Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:32776 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbcEAWpC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 May 2016 18:45:02 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH v2 08/10] gpio: 104-idi-48: Utilize the ISA bus driver
Date: Sun,  1 May 2016 18:44:55 -0400
Message-Id: <b5da31d639f81140c99187119b6a2afee052f118.1462141338.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1462141338.git.vilhelm.gray@gmail.com>
References: <cover.1462141338.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The ACCES 104-IDI-48 series communicates via the ISA bus. As such, it
is more appropriate to use the ISA bus driver over the platform driver
to control the ACCES 104-IDI-48 GPIO driver.

This patch also adds support for multiple devices via the base and irq
module array parameters. Each element of the base array corresponds to a
discrete device; each element of the irq array corresponds to the
respective device addressed in the respective base array element.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/Kconfig           | 10 +++--
 drivers/gpio/gpio-104-idi-48.c | 86 ++++++++++++++----------------------------
 2 files changed, 34 insertions(+), 62 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5aca476..c96ef58 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -536,12 +536,14 @@ config GPIO_104_IDIO_16
 
 config GPIO_104_IDI_48
 	tristate "ACCES 104-IDI-48 GPIO support"
+	depends on ISA
 	select GPIOLIB_IRQCHIP
 	help
-	  Enables GPIO support for the ACCES 104-IDI-48 family. The base port
-	  address for the device may be configured via the idi_48_base module
-	  parameter. The interrupt line number for the device may be configured
-	  via the idi_48_irq module parameter.
+	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
+	  104-IDI-48AC, 104-IDI-48B, 104-IDI-48BC). The base port addresses for
+	  the devices may be configured via the base module parameter. The
+	  interrupt line numbers for the devices may be configured via the irq
+	  module parameter.
 
 config GPIO_F7188X
 	tristate "F71869, F71869A, F71882FG, F71889F and F81866 GPIO support"
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index e37cd4c..6c75c83 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
+ *
+ * This driver supports the following ACCES devices: 104-IDI-48A,
+ * 104-IDI-48AC, 104-IDI-48B, and 104-IDI-48BC.
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
 
-static unsigned idi_48_base;
-module_param(idi_48_base, uint, 0);
-MODULE_PARM_DESC(idi_48_base, "ACCES 104-IDI-48 base address");
-static unsigned idi_48_irq;
-module_param(idi_48_irq, uint, 0);
-MODULE_PARM_DESC(idi_48_irq, "ACCES 104-IDI-48 interrupt line number");
+#define IDI_48_EXTENT 8
+#define MAX_NUM_IDI_48 max_num_isa_dev(IDI_48_EXTENT)
+
+static unsigned int base[MAX_NUM_IDI_48];
+static unsigned int num_idi_48;
+module_param_array(base, uint, &num_idi_48, 0);
+MODULE_PARM_DESC(base, "ACCES 104-IDI-48 base addresses");
+
+static unsigned int irq[MAX_NUM_IDI_48];
+module_param_array(irq, uint, NULL, 0);
+MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 
 /**
  * struct idi_48_gpio - GPIO device private data structure
@@ -211,23 +219,19 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init idi_48_probe(struct platform_device *pdev)
+static int idi_48_probe(struct device *dev, unsigned int id)
 {
-	struct device *dev = &pdev->dev;
 	struct idi_48_gpio *idi48gpio;
-	const unsigned base = idi_48_base;
-	const unsigned extent = 8;
 	const char *const name = dev_name(dev);
 	int err;
-	const unsigned irq = idi_48_irq;
 
 	idi48gpio = devm_kzalloc(dev, sizeof(*idi48gpio), GFP_KERNEL);
 	if (!idi48gpio)
 		return -ENOMEM;
 
-	if (!devm_request_region(dev, base, extent, name)) {
+	if (!devm_request_region(dev, base[id], IDI_48_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
-			base, base + extent);
+			base[id], base[id] + IDI_48_EXTENT);
 		return -EBUSY;
 	}
 
@@ -239,8 +243,8 @@ static int __init idi_48_probe(struct platform_device *pdev)
 	idi48gpio->chip.get_direction = idi_48_gpio_get_direction;
 	idi48gpio->chip.direction_input = idi_48_gpio_direction_input;
 	idi48gpio->chip.get = idi_48_gpio_get;
-	idi48gpio->base = base;
-	idi48gpio->irq = irq;
+	idi48gpio->base = base[id];
+	idi48gpio->irq = irq[id];
 
 	spin_lock_init(&idi48gpio->lock);
 
@@ -253,8 +257,8 @@ static int __init idi_48_probe(struct platform_device *pdev)
 	}
 
 	/* Disable IRQ by default */
-	outb(0, base + 7);
-	inb(base + 7);
+	outb(0, base[id] + 7);
+	inb(base[id] + 7);
 
 	err = gpiochip_irqchip_add(&idi48gpio->chip, &idi_48_irqchip, 0,
 		handle_edge_irq, IRQ_TYPE_NONE);
@@ -263,7 +267,7 @@ static int __init idi_48_probe(struct platform_device *pdev)
 		goto err_gpiochip_remove;
 	}
 
-	err = request_irq(irq, idi_48_irq_handler, IRQF_SHARED, name,
+	err = request_irq(irq[id], idi_48_irq_handler, IRQF_SHARED, name,
 		idi48gpio);
 	if (err) {
 		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
@@ -277,9 +281,9 @@ err_gpiochip_remove:
 	return err;
 }
 
-static int idi_48_remove(struct platform_device *pdev)
+static int idi_48_remove(struct device *dev, unsigned int id)
 {
-	struct idi_48_gpio *const idi48gpio = platform_get_drvdata(pdev);
+	struct idi_48_gpio *const idi48gpio = dev_get_drvdata(dev);
 
 	free_irq(idi48gpio->irq, idi48gpio);
 	gpiochip_remove(&idi48gpio->chip);
@@ -287,48 +291,14 @@ static int idi_48_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device *idi_48_device;
-
-static struct platform_driver idi_48_driver = {
+static struct isa_driver idi_48_driver = {
+	.probe = idi_48_probe,
 	.driver = {
 		.name = "104-idi-48"
 	},
 	.remove = idi_48_remove
 };
-
-static void __exit idi_48_exit(void)
-{
-	platform_device_unregister(idi_48_device);
-	platform_driver_unregister(&idi_48_driver);
-}
-
-static int __init idi_48_init(void)
-{
-	int err;
-
-	idi_48_device = platform_device_alloc(idi_48_driver.driver.name, -1);
-	if (!idi_48_device)
-		return -ENOMEM;
-
-	err = platform_device_add(idi_48_device);
-	if (err)
-		goto err_platform_device;
-
-	err = platform_driver_probe(&idi_48_driver, idi_48_probe);
-	if (err)
-		goto err_platform_driver;
-
-	return 0;
-
-err_platform_driver:
-	platform_device_del(idi_48_device);
-err_platform_device:
-	platform_device_put(idi_48_device);
-	return err;
-}
-
-module_init(idi_48_init);
-module_exit(idi_48_exit);
+module_isa_driver(idi_48_driver, num_idi_48);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-IDI-48 GPIO driver");
-- 
2.7.3

