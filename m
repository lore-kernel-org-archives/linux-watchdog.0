Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:32892 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbcEAWpT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 May 2016 18:45:19 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH v2 09/10] gpio: 104-idio-16: Utilize the ISA bus driver
Date: Sun,  1 May 2016 18:45:11 -0400
Message-Id: <f13ce73ea1644da42d5aa17a900fc0f497932ca6.1462141338.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1462141338.git.vilhelm.gray@gmail.com>
References: <cover.1462141338.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The ACCES 104-IDIO-16 series communicates via the ISA bus. As such, it
is more appropriate to use the ISA bus driver over the platform driver
to control the ACCES 104-IDIO-16 GPIO driver.

This patch also adds support for multiple devices via the base and irq
module array parameters. Each element of the base array corresponds to a
discrete device; each element of the irq array corresponds to the
respective device addressed in the respective base array element.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/Kconfig            | 10 +++--
 drivers/gpio/gpio-104-idio-16.c | 85 ++++++++++++++---------------------------
 2 files changed, 34 insertions(+), 61 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index c96ef58..af3237c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -527,12 +527,14 @@ config GPIO_104_DIO_48E
 
 config GPIO_104_IDIO_16
 	tristate "ACCES 104-IDIO-16 GPIO support"
+	depends on ISA
 	select GPIOLIB_IRQCHIP
 	help
-	  Enables GPIO support for the ACCES 104-IDIO-16 family. The base port
-	  address for the device may be set via the idio_16_base module
-	  parameter. The interrupt line number for the device may be set via the
-	  idio_16_irq module parameter.
+	  Enables GPIO support for the ACCES 104-IDIO-16 family (104-IDIO-16,
+	  104-IDIO-16E, 104-IDO-16, 104-IDIO-8, 104-IDIO-8E, 104-IDO-8). The
+	  base port addresses for the devices may be configured via the base
+	  module parameter. The interrupt line numbers for the devices may be
+	  configured via the irq module parameter.
 
 config GPIO_104_IDI_48
 	tristate "ACCES 104-IDI-48 GPIO support"
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index ecc85fe..6787b8f 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
+ *
+ * This driver supports the following ACCES devices: 104-IDIO-16,
+ * 104-IDIO-16E, 104-IDO-16, 104-IDIO-8, 104-IDIO-8E, and 104-IDO-8.
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
 
-static unsigned idio_16_base;
-module_param(idio_16_base, uint, 0);
-MODULE_PARM_DESC(idio_16_base, "ACCES 104-IDIO-16 base address");
-static unsigned idio_16_irq;
-module_param(idio_16_irq, uint, 0);
-MODULE_PARM_DESC(idio_16_irq, "ACCES 104-IDIO-16 interrupt line number");
+#define IDIO_16_EXTENT 8
+#define MAX_NUM_IDIO_16 max_num_isa_dev(IDIO_16_EXTENT)
+
+static unsigned int base[MAX_NUM_IDIO_16];
+static unsigned int num_idio_16;
+module_param_array(base, uint, &num_idio_16, 0);
+MODULE_PARM_DESC(base, "ACCES 104-IDIO-16 base addresses");
+
+static unsigned int irq[MAX_NUM_IDIO_16];
+module_param_array(irq, uint, NULL, 0);
+MODULE_PARM_DESC(irq, "ACCES 104-IDIO-16 interrupt line numbers");
 
 /**
  * struct idio_16_gpio - GPIO device private data structure
@@ -185,23 +193,19 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init idio_16_probe(struct platform_device *pdev)
+static int idio_16_probe(struct device *dev, unsigned int id)
 {
-	struct device *dev = &pdev->dev;
 	struct idio_16_gpio *idio16gpio;
-	const unsigned base = idio_16_base;
-	const unsigned extent = 8;
 	const char *const name = dev_name(dev);
 	int err;
-	const unsigned irq = idio_16_irq;
 
 	idio16gpio = devm_kzalloc(dev, sizeof(*idio16gpio), GFP_KERNEL);
 	if (!idio16gpio)
 		return -ENOMEM;
 
-	if (!devm_request_region(dev, base, extent, name)) {
+	if (!devm_request_region(dev, base[id], IDIO_16_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
-			base, base + extent);
+			base[id], base[id] + IDIO_16_EXTENT);
 		return -EBUSY;
 	}
 
@@ -215,8 +219,8 @@ static int __init idio_16_probe(struct platform_device *pdev)
 	idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
 	idio16gpio->chip.get = idio_16_gpio_get;
 	idio16gpio->chip.set = idio_16_gpio_set;
-	idio16gpio->base = base;
-	idio16gpio->irq = irq;
+	idio16gpio->base = base[id];
+	idio16gpio->irq = irq[id];
 	idio16gpio->out_state = 0xFFFF;
 
 	spin_lock_init(&idio16gpio->lock);
@@ -230,8 +234,8 @@ static int __init idio_16_probe(struct platform_device *pdev)
 	}
 
 	/* Disable IRQ by default */
-	outb(0, base + 2);
-	outb(0, base + 1);
+	outb(0, base[id] + 2);
+	outb(0, base[id] + 1);
 
 	err = gpiochip_irqchip_add(&idio16gpio->chip, &idio_16_irqchip, 0,
 		handle_edge_irq, IRQ_TYPE_NONE);
@@ -240,7 +244,7 @@ static int __init idio_16_probe(struct platform_device *pdev)
 		goto err_gpiochip_remove;
 	}
 
-	err = request_irq(irq, idio_16_irq_handler, 0, name, idio16gpio);
+	err = request_irq(irq[id], idio_16_irq_handler, 0, name, idio16gpio);
 	if (err) {
 		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
 		goto err_gpiochip_remove;
@@ -253,9 +257,9 @@ err_gpiochip_remove:
 	return err;
 }
 
-static int idio_16_remove(struct platform_device *pdev)
+static int idio_16_remove(struct device *dev, unsigned int id)
 {
-	struct idio_16_gpio *const idio16gpio = platform_get_drvdata(pdev);
+	struct idio_16_gpio *const idio16gpio = dev_get_drvdata(dev);
 
 	free_irq(idio16gpio->irq, idio16gpio);
 	gpiochip_remove(&idio16gpio->chip);
@@ -263,48 +267,15 @@ static int idio_16_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device *idio_16_device;
-
-static struct platform_driver idio_16_driver = {
+static struct isa_driver idio_16_driver = {
+	.probe = idio_16_probe,
 	.driver = {
 		.name = "104-idio-16"
 	},
 	.remove = idio_16_remove
 };
 
-static void __exit idio_16_exit(void)
-{
-	platform_device_unregister(idio_16_device);
-	platform_driver_unregister(&idio_16_driver);
-}
-
-static int __init idio_16_init(void)
-{
-	int err;
-
-	idio_16_device = platform_device_alloc(idio_16_driver.driver.name, -1);
-	if (!idio_16_device)
-		return -ENOMEM;
-
-	err = platform_device_add(idio_16_device);
-	if (err)
-		goto err_platform_device;
-
-	err = platform_driver_probe(&idio_16_driver, idio_16_probe);
-	if (err)
-		goto err_platform_driver;
-
-	return 0;
-
-err_platform_driver:
-	platform_device_del(idio_16_device);
-err_platform_device:
-	platform_device_put(idio_16_device);
-	return err;
-}
-
-module_init(idio_16_init);
-module_exit(idio_16_exit);
+module_isa_driver(idio_16_driver, num_idio_16);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-IDIO-16 GPIO driver");
-- 
2.7.3

