Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B046D562;
	Fri,  7 Aug 2026 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091383; cv=none; b=nUIBZZ52/yvD0WPgC9zmr4JPbuJd3nVXiKiDTetkqDpSKDsap4BbmqER5mSvx6RQgKxme28sBXkjMJchdjP7kW25mGiiMaAdfgp0LmDABxs0RfCwGc8+RyOxyrDXsZ+uybwu2cwR3Ac1o7gUpl5dkNmWn7lFtR7PoDfUsyaHtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091383; c=relaxed/simple;
	bh=eWzubjd4RqtYsSF00PfCz/D9zaAio3gn5rvo28apD9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+f0a9ybtFra9B8WpVt60XU4bdqIMhlanBEz1uU2VrO96YRPZ+ZiZ3JBwhzS+vzEe24/ls/u+HDRJJbaKCLkhNY9Y7ITo6a/5Pmi1cCG2yZxafWsgoI6VIZrLQyeAcOKVHh8AOTzrPZoDL/1xoUkDZxMCTPItp/KhMPro7gCNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B6CC41A0036;
	Fri,  7 Aug 2026 10:29:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E5001A001C;
	Fri,  7 Aug 2026 10:29:39 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4970C18000B0;
	Fri,  7 Aug 2026 16:29:36 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	lakshay.piplani@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: [PATCH 4/4] rtc: pcf8525: Add temperature sensor support via hwmon
Date: Fri,  7 Aug 2026 13:58:55 +0530
Message-Id: <20260807082855.3762394-5-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
References: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Register the PCF8525 internal temperature sensor through the hwmon
interface when CONFIG_RTC_DRV_PCF8525_HWMON is enabled.

Exposes temp1_input (millidegrees Celsius, read-only) and
update_interval (milliseconds, read/write).

Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
 drivers/rtc/Kconfig       |  15 +++
 drivers/rtc/rtc-pcf8525.c | 192 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 6c1c7b3d27b6..b2f8537d602b 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -524,6 +524,21 @@ config RTC_DRV_PCF8525
           This driver can also be built as a module. If so, the module
           will be called rtc-pcf8525.
 
+config RTC_DRV_PCF8525_HWMON
+	bool "HWMON support for NXP PCF8525"
+	depends on RTC_DRV_PCF8525 && HWMON && \
+		   !(RTC_DRV_PCF8525=y && HWMON=m)
+	default y
+	help
+	  Say Y here to expose the PCF8525 internal temperature
+	  sensor through the HWMON interface.
+
+	  This option provides temperature input reporting and allows
+	  the temperature measurement update interval to be configured
+	  from userspace.
+
+	  The interface is registered only when HWMON support is enabled
+
 config RTC_DRV_PCF85363
 	tristate "NXP PCF85363"
 	select REGMAP_I2C
diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
index 4ef648bdfc5b..92bab3231ce7 100644
--- a/drivers/rtc/rtc-pcf8525.c
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -34,6 +34,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
@@ -165,6 +166,7 @@
 #define PCF8525_WD_MIN_HW_HEARTBEAT_MS  4000
 #define PCF8525_WD_VAL_STOP             0
 #define PCF8525_WD_DEFAULT_TIMEOUT_S    60
+#define PCF8525_CLKOUT_TCR_MASK		GENMASK(7, 5)
 
 #define PCF8525_REG_AGING_OFFSET_HI	0x26
 #define PCF8525_REG_AGING_OFFSET_LO	0x27
@@ -570,6 +572,194 @@ static int pcf8525_rtc_set_offset(struct device *dev, long offset)
 	return pcf8525_write_aging_offset(pcf8525, (s16)raw);
 }
 
+static int pcf8525_hwmon_read_temp(struct device *dev, long *temp)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_TEMP, &regval);
+	if (ret)
+		return ret;
+
+	/*
+	 * PCF8525: signed 8-bit, 1 degree C per LSB.
+	 * HWMON requires millidegree Celsius.
+	 */
+	*temp = (long)(s8)(u8)regval * 1000L;
+
+	return 0;
+}
+
+static int pcf8525_hwmon_read_update_interval(struct device *dev, long *val)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int regval;
+	unsigned int tcr;
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CLKOUT, &regval);
+	if (ret)
+		return ret;
+
+	tcr = FIELD_GET(PCF8525_CLKOUT_TCR_MASK, regval);
+
+	switch (tcr) {
+	case 0:
+		*val = 32 * 60 * 1000L;
+		break;
+	case 1:
+		*val = 16 * 60 * 1000L;
+		break;
+	case 2:
+		*val = 8 * 60 * 1000L;
+		break;
+	case 3:
+		*val = 4 * 60 * 1000L;
+		break;
+	case 4:
+		*val = 2 * 60 * 1000L;
+		break;
+	default:
+		*val = 60 * 1000L;
+		break;
+	}
+
+	return 0;
+}
+
+static int pcf8525_hwmon_write_update_interval(struct device *dev, long val)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int tcr;
+
+	switch (val) {
+	case 32 * 60 * 1000L:
+		tcr = 0;
+		break;
+	case 16 * 60 * 1000L:
+		tcr = 1;
+		break;
+	case 8 * 60 * 1000L:
+		tcr = 2;
+		break;
+	case 4 * 60 * 1000L:
+		tcr = 3;
+		break;
+	case 2 * 60 * 1000L:
+		tcr = 4;
+		break;
+	case 60 * 1000L:
+		tcr = 5;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Update only TCR[2:0]; preserve OTPR, CLKOE and COF[2:0]. */
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
+		if (attr == hwmon_temp_input && channel == 0)
+			return 0444;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int pcf8525_hwmon_read(struct device *dev,
+			      enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_chip:
+		if (attr == hwmon_chip_update_interval)
+			return pcf8525_hwmon_read_update_interval(dev, val);
+		break;
+	case hwmon_temp:
+		if (attr == hwmon_temp_input && channel == 0)
+			return pcf8525_hwmon_read_temp(dev, val);
+		break;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int pcf8525_hwmon_write(struct device *dev,
+			       enum hwmon_sensor_types type,
+			       u32 attr, int channel, long val)
+{
+	if (type == hwmon_chip && attr == hwmon_chip_update_interval)
+		return pcf8525_hwmon_write_update_interval(dev, val);
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
+/*
+ * Keep HWMON optional and non-fatal so RTC and watchdog registration remain
+ * usable even if the temperature interface cannot be registered.
+ */
+static void pcf8525_hwmon_register(struct device *dev,
+				   struct pcf8525 *pcf8525)
+{
+	struct device *hwmon_dev;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_RTC_DRV_PCF8525_HWMON))
+		return;
+
+	/* Enable only the digital readout; preserve TSIE, CL and XTL_TYP. */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
+				 PCF8525_CTRL5_TEMP_RD_EN,
+				 PCF8525_CTRL5_TEMP_RD_EN);
+	if (ret) {
+		dev_warn(dev, "failed to enable temperature readout: %d\n", ret);
+		return;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "pcf8525",
+							 pcf8525,
+							 &pcf8525_hwmon_chip_info,
+							 NULL);
+	if (IS_ERR(hwmon_dev))
+		dev_warn(dev, "failed to register HWMON device: %ld\n",
+			 PTR_ERR(hwmon_dev));
+}
+
 static int pcf8525_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
@@ -1143,6 +1333,8 @@ static int pcf8525_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	pcf8525_hwmon_register(dev, pcf8525);
+
 	return 0;
 }
 
-- 
2.34.1

