Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34954 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbcEAWou (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 May 2016 18:44:50 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH v2 07/10] gpio: 104-dio-48e: Utilize the ISA bus driver
Date: Sun,  1 May 2016 18:44:39 -0400
Message-Id: <09cf1bbf8c10ab01472a9a2fdb45c08ea3b1066a.1462141338.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1462141338.git.vilhelm.gray@gmail.com>
References: <cover.1462141338.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The ACCES 104-DIO-48E series communicates via the ISA bus. As such, it
is more appropriate to use the ISA bus driver over the platform driver
to control the ACCES 104-DIO-48E GPIO driver.

This patch also adds support for multiple devices via the base and irq
module array parameters. Each element of the base array corresponds to a
discrete device; each element of the irq array corresponds to the
respective device addressed in the respective base array element.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/Kconfig            |   9 ++--
 drivers/gpio/gpio-104-dio-48e.c | 106 ++++++++++++++--------------------------
 2 files changed, 43 insertions(+), 72 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5f3429f..5aca476 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -517,12 +517,13 @@ menu "Port-mapped I/O GPIO drivers"
 
 config GPIO_104_DIO_48E
 	tristate "ACCES 104-DIO-48E GPIO support"
+	depends on ISA
 	select GPIOLIB_IRQCHIP
 	help
-	  Enables GPIO support for the ACCES 104-DIO-48E family. The base port
-	  address for the device may be configured via the dio_48e_base module
-	  parameter. The interrupt line number for the device may be configured
-	  via the dio_48e_irq module parameter.
+	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
+	  104-DIO-24E). The base port addresses for the devices may be
+	  configured via the base module parameter. The interrupt line numbers
+	  for the devices may be configured via the irq module parameter.
 
 config GPIO_104_IDIO_16
 	tristate "ACCES 104-IDIO-16 GPIO support"
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 448a903..1a647c0 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -1,5 +1,5 @@
 /*
- * GPIO driver for the ACCES 104-DIO-48E
+ * GPIO driver for the ACCES 104-DIO-48E series
  * Copyright (C) 2016 William Breathitt Gray
  *
  * This program is free software; you can redistribute it and/or modify
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
+ *
+ * This driver supports the following ACCES devices: 104-DIO-48E and
+ * 104-DIO-24E.
  */
 #include <linux/bitops.h>
 #include <linux/device.h>
@@ -19,18 +22,23 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irqdesc.h>
+#include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 
-static unsigned dio_48e_base;
-module_param(dio_48e_base, uint, 0);
-MODULE_PARM_DESC(dio_48e_base, "ACCES 104-DIO-48E base address");
-static unsigned dio_48e_irq;
-module_param(dio_48e_irq, uint, 0);
-MODULE_PARM_DESC(dio_48e_irq, "ACCES 104-DIO-48E interrupt line number");
+#define DIO48E_EXTENT 16
+#define MAX_NUM_DIO48E max_num_isa_dev(DIO48E_EXTENT)
+
+static unsigned int base[MAX_NUM_DIO48E];
+static unsigned int num_dio48e;
+module_param_array(base, uint, &num_dio48e, 0);
+MODULE_PARM_DESC(base, "ACCES 104-DIO-48E base addresses");
+
+static unsigned int irq[MAX_NUM_DIO48E];
+module_param_array(irq, uint, NULL, 0);
+MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
 /**
  * struct dio48e_gpio - GPIO device private data structure
@@ -294,23 +302,19 @@ static irqreturn_t dio48e_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init dio48e_probe(struct platform_device *pdev)
+static int dio48e_probe(struct device *dev, unsigned int id)
 {
-	struct device *dev = &pdev->dev;
 	struct dio48e_gpio *dio48egpio;
-	const unsigned base = dio_48e_base;
-	const unsigned extent = 16;
 	const char *const name = dev_name(dev);
 	int err;
-	const unsigned irq = dio_48e_irq;
 
 	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
 	if (!dio48egpio)
 		return -ENOMEM;
 
-	if (!devm_request_region(dev, base, extent, name)) {
+	if (!devm_request_region(dev, base[id], DIO48E_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
-			base, base + extent);
+			base[id], base[id] + DIO48E_EXTENT);
 		return -EBUSY;
 	}
 
@@ -324,8 +328,8 @@ static int __init dio48e_probe(struct platform_device *pdev)
 	dio48egpio->chip.direction_output = dio48e_gpio_direction_output;
 	dio48egpio->chip.get = dio48e_gpio_get;
 	dio48egpio->chip.set = dio48e_gpio_set;
-	dio48egpio->base = base;
-	dio48egpio->irq = irq;
+	dio48egpio->base = base[id];
+	dio48egpio->irq = irq[id];
 
 	spin_lock_init(&dio48egpio->lock);
 
@@ -338,19 +342,19 @@ static int __init dio48e_probe(struct platform_device *pdev)
 	}
 
 	/* initialize all GPIO as output */
-	outb(0x80, base + 3);
-	outb(0x00, base);
-	outb(0x00, base + 1);
-	outb(0x00, base + 2);
-	outb(0x00, base + 3);
-	outb(0x80, base + 7);
-	outb(0x00, base + 4);
-	outb(0x00, base + 5);
-	outb(0x00, base + 6);
-	outb(0x00, base + 7);
+	outb(0x80, base[id] + 3);
+	outb(0x00, base[id]);
+	outb(0x00, base[id] + 1);
+	outb(0x00, base[id] + 2);
+	outb(0x00, base[id] + 3);
+	outb(0x80, base[id] + 7);
+	outb(0x00, base[id] + 4);
+	outb(0x00, base[id] + 5);
+	outb(0x00, base[id] + 6);
+	outb(0x00, base[id] + 7);
 
 	/* disable IRQ by default */
-	inb(base + 0xB);
+	inb(base[id] + 0xB);
 
 	err = gpiochip_irqchip_add(&dio48egpio->chip, &dio48e_irqchip, 0,
 		handle_edge_irq, IRQ_TYPE_NONE);
@@ -359,7 +363,7 @@ static int __init dio48e_probe(struct platform_device *pdev)
 		goto err_gpiochip_remove;
 	}
 
-	err = request_irq(irq, dio48e_irq_handler, 0, name, dio48egpio);
+	err = request_irq(irq[id], dio48e_irq_handler, 0, name, dio48egpio);
 	if (err) {
 		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
 		goto err_gpiochip_remove;
@@ -372,9 +376,9 @@ err_gpiochip_remove:
 	return err;
 }
 
-static int dio48e_remove(struct platform_device *pdev)
+static int dio48e_remove(struct device *dev, unsigned int id)
 {
-	struct dio48e_gpio *const dio48egpio = platform_get_drvdata(pdev);
+	struct dio48e_gpio *const dio48egpio = dev_get_drvdata(dev);
 
 	free_irq(dio48egpio->irq, dio48egpio);
 	gpiochip_remove(&dio48egpio->chip);
@@ -382,48 +386,14 @@ static int dio48e_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device *dio48e_device;
-
-static struct platform_driver dio48e_driver = {
+static struct isa_driver dio48e_driver = {
+	.probe = dio48e_probe,
 	.driver = {
 		.name = "104-dio-48e"
 	},
 	.remove = dio48e_remove
 };
-
-static void __exit dio48e_exit(void)
-{
-	platform_device_unregister(dio48e_device);
-	platform_driver_unregister(&dio48e_driver);
-}
-
-static int __init dio48e_init(void)
-{
-	int err;
-
-	dio48e_device = platform_device_alloc(dio48e_driver.driver.name, -1);
-	if (!dio48e_device)
-		return -ENOMEM;
-
-	err = platform_device_add(dio48e_device);
-	if (err)
-		goto err_platform_device;
-
-	err = platform_driver_probe(&dio48e_driver, dio48e_probe);
-	if (err)
-		goto err_platform_driver;
-
-	return 0;
-
-err_platform_driver:
-	platform_device_del(dio48e_device);
-err_platform_device:
-	platform_device_put(dio48e_device);
-	return err;
-}
-
-module_init(dio48e_init);
-module_exit(dio48e_exit);
+module_isa_driver(dio48e_driver, num_dio48e);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-DIO-48E GPIO driver");
-- 
2.7.3

