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
Subject: [PATCH 7/7] hwmon: ptx1kbf: Add PTX1K I2CS BootFPGA sensor driver
Date: Fri,  7 Oct 2016 18:22:04 +0300
Message-Id: <1475853724-22557-8-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

The drivers allows reading CPU, PCH and DIMM modules teperatures
from the I2CS FPGA via the SMLink1 to the PCH.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/hwmon/Kconfig             |  17 ++++++
 drivers/hwmon/Makefile            |   1 +
 drivers/hwmon/jnx_ptx1kbf_hwmon.c | 123 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/hwmon/jnx_ptx1kbf_hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b9348d2..5b66c7b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -674,6 +674,23 @@ config SENSORS_JNX_FAN
 	  This driver can also be built as a module.  If so, the module
 	  will be called jnx-fan.
 
+config SENSORS_JNX_PTX1KBF
+	tristate "Juniper Networks PTX1000 I2CS BootFPGA thermal sensors"
+	depends on MFD_JUNIPER_PTX1KBF
+	help
+	  If you say yes here you get support for the hardware
+	  monitoring features of the Juniper Networks PTX1000 I2CS BootFPGA
+	  on the LPC bus. The CPU's digital thermal sensor can be read over
+	  the PECI interface. PECI is connected to the PCH and the PCH's
+	  Management Engine (ME) can be configured to poll CPU and DIMM
+	  temperatures over the PECI interface. Then, it is possible for an
+	  external I2C master (in the I2CS FPGA) to read CPU, DIMM and PCH
+	  temperatures from the PCH over SMLink1 (which is connected to the board
+	  I2C tree).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called jnx_ptx1kbf_hwmon.
+
 config SENSORS_POWR1220
 	tristate "Lattice POWR1220 Power Monitoring"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index eea631e..a3dedef 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_JNX_FAN)   += jnx-fan.o
+obj-$(CONFIG_SENSORS_JNX_PTX1KBF)	+= jnx_ptx1kbf_hwmon.o
 obj-$(CONFIG_SENSORS_JZ4740)	+= jz4740-hwmon.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
 obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
diff --git a/drivers/hwmon/jnx_ptx1kbf_hwmon.c b/drivers/hwmon/jnx_ptx1kbf_hwmon.c
new file mode 100644
index 0000000..a9d6562
--- /dev/null
+++ b/drivers/hwmon/jnx_ptx1kbf_hwmon.c
@@ -0,0 +1,123 @@
+/*
+ * Juniper Networks PTX1K RCB I2CS Boot FPGA hwmon driver
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
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/mfd/ptx1k-bootfpga.h>
+
+#define DRVNAME "jnx-ptx1kbf-hwmon"
+
+struct bf_hwmon {
+	void __iomem *base;
+};
+
+static const char *const bf_temp_label[] = {
+	"CPU", "PCH", "DIMM1", "DIMM2"
+};
+
+static ssize_t bf_show_temp(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct bf_hwmon *hwmon = dev_get_drvdata(dev);
+	int channel = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%d\n", be16_to_cpu(ioread16(hwmon->base +
+				BOOT_FPGA_CPU_TEMP_MSB + (channel * 2))));
+}
+
+static ssize_t bf_show_label(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	int channel = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%s\n", bf_temp_label[channel]);
+}
+
+/* CPU Temp */
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, bf_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, bf_show_label, NULL, 0);
+/* PCH Temp */
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, bf_show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, bf_show_label, NULL, 1);
+/* DIMM1 Temp */
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, bf_show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, bf_show_label, NULL, 2);
+/* DIMM2 Temp */
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, bf_show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, bf_show_label, NULL, 3);
+
+static struct attribute *bf_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_label.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_label.dev_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(bf);
+
+static int bf_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *hwmon_dev;
+	struct bf_hwmon *hwmon;
+	struct resource *mem;
+
+	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "Failed to get platform mmio resource\n");
+		return -ENOENT;
+	}
+
+	hwmon->base = devm_ioremap_nocache(dev, mem->start, resource_size(mem));
+	if (IS_ERR(hwmon->base)) {
+		dev_err(dev, "Failed to ioremap mmio memory\n");
+		return PTR_ERR(hwmon->base);
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "jnx_ptx1kbf",
+							   hwmon, bf_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct platform_driver bf_hwmon_driver = {
+	.probe  = bf_hwmon_probe,
+	.driver = {
+		.name = DRVNAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(bf_hwmon_driver);
+
+MODULE_DESCRIPTION("Juniper Networks PTX1K RCB I2CS Boot FPGA hwmon driver");
+MODULE_AUTHOR("Georgi Vlaev <gvlaev@juniper.net>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRVNAME);
-- 
1.9.1
