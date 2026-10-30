Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358146;
	b=zL/Gp32AFbOn0bgocMBOgCirZGb4Fo30BRbSvr4pZUeAG/8C3PHecfPtu+uVPhNP9YBH
	 wExWi4S4Pw4TTee6B9w75HnWIm7s8R1RunfuYZJiNLG+CmntCC5iSGODAGW00hokERRcg
	 mYGJ24daBuPPUL7rka6TYCoVy8sZsYWCy92ZYESRar4Y6wFrq0wg5pbbWwtWqG+bI7HdP
	 T/ralDqkjrMZpKg1EYcMYtX0v0clDQx9qvaX1hGO8GVHd+HYlNHvhZeuQp2nIjSe8hox7
	 YXdEmLqAlC8ff5rjlKyVeZqzfutsJd89YflyCfiOtjoRQwcMYLdZV5gnyAblpfmy1Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358146;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=EVoQEMG/hIVTEfMrsAYfy831uLlfffuPJ/isNnslcYI=;
	b=bMlTKCgvcxOJlvs3K6saoCmE9G30MjJf2Y133CimwVykv6KtkkZspxzmNC8V2OnaEQ9o
	 hkFZ+lFzTIbH+xH0DzrSzFOeZ5Um3Cg4IQsxfS2IznMURTckLP1Ji1Su6mdfF44yVw2s5
	 ycYNSzFC7OZUFQIaQagMvRE+NXg0WOzSD2ke43wM5Vf7FfLhxDdlH0Q6fGhWXEgDJS3Hn
	 mSYuLZnlVnwkwIXLYfpLC0OyROuJo6q/Rx43Lako3iJS8+rmlj8xY/rHgFNo1hRB+2y07
	 tbLnc3XMsPFGWkYPWYMCED/0Kz59MvI5nYBBqJ5ZIdBylqSx9pPeCfaINF/rooaYong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F094606C6C9;
	Fri, 30 Oct 2026 11:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F094606C6C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0DCB1200009;
	Fri, 30 Oct 2026 12:02:19 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCD5720001C;
	Fri, 30 Oct 2026 12:02:18 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D5C6D180022C;
	Fri, 30 Oct 2026 19:02:17 +0800 (+08)
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
Subject: [PATCH v4 4/4] rtc: pcf8525: Add temperature sensor support via hwmon
Date: Fri, 30 Oct 2026 16:31:39 +0530
Message-Id: <20261030110139.1929109-5-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
References: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
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
 drivers/rtc/Kconfig       |  11 ++
 drivers/rtc/rtc-pcf8525.c | 233 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index bc597af5b4fe..27bca34c2fca 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -527,6 +527,17 @@ config RTC_DRV_PCF8525
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8525.
 
+
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
index f8fbc00bb464..5cb984958f28 100644
--- a/drivers/rtc/rtc-pcf8525.c
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
@@ -152,6 +153,7 @@
 #define PCF8525_WD_MIN_HW_HEARTBEAT_MS	4000
 #define PCF8525_WD_VAL_STOP		0
 #define PCF8525_WD_DEFAULT_TIMEOUT_S	60
+#define PCF8525_CLKOUT_TCR_MASK		GENMASK(7, 5)
 
 #define PCF8525_REG_AGING_OFFSET_HI	0x26
 #define PCF8525_REG_AGING_OFFSET_LO	0x27
@@ -171,6 +173,7 @@ struct pcf8525 {
 	struct regmap *regmap;
 	struct mutex ts_mutex;	/* protects ts[] and ts_valid[] in IRQ mode */
 	bool irq_enabled;
+	bool hwmon_enabled;
 	time64_t ts[2];
 	bool ts_valid[2];
 	int irq_inta;
@@ -346,6 +349,217 @@ static int pcf8525_rtc_set_offset(struct device *dev, long offset)
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
+static void pcf8525_hwmon_disable_temp(void *data)
+{
+	struct pcf8525 *pcf8525 = data;
+
+	/* Disable digital temperature readout on driver removal. */
+	regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
+			   PCF8525_CTRL5_TEMP_RD_EN, 0);
+}
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
+	/* Enable the temperature readout before exposing hwmon attributes. */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
+				 PCF8525_CTRL5_TEMP_RD_EN,
+				 PCF8525_CTRL5_TEMP_RD_EN);
+	if (ret) {
+		dev_warn(dev, "failed to enable temperature readout: %d\n", ret);
+		return;
+	}
+
+	/*
+	 * Register a devm cleanup action to disable the digital
+	 * temperature readout when the driver is unbound.
+	 */
+	if (devm_add_action_or_reset(dev, pcf8525_hwmon_disable_temp, pcf8525)) {
+		dev_warn(dev, "failed to register HWMON cleanup action\n");
+		return;
+	}
+
+	/* Only expose sysfs attributes once the hardware is fully ready. */
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "pcf8525",
+							 pcf8525,
+							 &pcf8525_hwmon_chip_info,
+							 NULL);
+	if (IS_ERR(hwmon_dev)) {
+		dev_warn(dev, "failed to register HWMON device: %ld\n",
+			 PTR_ERR(hwmon_dev));
+		pcf8525_hwmon_disable_temp(pcf8525);
+		return;
+	}
+	pcf8525->hwmon_enabled = true;
+}
+
 static int pcf8525_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
@@ -1209,6 +1423,14 @@ static int pcf8525_suspend(struct device *dev)
 			return ret;
 	}
 
+	/* Disable digital temperature readout (warn-only on failure). */
+	if (IS_ENABLED(CONFIG_RTC_DRV_PCF8525_HWMON) && pcf8525->hwmon_enabled) {
+		ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
+					 PCF8525_CTRL5_TEMP_RD_EN, 0);
+		if (ret)
+			dev_warn(dev, "suspend: failed to disable TEMP_RD_EN: %d\n", ret);
+	}
+
 	return 0;
 }
 
@@ -1226,6 +1448,15 @@ static int pcf8525_resume(struct device *dev)
 			return ret;
 	}
 
+	/* Re-enable digital temperature readout (warn-only on failure). */
+	if (IS_ENABLED(CONFIG_RTC_DRV_PCF8525_HWMON) && pcf8525->hwmon_enabled) {
+		ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
+					 PCF8525_CTRL5_TEMP_RD_EN,
+					 PCF8525_CTRL5_TEMP_RD_EN);
+		if (ret)
+			dev_warn(dev, "resume: failed to restore TEMP_RD_EN: %d\n", ret);
+	}
+
 	return 0;
 }
 
@@ -1343,6 +1574,8 @@ static int pcf8525_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	pcf8525_hwmon_register(dev, pcf8525);
+
 	return 0;
 }
 
-- 
2.34.1

