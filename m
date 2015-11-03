Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:58963 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbbKCQNL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 11:13:11 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 07/13] watchdog: lpc18xx_wdt: use core restart handler
Date: Tue,  3 Nov 2015 11:12:40 -0500
Message-Id: <1446567166-10156-8-git-send-email-damien.riegel@savoirfairelinux.com>
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
 drivers/watchdog/lpc18xx_wdt.c | 68 ++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index ab7b8b1..6914c83 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 /* Registers */
@@ -59,7 +58,6 @@ struct lpc18xx_wdt_dev {
 	unsigned long		clk_rate;
 	void __iomem		*base;
 	struct timer_list	timer;
-	struct notifier_block	restart_handler;
 	spinlock_t		lock;
 };
 
@@ -155,6 +153,33 @@ static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int lpc18xx_wdt_restart(struct watchdog_device *wdt_dev)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned long flags;
+	int val;
+
+	/*
+	 * Incorrect feed sequence causes immediate watchdog reset if enabled.
+	 */
+	spin_lock_irqsave(&lpc18xx_wdt->lock, flags);
+
+	val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
+	val |= LPC18XX_WDT_MOD_WDEN;
+	val |= LPC18XX_WDT_MOD_WDRESET;
+	writel(val, lpc18xx_wdt->base + LPC18XX_WDT_MOD);
+
+	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+	writel(LPC18XX_WDT_FEED_MAGIC2, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+
+	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+
+	spin_unlock_irqrestore(&lpc18xx_wdt->lock, flags);
+
+	return 0;
+}
+
 static struct watchdog_info lpc18xx_wdt_info = {
 	.identity	= "NXP LPC18xx Watchdog",
 	.options	= WDIOF_SETTIMEOUT |
@@ -169,37 +194,9 @@ static const struct watchdog_ops lpc18xx_wdt_ops = {
 	.ping		= lpc18xx_wdt_feed,
 	.set_timeout	= lpc18xx_wdt_set_timeout,
 	.get_timeleft	= lpc18xx_wdt_get_timeleft,
+	.restart        = lpc18xx_wdt_restart,
 };
 
-static int lpc18xx_wdt_restart(struct notifier_block *this, unsigned long mode,
-			       void *cmd)
-{
-	struct lpc18xx_wdt_dev *lpc18xx_wdt = container_of(this,
-				struct lpc18xx_wdt_dev, restart_handler);
-	unsigned long flags;
-	int val;
-
-	/*
-	 * Incorrect feed sequence causes immediate watchdog reset if enabled.
-	 */
-	spin_lock_irqsave(&lpc18xx_wdt->lock, flags);
-
-	val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
-	val |= LPC18XX_WDT_MOD_WDEN;
-	val |= LPC18XX_WDT_MOD_WDRESET;
-	writel(val, lpc18xx_wdt->base + LPC18XX_WDT_MOD);
-
-	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
-	writel(LPC18XX_WDT_FEED_MAGIC2, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
-
-	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
-	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
-
-	spin_unlock_irqrestore(&lpc18xx_wdt->lock, flags);
-
-	return NOTIFY_OK;
-}
-
 static int lpc18xx_wdt_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt;
@@ -273,6 +270,7 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 		    (unsigned long)&lpc18xx_wdt->wdt_dev);
 
 	watchdog_set_nowayout(&lpc18xx_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&lpc18xx_wdt->wdt_dev, 128);
 
 	platform_set_drvdata(pdev, lpc18xx_wdt);
 
@@ -280,12 +278,6 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_wdt_clk;
 
-	lpc18xx_wdt->restart_handler.notifier_call = lpc18xx_wdt_restart;
-	lpc18xx_wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&lpc18xx_wdt->restart_handler);
-	if (ret)
-		dev_warn(dev, "failed to register restart handler: %d\n", ret);
-
 	return 0;
 
 disable_wdt_clk:
@@ -306,8 +298,6 @@ static int lpc18xx_wdt_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&lpc18xx_wdt->restart_handler);
-
 	dev_warn(&pdev->dev, "I quit now, hardware will probably reboot!\n");
 	del_timer(&lpc18xx_wdt->timer);
 
-- 
2.5.0

