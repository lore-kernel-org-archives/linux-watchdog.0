Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32902 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbcAJJLI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Jan 2016 04:11:08 -0500
From: richard.dorsch@gmail.com
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, jo.sunga@advantech.com,
	Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Subject: [PATCH v2 2/6] Add Advantech iManager GPIO driver
Date: Sun, 10 Jan 2016 01:11:04 -0800
Message-Id: <1452417064-28488-1-git-send-email-richard.dorsch@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 drivers/gpio/Kconfig              |   8 ++
 drivers/gpio/Makefile             |   2 +
 drivers/gpio/imanager-ec-gpio.c   |  98 +++++++++++++++++++++
 drivers/gpio/imanager-gpio.c      | 181 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/imanager/gpio.h |  27 ++++++
 5 files changed, 316 insertions(+)
 create mode 100644 drivers/gpio/imanager-ec-gpio.c
 create mode 100644 drivers/gpio/imanager-gpio.c
 create mode 100644 include/linux/mfd/imanager/gpio.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b18bea0..0f80947 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -765,6 +765,14 @@ config GPIO_DLN2
 	  This driver can also be built as a module. If so, the module
 	  will be called gpio-dln2.
 
+config GPIO_IMANAGER
+	tristate "Advantech iManager GPIO support"
+	depends on MFD_IMANAGER
+	help
+	  Say yes here to support Advantech iManager GPIO functionality
+	  of some Advantech SOM, MIO, AIMB, and PCM modules/boards.
+	  Requires mfd-core and imanager-core to function properly.
+
 config GPIO_JANZ_TTL
 	tristate "Janz VMOD-TTL Digital IO Module"
 	depends on MFD_JANZ_CMODIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 986dbd8..0df55e4 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -41,6 +41,8 @@ obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
 obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
+gpio-imanager-objs		:= imanager-gpio.o imanager-ec-gpio.o
+obj-$(CONFIG_GPIO_IMANAGER)	+= gpio-imanager.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
diff --git a/drivers/gpio/imanager-ec-gpio.c b/drivers/gpio/imanager-ec-gpio.c
new file mode 100644
index 0000000..c448666
--- /dev/null
+++ b/drivers/gpio/imanager-ec-gpio.c
@@ -0,0 +1,98 @@
+/*
+ * Advantech iManager GPIO core
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/bug.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/byteorder/generic.h>
+#include <linux/mfd/imanager/ec.h>
+#include <linux/mfd/imanager/gpio.h>
+
+#define EC_GPIOF_DIR_OUT	(1 << 6)
+#define EC_GPIOF_DIR_IN		(1 << 7)
+#define EC_GPIOF_LOW		(0 << 0)
+#define EC_GPIOF_HIGH		(1 << 0)
+
+/*
+ * Power-on default:
+ * GPIO[7..4] := Input
+ * GPIO[3..0] := Output
+ */
+
+static const struct imanager_gpio_device *gpio;
+
+int gpio_core_get_state(u32 num)
+{
+	int ret;
+
+	if (WARN_ON(num >= gpio->num))
+		return -EINVAL;
+
+	ret = imanager_read_byte(EC_CMD_HWP_RD, gpio->attr[num].did);
+	if (ret < 0)
+		pr_err("Failed to get GPIO pin state (%x)\n", num);
+
+	return ret;
+}
+
+int gpio_core_set_state(u32 num, bool state)
+{
+	int ret;
+
+	if (WARN_ON(num >= gpio->num))
+		return -EINVAL;
+
+	ret = imanager_write_byte(EC_CMD_HWP_WR, gpio->attr[num].did,
+			    state ? EC_GPIOF_HIGH : EC_GPIOF_LOW);
+	if (ret) {
+		pr_err("Failed to set GPIO pin state (%x)\n", num);
+		return ret;
+	}
+
+	return 0;
+}
+
+int gpio_core_set_direction(u32 num, int dir)
+{
+	int ret;
+
+	if (WARN_ON(num >= gpio->num))
+		return -EINVAL;
+
+	ret = imanager_write_byte(EC_CMD_GPIO_DIR_WR, gpio->attr[num].did,
+			    dir ? EC_GPIOF_DIR_IN : EC_GPIOF_DIR_OUT);
+	if (ret) {
+		pr_err("Failed to set GPIO direction (%x, '%s')\n", num,
+			dir == GPIOF_DIR_OUT ? "OUT" : "IN");
+		return ret;
+	}
+
+	return 0;
+}
+
+int gpio_core_get_max_count(void)
+{
+	return gpio->num;
+}
+
+int gpio_core_init(void)
+{
+	gpio = imanager_get_gpio_device();
+	if (!gpio)
+		return -ENODEV;
+
+	return 0;
+}
+
diff --git a/drivers/gpio/imanager-gpio.c b/drivers/gpio/imanager-gpio.c
new file mode 100644
index 0000000..d4a2b30
--- /dev/null
+++ b/drivers/gpio/imanager-gpio.c
@@ -0,0 +1,181 @@
+/*
+ * Advantech iManager GPIO driver
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
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
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/mfd/imanager/core.h>
+#include <linux/mfd/imanager/gpio.h>
+
+struct imanager_gpio_data {
+	struct imanager_device_data *idev;
+	struct gpio_chip chip;
+};
+
+static inline struct imanager_gpio_data *
+to_imanager_gpio_data(struct gpio_chip *chip)
+{
+	return container_of(chip, struct imanager_gpio_data, chip);
+}
+
+static int imanager_direction_in(struct gpio_chip *chip, u32 gpio_num)
+{
+	struct imanager_gpio_data *data = to_imanager_gpio_data(chip);
+	int ret;
+
+	mutex_lock(&data->idev->lock);
+
+	ret = gpio_core_set_direction(gpio_num, GPIOF_DIR_IN);
+	if (ret) {
+		dev_err(chip->dev, "Failed to set direction to 'in' (%d)\n",
+			gpio_num);
+		ret = -EIO;
+	}
+
+	mutex_unlock(&data->idev->lock);
+
+	return ret;
+}
+
+static int
+imanager_direction_out(struct gpio_chip *chip, u32 gpio_num, int val)
+{
+	struct imanager_gpio_data *data = to_imanager_gpio_data(chip);
+	int ret;
+
+	mutex_lock(&data->idev->lock);
+
+	ret = gpio_core_set_direction(gpio_num, GPIOF_DIR_OUT);
+	if (ret) {
+		dev_err(chip->dev, "Failed to set direction to 'out' (%d)\n",
+			gpio_num);
+		ret = -EIO;
+	}
+
+	mutex_unlock(&data->idev->lock);
+
+	return ret;
+}
+
+static int imanager_get(struct gpio_chip *chip, u32 gpio_num)
+{
+	struct imanager_gpio_data *data = to_imanager_gpio_data(chip);
+	int ret;
+
+	mutex_lock(&data->idev->lock);
+
+	ret = gpio_core_get_state(gpio_num);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to get status (%d)\n", gpio_num);
+		ret = -EIO;
+	}
+
+	mutex_unlock(&data->idev->lock);
+
+	return ret;
+}
+
+static void imanager_set(struct gpio_chip *chip, u32 gpio_num,
+			 int val)
+{
+	struct imanager_gpio_data *data = to_imanager_gpio_data(chip);
+	int ret;
+
+	mutex_lock(&data->idev->lock);
+
+	ret = gpio_core_set_state(gpio_num, val);
+	if (ret < 0)
+		dev_err(chip->dev, "Failed to set status (%d)\n", gpio_num);
+
+	mutex_unlock(&data->idev->lock);
+}
+
+static int imanager_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_device_data *idev = dev_get_drvdata(dev->parent);
+	struct imanager_gpio_data *data;
+	struct gpio_chip *chip;
+	int ret;
+
+	if (!idev) {
+		dev_err(dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
+
+	ret = gpio_core_init();
+	if (ret) {
+		dev_err(dev, "Failed initializing GPIO core\n");
+		return ret;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->idev = idev;
+
+	platform_set_drvdata(pdev, data);
+
+	chip = &data->chip;
+
+	chip->owner	= THIS_MODULE;
+	chip->dev	= dev;
+	chip->label	= "imanager_gpio";
+
+	chip->base	= -1;
+	chip->ngpio	= gpio_core_get_max_count();
+
+	chip->get	= imanager_get;
+	chip->set	= imanager_set;
+
+	chip->can_sleep	= 1;
+
+	chip->direction_input  = imanager_direction_in;
+	chip->direction_output = imanager_direction_out;
+
+	ret = gpiochip_add(chip);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register driver\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imanager_remove(struct platform_device *pdev)
+{
+	struct imanager_gpio_data *data = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&data->chip);
+
+	return 0;
+}
+
+static struct platform_driver imanager_gpio_driver = {
+	.driver = {
+		.name	= "imanager_gpio",
+	},
+	.probe	= imanager_gpio_probe,
+	.remove	= imanager_remove,
+};
+
+module_platform_driver(imanager_gpio_driver);
+
+MODULE_DESCRIPTION("Advantech iManager GPIO Driver");
+MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imanager_gpio");
diff --git a/include/linux/mfd/imanager/gpio.h b/include/linux/mfd/imanager/gpio.h
new file mode 100644
index 0000000..dfc849f
--- /dev/null
+++ b/include/linux/mfd/imanager/gpio.h
@@ -0,0 +1,27 @@
+/*
+ * Advantech iManager GPIO core
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __GPIO_H__
+#define __GPIO_H__
+
+#include <linux/gpio.h>
+#include <linux/types.h>
+
+int gpio_core_init(void);
+
+int gpio_core_get_max_count(void);
+
+int gpio_core_get_state(u32 num);
+int gpio_core_set_state(u32 num, bool state);
+int gpio_core_set_direction(u32 num, int dir);
+
+#endif
-- 
2.6.4

