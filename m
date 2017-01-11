Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 18:09:10 -0800
Message-Id: <1484100561-17638-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484100561-17638-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
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
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/tangox_wdt.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index d5fcce062920..7688e1b35867 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(dev->clk);
 	if (err)
 		return err;
+	err = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       dev->clk);
+	if (err)
+		return err;
 
 	dev->clk_rate = clk_get_rate(dev->clk);
-	if (!dev->clk_rate) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (!dev->clk_rate)
+		return -EINVAL;
 
 	dev->wdt.parent = &pdev->dev;
 	dev->wdt.info = &tangox_wdt_info;
@@ -173,19 +176,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_restart_priority(&dev->wdt, 128);
 
-	err = watchdog_register_device(&dev->wdt);
+	err = devm_watchdog_register_device(&pdev->dev, &dev->wdt);
 	if (err)
-		goto err;
+		return err;
 
 	platform_set_drvdata(pdev, dev);
 
 	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
 
 	return 0;
-
- err:
-	clk_disable_unprepare(dev->clk);
-	return err;
 }
 
 static int tangox_wdt_remove(struct platform_device *pdev)
@@ -193,9 +192,6 @@ static int tangox_wdt_remove(struct platform_device *pdev)
 	struct tangox_wdt_device *dev = platform_get_drvdata(pdev);
 
 	tangox_wdt_stop(&dev->wdt);
-	clk_disable_unprepare(dev->clk);
-
-	watchdog_unregister_device(&dev->wdt);
 
 	return 0;
 }
-- 
2.7.4
