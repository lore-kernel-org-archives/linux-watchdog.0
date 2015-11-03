Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:58904 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291AbbKCQND (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 11:13:03 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 02/13] watchdog: bcm47xx_wdt: use core restart handler
Date: Tue,  3 Nov 2015 11:12:35 -0500
Message-Id: <1446567166-10156-3-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1446567166-10156-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446567166-10156-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/bcm47xx_wdt.c | 21 +++++++--------------
 include/linux/bcm47xx_wdt.h    |  1 -
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 4064a43..534ffb4 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -94,6 +94,7 @@ static struct watchdog_ops bcm47xx_wdt_hard_ops = {
 	.stop		= bcm47xx_wdt_hard_stop,
 	.ping		= bcm47xx_wdt_hard_keepalive,
 	.set_timeout	= bcm47xx_wdt_hard_set_timeout,
+	.restart        = bcm47xx_wdt_restart,
 };
 
 static void bcm47xx_wdt_soft_timer_tick(unsigned long data)
@@ -169,15 +170,13 @@ static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned long mode,
-			       void *cmd)
+static int bcm47xx_wdt_restart(struct watchdog_device *wdd)
 {
-	struct bcm47xx_wdt *wdt;
+	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
 
-	wdt = container_of(this, struct bcm47xx_wdt, restart_handler);
 	wdt->timer_set(wdt, 1);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static struct watchdog_ops bcm47xx_wdt_soft_ops = {
@@ -186,6 +185,7 @@ static struct watchdog_ops bcm47xx_wdt_soft_ops = {
 	.stop		= bcm47xx_wdt_soft_stop,
 	.ping		= bcm47xx_wdt_soft_keepalive,
 	.set_timeout	= bcm47xx_wdt_soft_set_timeout,
+	.restart        = bcm47xx_wdt_restart,
 };
 
 static int bcm47xx_wdt_probe(struct platform_device *pdev)
@@ -214,6 +214,7 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_timer;
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
+	watchdog_set_restart_priority(&wdt->wdd, 64);
 
 	wdt->notifier.notifier_call = &bcm47xx_wdt_notify_sys;
 
@@ -221,23 +222,15 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_timer;
 
-	wdt->restart_handler.notifier_call = &bcm47xx_wdt_restart;
-	wdt->restart_handler.priority = 64;
-	ret = register_restart_handler(&wdt->restart_handler);
-	if (ret)
-		goto err_notifier;
-
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret)
-		goto err_handler;
+		goto err_notifier;
 
 	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
 		timeout, nowayout ? ", nowayout" : "",
 		soft ? ", Software Timer" : "");
 	return 0;
 
-err_handler:
-	unregister_restart_handler(&wdt->restart_handler);
 err_notifier:
 	unregister_reboot_notifier(&wdt->notifier);
 err_timer:
diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
index 5582c21..b708786 100644
--- a/include/linux/bcm47xx_wdt.h
+++ b/include/linux/bcm47xx_wdt.h
@@ -16,7 +16,6 @@ struct bcm47xx_wdt {
 
 	struct watchdog_device wdd;
 	struct notifier_block notifier;
-	struct notifier_block restart_handler;
 
 	struct timer_list soft_timer;
 	atomic_t soft_ticks;
-- 
2.5.0

