Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768719;
	b=AglMX6rmMRxczrotJQdKBsw+b/IWKYKeL4PBdYXHCDWf7i0yTdONGK9hnCu7mzEgURka
	 lPmNtkrgRSSjBxWHEj2du14MPZUr1bqUDJkppOzGBEA6gruy9DUOe2uMGbkB5SttRR3vg
	 GJlSb+/xWHBl4SvZRSpoZKK54dWHhGdcqSIrYKPmIyDwtvK+J4mkHDA/hXEmcWknU+QEt
	 EJBjjg1Xo2RAbHIgGGoMPsyEdLST7w9p4rNX4QPlFqLjDSaH9xsntMBPwg0PNMLxW3ksv
	 Qbux8UDhahFBgeD0ssXOfEiuTsqYnHSHcga7ALvw3k33apcVMLkbA5dNlQEdhPkJoBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768719;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=luosMlf5hFcwRLDqAAhP5X/cceODcUD5Jt286kkZr/4=;
	b=GBiZ6fQUSUGDmALSZOixTPlriYaS6v9ZR0LXPTvXENHsAiuW56EJ+hjT9mnPw20IILCm
	 XrUlZ0ogDTp2MHe0ST8drDbERuVyRLElZK/ej9XsF+Buj268VfQT25UVyPx9SZhXA3xFm
	 vp9emAWb5bx33VQSTqQf8KBTrPdH2DCodqw8GHFLGu2R9Xa/omPkopYXOlk/2UswKPaw6
	 DF9UJY2fQtBcH797BFW/vmABrYC4wqHL/gCJN+ILeBvdH5Lr89p4e1MwyqhJ3zCogbw5r
	 QTckgMBQIlp5yrvxFni7uHH2CjY7at6S9XjNq/HOFwKTaokT08I54GSFDci2jfVogVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC16606A31E;
	Fri, 27 Nov 2026 08:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC16606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56B64200066;
	Fri, 27 Nov 2026 09:38:30 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A58D2200058;
	Fri, 27 Nov 2026 09:38:27 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 81A8F18000B6;
	Fri, 27 Nov 2026 16:38:24 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	lakshay.piplani@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: [PATCH v6 4/4] rtc: pcf8525: Add temperature sensor support via hwmon
Date: Fri, 27 Nov 2026 14:08:07 +0530
Message-Id: <20261127083807.2844507-5-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
References: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Expose the PCF8525 on-chip temperature sensor through the hwmon
subsystem as an optional feature controlled by
CONFIG_RTC_DRV_PCF8525_HWMON.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
 drivers/rtc/Kconfig       |  10 +++
 drivers/rtc/rtc-pcf8525.c | 149 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 68b17ad29ed4..d5c3468e9867 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -537,6 +537,16 @@ config RTC_DRV_PCF8525
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8525.
 
+config RTC_DRV_PCF8525_HWMON
+	bool "HWMON support for NXP PCF8525"
+	depends on RTC_DRV_PCF8525 && HWMON && !(RTC_DRV_PCF8525=y && HWMON=m)
+	default y
+	help
+	  Say Y here to expose the PCF8525 on-chip temperature sensor
+	  through the hwmon interface (temp1_input in millidegrees Celsius).
+	  The sensor resolution is 1 degree C.  The measurement interval is
+	  programmable from 1 to 32 minutes via hwmon chip_update_interval.
+
 config RTC_DRV_PCF85363
 	tristate "NXP PCF85363"
 	select REGMAP_I2C
diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
index 3652ead8260e..d1c66922eed3 100644
--- a/drivers/rtc/rtc-pcf8525.c
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * NXP PCF8525 RTC driver with alarm, timestamp and watchdog support.
+ * NXP PCF8525 RTC driver with alarm, timestamp, watchdog and hwmon support.
  *
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCF8525.pdf
  */
 
+#include <linux/array_size.h>
 #include <linux/bcd.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
@@ -13,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/limits.h>
@@ -30,6 +32,7 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/util_macros.h>
 #include <linux/watchdog.h>
 
 #define PCF8525_REG_CTRL1		0x00
@@ -82,8 +85,10 @@
 #define PCF8525_CTRL4_TSF		BIT(7)
 
 #define PCF8525_CTRL5_TSIE		BIT(7)
+#define PCF8525_CTRL5_TEMP_RD_EN	BIT(2)
 #define PCF8525_CTRL5_XTL_TYP		BIT(0)
 
+#define PCF8525_CLKOUT_TCR_MASK		GENMASK(7, 5)
 #define PCF8525_CLKOUT_OTPR		BIT(4)
 #define PCF8525_CLKOUT_CLKOE		BIT(3)
 
@@ -232,6 +237,146 @@ static int pcf8525_rtc_set_offset(struct device *dev, long offset)
 				 buf, sizeof(buf));
 }
 
+static const int pcf8525_hwmon_interval_ms[] = {
+	32 * 60 * 1000,
+	16 * 60 * 1000,
+	8 * 60 * 1000,
+	4 * 60 * 1000,
+	2 * 60 * 1000,
+	60 * 1000,
+};
+
+static int pcf8525_hwmon_read_interval(struct pcf8525 *pcf8525, long *val)
+{
+	unsigned int regval;
+	unsigned int tcr;
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CLKOUT, &regval);
+	if (ret)
+		return ret;
+
+	/* TCR values 5 to 7 all select a period of one minute. */
+	tcr = min_t(unsigned int, FIELD_GET(PCF8525_CLKOUT_TCR_MASK, regval),
+		    ARRAY_SIZE(pcf8525_hwmon_interval_ms) - 1);
+	*val = pcf8525_hwmon_interval_ms[tcr];
+
+	return 0;
+}
+
+static int pcf8525_hwmon_write_interval(struct pcf8525 *pcf8525, long val)
+{
+	unsigned int tcr;
+
+	tcr = find_closest_descending(val, pcf8525_hwmon_interval_ms,
+				      ARRAY_SIZE(pcf8525_hwmon_interval_ms));
+
+	return regmap_update_bits(pcf8525->regmap, PCF8525_REG_CLKOUT,
+				  PCF8525_CLKOUT_TCR_MASK,
+				  FIELD_PREP(PCF8525_CLKOUT_TCR_MASK, tcr));
+}
+
+static umode_t pcf8525_hwmon_is_visible(const void *data,
+					enum hwmon_sensor_types type,
+					u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_chip:
+		if (attr == hwmon_chip_update_interval)
+			return 0644;
+		break;
+	case hwmon_temp:
+		if (attr == hwmon_temp_input)
+			return 0444;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int pcf8525_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int regval;
+	int ret;
+
+	switch (type) {
+	case hwmon_chip:
+		if (attr == hwmon_chip_update_interval)
+			return pcf8525_hwmon_read_interval(pcf8525, val);
+		break;
+	case hwmon_temp:
+		if (attr != hwmon_temp_input)
+			break;
+
+		ret = regmap_read(pcf8525->regmap, PCF8525_REG_TEMP, &regval);
+		if (ret)
+			return ret;
+
+		*val = (s8)regval * 1000L;
+		return 0;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int pcf8525_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long val)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+
+	if (type == hwmon_chip && attr == hwmon_chip_update_interval)
+		return pcf8525_hwmon_write_interval(pcf8525, val);
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_channel_info * const pcf8525_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops pcf8525_hwmon_ops = {
+	.is_visible = pcf8525_hwmon_is_visible,
+	.read = pcf8525_hwmon_read,
+	.write = pcf8525_hwmon_write,
+};
+
+static const struct hwmon_chip_info pcf8525_hwmon_chip_info = {
+	.ops = &pcf8525_hwmon_ops,
+	.info = pcf8525_hwmon_info,
+};
+
+static void pcf8525_hwmon_register(struct device *dev, struct pcf8525 *pcf8525)
+{
+	struct device *hwmon_dev;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_RTC_DRV_PCF8525_HWMON))
+		return;
+
+	/* A cleared TEMP_RD_EN enables the digital readout in register 0x2e. */
+	ret = regmap_clear_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
+				PCF8525_CTRL5_TEMP_RD_EN);
+	if (ret) {
+		dev_warn(dev, "failed to enable temperature readout: %d\n", ret);
+		return;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "pcf8525", pcf8525,
+							 &pcf8525_hwmon_chip_info,
+							 NULL);
+	if (IS_ERR(hwmon_dev))
+		dev_warn(dev, "failed to register hwmon device: %ld\n",
+			 PTR_ERR(hwmon_dev));
+}
+
 static int pcf8525_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
@@ -1225,6 +1370,8 @@ static int pcf8525_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	pcf8525_hwmon_register(dev, pcf8525);
+
 	return 0;
 }
 
-- 
2.34.1

