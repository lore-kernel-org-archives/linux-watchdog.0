Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@linux-mips.org
Subject: [PATCH 26/62] watchdog: loongson1_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:43 -0800
Message-Id: <1484091325-9199-27-git-send-email-linux@roeck-us.net>
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
- Replace 'val = e; return val;' with 'return e;'
- Drop assignments to otherwise unused variables
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Keguang Zhang <keguang.zhang@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/loongson1_wdt.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 3aee50c64a36..36f0c7e02745 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -109,12 +109,15 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "clk enable failed\n");
 		return err;
 	}
+	err = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       drvdata->clk);
+	if (err)
+		return err;
 
 	clk_rate = clk_get_rate(drvdata->clk);
-	if (!clk_rate) {
-		err = -EINVAL;
-		goto err0;
-	}
+	if (!clk_rate)
+		return -EINVAL;
 	drvdata->clk_rate = clk_rate;
 
 	ls1x_wdt = &drvdata->wdt;
@@ -129,35 +132,19 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(ls1x_wdt, nowayout);
 	watchdog_set_drvdata(ls1x_wdt, drvdata);
 
-	err = watchdog_register_device(&drvdata->wdt);
+	err = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register watchdog device\n");
-		goto err0;
+		return err;
 	}
 
-	platform_set_drvdata(pdev, drvdata);
-
 	dev_info(&pdev->dev, "Loongson1 Watchdog driver registered\n");
 
 	return 0;
-err0:
-	clk_disable_unprepare(drvdata->clk);
-	return err;
-}
-
-static int ls1x_wdt_remove(struct platform_device *pdev)
-{
-	struct ls1x_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&drvdata->wdt);
-	clk_disable_unprepare(drvdata->clk);
-
-	return 0;
 }
 
 static struct platform_driver ls1x_wdt_driver = {
 	.probe = ls1x_wdt_probe,
-	.remove = ls1x_wdt_remove,
 	.driver = {
 		.name = "ls1x-wdt",
 	},
-- 
2.7.4
