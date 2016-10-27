Return-path: <zdoychev@data-modul.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	lee.jones@linaro.org,
	wsa@the-dreams.de,
	linus.walleij@linaro.org,
	wim@iguana.be,
	linux@roeck-us.net
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	gnurou@gmail.com,
	linux-watchdog@vger.kernel.org,
	Zahari Doychev <zahari.doychev@linux.com>
Subject: [RFC PATCH 5/5] rtm-dmec: running time meter support
Date: Thu, 27 Oct 2016 12:47:16 +0200
Message-Id: <dd57adbd7f03b8cca56484105123c10727562e87.1477564996.git-series.zahari.doychev@linux.com>
In-Reply-To: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
References: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
In-Reply-To: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
References: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
List-ID: <linux-watchdog@vger.kernel.org>

This is support for the running time meter(RTM) found on the Data Modul
embedded boards.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 drivers/staging/dmec/Kconfig    |  10 ++-
 drivers/staging/dmec/Makefile   |   1 +-
 drivers/staging/dmec/rtm-dmec.c | 203 +++++++++++++++++++++++++++++++++-
 3 files changed, 214 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/dmec/rtm-dmec.c

diff --git a/drivers/staging/dmec/Kconfig b/drivers/staging/dmec/Kconfig
index eddf0bb..f6f4146 100644
--- a/drivers/staging/dmec/Kconfig
+++ b/drivers/staging/dmec/Kconfig
@@ -38,3 +38,13 @@ config WDT_DMEC
 
 	  To compile this driver as a module, say M here: the module will be
           called wdt-dmec
+
+config RTM_DMEC
+	tristate "Data Modul RTM"
+	depends on MFD_DMEC
+	help
+	  Say Y to enable support for a running time meter(RTM) on a Data Modul
+	  embedded controllers.
+
+	  To compile this driver as a module, say M here: the module will be
+          called wdt-dmec
diff --git a/drivers/staging/dmec/Makefile b/drivers/staging/dmec/Makefile
index 8b363cc..b55d56f 100644
--- a/drivers/staging/dmec/Makefile
+++ b/drivers/staging/dmec/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_MFD_DMEC)		+= dmec-core.o
 obj-$(CONFIG_I2C_DMEC)		+= i2c-dmec.o
 obj-$(CONFIG_GPIO_DMEC) 	+= gpio-dmec.o
 obj-$(CONFIG_WDT_DMEC)		+= wdt-dmec.o
+obj-$(CONFIG_RTM_DMEC)		+= rtm-dmec.o
diff --git a/drivers/staging/dmec/rtm-dmec.c b/drivers/staging/dmec/rtm-dmec.c
new file mode 100644
index 0000000..cd32536
--- /dev/null
+++ b/drivers/staging/dmec/rtm-dmec.c
@@ -0,0 +1,203 @@
+/*
+ * Running time meter for Data Modul AG Embedded Controller
+ *
+ * Copyright (C) 2016 Data Modul AG
+ *
+ * Author: Sebastian Wezel <sebastian@torvus-musica.de>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mutex.h>
+
+#include "dmec.h"
+
+#define DMEC_RTM_RTM_OFFSET             0x60
+#define DMEC_RTM_RTMREV_OFFSET          0x63
+#define DMEC_RTM_OOSRTM_OFFSET          0x64
+#define DMEC_RTM_BTCNT_OFFSET           0x68
+#define DMEC_RTM_BBCTNT_OFFSET          0x6c
+
+static DEFINE_MUTEX(rtm_lock);
+static struct regmap *regmap;
+static bool enable_reset;
+
+static unsigned int dmec_rtm_get_three_byte(unsigned int reg,
+					    struct device *dev)
+{
+	unsigned int low = 0, mid = 0, high = 0, val = 0;
+
+	regmap_read(regmap, reg, &low);
+	regmap_read(regmap, reg + 1, &mid);
+	regmap_read(regmap, reg + 2, &high);
+
+	val = ((high << 16) | (mid << 8) | (low & 0x0000ff));
+	return val;
+}
+
+static ssize_t dmec_rtm_time_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	unsigned int val = 0;
+
+	val = dmec_rtm_get_three_byte(DMEC_RTM_RTM_OFFSET, dev);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t dmec_rtm_time_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t count)
+{
+	unsigned int low = 0, mid = 0, high = 0, higher = 0;
+	long val = 0, ret = -EPERM;
+	int reg = DMEC_RTM_RTM_OFFSET;
+
+	mutex_lock(&rtm_lock);
+	if (enable_reset && !kstrtol(buf, 10, &val)) {
+		higher = (val >> 24) & 0xff;
+		high = (val >> 16) & 0xff;
+		mid = (val >> 8) & 0xff;
+		low = val & 0xff;
+
+		regmap_write(regmap, reg, low);
+		regmap_write(regmap, reg + 1, mid);
+		regmap_write(regmap, reg + 2, high);
+		regmap_write(regmap, reg + 3, higher);
+		enable_reset = false;
+		ret = count;
+	}
+	mutex_unlock(&rtm_lock);
+
+	return ret;
+}
+
+static ssize_t dmec_rtm_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	unsigned int val = 0;
+
+	regmap_read(regmap, DMEC_RTM_RTMREV_OFFSET, &val);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t dmec_rtm_out_of_spec_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	unsigned int val = 0;
+
+	val = dmec_rtm_get_three_byte(DMEC_RTM_OOSRTM_OFFSET, dev);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t dmec_rtm_boot_count_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	unsigned int val = 0;
+
+	val = dmec_rtm_get_three_byte(DMEC_RTM_BTCNT_OFFSET, dev);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t dmec_rtm_bios_boot_count_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	unsigned int val = 0;
+
+	val = dmec_rtm_get_three_byte(DMEC_RTM_BBCTNT_OFFSET, dev);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t dmec_rtm_enable_reset_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", enable_reset);
+}
+
+static ssize_t dmec_rtm_enable_reset_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	long val = 0;
+
+	mutex_lock(&rtm_lock);
+	if (kstrtol(buf, 10, &val) != 0)
+		enable_reset = false;
+
+	/* The enable should only work if the value is 1 */
+	if (val == 1)
+		enable_reset = true;
+	mutex_unlock(&rtm_lock);
+	return count;
+}
+
+static DEVICE_ATTR(rtm_time, 0664, dmec_rtm_time_show, dmec_rtm_time_store);
+static DEVICE_ATTR(rtm_version, 0444, dmec_rtm_version_show, NULL);
+static DEVICE_ATTR(rtm_out_of_spec, 0444, dmec_rtm_out_of_spec_show, NULL);
+static DEVICE_ATTR(rtm_boot_count, 0444, dmec_rtm_boot_count_show, NULL);
+static DEVICE_ATTR(rtm_bios_boot_count, 0444, dmec_rtm_bios_boot_count_show,
+			NULL);
+static DEVICE_ATTR(rtm_enable_reset, 0664, dmec_rtm_enable_reset_show,
+		   dmec_rtm_enable_reset_store);
+
+static struct attribute *rtm_attribute[] = {
+	&dev_attr_rtm_time.attr,
+	&dev_attr_rtm_version.attr,
+	&dev_attr_rtm_out_of_spec.attr,
+	&dev_attr_rtm_boot_count.attr,
+	&dev_attr_rtm_bios_boot_count.attr,
+	&dev_attr_rtm_enable_reset.attr,
+	NULL
+};
+
+static const struct attribute_group rtm_attr_group = {
+	.attrs = rtm_attribute,
+};
+
+static int dmec_rtm_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	regmap = dmec_get_regmap(pdev->dev.parent);
+	enable_reset = 0;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &rtm_attr_group);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int dmec_rtm_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &rtm_attr_group);
+
+	return 0;
+}
+
+static struct platform_driver dmec_rtm_driver = {
+	.driver = {
+			.name = "dmec-rtm",
+			.owner = THIS_MODULE,
+	},
+	.probe = dmec_rtm_probe,
+	.remove = dmec_rtm_remove,
+};
+
+module_platform_driver(dmec_rtm_driver);
+
+MODULE_DESCRIPTION("dmec rtm driver");
+MODULE_AUTHOR("Sebastian Wezel <sebastian@torvus-musica.de>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:dmec-rtm");
-- 
git-series 0.8.10
