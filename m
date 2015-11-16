Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 07/13] watchdog: lpc18xx_wdt: use core restart handler
Date: Mon, 16 Nov 2015 12:28:05 -0500
Message-Id: <1447694891-24831-8-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/lpc18xx_wdt.c | 52 +++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

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
 
@@ -155,27 +153,9 @@ static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
-static struct watchdog_info lpc18xx_wdt_info = {
-	.identity	= "NXP LPC18xx Watchdog",
-	.options	= WDIOF_SETTIMEOUT |
-			  WDIOF_KEEPALIVEPING |
-			  WDIOF_MAGICCLOSE,
-};
-
-static const struct watchdog_ops lpc18xx_wdt_ops = {
-	.owner		= THIS_MODULE,
-	.start		= lpc18xx_wdt_start,
-	.stop		= lpc18xx_wdt_stop,
-	.ping		= lpc18xx_wdt_feed,
-	.set_timeout	= lpc18xx_wdt_set_timeout,
-	.get_timeleft	= lpc18xx_wdt_get_timeleft,
-};
-
-static int lpc18xx_wdt_restart(struct notifier_block *this, unsigned long mode,
-			       void *cmd)
+static int lpc18xx_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	struct lpc18xx_wdt_dev *lpc18xx_wdt = container_of(this,
-				struct lpc18xx_wdt_dev, restart_handler);
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
 	unsigned long flags;
 	int val;
 
@@ -197,9 +177,26 @@ static int lpc18xx_wdt_restart(struct notifier_block *this, unsigned long mode,
 
 	spin_unlock_irqrestore(&lpc18xx_wdt->lock, flags);
 
-	return NOTIFY_OK;
+	return 0;
 }
 
+static struct watchdog_info lpc18xx_wdt_info = {
+	.identity	= "NXP LPC18xx Watchdog",
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops lpc18xx_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= lpc18xx_wdt_start,
+	.stop		= lpc18xx_wdt_stop,
+	.ping		= lpc18xx_wdt_feed,
+	.set_timeout	= lpc18xx_wdt_set_timeout,
+	.get_timeleft	= lpc18xx_wdt_get_timeleft,
+	.restart        = lpc18xx_wdt_restart,
+};
+
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
