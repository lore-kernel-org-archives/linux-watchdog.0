Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:46906 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0HUJeN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Aug 2010 05:34:13 -0400
Received: by pxi10 with SMTP id 10so1562881pxi.19
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Aug 2010 02:34:12 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Andrew Sharp <andy.sharp@lsi.com>
Subject: [PATCH] sb_wdog: release irq and reboot notifier in error path and module_exit()
Date: Sat, 21 Aug 2010 18:27:50 +0900
Message-Id: <1282382870-5820-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

irq and reboot notifier are acquired in module_init() but never released.
They should be released correctly, otherwise reloading the module or error
during module_init() will cause a problem.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Cc: Andrew Sharp <andy.sharp@lsi.com>
---
 drivers/watchdog/sb_wdog.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 88c83aa..f31493e 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -305,7 +305,7 @@ static int __init sbwdog_init(void)
 	if (ret) {
 		printk(KERN_ERR "%s: failed to request irq 1 - %d\n",
 						ident.identity, ret);
-		return ret;
+		goto out;
 	}
 
 	ret = misc_register(&sbwdog_miscdev);
@@ -313,14 +313,20 @@ static int __init sbwdog_init(void)
 		printk(KERN_INFO "%s: timeout is %ld.%ld secs\n",
 				ident.identity,
 				timeout / 1000000, (timeout / 100000) % 10);
-	} else
-		free_irq(1, (void *)user_dog);
+		return 0;
+	}
+	free_irq(1, (void *)user_dog);
+out:
+	unregister_reboot_notifier(&sbwdog_notifier);
+
 	return ret;
 }
 
 static void __exit sbwdog_exit(void)
 {
 	misc_deregister(&sbwdog_miscdev);
+	free_irq(1, (void *)user_dog);
+	unregister_reboot_notifier(&sbwdog_notifier);
 }
 
 module_init(sbwdog_init);
-- 
1.6.0.6

