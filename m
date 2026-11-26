Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677120;
	b=d4MIKpZEICW8X/WXkmqLl0no3q8c9xKAbNOqvKIT+Tgyd9Ya7YTPzAF+kP3X5cZKn+3I
	 +YELvZfaRxWQUK4iYmhnHPxqtzXi0Uf5oYUu7BER/h3brHiHy6iCh3KMY9zkBSnK3lG5v
	 PDtKDaarQKXhs584niQ2wsw5rGB+Pc2jherjEjutcLq3vORq08nKiBzGjK/sVrRQLGd7n
	 YNGt54kxkGHwg4dVTT1wsDbZjN7AmZLTTMdZfBvg+ScKoVDt9A9bp2W2aoBMWEv1xui12
	 KJCaQzZHCz0man6cN8arSBRU/NX0ougI11y6uiPwsamdplLJbQS6Pk4kCERFtHd+G9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677120;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=IpdbXlmbi+WCtLausYX+4t8fpLe5gnoF1KcYEXYiPI8=;
	b=Ib+COx114bxh1W7cAFr+JjhtOFBmdiKmcXuc33yJMmPwizeQFbSIeIQGt6jdHAjE4MdA
	 qDaKnm+0RvYDB7ZAAf8BhbYiFuvyx6g3NKDz2cRLAX8WPHiZXG1Z9UOG8mZQ2cq2ocMAS
	 btsbbdFe/aCmett6FrtqXgAZRVyb4JAT62jctDCmyBIzWh5uhj7GyXPc0/18eaYcwOcTs
	 Knwl9mzjdmJuEwFj/zfgGm3VTLf6ihyB78P4eGSZ8XD91R08Nm+1jpChtMJAyLuHZ1Xb2
	 8e52anKYNaVUYRJYzdmpM7TeXoeigkIrreyqaOEuv8EKoO8/ONtKmzB42FKh4Uk7NXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.13
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836E606A321;
	Thu, 26 Nov 2026 07:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7836E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A5551A000A;
	Thu, 26 Nov 2026 08:11:52 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 43E921A0005;
	Thu, 26 Nov 2026 08:11:52 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1C1B3180022C;
	Thu, 26 Nov 2026 15:11:48 +0800 (+08)
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
Subject: [PATCH v5 4/4] rtc: pcf8525: Add temperature sensor support via hwmon
Date: Thu, 26 Nov 2026 12:41:24 +0530
Message-Id: <20261126071124.2383368-5-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
References: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
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
index 25420e7ad21c..e98dd0468cfb 100644
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
 			return ret;
 	}
 
+	pcf8525_hwmon_register(dev, pcf8525);
+
 	return 0;
 }
 
-- 
2.34.1

