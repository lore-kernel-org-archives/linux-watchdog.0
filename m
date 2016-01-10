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
Subject: [PATCH v3 1/6] Add Advantech iManager MFD core driver
Date: Sun, 10 Jan 2016 15:31:10 -0800
Message-Id: <1452468675-5827-2-git-send-email-richard.dorsch@gmail.com>
In-Reply-To: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

This patch adds Advantech iManager Embedded Controller MFD core driver.
This mfd core dirver provides an interface to GPIO, I2C, HWmon,
Watchdog, and Backlight/Brightness control.

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 Documentation/devicetree/bindings/mfd/imanager.txt |   33 +
 MAINTAINERS                                        |   13 +
 drivers/mfd/Kconfig                                |   20 +
 drivers/mfd/Makefile                               |    2 +
 drivers/mfd/imanager-core.c                        |  287 +++++
 drivers/mfd/imanager-ec.c                          | 1345 ++++++++++++++++++++
 include/linux/mfd/imanager/core.h                  |   31 +
 include/linux/mfd/imanager/ec.h                    |  210 +++
 8 files changed, 1941 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/imanager.txt
 create mode 100644 drivers/mfd/imanager-core.c
 create mode 100644 drivers/mfd/imanager-ec.c
 create mode 100644 include/linux/mfd/imanager/core.h
 create mode 100644 include/linux/mfd/imanager/ec.h

diff --git a/Documentation/devicetree/bindings/mfd/imanager.txt b/Documentation/devicetree/bindings/mfd/imanager.txt
new file mode 100644
index 0000000..bf58a96
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/imanager.txt
@@ -0,0 +1,33 @@
+Note
+====
+
+This is a set of platform drivers which provide support for multiple
+embedded features such as GPIO, I2C/SMBus, Hardware Monitoring, Watchdog,
+and Backlight/Brightness control. Those features are available on Advantech
+Embedded boards such as SOM, MIO, AIMB, and PCM.
+Datasheets of each product line can be downloaded from www.advantech.com
+
+Author:
+	Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+
+
+Kernel driver imanager
+======================
+
+This driver provides a communication layer to the Advantech iManager EC
+firmware which is factory loaded onto ITE IT8518/28 chips. The type of
+communication is message based. Clients (gpio, i2c, hwmon etc. drivers)
+request data from Advantech iManager (polling, not interrupt driven). If
+a response is been received within a time frame, the data is been extracted
+from the message and then passed to the caller (clients).
+
+  Supported chips:
+  * Advantech EC based on ITE IT8518
+    Prefix: imanager
+    Addresses: 0x029e/0x029f
+    Datasheet: Available from ITE upon request
+  * Advantech EC based on ITE IT8528
+    Prefix: imanager
+    Addresses: 0x0299/0x29a
+    Datasheet: Available from ITE upon request
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 233f834..8d25fdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5391,6 +5391,19 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
 S:	Maintained
 F:	drivers/usb/atm/ueagle-atm.c
 
+IMANAGER ADVANTECH EC DRIVER
+M:	Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/imanager.txt
+F:	Documentation/hwmon/imanager
+F:	Documentation/i2c/busses/i2c-imanager
+F:	drivers/mfd/imanager-core.c
+F:	drivers/gpio/imanager-gpio.c
+F:	drivers/hwmon/imanager-hwmon.c
+F:	drivers/i2c/busses/imanager-i2c.c
+F:	drivers/video/backlight/imanager-bl.c
+F:	drivers/watchdog/imanager-wdt.c
+
 INA209 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	lm-sensors@lm-sensors.org
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4d92df6..4dc7c13 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -322,6 +322,26 @@ config MFD_INTEL_QUARK_I2C_GPIO
 	  their respective IO driver.
 	  The GPIO exports a total amount of 8 interrupt-capable GPIOs.
 
+config MFD_IMANAGER
+	tristate "Advantech iManager Embedded Controller"
+	depends on PCI
+	depends on X86
+	select MFD_CORE
+	help
+	  This is the core driver for Advantech iManager EC as found on some
+	  Advantech SOM, MIO, AIMB, and PCM modules/boards. The EC may provide
+	  functions like GPIO, I2C interface, HW monitoring, Watchdog, and
+	  backlight/brightness control.
+
+	  The following Advantech boards are supported:
+		* All SOM modules newer than SOM-5788
+		* MIO-5250/5251/5270/5271 and newer
+		* PCM-9388
+		* AIMB-274/231
+
+	  This driver can also be built as a module. If so, the module
+	  will be called imanager.
+
 config LPC_ICH
 	tristate "Intel ICH LPC"
 	depends on PCI
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a8b76b8..c9c63d9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -142,6 +142,8 @@ obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
 obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
 obj-$(CONFIG_MFD_TIMBERDALE)    += timberdale.o
 obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
+imanager-objs			:= imanager-core.o imanager-ec.o
+obj-$(CONFIG_MFD_IMANAGER)	+= imanager.o
 obj-$(CONFIG_MFD_KEMPLD)	+= kempld-core.o
 obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
 obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
diff --git a/drivers/mfd/imanager-core.c b/drivers/mfd/imanager-core.c
new file mode 100644
index 0000000..d573ecb
--- /dev/null
+++ b/drivers/mfd/imanager-core.c
@@ -0,0 +1,287 @@
+/*
+ * Advantech iManager MFD core driver
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
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/imanager/core.h>
+#include <linux/mfd/imanager/ec.h>
+
+static struct platform_device *pdev;
+
+enum imanager_cells {
+	IMANAGER_BL,
+	IMANAGER_GPIO,
+	IMANAGER_HWMON,
+	IMANAGER_I2C,
+	IMANAGER_WDT,
+};
+
+static const char * const chip_names[] = {
+	"it8516",
+	"it8518",
+	"it8528",
+	NULL
+};
+
+static struct resource imanager_ioresource = {
+	.start  = IT8516_DAT_PORT,
+	.end    = IT8518_DAT_PORT,
+	.flags  = IORESOURCE_IO,
+};
+
+/*
+ * Devices which are part of the iManager and are available via firmware.
+ */
+static struct mfd_cell imanager_devs[] = {
+	[IMANAGER_BL] = {
+		.name = "imanager_backlight",
+	},
+	[IMANAGER_GPIO] = {
+		.name = "imanager_gpio",
+	},
+	[IMANAGER_HWMON] = {
+		.name = "imanager_hwmon",
+	},
+	[IMANAGER_I2C] = {
+		.name = "imanager_i2c",
+	},
+	[IMANAGER_WDT] = {
+		.name = "imanager_wdt",
+	},
+};
+
+const char *project_type_to_str(int type)
+{
+	const char *version_type;
+
+	switch (type) {
+	case 'V':
+		version_type = "Release";
+		break;
+	case 'X':
+		version_type = "Engineering Sample";
+		break;
+	case 'A' ... 'U':
+		version_type = "Custom";
+		break;
+	default:
+		version_type = "Unknown";
+		break;
+	}
+
+	return version_type;
+}
+
+static ssize_t imanager_name_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct imanager_platform_data *pdata = dev_get_platdata(dev);
+	const struct ec_info *info = &pdata->dev->info;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", info->pcb_name);
+}
+
+static ssize_t imanager_kversion_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct imanager_platform_data *pdata = dev_get_platdata(dev);
+	const struct ec_info *info = &pdata->dev->info;
+
+	return scnprintf(buf, PAGE_SIZE, "%d.%d\n",
+			 info->version.kernel_major,
+			 info->version.kernel_minor);
+}
+
+static ssize_t imanager_fwversion_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct imanager_platform_data *pdata = dev_get_platdata(dev);
+	const struct ec_info *info = &pdata->dev->info;
+
+	return scnprintf(buf, PAGE_SIZE, "%d.%d\n",
+			 info->version.firmware_major,
+			 info->version.firmware_minor);
+}
+
+static ssize_t imanager_type_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct imanager_platform_data *pdata = dev_get_platdata(dev);
+	const struct ec_info *info = &pdata->dev->info;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			project_type_to_str(info->version.type));
+}
+
+static ssize_t imanager_chip_name_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct imanager_platform_data *pdata = dev_get_platdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", pdata->chip_name);
+}
+
+static DEVICE_ATTR(imanager_name, S_IRUGO, imanager_name_show, NULL);
+static DEVICE_ATTR(imanager_kversion, S_IRUGO, imanager_kversion_show, NULL);
+static DEVICE_ATTR(imanager_fwversion, S_IRUGO, imanager_fwversion_show, NULL);
+static DEVICE_ATTR(imanager_type, S_IRUGO, imanager_type_show, NULL);
+static DEVICE_ATTR(imanager_chip_name, S_IRUGO, imanager_chip_name_show, NULL);
+
+static struct attribute *imanager_core_attributes[] = {
+	&dev_attr_imanager_name.attr,
+	&dev_attr_imanager_kversion.attr,
+	&dev_attr_imanager_fwversion.attr,
+	&dev_attr_imanager_type.attr,
+	&dev_attr_imanager_chip_name.attr,
+	NULL
+};
+
+static const struct attribute_group imanager_core_attr_group = {
+	.attrs = imanager_core_attributes,
+};
+
+static int imanager_platform_create(void)
+{
+	struct device *dev;
+	struct imanager_platform_data platdata;
+	int err;
+
+	pdev = platform_device_alloc("imanager-core", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	dev = &pdev->dev;
+
+	err = platform_device_add_data(pdev, &platdata, sizeof(platdata));
+	if (err)
+		goto exit_device_put;
+
+	err = platform_device_add_resources(pdev, &imanager_ioresource, 1);
+	if (err)
+		goto exit_device_put;
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto exit_device_put;
+
+	err = mfd_add_devices(dev, pdev->id, imanager_devs,
+		ARRAY_SIZE(imanager_devs), NULL, -1, NULL);
+	if (err)
+		goto exit_device_unregister;
+
+	return 0;
+
+exit_device_unregister:
+	platform_device_unregister(pdev);
+exit_device_put:
+	platform_device_put(pdev);
+
+	return err;
+}
+
+static int imanager_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_platform_data *pdata = dev_get_platdata(dev);
+	struct imanager_device_data *imanager;
+	int ret;
+
+	if (!pdev)
+		return -EINVAL;
+
+	imanager = devm_kzalloc(dev, sizeof(*imanager), GFP_KERNEL);
+	if (!imanager)
+		return -ENOMEM;
+
+	imanager->dev = dev;
+	mutex_init(&imanager->lock);
+
+	platform_set_drvdata(pdev, imanager);
+
+	pdata->dev = imanager_get_ec_device();
+	pdata->chip_name = chip_names[pdata->dev->id];
+
+	dev_info(dev, "Found Advantech iManager %s - %s %d.%d/%d.%d (%s)\n",
+		 pdata->chip_name,
+		 pdata->dev->info.pcb_name,
+		 pdata->dev->info.version.kernel_major,
+		 pdata->dev->info.version.kernel_minor,
+		 pdata->dev->info.version.firmware_major,
+		 pdata->dev->info.version.firmware_minor,
+		 project_type_to_str(pdata->dev->info.version.type));
+
+	ret = sysfs_create_group(&dev->kobj, &imanager_core_attr_group);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int imanager_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	sysfs_remove_group(&dev->kobj, &imanager_core_attr_group);
+
+	mfd_remove_devices(dev);
+
+	return 0;
+}
+
+static struct platform_driver imanager_driver = {
+	.driver = {
+		.name  = "imanager-core",
+	},
+	.probe	= imanager_probe,
+	.remove	= imanager_remove,
+};
+
+static int __init imanager_init(void)
+{
+	int ret;
+
+	ret = imanager_ec_probe();
+	if (ret < 0)
+		return ret;
+
+	ret = imanager_platform_create();
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&imanager_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void __exit imanager_exit(void)
+{
+	if (pdev)
+		platform_device_unregister(pdev);
+
+	platform_driver_unregister(&imanager_driver);
+}
+
+module_init(imanager_init);
+module_exit(imanager_exit);
+
+MODULE_DESCRIPTION("Advantech iManager Core Driver");
+MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imanager-core");
diff --git a/drivers/mfd/imanager-ec.c b/drivers/mfd/imanager-ec.c
new file mode 100644
index 0000000..be554ba
--- /dev/null
+++ b/drivers/mfd/imanager-ec.c
@@ -0,0 +1,1345 @@
+/*
+ * Advantech iManager Core - Firmware Interface
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
+#include <linux/module.h>
+#include <linux/swab.h>
+#include <linux/mfd/imanager/ec.h>
+
+/**
+ * This is the delay time between two EC transactions.
+ * Values lower than 200us are not encouraged and may
+ * cause I/O errors
+ */
+#define EC_MICRO_DELAY			200
+#define EC_MAX_RETRY			1000
+
+#define EC_MSG_OFFSET_CMD		0UL
+#define EC_MSG_OFFSET_STATUS		1UL
+#define EC_MSG_OFFSET_PARAM		2UL
+#define EC_MSG_OFFSET_DATA(N)		(3UL + N)
+#define EC_MSG_OFFSET_PAYLOAD(N)	(7UL + N)
+
+/* The Device ID registers - 16 bit */
+#define DEVID_REG_MSB			0x20
+#define DEVID_REG_LSB			0x21
+
+/*
+ * IT8528 based firmware require a read/write command offset.
+ */
+#define EC_CMD_OFFSET_READ		0xA0UL
+#define EC_CMD_OFFSET_WRITE		0x50UL
+
+#define EC_STATUS_SUCCESS		BIT(0)
+#define EC_STATUS_CMD_COMPLETE		BIT(7)
+
+#define PCB_NAME_MAX_SIZE		8UL
+#define EC_I2C_BLOCK_SIZE		32
+#define EC_MAX_DID			32UL
+
+#define DID_LABEL_SIZE			24UL
+#define DID_DESC_SIZE			32UL
+
+#define EC_KERNEL_MINOR(x)		(LOBYTE16(x))
+#define EC_KERNEL_MAJOR(x) ({		\
+	typeof(x) __x = (HIBYTE16(x));	\
+	((__x >> 4) * 10 + (__x & 0x000f)); })
+#define EC_FIRMWARE_MINOR(x)		(LOBYTE16(x))
+#define EC_FIRMWARE_MAJOR(x)		EC_KERNEL_MAJOR(x)
+#define EC_PROJECT_CODE(x)		((char)(LOBYTE16(x)))
+
+enum ec_device_type {
+	ADC = 1,
+	DAC,
+	GPIO,
+	IRQ,
+	PWM,
+	SMB,
+	TACH
+};
+
+enum ec_device_id {
+	/* GPIO */
+	ALTGPIO0	= 0x10,
+	ALTGPIO1,
+	ALTGPIO2,
+	ALTGPIO3,
+	ALTGPIO4,
+	ALTGPIO5,
+	ALTGPIO6,
+	ALTGPIO7,
+	/* Button (GPIO) */
+	BUTTON0,
+	BUTTON1,
+	BUTTON2,
+	BUTTON3,
+	BUTTON4,
+	BUTTON5,
+	BUTTON6,
+	BUTTON7,
+	/* FAN */
+	CPUFAN_2P,
+	CPUFAN_4P,
+	SYSFAN1_2P,
+	SYSFAN1_4P,
+	SYSFAN2_2P,
+	SYSFAN2_4P,
+	/* Brightness Control */
+	BRIGHTNESS,
+	/* System Speaker */
+	PCBEEP,
+	/* SMBus */
+	SMBOEM0,
+	SMBOEM1,
+	SMBOEM2,
+	SMBEEPROM,
+	SMBTHERMAL0,
+	SMBTHERMAL1,
+	SMBSECEEP,
+	I2COEM,
+	/* Speaker */
+	SPEAKER		= 0x30,
+	/* SMBus */
+	SMBEEP2K	= 0x38,
+	OEMEEP,
+	OEMEEP2K,
+	PECI,
+	SMBOEM3,
+	SMLINK,
+	SMBSLV,
+	/* LED */
+	POWERLED	= 0x40,
+	BATLEDG,
+	OEMLED0,
+	OEMLED1,
+	OEMLED2,
+	BATLEDR,
+	/* Smart Battery */
+	SMARTBAT1	= 0x48,
+	SMARTBAT2,
+	/* ADC */
+	CMOSBAT		= 0x50,
+	CMOSBATx2,
+	CMOSBATx10,
+	LIBAT,
+	LIBATx2,
+	LIBATx10,
+	ADC5VS0,
+	ADC5VS0x2,
+	ADC5VS0x10,
+	ADC5VS5,
+	ADC5VS5x2,
+	ADC5VS5x10,
+	ADC33VS0,
+	ADC33VS0x2,
+	ADC33VS0x10,
+	ADC33VS5,
+	ADC33VS5x2,	/* 0x60 */
+	ADC33VS5x10,
+	ADC12VS0,
+	ADC12VS0x2,
+	ADC12VS0x10,
+	VCOREA,
+	VCOREAx2,
+	VCOREAx10,
+	VCOREB,
+	VCOREBx2,
+	VCOREBx10,
+	ADCDC,
+	ADCDCx2,
+	ADCDCx10,
+	VSTBY,
+	VSTBYx2,
+	VSTBYx10,	/* 0x70 */
+	VAUX,
+	VAUXx2,
+	VAUXx10,
+	CURRENT,
+	/* Watchdog */
+	WDIRQ		= 0x78,
+	WDNMI,
+	/* FAN Tacho */
+	TACHO0		= 0x80,
+	TACHO1,
+	TACHO2,
+	/* Brightness/Backlight Control */
+	BRIGHTNESS2	= 0x88,
+	BACKLIGHT1,
+	BACKLIGHT2
+};
+
+enum ec_dynamic_table_type {
+	EC_DYN_DID,
+	EC_DYN_HWP,
+	EC_DYN_POL
+};
+
+struct ec_devtbl {
+	int id;
+	int type;
+	int scale;
+	const char label[DID_LABEL_SIZE];
+	const char description[DID_DESC_SIZE];
+};
+
+struct ec_dyn_devtbl {
+	int did;	/* Device ID */
+	int hwp;	/* Hardware Pin */
+	int pol;	/* Polarity */
+	const struct ec_devtbl *devtbl; /* Device table Entry */
+};
+
+struct imanager_data {
+	int (*read)(int cmd);
+	int (*write)(int cmd, int value);
+
+	struct ec_dyn_devtbl dyn[EC_MAX_DID];
+
+	struct imanager_ec_device		dev;
+	struct imanager_hwmon_device		sensors;
+	struct imanager_gpio_device		gpio;
+	struct imanager_i2c_device		i2c;
+	struct imanager_watchdog_device		wdt;
+	struct imanager_backlight_device	blc;
+};
+
+struct ec_version_raw {
+	u16	kernel,
+		chipid,
+		project_code,
+		firmware;
+};
+
+enum ec_ram_type {
+	EC_RAM_ACPI = 1,
+	EC_RAM_HW,
+	EC_RAM_EXT
+};
+
+static struct imanager_data ec;
+
+static const struct ec_devtbl devtbl[] = {
+	{ ALTGPIO0,	GPIO,	-1,	"gpio0" },
+	{ ALTGPIO1,	GPIO,	-1,	"gpio1" },
+	{ ALTGPIO2,	GPIO,	-1,	"gpio2" },
+	{ ALTGPIO3,	GPIO,	-1,	"gpio3" },
+	{ ALTGPIO4,	GPIO,	-1,	"gpio4" },
+	{ ALTGPIO5,	GPIO,	-1,	"gpio5" },
+	{ ALTGPIO6,	GPIO,	-1,	"gpio6" },
+	{ ALTGPIO7,	GPIO,	-1,	"gpio7" },
+	{ BUTTON0,	GPIO,	-1,	"button0" },
+	{ BUTTON1,	GPIO,	-1,	"button1" },
+	{ BUTTON2,	GPIO,	-1,	"button2" },
+	{ BUTTON3,	GPIO,	-1,	"button3" },
+	{ BUTTON4,	GPIO,	-1,	"button4" },
+	{ BUTTON5,	GPIO,	-1,	"button4" },
+	{ BUTTON6,	GPIO,	-1,	"button4" },
+	{ BUTTON7,	GPIO,	-1,	"button4" },
+	{ CPUFAN_2P,	PWM,	2,	"FAN CPU" },
+	{ CPUFAN_4P,	PWM,	4,	"FAN CPU" },
+	{ SYSFAN1_2P,	PWM,	2,	"FAN SYS1" },
+	{ SYSFAN1_4P,	PWM,	4,	"FAN SYS1" },
+	{ SYSFAN2_2P,	PWM,	2,	"FAN SYS2" },
+	{ SYSFAN2_4P,	PWM,	4,	"FAN SYS2" },
+	{ BRIGHTNESS,	PWM,	-1,	"Brightness1" },
+	{ PCBEEP,	PWM,	-1,	"Beep" },
+	{ SMBOEM0,	SMB,	-1,	"SMB1" },
+	{ SMBOEM1,	SMB,	-1,	"SMB2" },
+	{ SMBOEM2,	SMB,	-1,	"SMB3" },
+	{ SMBEEPROM,	SMB,	-1,	"SMBEEP" },
+	{ SMBTHERMAL0,	SMB,	-1,	"SMBTHERM0" },
+	{ SMBTHERMAL1,	SMB,	-1,	"SMBTHERM1" },
+	{ SMBSECEEP,	SMB,	-1,	"SMBSECEEP" },
+	{ I2COEM,	SMB,	-1,	"I2COEM" },
+	{ SPEAKER,	DAC,	-1,	"Speaker" },
+	{ SMBEEP2K,	SMB,	-1,	"SMBEEP2K" },
+	{ OEMEEP,	SMB,	-1,	"OEMEEP" },
+	{ OEMEEP2K,	SMB,	-1,	"OEMEEP2K" },
+	{ PECI,		SMB,	-1,	"SMB_PECI" },
+	{ SMBOEM3,	SMB,	-1,	"SMBOEM3" },
+	{ SMLINK,	SMB,	-1,	"SMLINK" },
+	{ SMBSLV,	SMB,	-1,	"SMBSLV" },
+	{ POWERLED,	GPIO,	-1,	"Power LED" },
+	{ BATLEDG,	GPIO,	-1,	"BATLEDG" },
+	{ OEMLED0,	GPIO,	-1,	"OEMLED0" },
+	{ OEMLED1,	GPIO,	-1,	"OEMLED1" },
+	{ OEMLED2,	GPIO,	-1,	"OEMLED2" },
+	{ BATLEDR,	GPIO,	-1,	"OEMLEDR" },
+	{ SMARTBAT1,	SMB,	-1,	"SmartBat1" },
+	{ SMARTBAT2,	SMB,	-1,	"SmartBat2" },
+	{ CMOSBAT,	ADC,	1,	"VBat" },
+	{ CMOSBATx2,	ADC,	2,	"VBat" },
+	{ CMOSBATx10,	ADC,	10,	"VBat" },
+	{ LIBAT,	ADC,	1,	"VBat2" },
+	{ LIBATx2,	ADC,	2,	"VBat2" },
+	{ LIBATx10,	ADC,	10,	"VBat2" },
+	{ ADC5VS0,	ADC,	1,	"+5V" },
+	{ ADC5VS0x2,	ADC,	2,	"+5V" },
+	{ ADC5VS0x10,	ADC,	10,	"+5V" },
+	{ ADC5VS5,	ADC,	1,	"+5V" },
+	{ ADC5VS5x2,	ADC,	2,	"+5V" },
+	{ ADC5VS5x10,	ADC,	10,	"+5V" },
+	{ ADC33VS0,	ADC,	1,	"+3.3V" },
+	{ ADC33VS0x2,	ADC,	2,	"+3.3V" },
+	{ ADC33VS0x10,	ADC,	10,	"+3.3V" },
+	{ ADC33VS5,	ADC,	1,	"+3.3V" },
+	{ ADC33VS5x2,	ADC,	2,	"+3.3V" },
+	{ ADC33VS5x10,	ADC,	10,	"+3.3V" },
+	{ ADC12VS0,	ADC,	1,	"+12V" },
+	{ ADC12VS0x2,	ADC,	2,	"+12V" },
+	{ ADC12VS0x10,	ADC,	10,	"+12V" },
+	{ VCOREA,	ADC,	1,	"VCore" },
+	{ VCOREAx2,	ADC,	2,	"VCore" },
+	{ VCOREAx10,	ADC,	10,	"VCore" },
+	{ VCOREB,	ADC,	1,	"VCore2" },
+	{ VCOREBx2,	ADC,	2,	"VCore2" },
+	{ VCOREBx10,	ADC,	10,	"VCore2" },
+	{ ADCDC,	ADC,	1,	"ADCDC" },
+	{ ADCDCx2,	ADC,	2,	"ADCDCx2" },
+	{ ADCDCx10,	ADC,	10,	"ADCDCx10" },
+	{ VSTBY,	ADC,	1,	"Vsb" },
+	{ VSTBYx2,	ADC,	2,	"Vsb" },
+	{ VSTBYx10,	ADC,	10,	"Vsb" },
+	{ VAUX,		ADC,	1,	"VAUX" },
+	{ VAUXx2,	ADC,	2,	"VAUX" },
+	{ VAUXx10,	ADC,	10,	"VAUX" },
+	{ CURRENT,	ADC,	1,	"Imon" },
+	{ WDIRQ,	IRQ,	-1,	"WDIRQ" },
+	{ WDNMI,	GPIO,	-1,	"WDNMI" },
+	{ TACHO0,	TACH,	-1,	"Tacho1" },
+	{ TACHO1,	TACH,	-1,	"Tacho2" },
+	{ TACHO2,	TACH,	-1,	"Tacho3" },
+	{ BRIGHTNESS2,	PWM,	-1,	"Brightness2" },
+	{ BACKLIGHT1,	GPIO,	-1,	"Backlight1" },
+	{ BACKLIGHT2,	GPIO,	-1,	"Backlight2" },
+	{ 0, 0, 0, "" }
+};
+
+/**
+ * EC I/O
+ */
+
+static inline void imanager_delay(void)
+{
+	udelay(EC_MICRO_DELAY);
+}
+
+static int wait_ibf_cleared(void)
+{
+	int i = 0;
+
+	do {
+		if (!(inb(IT8516_CMD_PORT) & BIT(1)))
+			return 0;
+		imanager_delay();
+	} while (i++ < EC_MAX_RETRY);
+
+	return -ETIME;
+}
+
+static int wait_obf_set(void)
+{
+	int i = 0;
+
+	do {
+		if (inb(IT8516_CMD_PORT) & BIT(0))
+			return 0;
+		imanager_delay();
+	} while (i++ < EC_MAX_RETRY);
+
+	return -ETIME;
+}
+
+static inline int ec_inb(int addr, int reg)
+{
+	outb(reg, addr);
+	return inb(addr + 1);
+}
+
+static inline void ec_outb(int addr, int reg, int val)
+{
+	outb(reg, addr);
+	outb(val, addr + 1);
+}
+
+static inline int ec_io28_inb(int addr, int reg)
+{
+	int ret;
+
+	ret = wait_ibf_cleared();
+	if (ret)
+		return ret;
+
+	/* clear data to prevent lock */
+	inb(addr - 1);
+
+	outb(reg, addr);
+
+	ret = wait_obf_set();
+	if (ret)
+		return ret;
+
+	return inb(addr - 1);
+}
+
+static inline int ec_io28_outb(int addr, int reg, int val)
+{
+	int ret;
+
+	ret = wait_ibf_cleared();
+	if (ret)
+		return ret;
+
+	outb(reg, addr);
+
+	ret = wait_ibf_cleared();
+	if (ret)
+		return ret;
+
+	outb(val, addr - 1);
+
+	return 0;
+}
+
+static int ec_io18_read(int cmd)
+{
+	return ec_inb(IT8518_CMD_PORT, cmd);
+}
+
+static int ec_io18_write(int cmd, int value)
+{
+	ec_outb(IT8518_CMD_PORT, cmd, value);
+
+	return 0;
+}
+
+static int ec_io28_read(int cmd)
+{
+	return ec_io28_inb(IT8516_CMD_PORT, cmd + EC_CMD_OFFSET_READ);
+}
+
+static int ec_io28_write(int cmd, int value)
+{
+	return ec_io28_outb(IT8516_CMD_PORT, cmd + EC_CMD_OFFSET_WRITE, value);
+}
+
+/* Prevent FW lock */
+static void ec_clear_ports(void)
+{
+	inb(IT8516_DAT_PORT);
+	inb(IT8518_DAT_PORT);
+}
+
+static inline u16 ec_read_chipid(u16 addr)
+{
+	return (ec_inb(addr, DEVID_REG_MSB) << 8 |
+		ec_inb(addr, DEVID_REG_LSB));
+}
+
+static int ec_wait_cmd_clear(void)
+{
+	int i = 0;
+
+	do {
+		if (!ec.read(0))
+			return 0;
+		imanager_delay();
+	} while (i++ < EC_MAX_RETRY);
+
+	pr_err("No respons from EC (timeout)\n");
+
+	return -ETIME;
+}
+
+static int ec_read_ram(u8 bank, u8 offset, u8 len, u8 *buf, u8 bufsz)
+{
+	int i;
+	int ret;
+
+	if (WARN_ON(!buf))
+		return -EINVAL;
+
+	ret = ec_wait_cmd_clear();
+	if (ret)
+		return ret;
+
+	ec.write(EC_MSG_OFFSET_PARAM, bank);
+	ec.write(EC_MSG_OFFSET_DATA(0), offset);
+	ec.write(EC_MSG_OFFSET_DATA(0x2C), len);
+	ec.write(EC_MSG_OFFSET_CMD, EC_CMD_RAM_RD);
+
+	ret = ec_wait_cmd_clear();
+	if (ret)
+		return ret;
+
+	ret = ec.read(EC_MSG_OFFSET_STATUS);
+	if (ret != EC_STATUS_SUCCESS)
+		return -EIO;
+
+	for (i = 0; (i < len) && (len < EC_MSG_SIZE) && (len <= bufsz); i++)
+		buf[i] = ec.read(EC_MSG_OFFSET_DATA(i + 1));
+
+	return 0;
+}
+
+static int ec_write_ram(u8 bank, u8 offset, u8 len, u8 *buf)
+{
+	int i;
+	int ret;
+
+	if (WARN_ON(!buf))
+		return -EINVAL;
+
+	ret = ec_wait_cmd_clear();
+	if (ret)
+		return ret;
+
+	ec.write(EC_MSG_OFFSET_PARAM, bank);
+	ec.write(EC_MSG_OFFSET_DATA(0), offset);
+	ec.write(EC_MSG_OFFSET_DATA(0x2C), len);
+
+	for (i = 0; (i < len) && (len < EC_MSG_SIZE); i++)
+		ec.write(EC_MSG_OFFSET_DATA(i + 1), buf[i]);
+
+	ec.write(EC_MSG_OFFSET_CMD, EC_CMD_RAM_WR);
+
+	ret = ec_wait_cmd_clear();
+	if (ret)
+		return ret;
+
+	ret = ec.read(EC_MSG_OFFSET_STATUS);
+	if (ret != EC_STATUS_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int ec_read_dynamic_devtbl(struct imanager_data *ec)
+{
+	u32 i, j;
+	int ret;
+	struct ec_message did = {
+		.rlen = EC_MAX_DID,
+		.wlen = 0,
+	};
+	struct ec_message hwp = {
+		.rlen = EC_MAX_DID,
+		.wlen = 0,
+	};
+	struct ec_message pol = {
+		.rlen = EC_MAX_DID,
+		.wlen = 0,
+	};
+	struct ec_dyn_devtbl *dyn;
+
+	memset(ec->dyn, 0, sizeof(ec->dyn));
+
+	ret = imanager_msg_read(EC_CMD_DYN_TBL_RD, EC_DYN_DID, &did);
+	if (ret)
+		return -EIO;
+
+	ret = imanager_msg_read(EC_CMD_DYN_TBL_RD, EC_DYN_HWP, &hwp);
+	if (ret)
+		return -EIO;
+
+	ret = imanager_msg_read(EC_CMD_DYN_TBL_RD, EC_DYN_POL, &pol);
+	if (ret)
+		return -EIO;
+
+	for (i = 0; (i < EC_MAX_DID) && did.u.data[i]; i++) {
+		dyn = &ec->dyn[i];
+		for (j = 0; j < ARRAY_SIZE(devtbl); j++) {
+			if (devtbl[j].id == did.u.data[i]) {
+				dyn->did = did.u.data[i];
+				dyn->hwp = hwp.u.data[i];
+				dyn->pol = pol.u.data[i];
+				dyn->devtbl = &devtbl[j];
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int ec_read_buffer(u8 *data, int rlen)
+{
+	int ret, i, j;
+	int pages = rlen % EC_I2C_BLOCK_SIZE;
+	int rem = rlen / EC_I2C_BLOCK_SIZE;
+
+	/* pre-condition: rlen <= 256 */
+
+	ret = ec_wait_cmd_clear();
+	if (ret)
+		return ret;
+
+	for (i = 0; i < pages; i++) {
+		ec.write(EC_MSG_OFFSET_PARAM, i);
+		ec.write(EC_MSG_OFFSET_CMD, EC_CMD_BUF_RD);
+
+		ret = ec_wait_cmd_clear();
+		if (ret)
+			return ret;
+
+		ret = ec.read(EC_MSG_OFFSET_STATUS);
+		if (ret != EC_STATUS_SUCCESS)
+			return -EIO;
+
+		for (j = 0; j < EC_I2C_BLOCK_SIZE; j++)
+			data[i * EC_I2C_BLOCK_SIZE + j] =
+				ec.read(EC_MSG_OFFSET_DATA(j));
+	}
+
+	if (rem) {
+		ec.write(EC_MSG_OFFSET_PARAM, pages);
+		ec.write(EC_MSG_OFFSET_CMD, EC_CMD_BUF_RD);
+
+		ret = ec_wait_cmd_clear();
+		if (ret)
+			return ret;
+
+		ret = ec.read(EC_MSG_OFFSET_STATUS);
+		if (ret != EC_STATUS_SUCCESS)
+			return -EIO;
+
+		for (j = 0; j < rem; j++)
+			data[pages * EC_I2C_BLOCK_SIZE + j] =
+				ec.read(EC_MSG_OFFSET_DATA(j));
+	}
+
+	return 0;
+}
+
+static int
+imanager_msg_trans(u8 cmd, u8 param, struct ec_message *msg, bool payload)
+{
+	int ret, i, len;
+	u32 offset;
+
+	ret = ec_wait_cmd_clear();
+	if (ret)
+		return ret;
+
+	ec.write(EC_MSG_OFFSET_PARAM, param);
+
+	if (msg && msg->wlen) {
+		if (!msg->data) {
+			for (i = 0; i < msg->wlen; i++)
+				ec.write(EC_MSG_OFFSET_DATA(i),
+					msg->u.data[i]);
+		} else {
+			for (i = 0; i < msg->wlen; i++)
+				ec.write(EC_MSG_OFFSET_DATA(i), msg->data[i]);
+			ec.write(EC_MSG_OFFSET_DATA(0x2c), msg->wlen);
+		}
+	}
+
+	ec.write(EC_MSG_OFFSET_CMD, cmd);
+	ret = ec_wait_cmd_clear();
+	if (ret)
+		return ret;
+
+	/* GPIO and I2C have different success return values */
+	ret = ec.read(EC_MSG_OFFSET_STATUS);
+	if ((ret != EC_STATUS_SUCCESS) && !(ret & EC_STATUS_CMD_COMPLETE))
+		return -EIO;
+	/*
+	 * EC I2C may return an error code which we need to hand-off
+	 * to the caller
+	 */
+	else if (ret & 0x07e)
+		return ret;
+
+	if (msg && msg->data) {
+		ret = ec_read_buffer(msg->data, msg->rlen);
+		if (ret < 0)
+			return ret;
+	} else if (msg && msg->rlen) {
+		if (msg->rlen == 0xff)
+			/* Use alternate message body for hwmon */
+			len = ec.read(EC_MSG_OFFSET_DATA(0x2C));
+		else
+			len = (msg->rlen > EC_MSG_SIZE ? EC_MSG_SIZE :
+				msg->rlen);
+		offset = payload ? EC_MSG_OFFSET_PAYLOAD(0) :
+				EC_MSG_OFFSET_DATA(0);
+		for (i = 0; i < len; i++)
+			msg->u.data[i] = ec.read(offset + i);
+	}
+
+	return 0;
+}
+
+int imanager_msg_read(u8 cmd, u8 param, struct ec_message *msg)
+{
+	return imanager_msg_trans(cmd, param, msg, false);
+}
+EXPORT_SYMBOL_GPL(imanager_msg_read);
+
+int imanager_msg_write(u8 cmd, u8 param, struct ec_message *msg)
+{
+	return imanager_msg_trans(cmd, param, msg, true);
+}
+EXPORT_SYMBOL_GPL(imanager_msg_write);
+
+int imanager_read_byte(u8 cmd, u8 param)
+{
+	int ret;
+	struct ec_message msg = {
+		.rlen = 1,
+		.wlen = 0,
+	};
+
+	ret = imanager_msg_read(cmd, param, &msg);
+	if (ret)
+		return ret;
+
+	return msg.u.data[0];
+}
+EXPORT_SYMBOL_GPL(imanager_read_byte);
+
+int imanager_read_word(u8 cmd, u8 param)
+{
+	int ret;
+	struct ec_message msg = {
+		.rlen = 2,
+		.wlen = 0,
+	};
+
+	ret = imanager_msg_read(cmd, param, &msg);
+	if (ret)
+		return ret;
+
+	return (msg.u.data[0] << 8 | msg.u.data[1]);
+}
+EXPORT_SYMBOL_GPL(imanager_read_word);
+
+int imanager_write_byte(u8 cmd, u8 param, u8 byte)
+{
+	struct ec_message msg = {
+		.rlen = 0,
+		.wlen = 1,
+		.u = {
+			.data = { byte, 0 },
+		},
+	};
+
+	return imanager_msg_write(cmd, param, &msg);
+}
+EXPORT_SYMBOL_GPL(imanager_write_byte);
+
+int imanager_write_word(u8 cmd, u8 param, u16 word)
+{
+	struct ec_message msg = {
+		.rlen = 0,
+		.wlen = 2,
+		.u = {
+			.data = { HIBYTE16(word), LOBYTE16(word), 0 },
+		},
+	};
+
+	return imanager_msg_write(cmd, param, &msg);
+}
+EXPORT_SYMBOL_GPL(imanager_write_word);
+
+static int ec_hwram_read_byte(u8 offset)
+{
+	int ret;
+	u8 val;
+
+	ret = ec_read_ram(EC_RAM_HW, offset, sizeof(val), &val, sizeof(val));
+	if (ret < 0) {
+		pr_err("Failed to read from HWRAM @ 0x%02X\n", offset);
+		return ret;
+	}
+
+	return val;
+}
+
+int imanager_acpiram_read_byte(u8 offset)
+{
+	int ret;
+	u8 value;
+
+	ret = ec_read_ram(EC_RAM_ACPI, offset, sizeof(value), (u8 *)&value,
+			  sizeof(value));
+	if (ret < 0) {
+		pr_err("Failed to read from ACPI RAM @ 0x%02X\n", offset);
+		return ret;
+	}
+
+	return value;
+}
+EXPORT_SYMBOL_GPL(imanager_acpiram_read_byte);
+
+int imanager_acpiram_write_byte(u8 offset, u8 value)
+{
+	int ret;
+
+	ret = ec_write_ram(EC_RAM_ACPI, offset, sizeof(value), &value);
+	if (ret) {
+		pr_err("Failed to write to ACPI RAM @ 0x%02X\n", offset);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imanager_acpiram_write_byte);
+
+int imanager_acpiram_read_block(u8 offset, u8 *buf, u8 len)
+{
+	int ret;
+
+	ret = ec_read_ram(EC_RAM_ACPI, offset, len, buf, len);
+	if (ret < 0) {
+		pr_err("Failed to read from ACPI RAM @ 0x%02X\n", offset);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imanager_acpiram_read_block);
+
+int imanager_acpiram_write_block(u8 offset, u8 *buf, u8 len)
+{
+	int ret;
+
+	ret = ec_write_ram(EC_RAM_ACPI, offset, len, buf);
+	if (ret) {
+		pr_err("Failed to write to ACPI RAM @ 0x%02X\n", offset);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imanager_acpiram_write_block);
+
+int imanager_wait_proc_complete(u8 offset, int cond)
+{
+	int ret, i;
+
+	for (i = 0; i < EC_MAX_RETRY; i++) {
+		ret = ec_hwram_read_byte(offset);
+		if (ret < 0)
+			return ret;
+
+		if (ret == cond)
+			return 0;
+
+		imanager_delay();
+	}
+
+	return -EIO;
+}
+EXPORT_SYMBOL_GPL(imanager_wait_proc_complete);
+
+static inline void ec_get_dev_attr(struct ec_dev_attr *attr,
+				   const struct ec_dyn_devtbl *tbl)
+{
+	attr->did = tbl->did;
+	attr->hwp = tbl->hwp;
+	attr->pol = tbl->pol;
+	attr->scale = tbl->devtbl->scale;
+	attr->label = tbl->devtbl->label;
+}
+
+static int ec_get_dev_gpio(struct imanager_data *ec)
+{
+	size_t i;
+	struct ec_dyn_devtbl *dyn;
+	struct imanager_gpio_device *gpio = &ec->gpio;
+
+	for (i = 0; i < ARRAY_SIZE(ec->dyn); i++) {
+		dyn = &ec->dyn[i];
+		if (dyn->did && (dyn->devtbl->type == GPIO)) {
+			switch (dyn->did) {
+			case ALTGPIO0:
+				ec_get_dev_attr(&gpio->attr[0], dyn);
+				gpio->num++;
+				break;
+			case ALTGPIO1:
+				ec_get_dev_attr(&gpio->attr[1], dyn);
+				gpio->num++;
+				break;
+			case ALTGPIO2:
+				ec_get_dev_attr(&gpio->attr[2], dyn);
+				gpio->num++;
+				break;
+			case ALTGPIO3:
+				ec_get_dev_attr(&gpio->attr[3], dyn);
+				gpio->num++;
+				break;
+			case ALTGPIO4:
+				ec_get_dev_attr(&gpio->attr[4], dyn);
+				gpio->num++;
+				break;
+			case ALTGPIO5:
+				ec_get_dev_attr(&gpio->attr[5], dyn);
+				gpio->num++;
+				break;
+			case ALTGPIO6:
+				ec_get_dev_attr(&gpio->attr[6], dyn);
+				gpio->num++;
+				break;
+			case ALTGPIO7:
+				ec_get_dev_attr(&gpio->attr[7], dyn);
+				gpio->num++;
+				break;
+			case BUTTON0:
+			case BUTTON1:
+			case BUTTON2:
+			case BUTTON3:
+			case BUTTON4:
+			case BUTTON5:
+			case BUTTON6:
+			case BUTTON7:
+			case POWERLED:
+			case BATLEDG:
+			case OEMLED0:
+			case OEMLED1:
+			case OEMLED2:
+			case BATLEDR:
+			case WDNMI:
+			case BACKLIGHT1:
+			case BACKLIGHT2:
+				break;
+			default:
+				pr_err("DID 0x%02X not handled\n", dyn->did);
+				return -EINVAL;
+			}
+		}
+	}
+
+	gpio->info = &ec->dev.info;
+
+	return 0;
+}
+
+static int ec_get_dev_adc(struct imanager_data *ec)
+{
+	size_t i;
+	struct ec_dyn_devtbl *dyn;
+	struct dev_adc *adc = &ec->sensors.adc;
+
+	for (i = 0; i < ARRAY_SIZE(ec->dyn); i++) {
+		dyn = &ec->dyn[i];
+		if (dyn->did && (dyn->devtbl->type == ADC)) {
+			switch (dyn->did) {
+			case ADC12VS0:
+			case ADC12VS0x2:
+			case ADC12VS0x10:
+				ec_get_dev_attr(&adc->attr[0], dyn);
+				adc->num++;
+				break;
+			case ADC5VS5:
+			case ADC5VS5x2:
+			case ADC5VS5x10:
+				ec_get_dev_attr(&adc->attr[1], dyn);
+				adc->num++;
+				break;
+			case CMOSBAT:
+			case CMOSBATx2:
+			case CMOSBATx10:
+				ec_get_dev_attr(&adc->attr[2], dyn);
+				adc->num++;
+				break;
+			case VCOREA:
+			case ADC5VS0:
+			case ADC5VS0x2:
+			case ADC5VS0x10:
+				ec_get_dev_attr(&adc->attr[3], dyn);
+				adc->num++;
+				break;
+			case CURRENT:
+			case ADC33VS0:
+			case ADC33VS0x2:
+			case ADC33VS0x10:
+				ec_get_dev_attr(&adc->attr[4], dyn);
+				adc->num++;
+				break;
+			default:
+				pr_err("DID 0x%02X not handled\n", dyn->did);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int ec_get_dev_fan(struct imanager_data *ec)
+{
+	size_t i;
+	struct ec_dyn_devtbl *dyn;
+	struct dev_fan *fan = &ec->sensors.fan;
+
+	for (i = 0; i < ARRAY_SIZE(ec->dyn); i++) {
+		dyn = &ec->dyn[i];
+		if (dyn->did && ((dyn->devtbl->type == TACH) ||
+				 (dyn->devtbl->type == PWM))) {
+			switch (dyn->did) {
+			case CPUFAN_2P:
+			case CPUFAN_4P:
+				ec_get_dev_attr(&fan->attr[0], dyn);
+				fan->num++;
+				fan->active |= 1 << 0;
+				break;
+			case SYSFAN1_2P:
+			case SYSFAN1_4P:
+				ec_get_dev_attr(&fan->attr[1], dyn);
+				fan->num++;
+				fan->active |= 1 << 1;
+				break;
+			case SYSFAN2_2P:
+			case SYSFAN2_4P:
+				ec_get_dev_attr(&fan->attr[2], dyn);
+				fan->num++;
+				fan->active |= 1 << 2;
+				break;
+			case TACHO0:
+			case TACHO1:
+			case TACHO2:
+			case BRIGHTNESS:
+			case BRIGHTNESS2:
+			case PCBEEP:
+				break;
+			default:
+				pr_err("DID 0x%02X not handled\n", dyn->did);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int ec_get_dev_hwmon(struct imanager_data *ec)
+{
+	int ret;
+
+	ret = ec_get_dev_adc(ec);
+	if (ret < 0)
+		return ret;
+
+	ret = ec_get_dev_fan(ec);
+	if (ret < 0)
+		return ret;
+
+	ec->sensors.ecdev = &ec->dev;
+
+	return 0;
+}
+
+static int ec_get_dev_i2c(struct imanager_data *ec)
+{
+	size_t i;
+	struct ec_dyn_devtbl *dyn;
+	struct imanager_i2c_device *i2c = &ec->i2c;
+
+	for (i = 0; i < ARRAY_SIZE(ec->dyn); i++) {
+		dyn = &ec->dyn[i];
+		if (dyn->did && (dyn->devtbl->type == SMB)) {
+			switch (dyn->did) {
+			case SMBEEPROM:
+				ec_get_dev_attr(&i2c->attr[0], dyn);
+				i2c->eeprom = &i2c->attr[0];
+				i2c->num++;
+				break;
+			case I2COEM:
+				ec_get_dev_attr(&i2c->attr[1], dyn);
+				i2c->i2coem = &i2c->attr[1];
+				i2c->num++;
+				break;
+			case SMBOEM0:
+			case SMBOEM1:
+			case SMBOEM2:
+			case SMBTHERMAL0:
+			case SMBTHERMAL1:
+			case SMBSECEEP:
+			case SMBEEP2K:
+			case OEMEEP:
+			case OEMEEP2K:
+			case PECI:
+			case SMBOEM3:
+			case SMLINK:
+			case SMBSLV:
+			case SMARTBAT1:
+			case SMARTBAT2:
+				break;
+			default:
+				pr_err("DID 0x%02X not handled\n", dyn->did);
+				return -EINVAL;
+			}
+		}
+	}
+
+	i2c->ecdev = &ec->dev;
+
+	return 0;
+}
+
+static int ec_get_dev_blc(struct imanager_data *ec)
+{
+	size_t i;
+	struct ec_dyn_devtbl *dyn;
+	struct imanager_backlight_device *blc = &ec->blc;
+
+	for (i = 0; i < ARRAY_SIZE(ec->dyn); i++) {
+		dyn = &ec->dyn[i];
+		if (dyn->did && (dyn->devtbl->type == PWM)) {
+			switch (dyn->did) {
+			case BRIGHTNESS:
+				ec_get_dev_attr(&blc->attr[0], dyn);
+				blc->brightness[0] = EC_ACPIRAM_BRIGHTNESS1;
+				blc->num++;
+				break;
+			case BRIGHTNESS2:
+				ec_get_dev_attr(&blc->attr[1], dyn);
+				blc->brightness[1] = EC_ACPIRAM_BRIGHTNESS2;
+				blc->num++;
+				break;
+			case CPUFAN_2P:
+			case CPUFAN_4P:
+			case SYSFAN1_2P:
+			case SYSFAN1_4P:
+			case SYSFAN2_2P:
+			case SYSFAN2_4P:
+			case PCBEEP:
+			case TACHO0:
+			case TACHO1:
+			case TACHO2:
+				break;
+			default:
+				pr_err("DID 0x%02X not handled\n", dyn->did);
+				return -EINVAL;
+			}
+		}
+	}
+
+	blc->info = &ec->dev.info;
+
+	return 0;
+}
+
+static int ec_get_dev_wdt(struct imanager_data *ec)
+{
+	size_t i;
+	struct ec_dyn_devtbl *dyn;
+	struct imanager_watchdog_device *wdt = &ec->wdt;
+
+	for (i = 0; i < ARRAY_SIZE(ec->dyn); i++) {
+		dyn = &ec->dyn[i];
+		if (dyn->did && (dyn->devtbl->type == IRQ)) {
+			switch (dyn->did) {
+			case WDIRQ:
+				ec_get_dev_attr(&wdt->attr[0], dyn);
+				wdt->irq = &wdt->attr[0];
+				wdt->num++;
+				break;
+			case WDNMI:
+				ec_get_dev_attr(&wdt->attr[1], dyn);
+				wdt->nmi = &wdt->attr[1];
+				wdt->num++;
+				break;
+			default:
+				pr_err("DID 0x%02X not handled\n", dyn->did);
+				return -EINVAL;
+			}
+		}
+	}
+
+	wdt->info = &ec->dev.info;
+
+	return 0;
+}
+
+const struct imanager_ec_device *imanager_get_ec_device(void)
+{
+	return &ec.dev;
+};
+EXPORT_SYMBOL_GPL(imanager_get_ec_device);
+
+const struct imanager_hwmon_device *imanager_get_hwmon_device(void)
+{
+	return &ec.sensors;
+}
+EXPORT_SYMBOL_GPL(imanager_get_hwmon_device);
+
+const struct imanager_gpio_device *imanager_get_gpio_device(void)
+{
+	return &ec.gpio;
+}
+EXPORT_SYMBOL_GPL(imanager_get_gpio_device);
+
+const struct imanager_i2c_device *imanager_get_i2c_device(void)
+{
+	return &ec.i2c;
+}
+EXPORT_SYMBOL_GPL(imanager_get_i2c_device);
+
+const struct imanager_backlight_device *imanager_get_backlight_device(void)
+{
+	return &ec.blc;
+}
+EXPORT_SYMBOL_GPL(imanager_get_backlight_device);
+
+const struct imanager_watchdog_device *imanager_get_watchdog_device(void)
+{
+	return &ec.wdt;
+}
+EXPORT_SYMBOL_GPL(imanager_get_watchdog_device);
+
+static int ec_get_version(struct ec_version *version)
+{
+	int ret;
+	u16 raw;
+	struct ec_version_raw ver;
+
+	if (WARN_ON(!version))
+		return -EINVAL;
+
+	ret = ec_read_ram(EC_RAM_ACPI, EC_ACPIRAM_FW_RELEASE_RD, sizeof(ver),
+			 (u8 *)&ver, sizeof(ver));
+	if (ret < 0)
+		return ret;
+
+	raw = swab16(ver.kernel);
+	version->kernel_major = EC_KERNEL_MAJOR(raw);
+	version->kernel_minor = EC_KERNEL_MINOR(raw);
+
+	raw = swab16(ver.firmware);
+	version->firmware_major = EC_FIRMWARE_MAJOR(raw);
+	version->firmware_minor = EC_FIRMWARE_MINOR(raw);
+
+	raw = swab16(ver.project_code);
+	version->type = EC_PROJECT_CODE(raw);
+
+	return 0;
+}
+
+static int ec_get_pcb_name(struct ec_info *info)
+{
+	int ret;
+	struct ec_message msg = {
+		.rlen = ARRAY_SIZE(info->pcb_name),
+		.wlen = 0,
+	};
+
+	if (WARN_ON(!info))
+		return -EINVAL;
+
+	ret = imanager_msg_read(EC_CMD_FW_INFO_RD, 0, &msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * Sadly, the string is not Null-terminated so we will need to read a
+	 * fixed amount of chars. There is, apparently, no exact definition
+	 * of board name (SOM6867 vs. MIO-5271).
+	 */
+	memset(info->pcb_name, 0, ARRAY_SIZE(info->pcb_name));
+	strncpy(info->pcb_name, (const char *)msg.u.data, PCB_NAME_MAX_SIZE);
+
+	if (strchr(info->pcb_name, '-') == NULL)
+		info->pcb_name[PCB_NAME_MAX_SIZE - 1] = '\0';
+
+	return 0;
+}
+
+static int ec_get_fw_info(struct ec_info *info)
+{
+	int ret;
+
+	if (WARN_ON(!info))
+		return -EINVAL;
+
+	ret = ec_get_version(&info->version);
+	if (ret)
+		return ret;
+
+	return ec_get_pcb_name(info);
+}
+
+static int ec_init(void)
+{
+	int ret;
+
+	ec_clear_ports();
+
+	ret = ec_read_dynamic_devtbl(&ec);
+	if (ret)
+		return ret;
+
+	ret = ec_get_fw_info(&ec.dev.info);
+	if (ret < 0)
+		return ret;
+
+	ret = ec_get_dev_gpio(&ec);
+	if (ret < 0)
+		return ret;
+
+	ret = ec_get_dev_hwmon(&ec);
+	if (ret < 0)
+		return ret;
+
+	ret = ec_get_dev_i2c(&ec);
+	if (ret < 0)
+		return ret;
+
+	ret = ec_get_dev_blc(&ec);
+	if (ret < 0)
+		return ret;
+
+	ret = ec_get_dev_wdt(&ec);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int imanager_ec_probe(void)
+{
+	int chipid = ec_read_chipid(EC_BASE_ADDR);
+
+	memset((void *)&ec, 0, sizeof(ec));
+
+	switch (chipid) {
+	case EC_DEVID_IT8516:
+		pr_err("EC IT8516 not supported\n");
+		ec.dev.id = IT8516;
+		return -ENODEV;
+	case EC_DEVID_IT8518:
+		ec.read = ec_io18_read;
+		ec.write = ec_io18_write;
+		ec.dev.id = IT8518;
+		break;
+	case EC_DEVID_IT8528:
+		ec.read = ec_io28_read;
+		ec.write = ec_io28_write;
+		ec.dev.id = IT8528;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ec.dev.addr = EC_BASE_ADDR;
+
+	return ec_init();
+}
+
diff --git a/include/linux/mfd/imanager/core.h b/include/linux/mfd/imanager/core.h
new file mode 100644
index 0000000..05c77fa
--- /dev/null
+++ b/include/linux/mfd/imanager/core.h
@@ -0,0 +1,31 @@
+/*
+ * Advantech iManager MFD core
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
+#ifndef __CORE_H__
+#define __CORE_H__
+
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/mfd/imanager/ec.h>
+
+struct imanager_platform_data {
+	const struct imanager_ec_device *dev;
+	const char *chip_name;
+};
+
+struct imanager_device_data {
+	struct device *dev;
+	struct mutex  lock;
+};
+
+#endif
diff --git a/include/linux/mfd/imanager/ec.h b/include/linux/mfd/imanager/ec.h
new file mode 100644
index 0000000..783f268
--- /dev/null
+++ b/include/linux/mfd/imanager/ec.h
@@ -0,0 +1,210 @@
+/*
+ * Advantech iManager core - firmware interface
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
+#ifndef __EC_H__
+#define __EC_H__
+
+#include <linux/types.h>
+
+#define EC_DEVID_IT8516			0x8516
+#define EC_DEVID_IT8518			0x8518
+#define EC_DEVID_IT8528			0x8528
+
+#define EC_BASE_ADDR			0x029C
+
+#define IT8516_CMD_PORT			0x029A /* it8528 */
+#define IT8516_DAT_PORT			0x0299
+
+#define IT8518_CMD_PORT			0x029E /* it8518 */
+#define IT8518_DAT_PORT			0x029F
+
+#define EC_GPIO_MAX_NUM			8
+#define EC_HWM_MAX_ADC			5
+#define EC_HWM_MAX_FAN			3
+#define EC_BLC_MAX_NUM			2
+#define EC_SMB_MAX_NUM			4
+#define EC_WDT_MAX_NUM			2
+
+#define PCB_NAME_SIZE			32
+#define EC_PAYLOAD_SIZE			40
+#define EC_MSG_SIZE			sizeof(struct ec_smb_message)
+
+#define LOBYTE16(x)			(x & 0x00FF)
+#define HIBYTE16(x)			(LOBYTE16(x >> 8))
+#define LOADDR16(x)			LOBYTE16(x)
+#define HIADDR16(x)			(x >= 0xF000 ? LOBYTE16(x >> 8) : 0)
+
+/*
+ * iManager commands
+ */
+#define EC_CMD_HWP_RD			0x11UL
+#define EC_CMD_HWP_WR			0x12UL
+#define EC_CMD_GPIO_DIR_RD		0x30UL
+#define EC_CMD_GPIO_DIR_WR		0x31UL
+#define EC_CMD_PWM_FREQ_RD		0x36UL
+#define EC_CMD_PWM_FREQ_WR		0x32UL
+#define EC_CMD_PWM_POL_RD		0x37UL
+#define EC_CMD_PWM_POL_WR		0x33UL
+#define EC_CMD_SMB_FREQ_RD		0x34UL
+#define EC_CMD_SMB_FREQ_WR		0x35UL
+#define EC_CMD_FAN_CTL_RD		0x40UL
+#define EC_CMD_FAN_CTL_WR		0x41UL
+#define EC_CMD_THZ_RD			0x42UL
+#define EC_CMD_DYN_TBL_RD		0x20UL
+#define EC_CMD_FW_INFO_RD		0xF0UL
+#define EC_CMD_BUF_CLR			0xC0UL
+#define EC_CMD_BUF_RD			0xC1UL
+#define EC_CMD_BUF_WR			0xC2UL
+#define EC_CMD_RAM_RD			0x1EUL
+#define EC_CMD_RAM_WR			0x1FUL
+#define EC_CMD_I2C_RW			0x0EUL
+#define EC_CMD_I2C_WR			0x0FUL
+#define EC_CMD_WDT_CTRL			0x28UL
+
+/*
+ * ACPI and HW RAM offsets
+ */
+#define EC_ACPIRAM_FAN_ALERT		0x6FUL
+#define EC_ACPIRAM_FAN_SPEED_LIMIT	0x76UL
+#define EC_ACPIRAM_BRIGHTNESS1		0x50UL
+#define EC_ACPIRAM_BRIGHTNESS2		0x52UL
+#define EC_ACPIRAM_BLC_CTRL		0x99UL
+#define EC_ACPIRAM_FW_RELEASE_RD	0xF8UL
+
+enum chips { IT8516, IT8518, IT8528 };
+
+struct ec_message_header {
+	u8 addr_low;	/* SMB low-byte address or data low-byte */
+			/* of byte-/word-transaction */
+	u8 addr_high;	/* SMB high-byte address or data high-byte */
+			/* of word-transaction */
+	u8 rlen;	/* SMB read length */
+	u8 wlen;	/* SMB write length */
+	u8 cmd;		/* SMB command */
+};
+
+struct ec_smb_message {
+	struct ec_message_header hdr;
+	u8 data[EC_PAYLOAD_SIZE];
+};
+
+struct ec_message {
+	u8 rlen;	/* EC message read length */
+	u8 wlen;	/* EC message write length */
+	union {
+		struct ec_smb_message smb;
+		u8 data[EC_MSG_SIZE];
+	} u;
+
+	u8 *data;
+};
+
+struct ec_version {
+	u32 kernel_major;
+	u32 kernel_minor;
+	u32 firmware_major;
+	u32 firmware_minor;
+	u32 type;
+};
+
+struct ec_info {
+	struct ec_version version;
+	char pcb_name[PCB_NAME_SIZE];
+};
+
+struct imanager_ec_device {
+	int		id; /* enum chip */
+	u16		addr;
+	struct ec_info	info;
+};
+
+struct ec_dev_attr {
+	int did;	/* Device ID */
+	int hwp;	/* Hardware Pin number */
+	int pol;	/* Polarity */
+	int scale;	/* Scaling factor */
+	const char *label;
+};
+
+struct imanager_gpio_device {
+	u32			num;
+	struct ec_dev_attr	attr[EC_GPIO_MAX_NUM];
+	struct ec_info		*info;
+};
+
+struct dev_adc {
+	u32			num;
+	struct ec_dev_attr	attr[EC_HWM_MAX_ADC];
+};
+
+struct dev_fan {
+	u32			num;
+	u32			active;
+	struct ec_dev_attr	attr[EC_HWM_MAX_FAN];
+};
+
+struct imanager_hwmon_device {
+	struct dev_adc		adc;
+	struct dev_fan		fan;
+	struct imanager_ec_device *ecdev;
+};
+
+struct imanager_i2c_device {
+	u32			num;
+	struct ec_dev_attr	attr[EC_SMB_MAX_NUM];
+	struct ec_dev_attr	*eeprom;
+	struct ec_dev_attr	*i2coem;
+	struct imanager_ec_device *ecdev;
+};
+
+struct imanager_backlight_device {
+	u32			num;
+	struct ec_dev_attr	attr[EC_BLC_MAX_NUM];
+	u8			brightness[EC_BLC_MAX_NUM];
+	struct ec_info		*info;
+};
+
+struct imanager_watchdog_device {
+	u32			num;
+	struct ec_dev_attr	attr[EC_WDT_MAX_NUM];
+	struct ec_dev_attr	*irq;
+	struct ec_dev_attr	*nmi;
+	struct ec_info		*info;
+};
+
+/* Must be called first, obviously */
+int imanager_ec_probe(void);
+
+int imanager_msg_write(u8 cmd, u8 param, struct ec_message *msg);
+int imanager_msg_read(u8 cmd, u8 param, struct ec_message *msg);
+
+int imanager_read_byte(u8 cmd, u8 param);
+int imanager_read_word(u8 cmd, u8 param);
+
+int imanager_write_byte(u8 cmd, u8 param, u8 byte);
+int imanager_write_word(u8 cmd, u8 param, u16 word);
+
+int imanager_acpiram_read_byte(u8 offset);
+int imanager_acpiram_write_byte(u8 offset, u8 value);
+int imanager_acpiram_read_block(u8 offset, u8 *buf, u8 len);
+int imanager_acpiram_write_block(u8 offset, u8 *buf, u8 len);
+
+int imanager_wait_proc_complete(u8 offset, int cond);
+
+const struct imanager_ec_device *imanager_get_ec_device(void);
+const struct imanager_hwmon_device *imanager_get_hwmon_device(void);
+const struct imanager_gpio_device *imanager_get_gpio_device(void);
+const struct imanager_i2c_device *imanager_get_i2c_device(void);
+const struct imanager_watchdog_device *imanager_get_watchdog_device(void);
+const struct imanager_backlight_device *imanager_get_backlight_device(void);
+
+#endif
-- 
2.7.0
