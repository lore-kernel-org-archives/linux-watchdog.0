Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>,
	Eric Anholt <eric@anholt.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 05/62] watchdog: bcm2835_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:22 -0800
Message-Id: <1484091325-9199-6-git-send-email-linux@roeck-us.net>
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

- Drop assignments to otherwise unused variables
- Replace of_iomap() with platform_get_resource() followed by
  devm_ioremap_resource()
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm2835_wdt.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 4e0adb6c88f0..496f6c106bb1 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -172,8 +172,8 @@ static void bcm2835_power_off(void)
 
 static int bcm2835_wdt_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct bcm2835_wdt *wdt;
 	int err;
 
@@ -184,16 +184,15 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 
 	spin_lock_init(&wdt->lock);
 
-	wdt->base = of_iomap(np, 0);
-	if (!wdt->base) {
-		dev_err(dev, "Failed to remap watchdog regs");
-		return -ENODEV;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
 
 	watchdog_set_drvdata(&bcm2835_wdt_wdd, wdt);
 	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
 	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
-	bcm2835_wdt_wdd.parent = &pdev->dev;
+	bcm2835_wdt_wdd.parent = dev;
 	if (bcm2835_wdt_is_running(wdt)) {
 		/*
 		 * The currently active timeout value (set by the
@@ -208,10 +207,10 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_restart_priority(&bcm2835_wdt_wdd, 128);
 
-	err = watchdog_register_device(&bcm2835_wdt_wdd);
+	watchdog_stop_on_reboot(&bcm2835_wdt_wdd);
+	err = devm_watchdog_register_device(dev, &bcm2835_wdt_wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device");
-		iounmap(wdt->base);
 		return err;
 	}
 
@@ -224,21 +223,12 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 
 static int bcm2835_wdt_remove(struct platform_device *pdev)
 {
-	struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
-
 	if (pm_power_off == bcm2835_power_off)
 		pm_power_off = NULL;
-	watchdog_unregister_device(&bcm2835_wdt_wdd);
-	iounmap(wdt->base);
 
 	return 0;
 }
 
-static void bcm2835_wdt_shutdown(struct platform_device *pdev)
-{
-	bcm2835_wdt_stop(&bcm2835_wdt_wdd);
-}
-
 static const struct of_device_id bcm2835_wdt_of_match[] = {
 	{ .compatible = "brcm,bcm2835-pm-wdt", },
 	{},
@@ -248,7 +238,6 @@ MODULE_DEVICE_TABLE(of, bcm2835_wdt_of_match);
 static struct platform_driver bcm2835_wdt_driver = {
 	.probe		= bcm2835_wdt_probe,
 	.remove		= bcm2835_wdt_remove,
-	.shutdown	= bcm2835_wdt_shutdown,
 	.driver = {
 		.name =		"bcm2835-wdt",
 		.of_match_table = bcm2835_wdt_of_match,
-- 
2.7.4
