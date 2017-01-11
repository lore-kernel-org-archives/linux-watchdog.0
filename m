Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 37/62] watchdog: mtk_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 16:44:46 -0800
Message-Id: <1484095516-12720-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mtk_wdt.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 7ed417a765c7..db2e70ed368b 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -192,7 +192,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	mtk_wdt_stop(&mtk_wdt->wdt_dev);
 
-	err = watchdog_register_device(&mtk_wdt->wdt_dev);
+	watchdog_stop_on_reboot(&mtk_wdt->wdt_dev);
+	err = devm_watchdog_register_device(&pdev->dev, &mtk_wdt->wdt_dev);
 	if (unlikely(err))
 		return err;
 
@@ -202,23 +203,6 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void mtk_wdt_shutdown(struct platform_device *pdev)
-{
-	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
-
-	if (watchdog_active(&mtk_wdt->wdt_dev))
-		mtk_wdt_stop(&mtk_wdt->wdt_dev);
-}
-
-static int mtk_wdt_remove(struct platform_device *pdev)
-{
-	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&mtk_wdt->wdt_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int mtk_wdt_suspend(struct device *dev)
 {
@@ -256,8 +240,6 @@ static const struct dev_pm_ops mtk_wdt_pm_ops = {
 
 static struct platform_driver mtk_wdt_driver = {
 	.probe		= mtk_wdt_probe,
-	.remove		= mtk_wdt_remove,
-	.shutdown	= mtk_wdt_shutdown,
 	.driver		= {
 		.name		= DRV_NAME,
 		.pm		= &mtk_wdt_pm_ops,
-- 
2.7.4
