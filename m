Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35654 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753887AbcKBIiF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Nov 2016 04:38:05 -0400
From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, wsa@the-dreams.de, lee.jones@linaro.org,
        jingoohan1@gmail.com, tomi.valkeinen@ti.com, wim@iguana.be,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        k.kozlowski@samsung.com
Cc: Richard Vidal-Dorsch <richard.dorsch@gmail.com>,
        jo.sunga@advantech.com, weilun.huang@advantech.com,
        andrew.chou@advantech.com
Subject: [PATCH v4 2/6] Add Advantech iManager GPIO driver
Date: Wed,  2 Nov 2016 01:37:47 -0700
Message-Id: <20161102083751.6335-3-richard.dorsch@gmail.com>
In-Reply-To: <20161102083751.6335-1-richard.dorsch@gmail.com>
References: <20161102083751.6335-1-richard.dorsch@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 drivers/gpio/Kconfig         |  10 +++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-imanager.c | 155 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 drivers/gpio/gpio-imanager.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d011cb8..52e371f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -884,6 +884,16 @@ config HTC_EGPIO
 	    several HTC phones.  It provides basic support for input
 	    pins, output pins, and irqs.
 
+config GPIO_IMANAGER
+	tristate "Advantech iManager GPIO"
+	depends on MFD_IMANAGER
+	help
+	  This enables support for the iManager GPIO interface on some
+	  Advantech SOM, MIO, AIMB, and PCM modules/boards.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called gpio-imanager.
+
 config GPIO_JANZ_TTL
 	tristate "Janz VMOD-TTL Digital IO Module"
 	depends on MFD_JANZ_CMODIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ab28a2d..e1250eb 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_GPIO_GPIO_MM)	+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
+obj-$(CONFIG_GPIO_IMANAGER)	+= gpio-imanager.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
diff --git a/drivers/gpio/gpio-imanager.c b/drivers/gpio/gpio-imanager.c
new file mode 100644
index 0000000..f60592b
--- /dev/null
+++ b/drivers/gpio/gpio-imanager.c
@@ -0,0 +1,155 @@
+/*
+ * Advantech iManager GPIO driver
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd.
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/mfd/imanager.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#define EC_GPIOF_DIR_OUT	BIT(6)
+#define EC_GPIOF_DIR_IN		BIT(7)
+
+struct imanager_gpio_data {
+	struct imanager_device_data *imgr;
+	struct gpio_chip chip;
+};
+
+static int imanager_gpio_direction_in(struct gpio_chip *chip, uint offset)
+{
+	struct imanager_gpio_data *data = gpiochip_get_data(chip);
+	struct imanager_device_data *imgr = data->imgr;
+	struct imanager_device_attribute *attr = imgr->ec.gpio.attr[offset];
+
+	mutex_lock(&imgr->lock);
+	imanager_write8(&imgr->ec, EC_CMD_GPIO_DIR_WR, attr->did,
+			EC_GPIOF_DIR_IN);
+	mutex_unlock(&imgr->lock);
+
+	return 0;
+}
+
+static int
+imanager_gpio_direction_out(struct gpio_chip *chip, uint offset, int val)
+{
+	struct imanager_gpio_data *data = gpiochip_get_data(chip);
+	struct imanager_device_data *imgr = data->imgr;
+	struct imanager_device_attribute *attr = imgr->ec.gpio.attr[offset];
+
+	mutex_lock(&imgr->lock);
+	imanager_write8(&imgr->ec, EC_CMD_GPIO_DIR_WR, attr->did,
+			EC_GPIOF_DIR_OUT);
+	mutex_unlock(&imgr->lock);
+
+	return 0;
+}
+
+static int imanager_gpio_get_direction(struct gpio_chip *chip, uint offset)
+{
+	struct imanager_gpio_data *data = gpiochip_get_data(chip);
+	struct imanager_device_data *imgr = data->imgr;
+	struct imanager_device_attribute *attr = imgr->ec.gpio.attr[offset];
+	int ret;
+
+	mutex_lock(&imgr->lock);
+	ret = imanager_read8(&imgr->ec, EC_CMD_GPIO_DIR_RD, attr->did);
+	mutex_unlock(&imgr->lock);
+
+	return ret & EC_GPIOF_DIR_IN ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
+}
+
+static int imanager_gpio_get(struct gpio_chip *chip, uint offset)
+{
+	struct imanager_gpio_data *data = gpiochip_get_data(chip);
+	struct imanager_device_data *imgr = data->imgr;
+	struct imanager_device_attribute *attr = imgr->ec.gpio.attr[offset];
+	int ret;
+
+	mutex_lock(&imgr->lock);
+	ret = imanager_read8(&imgr->ec, EC_CMD_HWP_RD, attr->did);
+	mutex_unlock(&imgr->lock);
+
+	return ret;
+}
+
+static void imanager_gpio_set(struct gpio_chip *chip, uint offset, int val)
+{
+	struct imanager_gpio_data *data = gpiochip_get_data(chip);
+	struct imanager_device_data *imgr = data->imgr;
+	struct imanager_device_attribute *attr = imgr->ec.gpio.attr[offset];
+
+	mutex_lock(&imgr->lock);
+	imanager_write8(&imgr->ec, EC_CMD_HWP_WR, attr->did, val);
+	mutex_unlock(&imgr->lock);
+}
+
+static int imanager_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_device_data *imgr = dev_get_drvdata(dev->parent);
+	struct imanager_gpio_data *gpio;
+	struct gpio_chip *chip;
+	int ret;
+
+	gpio = devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	gpio->imgr = imgr;
+
+	platform_set_drvdata(pdev, gpio);
+
+	chip = &gpio->chip;
+
+	chip->owner = THIS_MODULE;
+	chip->parent = dev;
+	chip->label = "gpio-imanager";
+	chip->base = -1;
+	chip->ngpio = imgr->ec.gpio.num;
+	chip->get = imanager_gpio_get;
+	chip->set = imanager_gpio_set;
+	chip->direction_input = imanager_gpio_direction_in;
+	chip->direction_output = imanager_gpio_direction_out;
+	chip->get_direction = imanager_gpio_get_direction;
+	if (!chip->ngpio) {
+		dev_err(dev, "No GPIO pins detected\n");
+		return -ENODEV;
+	}
+
+	ret = devm_gpiochip_add_data(dev, chip, gpio);
+	if (ret < 0) {
+		dev_err(dev, "Could not register GPIO chip\n");
+		return ret;
+	}
+
+	dev_info(dev, "GPIO initialized with %d pins\n", chip->ngpio);
+
+	return 0;
+}
+
+static struct platform_driver imanager_gpio_driver = {
+	.driver = {
+		.name	= "imanager-gpio",
+	},
+	.probe	= imanager_gpio_probe,
+};
+
+module_platform_driver(imanager_gpio_driver);
+
+MODULE_DESCRIPTION("Advantech iManager GPIO Driver");
+MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imanager-gpio");
-- 
2.10.1

