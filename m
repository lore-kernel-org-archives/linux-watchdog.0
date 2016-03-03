Return-path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2] watchdog: tangox_wdt: test clock rate to avoid division by 0
Date: Thu,  3 Mar 2016 09:24:12 +0100
Message-Id: <1456993453-7958-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The clk API may return 0 on clk_get_rate, so we should check the result before
using it as a divisor. For this, refactor the code to use a central
error path.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/tangox_wdt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index 709c1ed6fd79b9..cfbed7e051b619 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -139,6 +139,10 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 		return err;
 
 	dev->clk_rate = clk_get_rate(dev->clk);
+	if (!dev->clk_rate) {
+		err = -EINVAL;
+		goto err;
+	}
 
 	dev->wdt.parent = &pdev->dev;
 	dev->wdt.info = &tangox_wdt_info;
@@ -171,10 +175,8 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	}
 
 	err = watchdog_register_device(&dev->wdt);
-	if (err) {
-		clk_disable_unprepare(dev->clk);
-		return err;
-	}
+	if (err)
+		goto err;
 
 	platform_set_drvdata(pdev, dev);
 
@@ -187,6 +189,10 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
 
 	return 0;
+
+ err:
+	clk_disable_unprepare(dev->clk);
+	return err;
 }
 
 static int tangox_wdt_remove(struct platform_device *pdev)
-- 
2.7.0
