Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbbKZMch (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 07:32:37 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 5/6] mei: wd: register wd device only if required
Date: Thu, 26 Nov 2015 14:31:20 +0200
Message-Id: <1448541081-11299-6-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
References: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

For Intel Broadwell and newer platforms, the ME device can inform
the host whether the watchdog functionality is activated or not.
If the watchdog functionality is not activated then watchdog interface
can be not registered and eliminate unnecessary pings and hence lower the
power consumption by not waking up the device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/watchdog/mei_wdt.c | 127 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 149b29f341cf..47f0dc2e822a 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/watchdog.h>
+#include <linux/completion.h>
 
 #include <linux/uuid.h>
 #include <linux/mei_cl_bus.h>
@@ -37,21 +38,27 @@
 
 /* Sub Commands */
 #define MEI_MC_START_WD_TIMER_REQ  0x13
+#define MEI_MC_START_WD_TIMER_RES  0x83
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
 
 struct mei_wdt;
@@ -75,12 +82,16 @@ struct mei_wdt_dev {
  * @cldev: mei watchdog client device
  * @mwd: watchdog device wrapper
  * @state: watchdog internal state
+ * @resp_required: ping required response
+ * @response: ping response
  * @timeout: watchdog current timeout
  */
 struct mei_wdt {
 	struct mei_cl_device *cldev;
 	struct mei_wdt_dev *mwd;
 	enum mei_wdt_state state;
+	bool resp_required;
+	struct completion response;
 	u16 timeout;
 };
 
@@ -97,10 +108,19 @@ struct mei_wdt_start_request {
 	u8 reserved[17];
 } __packed;
 
+struct mei_wdt_start_response {
+	struct mei_wdt_hdr hdr;
+	u8 status;
+	u8 wdstate;
+} __packed;
+
 struct mei_wdt_stop_request {
 	struct mei_wdt_hdr hdr;
 } __packed;
 
+static void mei_wdt_unregister(struct mei_wdt *wdt);
+static int mei_wdt_register(struct mei_wdt *wdt);
+
 /**
  * mei_wdt_ping - send wd start command
  *
@@ -192,12 +212,88 @@ static int mei_wdt_ops_stop(struct watchdog_device *wdd)
 	if (ret < 0)
 		return ret;
 
-	wdt->state = MEI_WDT_IDLE;
+	if (!wdt->resp_required)
+		wdt->state = MEI_WDT_IDLE;
 
 	return 0;
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
+	if (ret == 0) {
+		if (wdt->state == MEI_WDT_STOPPING)
+			wdt->state = MEI_WDT_IDLE;
+		return;
+	}
+
+	if (ret < sizeof(struct mei_wdt_hdr)) {
+		dev_err(&cldev->dev, "recv small data %d\n", ret);
+		return;
+	}
+
+	if (res.hdr.command != MEI_MANAGEMENT_CONTROL ||
+	    res.hdr.subcommand != MEI_MC_START_WD_TIMER_RES ||
+	    res.hdr.versionnumber != MEI_MC_VERSION_NUMBER)
+		return;
+
+	if (wdt->state == MEI_WDT_RUNNING) {
+		if (res.wdstate & MEI_WDT_WDSTATE_NOT_REQUIRED) {
+			wdt->state = MEI_WDT_NOT_REQUIRED;
+			mei_wdt_unregister(wdt);
+		}
+
+		goto out;
+	}
+
+	if (wdt->state == MEI_WDT_PROBE) {
+		if (res.wdstate & MEI_WDT_WDSTATE_NOT_REQUIRED) {
+			wdt->state = MEI_WDT_NOT_REQUIRED;
+		} else {
+			/* stop the ping register watchdog device */
+			mei_wdt_stop(wdt);
+			wdt->state = MEI_WDT_IDLE;
+			mei_wdt_register(wdt);
+		}
+		return;
+	}
+
+	dev_err(&cldev->dev, "not in running state %d\n", wdt->state);
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
@@ -219,11 +315,17 @@ static int mei_wdt_ops_ping(struct watchdog_device *wdd)
 	    wdt->state != MEI_WDT_RUNNING)
 		return 0;
 
+
+	if (wdt->resp_required)
+		reinit_completion(&wdt->response);
+
+	wdt->state = MEI_WDT_RUNNING;
 	ret = mei_wdt_ping(wdt);
 	if (ret < 0)
 		return ret;
 
-	wdt->state = MEI_WDT_RUNNING;
+	if (wdt->resp_required)
+		wait_for_completion_interruptible(&wdt->response);
 
 	return 0;
 }
@@ -349,8 +451,11 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 		return -ENOMEM;
 
 	wdt->timeout = MEI_WDT_DEFAULT_TIMEOUT;
-	wdt->state = MEI_WDT_IDLE;
+	wdt->state = MEI_WDT_PROBE;
 	wdt->cldev = cldev;
+	wdt->resp_required = mei_cldev_ver(cldev) > 0x1;
+	init_completion(&wdt->response);
+
 	mei_cldev_set_drvdata(cldev, wdt);
 
 	ret = mei_cldev_enable(cldev);
@@ -361,8 +466,20 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 
 	wd_info.firmware_version = mei_cldev_ver(cldev);
 
-	ret = mei_wdt_register(wdt);
-	if (ret)
+	ret = mei_cldev_register_event_cb(wdt->cldev, BIT(MEI_CL_EVENT_RX),
+					  mei_wdt_event, NULL);
+	if (ret) {
+		dev_err(&cldev->dev, "Could not register event ret=%d\n", ret);
+		goto err_disable;
+	}
+
+	/* register after ping response */
+	if (wdt->resp_required)
+		ret = mei_wdt_ping(wdt);
+	else
+		ret = mei_wdt_register(wdt);
+
+	if (ret < 0)
 		goto err_disable;
 
 	return 0;
-- 
2.4.3

