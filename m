Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbbKZMcj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 07:32:39 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 6/6] mei: wd: re-register device on event
Date: Thu, 26 Nov 2015 14:31:21 +0200
Message-Id: <1448541081-11299-7-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
References: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

For Intel SKL platform the ME device can inform the host via
asynchronous notification that the watchdog feature was activated on the
device. The activation doesn't require reboot.
In that case the driver register the watchdog device with the kernel.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/watchdog/mei_wdt.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 47f0dc2e822a..ee3b5d12b1b2 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -279,6 +279,21 @@ out:
 		complete(&wdt->response);
 }
 
+/*
+ * mei_wdt_event_notif - callback for notification
+ *
+ * @cldev: bus device
+ */
+static void mei_wdt_event_notif(struct mei_cl_device *cldev)
+{
+	struct mei_wdt *wdt = mei_cldev_get_drvdata(cldev);
+
+	if (wdt->state == MEI_WDT_NOT_REQUIRED) {
+		mei_wdt_register(wdt);
+		wdt->state = MEI_WDT_IDLE;
+	}
+}
+
 /**
  * mei_wdt_event - callback for event receive
  *
@@ -291,6 +306,9 @@ static void mei_wdt_event(struct mei_cl_device *cldev,
 {
 	if (events & BIT(MEI_CL_EVENT_RX))
 		mei_wdt_event_rx(cldev);
+
+	if (events & BIT(MEI_CL_EVENT_NOTIF))
+		mei_wdt_event_notif(cldev);
 }
 
 /**
@@ -466,9 +484,13 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
 
 	wd_info.firmware_version = mei_cldev_ver(cldev);
 
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

