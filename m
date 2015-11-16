Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 06/13] watchdog: imx2_wdt: use core restart handler
Date: Mon, 16 Nov 2015 12:28:04 -0500
Message-Id: <1447694891-24831-7-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/imx2_wdt.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 29ef719..e47966a 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -29,10 +29,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/timer.h>
 #include <linux/watchdog.h>
@@ -64,7 +62,6 @@ struct imx2_wdt_device {
 	struct regmap *regmap;
 	struct timer_list timer;	/* Pings the watchdog when closed */
 	struct watchdog_device wdog;
-	struct notifier_block restart_handler;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -83,13 +80,11 @@ static const struct watchdog_info imx2_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
-static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
-				void *cmd)
+static int imx2_wdt_restart(struct watchdog_device *wdog)
 {
+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
-	struct imx2_wdt_device *wdev = container_of(this,
-						    struct imx2_wdt_device,
-						    restart_handler);
+
 	/* Assert SRS signal */
 	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
 	/*
@@ -105,7 +100,7 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
 	/* wait for reset to assert... */
 	mdelay(500);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static inline void imx2_wdt_setup(struct watchdog_device *wdog)
@@ -213,6 +208,7 @@ static const struct watchdog_ops imx2_wdt_ops = {
 	.stop = imx2_wdt_stop,
 	.ping = imx2_wdt_ping,
 	.set_timeout = imx2_wdt_set_timeout,
+	.restart = imx2_wdt_restart,
 };
 
 static const struct regmap_config imx2_wdt_regmap_config = {
@@ -275,6 +271,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdog);
 	watchdog_set_drvdata(wdog, wdev);
 	watchdog_set_nowayout(wdog, nowayout);
+	watchdog_set_restart_priority(wdog, 128);
 	watchdog_init_timeout(wdog, timeout, &pdev->dev);
 
 	setup_timer(&wdev->timer, imx2_wdt_timer_ping, (unsigned long)wdog);
@@ -294,12 +291,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	wdev->restart_handler.notifier_call = imx2_restart_handler;
-	wdev->restart_handler.priority = 128;
-	ret = register_restart_handler(&wdev->restart_handler);
-	if (ret)
-		dev_err(&pdev->dev, "cannot register restart handler\n");
-
 	dev_info(&pdev->dev, "timeout %d sec (nowayout=%d)\n",
 		 wdog->timeout, nowayout);
 
@@ -315,8 +306,6 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
 	struct watchdog_device *wdog = platform_get_drvdata(pdev);
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
-	unregister_restart_handler(&wdev->restart_handler);
-
 	watchdog_unregister_device(wdog);
 
 	if (imx2_wdt_is_running(wdev)) {
-- 
2.5.0
