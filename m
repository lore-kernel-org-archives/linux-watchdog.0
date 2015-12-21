Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43043 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbbLUXTM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 18:19:12 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v3 6/8] watchdog: mei_wdt: register wd device only if required
Date: Tue, 22 Dec 2015 01:17:59 +0200
Message-Id: <1450739881-3923-7-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
References: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

For Intel Broadwell and newer platforms, the ME device can inform
the host whether the watchdog functionality is activated or not.
If the watchdog functionality is not activated then the watchdog interface
can be not registered and eliminate unnecessary pings and hence lower the
power consumption by avoiding waking up the device.
The feature can be deactivated also without reboot
in that case the watchdog device should be unregistered at runtime.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: rework unregistration
V3: rebase; implement unregistraion also at runtime

 drivers/watchdog/mei_wdt.c | 183 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 169 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index ab9aec218d69..3cd80aa75db1 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
+#include <linux/completion.h>
 #include <linux/watchdog.h>
 
 #include <linux/uuid.h>
@@ -38,24 +39,30 @@
 
 /* Sub Commands */
 #define MEI_MC_START_WD_TIMER_REQ  0x13
+#define MEI_MC_START_WD_TIMER_RES  0x83
+#define   MEI_WDT_STATUS_SUCCESS 0
+#define   MEI_WDT_WDSTATE_NOT_REQUIRED 0x1
 #define MEI_MC_STOP_WD_TIMER_REQ   0x14
 
 /**
  * enum mei_wdt_state - internal watchdog state
  *
+ * @MEI_WDT_PROBE: wd in probing stage
  * @MEI_WDT_IDLE: wd is idle and not opened
  * @MEI_WDT_START: wd was opened, start was called
  * @MEI_WDT_RUNNING: wd is expecting keep alive pings
  * @MEI_WDT_STOPPING: wd is stopping and will move to IDLE
+ * @MEI_WDT_NOT_REQUIRED: wd device is not required
  */
 enum mei_wdt_state {
+	MEI_WDT_PROBE,
 	MEI_WDT_IDLE,
 	MEI_WDT_START,
 	MEI_WDT_RUNNING,
 	MEI_WDT_STOPPING,
+	MEI_WDT_NOT_REQUIRED,
 };
 
-#if IS_ENABLED(CONFIG_DEBUG_FS)
 static const char *mei_wdt_state_str(enum mei_wdt_state state)
 {
 	switch (state) {
@@ -71,7 +78,6 @@ static const char *mei_wdt_state_str(enum mei_wdt_state state)
 		return "unknown";
 	}
 }
-#endif /* CONFIG_DEBUG_FS */
 
 struct mei_wdt;
 
@@ -94,6 +100,10 @@ struct mei_wdt_dev {
  *
  * @cldev: mei watchdog client device
  * @state: watchdog internal state
+ * @resp_required: ping required response
+ * @response: ping response completion
+ * @unregister: unregister worker
+ * @reg_lock: watchdog device registration lock
  * @timeout: watchdog current timeout
  *
  * @dbgfs_dir: debugfs dir entry
@@ -103,6 +113,10 @@ struct mei_wdt {
 
 	struct mei_cl_device *cldev;
 	enum mei_wdt_state state;
+	bool resp_required;
+	struct completion response;
+	struct work_struct unregister;
+	struct mutex reg_lock;
 	u16 timeout;
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -139,6 +153,19 @@ struct mei_wdt_start_request {
 } __packed;
 
 /**
+ * struct mei_wdt_start_response watchdog start/ping response
+ *
+ * @hdr: Management Control Command Header
+ * @status: operation status
+ * @wdstate: watchdog status bit mask
+ */
+struct mei_wdt_start_response {
+	struct mei_mc_hdr hdr;
+	u8 status;
+	u8 wdstate;
+} __packed;
+
+/**
  * struct mei_wdt_stop_request - watchdog stop
  *
  * @hdr: Management Control Command Header
@@ -277,13 +304,18 @@ static int mei_wdt_ops_ping(struct watchdog_device *wdd)
 	if (wdt->state != MEI_WDT_START && wdt->state != MEI_WDT_RUNNING)
 		return 0;
 
+	if (wdt->resp_required)
+		init_completion(&wdt->response);
+
+	wdt->state = MEI_WDT_RUNNING;
 	ret = mei_wdt_ping(wdt);
 	if (ret)
 		return ret;
 
-	wdt->state = MEI_WDT_RUNNING;
+	if (wdt->resp_required)
+		ret = wait_for_completion_killable(&wdt->response);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -358,15 +390,22 @@ static struct watchdog_info wd_info = {
  */
 static void mei_wdt_unregister(struct mei_wdt *wdt)
 {
-	struct mei_wdt_dev *mwd = wdt->mwd;
+	struct mei_wdt_dev *mwd;
 
-	if (!mwd)
-		return;
+	mutex_lock(&wdt->reg_lock);
+
+	if (!wdt->mwd)
+		goto out;
+
+	mwd = wdt->mwd;
 
 	watchdog_unregister_device(&mwd->wdd);
+
 	wdt->mwd = NULL;
-	wdt->state = MEI_WDT_IDLE;
 	kref_put(&mwd->refcnt, mei_wdt_release);
+
+out:
+	mutex_unlock(&wdt->reg_lock);
 }
 
 /**
@@ -387,9 +426,13 @@ static int mei_wdt_register(struct mei_wdt *wdt)
 
 	dev = &wdt->cldev->dev;
 
+	mutex_lock(&wdt->reg_lock);
+
 	mwd = kzalloc(sizeof(struct mei_wdt_dev), GFP_KERNEL);
-	if (!mwd)
-		return -ENOMEM;
+	if (!mwd) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	mwd->wdt = wdt;
 	mwd->wdd.info = &wd_info;
@@ -405,13 +448,104 @@ static int mei_wdt_register(struct mei_wdt *wdt)
 	if (ret) {
 		dev_err(dev, "unable to register watchdog device = %d.\n", ret);
 		kref_put(&mwd->refcnt, mei_wdt_release);
-		return ret;
+		goto out;
 	}
 
 	wdt->mwd = mwd;
+out:
+	mutex_unlock(&wdt->reg_lock);
 	return 0;
 }
 
+static void mei_wdt_unregister_work(struct work_struct *work)
+{
+	struct mei_wdt *wdt = container_of(work, struct mei_wdt, unregister);
+
+	mei_wdt_unregister(wdt);
+}
+
+/**
+ * mei_wdt_event_rx - callback for data receive
+ *
+ * @cldev: bus device
+ */
+static void mei_wdt_event_rx(struct mei_cl_device *cldev)
+{
+	struct mei_wdt *wdt = mei_cldev_get_drvdata(cldev);
+	struct mei_wdt_start_response res;
+	const size_t res_len = sizeof(res);
+	int ret;
+
+	ret = mei_cldev_recv(wdt->cldev, (u8 *)&res, res_len);
+	if (ret < 0) {
+		dev_err(&cldev->dev, "failure in recv %d\n", ret);
+		return;
+	}
+
+	/* Empty response can be sent on stop */
+	if (ret == 0)
+		return;
+
+	if (ret < sizeof(struct mei_mc_hdr)) {
+		dev_err(&cldev->dev, "recv small data %d\n", ret);
+		return;
+	}
+
+	if (res.hdr.command != MEI_MANAGEMENT_CONTROL ||
+	    res.hdr.versionnumber != MEI_MC_VERSION_NUMBER) {
+		dev_err(&cldev->dev, "wrong command received\n");
+		return;
+	}
+
+	if (res.hdr.subcommand != MEI_MC_START_WD_TIMER_RES) {
+		dev_warn(&cldev->dev, "unsupported command %d :%s[%d]\n",
+			 res.hdr.subcommand,
+			 mei_wdt_state_str(wdt->state),
+			 wdt->state);
+		return;
+	}
+
+	if (wdt->state == MEI_WDT_RUNNING) {
+		if (res.wdstate & MEI_WDT_WDSTATE_NOT_REQUIRED) {
+			wdt->state = MEI_WDT_NOT_REQUIRED;
+			schedule_work(&wdt->unregister);
+		}
+		goto out;
+	}
+
+	if (wdt->state == MEI_WDT_PROBE) {
+		if (res.wdstate & MEI_WDT_WDSTATE_NOT_REQUIRED) {
+			wdt->state = MEI_WDT_NOT_REQUIRED;
+		} else {
+			/* stop the ping register watchdog device */
+			mei_wdt_stop(wdt);
+			mei_wdt_register(wdt);
+		}
+		return;
+	}
+
+	dev_warn(&cldev->dev, "not in correct state %s[%d]\n",
+			 mei_wdt_state_str(wdt->state), wdt->state);
+
+out:
+	if (!completion_done(&wdt->response))
+		complete(&wdt->response);
+}
+
+/**
+ * mei_wdt_event - callback for event receive
+ *
+ * @cldev: bus device
+ * @events: event mask
+ * @context: callback context
+ */
+static void mei_wdt_event(struct mei_cl_device *cldev,
+			  u32 events, void *context)
+{
+	if (events & BIT(MEI_CL_EVENT_RX))
+		mei_wdt_event_rx(cldev);
+}
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 static ssize_t mei_dbgfs_read_state(struct file *file, char __user *ubuf,
@@ -482,8 +616,13 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 		return -ENOMEM;
 
 	wdt->timeout = MEI_WDT_DEFAULT_TIMEOUT;
-	wdt->state = MEI_WDT_IDLE;
+	wdt->state = MEI_WDT_PROBE;
 	wdt->cldev = cldev;
+	wdt->resp_required = mei_cldev_ver(cldev) > 0x1;
+	mutex_init(&wdt->reg_lock);
+	init_completion(&wdt->response);
+	INIT_WORK(&wdt->unregister, mei_wdt_unregister_work);
+
 	mei_cldev_set_drvdata(cldev, wdt);
 
 	ret = mei_cldev_enable(cldev);
@@ -492,9 +631,19 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 		goto err_out;
 	}
 
+	ret = mei_cldev_register_event_cb(wdt->cldev, BIT(MEI_CL_EVENT_RX),
+					  mei_wdt_event, NULL);
+	if (ret) {
+		dev_err(&cldev->dev, "Could not register event ret=%d\n", ret);
+		goto err_disable;
+	}
+
 	wd_info.firmware_version = mei_cldev_ver(cldev);
 
-	ret = mei_wdt_register(wdt);
+	if (wdt->resp_required)
+		ret = mei_wdt_ping(wdt);
+	else
+		ret = mei_wdt_register(wdt);
 	if (ret)
 		goto err_disable;
 
@@ -515,6 +664,12 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
 {
 	struct mei_wdt *wdt = mei_cldev_get_drvdata(cldev);
 
+	/* Free the caller in case of fw initiated or unexpected reset */
+	if (!completion_done(&wdt->response))
+		complete(&wdt->response);
+
+	cancel_work_sync(&wdt->unregister);
+
 	mei_wdt_unregister(wdt);
 
 	mei_cldev_disable(cldev);
@@ -530,7 +685,7 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
 			    0x89, 0x9D, 0xA9, 0x15, 0x14, 0xCB, 0x32, 0xAB)
 
 static struct mei_cl_device_id mei_wdt_tbl[] = {
-	{ .uuid = MEI_UUID_WD, .version = 0x1},
+	{ .uuid = MEI_UUID_WD, .version = MEI_CL_VERSION_ANY },
 	/* required last entry */
 	{ }
 };
-- 
2.4.3

