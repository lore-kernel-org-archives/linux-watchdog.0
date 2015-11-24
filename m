Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:41240 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbbKXUWi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 15:22:38 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH] watchdog: core: factorize register error paths
Date: Tue, 24 Nov 2015 15:15:35 -0500
Message-Id: <1448396135-21649-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The commit adding the reboot notifier in the core introduced a new error
path in __watchdog_register_device, making error paths quite redondant.

This commit factorizes all error paths that do some cleanup.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 drivers/watchdog/watchdog_core.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 551af04..aff17b1 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -241,20 +241,16 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		wdd->id = id;
 
 		ret = watchdog_dev_register(wdd);
-		if (ret) {
-			ida_simple_remove(&watchdog_ida, id);
-			return ret;
-		}
+		if (ret)
+			goto remove_ida;
 	}
 
 	devno = wdd->cdev.dev;
 	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
 					wdd, "watchdog%d", wdd->id);
 	if (IS_ERR(wdd->dev)) {
-		watchdog_dev_unregister(wdd);
-		ida_simple_remove(&watchdog_ida, id);
 		ret = PTR_ERR(wdd->dev);
-		return ret;
+		goto unregister_device;
 	}
 
 	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
@@ -264,11 +260,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		if (ret) {
 			dev_err(wdd->dev, "Cannot register reboot notifier (%d)\n",
 				ret);
-			watchdog_dev_unregister(wdd);
-			device_destroy(watchdog_class, devno);
-			ida_simple_remove(&watchdog_ida, wdd->id);
-			wdd->dev = NULL;
-			return ret;
+			goto unregister_device;
 		}
 	}
 
@@ -282,6 +274,17 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 	}
 
 	return 0;
+
+unregister_device:
+	watchdog_dev_unregister(wdd);
+	if (!IS_ERR(wdd->dev)) {
+		device_destroy(watchdog_class, devno);
+		wdd->dev = NULL;
+	}
+remove_ida:
+	ida_simple_remove(&watchdog_ida, id);
+
+	return ret;
 }
 
 /**
-- 
2.5.0

