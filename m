Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2] watchdog: mtx-1: Convert to use GPIO descriptor
Date: Tue,  4 Dec 2018 14:02:36 +0100
Message-Id: <20181204130236.11504-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

This converts the MTX-1 driver to grab a GPIO descriptor
associated with the device instead of using a resource with
a global GPIO number.

The board using this driver appears to be out-of-tree
(OpenWRT), but the users can be easily augmented by adding a
machine descriptor table before registering the device.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add the correct descriptor table to the board file and
  register it. I missed the existing board file in the
  previous iteration.
---
 arch/mips/alchemy/board-mtx1.c | 16 +++++++++-------
 drivers/watchdog/mtx-1_wdt.c   | 19 +++++++++----------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index d625e6f99ae7..e263a5d1623f 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/mtd/partitions.h>
@@ -130,13 +131,13 @@ static struct platform_device mtx1_button = {
 	}
 };
 
-static struct resource mtx1_wdt_res[] = {
-	[0] = {
-		.start	= 215,
-		.end	= 215,
-		.name	= "mtx1-wdt-gpio",
-		.flags	= IORESOURCE_IRQ,
-	}
+static struct gpiod_lookup_table mtx1_wdt_gpio_table = {
+	.dev_id = "mtx1-wdt.0",
+	.table = {
+		/* Global number 215 is offset 15 on Alchemy GPIO 2 */
+		GPIO_LOOKUP("alchemy-gpio2", 15, NULL, GPIO_ACTIVE_HIGH),
+		{ },
+	},
 };
 
 static struct platform_device mtx1_wdt = {
@@ -310,6 +311,7 @@ static int __init mtx1_register_devices(void)
 	}
 	gpio_direction_input(mtx1_gpio_button[0].gpio);
 out:
+	gpiod_add_lookup_table(&mtx1_wdt_gpio_table);
 	return platform_add_devices(mtx1_devs, ARRAY_SIZE(mtx1_devs));
 }
 arch_initcall(mtx1_register_devices);
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
2.19.2
