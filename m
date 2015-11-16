Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 13/13] watchdog: sunxi_wdt: use core restart handler
Date: Mon, 16 Nov 2015 12:28:11 -0500
Message-Id: <1447694891-24831-14-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/sunxi_wdt.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 47bd8a1..e027deb 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -21,11 +21,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -60,7 +58,6 @@ struct sunxi_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
 	const struct sunxi_wdt_reg *wdt_regs;
-	struct notifier_block restart_handler;
 };
 
 /*
@@ -86,12 +83,9 @@ static const int wdt_timeout_map[] = {
 };
 
 
-static int sunxi_restart_handle(struct notifier_block *this, unsigned long mode,
-				void *cmd)
+static int sunxi_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	struct sunxi_wdt_dev *sunxi_wdt = container_of(this,
-						       struct sunxi_wdt_dev,
-						       restart_handler);
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base = sunxi_wdt->wdt_base;
 	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
 	u32 val;
@@ -120,7 +114,7 @@ static int sunxi_restart_handle(struct notifier_block *this, unsigned long mode,
 		val |= WDT_MODE_EN;
 		writel(val, wdt_base + regs->wdt_mode);
 	}
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
@@ -208,6 +202,7 @@ static const struct watchdog_ops sunxi_wdt_ops = {
 	.stop		= sunxi_wdt_stop,
 	.ping		= sunxi_wdt_ping,
 	.set_timeout	= sunxi_wdt_set_timeout,
+	.restart	= sunxi_wdt_restart,
 };
 
 static const struct sunxi_wdt_reg sun4i_wdt_reg = {
@@ -268,6 +263,7 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&sunxi_wdt->wdt_dev, timeout, &pdev->dev);
 	watchdog_set_nowayout(&sunxi_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&sunxi_wdt->wdt_dev, 128);
 
 	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, sunxi_wdt);
 
@@ -277,13 +273,6 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	if (unlikely(err))
 		return err;
 
-	sunxi_wdt->restart_handler.notifier_call = sunxi_restart_handle;
-	sunxi_wdt->restart_handler.priority = 128;
-	err = register_restart_handler(&sunxi_wdt->restart_handler);
-	if (err)
-		dev_err(&pdev->dev,
-			"cannot register restart handler (err=%d)\n", err);
-
 	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
 			sunxi_wdt->wdt_dev.timeout, nowayout);
 
@@ -294,8 +283,6 @@ static int sunxi_wdt_remove(struct platform_device *pdev)
 {
 	struct sunxi_wdt_dev *sunxi_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&sunxi_wdt->restart_handler);
-
 	watchdog_unregister_device(&sunxi_wdt->wdt_dev);
 	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, NULL);
 
-- 
2.5.0
