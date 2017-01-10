Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/62] watchdog: asm9260_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:18 -0800
Message-Id: <1484091325-9199-2-git-send-email-linux@roeck-us.net>
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
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/asm9260_wdt.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 028feb6f6e53..828ca7d5e671 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -219,26 +219,32 @@ static int asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
 		dev_err(priv->dev, "Failed to enable ahb_clk!\n");
 		return err;
 	}
+	err = devm_add_action_or_reset(priv->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       priv->clk_ahb);
+	if (err)
+		return err;
 
 	err = clk_set_rate(priv->clk, CLOCK_FREQ);
 	if (err) {
-		clk_disable_unprepare(priv->clk_ahb);
 		dev_err(priv->dev, "Failed to set rate!\n");
 		return err;
 	}
 
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
-		clk_disable_unprepare(priv->clk_ahb);
 		dev_err(priv->dev, "Failed to enable clk!\n");
 		return err;
 	}
+	err = devm_add_action_or_reset(priv->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       priv->clk);
+	if (err)
+		return err;
 
 	/* wdt has internal divider */
 	clk = clk_get_rate(priv->clk);
 	if (!clk) {
-		clk_disable_unprepare(priv->clk);
-		clk_disable_unprepare(priv->clk_ahb);
 		dev_err(priv->dev, "Failed, clk is 0!\n");
 		return -EINVAL;
 	}
@@ -335,27 +341,16 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_restart_priority(wdd, 128);
 
-	ret = watchdog_register_device(wdd);
+	watchdog_stop_on_reboot(wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, wdd);
 	if (ret)
-		goto clk_off;
+		return ret;
 
 	platform_set_drvdata(pdev, priv);
 
 	dev_info(&pdev->dev, "Watchdog enabled (timeout: %d sec, mode: %s)\n",
 		 wdd->timeout, mode_name[priv->mode]);
 	return 0;
-
-clk_off:
-	clk_disable_unprepare(priv->clk);
-	clk_disable_unprepare(priv->clk_ahb);
-	return ret;
-}
-
-static void asm9260_wdt_shutdown(struct platform_device *pdev)
-{
-	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
-
-	asm9260_wdt_disable(&priv->wdd);
 }
 
 static int asm9260_wdt_remove(struct platform_device *pdev)
@@ -364,11 +359,6 @@ static int asm9260_wdt_remove(struct platform_device *pdev)
 
 	asm9260_wdt_disable(&priv->wdd);
 
-	watchdog_unregister_device(&priv->wdd);
-
-	clk_disable_unprepare(priv->clk);
-	clk_disable_unprepare(priv->clk_ahb);
-
 	return 0;
 }
 
@@ -385,7 +375,6 @@ static struct platform_driver asm9260_wdt_driver = {
 	},
 	.probe = asm9260_wdt_probe,
 	.remove = asm9260_wdt_remove,
-	.shutdown = asm9260_wdt_shutdown,
 };
 module_platform_driver(asm9260_wdt_driver);
 
-- 
2.7.4
