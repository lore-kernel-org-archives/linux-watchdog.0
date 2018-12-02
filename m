Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41170 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeLBNF7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 2 Dec 2018 08:05:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so8849984ljb.8
        for <linux-watchdog@vger.kernel.org>; Sun, 02 Dec 2018 05:05:54 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] watchdog: mtx-1: Convert to use GPIO descriptor
Date: Sun,  2 Dec 2018 14:03:49 +0100
Message-Id: <20181202130349.30464-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This converts the MTX-1 driver to grab a GPIO descriptor
associated with the device instead of using a resource with
a global GPIO number.

The board using this driver appears to be out-of-tree
(OpenWRT), but the users can be easily augmented by adding a
machine descriptor table before registering the device.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/watchdog/mtx-1_wdt.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 1fa7d2b32494..522a2b98ec16 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -39,7 +39,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
@@ -55,7 +55,7 @@ static struct {
 	int queue;
 	int default_ticks;
 	unsigned long inuse;
-	unsigned gpio;
+	struct gpio_desc *gpiod;
 	unsigned int gstate;
 } mtx1_wdt_device;
 
@@ -67,7 +67,7 @@ static void mtx1_wdt_trigger(struct timer_list *unused)
 
 	/* toggle wdt gpio */
 	mtx1_wdt_device.gstate = !mtx1_wdt_device.gstate;
-	gpio_set_value(mtx1_wdt_device.gpio, mtx1_wdt_device.gstate);
+	gpiod_set_value(mtx1_wdt_device.gpiod, mtx1_wdt_device.gstate);
 
 	if (mtx1_wdt_device.queue && ticks)
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
@@ -90,7 +90,7 @@ static void mtx1_wdt_start(void)
 	if (!mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 1;
 		mtx1_wdt_device.gstate = 1;
-		gpio_set_value(mtx1_wdt_device.gpio, 1);
+		gpiod_set_value(mtx1_wdt_device.gpio, 1);
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
 	}
 	mtx1_wdt_device.running++;
@@ -105,7 +105,7 @@ static int mtx1_wdt_stop(void)
 	if (mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 0;
 		mtx1_wdt_device.gstate = 0;
-		gpio_set_value(mtx1_wdt_device.gpio, 0);
+		gpiod_set_value(mtx1_wdt_device.gpio, 0);
 	}
 	ticks = mtx1_wdt_device.default_ticks;
 	spin_unlock_irqrestore(&mtx1_wdt_device.lock, flags);
@@ -198,12 +198,11 @@ static int mtx1_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	mtx1_wdt_device.gpio = pdev->resource[0].start;
-	ret = devm_gpio_request_one(&pdev->dev, mtx1_wdt_device.gpio,
-				GPIOF_OUT_INIT_HIGH, "mtx1-wdt");
-	if (ret < 0) {
+	mtx1_wdt_device.gpiod = devm_gpiod_get(&pdev->dev,
+					       NULL, GPIOD_OUT_HIGH);
+	if (IS_ERR(mtx1_wdt_device.gpiod)) {
 		dev_err(&pdev->dev, "failed to request gpio");
-		return ret;
+		return PTR_ERR(mtx1_wdt_device.gpiod);
 	}
 
 	spin_lock_init(&mtx1_wdt_device.lock);
-- 
2.19.1
