Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34156 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbcAGWuz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Jan 2016 17:50:55 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v4 7/7] watchdog: mei_wdt: re-register device on event
Date: Fri,  8 Jan 2016 00:49:27 +0200
Message-Id: <1452206967-1144-8-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
References: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

For Intel SKL platform the ME device can inform the host via
asynchronous notification that the watchdog feature was activated
on the device. The activation doesn't require reboot.
In that case the driver registers the watchdog device with the kernel.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
V2: rework un/registration in runtime
V3: rebase, runtime unregistration was moved to BDW patch.
V4: Rebase the code over patchset : "watchdog: Replace driver based refcounting"

 drivers/watchdog/mei_wdt.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index fe683e582566..a49be916ac7f 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -477,6 +477,21 @@ out:
 		complete(&wdt->response);
 }
 
+/*
+ * mei_wdt_notify_event - callback for event notification
+ *
+ * @cldev: bus device
+ */
+static void mei_wdt_notify_event(struct mei_cl_device *cldev)
+{
+	struct mei_wdt *wdt = mei_cldev_get_drvdata(cldev);
+
+	if (wdt->state != MEI_WDT_NOT_REQUIRED)
+		return;
+
+	mei_wdt_register(wdt);
+}
+
 /**
  * mei_wdt_event - callback for event receive
  *
@@ -489,6 +504,9 @@ static void mei_wdt_event(struct mei_cl_device *cldev,
 {
 	if (events & BIT(MEI_CL_EVENT_RX))
 		mei_wdt_event_rx(cldev);
+
+	if (events & BIT(MEI_CL_EVENT_NOTIF))
+		mei_wdt_notify_event(cldev);
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -601,9 +619,15 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 		goto err_out;
 	}
 
-	ret = mei_cldev_register_event_cb(wdt->cldev, BIT(MEI_CL_EVENT_RX),
+	ret = mei_cldev_register_event_cb(wdt->cldev,
+					  BIT(MEI_CL_EVENT_RX) |
+					  BIT(MEI_CL_EVENT_NOTIF),
 					  mei_wdt_event, NULL);
-	if (ret) {
+
+	/* on legacy devices notification is not supported
+	 * this doesn't fail the registration for RX event
+	 */
+	if (ret && ret != -EOPNOTSUPP) {
 		dev_err(&cldev->dev, "Could not register event ret=%d\n", ret);
 		goto err_disable;
 	}
-- 
2.4.3

