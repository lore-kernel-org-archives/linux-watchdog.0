Return-path: <richard.dorsch@gmail.com>
From: richard.dorsch@gmail.com
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org,
	linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	lee.jones@linaro.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	wim@iguana.be,
	jo.sunga@advantech.com,
	Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Subject: [PATCH v3 5/6] Add Advantech iManager Backlight driver
Date: Sun, 10 Jan 2016 15:31:14 -0800
Message-Id: <1452468675-5827-6-git-send-email-richard.dorsch@gmail.com>
In-Reply-To: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 drivers/video/backlight/Kconfig          |  12 ++
 drivers/video/backlight/Makefile         |   2 +
 drivers/video/backlight/imanager-bl.c    | 198 +++++++++++++++++++++++++++++++
 drivers/video/backlight/imanager-ec-bl.c | 118 ++++++++++++++++++
 include/linux/mfd/imanager/backlight.h   |  37 ++++++
 5 files changed, 367 insertions(+)
 create mode 100644 drivers/video/backlight/imanager-bl.c
 create mode 100644 drivers/video/backlight/imanager-ec-bl.c
 create mode 100644 include/linux/mfd/imanager/backlight.h

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 5ffa4b4..8003573 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -251,6 +251,18 @@ config BACKLIGHT_HP700
 	  If you have an HP Jornada 700 series,
 	  say Y to include backlight control driver.
 
+config BACKLIGHT_IMANAGER
+	tristate "Advantech iManager backlight/brightness"
+	depends on MFD_IMANAGER
+	help
+	  This enables support for Advantech iManager Backlight and
+	  Brightness control of some Advantech SOM, MIO, AIMB, and
+	  PCM modules/boards.
+	  Requires mfd-core and imanager-core to function properly.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called imanager_bl.
+
 config BACKLIGHT_CARILLO_RANCH
 	tristate "Intel Carillo Ranch Backlight Driver"
 	depends on LCD_CLASS_DEVICE && PCI && X86 && FB_LE80578
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 16ec534..15bf136 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -26,6 +26,8 @@ obj-$(CONFIG_BACKLIGHT_ADP8870)		+= adp8870_bl.o
 obj-$(CONFIG_BACKLIGHT_APPLE)		+= apple_bl.o
 obj-$(CONFIG_BACKLIGHT_AS3711)		+= as3711_bl.o
 obj-$(CONFIG_BACKLIGHT_BD6107)		+= bd6107.o
+imanager_bl-objs			:= imanager-bl.o imanager-ec-bl.o
+obj-$(CONFIG_BACKLIGHT_IMANAGER)	+= imanager_bl.o
 obj-$(CONFIG_BACKLIGHT_CARILLO_RANCH)	+= cr_bllcd.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE)	+= backlight.o
 obj-$(CONFIG_BACKLIGHT_DA903X)		+= da903x_bl.o
diff --git a/drivers/video/backlight/imanager-bl.c b/drivers/video/backlight/imanager-bl.c
new file mode 100644
index 0000000..9950fec
--- /dev/null
+++ b/drivers/video/backlight/imanager-bl.c
@@ -0,0 +1,198 @@
+/*
+ * Advantech iManager Backlight driver
+ * Partially derived from wm831x_bl
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
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/backlight.h>
+#include <linux/fb.h>
+#include <linux/pwm.h>
+#include <linux/mfd/imanager/core.h>
+#include <linux/mfd/imanager/backlight.h>
+
+#define BL_MAX_BRIGHTNESS	100
+
+static bool polarity = PWM_POLARITY_NORMAL;
+module_param(polarity, bool, 0);
+MODULE_PARM_DESC(polarity, "Select backlight polarity (inverted := 1)");
+
+static ushort unit = UNIT_1;
+module_param(unit, ushort, 0);
+MODULE_PARM_DESC(unit, "Select backlight control unit [0, 1] (defaults to 0)");
+
+struct imanager_backlight_data {
+	struct imanager_device_data *idev;
+	struct backlight_device *bl;
+};
+
+static int get_brightness(struct backlight_device *dev)
+{
+	struct imanager_backlight_data *data = bl_get_data(dev);
+	int ret;
+
+	mutex_lock(&data->idev->lock);
+
+	ret = bl_core_get_pulse_width(unit);
+	/* Reverse percentage if polarity is set */
+	if (polarity)
+		ret = 100 - ret;
+
+	mutex_unlock(&data->idev->lock);
+
+	return ret;
+}
+
+static int set_brightness(struct backlight_device *dev)
+{
+	struct imanager_backlight_data *data = bl_get_data(dev);
+	u8 brightness = (u8) dev->props.brightness;
+	int ret;
+
+	if (brightness > BL_MAX_BRIGHTNESS)
+		return -EINVAL;
+
+	if (dev->props.power != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	if (dev->props.fb_blank != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	if (dev->props.state & BL_CORE_SUSPENDED)
+		brightness = 0;
+
+	mutex_lock(&data->idev->lock);
+
+	/* Inversed percentage if polarity is set */
+	if (polarity)
+		brightness = 100 - brightness;
+	ret = bl_core_set_pulse_width(unit, brightness);
+
+	mutex_unlock(&data->idev->lock);
+
+	return ret;
+}
+
+static const struct backlight_ops imanager_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.get_brightness = get_brightness,
+	.update_status  = set_brightness,
+};
+
+static int imanager_backlight_init(struct device *dev,
+				   struct imanager_backlight_data *data)
+{
+	struct backlight_device *bd;
+	struct backlight_properties props;
+
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_PLATFORM;
+	props.max_brightness = BL_MAX_BRIGHTNESS;
+	bd = backlight_device_register("imanager_backlight", dev, data,
+					&imanager_bl_ops, &props);
+
+	if (IS_ERR(bd)) {
+		data->bl = NULL;
+		dev_err(dev, "Unable to register backlight device\n");
+		return PTR_ERR(bd);
+	}
+
+	data->bl = bd;
+
+	bd->props.brightness = get_brightness(bd);
+	bd->props.power = FB_BLANK_UNBLANK;
+	backlight_update_status(bd);
+
+	return 0;
+}
+
+static int imanager_backlight_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_device_data *idev = dev_get_drvdata(dev->parent);
+	struct imanager_backlight_data *data;
+	int ret;
+
+	if (!idev) {
+		dev_err(dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
+
+	ret = bl_core_init();
+	if (ret) {
+		dev_err(dev, "Failed to initialize backlight core\n");
+		return -EIO;
+	}
+
+	ret = bl_core_set_state(unit, BL_CTRL_ENABLE);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable backlight control (%d)\n",
+				unit);
+		return -EIO;
+	}
+
+	if (polarity)
+		ret = bl_core_set_polarity(PWM_POLARITY_INVERSED);
+	else
+		ret = bl_core_set_polarity(PWM_POLARITY_NORMAL);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set backlight polarity\n");
+		return -EIO;
+	}
+
+	/* init brightness to 60% */
+	bl_core_set_pulse_width(unit, 60);
+
+	data = devm_kzalloc(dev, sizeof(struct imanager_backlight_data),
+			GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->idev = idev;
+
+	ret = imanager_backlight_init(dev, data);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int imanager_backlight_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_backlight_data *data = dev_get_drvdata(dev);
+
+	backlight_device_unregister(data->bl);
+
+	return 0;
+}
+
+static struct platform_driver imanager_backlight_driver = {
+	.driver = {
+		.name	= "imanager_backlight",
+	},
+	.probe	= imanager_backlight_probe,
+	.remove	= imanager_backlight_remove,
+};
+
+module_platform_driver(imanager_backlight_driver);
+
+MODULE_DESCRIPTION("Advantech iManager Backlight driver");
+MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imanager_backlight");
diff --git a/drivers/video/backlight/imanager-ec-bl.c b/drivers/video/backlight/imanager-ec-bl.c
new file mode 100644
index 0000000..04d2478
--- /dev/null
+++ b/drivers/video/backlight/imanager-ec-bl.c
@@ -0,0 +1,118 @@
+/*
+ * Advantech iManager Backlight/Brightness Core
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
+#include <linux/mfd/imanager/backlight.h>
+
+struct brightness_level {
+	u32	value	: 7,	/* Brightness Value  - LSB [6..0] */
+		enable	: 1;	/* Brightness Enable - MSB [7] */
+};
+
+struct backlight_ctrl {
+	u32	enable	: 1,	/* Backlight Control Enable - LSB [0] */
+		pwmpol	: 1,	/* PWM Polarity		    - bit [1] */
+		blpol	: 1,	/* Backlight Polarity	    - bit [2] */
+		dnc	: 5;	/* Don't care		    - bit [7..3] */
+};
+
+static const struct imanager_backlight_device *bl;
+
+int bl_core_get_pulse_width(u32 unit)
+{
+	int ret;
+
+	if (WARN_ON(unit >= EC_BLC_MAX_NUM))
+		return -EINVAL;
+
+	ret = imanager_read_byte(EC_CMD_HWP_RD, bl->attr[unit].did);
+	if (ret < 0)
+		pr_err("Failed reading PWM (unit=%d)\n", unit);
+
+	return ret;
+}
+
+int bl_core_set_pulse_width(u32 unit, u32 pwm)
+{
+	int ret;
+
+	if (WARN_ON(unit >= EC_BLC_MAX_NUM))
+		return -EINVAL;
+
+	pwm = pwm > 100 ? 100 : pwm;
+
+	ret = imanager_write_byte(EC_CMD_HWP_WR, bl->attr[unit].did, pwm);
+	if (ret < 0)
+		pr_err("Failed writing PWM (val=%d, unit=%d)\n", pwm, unit);
+
+	return ret;
+}
+
+int bl_core_set_state(u32 unit, bool enable)
+{
+	int ret;
+	u8 val8;
+	struct brightness_level *pl = (struct brightness_level *)&val8;
+
+	if (WARN_ON(unit >= EC_BLC_MAX_NUM))
+		return -EINVAL;
+
+	ret = imanager_acpiram_read_byte(bl->brightness[unit]);
+	if (ret < 0)
+		return ret;
+	val8 = ret;
+
+	pl->enable = enable ? 1 : 0;
+
+	ret = imanager_acpiram_write_byte(bl->attr[unit].did, val8);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int bl_core_set_polarity(u32 polarity)
+{
+	int ret;
+	u8 val8;
+	struct backlight_ctrl *ctrl = (struct backlight_ctrl *)&val8;
+
+	ret = imanager_acpiram_read_byte(EC_ACPIRAM_BLC_CTRL);
+	if (ret < 0)
+		return ret;
+	val8 = ret;
+
+	ctrl->blpol = polarity ? 1 : 0;
+
+	ret = imanager_acpiram_write_byte(EC_ACPIRAM_BLC_CTRL, val8);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int bl_core_init(void)
+{
+	bl = imanager_get_backlight_device();
+	if (!bl)
+		return -ENODEV;
+
+	return 0;
+}
+
diff --git a/include/linux/mfd/imanager/backlight.h b/include/linux/mfd/imanager/backlight.h
new file mode 100644
index 0000000..93ea7cf5
--- /dev/null
+++ b/include/linux/mfd/imanager/backlight.h
@@ -0,0 +1,37 @@
+/*
+ * Advantech iManager Backlight core
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
+#ifndef __BACKLIGHT_H__
+#define __BACKLIGHT_H__
+
+#include <linux/types.h>
+
+enum backlight_control {
+	BL_CTRL_DISABLE,
+	BL_CTRL_ENABLE,
+};
+
+enum backlight_unit {
+	UNIT_1,
+	UNIT_2,
+};
+
+int bl_core_init(void);
+
+int bl_core_set_state(u32 unit, bool enable);
+
+int bl_core_set_polarity(u32 polarity);
+
+int bl_core_get_pulse_width(u32 unit);
+int bl_core_set_pulse_width(u32 unit, u32 pwm);
+
+#endif
-- 
2.7.0
