Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 39/62] watchdog: of_xilinx_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:48 -0800
Message-Id: <1484095516-12720-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Replace 'goto l; ... l: return e;' with 'return e;'
- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/of_xilinx_wdt.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index fae7fe929ea3..277de711c31f 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -210,38 +210,27 @@ static int xwdt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "unable to enable clock\n");
 		return rc;
 	}
+	rc = devm_add_action_or_reset(&pdev->dev,
+				      (void(*)(void *))clk_disable_unprepare,
+				      xdev->clk);
+	if (rc)
+		return rc;
 
 	rc = xwdt_selftest(xdev);
 	if (rc == XWT_TIMER_FAILED) {
 		dev_err(&pdev->dev, "SelfTest routine error\n");
-		goto err_clk_disable;
+		return rc;
 	}
 
-	rc = watchdog_register_device(xilinx_wdt_wdd);
+	rc = devm_watchdog_register_device(&pdev->dev, xilinx_wdt_wdd);
 	if (rc) {
 		dev_err(&pdev->dev, "Cannot register watchdog (err=%d)\n", rc);
-		goto err_clk_disable;
+		return rc;
 	}
 
 	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
 		 xdev->base, xilinx_wdt_wdd->timeout);
 
-	platform_set_drvdata(pdev, xdev);
-
-	return 0;
-err_clk_disable:
-	clk_disable_unprepare(xdev->clk);
-
-	return rc;
-}
-
-static int xwdt_remove(struct platform_device *pdev)
-{
-	struct xwdt_device *xdev = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
-	clk_disable_unprepare(xdev->clk);
-
 	return 0;
 }
 
@@ -255,7 +244,6 @@ MODULE_DEVICE_TABLE(of, xwdt_of_match);
 
 static struct platform_driver xwdt_driver = {
 	.probe       = xwdt_probe,
-	.remove      = xwdt_remove,
 	.driver = {
 		.name  = WATCHDOG_NAME,
 		.of_match_table = xwdt_of_match,
-- 
2.7.4
