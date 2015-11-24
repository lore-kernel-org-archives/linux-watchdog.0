Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 1/2] watchdog: core: call device_destroy before watchdog_dev_unregister
Date: Tue, 24 Nov 2015 18:45:44 -0500
Message-Id: <1448408745-26719-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

device_create is called after watchdog_dev_register, so it makes more
sense to call the cleanup functions in reverse order, ie. device_destroy
before watchdog_dev_unregister.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 drivers/watchdog/watchdog_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 551af04..e70b6e8 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -264,8 +264,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		if (ret) {
 			dev_err(wdd->dev, "Cannot register reboot notifier (%d)\n",
 				ret);
-			watchdog_dev_unregister(wdd);
 			device_destroy(watchdog_class, devno);
+			watchdog_dev_unregister(wdd);
 			ida_simple_remove(&watchdog_ida, wdd->id);
 			wdd->dev = NULL;
 			return ret;
@@ -324,10 +324,10 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
 		unregister_reboot_notifier(&wdd->reboot_nb);
 
 	devno = wdd->cdev.dev;
+	device_destroy(watchdog_class, devno);
 	ret = watchdog_dev_unregister(wdd);
 	if (ret)
 		pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);
-	device_destroy(watchdog_class, devno);
 	ida_simple_remove(&watchdog_ida, wdd->id);
 	wdd->dev = NULL;
 }
-- 
2.5.0
