Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [RFC PATCH 10/13] watchdog: mtk_wdt: use core restart handler
Date: Mon,  2 Nov 2015 20:36:23 -0500
Message-Id: <1446514586-31455-11-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/mtk_wdt.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 6ad9df9..277f588 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -29,7 +29,6 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/delay.h>
 
 #define WDT_MAX_TIMEOUT		31
@@ -64,16 +63,13 @@ static unsigned int timeout = WDT_MAX_TIMEOUT;
 struct mtk_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
-	struct notifier_block restart_handler;
 };
 
-static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
-				void *cmd)
+static int mtk_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	struct mtk_wdt_dev *mtk_wdt;
+	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base;
 
-	mtk_wdt = container_of(this, struct mtk_wdt_dev, restart_handler);
 	wdt_base = mtk_wdt->wdt_base;
 
 	while (1) {
@@ -160,6 +156,7 @@ static const struct watchdog_ops mtk_wdt_ops = {
 	.stop		= mtk_wdt_stop,
 	.ping		= mtk_wdt_ping,
 	.set_timeout	= mtk_wdt_set_timeout,
+	.restart	= mtk_wdt_restart,
 };
 
 static int mtk_wdt_probe(struct platform_device *pdev)
@@ -188,6 +185,7 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&mtk_wdt->wdt_dev, timeout, &pdev->dev);
 	watchdog_set_nowayout(&mtk_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&mtk_wdt->wdt_dev, 128);
 
 	watchdog_set_drvdata(&mtk_wdt->wdt_dev, mtk_wdt);
 
@@ -197,13 +195,6 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	if (unlikely(err))
 		return err;
 
-	mtk_wdt->restart_handler.notifier_call = mtk_reset_handler;
-	mtk_wdt->restart_handler.priority = 128;
-	err = register_restart_handler(&mtk_wdt->restart_handler);
-	if (err)
-		dev_warn(&pdev->dev,
-			"cannot register restart handler (err=%d)\n", err);
-
 	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
 			mtk_wdt->wdt_dev.timeout, nowayout);
 
@@ -222,8 +213,6 @@ static int mtk_wdt_remove(struct platform_device *pdev)
 {
 	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&mtk_wdt->restart_handler);
-
 	watchdog_unregister_device(&mtk_wdt->wdt_dev);
 
 	return 0;
-- 
2.5.0
