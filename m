Return-path: <pantelis.antoniou@konsulko.com>
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jean Delvare <jdelvare@suse.com>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 1/7] mfd: Add PTX1K I2CS BootFPGA MFD driver
Date: Fri,  7 Oct 2016 18:21:58 +0300
Message-Id: <1475853724-22557-2-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

The driver allows access to the BootFPGA logic of the I2CS FPGA
@0xfed5000 from the LPC bus. The driver exports debugfs entries
for manipulating registers and device attrs for reading board and
FPGA IDs and switching the active BIOS flash. The client devices
created by the MFD driver depend on the PCB and FPGA version
numbers. PTX1K (etch1) RE boards support only watchdog clients.
Warn on using engineering releases (FPGA version = 0xEE) and
disable clients on revisions known to cause problems.

- watchdog - jnx_ptx1kbf_wdt
- mtd - jnx_ptx1kbf_mtd (etch2)
- hwmon - jnx_ptx1kbf_hwmon (etch2)

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
Signed-off-by: JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/mfd/Kconfig                |  11 +
 drivers/mfd/Makefile               |   1 +
 drivers/mfd/ptx1k-bootfpga.c       | 462 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ptx1k-bootfpga.h |  93 ++++++++
 4 files changed, 567 insertions(+)
 create mode 100644 drivers/mfd/ptx1k-bootfpga.c
 create mode 100644 include/linux/mfd/ptx1k-bootfpga.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 82493d5..a2564ba 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1417,6 +1417,17 @@ config MFD_JUNIPER_I2CS
 	  This driver can be built as a module. If built as a module it will be
 	  called "jnx_i2cs"
 
+config MFD_JUNIPER_PTX1KBF
+	tristate "Juniper PTX1K RCB I2CS BootFPGA"
+	depends on JNX_PTX1K_RCB
+	select MFD_CORE
+	help
+	  Select this to enable the I2CS Boot FPGA multi-function kernel driver.
+	  This FPGA is present on the PTX1K RCB.
+
+	  This driver can be built as a module. If built as a module it will be
+	  called "ptx1k-bootfpga"
+
 config MFD_TWL4030_AUDIO
 	bool "TI TWL4030 Audio"
 	depends on TWL4030_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 215d9cf..1661b82 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -153,6 +153,7 @@ obj-$(CONFIG_MFD_JUNIPER_SAM)	+= sam-core.o
 obj-$(CONFIG_MFD_JUNIPER_EXT_CPLD) += ptxpmb-ext-cpld-core.o
 obj-$(CONFIG_MFD_JUNIPER_CBC)	+= cbc-core.o
 obj-$(CONFIG_MFD_JUNIPER_I2CS)	+= jnx-i2cs-core.o
+obj-$(CONFIG_MFD_JUNIPER_PTX1KBF) += ptx1k-bootfpga.o
 obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
 # ab8500-core need to come after db8500-prcmu (which provides the channel)
 obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
diff --git a/drivers/mfd/ptx1k-bootfpga.c b/drivers/mfd/ptx1k-bootfpga.c
new file mode 100644
index 0000000..5ab2ed2
--- /dev/null
+++ b/drivers/mfd/ptx1k-bootfpga.c
@@ -0,0 +1,462 @@
+/*
+ * Juniper Networks PTX1K RCB I2CS Boot FPGA multi-function core driver
+ *
+ * Copyright (C) 2014 Juniper Networks. All rights reserved.
+ * Author: Georgi Vlaev <gvlaev@juniper.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/ptx1k-bootfpga.h>
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#endif
+
+struct ptx1kbf_core {
+	struct device	*dev;
+	void __iomem	*base;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dir;
+	u8 addr;				/* any register offsset */
+	struct debugfs_blob_wrapper blob;	/* regspace page blob */
+#endif
+};
+
+static struct resource ptx1kbf_resources[] = {
+	{
+		.start	= 0,
+		.end	= 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct mfd_cell ptx1kbf_cells[] = {
+	{
+		.name = "jnx-ptx1kbf-wdt",
+		.num_resources = ARRAY_SIZE(ptx1kbf_resources),
+		.resources = ptx1kbf_resources,
+		.of_compatible = "jnx,ptx1kbf-wdt",
+	}, {
+		.name = "jnx-ptx1kbf-mtd",
+		.num_resources = ARRAY_SIZE(ptx1kbf_resources),
+		.resources = ptx1kbf_resources,
+		.of_compatible = "jnx,ptx1kbf-mtd",
+	}, {
+		.name = "jnx-ptx1kbf-hwmon",
+		.num_resources = ARRAY_SIZE(ptx1kbf_resources),
+		.resources = ptx1kbf_resources,
+		.of_compatible = "jnx,ptx1kbf-hwmon",
+	},
+};
+
+/* ptx1k-bootfpga debugfs */
+#ifdef CONFIG_DEBUG_FS
+/* debugfs: set/get register offset */
+static int bf_debugfs_addr_print(struct seq_file *s, void *p)
+{
+	struct ptx1kbf_core *bf = (struct ptx1kbf_core *)s->private;
+
+	seq_printf(s, "0x%02X\n", bf->addr);
+
+	return 0;
+}
+
+static int bf_debugfs_addr_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, bf_debugfs_addr_print, inode->i_private);
+}
+
+static ssize_t bf_debugfs_addr_write(struct file *file,
+	const char __user *user_buf, size_t count, loff_t *ppos)
+{
+	struct ptx1kbf_core *bf =
+		((struct seq_file *)(file->private_data))->private;
+	unsigned long addr;
+	int err;
+
+	err = kstrtoul_from_user(user_buf, count, 0, &addr);
+	if (err)
+		return err;
+
+	if (addr > ptx1kbf_resources[0].end) {
+		dev_err(bf->dev, "register offset out of range\n");
+		return -EINVAL;
+	}
+	bf->addr = addr;
+
+	return count;
+}
+
+static const struct file_operations bf_debugfs_addr_fops = {
+	.open = bf_debugfs_addr_open,
+	.write = bf_debugfs_addr_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+/* debugfs: set/get register value */
+static int bf_debugfs_val_print(struct seq_file *s, void *p)
+{
+	struct ptx1kbf_core *bf = (struct ptx1kbf_core *)s->private;
+
+	seq_printf(s, "0x%02X\n", ioread8(bf->base + bf->addr));
+
+	return 0;
+}
+
+static int bf_debugfs_val_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, bf_debugfs_val_print, inode->i_private);
+}
+
+static ssize_t bf_debugfs_val_write(struct file *file,
+	const char __user *user_buf, size_t count, loff_t *ppos)
+{
+	struct ptx1kbf_core *bf =
+		((struct seq_file *)(file->private_data))->private;
+	unsigned long value;
+	int err;
+
+	err = kstrtoul_from_user(user_buf, count, 0, &value);
+	if (err)
+		return err;
+
+	iowrite8(value & 0xff, bf->base + bf->addr);
+
+	return count;
+}
+
+static const struct file_operations bf_debugfs_val_fops = {
+	.open = bf_debugfs_val_open,
+	.write = bf_debugfs_val_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static int bf_debugfs_init(struct ptx1kbf_core *bf)
+{
+	struct dentry *file;
+
+	bf->dir = debugfs_create_dir("ptx1k-bootfpga", NULL);
+	if (!bf->dir)
+		return -ENOMEM;
+
+/* Register dump */
+	bf->blob.size = resource_size(&ptx1kbf_resources[0]);
+	bf->blob.data = bf->base;
+
+	file = debugfs_create_blob("reg-dump", S_IFREG | S_IRUSR, bf->dir,
+				   &bf->blob);
+	if (!file)
+		goto err;
+
+/* Any register @base */
+	file = debugfs_create_file("reg-address", (S_IRUGO | S_IWUSR),
+		bf->dir, bf, &bf_debugfs_addr_fops);
+	if (!file)
+		goto err;
+
+	file = debugfs_create_file("reg-value", (S_IRUGO | S_IWUSR),
+		bf->dir, bf, &bf_debugfs_val_fops);
+	if (!file)
+		goto err;
+
+	return 0;
+err:
+	debugfs_remove_recursive(bf->dir);
+	dev_err(bf->dev, "failed to create debugfs entries.\n");
+
+	return -ENOMEM;
+}
+
+static void bf_debugfs_remove(struct ptx1kbf_core *bf)
+{
+	debugfs_remove_recursive(bf->dir);
+}
+#endif /* CONFIG_DEBUG_FS */
+
+/* Export FPGA board revisions and status as device attrs */
+static ssize_t bf_reg_show(struct device *dev, char *buf, u8 reg)
+{
+	struct ptx1kbf_core *bf = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%02x\n", ioread8(bf->base + reg));
+}
+
+static ssize_t bf_version_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return bf_reg_show(dev, buf, BOOT_FPGA_VERSION);
+}
+
+static ssize_t bf_board_id_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return bf_reg_show(dev, buf, BOOT_FPGA_BOARD_ID);
+}
+
+static ssize_t bf_jspec_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return bf_reg_show(dev, buf, BOOT_FPGA_JSPEC_VERSION);
+}
+
+static ssize_t bf_pcb_version_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return bf_reg_show(dev, buf, BOOT_FPGA_PCB_VERSION);
+}
+
+static ssize_t bf_chassis_type_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return bf_reg_show(dev, buf, BOOT_FPGA_CHASSIS_TYPE);
+}
+
+/* active_flash: (BIOS) Switch bethween FlashA and FlashB */
+static ssize_t bf_active_flash_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct ptx1kbf_core *bf = dev_get_drvdata(dev);
+	u8 reg = ioread8(bf->base + BOOT_FPGA_BOOT_CONTROL);
+
+	return sprintf(buf, "%u\n", (u8)(reg & BC_FLASH_SELECT) >> 4);
+}
+
+static ssize_t bf_active_flash_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct ptx1kbf_core *bf = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+	u8 reg;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val > 1)
+		return -EINVAL;
+
+	reg = ioread8(bf->base + BOOT_FPGA_BOOT_CONTROL);
+	reg &= ~BC_FLASH_SELECT;
+	reg |= (u8)((val << 4) & BC_FLASH_SELECT);
+	iowrite8(reg, bf->base + BOOT_FPGA_BOOT_CONTROL);
+
+	return count;
+}
+
+static DEVICE_ATTR(version, S_IRUGO, bf_version_show, NULL);
+static DEVICE_ATTR(board_id, S_IRUGO, bf_board_id_show, NULL);
+static DEVICE_ATTR(jspec_version, S_IRUGO, bf_jspec_version_show, NULL);
+static DEVICE_ATTR(pcb_version, S_IRUGO, bf_pcb_version_show, NULL);
+static DEVICE_ATTR(chassis_type, S_IRUGO, bf_chassis_type_show, NULL);
+static DEVICE_ATTR(active_flash, S_IRUGO | S_IWUSR, bf_active_flash_show,
+		bf_active_flash_store);
+
+static struct attribute *bf_attrs[] = {
+	&dev_attr_version.attr,
+	&dev_attr_board_id.attr,
+	&dev_attr_jspec_version.attr,
+	&dev_attr_pcb_version.attr,
+	&dev_attr_chassis_type.attr,
+	&dev_attr_active_flash.attr,
+	NULL,
+};
+
+static struct attribute_group bf_attr_group = {
+	.attrs = bf_attrs,
+};
+
+/* Check if scratch regs are usable */
+static int bf_scratch_test(struct ptx1kbf_core *bf)
+{
+	u8 i, ii;
+
+	for (i = 0; i < 0xff; i++) {
+		iowrite8(i, bf->base + BOOT_FPGA_SCRATCH1);
+		ii = ioread8(bf->base + BOOT_FPGA_SCRATCH1);
+		if (ii != i) {
+			dev_err(bf->dev, "Scratch(1) write failed: %02x->%02x",
+				i, ii);
+			return -EIO;
+		}
+	}
+
+	for (i = 0; i < 0xff; i++) {
+		iowrite8(i, bf->base + BOOT_FPGA_SCRATCH2);
+		ii = ioread8(bf->base + BOOT_FPGA_SCRATCH2);
+		if (ii != i) {
+			dev_err(bf->dev, "Scratch(2) write failed: %02x->%02x",
+				i, ii);
+			return -EIO;
+		}
+	}
+
+	iowrite8(0, bf->base + BOOT_FPGA_SCRATCH1);
+	iowrite8(0, bf->base + BOOT_FPGA_SCRATCH2);
+
+	return 0;
+}
+
+static int ptx1kbf_probe(struct platform_device *pdev)
+{
+	static struct ptx1kbf_core *bf;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int err, ncells = 0;
+	u8 pcb_version, fpga_version;
+
+	bf = devm_kzalloc(dev, sizeof(struct ptx1kbf_core), GFP_KERNEL);
+	if (!bf)
+		return -ENOMEM;
+
+	bf->dev = dev;
+	dev_set_drvdata(dev, bf);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	bf->base = devm_ioremap_nocache(dev, res->start, resource_size(res));
+	if (IS_ERR(bf->base))
+		return -EADDRNOTAVAIL;
+
+	/* Get the FPGA & PCB versions to filter supported features */
+	fpga_version = ioread8(bf->base + BOOT_FPGA_VERSION),
+	pcb_version = ioread8(bf->base + BOOT_FPGA_PCB_VERSION);
+
+	dev_info(dev, "FPGA version: 0x%02X, PCB version: 0x%02X\n",
+		 fpga_version, pcb_version);
+
+	/* Exit if scratch loop fails */
+	err = bf_scratch_test(bf);
+	if (err)
+		return err;
+
+	/*
+	 * Support matrix.
+	 * PCB version #0 (ETCH1) = Spartan XC3S400AN
+	 * PCB version #1 (ETCH2) = Spartan XC3S700AN
+	 *
+	 * PCB version #0 supported devices
+	 *	- watchdog (FPGA version >= 0x0E)
+	 *	- hwmon & mtd unsupported due to FPGA limitations
+	 *
+	 * PCB version #1 supported devices
+	 *	- watchdog (FPGA version >= 0x0E)
+	 *	- mtd devices (FPGA version > 0x0E)
+	 *	- hwmon (FPGA version > 0x0F ?)
+	 *
+	 * FPGA version 0xEE is "engineering release", warn on usage.
+	 * FPGA version 0xC0 and < 0x0E are unsupported.
+	 */
+
+	/* Engineering release - allow it to run for testing/debug */
+	if (fpga_version == 0xEE) {
+		dev_warn(dev,
+			"0x%02X is engineering release, consider FPGA update",
+			fpga_version);
+	}
+
+	if (fpga_version != 0xC0 && fpga_version >= 0x0E) {
+		/* wdt - any pcb, fpga >= 0x0E && !0xC0 */
+		ncells = 1;
+
+		/* mtd - pcb > 0, fpga >= 0x0F
+		 * Versions bellow 0x0F may cause damage of the flash (!)
+		 */
+		if (pcb_version > 0 && fpga_version > 0x0E)
+			ncells = 2;
+
+		/* hwmon - pcb > 0, fpga > 0x0F (assumption) */
+		if (pcb_version > 0 && fpga_version > 0x0F)
+			ncells = 3;
+
+		err = mfd_add_devices(dev, pdev->id, ptx1kbf_cells,
+				      ncells, res, 0, NULL);
+		if (err)
+			return err;
+	} else {
+		/* Unsupported - known to cause problems: 0xC0, < 0x0E */
+		dev_err(dev,
+			"0x%02X is unsupported version, consider FPGA update",
+			fpga_version);
+	}
+
+	err = sysfs_create_group(&dev->kobj, &bf_attr_group);
+	if (err) {
+		sysfs_remove_group(&dev->kobj, &bf_attr_group);
+		goto err_mfd;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	bf_debugfs_init(bf);
+#endif
+
+	return 0;
+
+err_mfd:
+	mfd_remove_devices(&pdev->dev);
+
+	return err;
+}
+
+static int ptx1kbf_remove(struct platform_device *pdev)
+{
+#ifdef CONFIG_DEBUG_FS
+	struct ptx1kbf_core *bf = dev_get_drvdata(&pdev->dev);
+
+	bf_debugfs_remove(bf);
+#endif
+	sysfs_remove_group(&pdev->dev.kobj, &bf_attr_group);
+	mfd_remove_devices(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id ptx1kbf_of_ids[] = {
+	{ .compatible = "jnx,ptx1k-bootfpga" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ptx1kbf_of_ids);
+
+static struct platform_driver ptx1kbf_driver = {
+	.driver		= {
+		.name	= "ptx1k-bootfpga",
+		.of_match_table = ptx1kbf_of_ids,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ptx1kbf_probe,
+	.remove		= ptx1kbf_remove,
+};
+
+module_platform_driver(ptx1kbf_driver);
+
+MODULE_DESCRIPTION("Juniper Networks PTX1K RCB I2CS Boot FPGA Driver");
+MODULE_AUTHOR("Georgi Vlaev <gvlaev@juniper.net>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ptx1k-bootfpga");
diff --git a/include/linux/mfd/ptx1k-bootfpga.h b/include/linux/mfd/ptx1k-bootfpga.h
new file mode 100644
index 0000000..6a40c95
--- /dev/null
+++ b/include/linux/mfd/ptx1k-bootfpga.h
@@ -0,0 +1,93 @@
+/*
+ * PTX1K I2CS Boot FPGA registers
+ *
+ * Copyright (C) 2014 Juniper Networks. All rights reserved.
+ * Author: Georgi Vlaev <gvlaev@juniper.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __PTX1K_BOOTFPGA_H__
+#define __PTX1K_BOOTFPGA_H__
+
+#include <linux/bitops.h>
+
+#define BOOT_FPGA_SCRATCH1			0x00
+#define BOOT_FPGA_SCRATCH2			0x01
+#define BOOT_FPGA_VERSION			0x02
+#define BOOT_FPGA_JSPEC_VERSION			0x03
+#define BOOT_FPGA_PCB_VERSION			0x04
+#define BOOT_FPGA_BOARD_ID			0x05
+#define BOOT_FPGA_RESET_REASON1			0x06
+#define BOOT_FPGA_RESET_REASON2			0x07
+#define BOOT_FPGA_RESET_CONTROL_AND_STATUS1	0x08
+#define BOOT_FPGA_RESET_CONTROL_AND_STATUS2	0x09
+#define BOOT_FPGA_RESET_CONTROL_AND_STATUS3	0x0a
+#define BOOT_FPGA_BOOT_CONTROL			0x0b
+#define BOOT_FPGA_WATCHDOG_TIMER_THRESHOLD	0x0c
+#define BOOT_FPGA_ERROR_STATUS1			0x0d
+#define BOOT_FPGA_ERROR_STATUS2			0x0e
+#define BOOT_FPGA_ERROR_STATUS3			0x0f
+#define BOOT_FPGA_IRQ_ENABLE1			0x10
+#define BOOT_FPGA_IRQ_STATUS1			0x11
+#define BOOT_FPGA_IRQ_ENABLE2			0x12
+#define BOOT_FPGA_IRQ_STATUS2			0x13
+#define BOOT_FPGA_CHASSIS_TYPE			0x14
+#define BOOT_FPGA_POST_CODE			0x15
+#define BOOT_FPGA_MISC_CONTROL			0x16
+#define BOOT_FPGA_MISC_STATUS			0x17
+#define BOOT_FPGA_CPU_TEMP_MSB			0x18
+#define BOOT_FPGA_CPU_TEMP_LSB			0x19
+#define BOOT_FPGA_PCH_TEMP_MSB			0x1a
+#define BOOT_FPGA_PCH_TEMP_LSB			0x1b
+#define BOOT_FPGA_DIMM1_TEMP_MSB		0x1c
+#define BOOT_FPGA_DIMM1_TEMP_LSB		0x1d
+#define BOOT_FPGA_DIMM2_TEMP_MSB		0x1e
+#define BOOT_FPGA_DIMM2_TEMP_LSB		0x1f
+
+#define BOOT_FPGA_SFPP_USB_SSD_PWR_CONTROL	0x20
+#define BOOT_FPGA_FPGA_ID			0x21
+#define BOOT_FPGA_SPI_FLASH_CONTROL_AND_STATUS	0x22
+#define BOOT_FPGA_PCH_NMI_SLEEP_RT_STATUS	0x23
+#define BOOT_FPGA_PCH_NMI_SLEEP_LATCHED_STATUS	0x24
+
+#define BOOT_FPGA_FLASH_IF_ADDR(a)		(0xe0 + (a))
+#define BOOT_FPGA_FLASH_IF_BYTE_COUNT(a)	(0xe4 + (a))
+#define BOOT_FPGA_FLASH_IF_CONTROL(a)		(0xe8 + (a))
+#define BOOT_FPGA_FLASH_IF_STATUS(a)		(0xec + (a))
+#define BOOT_FPGA_FLASH_IF_WRITE_BUF_ADDR_MSB	0xf0
+#define BOOT_FPGA_FLASH_IF_WRITE_BUF_ADDR_LSB	0xf1
+#define BOOT_FPGA_FLASH_IF_WRITE_BUF_DATA	0xf2
+#define BOOT_FPGA_FLASH_IF_READ_BUF_ADDR_MSB	0xf3
+#define BOOT_FPGA_FLASH_IF_READ_BUF_ADDR_LSB	0xf4
+#define BOOT_FPGA_FLASH_IF_READ_BUF_DATA	0xf5
+
+#define BOOT_FPGA_RU_CONFIG_CONTROL_STATUS	0xf6
+#define BOOT_FPGA_RU_CONFIG_STATUS_DATA_MSB	0xf7
+#define BOOT_FPGA_RU_CONFIG_STATUS_DATA_LSB	0xf8
+#define BOOT_FPGA_RU_CONFIG_ADDR_23_DOWNTO_16	0xf9
+#define BOOT_FPGA_RU_CONFIG_ADDR_15_DOWNTO_8	0xfa
+#define BOOT_FPGA_RU_CONFIG_ADDR_7_DOWNTO_0	0xfb
+
+#define RR1_SW		BIT(7)	/* SW initiated reset */
+#define RR1_WDOG	BIT(6)	/* Watchdog induced reset */
+#define RR1_MSTR	BIT(5)	/* System host (Master RE) initiated reset */
+#define RR1_BUTTON	BIT(4)	/* Front panel button reset */
+#define RR1_POWER_CYCLE	BIT(3)	/* Natural power cycle */
+#define RR1_POWER_FAIL	BIT(2)	/* Power fail */
+#define RR1_THERM_TRIP	BIT(1)	/* CPU thermal trip */
+#define RR1_PCH		BIT(0)	/* PCH initiated reset, e.g TCO timer expiry */
+
+#define RR2_MSMI_FATAL		BIT(3)	/* CPU MSMI# fatal reset */
+#define RR2_CATERR_IERR		BIT(2)	/* CPU CATERR_IERR# induced reset */
+#define RR2_XDP			BIT(1)	/* XDP request reset */
+#define RR2_AUTO_POWER_OFF	BIT(0)	/* Auto power off */
+
+#define BC_WDT_ENA		BIT(6)	/* Watchdog timer enable */
+#define BC_FLASH_SELECT		BIT(4)	/* Flash select enable/status */
+#define WTT_THRESHOLD_MASK	0x3f
+
+#endif /*__PTX1K_BOOTFPGA_H__*/
-- 
1.9.1
