Return-path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <groeck7@gmail.com>, <linux-watchdog@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] watchdog: imx2_wdt: Add power management support.
Date: Mon, 22 Sep 2014 18:00:52 +0800
Message-ID: <1411380052-48655-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Add power management operations(suspend and resume) as part of
dev_pm_ops for IMX2 watchdog driver.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/watchdog/imx2_wdt.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 68c3d37..941c36f 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -295,6 +295,52 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
 	}
 }
 
+#ifdef CONFIG_PM_SLEEP
+/* Disable watchdog if it is active during suspend */
+static int imx2_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *wdog = dev_get_drvdata(dev);
+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+
+	imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
+	imx2_wdt_ping(wdog);
+
+	/* Watchdog has been stopped but IP block is still running */
+	if (!watchdog_active(&wdog) && imx2_wdt_is_running(wdev))
+		del_timer_sync(&wdev->timer);
+
+	clk_disable_unprepare(wdev->clk);
+
+	return 0;
+}
+
+/* Enable watchdog and configure it if necessary */
+static int imx2_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *wdog = dev_get_drvdata(dev);
+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+
+	clk_prepare_enable(wdev->clk);
+
+	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
+		/* Resumes from deep sleep we need restart
+		 * the watchdog again.
+		 */
+		imx2_wdt_setup(wdog);
+		imx2_wdt_set_timeout(wdog, wdog->timeout);
+		imx2_wdt_ping(wdog);
+	} else if (imx2_wdt_is_running(wdev)) {
+		imx2_wdt_ping(wdog);
+		mod_timer(&wdev->timer, jiffies + wdog->timeout * HZ / 2);
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
+			 imx2_wdt_resume);
+
 static const struct of_device_id imx2_wdt_dt_ids[] = {
 	{ .compatible = "fsl,imx21-wdt", },
 	{ /* sentinel */ }
@@ -307,6 +353,7 @@ static struct platform_driver imx2_wdt_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.pm     = &imx2_wdt_pm_ops,
 		.of_match_table = imx2_wdt_dt_ids,
 	},
 };
-- 
2.1.0.27.g96db324
