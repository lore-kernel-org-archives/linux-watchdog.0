Return-path: <Li.Xiubo@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>
CC: <wim@iguana.be>, <linux-kernel@vger.kernel.org>, Xiubo Li
	<Li.Xiubo@freescale.com>
Subject: [PATCH v2] watchdog: imx2_wdt: Add power management support.
Date: Tue, 23 Sep 2014 20:31:53 +0800
Message-ID: <1411475513-2576-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Add power management operations(suspend and resume) as part of
dev_pm_ops for IMX2 watchdog driver.

If PM will be supported, please make sure that the wdev->clk
could disable the watchdog's counter input clock source or can
mask watchdog's reset request to the core.

If watchdog is still used by consumers and resumes from deep
sleep state, we need to restart the watchdog again without
enabling the timer.

If watchdog been has started --> stopped by the consumers and
resumes from non-deep sleep state, then start the timer again.

If watchdog has been started --> stopped by the consumers and
resumes from deep sleep state, will do nothing. The watchdog
will be restarted by consumers next time to be used.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

Hi,

I have pulled all the patches since Linux kernel v3.12 to v3.12, and
test the PM on my LS1021A QDS board again.
It works fine for now.

Change in v2:
- Fix one bug with another small change.
- Adjust the comments.



 drivers/watchdog/imx2_wdt.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 68c3d37..b9c81c9 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -295,6 +295,71 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
 	}
 }
 
+#ifdef CONFIG_PM_SLEEP
+/* Disable watchdog if it is active or non-active but still running */
+static int imx2_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *wdog = dev_get_drvdata(dev);
+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+
+	imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
+	imx2_wdt_ping(wdog);
+
+	/* Watchdog has been stopped but IP block is still running */
+	if (!watchdog_active(wdog) && imx2_wdt_is_running(wdev))
+		del_timer_sync(&wdev->timer);
+
+	/* If PM will be supported using imx2_wdt, please
+	 * make sure that the wdev->clk could disable the
+	 * watchdog's counter input clock source or can mask
+	 * watchdog's reset request to the core.
+	 */
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
+		/* If watchdog is still used by consumers and
+		 * resumes from deep sleep state, need to
+		 * restart the watchdog again.
+		 */
+		imx2_wdt_setup(wdog);
+		imx2_wdt_set_timeout(wdog, wdog->timeout);
+		imx2_wdt_ping(wdog);
+	} else if (imx2_wdt_is_running(wdev)) {
+		imx2_wdt_set_timeout(wdog, wdog->timeout);
+		imx2_wdt_ping(wdog);
+		/* If watchdog has started --> stopped by the
+		 * consumers and resumes from non-deep sleep state,
+		 * then start the timer again.
+		 */
+		if (!watchdog_active(wdog))
+			mod_timer(&wdev->timer,
+				  jiffies + wdog->timeout * HZ / 2);
+	} else {
+		/* If watchdog has been started --> stopped by
+		 * the consumers and resumes from deep sleep state,
+		 * will do nothing. The watchdog will be restarted
+		 * by consumers next time to be used.
+		 */
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
@@ -307,6 +372,7 @@ static struct platform_driver imx2_wdt_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.pm     = &imx2_wdt_pm_ops,
 		.of_match_table = imx2_wdt_dt_ids,
 	},
 };
-- 
2.1.0.27.g96db324
