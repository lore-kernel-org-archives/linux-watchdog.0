Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Joachim Eastwood <manabian@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 27/62] watchdog: lpc18xx_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:44 -0800
Message-Id: <1484091325-9199-28-git-send-email-linux@roeck-us.net>
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
- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Call del_timer() using devm_add_action()
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Joachim Eastwood <manabian@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/lpc18xx_wdt.c | 58 ++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index 3b8bb59adf02..554030628caa 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -231,19 +231,28 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 		dev_err(dev, "could not prepare or enable sys clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       lpc18xx_wdt->reg_clk);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(lpc18xx_wdt->wdt_clk);
 	if (ret) {
 		dev_err(dev, "could not prepare or enable wdt clock\n");
-		goto disable_reg_clk;
+		return ret;
 	}
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       lpc18xx_wdt->wdt_clk);
+	if (ret)
+		return ret;
 
 	/* We use the clock rate to calculate timeouts */
 	lpc18xx_wdt->clk_rate = clk_get_rate(lpc18xx_wdt->wdt_clk);
 	if (lpc18xx_wdt->clk_rate == 0) {
 		dev_err(dev, "failed to get clock rate\n");
-		ret = -EINVAL;
-		goto disable_wdt_clk;
+		return -EINVAL;
 	}
 
 	lpc18xx_wdt->wdt_dev.info = &lpc18xx_wdt_info;
@@ -269,44 +278,17 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 
 	setup_timer(&lpc18xx_wdt->timer, lpc18xx_wdt_timer_feed,
 		    (unsigned long)&lpc18xx_wdt->wdt_dev);
+	ret = devm_add_action(dev, (void(*)(void *))del_timer,
+			       &lpc18xx_wdt->timer);
+	if (ret)
+		return ret;
 
 	watchdog_set_nowayout(&lpc18xx_wdt->wdt_dev, nowayout);
 	watchdog_set_restart_priority(&lpc18xx_wdt->wdt_dev, 128);
 
-	platform_set_drvdata(pdev, lpc18xx_wdt);
-
-	ret = watchdog_register_device(&lpc18xx_wdt->wdt_dev);
-	if (ret)
-		goto disable_wdt_clk;
-
-	return 0;
-
-disable_wdt_clk:
-	clk_disable_unprepare(lpc18xx_wdt->wdt_clk);
-disable_reg_clk:
-	clk_disable_unprepare(lpc18xx_wdt->reg_clk);
-	return ret;
-}
-
-static void lpc18xx_wdt_shutdown(struct platform_device *pdev)
-{
-	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
-
-	lpc18xx_wdt_stop(&lpc18xx_wdt->wdt_dev);
-}
-
-static int lpc18xx_wdt_remove(struct platform_device *pdev)
-{
-	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
-
-	dev_warn(&pdev->dev, "I quit now, hardware will probably reboot!\n");
-	del_timer(&lpc18xx_wdt->timer);
-
-	watchdog_unregister_device(&lpc18xx_wdt->wdt_dev);
-	clk_disable_unprepare(lpc18xx_wdt->wdt_clk);
-	clk_disable_unprepare(lpc18xx_wdt->reg_clk);
-
-	return 0;
+	watchdog_stop_on_reboot(&lpc18xx_wdt->wdt_dev);
+	return devm_watchdog_register_device(dev,
+					     &lpc18xx_wdt->wdt_dev);
 }
 
 static const struct of_device_id lpc18xx_wdt_match[] = {
@@ -321,8 +303,6 @@ static struct platform_driver lpc18xx_wdt_driver = {
 		.of_match_table	= lpc18xx_wdt_match,
 	},
 	.probe = lpc18xx_wdt_probe,
-	.remove = lpc18xx_wdt_remove,
-	.shutdown = lpc18xx_wdt_shutdown,
 };
 module_platform_driver(lpc18xx_wdt_driver);
 
-- 
2.7.4
