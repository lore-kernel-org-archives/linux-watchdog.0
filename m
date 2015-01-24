Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:61013 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbbAXN6t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Jan 2015 08:58:49 -0500
Received: by mail-la0-f54.google.com with SMTP id hv19so1787013lab.13
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Jan 2015 05:58:48 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] watchdog: bcm47xx_wdt.c: add restart handler support
Date: Sat, 24 Jan 2015 14:58:38 +0100
Message-Id: <1422107918-8043-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1422107244-32097-1-git-send-email-zajec5@gmail.com>
References: <1422107244-32097-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Just like in case of other watchdog drivers, use the new kernel core
API to provide restart support.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
V2: Include changes to include/linux/bcm47xx_wdt.h
---
 drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
 include/linux/bcm47xx_wdt.h    |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 9816485..dac3c5d 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -169,6 +169,17 @@ static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned long mode,
+			       void *cmd)
+{
+	struct bcm47xx_wdt *wdt;
+
+	wdt = container_of(this, struct bcm47xx_wdt, restart_handler);
+	wdt->timer_set(wdt, 1);
+
+	return NOTIFY_DONE;
+}
+
 static struct watchdog_ops bcm47xx_wdt_soft_ops = {
 	.owner		= THIS_MODULE,
 	.start		= bcm47xx_wdt_soft_start,
@@ -204,20 +215,27 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 
 	wdt->notifier.notifier_call = &bcm47xx_wdt_notify_sys;
-
 	ret = register_reboot_notifier(&wdt->notifier);
 	if (ret)
 		goto err_timer;
 
-	ret = watchdog_register_device(&wdt->wdd);
+	wdt->restart_handler.notifier_call = &bcm47xx_wdt_restart;
+	wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&wdt->restart_handler);
 	if (ret)
 		goto err_notifier;
 
+	ret = watchdog_register_device(&wdt->wdd);
+	if (ret)
+		goto err_handler;
+
 	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
 		timeout, nowayout ? ", nowayout" : "",
 		soft ? ", Software Timer" : "");
 	return 0;
 
+err_handler:
+	unregister_restart_handler(&wdt->restart_handler);
 err_notifier:
 	unregister_reboot_notifier(&wdt->notifier);
 err_timer:
diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
index b708786..5582c21 100644
--- a/include/linux/bcm47xx_wdt.h
+++ b/include/linux/bcm47xx_wdt.h
@@ -16,6 +16,7 @@ struct bcm47xx_wdt {
 
 	struct watchdog_device wdd;
 	struct notifier_block notifier;
+	struct notifier_block restart_handler;
 
 	struct timer_list soft_timer;
 	atomic_t soft_ticks;
-- 
1.8.4.5

