Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 22/62] watchdog: imx2_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:39 -0800
Message-Id: <1484091325-9199-23-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Replace 'goto l; ... l: return e;' with 'return e;'
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/imx2_wdt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 4874b0f18650..8993351bc8df 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -287,6 +287,11 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(wdev->clk);
 	if (ret)
 		return ret;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       wdev->clk);
+	if (ret)
+		return ret;
 
 	regmap_read(wdev->regmap, IMX2_WDT_WRSR, &val);
 	wdog->bootstatus = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
@@ -316,20 +321,16 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	 */
 	regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
 
-	ret = watchdog_register_device(wdog);
+	ret = devm_watchdog_register_device(&pdev->dev, wdog);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register watchdog device\n");
-		goto disable_clk;
+		return ret;
 	}
 
 	dev_info(&pdev->dev, "timeout %d sec (nowayout=%d)\n",
 		 wdog->timeout, nowayout);
 
 	return 0;
-
-disable_clk:
-	clk_disable_unprepare(wdev->clk);
-	return ret;
 }
 
 static int __exit imx2_wdt_remove(struct platform_device *pdev)
@@ -337,8 +338,6 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
 	struct watchdog_device *wdog = platform_get_drvdata(pdev);
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
-	watchdog_unregister_device(wdog);
-
 	if (imx2_wdt_is_running(wdev)) {
 		imx2_wdt_ping(wdog);
 		dev_crit(&pdev->dev, "Device removed: Expect reboot!\n");
-- 
2.7.4
