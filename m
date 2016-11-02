Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34656 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753816AbcKBIiR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Nov 2016 04:38:17 -0400
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
Subject: [PATCH v4 5/6] Add Advantech iManager Backlight driver
Date: Wed,  2 Nov 2016 01:37:50 -0700
Message-Id: <20161102083751.6335-6-richard.dorsch@gmail.com>
In-Reply-To: <20161102083751.6335-1-richard.dorsch@gmail.com>
References: <20161102083751.6335-1-richard.dorsch@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 drivers/video/backlight/Kconfig       |   8 ++
 drivers/video/backlight/Makefile      |   1 +
 drivers/video/backlight/imanager_bl.c | 210 ++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/video/backlight/imanager_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 5ffa4b4..2dac696 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -251,6 +251,14 @@ config BACKLIGHT_HP700
 	  If you have an HP Jornada 700 series,
 	  say Y to include backlight control driver.
 
+config BACKLIGHT_IMANAGER
+	tristate "Advantech iManager Backlight/Brightness"
+	depends on MFD_IMANAGER
+	help
+	  This enables support for Advantech iManager Backlight and
+	  Brightness control of some Advantech SOM, MIO, AIMB, and
+	  PCM modules/boards.
+
 config BACKLIGHT_CARILLO_RANCH
 	tristate "Intel Carillo Ranch Backlight Driver"
 	depends on LCD_CLASS_DEVICE && PCI && X86 && FB_LE80578
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 16ec534..713b406 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_BACKLIGHT_GENERIC)		+= generic_bl.o
 obj-$(CONFIG_BACKLIGHT_GPIO)		+= gpio_backlight.o
 obj-$(CONFIG_BACKLIGHT_HP680)		+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
+obj-$(CONFIG_BACKLIGHT_IMANAGER)	+= imanager_bl.o
 obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
diff --git a/drivers/video/backlight/imanager_bl.c b/drivers/video/backlight/imanager_bl.c
new file mode 100644
index 0000000..d8b4e3d
--- /dev/null
+++ b/drivers/video/backlight/imanager_bl.c
@@ -0,0 +1,210 @@
+/*
+ * Advantech iManager Backlight driver
+ * Partially derived from wm831x_bl
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
+#include <linux/backlight.h>
+#include <linux/device.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mfd/imanager.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define BL_MAX_PWM	100
+
+enum backlight_units { BL_UNIT_1 = 0, BL_UNIT_2 };
+
+static bool polarity = PWM_POLARITY_NORMAL;
+module_param(polarity, bool, 0444);
+MODULE_PARM_DESC(polarity, "Select backlight polarity (inverted := 1)");
+
+static ushort unit = BL_UNIT_1;
+module_param(unit, ushort, 0444);
+MODULE_PARM_DESC(unit, "Select backlight control unit [0, 1] (defaults to 0)");
+
+struct imanager_backlight_data {
+	struct imanager_device_data *imgr;
+};
+
+struct brightness_level {
+	uint value	: 7,	/* Brightness Value  - LSB [6..0] */
+	     enable	: 1;	/* Brightness Enable - MSB [7] */
+};
+
+struct backlight_ctrl {
+	uint enable	: 1,	/* Backlight Control Enable - LSB [0] */
+	     pwmpol	: 1,	/* PWM Polarity		    - bit [1] */
+	     blpol	: 1,	/* Backlight Polarity	    - bit [2] */
+	     dnc	: 5;	/* Don't care		    - bit [7..3] */
+};
+
+static int imanager_bl_enable(struct imanager_ec_data *ec, int unit)
+{
+	u8 val8;
+	struct brightness_level *ctrl = (struct brightness_level *)&val8;
+	u8 devid = ec->bl.attr[unit]->did;
+	u8 bl_unit = ec->bl.brightness[unit];
+	int ret;
+
+	ret = imanager_read_ram(ec, EC_RAM_ACPI, bl_unit, &val8, sizeof(val8));
+	if (ret < 0)
+		return ret;
+
+	ctrl->enable = 1;
+
+	return imanager_write_ram(ec, EC_RAM_ACPI, devid, &val8, sizeof(val8));
+}
+
+static int imanager_bl_set_polarity(struct imanager_ec_data *ec, uint polarity)
+{
+	u8 val8;
+	struct backlight_ctrl *ctrl = (struct backlight_ctrl *)&val8;
+	int ret;
+
+	ret = imanager_read_ram(ec, EC_RAM_ACPI, EC_OFFSET_BACKLIGHT_CTRL,
+				&val8, sizeof(val8));
+	if (ret < 0)
+		return ret;
+
+	ctrl->blpol = polarity ? 1 : 0;
+
+	return imanager_write_ram(ec, EC_RAM_ACPI, EC_OFFSET_BACKLIGHT_CTRL,
+				  &val8, sizeof(val8));
+}
+
+static int imanager_bl_get_brightness(struct backlight_device *bd)
+{
+	struct imanager_backlight_data *data = bl_get_data(bd);
+	struct imanager_device_data *imgr = data->imgr;
+	u8 devid = imgr->ec.bl.attr[unit]->did;
+	int pwm;
+
+	mutex_lock(&imgr->lock);
+
+	pwm = imanager_read8(&imgr->ec, EC_CMD_HWP_RD, devid);
+	if (pwm < 0) {
+		dev_warn(&bd->dev, "Failed while reading PWM\n");
+		pwm = 0;
+	}
+
+	mutex_unlock(&imgr->lock);
+
+	return polarity ? BL_MAX_PWM - pwm : pwm;
+}
+
+static int imanager_bl_set_brightness(struct backlight_device *bd)
+{
+	struct imanager_backlight_data *data = bl_get_data(bd);
+	struct imanager_device_data *imgr = data->imgr;
+	u8 devid = imgr->ec.bl.attr[unit]->did;
+	u8 brightness = bd->props.brightness;
+	int ret;
+
+	if (bd->props.power != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	if (bd->props.state & BL_CORE_SUSPENDED)
+		brightness = 0;
+
+	/* invert brightness if polarity is set */
+	brightness = polarity ? BL_MAX_PWM - brightness : brightness;
+
+	mutex_lock(&imgr->lock);
+	ret = imanager_write8(&imgr->ec, EC_CMD_HWP_WR, devid, brightness);
+	mutex_unlock(&imgr->lock);
+
+	return ret;
+}
+
+static const struct backlight_ops imanager_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.get_brightness = imanager_bl_get_brightness,
+	.update_status  = imanager_bl_set_brightness,
+};
+
+static int imanager_bl_init(struct device *dev,
+			    struct imanager_backlight_data *data)
+{
+	struct backlight_device *bd;
+	struct backlight_properties props;
+	int ret;
+
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_PLATFORM;
+	props.max_brightness = BL_MAX_PWM;
+	bd = devm_backlight_device_register(dev, "imanager-backlight", dev,
+					    data, &imanager_bl_ops, &props);
+
+	if (IS_ERR(bd)) {
+		dev_err(dev, "Unable to register backlight device\n");
+		return PTR_ERR(bd);
+	}
+
+	bd->props.brightness = imanager_bl_get_brightness(bd);
+	bd->props.max_brightness = BL_MAX_PWM;
+	bd->props.power = FB_BLANK_UNBLANK;
+
+	backlight_update_status(bd);
+
+	ret = imanager_bl_enable(&data->imgr->ec, unit);
+	if (ret < 0)
+		dev_warn(dev, "Could not enable backlight control\n");
+
+	ret = imanager_bl_set_polarity(&data->imgr->ec, polarity);
+	if (ret < 0)
+		dev_warn(dev, "Could not set backlight polarity\n");
+
+	return 0;
+}
+
+static int imanager_bl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_device_data *imgr = dev_get_drvdata(dev->parent);
+	struct imanager_backlight_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->imgr = imgr;
+
+	ret = imanager_bl_init(dev, data);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static struct platform_driver imanager_backlight_driver = {
+	.driver = {
+		.name	= "imanager-backlight",
+	},
+	.probe	= imanager_bl_probe,
+};
+
+module_platform_driver(imanager_backlight_driver);
+
+MODULE_DESCRIPTION("Advantech iManager Backlight driver");
+MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imanager-backlight");
-- 
2.10.1

