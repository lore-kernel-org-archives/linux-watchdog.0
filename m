Return-path: <tomas.winkler@intel.com>
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 6/7] watchdog: mei_wdt: register wd device only if required
Date: Thu, 17 Dec 2015 16:49:39 +0200
Message-Id: <1450363780-30008-7-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Alexander Usyskin <alexander.usyskin@intel.com>

For Intel Broadwell and newer platforms, the ME device can inform
the host whether the watchdog functionality is activated or not.
If the watchdog functionality is not activated then the watchdog interface
can be not registered and eliminate unnecessary pings and hence lower the
power consumption by avoiding waking up the device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: rework unregistration

 drivers/watchdog/mei_wdt.c | 180 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 167 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index a3f1c1613c32..00d1b8e630b7 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/watchdog.h>
+#include <linux/completion.h>
 #include <linux/debugfs.h>
 
 #include <linux/uuid.h>
@@ -38,43 +39,54 @@
 
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
+	case MEI_WDT_PROBE: return "PROBE";
 	case MEI_WDT_IDLE: return "IDLE";
 	case MEI_WDT_START: return "START";
 	case MEI_WDT_RUNNING: return "RUNNING";
 	case MEI_WDT_STOPPING: return "STOPPING";
+	case MEI_WDT_NOT_REQUIRED: return "NOT_REQUIRED";
 	default: return "unknown";
 	}
 }
-#endif /* CONFIG_DEBUG_FS */
 
 /**
  * struct mei_wdt - mei watchdog driver
  * @wdd: watchdog device
  * @refcnt: watchdog device reference counter
+ * @reg_lock: watchdog device registration lock
+ * @is_registered: is watchdog device registered
  *
- * @state: watchdog internal state
  * @cldev: mei watchdog client device
+ * @state: watchdog internal state
+ * @resp_required: ping required response
+ * @response: ping response
  * @timeout: watchdog current timeout
  *
  * @dbgfs_dir: debugfs dir entry
@@ -82,9 +94,13 @@ static const char *mei_wdt_state_str(enum mei_wdt_state state)
 struct mei_wdt {
 	struct watchdog_device wdd;
 	struct kref refcnt;
+	struct mutex reg_lock;
+	bool   is_registered;
 
 	struct mei_cl_device *cldev;
 	enum mei_wdt_state state;
+	bool resp_required;
+	struct completion response;
 	u16 timeout;
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -121,6 +137,19 @@ struct mei_wdt_start_request {
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
@@ -192,6 +221,23 @@ static void mei_wdt_release(struct kref *ref)
 }
 
 /**
+ * mei_wdt_unregister - unregister from the watchdog subsystem
+ *
+ * @wdt: mei watchdog device
+ */
+static void mei_wdt_unregister(struct mei_wdt *wdt)
+{
+
+	mutex_lock(&wdt->reg_lock);
+	if (wdt->is_registered) {
+		clear_bit(WDOG_ACTIVE, &wdt->wdd.status);
+		watchdog_unregister_device(&wdt->wdd);
+		wdt->is_registered = false;
+	}
+	mutex_unlock(&wdt->reg_lock);
+}
+
+/**
  * mei_wdt_register - register with the watchdog subsystem
  *
  * @wdt: mei watchdog device
@@ -205,15 +251,20 @@ static int mei_wdt_register(struct mei_wdt *wdt)
 
 	dev = &wdt->cldev->dev;
 
-	watchdog_set_drvdata(&wdt->wdd, wdt);
+	wdt->state = MEI_WDT_IDLE;
 
+	mutex_lock(&wdt->reg_lock);
+	clear_bit(WDOG_UNREGISTERED, &wdt->wdd.status);
+	watchdog_set_drvdata(&wdt->wdd, wdt);
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret) {
 		dev_err(dev, "unable to register watchdog device = %d.\n", ret);
-		return ret;
+		watchdog_set_drvdata(&wdt->wdd, NULL);
 	}
+	wdt->is_registered = true;
+	mutex_unlock(&wdt->reg_lock);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -259,6 +310,83 @@ static int mei_wdt_ops_stop(struct watchdog_device *wdd)
 }
 
 /**
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
+	if (wdt->state == MEI_WDT_RUNNING)
+		goto out;
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
+/**
  * mei_wdt_ops_ping - wd ping command from the watchdog core.
  *
  * @wdd: watchdog device
@@ -273,13 +401,18 @@ static int mei_wdt_ops_ping(struct watchdog_device *wdd)
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
@@ -405,8 +538,13 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 
 	kref_init(&wdt->refcnt);
 	wdt->timeout = MEI_WDT_DEFAULT_TIMEOUT;
-	wdt->state = MEI_WDT_IDLE;
+	wdt->state = MEI_WDT_PROBE;
 	wdt->cldev = cldev;
+	wdt->resp_required = mei_cldev_ver(cldev) > 0x1;
+	mutex_init(&wdt->reg_lock);
+	wdt->is_registered = false;
+	init_completion(&wdt->response);
+
 	mei_cldev_set_drvdata(cldev, wdt);
 
 	ret = mei_cldev_enable(cldev);
@@ -415,6 +553,13 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
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
 
 	wdt->wdd.info = &wd_info;
@@ -424,8 +569,13 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 	wdt->wdd.min_timeout = MEI_WDT_MIN_TIMEOUT;
 	wdt->wdd.max_timeout = MEI_WDT_MAX_TIMEOUT;
 
-	ret = mei_wdt_register(wdt);
-	if (ret)
+	/* register after ping response */
+	if (wdt->resp_required)
+		ret = mei_wdt_ping(wdt);
+	else
+		ret = mei_wdt_register(wdt);
+
+	if (ret < 0)
 		goto err_disable;
 
 	dbgfs_register(wdt);
@@ -445,7 +595,11 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
 {
 	struct mei_wdt *wdt = mei_cldev_get_drvdata(cldev);
 
-	watchdog_unregister_device(&wdt->wdd);
+	/* Free the caller in case of fw initiated or unexpected reset */
+	if (!completion_done(&wdt->response))
+		complete(&wdt->response);
+
+	mei_wdt_unregister(wdt);
 
 	kref_put(&wdt->refcnt, mei_wdt_release);
 
@@ -460,7 +614,7 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
 			    0x89, 0x9D, 0xA9, 0x15, 0x14, 0xCB, 0x32, 0xAB)
 
 static struct mei_cl_device_id mei_wdt_tbl[] = {
-	{ .uuid = MEI_UUID_WD, .version = 0x1},
+	{ .uuid = MEI_UUID_WD, .version = MEI_CL_VERSION_ANY },
 	/* required last entry */
 	{ }
 };
-- 
2.4.3
