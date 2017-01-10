Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 24/62] watchdog: jz4740_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:41 -0800
Message-Id: <1484091325-9199-25-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_clk_get() if the device parameter is not NULL
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 20627f22baf6..1d0c85aceaab 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -178,29 +178,21 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drvdata->base)) {
-		ret = PTR_ERR(drvdata->base);
-		goto err_out;
-	}
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
 
-	drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
+	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
 	if (IS_ERR(drvdata->rtc_clk)) {
 		dev_err(&pdev->dev, "cannot find RTC clock\n");
-		ret = PTR_ERR(drvdata->rtc_clk);
-		goto err_out;
+		return PTR_ERR(drvdata->rtc_clk);
 	}
 
-	ret = watchdog_register_device(&drvdata->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
 	if (ret < 0)
-		goto err_disable_clk;
+		return ret;
 
 	platform_set_drvdata(pdev, drvdata);
 	return 0;
-
-err_disable_clk:
-	clk_put(drvdata->rtc_clk);
-err_out:
-	return ret;
 }
 
 static int jz4740_wdt_remove(struct platform_device *pdev)
@@ -208,8 +200,6 @@ static int jz4740_wdt_remove(struct platform_device *pdev)
 	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
 
 	jz4740_wdt_stop(&drvdata->wdt);
-	watchdog_unregister_device(&drvdata->wdt);
-	clk_put(drvdata->rtc_clk);
 
 	return 0;
 }
-- 
2.7.4
