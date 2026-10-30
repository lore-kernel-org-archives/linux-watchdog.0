Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358145;
	b=aA4leBwMls6mMuA5TlmNurXx4oG9tgn2lDvBHUID8CsZlPy4gvW3cyxEsjZbKKDfij8A
	 hV0s5uGN9ApAk5rRL8Y5GNUJZA6ly8YP2Dxg0wu7CfGhpmhzAa+iHQf8jlvrbdwLfV/oV
	 NDlsXYWfznVa+grwFLUIZ0tfFmd1ErP497K/YLRr2ZmhW3Gtg68hIlCj0GfoemJmJ8xRw
	 5bpy+2EHKpactIzY/iSUiImefOrFGJk+0eEyJIxoj4gpFq+dE51CkCe59W6N9PRQJXnms
	 7xrz998zSFM3UCtaR8kLxJA2mPE4ae9juI68i+LN7AGK8Csr1E8qFKhpXF5cN9sSMbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358145;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=wLL6ajtAU5tC67mFbY4JuQgKgoTDPgsUG71zSA30OzA=;
	b=VByjvVtqxo8HSgpdTaB8HV39W40qkCk4Wz8z8kQIoiZcrM8k1D6DoVu8dt9rqOV5hBaD
	 RRbCMh15EFTXk1QHhCJY+VnLnk+OawcKGe0uXfV7IM69vNSmngAvDjU2nC+Vkwg2M7X/m
	 HzCfCBonx9Rvqcju5grzeqQ0EF0S5FDQvHsiI8pNxK+GiRkw7aWPH4XF7waK97jymxGN8
	 H9dDSPicHdNJxctunK/s080DQgfMUgPFwf+UdPrk3DjpB/4OiPepPHXrOjOBLgZzjQDKj
	 ODVK3Wqd4NXunx6KDQl1auR8rizXCAvSKycJloCAIeQ0feQrRO1SX7rhAiBqvgDZ9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4D606AC25;
	Fri, 30 Oct 2026 11:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB4D606AC25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D697200012;
	Fri, 30 Oct 2026 12:02:17 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FD7D20001A;
	Fri, 30 Oct 2026 12:02:17 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 38BDC1800229;
	Fri, 30 Oct 2026 19:02:16 +0800 (+08)
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
Subject: [PATCH v4 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Date: Fri, 30 Oct 2026 16:31:37 +0530
Message-Id: <20261030110139.1929109-3-shivprakash.gupta@nxp.com>
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

Add a driver for the NXP PCF8525 I2C real-time clock.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
 MAINTAINERS               |    7 +
 drivers/rtc/Kconfig       |   12 +
 drivers/rtc/Makefile      |    1 +
 drivers/rtc/rtc-pcf8525.c | 1112 +++++++++++++++++++++++++++++++++++++
 4 files changed, 1132 insertions(+)
 create mode 100644 drivers/rtc/rtc-pcf8525.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 040df7bfb24f..0394874e5099 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19604,6 +19604,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
 F:	drivers/regulator/pf8x00-regulator.c
 
+NXP PCF8525 RTC DRIVER
+M:	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
+F:	drivers/rtc/rtc-pcf8525.c
+
 NXP PTN5150A CC LOGIC AND EXTCON DRIVER
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 01def8231873..b6c43b173445 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -513,6 +513,18 @@ config RTC_DRV_PCF8523
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8523.
 
+config RTC_DRV_PCF8525
+	tristate "NXP PCF8525"
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the NXP PCF8525 RTC chip.
+	  The PCF8525 is an I2C real-time clock with alarm, external timestamp
+	  capture and recording of the last calendar write, crystal aging offset
+	  correction, and backup power switchover.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf8525.
+
 config RTC_DRV_PCF85363
 	tristate "NXP PCF85363"
 	select REGMAP_I2C
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0347645b021f..2b90d28235c6 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_RTC_DRV_PCF2123)	+= rtc-pcf2123.o
 obj-$(CONFIG_RTC_DRV_PCF2127)	+= rtc-pcf2127.o
 obj-$(CONFIG_RTC_DRV_PCF85063)	+= rtc-pcf85063.o
 obj-$(CONFIG_RTC_DRV_PCF8523)	+= rtc-pcf8523.o
+obj-$(CONFIG_RTC_DRV_PCF8525)	+= rtc-pcf8525.o
 obj-$(CONFIG_RTC_DRV_PCF85363)	+= rtc-pcf85363.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_PCF8583)	+= rtc-pcf8583.o
diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
new file mode 100644
index 000000000000..3c5f15f95a9e
--- /dev/null
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -0,0 +1,1112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * I2C driver for NXP PCF8525 RTC.
+ *
+ * Supports RTC, alarm, timestamp capture, crystal aging correction,
+ * watchdog and optional hwmon temperature readout.
+ */
+
+#include <linux/bcd.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/mutex.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/bitfield.h>
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/pm.h>
+
+/* Registers */
+#define PCF8525_REG_CTRL1		0x00
+#define PCF8525_REG_CTRL2		0x01
+#define PCF8525_REG_CTRL3		0x02
+#define PCF8525_REG_CTRL4		0x03
+#define PCF8525_REG_CTRL5		0x04
+#define PCF8525_REG_RESET		0x05
+
+#define PCF8525_REG_100THS		0x06
+#define PCF8525_REG_SECONDS		0x07
+#define PCF8525_REG_MINUTES		0x08
+#define PCF8525_REG_HOURS		0x09
+#define PCF8525_REG_DAYS		0x0A
+#define PCF8525_REG_WEEKDAYS		0x0B
+#define PCF8525_REG_MONTHS		0x0C
+#define PCF8525_REG_YEARS		0x0D
+
+#define PCF8525_REG_ALM_SEC		0x0E
+#define PCF8525_REG_ALM_MIN		0x0F
+#define PCF8525_REG_ALM_HOUR		0x10
+#define PCF8525_REG_ALM_DAY		0x11
+#define PCF8525_REG_ALM_WDAY		0x12
+#define PCF8525_REG_ALM_MONTH		0x13
+#define PCF8525_REG_ALM_YEAR		0x14
+
+#define PCF8525_REG_CLKOUT		0x15
+
+#define PCF8525_REG_TS_CTL1		0x16
+#define PCF8525_REG_TS1_SEC		0x17
+#define PCF8525_REG_TS1_MIN		0x18
+#define PCF8525_REG_TS1_HOUR		0x19
+#define PCF8525_REG_TS1_DAY		0x1A
+#define PCF8525_REG_TS1_MONTH		0x1B
+#define PCF8525_REG_TS1_YEAR		0x1C
+
+#define PCF8525_REG_TS2_SUBSEC		0x1D
+#define PCF8525_REG_TS2_SEC		0x1E
+#define PCF8525_REG_TS2_MIN		0x1F
+#define PCF8525_REG_TS2_HOUR		0x20
+#define PCF8525_REG_TS2_DAY		0x21
+#define PCF8525_REG_TS2_MONTH		0x22
+#define PCF8525_REG_TS2_YEAR		0x23
+
+#define PCF8525_REG_INTA_MASK1		0x28
+#define PCF8525_REG_INTA_MASK2		0x29
+#define PCF8525_REG_INTB_MASK1		0x2A
+#define PCF8525_REG_INTB_MASK2		0x2B
+
+#define PCF8525_REG_TEMP		0x2E
+
+/* CTRL1 */
+#define PCF8525_CTRL1_STOP		BIT(5)
+#define PCF8525_CTRL1_12_24		BIT(2)
+#define PCF8525_CTRL1_MI		BIT(1)
+#define PCF8525_CTRL1_SI		BIT(0)
+/* CTRL2 */
+#define PCF8525_CTRL2_MSF		BIT(7)
+#define PCF8525_CTRL2_TI_TP		BIT(6)
+#define PCF8525_CTRL2_WDTF		BIT(5)
+#define PCF8525_CTRL2_AF		BIT(4)
+#define PCF8525_CTRL2_OSFE_MASK		GENMASK(3, 2)
+#define PCF8525_CTRL2_AIE		BIT(1)
+#define PCF8525_CTRL2_SMBTO		BIT(0)
+/*
+ * All W0C status bits in CTRL2 (writing 1 = no effect, writing 0 = clear).
+ */
+#define PCF8525_CTRL2_W0C_FLAGS		(PCF8525_CTRL2_MSF | \
+					 PCF8525_CTRL2_WDTF | \
+					 PCF8525_CTRL2_AF)
+/* CTRL3 */
+#define PCF8525_CTRL3_PWRMNG_MASK	GENMASK(6, 5)
+#define PCF8525_CTRL3_BF		BIT(3)
+#define PCF8525_CTRL3_OSIE		BIT(2)
+#define PCF8525_CTRL3_BIE		BIT(1)
+/* CTRL4/5 */
+#define PCF8525_CTRL4_TSF		BIT(7)
+#define PCF8525_CTRL5_TSIE		BIT(7)
+#define PCF8525_CTRL5_TEMP_RD_EN	BIT(2)
+#define PCF8525_CTRL5_CL		BIT(1)
+#define PCF8525_CTRL5_XTL_TYP		BIT(0)
+
+/* CLKOUT_ctl */
+#define PCF8525_CLKOUT_CLKOE		BIT(3)
+
+/* Timestamp control */
+#define PCF8525_TS_CTL1_TSM             BIT(7)
+#define PCF8525_TS_CTL1_TSOFF           BIT(6)
+
+/* Seconds/Minutes flags */
+#define PCF8525_SC_OSF			BIT(7)
+#define PCF8525_MN_VLF			BIT(7)
+
+/* Alarm AE bits */
+#define PCF8525_ALM_AE			BIT(7)
+
+/* RESET commands */
+#define PCF8525_RESET_CPR_CMD		0xA4 /* clear prescaler */
+#define PCF8525_RESET_CTS_CMD		0x25 /* clear timestamp */
+#define PCF8525_RESET_CPR_CTS_CMD	0xA5 /* clear prescaler + timestamp */
+#define PCF8525_RESET_SR_CMD		0x2C /* software reset */
+
+/* Interrupt masks (mask bit = 1 means masked/disabled) - INTA_MASK1 bits */
+#define PCF8525_MASK1_WD_CD		BIT(0)
+#define PCF8525_MASK1_BIE		BIT(1)
+#define PCF8525_MASK1_AIE		BIT(2)
+#define PCF8525_MASK1_OSIE		BIT(3)
+#define PCF8525_MASK1_SI		BIT(4)
+#define PCF8525_MASK1_MI		BIT(5)
+/* INTA_MASK2 - timestamp mask bit3 */
+#define PCF8525_MASK2_TSIE		BIT(3)
+
+#define PCF8525_ALM_AE_MONTH		BIT(7)
+#define PCF8525_ALM_AE_YEAR		BIT(6)
+
+#define PCF8525_REG_AGING_OFFSET_HI	0x26
+#define PCF8525_REG_AGING_OFFSET_LO	0x27
+/*
+ * One aging-offset register step is 0.0298 ppm, or 29.8 ppb.
+ * The RTC core offset interface uses ppb.
+ */
+#define PCF8525_AGING_OFFSET_STEP_NUM	298L
+#define PCF8525_AGING_OFFSET_STEP_DEN	10L
+
+#define PCF8525_AGING_OFFSET_MIN	(-32768L)
+#define PCF8525_AGING_OFFSET_MAX	32767L
+
+struct pcf8525 {
+	struct rtc_device *rtc;
+	struct regmap *regmap;
+	struct mutex ts_mutex;	/* protects ts[] and ts_valid[] in IRQ mode */
+	bool irq_enabled;
+	time64_t ts[2];
+	bool ts_valid[2];
+	int irq_inta;
+};
+
+static const struct regmap_config pcf8525_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PCF8525_REG_TEMP,
+};
+
+/*
+ * Configure only the crystal fields explicitly provided by firmware.
+ * If a property is absent, preserve the current hardware setting.
+ *
+ * quartz-load-femtofarads:
+ *   6000 -> Control_5.CL = 0
+ *   7000 -> Control_5.CL = 1
+ *
+ * nxp,xtal-type:
+ *   1 -> Control_5.XTL_TYP = 0 (-0.035 ppm/degree C^2 model)
+ *   2 -> Control_5.XTL_TYP = 1 (-0.04 ppm/degree C^2 model)
+ */
+static int pcf8525_configure_crystal(struct device *dev,
+				     struct pcf8525 *pcf8525)
+{
+	unsigned int value = 0;
+	unsigned int mask = 0;
+	u32 xtal_type;
+	u32 load;
+	int ret;
+
+	ret = device_property_read_u32(dev,
+				       "quartz-load-femtofarads",
+				       &load);
+	if (!ret) {
+		switch (load) {
+		case 6000:
+			mask |= PCF8525_CTRL5_CL;
+			break;
+
+		case 7000:
+			mask |= PCF8525_CTRL5_CL;
+			value |= PCF8525_CTRL5_CL;
+			break;
+
+		default:
+			dev_warn(dev,
+				 "unsupported quartz-load-femtofarads=%u; "
+				 "preserving CL bit\n",
+				 load);
+			break;
+		}
+	}
+
+	ret = device_property_read_u32(dev,
+				       "nxp,xtal-type",
+				       &xtal_type);
+	if (!ret) {
+		switch (xtal_type) {
+		case 1:
+			mask |= PCF8525_CTRL5_XTL_TYP;
+			break;
+
+		case 2:
+			mask |= PCF8525_CTRL5_XTL_TYP;
+			value |= PCF8525_CTRL5_XTL_TYP;
+			break;
+
+		default:
+			dev_warn(dev,
+				 "unsupported nxp,xtal-type=%u; "
+				 "preserving XTL_TYP bit\n",
+				 xtal_type);
+			break;
+		}
+	}
+
+	if (!mask)
+		return 0;
+
+	return regmap_update_bits(pcf8525->regmap,
+				  PCF8525_REG_CTRL5,
+				  mask, value);
+}
+
+static int pcf8525_read_aging_offset(struct pcf8525 *pcf8525, s16 *offset)
+{
+	u8 buf[2];
+	int ret;
+
+	ret = regmap_bulk_read(pcf8525->regmap,
+			       PCF8525_REG_AGING_OFFSET_HI,
+			       buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	*offset = (s16)((buf[0] << 8) | buf[1]);
+
+	return 0;
+}
+
+static int pcf8525_write_aging_offset(struct pcf8525 *pcf8525, s16 offset)
+{
+	u8 buf[2];
+
+	buf[0] = (offset >> 8) & 0xff;
+	buf[1] = offset & 0xff;
+
+	/*
+	 * Write high byte first and low byte last. The new aging correction
+	 * starts after AgingOffset_Low is written.
+	 */
+	return regmap_bulk_write(pcf8525->regmap,
+				 PCF8525_REG_AGING_OFFSET_HI,
+				 buf, sizeof(buf));
+}
+
+static int pcf8525_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	s16 raw;
+	int ret;
+
+	ret = pcf8525_read_aging_offset(pcf8525, &raw);
+	if (ret)
+		return ret;
+
+	/*
+	 * Convert the signed 16-bit hardware value to ppb:
+	 *
+	 * one raw step = 0.0298 ppm = 29.8 ppb
+	 */
+	*offset = DIV_ROUND_CLOSEST((long)raw *
+				    PCF8525_AGING_OFFSET_STEP_NUM,
+				    PCF8525_AGING_OFFSET_STEP_DEN);
+
+	return 0;
+}
+
+static int pcf8525_rtc_set_offset(struct device *dev, long offset)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	long min_offset;
+	long max_offset;
+	long raw;
+
+	min_offset =
+		DIV_ROUND_CLOSEST(PCF8525_AGING_OFFSET_MIN *
+				  PCF8525_AGING_OFFSET_STEP_NUM,
+				  PCF8525_AGING_OFFSET_STEP_DEN);
+
+	max_offset =
+		DIV_ROUND_CLOSEST(PCF8525_AGING_OFFSET_MAX *
+				  PCF8525_AGING_OFFSET_STEP_NUM,
+				  PCF8525_AGING_OFFSET_STEP_DEN);
+
+	if (offset < min_offset || offset > max_offset)
+		return -ERANGE;
+
+	/*
+	 * Convert the requested ppb value to the closest signed
+	 * 16-bit hardware value.
+	 */
+	raw = DIV_ROUND_CLOSEST(offset *
+				PCF8525_AGING_OFFSET_STEP_DEN,
+				PCF8525_AGING_OFFSET_STEP_NUM);
+
+	if (raw < PCF8525_AGING_OFFSET_MIN ||
+	    raw > PCF8525_AGING_OFFSET_MAX)
+		return -ERANGE;
+
+	return pcf8525_write_aging_offset(pcf8525, (s16)raw);
+}
+
+static int pcf8525_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	u8 buf[7];
+	int ret;
+
+	/* Read seconds..years (0x07..0x0D) */
+	ret = regmap_bulk_read(pcf8525->regmap, PCF8525_REG_SECONDS, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	/* OSF: oscillator stop => time not reliable */
+	if (buf[0] & PCF8525_SC_OSF)
+		return -EINVAL;
+
+	/*
+	 * VLF is on minutes register bit7;
+	 * Keep policy conservative: warn but still allow read.
+	 */
+	if (buf[1] & PCF8525_MN_VLF)
+		dev_warn(dev, "VLF set: clock integrity not guaranteed\n");
+
+	tm->tm_sec =  bcd2bin(buf[0] & 0x7f);
+	tm->tm_min =  bcd2bin(buf[1] & 0x7f);
+	tm->tm_hour = bcd2bin(buf[2] & 0x3f);
+	tm->tm_mday = bcd2bin(buf[3] & 0x3f);
+	tm->tm_wday = buf[4] & 0x07;
+	tm->tm_mon =  bcd2bin(buf[5] & 0x1f) - 1;
+	tm->tm_year = bcd2bin(buf[6]) + 100; /* 20xx */
+
+	return rtc_valid_tm(tm);
+}
+
+static int pcf8525_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	int ret, ret2;
+	u8 buf[8];
+
+	ret = rtc_valid_tm(tm);
+	if (ret)
+		return ret;
+
+	/*
+	 * Use STOP + clear prescaler (CPR) like RESET register describes.
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL1,
+				 PCF8525_CTRL1_STOP, PCF8525_CTRL1_STOP);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_RESET, PCF8525_RESET_CPR_CMD);
+	if (ret)
+		goto out_start;
+
+	buf[0] = 0;                          /* 100th seconds, always zero on set */
+	buf[1] = bin2bcd(tm->tm_sec);
+	buf[2] = bin2bcd(tm->tm_min);
+	buf[3] = bin2bcd(tm->tm_hour);
+	buf[4] = bin2bcd(tm->tm_mday);
+	buf[5] = tm->tm_wday & 0x07;
+	buf[6] = bin2bcd(tm->tm_mon + 1);
+	buf[7] = bin2bcd(tm->tm_year - 100);
+
+	ret = regmap_bulk_write(pcf8525->regmap, PCF8525_REG_100THS, buf, sizeof(buf));
+
+out_start:
+	/* Clear STOP regardless of bulk write outcome */
+	ret2 = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL1, PCF8525_CTRL1_STOP, 0);
+	if (ret2)
+		return ret2;
+	return ret;
+}
+
+static int pcf8525_rtc_ioctl(struct device *dev,
+			     unsigned int cmd, unsigned long arg)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int flags = 0;
+	unsigned int val;
+	int ret;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL3, &val);
+		if (ret)
+			return ret;
+
+		if (val & PCF8525_CTRL3_BF)
+			flags |= RTC_VL_BACKUP_SWITCH;
+
+		return put_user(flags, (unsigned int __user *)arg);
+
+	case RTC_VL_CLR:
+		/* Clear BF by writing 0 (AND semantics respected) */
+		return regmap_update_bits(pcf8525->regmap,
+					  PCF8525_REG_CTRL3,
+					  PCF8525_CTRL3_BF,
+					  0);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static int pcf8525_param_get(struct device *dev, struct rtc_param *param)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int val;
+	unsigned int mode;
+	int ret;
+
+	switch (param->param) {
+	case RTC_PARAM_BACKUP_SWITCH_MODE:
+		ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL3, &val);
+		if (ret)
+			return ret;
+
+		mode = FIELD_GET(PCF8525_CTRL3_PWRMNG_MASK, val);
+
+		switch (mode) {
+		case 0:
+			param->uvalue = RTC_BSM_LEVEL;
+			break;
+		case 1:
+			param->uvalue = RTC_BSM_DIRECT;
+			break;
+		default:
+			param->uvalue = RTC_BSM_DISABLED;
+			break;
+		}
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pcf8525_param_set(struct device *dev, struct rtc_param *param)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int mode;
+
+	switch (param->param) {
+	case RTC_PARAM_BACKUP_SWITCH_MODE:
+		switch (param->uvalue) {
+		case RTC_BSM_LEVEL:
+			mode = 0;
+			break;
+		case RTC_BSM_DIRECT:
+			mode = 1;
+			break;
+		case RTC_BSM_DISABLED:
+			mode = 2;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+	/*
+	 * CTRL3 BF is a W0C bit: include it in the mask with value=1 so the
+	 * RMW cycle does not accidentally clear it if it asserted between the
+	 * regmap read and write.
+	 */
+	return regmap_update_bits(pcf8525->regmap,
+				  PCF8525_REG_CTRL3,
+				  PCF8525_CTRL3_PWRMNG_MASK | PCF8525_CTRL3_BF,
+				  FIELD_PREP(PCF8525_CTRL3_PWRMNG_MASK, mode) |
+				  PCF8525_CTRL3_BF);
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Alarm uses RTC wkalrm: map to sec/min/hour/day and disable others */
+static int pcf8525_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int ctrl2;
+	u8 buf[7];
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(pcf8525->regmap, PCF8525_REG_ALM_SEC, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	alrm->enabled = !!(ctrl2 & PCF8525_CTRL2_AIE);
+	alrm->pending = !!(ctrl2 & PCF8525_CTRL2_AF);
+
+	alrm->time.tm_sec = bcd2bin(buf[0] & 0x7f);
+	alrm->time.tm_min = bcd2bin(buf[1] & 0x7f);
+	alrm->time.tm_hour = bcd2bin(buf[2] & 0x3f);
+	alrm->time.tm_mday = bcd2bin(buf[3] & 0x3f);
+
+	return 0;
+}
+
+static int pcf8525_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * Include all CTRL2 W0C flags in the mask and keep them set to 1 in the
+	 * value so the RMW does not accidentally clear a concurrently asserted
+	 * interrupt flag (AF or MSF).
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
+				 PCF8525_CTRL2_AIE | PCF8525_CTRL2_W0C_FLAGS,
+				 (enable ? PCF8525_CTRL2_AIE : 0) |
+				 PCF8525_CTRL2_W0C_FLAGS);
+	if (ret)
+		dev_err(dev, "alarm_irq_enable: failed ret=%d\n", ret);
+
+	return ret;
+}
+
+static int pcf8525_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	u8 buf[7];
+	int ret;
+
+	/*
+	 * Clear AF (W0C). Use W0C_FLAGS as the mask and preserve MSF and WDTF
+	 * by writing 1 to them: writing 0 to a W0C bit that has asserted
+	 * between the read and write would silently drop the event.
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
+				 PCF8525_CTRL2_W0C_FLAGS,
+				 PCF8525_CTRL2_MSF | PCF8525_CTRL2_WDTF);
+	if (ret)
+		return ret;
+
+	buf[0] = bin2bcd(alrm->time.tm_sec) & 0x7f;
+	buf[1] = bin2bcd(alrm->time.tm_min) & 0x7f;
+	buf[2] = bin2bcd(alrm->time.tm_hour) & 0x3f;
+	buf[3] = bin2bcd(alrm->time.tm_mday) & 0x3f;
+
+	/* Disable match on weekday/month/year by setting AE bits */
+	buf[4] = PCF8525_ALM_AE; /* weekday alarm ignored */
+	buf[5] = PCF8525_ALM_AE_MONTH | PCF8525_ALM_AE_YEAR;  /* disable month + year alarm */
+	buf[6] = 0x00; /* year alarm value (ignored if month/year disabled) */
+
+	ret = regmap_bulk_write(pcf8525->regmap, PCF8525_REG_ALM_SEC, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	return pcf8525_alarm_irq_enable(dev, alrm->enabled);
+}
+
+/* ---- Timestamp handling (sysfs) ---- */
+static int pcf8525_ts_read(struct device *dev, int id, time64_t *ts_out)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	struct rtc_time tm;
+	u8 buf[6];
+	int ret;
+	u8 base;
+
+	/*
+	 * TS0 maps to TS1 (0x17..0x1C)
+	 * TS1 maps to TS2 (0x1E..0x23) (skip subsec at 0x1D)
+	 */
+	if (id == 0)
+		base = PCF8525_REG_TS1_SEC;
+	else if (id == 1)
+		base = PCF8525_REG_TS2_SEC;
+	else
+		return -EINVAL;
+
+	ret = regmap_bulk_read(pcf8525->regmap, base, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	tm.tm_sec = bcd2bin(buf[0] & 0x7f);
+	tm.tm_min = bcd2bin(buf[1] & 0x7f);
+	tm.tm_hour = bcd2bin(buf[2] & 0x3f);
+	tm.tm_mday = bcd2bin(buf[3] & 0x3f);
+	tm.tm_mon = bcd2bin(buf[4] & 0x1f) - 1;
+	tm.tm_year = bcd2bin(buf[5]) + 100;
+
+	ret = rtc_valid_tm(&tm);
+	if (ret)
+		return ret;
+
+	*ts_out = rtc_tm_to_time64(&tm);
+	return 0;
+}
+
+static ssize_t timestamp_show_common(struct device *dev, char *buf, int id)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev->parent);
+	unsigned int ctrl4;
+	time64_t ts;
+	int ret;
+
+	if (id < 0 || id > 1)
+		return -EINVAL;
+
+	/*
+	 * Timestamp2 (id=1) records the last calendar/date-time write.
+	 * It is updated automatically by hardware on every set_time call
+	 * and is not related to the external TS capture event (TSF).
+	 * Always read it directly from the hardware registers.
+	 */
+	if (id == 1) {
+		ret = pcf8525_ts_read(dev->parent, 1, &ts);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);
+	}
+
+	/* id == 0: Timestamp1 = external TS pin capture */
+	if (pcf8525->irq_enabled) {
+		bool valid;
+
+		mutex_lock(&pcf8525->ts_mutex);
+		valid = pcf8525->ts_valid[0];
+		if (valid)
+			ts = pcf8525->ts[0];
+		mutex_unlock(&pcf8525->ts_mutex);
+
+		if (!valid)
+			return 0;
+		return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);
+	}
+
+	/* polling mode: only report if TSF is currently set */
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
+	if (ret)
+		return ret;
+
+	if (!(ctrl4 & PCF8525_CTRL4_TSF))
+		return 0;
+
+	ret = pcf8525_ts_read(dev->parent, 0, &ts);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);
+}
+
+static ssize_t timestamp_store_common(struct device *dev, const char *buf,
+				      size_t count, int id)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev->parent);
+	int ret;
+
+	if (id < 0 || id > 1)
+		return -EINVAL;
+
+	if (pcf8525->irq_enabled) {
+		/*
+		 * Serialize CTS with the IRQ handler. CTS clears the timestamp
+		 * registers and Timestp_ctl1, so invalidate the cache only after
+		 * CTS succeeds, restore TSM, then clear TSF.
+		 */
+		mutex_lock(&pcf8525->ts_mutex);
+
+		ret = regmap_write(pcf8525->regmap, PCF8525_REG_RESET,
+				   PCF8525_RESET_CTS_CMD);
+		if (ret) {
+			mutex_unlock(&pcf8525->ts_mutex);
+			return ret;
+		}
+
+		/* CTS succeeded: hardware registers are now zeroed. */
+		pcf8525->ts_valid[0] = false;
+		pcf8525->ts_valid[1] = false;
+
+		/* Restore TSM=1, TSOFF=0 (CTS cleared 0x16). */
+		ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_TS_CTL1,
+					 PCF8525_TS_CTL1_TSM | PCF8525_TS_CTL1_TSOFF,
+					 PCF8525_TS_CTL1_TSM);
+		if (!ret)
+			ret = regmap_update_bits(pcf8525->regmap,
+						 PCF8525_REG_CTRL4,
+						 PCF8525_CTRL4_TSF, 0);
+		mutex_unlock(&pcf8525->ts_mutex);
+		return ret ? ret : (ssize_t)count;
+	}
+
+	/*
+	 * Polling path: CTS first, then restore TSM=1/TSOFF=0, then clear TSF.
+	 */
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_RESET, PCF8525_RESET_CTS_CMD);
+	if (ret)
+		return ret;
+
+	/* Restore TSM=1, TSOFF=0 (CTS cleared 0x16). */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_TS_CTL1,
+				 PCF8525_TS_CTL1_TSM | PCF8525_TS_CTL1_TSOFF,
+				 PCF8525_TS_CTL1_TSM);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL4,
+				 PCF8525_CTRL4_TSF, 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t timestamp0_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return timestamp_show_common(dev, buf, 0);
+}
+
+static ssize_t timestamp1_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return timestamp_show_common(dev, buf, 1);
+}
+
+static ssize_t timestamp0_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	return timestamp_store_common(dev, buf, count, 0);
+}
+
+static ssize_t timestamp1_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	return timestamp_store_common(dev, buf, count, 1);
+}
+
+static DEVICE_ATTR_RW(timestamp0);
+static DEVICE_ATTR_RW(timestamp1);
+
+static struct attribute *pcf8525_attrs[] = {
+	&dev_attr_timestamp0.attr,
+	&dev_attr_timestamp1.attr,
+	NULL
+};
+
+static const struct attribute_group pcf8525_attr_group = {
+	.attrs = pcf8525_attrs,
+};
+
+static irqreturn_t pcf8525_irq(int irq, void *data)
+{
+	struct device *dev = data;
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	irqreturn_t handled = IRQ_NONE;
+	unsigned int ctrl2, ctrl4;
+	int ret;
+
+	/*
+	 * Drain all pending INTA sources. Re-read the status registers
+	 * because another source may assert while INTA is already low.
+	 */
+	for (;;) {
+		ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
+		if (ret)
+			return handled;
+
+		ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
+		if (ret)
+			return handled;
+
+		if (!(ctrl2 & (PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF)) &&
+		    !(ctrl4 & PCF8525_CTRL4_TSF))
+			break;
+
+		/* Timestamp */
+		if (ctrl4 & PCF8525_CTRL4_TSF) {
+			time64_t ts0;
+			unsigned int ctrl4_now;
+			bool ok0;
+
+			/*
+			 * Serialize against CTS and re-check TSF under the mutex before
+			 * reading the timestamp registers.
+			 */
+			mutex_lock(&pcf8525->ts_mutex);
+
+			ret = regmap_read(pcf8525->regmap,
+					  PCF8525_REG_CTRL4, &ctrl4_now);
+			if (ret) {
+				mutex_unlock(&pcf8525->ts_mutex);
+				return handled;
+			}
+
+			if (!(ctrl4_now & PCF8525_CTRL4_TSF)) {
+				/*
+				 * timestamp_store_common() already issued
+				 * CTS and cleared TSF; registers are zeroed.
+				 * Continue to check AF/MSF below.
+				 */
+				mutex_unlock(&pcf8525->ts_mutex);
+			} else {
+				/*
+				 * TSM=1 retains the first event while TSF is set, so read TS1
+				 * before clearing TSF.
+				 */
+				ok0 = !pcf8525_ts_read(dev, 0, &ts0);
+				if (!ok0) {
+					/*
+					 * TS1 read failed; leave TSF set
+					 * so the event is not silently
+					 * dropped and hardware can
+					 * re-trigger.
+					 */
+					mutex_unlock(&pcf8525->ts_mutex);
+					return handled;
+				}
+
+				/* Acknowledge/re-arm the timestamp event. */
+				ret = regmap_update_bits(pcf8525->regmap,
+							 PCF8525_REG_CTRL4,
+							 PCF8525_CTRL4_TSF, 0);
+				if (ret) {
+					mutex_unlock(&pcf8525->ts_mutex);
+					return handled;
+				}
+
+				if (!pcf8525->ts_valid[0]) {
+					pcf8525->ts[0] = ts0;
+					pcf8525->ts_valid[0] = true;
+				}
+				mutex_unlock(&pcf8525->ts_mutex);
+				handled = IRQ_HANDLED;
+			}
+		}
+
+		/* Alarm */
+		if (ctrl2 & PCF8525_CTRL2_AF) {
+			/* Clear AF while preserving the other CTRL2 W0C flags. */
+			ret = regmap_update_bits(pcf8525->regmap,
+						 PCF8525_REG_CTRL2,
+						 PCF8525_CTRL2_W0C_FLAGS,
+						 PCF8525_CTRL2_MSF |
+						 PCF8525_CTRL2_WDTF);
+			if (ret)
+				return handled;
+			rtc_update_irq(pcf8525->rtc, 1, RTC_IRQF | RTC_AF);
+			handled = IRQ_HANDLED;
+		}
+
+		if (ctrl2 & PCF8525_CTRL2_MSF) {
+			/* Clear MSF while preserving AF and WDTF. */
+			ret = regmap_update_bits(pcf8525->regmap,
+						 PCF8525_REG_CTRL2,
+						 PCF8525_CTRL2_W0C_FLAGS,
+						 PCF8525_CTRL2_AF |
+						 PCF8525_CTRL2_WDTF);
+			if (ret)
+				return handled;
+			handled = IRQ_HANDLED;
+		}
+	}
+
+	return handled;
+}
+
+static const struct rtc_class_ops pcf8525_rtc_ops = {
+	.ioctl = pcf8525_rtc_ioctl,
+	.read_time = pcf8525_read_time,
+	.set_time = pcf8525_set_time,
+	.read_alarm = pcf8525_read_alarm,
+	.set_alarm = pcf8525_set_alarm,
+	.alarm_irq_enable = pcf8525_alarm_irq_enable,
+	.read_offset = pcf8525_rtc_read_offset,
+	.set_offset = pcf8525_rtc_set_offset,
+	.param_get = pcf8525_param_get,
+	.param_set = pcf8525_param_set,
+};
+
+static int pcf8525_get_irqs(struct i2c_client *client, struct pcf8525 *pcf8525)
+{
+	struct device *dev = &client->dev;
+	int irq;
+
+	irq = fwnode_irq_get_byname(dev_fwnode(dev), "inta");
+	if (irq == -ENOENT || irq == -EINVAL)
+		irq = client->irq;
+	else if (irq < 0)
+		return irq;
+	pcf8525->irq_inta = irq;
+
+	return 0;
+}
+
+/*
+ * pcf8525_mask_inta - devm cleanup: re-mask INTA alarm and timestamp
+ * interrupts on driver unbind so the open-drain line is not left asserted.
+ */
+static void pcf8525_mask_inta(void *data)
+{
+	struct pcf8525 *pcf8525 = data;
+	unsigned int m1, m2;
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTA_MASK1, &m1);
+	if (!ret) {
+		m1 |= PCF8525_MASK1_AIE;
+		regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK1, m1);
+	}
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTA_MASK2, &m2);
+	if (!ret) {
+		m2 |= PCF8525_MASK2_TSIE;
+		regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK2, m2);
+	}
+}
+
+static int pcf8525_unmask_irqs_inta(struct pcf8525 *pcf8525)
+{
+	/*
+	 * Mask registers: bit=1 means masked/disabled.
+	 * We want alarm + timestamp unmasked on INTA by default:
+	 * - AIE => mask bit2 must be 0
+	 * - TSIE => mask2 bit3 must be 0
+	 */
+	unsigned int m1, m2;
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTA_MASK1, &m1);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTA_MASK2, &m2);
+	if (ret)
+		return ret;
+
+	m1 |= PCF8525_MASK1_WD_CD;	/* keep watchdog masked on INTA */
+	m1 &= ~PCF8525_MASK1_AIE;	/* unmask alarm interrupt on INTA */
+	m2 &= ~PCF8525_MASK2_TSIE;	/* unmask timestamp interrupt on INTA */
+
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK1, m1);
+	if (ret)
+		return ret;
+
+	return regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK2, m2);
+}
+
+static int pcf8525_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct pcf8525 *pcf8525;
+	int ret;
+
+	pcf8525 = devm_kzalloc(dev, sizeof(*pcf8525), GFP_KERNEL);
+	if (!pcf8525)
+		return -ENOMEM;
+
+	mutex_init(&pcf8525->ts_mutex);
+
+	pcf8525->regmap = devm_regmap_init_i2c(client, &pcf8525_regmap_cfg);
+	if (IS_ERR(pcf8525->regmap))
+		return dev_err_probe(dev, PTR_ERR(pcf8525->regmap),
+				     "failed to init regmap\n");
+
+	i2c_set_clientdata(client, pcf8525);
+
+	ret = pcf8525_get_irqs(client, pcf8525);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get IRQs\n");
+
+	pcf8525->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(pcf8525->rtc))
+		return dev_err_probe(dev, PTR_ERR(pcf8525->rtc),
+				     "failed to allocate RTC device\n");
+
+	pcf8525->rtc->ops = &pcf8525_rtc_ops;
+	pcf8525->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	pcf8525->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	pcf8525->rtc->set_start_time = true;
+
+	clear_bit(RTC_FEATURE_ALARM, pcf8525->rtc->features);
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf8525->rtc->features);
+	set_bit(RTC_FEATURE_BACKUP_SWITCH_MODE, pcf8525->rtc->features);
+
+	/* Use 24-hour mode */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL1,
+				 PCF8525_CTRL1_12_24, 0);
+	if (ret)
+		return ret;
+
+	ret = pcf8525_configure_crystal(dev, pcf8525);
+	if (ret)
+		return ret;
+	/*
+	 * Enable timestamp engine + timestamp interrupt (TSIE).
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_TS_CTL1,
+				 PCF8525_TS_CTL1_TSM | PCF8525_TS_CTL1_TSOFF,
+				 PCF8525_TS_CTL1_TSM);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
+				 PCF8525_CTRL5_TSIE, PCF8525_CTRL5_TSIE);
+	if (ret)
+		return ret;
+
+	/* Create sysfs timestamp0/1 */
+	ret = rtc_add_group(pcf8525->rtc, &pcf8525_attr_group);
+	if (ret)
+		return ret;
+
+	/* Optional IRQ */
+	if (pcf8525->irq_inta > 0) {
+		ret = devm_request_threaded_irq(dev, pcf8525->irq_inta,
+						NULL, pcf8525_irq,
+						IRQF_ONESHOT,
+						dev_name(dev), dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to request INTA IRQ\n");
+
+		pcf8525->irq_enabled = true;
+
+		/*
+		 * Register the INTA cleanup action before unmasking hardware
+		 * interrupt sources. If the unmask step fails, the devm
+		 * unwinding will still re-mask INTA so the line is not left
+		 * asserted on probe failure.
+		 */
+		ret = devm_add_action_or_reset(dev, pcf8525_mask_inta, pcf8525);
+		if (ret)
+			return ret;
+
+		/* Route/unmask alarm + timestamp to INTA by default */
+		ret = pcf8525_unmask_irqs_inta(pcf8525);
+		if (ret)
+			return ret;
+
+		ret = devm_device_init_wakeup(dev);
+		if (ret)
+			return ret;
+
+		ret = devm_pm_set_wake_irq(dev, pcf8525->irq_inta);
+		if (ret)
+			return ret;
+
+		set_bit(RTC_FEATURE_ALARM, pcf8525->rtc->features);
+	}
+
+	/* Register device */
+	ret = devm_rtc_register_device(pcf8525->rtc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id pcf8525_of_match[] = {
+	{ .compatible = "nxp,pcf8525" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcf8525_of_match);
+
+static const struct i2c_device_id pcf8525_i2c_id[] = {
+	{ .name = "pcf8525" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcf8525_i2c_id);
+
+static struct i2c_driver pcf8525_driver = {
+	.driver = {
+		.name = "rtc-pcf8525",
+		.of_match_table = pcf8525_of_match,
+	},
+	.probe = pcf8525_probe,
+	.id_table = pcf8525_i2c_id,
+};
+module_i2c_driver(pcf8525_driver);
+
+MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
+MODULE_AUTHOR("Shiv Prakash Gupta <shivprakash.gupta@nxp.com>");
+MODULE_DESCRIPTION("NXP PCF8525 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

