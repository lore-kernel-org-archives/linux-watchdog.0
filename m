Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 21/62] watchdog: imgpdc_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:38 -0800
Message-Id: <1484091325-9199-22-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Replace 'if (e) return e; return 0;' with 'return e;'
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/imgpdc_wdt.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 6ed39dee995f..883bc27fecbf 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -211,25 +211,33 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "could not prepare or enable sys clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       pdc_wdt->sys_clk);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(pdc_wdt->wdt_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "could not prepare or enable wdt clock\n");
-		goto disable_sys_clk;
+		return ret;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       pdc_wdt->wdt_clk);
+	if (ret)
+		return ret;
 
 	/* We use the clock rate to calculate the max timeout */
 	clk_rate = clk_get_rate(pdc_wdt->wdt_clk);
 	if (clk_rate == 0) {
 		dev_err(&pdev->dev, "failed to get clock rate\n");
-		ret = -EINVAL;
-		goto disable_wdt_clk;
+		return -EINVAL;
 	}
 
 	if (order_base_2(clk_rate) > PDC_WDT_CONFIG_DELAY_MASK + 1) {
 		dev_err(&pdev->dev, "invalid clock rate\n");
-		ret = -EINVAL;
-		goto disable_wdt_clk;
+		return -EINVAL;
 	}
 
 	if (order_base_2(clk_rate) == 0)
@@ -284,24 +292,8 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdc_wdt);
 
-	ret = watchdog_register_device(&pdc_wdt->wdt_dev);
-	if (ret)
-		goto disable_wdt_clk;
-
-	return 0;
-
-disable_wdt_clk:
-	clk_disable_unprepare(pdc_wdt->wdt_clk);
-disable_sys_clk:
-	clk_disable_unprepare(pdc_wdt->sys_clk);
-	return ret;
-}
-
-static void pdc_wdt_shutdown(struct platform_device *pdev)
-{
-	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
-
-	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+	watchdog_stop_on_reboot(&pdc_wdt->wdt_dev);
+	return devm_watchdog_register_device(&pdev->dev, &pdc_wdt->wdt_dev);
 }
 
 static int pdc_wdt_remove(struct platform_device *pdev)
@@ -309,9 +301,6 @@ static int pdc_wdt_remove(struct platform_device *pdev)
 	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
 
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
-	watchdog_unregister_device(&pdc_wdt->wdt_dev);
-	clk_disable_unprepare(pdc_wdt->wdt_clk);
-	clk_disable_unprepare(pdc_wdt->sys_clk);
 
 	return 0;
 }
@@ -329,7 +318,6 @@ static struct platform_driver pdc_wdt_driver = {
 	},
 	.probe = pdc_wdt_probe,
 	.remove = pdc_wdt_remove,
-	.shutdown = pdc_wdt_shutdown,
 };
 module_platform_driver(pdc_wdt_driver);
 
-- 
2.7.4
