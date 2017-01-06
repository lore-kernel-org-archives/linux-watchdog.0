Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] watchdog: tangox: Use watchdog core to install restart handler
Date: Thu,  5 Jan 2017 19:52:00 -0800
Message-Id: <1483674720-4870-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483674720-4870-1-git-send-email-linux@roeck-us.net>
References: <1483674720-4870-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use the infrastructure provided by the watchdog core to install
the restart handler.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Need to call watchdog_set_restart_priority()

 drivers/watchdog/tangox_wdt.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index 202c4b9cc921..d5fcce062920 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -15,9 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/notifier.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #define DEFAULT_TIMEOUT 30
@@ -47,7 +45,6 @@ struct tangox_wdt_device {
 	void __iomem *base;
 	unsigned long clk_rate;
 	struct clk *clk;
-	struct notifier_block restart;
 };
 
 static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
@@ -96,24 +93,24 @@ static const struct watchdog_info tangox_wdt_info = {
 	.identity = "tangox watchdog",
 };
 
+static int tangox_wdt_restart(struct watchdog_device *wdt,
+			      unsigned long action, void *data)
+{
+	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
+
+	writel(1, dev->base + WD_COUNTER);
+
+	return 0;
+}
+
 static const struct watchdog_ops tangox_wdt_ops = {
 	.start		= tangox_wdt_start,
 	.stop		= tangox_wdt_stop,
 	.set_timeout	= tangox_wdt_set_timeout,
 	.get_timeleft	= tangox_wdt_get_timeleft,
+	.restart	= tangox_wdt_restart,
 };
 
-static int tangox_wdt_restart(struct notifier_block *nb, unsigned long action,
-			      void *data)
-{
-	struct tangox_wdt_device *dev =
-		container_of(nb, struct tangox_wdt_device, restart);
-
-	writel(1, dev->base + WD_COUNTER);
-
-	return NOTIFY_DONE;
-}
-
 static int tangox_wdt_probe(struct platform_device *pdev)
 {
 	struct tangox_wdt_device *dev;
@@ -174,18 +171,14 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 		tangox_wdt_start(&dev->wdt);
 	}
 
+	watchdog_set_restart_priority(&dev->wdt, 128);
+
 	err = watchdog_register_device(&dev->wdt);
 	if (err)
 		goto err;
 
 	platform_set_drvdata(pdev, dev);
 
-	dev->restart.notifier_call = tangox_wdt_restart;
-	dev->restart.priority = 128;
-	err = register_restart_handler(&dev->restart);
-	if (err)
-		dev_warn(&pdev->dev, "failed to register restart handler\n");
-
 	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
 
 	return 0;
@@ -202,7 +195,6 @@ static int tangox_wdt_remove(struct platform_device *pdev)
 	tangox_wdt_stop(&dev->wdt);
 	clk_disable_unprepare(dev->clk);
 
-	unregister_restart_handler(&dev->restart);
 	watchdog_unregister_device(&dev->wdt);
 
 	return 0;
-- 
2.7.4
