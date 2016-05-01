Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34048 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbcEAWpc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 May 2016 18:45:32 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH v2 10/10] gpio: ws16c48: Utilize the ISA bus driver
Date: Sun,  1 May 2016 18:45:24 -0400
Message-Id: <bb6f42624eaa1d4c361d4ab216a99178a95bdb09.1462141338.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1462141338.git.vilhelm.gray@gmail.com>
References: <cover.1462141338.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The WinSystems WS16C48 communicates via the ISA bus. As such, it is more
appropriate to use the ISA bus driver over the platform driver to
control the WinSystems WS16C48 GPIO driver.

This patch also adds support for multiple devices via the base and irq
module array parameters. Each element of the base array corresponds to a
discrete device; each element of the irq array corresponds to the
respective device addressed in the respective base array element.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/Kconfig        |  9 ++---
 drivers/gpio/gpio-ws16c48.c | 88 +++++++++++++++------------------------------
 2 files changed, 33 insertions(+), 64 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index af3237c..e5c1224 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -614,12 +614,13 @@ config GPIO_TS5500
 
 config GPIO_WS16C48
 	tristate "WinSystems WS16C48 GPIO support"
+	depends on ISA
 	select GPIOLIB_IRQCHIP
 	help
-	  Enables GPIO support for the WinSystems WS16C48. The base port address
-	  for the device may be configured via the ws16c48_base module
-	  parameter. The interrupt line number for the device may be configured
-	  via the ws16c48_irq module parameter.
+	  Enables GPIO support for the WinSystems WS16C48. The base port
+	  addresses for the devices may be configured via the base module
+	  parameter. The interrupt line numbers for the devices may be
+	  configured via the irq module parameter.
 
 endmenu
 
diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 51f41e8..eaa71d4 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -19,18 +19,23 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irqdesc.h>
+#include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 
-static unsigned ws16c48_base;
-module_param(ws16c48_base, uint, 0);
-MODULE_PARM_DESC(ws16c48_base, "WinSystems WS16C48 base address");
-static unsigned ws16c48_irq;
-module_param(ws16c48_irq, uint, 0);
-MODULE_PARM_DESC(ws16c48_irq, "WinSystems WS16C48 interrupt line number");
+#define WS16C48_EXTENT 16
+#define MAX_NUM_WS16C48 max_num_isa_dev(WS16C48_EXTENT)
+
+static unsigned int base[MAX_NUM_WS16C48];
+static unsigned int num_ws16c48;
+module_param_array(base, uint, &num_ws16c48, 0);
+MODULE_PARM_DESC(base, "WinSystems WS16C48 base addresses");
+
+static unsigned int irq[MAX_NUM_WS16C48];
+module_param_array(irq, uint, NULL, 0);
+MODULE_PARM_DESC(irq, "WinSystems WS16C48 interrupt line numbers");
 
 /**
  * struct ws16c48_gpio - GPIO device private data structure
@@ -298,23 +303,19 @@ static irqreturn_t ws16c48_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init ws16c48_probe(struct platform_device *pdev)
+static int ws16c48_probe(struct device *dev, unsigned int id)
 {
-	struct device *dev = &pdev->dev;
 	struct ws16c48_gpio *ws16c48gpio;
-	const unsigned base = ws16c48_base;
-	const unsigned extent = 16;
 	const char *const name = dev_name(dev);
 	int err;
-	const unsigned irq = ws16c48_irq;
 
 	ws16c48gpio = devm_kzalloc(dev, sizeof(*ws16c48gpio), GFP_KERNEL);
 	if (!ws16c48gpio)
 		return -ENOMEM;
 
-	if (!devm_request_region(dev, base, extent, name)) {
+	if (!devm_request_region(dev, base[id], WS16C48_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
-			base, base + extent);
+			base[id], base[id] + WS16C48_EXTENT);
 		return -EBUSY;
 	}
 
@@ -328,8 +329,8 @@ static int __init ws16c48_probe(struct platform_device *pdev)
 	ws16c48gpio->chip.direction_output = ws16c48_gpio_direction_output;
 	ws16c48gpio->chip.get = ws16c48_gpio_get;
 	ws16c48gpio->chip.set = ws16c48_gpio_set;
-	ws16c48gpio->base = base;
-	ws16c48gpio->irq = irq;
+	ws16c48gpio->base = base[id];
+	ws16c48gpio->irq = irq[id];
 
 	spin_lock_init(&ws16c48gpio->lock);
 
@@ -342,11 +343,11 @@ static int __init ws16c48_probe(struct platform_device *pdev)
 	}
 
 	/* Disable IRQ by default */
-	outb(0x80, base + 7);
-	outb(0, base + 8);
-	outb(0, base + 9);
-	outb(0, base + 10);
-	outb(0xC0, base + 7);
+	outb(0x80, base[id] + 7);
+	outb(0, base[id] + 8);
+	outb(0, base[id] + 9);
+	outb(0, base[id] + 10);
+	outb(0xC0, base[id] + 7);
 
 	err = gpiochip_irqchip_add(&ws16c48gpio->chip, &ws16c48_irqchip, 0,
 		handle_edge_irq, IRQ_TYPE_NONE);
@@ -355,7 +356,7 @@ static int __init ws16c48_probe(struct platform_device *pdev)
 		goto err_gpiochip_remove;
 	}
 
-	err = request_irq(irq, ws16c48_irq_handler, IRQF_SHARED, name,
+	err = request_irq(irq[id], ws16c48_irq_handler, IRQF_SHARED, name,
 		ws16c48gpio);
 	if (err) {
 		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
@@ -369,9 +370,9 @@ err_gpiochip_remove:
 	return err;
 }
 
-static int ws16c48_remove(struct platform_device *pdev)
+static int ws16c48_remove(struct device *dev, unsigned int id)
 {
-	struct ws16c48_gpio *const ws16c48gpio = platform_get_drvdata(pdev);
+	struct ws16c48_gpio *const ws16c48gpio = dev_get_drvdata(dev);
 
 	free_irq(ws16c48gpio->irq, ws16c48gpio);
 	gpiochip_remove(&ws16c48gpio->chip);
@@ -379,48 +380,15 @@ static int ws16c48_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device *ws16c48_device;
-
-static struct platform_driver ws16c48_driver = {
+static struct isa_driver ws16c48_driver = {
+	.probe = ws16c48_probe,
 	.driver = {
 		.name = "ws16c48"
 	},
 	.remove = ws16c48_remove
 };
 
-static void __exit ws16c48_exit(void)
-{
-	platform_device_unregister(ws16c48_device);
-	platform_driver_unregister(&ws16c48_driver);
-}
-
-static int __init ws16c48_init(void)
-{
-	int err;
-
-	ws16c48_device = platform_device_alloc(ws16c48_driver.driver.name, -1);
-	if (!ws16c48_device)
-		return -ENOMEM;
-
-	err = platform_device_add(ws16c48_device);
-	if (err)
-		goto err_platform_device;
-
-	err = platform_driver_probe(&ws16c48_driver, ws16c48_probe);
-	if (err)
-		goto err_platform_driver;
-
-	return 0;
-
-err_platform_driver:
-	platform_device_del(ws16c48_device);
-err_platform_device:
-	platform_device_put(ws16c48_device);
-	return err;
-}
-
-module_init(ws16c48_init);
-module_exit(ws16c48_exit);
+module_isa_driver(ws16c48_driver, num_ws16c48);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("WinSystems WS16C48 GPIO driver");
-- 
2.7.3

