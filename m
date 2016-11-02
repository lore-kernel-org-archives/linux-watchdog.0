Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35645 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbcKBIiD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Nov 2016 04:38:03 -0400
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
Subject: [PATCH v4 1/6] Add Advantech iManager MFD core driver
Date: Wed,  2 Nov 2016 01:37:46 -0700
Message-Id: <20161102083751.6335-2-richard.dorsch@gmail.com>
In-Reply-To: <20161102083751.6335-1-richard.dorsch@gmail.com>
References: <20161102083751.6335-1-richard.dorsch@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds Advantech iManager Embedded Controller MFD core driver.
This mfd core dirver provides an interface for GPIO, I2C, HWmon,
Watchdog, and Backlight/Brightness control.

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 drivers/mfd/Kconfig             |  18 +
 drivers/mfd/Makefile            |   1 +
 drivers/mfd/imanager-core.c     | 941 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/imanager-ec.h | 228 ++++++++++
 include/linux/mfd/imanager.h    | 221 ++++++++++
 5 files changed, 1409 insertions(+)
 create mode 100644 drivers/mfd/imanager-core.c
 create mode 100644 include/linux/mfd/imanager-ec.h
 create mode 100644 include/linux/mfd/imanager.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c6df644..294c19d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -388,6 +388,24 @@ config MFD_INTEL_QUARK_I2C_GPIO
 	  their respective IO driver.
 	  The GPIO exports a total amount of 8 interrupt-capable GPIOs.
 
+config MFD_IMANAGER
+	tristate "Advantech iManager EC device"
+	select MFD_CORE
+	help
+	  This is the core driver for Advantech iManager Embedded Controller
+	  found on some Advantech SOM, MIO, AIMB, and PCM modules/boards. The
+	  EC may provide functions like GPIO, I2C bus, HW monitoring, Watchdog,
+	  and backlight/brightness control.
+
+	  The following Advantech boards are supported:
+		* All SOM modules newer than SOM-5788
+		* MIO-5250/5251/5270/5271/5272/5290 and newer
+		* PCM-9389/9365/9376 and newer
+		* AIMB-273/274/230/231 and newer
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called imanager-core.
+
 config LPC_ICH
 	tristate "Intel ICH LPC"
 	depends on PCI
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9834e66..e4b0a4d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
 obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
 obj-$(CONFIG_MFD_TIMBERDALE)    += timberdale.o
 obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
+obj-$(CONFIG_MFD_IMANAGER)	+= imanager-core.o
 obj-$(CONFIG_MFD_KEMPLD)	+= kempld-core.o
 obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
 obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
diff --git a/drivers/mfd/imanager-core.c b/drivers/mfd/imanager-core.c
new file mode 100644
index 0000000..2ec1b79
--- /dev/null
+++ b/drivers/mfd/imanager-core.c
@@ -0,0 +1,941 @@
+/*
+ * Advantech iManager MFD driver
+ * Partially derived from kempld-core
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
+#include <linux/bitops.h>
+#include <linux/byteorder/generic.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/imanager.h>
+#include <linux/mfd/imanager-ec.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+enum kinds { IT8518, IT8528 };
+
+static struct platform_device *imanager_pdev;
+
+static const char * const chip_names[] = {
+	"it8518",
+	"it8528",
+	NULL
+};
+
+static const struct imanager_ec_device ecdev_table[] = {
+	/* GPIO */
+	{ IMANAGER_EC_DEVICE(GPIO0, GPIO, -1) },
+	{ IMANAGER_EC_DEVICE(GPIO1, GPIO, -1) },
+	{ IMANAGER_EC_DEVICE(GPIO2, GPIO, -1) },
+	{ IMANAGER_EC_DEVICE(GPIO3, GPIO, -1) },
+	{ IMANAGER_EC_DEVICE(GPIO4, GPIO, -1) },
+	{ IMANAGER_EC_DEVICE(GPIO5, GPIO, -1) },
+	{ IMANAGER_EC_DEVICE(GPIO6, GPIO, -1) },
+	{ IMANAGER_EC_DEVICE(GPIO7, GPIO, -1) },
+	/* FAN */
+	{ IMANAGER_EC_DEVICE(CPUFAN_2P,  PWM, 2) },
+	{ IMANAGER_EC_DEVICE(CPUFAN_4P,  PWM, 4) },
+	{ IMANAGER_EC_DEVICE(SYSFAN1_2P, PWM, 2) },
+	{ IMANAGER_EC_DEVICE(SYSFAN1_4P, PWM, 4) },
+	{ IMANAGER_EC_DEVICE(SYSFAN2_2P, PWM, 2) },
+	{ IMANAGER_EC_DEVICE(SYSFAN2_4P, PWM, 4) },
+	/* ADC */
+	{ IMANAGER_EC_DEVICE(ADC12VS0,    ADC, 1) },
+	{ IMANAGER_EC_DEVICE(ADC12VS0_2,  ADC, 2) },
+	{ IMANAGER_EC_DEVICE(ADC12VS0_10, ADC, 10) },
+	{ IMANAGER_EC_DEVICE(ADC5VS0,     ADC, 1) },
+	{ IMANAGER_EC_DEVICE(ADC5VS0_2,   ADC, 2) },
+	{ IMANAGER_EC_DEVICE(ADC5VS0_10,  ADC, 10) },
+	{ IMANAGER_EC_DEVICE(ADC5VS5,     ADC, 1) },
+	{ IMANAGER_EC_DEVICE(ADC5VS5_2,   ADC, 2) },
+	{ IMANAGER_EC_DEVICE(ADC5VS5_10,  ADC, 10) },
+	{ IMANAGER_EC_DEVICE(ADC33VS0,    ADC, 1) },
+	{ IMANAGER_EC_DEVICE(ADC33VS0_2,  ADC, 2) },
+	{ IMANAGER_EC_DEVICE(ADC33VS0_10, ADC, 10) },
+	{ IMANAGER_EC_DEVICE(CMOSBAT,     ADC, 1) },
+	{ IMANAGER_EC_DEVICE(CMOSBAT_2,   ADC, 2) },
+	{ IMANAGER_EC_DEVICE(CMOSBAT_10,  ADC, 10) },
+	{ IMANAGER_EC_DEVICE(VCOREA,      ADC, 1) },
+	{ IMANAGER_EC_DEVICE(CURRENT,     ADC, 1) },
+	/* I2C/SMBus */
+	{ IMANAGER_EC_DEVICE(SMBEEPROM,   SMB, -1) },
+	{ IMANAGER_EC_DEVICE(I2COEM,      SMB, -1) },
+	{ IMANAGER_EC_DEVICE(SMBOEM0,     SMB, -1) },
+	{ IMANAGER_EC_DEVICE(SMBPECI,     SMB, -1) },
+	/* Backlight/Brightness */
+	{ IMANAGER_EC_DEVICE(BRIGHTNESS,  PWM, -1) },
+	{ IMANAGER_EC_DEVICE(BRIGHTNESS2, PWM, -1) },
+	/* Watchdog */
+	{ IMANAGER_EC_DEVICE(WDIRQ, IRQ,  -1) },
+	{ IMANAGER_EC_DEVICE(WDNMI, GPIO, -1) },
+	{ 0 }
+};
+
+/**
+ * iManager I/O
+ */
+
+enum imanager_io_buffer_status { IS_CLEARED = 0, IS_SET };
+
+#define CHECK_BIT(reg, bit) ((reg) & (bit))
+
+static inline int check_io28_ready(uint bit, uint state)
+{
+	int ret, i = 0;
+
+	do {
+		ret = inb(IT8528_CMD_PORT);
+		if (CHECK_BIT(ret, bit) == state)
+			return 0;
+		usleep_range(EC_DELAY_MIN, EC_DELAY_MAX);
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
+	ret = check_io28_ready(EC_IO28_INBUF, IS_CLEARED);
+	if (ret)
+		return ret;
+
+	/* prevent firmware lock */
+	inb(addr - 1);
+
+	outb(reg, addr);
+
+	ret = check_io28_ready(EC_IO28_OUTBUF, IS_SET);
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
+	ret = check_io28_ready(EC_IO28_INBUF, IS_CLEARED);
+	if (ret)
+		return ret;
+
+	outb(reg, addr);
+
+	ret = check_io28_ready(EC_IO28_INBUF, IS_CLEARED);
+	if (ret)
+		return ret;
+
+	outb(val, addr - 1);
+
+	return 0;
+}
+
+static inline int ec_io18_read(int cmd)
+{
+	return ec_inb(IT8518_CMD_PORT, cmd);
+}
+
+static inline int ec_io18_write(int cmd, int value)
+{
+	ec_outb(IT8518_CMD_PORT, cmd, value);
+
+	return 0;
+}
+
+static inline int ec_io28_read(int cmd)
+{
+	return ec_io28_inb(IT8528_CMD_PORT, cmd + EC_CMD_OFFSET_READ);
+}
+
+static inline int ec_io28_write(int cmd, int value)
+{
+	return ec_io28_outb(IT8528_CMD_PORT, cmd + EC_CMD_OFFSET_WRITE, value);
+}
+
+static int imanager_check_ec_ready(struct imanager_io_ops *io)
+{
+	int i = 0;
+
+	do {
+		if (!io->read(EC_CMD_CHK_RDY))
+			return 0;
+		usleep_range(EC_DELAY_MIN, EC_DELAY_MAX);
+	} while (i++ < EC_MAX_RETRY);
+
+	return -ETIME;
+}
+
+/**
+ * iManager Device Configuration
+ */
+
+static void imanager_add_attribute(struct imanager_ec_data *ec,
+				   struct imanager_device_attribute *attr)
+{
+	struct imanager_gpio_device *gpio = &ec->gpio;
+	struct imanager_adc_device *adc = &ec->hwmon.adc;
+	struct imanager_fan_device *fan = &ec->hwmon.fan;
+	struct imanager_i2c_device *i2c = &ec->i2c;
+	struct imanager_backlight_device *bl = &ec->bl;
+	struct imanager_watchdog_device *wdt = &ec->wdt;
+
+	switch (attr->ecdev->type) {
+	case GPIO:
+		switch (attr->did) {
+		case GPIO0:
+		case GPIO1:
+		case GPIO2:
+		case GPIO3:
+		case GPIO4:
+		case GPIO5:
+		case GPIO6:
+		case GPIO7:
+			gpio->attr[gpio->num++] = attr;
+			break;
+		case WDNMI:
+			wdt->attr[1] = attr;
+			wdt->num++;
+			break;
+		}
+	case ADC:
+		switch (attr->did) {
+		case ADC12VS0:
+		case ADC12VS0_2:
+		case ADC12VS0_10:
+			adc->attr[0] = attr;
+			adc->label[0] = "+12VS0";
+			adc->num++;
+			break;
+		case ADC5VS5:
+		case ADC5VS5_2:
+		case ADC5VS5_10:
+			adc->attr[1] = attr;
+			adc->label[1] = "+5VS0";
+			adc->num++;
+			break;
+		case CMOSBAT:
+		case CMOSBAT_2:
+		case CMOSBAT_10:
+			adc->attr[2] = attr;
+			adc->label[2] = "+3.3VS0";
+			adc->num++;
+			break;
+		case VCOREA:
+		case ADC5VS0:
+		case ADC5VS0_2:
+		case ADC5VS0_10:
+			adc->attr[3] = attr;
+			adc->num++;
+			break;
+		case CURRENT:
+		case ADC33VS0:
+		case ADC33VS0_2:
+		case ADC33VS0_10:
+			adc->attr[4] = attr;
+			adc->num++;
+			break;
+		}
+	case PWM:
+		switch (attr->did) {
+		case CPUFAN_2P:
+		case CPUFAN_4P:
+			fan->attr[0] = attr;
+			fan->label[0] = "FAN CPU";
+			fan->temp_label[0] = "Temp CPU";
+			fan->num++;
+			break;
+		case SYSFAN1_2P:
+		case SYSFAN1_4P:
+			fan->attr[1] = attr;
+			fan->label[1] = "FAN SYS1";
+			fan->temp_label[1] = "Temp SYS1";
+			fan->num++;
+			break;
+		case SYSFAN2_2P:
+		case SYSFAN2_4P:
+			fan->attr[2] = attr;
+			fan->label[2] = "FAN SYS2";
+			fan->temp_label[2] = "Temp SYS2";
+			fan->num++;
+			break;
+		case BRIGHTNESS:
+			bl->attr[0] = attr;
+			bl->brightness[0] = EC_OFFSET_BRIGHTNESS1;
+			bl->num++;
+			break;
+		case BRIGHTNESS2:
+			bl->attr[1] = attr;
+			bl->brightness[1] = EC_OFFSET_BRIGHTNESS2;
+			bl->num++;
+			break;
+		}
+	case SMB:
+		switch (attr->did) {
+		case SMBEEPROM:
+			i2c->attr[SMB_EEP] = attr;
+			i2c->num++;
+			break;
+		case I2COEM:
+			i2c->attr[I2C_OEM] = attr;
+			i2c->num++;
+			break;
+		case SMBOEM0:
+			i2c->attr[SMB_1] = attr;
+			i2c->num++;
+			break;
+		case SMBPECI:
+			i2c->attr[SMB_PECI] = attr;
+			i2c->num++;
+			break;
+		}
+	case IRQ:
+		if (attr->did == WDIRQ) {
+			wdt->attr[0] = attr;
+			wdt->num++;
+			break;
+		}
+	}
+}
+
+enum imanager_device_table_type { DEVID = 0, HWPIN, POLARITY };
+
+static int imanager_read_device_config(struct imanager_ec_data *ec)
+{
+	struct imanager_ec_message msgs[] = {
+		{ IMANAGER_MSG_SIMPLE(EC_MAX_DID, 0, DEVID, NULL) },
+		{ IMANAGER_MSG_SIMPLE(EC_MAX_DID, 0, HWPIN, NULL) },
+		{ IMANAGER_MSG_SIMPLE(EC_MAX_DID, 0, POLARITY, NULL) },
+	};
+	struct imanager_device_attribute *attr;
+	int i, j, ret;
+
+	/* Read iManager device configurations */
+	for (i = 0; i < ARRAY_SIZE(msgs); i++) {
+		ret = imanager_read(ec, EC_CMD_DEV_TBL_RD, &msgs[i]);
+		if (ret)
+			return ret;
+	}
+
+	/* Generate iManager device atributes */
+	for (i = 0; i < EC_MAX_DID && msgs[DEVID].u.data[i]; i++) {
+		attr = &ec->attr[i];
+		for (j = 0; j < ARRAY_SIZE(ecdev_table); j++) {
+			if (ecdev_table[j].did == msgs[DEVID].u.data[i]) {
+				attr->did = msgs[DEVID].u.data[i];
+				attr->hwp = msgs[HWPIN].u.data[i];
+				attr->pol = msgs[POLARITY].u.data[i];
+				attr->ecdev = &ecdev_table[j];
+				imanager_add_attribute(ec, attr);
+				break;
+			}
+		}
+	}
+
+	if (ec->gpio.num)
+		ec->features |= IMANAGER_FEATURE_GPIO;
+	if (ec->hwmon.adc.num)
+		ec->features |= IMANAGER_FEATURE_HWMON_ADC;
+	if (ec->hwmon.fan.num)
+		ec->features |= IMANAGER_FEATURE_HWMON_FAN;
+	if (ec->i2c.num)
+		ec->features |= IMANAGER_FEATURE_SMBUS;
+	if (ec->bl.num)
+		ec->features |= IMANAGER_FEATURE_BACKLIGHT;
+	if (ec->wdt.num)
+		ec->features |= IMANAGER_FEATURE_WDT;
+
+	return 0;
+}
+
+static const char *project_code_to_str(unsigned int code)
+{
+	switch ((char)code) {
+	case 'V':
+		return "release";
+	case 'X':
+		return "debug";
+	case 'A' ... 'U':
+	case 'Y':
+	case 'Z':
+		return "custom";
+	}
+
+	return "unspecified";
+}
+
+static int imanager_read_firmware_version(struct imanager_ec_data *ec)
+{
+	char pcb_name[IMANAGER_PCB_NAME_LEN] = { 0 };
+	struct imanager_info *info = &ec->info;
+	struct imanager_ec_message msg = {
+		.rlen = ARRAY_SIZE(pcb_name) - 1,
+		.wlen = 0,
+		.param = 0,
+		.data = pcb_name,
+	};
+	struct imanager_ec_version ver;
+	unsigned int val;
+	int ret;
+
+	ret = imanager_read_ram(ec, EC_RAM_ACPI, EC_OFFSET_FW_RELEASE,
+				(u8 *)&ver, sizeof(ver));
+	if (ret < 0)
+		return ret;
+
+	val = cpu_to_be16(ver.kernel);
+	info->kernel_major = EC_KERNEL_MAJOR(val);
+	info->kernel_minor = EC_KERNEL_MINOR(val);
+
+	val = cpu_to_be16(ver.firmware);
+	info->firmware_major = EC_FIRMWARE_MAJOR(val);
+	info->firmware_minor = EC_FIRMWARE_MINOR(val);
+
+	val = cpu_to_be16(ver.project_code);
+	info->type = project_code_to_str(EC_PROJECT_CODE(val));
+
+	/*
+	 * The PCB name string, in some FW releases, is not Null-terminated,
+	 * so we need to read a fixed amount of chars. Also, the name length
+	 * may vary by one char (SOM6867 vs. SOM-6867).
+	 */
+	ret = imanager_read(ec, EC_CMD_FW_INFO_RD, &msg);
+	if (ret)
+		return ret;
+
+	if (!strchr(pcb_name, '-'))
+		pcb_name[IMANAGER_PCB_NAME_LEN - 2] = '\0';
+
+	return scnprintf(info->version, sizeof(info->version),
+			 "%s_k%d.%d_f%d.%d_%s", pcb_name, info->kernel_major,
+			 info->kernel_minor, info->firmware_major,
+			 info->firmware_minor, info->type);
+}
+
+static int imanager_ec_init(struct imanager_ec_data *ec)
+{
+	int ret;
+
+	/* Prevent firmware lock */
+	inb(IT8528_DAT_PORT);
+	inb(IT8518_DAT_PORT);
+
+	ret = imanager_read_firmware_version(ec);
+	if (ret < 0)
+		return ret;
+
+	return imanager_read_device_config(ec);
+}
+
+static inline void data_to_ec(struct imanager_io_ops *io, u8 *data, u8 len,
+			      int offset)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		io->write(offset++, data[i]);
+}
+
+static inline void data_from_ec(struct imanager_io_ops *io, u8 *data, u8 len,
+				int offset)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		data[i] = io->read(offset++);
+}
+
+static int imanager_msg_xfer(struct imanager_ec_data *ec, u8 cmd,
+			     struct imanager_ec_message *msg, bool payload)
+{
+	int ret;
+	int offset = EC_MSG_OFFSET_DATA;
+
+	ret = imanager_check_ec_ready(&ec->io);
+	if (ret)
+		return ret;
+
+	ec->io.write(EC_MSG_OFFSET_PARAM, msg->param);
+
+	if (msg->wlen) {
+		if (msg->data) {
+			data_to_ec(&ec->io, msg->data, msg->wlen, offset);
+			ec->io.write(EC_MSG_OFFSET_LEN, msg->wlen);
+		} else {
+			data_to_ec(&ec->io, msg->u.data, msg->wlen, offset);
+		}
+	}
+
+	/* Execute command */
+	ec->io.write(EC_MSG_OFFSET_CMD, cmd);
+	ret = imanager_check_ec_ready(&ec->io);
+	if (ret)
+		return ret;
+
+	/* GPIO and I2C have different success return values */
+	ret = ec->io.read(EC_MSG_OFFSET_STATUS);
+	if ((ret != EC_F_SUCCESS) && !(ret & EC_F_CMD_COMPLETE))
+		return -EFAULT;
+	/*
+	 * EC I2C may return an error code which we need to handoff
+	 * to the caller
+	 */
+	else if (ret & 0x007e)
+		return ret;
+
+	if (msg->rlen) {
+		if (msg->rlen == EC_F_HWMON_MSG)
+			msg->rlen = ec->io.read(EC_MSG_OFFSET_LEN);
+		if (payload) /* i2c, hwmon, wdt */
+			offset = EC_MSG_OFFSET_PAYLOAD;
+		if (msg->data)
+			data_from_ec(&ec->io, msg->data, msg->rlen, offset);
+		else
+			data_from_ec(&ec->io, msg->u.data, msg->rlen, offset);
+	}
+
+	return 0;
+}
+
+/**
+ * imanager_read_ram - read 'size' amount of data @ 'offset' of 'ram_type'
+ * @ec:		imanager_ec_data structure describing the EC
+ * @ram_type:	RAM type such as ACPI, HW, or EXternal
+ * @offset:	offset within the RAM segment
+ * @data:	data pointer
+ * @len:	data length
+ */
+int imanager_read_ram(struct imanager_ec_data *ec, int ram_type, u8 offset,
+		      u8 *data, u8 len)
+{
+	int ret;
+
+	ret = imanager_check_ec_ready(&ec->io);
+	if (ret)
+		return ret;
+
+	ec->io.write(EC_MSG_OFFSET_PARAM, ram_type);
+	ec->io.write(EC_MSG_OFFSET_DATA, offset);
+	ec->io.write(EC_MSG_OFFSET_LEN, len);
+	ec->io.write(EC_MSG_OFFSET_CMD, EC_CMD_RAM_RD);
+
+	ret = imanager_check_ec_ready(&ec->io);
+	if (ret)
+		return ret;
+
+	ret = ec->io.read(EC_MSG_OFFSET_STATUS);
+	if (ret != EC_F_SUCCESS)
+		return -EIO;
+
+	data_from_ec(&ec->io, data, len, EC_MSG_OFFSET_RAM_DATA);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imanager_read_ram);
+
+/**
+ * imanager_write_ram - write 'len' amount of data @ 'offset' of 'ram_type'
+ * @ec:		imanager_ec_data structure describing the EC
+ * @ram_type:	RAM type such as ACPI, HW, or EXternal
+ * @offset:	offset within the RAM segment
+ * @data:	data pointer
+ * @len:	data length
+ */
+int imanager_write_ram(struct imanager_ec_data *ec, int ram_type, u8 offset,
+		       u8 *data, u8 len)
+{
+	int ret;
+
+	ret = imanager_check_ec_ready(&ec->io);
+	if (ret)
+		return ret;
+
+	ec->io.write(EC_MSG_OFFSET_PARAM, ram_type);
+	ec->io.write(EC_MSG_OFFSET_DATA, offset);
+	ec->io.write(EC_MSG_OFFSET_LEN, len);
+
+	data_to_ec(&ec->io, data, len, EC_MSG_OFFSET_RAM_DATA);
+
+	ec->io.write(EC_MSG_OFFSET_CMD, EC_CMD_RAM_WR);
+
+	ret = imanager_check_ec_ready(&ec->io);
+	if (ret)
+		return ret;
+
+	ret = ec->io.read(EC_MSG_OFFSET_STATUS);
+	if (ret != EC_F_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imanager_write_ram);
+
+/**
+ * imanager_read - read data through request/response messaging
+ * @ec:		imanager_ec_data structure describing the EC
+ * @cmd:	imanager EC firmware command
+ * @msg:	imanager_ec_message structure holding the message
+ */
+int imanager_read(struct imanager_ec_data *ec, u8 cmd,
+		  struct imanager_ec_message *msg)
+{
+	return imanager_msg_xfer(ec, cmd, msg, false);
+}
+EXPORT_SYMBOL_GPL(imanager_read);
+
+/**
+ * imanager_write - write data through request/response messaging
+ * @ec:		imanager_ec_data structure describing the EC
+ * @cmd:	imanager EC firmware command
+ * @msg:	imanager_ec_message structure holding the message
+ */
+int imanager_write(struct imanager_ec_data *ec, u8 cmd,
+		   struct imanager_ec_message *msg)
+{
+	return imanager_msg_xfer(ec, cmd, msg, true);
+}
+EXPORT_SYMBOL_GPL(imanager_write);
+
+/**
+ * imanager_read8 - read 8-bit data
+ * @ec:		imanager_ec_data structure describing the EC
+ * @cmd:	imanager EC firmware command
+ * @param:	parameter depening on cmd - device ID, offset or unit number
+ */
+int imanager_read8(struct imanager_ec_data *ec, u8 cmd, u8 param)
+{
+	int ret;
+	struct imanager_ec_message msg = {
+		.rlen = 1,
+		.wlen = 0,
+		.param = param,
+		.data = NULL,
+	};
+
+	ret = imanager_read(ec, cmd, &msg);
+	if (ret)
+		return ret;
+
+	return msg.u.data[0];
+}
+EXPORT_SYMBOL_GPL(imanager_read8);
+
+/**
+ * imanager_read16 - read 16-bit data
+ * @ec:		imanager_ec_data structure describing the EC
+ * @cmd:	imanager EC firmware command
+ * @param:	parameter depening on cmd - device ID, offset or unit number
+ */
+int imanager_read16(struct imanager_ec_data *ec, u8 cmd, u8 param)
+{
+	int ret;
+	struct imanager_ec_message msg = {
+		.rlen = 2,
+		.wlen = 0,
+		.param = param,
+		.data = NULL,
+	};
+
+	ret = imanager_read(ec, cmd, &msg);
+	if (ret)
+		return ret;
+
+	return (msg.u.data[0] << 8 | msg.u.data[1]);
+}
+EXPORT_SYMBOL_GPL(imanager_read16);
+
+/**
+ * imanager_write8 - write 8-bit data
+ * @ec:		imanager_ec_data structure describing the EC
+ * @cmd:	imanager EC firmware command
+ * @param:	parameter depening on cmd - device ID, offset or unit number
+ * @byte:	8-bit data
+ */
+int imanager_write8(struct imanager_ec_data *ec, u8 cmd, u8 param, u8 byte)
+{
+	struct imanager_ec_message msg = {
+		.rlen = 0,
+		.wlen = 1,
+		.param = param,
+		.u = {
+			.data = { byte, 0 },
+		},
+	};
+
+	return imanager_write(ec, cmd, &msg);
+}
+EXPORT_SYMBOL_GPL(imanager_write8);
+
+/**
+ * imanager_write16 - write 16-bit data
+ * @ec:		imanager_ec_data structure describing the EC
+ * @cmd:	imanager EC firmware command
+ * @param:	parameter depening on cmd - device ID, offset or unit number
+ * @word:	16-bit data
+ */
+int imanager_write16(struct imanager_ec_data *ec, u8 cmd, u8 param, u16 word)
+{
+	struct imanager_ec_message msg = {
+		.rlen = 0,
+		.wlen = 2,
+		.param = param,
+		.u = {
+			.data = { (word >> 8), (word & 0xff), 0 },
+		},
+	};
+
+	return imanager_write(ec, cmd, &msg);
+}
+EXPORT_SYMBOL_GPL(imanager_write16);
+
+enum imanager_cells {
+	IMANAGER_BACKLIGHT = 0,
+	IMANAGER_GPIO,
+	IMANAGER_HWMON,
+	IMANAGER_SMB,
+	IMANAGER_WDT,
+};
+
+/**
+ * iManager devices which are available via firmware.
+ */
+
+static const struct mfd_cell imanager_devs[] = {
+	[IMANAGER_BACKLIGHT] = {
+		.name = "imanager-backlight",
+	},
+	[IMANAGER_GPIO] = {
+		.name = "imanager-gpio",
+	},
+	[IMANAGER_HWMON] = {
+		.name = "imanager-hwmon",
+	},
+	[IMANAGER_SMB] = {
+		.name = "imanager-smbus",
+	},
+	[IMANAGER_WDT] = {
+		.name = "imanager-wdt",
+	},
+};
+
+static int imanager_register_cells(struct imanager_device_data *imgr)
+{
+	struct imanager_ec_data *ec = &imgr->ec;
+	struct mfd_cell devs[ARRAY_SIZE(imanager_devs)];
+	int i = 0;
+
+	if (ec->features & IMANAGER_FEATURE_BACKLIGHT)
+		devs[i++] = imanager_devs[IMANAGER_BACKLIGHT];
+
+	if (ec->features & IMANAGER_FEATURE_GPIO)
+		devs[i++] = imanager_devs[IMANAGER_GPIO];
+
+	if (ec->features & IMANAGER_FEATURE_HWMON_ADC)
+		devs[i++] = imanager_devs[IMANAGER_HWMON];
+
+	if (ec->features & IMANAGER_FEATURE_SMBUS)
+		devs[i++] = imanager_devs[IMANAGER_SMB];
+
+	if (ec->features & IMANAGER_FEATURE_WDT)
+		devs[i++] = imanager_devs[IMANAGER_WDT];
+
+	return mfd_add_devices(imgr->dev, -1, devs, i, NULL, 0, NULL);
+}
+
+static struct resource imanager_ioresource = {
+	.start  = IT8528_DAT_PORT,
+	.end    = IT8518_DAT_PORT,
+	.flags  = IORESOURCE_IO,
+};
+
+static ssize_t imanager_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct imanager_device_data *data = dev_get_drvdata(dev);
+	struct imanager_info *info = &data->ec.info;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", info->version);
+}
+
+static ssize_t imanager_chip_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct imanager_device_data *data = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", data->ec.chip_name);
+}
+
+static DEVICE_ATTR(imanager_version, 0444, imanager_version_show, NULL);
+static DEVICE_ATTR(imanager_chip, 0444, imanager_chip_show, NULL);
+
+static struct attribute *imanager_attributes[] = {
+	&dev_attr_imanager_version.attr,
+	&dev_attr_imanager_chip.attr,
+	NULL
+};
+
+static const struct attribute_group imanager_attr_group = {
+	.attrs = imanager_attributes,
+};
+
+static int imanager_platform_create(void)
+{
+	int ret;
+
+	imanager_pdev = platform_device_alloc("imanager", -1);
+	if (!imanager_pdev)
+		return -ENOMEM;
+
+	/* No platform device data required */
+
+	ret = platform_device_add_resources(imanager_pdev,
+					    &imanager_ioresource, 1);
+	if (ret)
+		goto err;
+
+	ret = platform_device_add(imanager_pdev);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	platform_device_put(imanager_pdev);
+	return ret;
+}
+
+static inline int ec_read_chipid(u16 addr)
+{
+	return (ec_inb(addr, CHIP_DEVID_MSB) << 8 |
+		ec_inb(addr, CHIP_DEVID_LSB));
+}
+
+static int imanager_detect_device(struct imanager_device_data *imgr)
+{
+	struct imanager_ec_data *ec = &imgr->ec;
+	struct device *dev = imgr->dev;
+	struct imanager_info *info = &imgr->ec.info;
+	int chipid = ec_read_chipid(EC_BASE_ADDR);
+	int ret;
+
+	if (chipid == CHIP_ID_IT8518) {
+		ec->io.read	= ec_io18_read;
+		ec->io.write	= ec_io18_write;
+		ec->chip_name	= chip_names[IT8518];
+	} else if (chipid == CHIP_ID_IT8528) {
+		ec->io.read	= ec_io28_read;
+		ec->io.write	= ec_io28_write;
+		ec->chip_name	= chip_names[IT8528];
+	}
+
+	ret = imanager_ec_init(ec);
+	if (ret) {
+		dev_err(dev, "iManager firmware communication error\n");
+		return ret;
+	}
+
+	dev_info(dev, "Found Advantech iManager %s: %s (%s)\n",
+		 ec->chip_name, info->version, info->type);
+
+	ret = sysfs_create_group(&dev->kobj, &imanager_attr_group);
+	if (ret)
+		return ret;
+
+	ret = imanager_register_cells(imgr);
+	if (ret)
+		sysfs_remove_group(&dev->kobj, &imanager_attr_group);
+
+	return ret;
+}
+
+static int imanager_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_device_data *imgr;
+
+	imgr = devm_kzalloc(dev, sizeof(*imgr), GFP_KERNEL);
+	if (!imgr)
+		return -ENOMEM;
+
+	imgr->dev = dev;
+	mutex_init(&imgr->lock);
+
+	platform_set_drvdata(pdev, imgr);
+
+	return imanager_detect_device(imgr);
+}
+
+static int imanager_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &imanager_attr_group);
+	mfd_remove_devices(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver imanager_driver = {
+	.driver = {
+		.name  = "imanager",
+	},
+	.probe	= imanager_probe,
+	.remove	= imanager_remove,
+};
+
+static int __init imanager_init(void)
+{
+	int chipid = ec_read_chipid(EC_BASE_ADDR);
+	int ret;
+
+	/* Check for the presence of the EC chip */
+	if ((chipid != CHIP_ID_IT8518) && (chipid != CHIP_ID_IT8528))
+		return -ENODEV;
+
+	ret = imanager_platform_create();
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&imanager_driver);
+}
+
+static void __exit imanager_exit(void)
+{
+	if (imanager_pdev)
+		platform_device_unregister(imanager_pdev);
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
diff --git a/include/linux/mfd/imanager-ec.h b/include/linux/mfd/imanager-ec.h
new file mode 100644
index 0000000..6319b7a
--- /dev/null
+++ b/include/linux/mfd/imanager-ec.h
@@ -0,0 +1,228 @@
+/*
+ * Advantech iManager - firmware interface
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
+#ifndef _LINUX_MFD_IMANAGER_EC_H_
+#define _LINUX_MFD_IMANAGER_EC_H_
+
+#include <linux/types.h>
+
+/* Delay time for port polling in micro seconds */
+#define EC_DELAY_MIN			200UL
+#define EC_DELAY_MAX			250UL
+
+#define EC_MAX_RETRY			400UL
+
+#define CHIP_ID_IT8518			0x8518
+#define CHIP_ID_IT8528			0x8528
+
+#define EC_BASE_ADDR			0x029C
+
+#define IT8528_CMD_PORT			0x029A
+#define IT8528_DAT_PORT			0x0299
+#define IT8518_CMD_PORT			0x029E
+#define IT8518_DAT_PORT			0x029F
+
+/* 16-bit device ID registers */
+#define CHIP_DEVID_MSB			0x20
+#define CHIP_DEVID_LSB			0x21
+
+#define EC_MAX_GPIO_NUM			8UL
+#define EC_MAX_ADC_NUM			5UL
+#define EC_MAX_FAN_NUM			3UL
+#define EC_MAX_BLC_NUM			2UL
+#define EC_MAX_SMB_NUM			4UL
+#define EC_MAX_WDT_NUM			2UL
+
+#define EC_PAYLOAD_SIZE			40UL
+#define EC_MSG_SIZE			sizeof(struct imanager_ec_smb_message)
+#define EC_MSG_HDR_SIZE			sizeof(struct imanager_ec_smb_msg_hdr)
+
+#define EC_MAX_DID			32UL
+
+/*
+ * iManager commands
+ */
+#define EC_CMD_CHK_RDY			0UL
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
+#define EC_CMD_DEV_TBL_RD		0x20UL
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
+ * ACPI RAM offsets
+ */
+#define EC_OFFSET_FAN_ALERT		0x6FUL
+#define EC_OFFSET_FAN_ALERT_LIMIT	0x76UL
+#define EC_OFFSET_BRIGHTNESS1		0x50UL
+#define EC_OFFSET_BRIGHTNESS2		0x52UL
+#define EC_OFFSET_BACKLIGHT_CTRL	0x99UL
+#define EC_OFFSET_FW_RELEASE		0xF8UL
+
+/* iManager flags */
+#define IMANAGER_FEATURE_BACKLIGHT	BIT(0)
+#define IMANAGER_FEATURE_GPIO		BIT(1)
+#define IMANAGER_FEATURE_HWMON_ADC	BIT(2)
+#define IMANAGER_FEATURE_HWMON_FAN	BIT(3)
+#define IMANAGER_FEATURE_SMBUS		BIT(4)
+#define IMANAGER_FEATURE_WDT		BIT(5)
+
+#define EC_IO28_OUTBUF			BIT(0)
+#define EC_IO28_INBUF			BIT(1)
+
+#define EC_F_SUCCESS			BIT(0)
+#define EC_F_CMD_COMPLETE		BIT(7)
+#define EC_F_HWMON_MSG			BIT(9)
+
+/* iManager offsets */
+#define EC_MSG_OFFSET(N)		(0UL + (N))
+#define EC_MSG_OFFSET_CMD		EC_MSG_OFFSET(0)
+#define EC_MSG_OFFSET_STATUS		EC_MSG_OFFSET(1)
+#define EC_MSG_OFFSET_PARAM		EC_MSG_OFFSET(2)
+#define EC_MSG_OFFSET_DATA		EC_MSG_OFFSET(3)
+#define EC_MSG_OFFSET_RAM_DATA		EC_MSG_OFFSET(4)
+#define EC_MSG_OFFSET_PAYLOAD		EC_MSG_OFFSET(7)
+#define EC_MSG_OFFSET_LEN		EC_MSG_OFFSET(0x2F)
+
+/* IT8528 based firmware require a read/write command offset. */
+#define EC_CMD_OFFSET_READ		0xA0UL
+#define EC_CMD_OFFSET_WRITE		0x50UL
+
+#define EC_KERNEL_MINOR(x)		((x) & 0xff)
+#define EC_KERNEL_MAJOR(x)		({ typeof(x) __x = (x >> 8); \
+					((__x >> 4) * 10 + (__x & 0x0f)); })
+#define EC_FIRMWARE_MINOR(x)		EC_KERNEL_MINOR(x)
+#define EC_FIRMWARE_MAJOR(x)		EC_KERNEL_MAJOR(x)
+#define EC_PROJECT_CODE(x)		EC_KERNEL_MINOR(x)
+
+enum imanager_smb_cells { SMB_EEP = 0, I2C_OEM, SMB_1, SMB_PECI };
+
+enum imanager_device_type { ADC = 1, DAC, GPIO, IRQ, PWM, SMB };
+
+enum imanager_device_id {
+	/* GPIO */
+	GPIO0 = 0x10, GPIO1, GPIO2, GPIO3, GPIO4, GPIO5, GPIO6, GPIO7,
+	/* FAN */
+	CPUFAN_2P = 0x20, CPUFAN_4P, SYSFAN1_2P, SYSFAN1_4P, SYSFAN2_2P,
+	SYSFAN2_4P,
+	/* Brightness Control */
+	BRIGHTNESS = 0x26, BRIGHTNESS2 = 0x88,
+	/* SMBus */
+	SMBOEM0	 = 0x28, SMBOEM1, SMBOEM2, SMBEEPROM,
+	SMBTHM0  = 0x2C, SMBTHM1, SMBSECEEP, I2COEM,
+	SMBEEP2K = 0x38, OEMEEP, OEMEEP2K, SMBPECI,
+	/* ADC */
+	CMOSBAT  = 0x50, CMOSBAT_2, CMOSBAT_10,
+	ADC5VS0  = 0x56, ADC5VS0_2, ADC5VS0_10,
+	ADC5VS5  = 0x59, ADC5VS5_2, ADC5VS5_10,
+	ADC33VS0 = 0x5C, ADC33VS0_2, ADC33VS0_10,
+	ADC33VS5 = 0x5F, ADC33VS5_2, ADC33VS5_10,
+	ADC12VS0 = 0x62, ADC12VS0_2, ADC12VS0_10,
+	VCOREA   = 0x65, VCOREA_2, VCOREA_10,
+	CURRENT  = 0x74,
+	/* Watchdog */
+	WDIRQ    = 0x78, WDNMI,
+};
+
+/**
+ * struct imanager_ec_device - Describes iManager EC Device
+ * @did:	iManager Device ID
+ * @type:	iManager Device Type
+ * @scale:	Scaling factor
+ */
+struct imanager_ec_device {
+	unsigned int did;
+	unsigned int type;
+	unsigned int scale;
+};
+
+/**
+ * IMANAGER_EC_DEVICE - macro used to describe a specific iManager device
+ * @device_id:		the 8 bit iManager device ID
+ * @device_type:	the iManager device type
+ * @scaling_factor:	the iManager sensor device scaling factor
+ *
+ * This macro is used to create a struct imanager_ec_device that matches a
+ * specific iManager device
+ */
+#define IMANAGER_EC_DEVICE(device_id, device_type, scaling_factor) \
+	.did = (device_id), .type = (device_type), .scale = (scaling_factor)
+
+/**
+ * struct imanager_io_ops - iManager I/O operation structure
+ * @read:	iManager read call-back
+ * @write:	iManager write call-back
+ */
+struct imanager_io_ops {
+	int (*read)(int cmd);
+	int (*write)(int cmd, int value);
+};
+
+/**
+ * struct imanager_ec_smb_msg_hdr - Defines iManager EC SMBus message header
+ * @addr_low:	low-byte of word address (or data)
+ * @addr_high:	high-byte of word address (or data)
+ * @rlen:	SMB read length
+ * @wlen:	SMB write length
+ * @cmd:	SMB command
+ */
+struct imanager_ec_smb_msg_hdr {
+	unsigned char addr_low;
+	unsigned char addr_high;
+	unsigned char rlen;
+	unsigned char wlen;
+	unsigned char cmd;
+} __attribute__((__packed__));
+
+/**
+ * struct imanager_ec_smb_message - Defines iManager SMBus message
+ * @hdr:	iManager SMBus message header
+ * @data:	iManager SMBus message data field (payload)
+ */
+struct imanager_ec_smb_message {
+	struct imanager_ec_smb_msg_hdr hdr;
+	unsigned char data[EC_PAYLOAD_SIZE];
+} __attribute__((__packed__));
+
+/**
+ * struct imanager_ec_version - Defines iManager EC firmware version structure
+ * @kernel:		iManager EC FW kernel release
+ * @chipid:		iManager EC chip ID
+ * @project_code:	iManager EC FW status
+ * @firmware:		iManager EC FW release
+ */
+struct imanager_ec_version {
+	unsigned short kernel;
+	unsigned short chipid;
+	unsigned short project_code;
+	unsigned short firmware;
+} __attribute__((__packed__));
+
+#endif
diff --git a/include/linux/mfd/imanager.h b/include/linux/mfd/imanager.h
new file mode 100644
index 0000000..32d7af6
--- /dev/null
+++ b/include/linux/mfd/imanager.h
@@ -0,0 +1,221 @@
+/*
+ * Advantech iManager MFD
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
+#ifndef _LINUX_MFD_IMANAGER_H_
+#define _LINUX_MFD_IMANAGER_H_
+
+#include <linux/mutex.h>
+#include <linux/mfd/imanager-ec.h>
+
+#define IMANAGER_PCB_NAME_LEN	9
+#define IMANAGER_VERSION_LEN	40
+
+/**
+ * IMANAGER_MSG_SIMPLE - macro used to describe a simple iManager message
+ * @read_len:	the message read length
+ * @write_len:	the message write length
+ * @parameter:	the message parameter
+ * @_data:	pointer to data field
+ *
+ * This macro is used to create a struct imanager_ec_message used for basic
+ * EC communication
+ */
+#define IMANAGER_MSG_SIMPLE(read_len, write_len, parameter, _data) \
+	.rlen = (read_len), .wlen = (write_len), \
+	.param = (parameter), .data = (_data)
+
+/**
+ * struct imanager_ec_message - Describes iManager EC message
+ * @rlen:	iManager message read length
+ * @wlen:	iManager message write length
+ * @param:	iManager message parameter (offset, id, or unit number)
+ * @u:		union holding struct imanager_ec_smb_message and data field
+ * @data:	pointer to data field
+ */
+struct imanager_ec_message {
+	unsigned int rlen;
+	unsigned int wlen;
+	unsigned int param;
+	union {
+		struct imanager_ec_smb_message smb;
+		unsigned char data[EC_MSG_SIZE];
+	} u;
+
+	unsigned char *data;
+};
+
+/**
+ * struct imanager_device_attribute - Describes iManager Device attribute
+ * @did:	iManager Device ID
+ * @hwp:	iManager Hardware Pin number
+ * @pol:	iManager Device Polarity
+ * @ecdev:	pointer to iManager device table entry
+ */
+struct imanager_device_attribute {
+	unsigned int did;
+	unsigned int hwp;
+	unsigned int pol;
+	const struct imanager_ec_device *ecdev;
+};
+
+/**
+ * struct imanager_gpio_device - Describes iManager GPIO device
+ * @num:	available GPIO pins
+ * @attr:	pointer to array of iManager GPIO device attribute
+ */
+struct imanager_gpio_device {
+	unsigned int num;
+	struct imanager_device_attribute *attr[EC_MAX_GPIO_NUM];
+};
+
+/**
+ * struct imanager_adc_device - Describes iManager ADC device
+ * @num:	available ADC devices
+ * @attr:	pointer to array of iManager ADC device attribute
+ * @label	pointer to ADC label
+ */
+struct imanager_adc_device {
+	unsigned int num;
+	struct imanager_device_attribute *attr[EC_MAX_ADC_NUM];
+	const char *label[EC_MAX_ADC_NUM];
+};
+
+/**
+ * struct imanager_fan_device - Describes iManager FAN device
+ * @num:	available FAN devices
+ * @attr:	pointer to array of iManager FAN device attribute
+ * @label	pointer to FAN label
+ * @temp_label	pointer to FAN temperature label
+ */
+struct imanager_fan_device {
+	unsigned int num;
+	struct imanager_device_attribute *attr[EC_MAX_FAN_NUM];
+	const char *label[EC_MAX_FAN_NUM];
+	const char *temp_label[EC_MAX_FAN_NUM];
+};
+
+/**
+ * struct imanager_hwmon_device - Describes iManager hwmon device
+ * @adc:	iManager ADC device
+ * @fan:	iManager FAN device
+ */
+struct imanager_hwmon_device {
+	struct imanager_adc_device adc;
+	struct imanager_fan_device fan;
+};
+
+/**
+ * struct imanager_i2c_device - Describes iManager I2C device
+ * @num:	available I2C devices
+ * @attr:	pointer to array of iManager GPIO device attribute
+ */
+struct imanager_i2c_device {
+	unsigned int num;
+	struct imanager_device_attribute *attr[EC_MAX_SMB_NUM];
+};
+
+/**
+ * struct imanager_backlight_device - Describes iManager backlight device
+ * @num:	available backlight devices
+ * @attr:	pointer to array of iManager backlight device attribute
+ * @brightnes:	array of brightness devices
+ */
+struct imanager_backlight_device {
+	unsigned int num;
+	struct imanager_device_attribute *attr[EC_MAX_BLC_NUM];
+	unsigned char brightness[EC_MAX_BLC_NUM];
+};
+
+/**
+ * struct imanager_watchdog_device - Describes iManager watchdog device
+ * @num:	available WD devices
+ * @attr:	pointer to array of iManager watchdog device attribute
+ */
+struct imanager_watchdog_device {
+	unsigned int num;
+	struct imanager_device_attribute *attr[EC_MAX_BLC_NUM];
+};
+
+/**
+ * struct imanager_info - iManager device information structure
+ * @kernel_major:	iManager EC kernel major revision
+ * @kernel_minor:	iManager EC kernel minor revision
+ * @firmware_major:	iManager EC firmware major revision
+ * @firmware_minor:	iManager EC firmware minor revision
+ * @type:		iManager type - release/debug/custom
+ * @pcb_name:		PC board name
+ * @version:		iManager version string
+ */
+struct imanager_info {
+	unsigned int kernel_major;
+	unsigned int kernel_minor;
+	unsigned int firmware_major;
+	unsigned int firmware_minor;
+	const char *type;
+	char version[IMANAGER_VERSION_LEN];
+};
+
+/**
+ * struct imanager_ec_data - iManager EC data structure
+ * @features:	iManager feature mask
+ * @attr:	array of iManager device attribute structure
+ * @io:		imanager_io_ops structure providing I/O operations
+ * @gpio:	iManager GPIO device structure
+ * @hwmon:	iManager Hardware monitor device structure
+ * @i2c:	iManager I2C/SMBus device structure
+ * @bl:		iManager Backlight/Brightness device structure
+ * @wdt:	iManager Watchdog device structure
+ */
+struct imanager_ec_data {
+	unsigned int features;
+	const char *chip_name;
+	struct imanager_device_attribute	attr[EC_MAX_DID];
+	struct imanager_io_ops			io;
+	struct imanager_gpio_device		gpio;
+	struct imanager_hwmon_device		hwmon;
+	struct imanager_i2c_device		i2c;
+	struct imanager_backlight_device	bl;
+	struct imanager_watchdog_device		wdt;
+	struct imanager_info			info;
+};
+
+/**
+ * struct imanager_device_data - Internal representation of the iManager device
+ * @ec:		iManager data structure describing the EC
+ * @dev:	Pointer to kernel device structure
+ * @lock:	iManager mutex
+ */
+struct imanager_device_data {
+	struct imanager_ec_data	ec;
+	struct device	*dev;
+	struct mutex	lock; /* generic mutex for imanager core */
+};
+
+enum ec_ram_type { EC_RAM_ACPI = 1, EC_RAM_HW, EC_RAM_EXT };
+
+int imanager_read(struct imanager_ec_data *ec, u8 cmd,
+		  struct imanager_ec_message *msg);
+int imanager_write(struct imanager_ec_data *ec, u8 cmd,
+		   struct imanager_ec_message *msg);
+
+int imanager_read8(struct imanager_ec_data *ec, u8 cmd, u8 param);
+int imanager_write8(struct imanager_ec_data *ec, u8 cmd, u8 param, u8 byte);
+
+int imanager_read16(struct imanager_ec_data *ec, u8 cmd, u8 param);
+int imanager_write16(struct imanager_ec_data *ec, u8 cmd, u8 param, u16 word);
+
+int imanager_read_ram(struct imanager_ec_data *ec, int ram_type, u8 offset,
+		      u8 *buf, u8 len);
+int imanager_write_ram(struct imanager_ec_data *ec, int ram_type, u8 offset,
+		       u8 *data, u8 size);
+
+#endif
-- 
2.10.1

