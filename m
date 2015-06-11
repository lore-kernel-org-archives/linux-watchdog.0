Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34499 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359AbbFKUtY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Jun 2015 16:49:24 -0400
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sameo@linux.intel.com, lee.jones@linaro.org, wsa@the-dreams.de,
	jdelvare@suse.de, linux-i2c@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, jingoohan1@gmail.com,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 4/4] backlight: Add Congatec CGEB backlight driver
Date: Thu, 11 Jun 2015 22:48:54 +0200
Message-Id: <1434055734-3602-5-git-send-email-christian.gmeiner@gmail.com>
In-Reply-To: <1434055734-3602-1-git-send-email-christian.gmeiner@gmail.com>
References: <1434055734-3602-1-git-send-email-christian.gmeiner@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver provides support for the CGEB backlight found on some
Congatec x86 modules.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/video/backlight/Kconfig            |   7 ++
 drivers/video/backlight/Makefile           |   1 +
 drivers/video/backlight/congatec-cgeb_bl.c | 125 +++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/video/backlight/congatec-cgeb_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 2d9923a..35e4913 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -451,6 +451,13 @@ config BACKLIGHT_BD6107
 	help
 	  If you have a Rohm BD6107 say Y to enable the backlight driver.
 
+config BACKLIGHT_CONGATEC_CGEB
+	tristate "Congatec CGEB Backlight driver"
+	depends on MFD_CONGATEC_CGEB
+	help
+	  This driver provides support for the backlight accssable via
+	  the Congatec CGEB interface found on Congatec boards.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endif # BACKLIGHT_LCD_SUPPORT
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index d67073f..5654d6a 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_BACKLIGHT_AS3711)		+= as3711_bl.o
 obj-$(CONFIG_BACKLIGHT_BD6107)		+= bd6107.o
 obj-$(CONFIG_BACKLIGHT_CARILLO_RANCH)	+= cr_bllcd.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE)	+= backlight.o
+obj-$(CONFIG_BACKLIGHT_CONGATEC_CGEB)	+= congatec-cgeb_bl.o
 obj-$(CONFIG_BACKLIGHT_DA903X)		+= da903x_bl.o
 obj-$(CONFIG_BACKLIGHT_DA9052)		+= da9052_bl.o
 obj-$(CONFIG_BACKLIGHT_EP93XX)		+= ep93xx_bl.o
diff --git a/drivers/video/backlight/congatec-cgeb_bl.c b/drivers/video/backlight/congatec-cgeb_bl.c
new file mode 100644
index 0000000..4e5f97e
--- /dev/null
+++ b/drivers/video/backlight/congatec-cgeb_bl.c
@@ -0,0 +1,125 @@
+/*
+ * CGEB backlight driver
+ *
+ * (c) 2012 Christian Gmeiner <christian.gmeiner@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/backlight.h>
+#include <linux/mfd/congatec-cgeb.h>
+
+struct cgeb_backlight_data {
+	struct cgeb_board_data          *board;
+	int unit;
+};
+
+static int cgeb_backlight_update_status(struct backlight_device *bl)
+{
+	struct cgeb_backlight_data *data = bl_get_data(bl);
+	struct cgeb_function_parameters fps;
+	int brightness = bl->props.brightness;
+	int err;
+
+	memset(&fps, 0, sizeof(fps));
+	
+	fps.unit = data->unit;
+	fps.pars[0] = brightness;
+	
+	err = cgeb_call(data->board, &fps, CgebVgaSetBacklight);
+	return err;
+}
+
+static int cgeb_backlight_get_brightness(struct backlight_device *bl)
+{
+	struct cgeb_backlight_data *data = bl_get_data(bl);
+	unsigned long brightness;
+
+	cgeb_call_simple(data->board, CgebVgaGetBacklight, 0, NULL, &brightness);
+
+	return brightness;
+}
+
+static const struct backlight_ops cgeb_backlight_ops = {
+	.update_status	= cgeb_backlight_update_status,
+	.get_brightness	= cgeb_backlight_get_brightness,
+};
+
+static int cgeb_backlight_probe(struct platform_device *pdev)
+{  
+	struct backlight_device *bl;
+	struct backlight_properties props;
+	struct cgeb_backlight_data *data;
+	struct cgeb_pdata *pdata = pdev->dev.platform_data;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->unit = pdata->unit;
+	data->board = pdata->board;
+
+	props.max_brightness = 100;
+	props.brightness = 100;
+	props.type = BACKLIGHT_RAW;
+	
+	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, data,
+					&cgeb_backlight_ops, &props);
+	if (IS_ERR(bl)) {
+		dev_err(&pdev->dev, "failed to register backlight\n");
+		ret = PTR_ERR(bl);
+		goto error_backlight_device_register;
+	}
+
+	platform_set_drvdata(pdev, bl);
+	
+	dev_info(&pdev->dev, "registered\n");
+	return 0;
+	
+error_backlight_device_register:
+	kfree(data);
+	return ret;
+};
+
+static int cgeb_backlight_remove(struct platform_device *pdev)
+{
+	struct backlight_device *bl = platform_get_drvdata(pdev);
+	struct cgeb_backlight_data *data = bl_get_data(bl);
+	struct cgeb_function_parameters fps;
+
+	backlight_device_unregister(bl);
+
+	/* on module unload set brightness to 100% */
+	memset(&fps, 0, sizeof(fps));
+	fps.unit = data->unit;
+	fps.pars[0] = 100;
+	cgeb_call(data->board, &fps, CgebVgaSetBacklight);
+
+	kfree(data);
+	return 0;
+}
+
+static struct platform_driver cgeb_backlight_driver = {
+	.probe          = cgeb_backlight_probe,
+	.remove         = __exit_p(cgeb_backlight_remove),
+	.driver = {
+	        .name   = "cgeb-backlight",
+	        .owner  = THIS_MODULE,
+	},
+};
+
+module_platform_driver(cgeb_backlight_driver);
+
+MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
+MODULE_DESCRIPTION("cgeb backlight driver");
+MODULE_LICENSE("GPL");
-- 
2.4.2

