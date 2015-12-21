Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43043 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbbLUXTR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 18:19:17 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v3 8/8] watchdog: mei_wdt: re-register device on event
Date: Tue, 22 Dec 2015 01:18:01 +0200
Message-Id: <1450739881-3923-9-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
References: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

For Intel SKL platform the ME device can inform the host via
asynchronous notification that the watchdog feature was activated
on the device. The activation doesn't require reboot.
In that case the driver registers the watchdog device with the kernel.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: rework un/registration in runtime
V2: rebase, runtime unregistration was moved to BDW patch.
 drivers/watchdog/mei_wdt.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 88511ef68b67..93fb8ce80456 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -532,6 +532,21 @@ out:
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
+	wdt->state = MEI_WDT_IDLE;
+	mei_wdt_register(wdt);
+}
+
 /**
  * mei_wdt_event - callback for event receive
  *
@@ -544,6 +559,9 @@ static void mei_wdt_event(struct mei_cl_device *cldev,
 {
 	if (events & BIT(MEI_CL_EVENT_RX))
 		mei_wdt_event_rx(cldev);
+
+	if (events & BIT(MEI_CL_EVENT_NOTIF))
+		mei_wdt_notify_event(cldev);
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -658,9 +676,13 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 		goto err_out;
 	}
 
-	ret = mei_cldev_register_event_cb(wdt->cldev, BIT(MEI_CL_EVENT_RX),
+	ret = mei_cldev_register_event_cb(wdt->cldev,
+					  BIT(MEI_CL_EVENT_RX) |
+					  BIT(MEI_CL_EVENT_NOTIF),
 					  mei_wdt_event, NULL);
-	if (ret) {
+
+	/* on legacy devices notification is not supported */
+	if (ret && ret != -EOPNOTSUPP) {
 		dev_err(&cldev->dev, "Could not register event ret=%d\n", ret);
 		goto err_disable;
 	}
-- 
2.4.3

