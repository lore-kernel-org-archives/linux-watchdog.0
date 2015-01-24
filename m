Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:41560 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbbAXNre (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Jan 2015 08:47:34 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so2048465wgh.10
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Jan 2015 05:47:33 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] watchdog: bcm47xx_wdt.c: add restart handler support
Date: Sat, 24 Jan 2015 14:47:24 +0100
Message-Id: <1422107244-32097-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Just like in case of other watchdog drivers, use the new kernel core
API to provide restart support.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

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
-- 
1.8.4.5

