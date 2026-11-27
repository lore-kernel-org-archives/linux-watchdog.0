Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768719;
	b=PgkIu0+d9A7bgpdbyfEWb+uO73yXxeen/sWzR1hhvbYvKuDhY8QMzefdgZ0RsnCMhntE
	 mYvSGkXbhAsevZGdTqNz01f6kpIfP2Losc9FBNzJm4+96Cf3QQ0eFB/XNTUGPfyTCfN9Y
	 mqUNNnjKfdKCfREH55QZ4fRrjnu0kIyXdgv/HsJ8XN2Ovpn/XU+1igKJykrZpb7Av8uZj
	 TuzlM865v8YHBZuS/GK9nkaVo9SkYyNuq1o/G7AdqT1nCZuyDECi1ImSjE7JEtD5EpEx6
	 5X9j7Lu2d3xmHF8obIpDgWe7K6xPCKfX8GQ6yhQ6mXK3wBrl26YKRQlAs6BWd61jCxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768719;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=nDEoWtjt0Jy43thX5v1RxBhGypZ16UivKni8TX+ltWg=;
	b=iFbhU2/anRujKnEfzTEuKX7sMTiANRvc3qOLkYVzGKNVQpHbPVh5mZB2xM2TgkPEdkrg
	 jzC6GLzdwkvw03vlo0UpPmjyPPyzw+N8i+BS6AgrV0RBTB0faXGOoTnPoUz7y9S7mad8e
	 XrRqS6aYOa/dM/p90M4f1aN9SXgMomRAzlJ17Jfq+ri+qXv2g7WMeZtpO+KpwgmSCrw7z
	 zxo9x1DA/6NDySv8VyJRSgG9p3dvLPGgXl9IlA5MEctAIe8Ku2QiQwhne/MUbuZjl+kWp
	 5dce6qe7mNv6PdUB+UvY2IjQfxyCLhGlews21T6nOxLeg8cZaweFJQhLoc/KW3NLBeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA7606A324;
	Fri, 27 Nov 2026 08:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EDA7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A57320005C;
	Fri, 27 Nov 2026 09:38:30 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E21CA200077;
	Fri, 27 Nov 2026 09:38:21 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8F3B218000B6;
	Fri, 27 Nov 2026 16:38:18 +0800 (+08)
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
Subject: [PATCH v6 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Date: Fri, 27 Nov 2026 14:08:05 +0530
Message-Id: <20261127083807.2844507-3-shivprakash.gupta@nxp.com>
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

Add a driver for the NXP PCF8525 I2C real-time clock.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
 MAINTAINERS               |   8 +
 drivers/rtc/Kconfig       |  12 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-pcf8525.c | 931 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 952 insertions(+)
 create mode 100644 drivers/rtc/rtc-pcf8525.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ac5128b756e..2b580150feab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20331,6 +20331,14 @@ L:	linux-i3c@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/nxp,p3h2840.yaml
 
+NXP PCF8525 RTC DRIVER
+M:	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
+M:	Lakshay Piplani <lakshay.piplani@nxp.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
+F:	drivers/rtc/rtc-pcf8525.c
+
 NXP PF5300/PF5301/PF5302 PMIC REGULATOR DEVICE DRIVER
 M:	Woodrow Douglass <wdouglass@carnegierobotics.com>
 S:	Maintained
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 73ec9230edfd..848bcde41f2a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -523,6 +523,18 @@ config RTC_DRV_PCF8523
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
index 46f1a0fc2416..08e0d36d7cb9 100644
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
index 000000000000..06ff14a1dbe1
--- /dev/null
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -0,0 +1,931 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP PCF8525 RTC driver with alarm and timestamp support.
+ *
+ * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCF8525.pdf
+ */
+
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/pm_wakeup.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#define PCF8525_REG_CTRL1		0x00
+#define PCF8525_REG_CTRL2		0x01
+#define PCF8525_REG_CTRL3		0x02
+#define PCF8525_REG_CTRL4		0x03
+#define PCF8525_REG_CTRL5		0x04
+#define PCF8525_REG_RESET		0x05
+
+#define PCF8525_REG_100THS		0x06
+#define PCF8525_REG_SECONDS		0x07
+
+#define PCF8525_REG_ALM_SEC		0x0E
+
+#define PCF8525_REG_CLKOUT		0x15
+
+#define PCF8525_REG_TS_CTL1		0x16
+#define PCF8525_REG_TS1_SEC		0x17
+#define PCF8525_REG_TS2_SEC		0x1E
+
+#define PCF8525_REG_AGING_OFFSET_HI	0x26
+
+#define PCF8525_REG_INTA_MASK1		0x28
+#define PCF8525_REG_INTA_MASK2		0x29
+
+#define PCF8525_REG_TEMP		0x2E
+
+#define PCF8525_CTRL1_STOP		BIT(5)
+#define PCF8525_CTRL1_12_24		BIT(2)
+
+#define PCF8525_CTRL2_MSF		BIT(7)
+#define PCF8525_CTRL2_WDTF		BIT(5)
+#define PCF8525_CTRL2_AF		BIT(4)
+#define PCF8525_CTRL2_AIE		BIT(1)
+#define PCF8525_CTRL2_W0C_FLAGS		(PCF8525_CTRL2_MSF | \
+					 PCF8525_CTRL2_WDTF | \
+					 PCF8525_CTRL2_AF)
+
+#define PCF8525_CTRL3_PWRMNG_MASK	GENMASK(6, 5)
+#define PCF8525_CTRL3_BF		BIT(3)
+
+#define PCF8525_PWRMNG_STANDARD		0
+#define PCF8525_PWRMNG_DIRECT		1
+#define PCF8525_PWRMNG_DISABLED		2
+
+#define PCF8525_CTRL4_TSF		BIT(7)
+
+#define PCF8525_CTRL5_TSIE		BIT(7)
+#define PCF8525_CTRL5_XTL_TYP		BIT(0)
+
+#define PCF8525_CLKOUT_OTPR		BIT(4)
+
+#define PCF8525_TS_CTL1_TSM		BIT(7)
+#define PCF8525_TS_CTL1_TSOFF		BIT(6)
+
+#define PCF8525_SC_OSF			BIT(7)
+#define PCF8525_MN_VLF			BIT(7)
+
+#define PCF8525_ALM_AE			BIT(7)
+#define PCF8525_ALM_AE_YEAR		BIT(7)
+#define PCF8525_ALM_AE_MONTH		BIT(6)
+
+#define PCF8525_RESET_CPR_CMD		0xA4
+
+/* A set bit in the INTx_MASKy registers masks the interrupt source. */
+#define PCF8525_MASK1_AIE		BIT(2)
+#define PCF8525_MASK1_ALL		GENMASK(5, 0)
+#define PCF8525_MASK2_TSIE		BIT(3)
+
+#define PCF8525_AGING_STEP_NUM		298L
+#define PCF8525_AGING_STEP_DEN		10L
+
+#define PCF8525_IRQ_MAX_PASSES		16
+
+struct pcf8525 {
+	struct rtc_device *rtc;
+	struct regmap *regmap;
+	struct mutex ts_mutex;	/* protects the TS1 cache and TSF */
+	time64_t ts;
+	bool ts_valid;
+	bool irq_enabled;
+};
+
+static const struct regmap_config pcf8525_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PCF8525_REG_TEMP,
+};
+
+/*
+ * MSF, WDTF and AF are write-0-to-clear. Write 1 to every flag not in @mask
+ * so that a flag set in the meantime is not lost.
+ */
+static int pcf8525_update_ctrl2(struct pcf8525 *pcf8525, unsigned int mask,
+				unsigned int val)
+{
+	return regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
+				  mask | PCF8525_CTRL2_W0C_FLAGS,
+				  val | (PCF8525_CTRL2_W0C_FLAGS & ~mask));
+}
+
+static int pcf8525_configure_crystal(struct device *dev,
+				     struct pcf8525 *pcf8525)
+{
+	u32 val;
+
+	if (!device_property_read_u32(dev, "nxp,xtal-type", &val)) {
+		if (val == 1 || val == 2)
+			return regmap_assign_bits(pcf8525->regmap,
+						  PCF8525_REG_CTRL5,
+						  PCF8525_CTRL5_XTL_TYP,
+						  val == 2);
+
+		dev_warn(dev, "unsupported nxp,xtal-type %u\n", val);
+	}
+
+	return 0;
+}
+
+static int pcf8525_otp_refresh(struct pcf8525 *pcf8525)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_clear_bits(pcf8525->regmap, PCF8525_REG_CLKOUT,
+				PCF8525_CLKOUT_OTPR);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(pcf8525->regmap, PCF8525_REG_CLKOUT,
+			      PCF8525_CLKOUT_OTPR);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(pcf8525->regmap, PCF8525_REG_CLKOUT,
+				val, val & PCF8525_CLKOUT_OTPR,
+				1000, 100000);
+}
+
+static int pcf8525_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	u8 buf[2];
+	s16 raw;
+	int ret;
+
+	ret = regmap_bulk_read(pcf8525->regmap, PCF8525_REG_AGING_OFFSET_HI,
+			       buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	raw = (s16)((buf[0] << 8) | buf[1]);
+	*offset = DIV_ROUND_CLOSEST((long)raw * PCF8525_AGING_STEP_NUM,
+				    PCF8525_AGING_STEP_DEN);
+
+	return 0;
+}
+
+static int pcf8525_rtc_set_offset(struct device *dev, long offset)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	long min_ppb, max_ppb, raw;
+	u8 buf[2];
+
+	min_ppb = DIV_ROUND_CLOSEST(S16_MIN * PCF8525_AGING_STEP_NUM,
+				    PCF8525_AGING_STEP_DEN);
+	max_ppb = DIV_ROUND_CLOSEST(S16_MAX * PCF8525_AGING_STEP_NUM,
+				    PCF8525_AGING_STEP_DEN);
+	if (offset < min_ppb || offset > max_ppb)
+		return -ERANGE;
+
+	raw = DIV_ROUND_CLOSEST(offset * PCF8525_AGING_STEP_DEN,
+				PCF8525_AGING_STEP_NUM);
+	if (raw < S16_MIN || raw > S16_MAX)
+		return -ERANGE;
+
+	buf[0] = (raw >> 8) & 0xff;
+	buf[1] = raw & 0xff;
+
+	/* The new correction takes effect once the low byte is written. */
+	return regmap_bulk_write(pcf8525->regmap, PCF8525_REG_AGING_OFFSET_HI,
+				 buf, sizeof(buf));
+}
+
+static int pcf8525_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	u8 buf[7];
+	int ret;
+
+	ret = regmap_bulk_read(pcf8525->regmap, PCF8525_REG_SECONDS, buf,
+			       sizeof(buf));
+	if (ret)
+		return ret;
+
+	if (buf[0] & PCF8525_SC_OSF)
+		return -EINVAL;
+
+	if (buf[1] & PCF8525_MN_VLF)
+		dev_warn_ratelimited(dev, "VLF set: clock integrity not guaranteed\n");
+
+	tm->tm_sec = bcd2bin(buf[0] & 0x7f);
+	tm->tm_min = bcd2bin(buf[1] & 0x7f);
+	tm->tm_hour = bcd2bin(buf[2] & 0x3f);
+	tm->tm_mday = bcd2bin(buf[3] & 0x3f);
+	tm->tm_wday = buf[4] & 0x07;
+	tm->tm_mon = bcd2bin(buf[5] & 0x1f) - 1;
+	tm->tm_year = bcd2bin(buf[6]) + 100;
+
+	return rtc_valid_tm(tm);
+}
+
+static int pcf8525_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	u8 old_time[7];
+	u8 buf[8];
+	bool refresh_otp;
+	int ret, ret2;
+
+	/*
+	 * Remember OSF, as clearing it needs an OTP refresh. Read the whole
+	 * calendar in one transaction.
+	 */
+	ret = regmap_bulk_read(pcf8525->regmap, PCF8525_REG_SECONDS,
+			       old_time, sizeof(old_time));
+	if (ret)
+		return ret;
+
+	refresh_otp = old_time[0] & PCF8525_SC_OSF;
+
+	ret = regmap_set_bits(pcf8525->regmap, PCF8525_REG_CTRL1,
+			      PCF8525_CTRL1_STOP);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_RESET,
+			   PCF8525_RESET_CPR_CMD);
+	if (!ret) {
+		buf[0] = 0;
+		buf[1] = bin2bcd(tm->tm_sec);
+		buf[2] = bin2bcd(tm->tm_min);
+		buf[3] = bin2bcd(tm->tm_hour);
+		buf[4] = bin2bcd(tm->tm_mday);
+		buf[5] = tm->tm_wday & 0x07;
+		buf[6] = bin2bcd(tm->tm_mon + 1);
+		buf[7] = bin2bcd(tm->tm_year - 100);
+
+		ret = regmap_bulk_write(pcf8525->regmap, PCF8525_REG_100THS,
+					buf, sizeof(buf));
+	}
+
+	ret2 = regmap_clear_bits(pcf8525->regmap, PCF8525_REG_CTRL1,
+				 PCF8525_CTRL1_STOP);
+
+	/* The write cleared OSF, so refresh the OTP even if STOP failed. */
+	if (!ret && refresh_otp) {
+		int otp_ret = pcf8525_otp_refresh(pcf8525);
+
+		if (!ret2)
+			ret2 = otp_ret;
+	}
+
+	if (ret)
+		return ret;
+
+	return ret2;
+}
+
+static int pcf8525_rtc_ioctl(struct device *dev, unsigned int cmd,
+			     unsigned long arg)
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
+	case RTC_VL_CLR:
+		return regmap_clear_bits(pcf8525->regmap, PCF8525_REG_CTRL3,
+					 PCF8525_CTRL3_BF);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static int pcf8525_param_get(struct device *dev, struct rtc_param *param)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	if (param->param != RTC_PARAM_BACKUP_SWITCH_MODE)
+		return -EINVAL;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL3, &val);
+	if (ret)
+		return ret;
+
+	switch (FIELD_GET(PCF8525_CTRL3_PWRMNG_MASK, val)) {
+	case PCF8525_PWRMNG_STANDARD:
+		param->uvalue = RTC_BSM_LEVEL;
+		break;
+	case PCF8525_PWRMNG_DIRECT:
+		param->uvalue = RTC_BSM_DIRECT;
+		break;
+	default:
+		param->uvalue = RTC_BSM_DISABLED;
+		break;
+	}
+
+	return 0;
+}
+
+static int pcf8525_param_set(struct device *dev, struct rtc_param *param)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int mode;
+
+	if (param->param != RTC_PARAM_BACKUP_SWITCH_MODE)
+		return -EINVAL;
+
+	switch (param->uvalue) {
+	case RTC_BSM_LEVEL:
+		mode = PCF8525_PWRMNG_STANDARD;
+		break;
+	case RTC_BSM_DIRECT:
+		mode = PCF8525_PWRMNG_DIRECT;
+		break;
+	case RTC_BSM_DISABLED:
+		mode = PCF8525_PWRMNG_DISABLED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* BF is write-0-to-clear, so write 1 to keep a pending flag. */
+	return regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL3,
+				  PCF8525_CTRL3_PWRMNG_MASK | PCF8525_CTRL3_BF,
+				  FIELD_PREP(PCF8525_CTRL3_PWRMNG_MASK, mode) |
+				  PCF8525_CTRL3_BF);
+}
+
+static int pcf8525_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	struct rtc_time *tm = &alrm->time;
+	unsigned int ctrl2;
+	u8 buf[7];
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(pcf8525->regmap, PCF8525_REG_ALM_SEC, buf,
+			       sizeof(buf));
+	if (ret)
+		return ret;
+
+	alrm->enabled = !!(ctrl2 & PCF8525_CTRL2_AIE);
+	alrm->pending = !!(ctrl2 & PCF8525_CTRL2_AF);
+
+	/* Fields with the enable bit cleared are matched; the rest stay -1. */
+	if (!(buf[0] & PCF8525_ALM_AE))
+		tm->tm_sec = bcd2bin(buf[0] & 0x7f);
+	if (!(buf[1] & PCF8525_ALM_AE))
+		tm->tm_min = bcd2bin(buf[1] & 0x7f);
+	if (!(buf[2] & PCF8525_ALM_AE))
+		tm->tm_hour = bcd2bin(buf[2] & 0x3f);
+	if (!(buf[3] & PCF8525_ALM_AE))
+		tm->tm_mday = bcd2bin(buf[3] & 0x3f);
+	if (!(buf[5] & PCF8525_ALM_AE_MONTH))
+		tm->tm_mon = bcd2bin(buf[5] & 0x1f) - 1;
+	if (!(buf[5] & PCF8525_ALM_AE_YEAR))
+		tm->tm_year = bcd2bin(buf[6]) + 100;
+
+	return 0;
+}
+
+static int pcf8525_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+
+	return pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_AIE,
+				    enable ? PCF8525_CTRL2_AIE : 0);
+}
+
+static int pcf8525_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	struct rtc_time *tm = &alrm->time;
+	u8 buf[7];
+	int ret;
+
+	/* Keep the alarm disabled while the registers are being rewritten. */
+	ret = pcf8525_alarm_irq_enable(dev, 0);
+	if (ret)
+		return ret;
+
+	buf[0] = bin2bcd(tm->tm_sec);
+	buf[1] = bin2bcd(tm->tm_min);
+	buf[2] = bin2bcd(tm->tm_hour);
+	buf[3] = bin2bcd(tm->tm_mday);
+	buf[4] = PCF8525_ALM_AE;
+	buf[5] = bin2bcd(tm->tm_mon + 1);
+	buf[6] = bin2bcd(tm->tm_year - 100);
+
+	ret = regmap_bulk_write(pcf8525->regmap, PCF8525_REG_ALM_SEC, buf,
+				sizeof(buf));
+	if (ret)
+		return ret;
+
+	ret = pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_AF, 0);
+	if (ret)
+		return ret;
+
+	return pcf8525_alarm_irq_enable(dev, alrm->enabled);
+}
+
+static int pcf8525_ts_read(struct pcf8525 *pcf8525, unsigned int reg,
+			   time64_t *ts)
+{
+	struct rtc_time tm = { };
+	u8 buf[6];
+	int ret;
+
+	ret = regmap_bulk_read(pcf8525->regmap, reg, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	/* The timestamps read as all zero until they have been captured. */
+	if (!(buf[3] & 0x3f) && !(buf[4] & 0x1f))
+		return -ENODATA;
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
+	*ts = rtc_tm_to_time64(&tm);
+
+	return 0;
+}
+
+/* The RTC core only applies the start-year offset to calendar reads. */
+static time64_t pcf8525_ts_apply_offset(struct pcf8525 *pcf8525, time64_t ts)
+{
+	struct rtc_device *rtc = pcf8525->rtc;
+
+	if (!rtc->offset_secs)
+		return ts;
+
+	if ((rtc->start_secs > rtc->range_min && ts >= rtc->start_secs) ||
+	    (rtc->start_secs < rtc->range_min &&
+	     ts <= rtc->start_secs + rtc->range_max - rtc->range_min))
+		return ts;
+
+	return ts + rtc->offset_secs;
+}
+
+static ssize_t timestamp0_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev->parent);
+	unsigned int ctrl4;
+	time64_t ts = 0;
+	int ret;
+
+	guard(mutex)(&pcf8525->ts_mutex);
+
+	if (pcf8525->irq_enabled) {
+		if (!pcf8525->ts_valid)
+			return 0;
+
+		ts = pcf8525->ts;
+	} else {
+		ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
+		if (ret)
+			return ret;
+
+		if (!(ctrl4 & PCF8525_CTRL4_TSF))
+			return 0;
+
+		ret = pcf8525_ts_read(pcf8525, PCF8525_REG_TS1_SEC, &ts);
+		if (ret)
+			return ret == -ENODATA ? 0 : ret;
+	}
+
+	return sysfs_emit(buf, "%lld\n",
+			  (long long)pcf8525_ts_apply_offset(pcf8525, ts));
+}
+
+static ssize_t timestamp0_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev->parent);
+	int ret;
+
+	/* Clear TSF only; the CTS command would also clear TS2. */
+	guard(mutex)(&pcf8525->ts_mutex);
+
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_CTRL4, 0);
+	if (ret)
+		return ret;
+
+	pcf8525->ts_valid = false;
+
+	return count;
+}
+
+static ssize_t timestamp1_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev->parent);
+	time64_t ts = 0;
+	int ret;
+
+	/* TS2 holds the time of the last calendar write. */
+	ret = pcf8525_ts_read(pcf8525, PCF8525_REG_TS2_SEC, &ts);
+	if (ret)
+		return ret == -ENODATA ? 0 : ret;
+
+	return sysfs_emit(buf, "%lld\n",
+			  (long long)pcf8525_ts_apply_offset(pcf8525, ts));
+}
+
+static DEVICE_ATTR_RW(timestamp0);
+static DEVICE_ATTR_RO(timestamp1);
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
+static int pcf8525_handle_ts(struct device *dev, struct pcf8525 *pcf8525)
+{
+	unsigned int ctrl4;
+	time64_t ts = 0;
+	int ret, err;
+
+	guard(mutex)(&pcf8525->ts_mutex);
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
+	if (ret)
+		return ret;
+
+	/* User space may have acknowledged the flag while we waited. */
+	if (!(ctrl4 & PCF8525_CTRL4_TSF))
+		return 0;
+
+	/* Read TS1 before clearing TSF, which re-arms the capture. */
+	err = pcf8525_ts_read(pcf8525, PCF8525_REG_TS1_SEC, &ts);
+	if (err && err != -ENODATA && err != -EINVAL)
+		return err;
+	if (err)
+		dev_warn_ratelimited(dev, "unusable timestamp: %d\n", err);
+
+	/* Invalid timestamp data must not leave the level-low INTA stuck. */
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_CTRL4, 0);
+	if (ret)
+		return ret;
+
+	if (!err && !pcf8525->ts_valid) {
+		pcf8525->ts = ts;
+		pcf8525->ts_valid = true;
+	}
+
+	return 0;
+}
+
+static int pcf8525_service_inta(struct device *dev, struct pcf8525 *pcf8525,
+				bool *handled)
+{
+	unsigned int ctrl2, ctrl4;
+	int i, ret;
+
+	*handled = false;
+
+	/* Flags can be set again while INTA is low, so re-read until clean. */
+	for (i = 0; i < PCF8525_IRQ_MAX_PASSES; i++) {
+		ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
+		if (ret)
+			return ret;
+
+		if (!(ctrl2 & (PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF)) &&
+		    !(ctrl4 & PCF8525_CTRL4_TSF))
+			return 0;
+
+		if (ctrl4 & PCF8525_CTRL4_TSF) {
+			ret = pcf8525_handle_ts(dev, pcf8525);
+			if (ret)
+				return ret;
+
+			*handled = true;
+		}
+
+		if (ctrl2 & PCF8525_CTRL2_AF) {
+			ret = pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_AF, 0);
+			if (ret)
+				return ret;
+
+			rtc_update_irq(pcf8525->rtc, 1, RTC_IRQF | RTC_AF);
+			*handled = true;
+		}
+
+		if (ctrl2 & PCF8525_CTRL2_MSF) {
+			ret = pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_MSF, 0);
+			if (ret)
+				return ret;
+
+			*handled = true;
+		}
+	}
+
+	return -EBUSY;
+}
+
+static irqreturn_t pcf8525_irq(int irq, void *data)
+{
+	struct device *dev = data;
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	bool handled;
+	int ret;
+
+	ret = pcf8525_service_inta(dev, pcf8525, &handled);
+	if (ret) {
+		dev_err_ratelimited(dev, "failed to service INTA: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	return handled ? IRQ_HANDLED : IRQ_NONE;
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
+static int pcf8525_get_inta_irq(struct i2c_client *client)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&client->dev);
+	int irq;
+
+	irq = fwnode_irq_get_byname(fwnode, "inta");
+	if (irq >= 0 || irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq != -ENOENT && irq != -EINVAL && irq != -ENODATA &&
+	    irq != -ENXIO)
+		return irq;
+
+	if (fwnode_property_present(fwnode, "interrupt-names"))
+		return 0;
+
+	/* Legacy firmware without interrupt-names uses the first IRQ as INTA. */
+	return client->irq;
+}
+
+static int pcf8525_mask_irqs_inta(struct pcf8525 *pcf8525)
+{
+	int ret;
+
+	ret = regmap_set_bits(pcf8525->regmap, PCF8525_REG_INTA_MASK1,
+			      PCF8525_MASK1_ALL);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(pcf8525->regmap, PCF8525_REG_INTA_MASK2,
+			       PCF8525_MASK2_TSIE);
+}
+
+static void pcf8525_mask_inta(void *data)
+{
+	pcf8525_mask_irqs_inta(data);
+}
+
+static int pcf8525_unmask_irqs_inta(struct pcf8525 *pcf8525, bool timestamp)
+{
+	int ret;
+
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_INTA_MASK1,
+				 PCF8525_MASK1_ALL,
+				 PCF8525_MASK1_ALL & ~PCF8525_MASK1_AIE);
+	if (ret)
+		return ret;
+
+	if (!timestamp)
+		return 0;
+
+	return regmap_clear_bits(pcf8525->regmap, PCF8525_REG_INTA_MASK2,
+				 PCF8525_MASK2_TSIE);
+}
+
+static int pcf8525_setup_inta(struct i2c_client *client,
+			      struct pcf8525 *pcf8525, int irq)
+{
+	struct device *dev = &client->dev;
+	bool handled;
+	int ret;
+
+	/* INTA is still masked, so drain all stale flags before enabling it. */
+	ret = pcf8525_service_inta(dev, pcf8525, &handled);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to drain pending INTA\n");
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pcf8525_irq,
+					IRQF_ONESHOT, dev_name(dev), dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request INTA IRQ\n");
+
+	pcf8525->irq_enabled = true;
+
+	ret = devm_add_action_or_reset(dev, pcf8525_mask_inta, pcf8525);
+	if (ret)
+		return ret;
+
+	ret = pcf8525_unmask_irqs_inta(pcf8525, true);
+	if (ret)
+		return ret;
+
+	/* The I2C core already set up wakeup for wakeup-source devices. */
+	if (client->flags & I2C_CLIENT_WAKE)
+		return 0;
+
+	return devm_pm_set_wake_irq(dev, irq);
+}
+
+static int pcf8525_setup_wakeup_only(struct device *dev,
+				     struct pcf8525 *pcf8525)
+{
+	int ret;
+
+	ret = devm_add_action_or_reset(dev, pcf8525_mask_inta, pcf8525);
+	if (ret)
+		return ret;
+
+	ret = pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_AF, 0);
+	if (ret)
+		return ret;
+
+	return pcf8525_unmask_irqs_inta(pcf8525, false);
+}
+
+static int pcf8525_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct pcf8525 *pcf8525;
+	int irq, ret;
+	bool wakeup;
+
+	pcf8525 = devm_kzalloc_obj(dev, *pcf8525);
+	if (!pcf8525)
+		return -ENOMEM;
+
+	wakeup = device_property_read_bool(dev, "wakeup-source");
+
+	ret = devm_mutex_init(dev, &pcf8525->ts_mutex);
+	if (ret)
+		return ret;
+
+	pcf8525->regmap = devm_regmap_init_i2c(client, &pcf8525_regmap_cfg);
+	if (IS_ERR(pcf8525->regmap))
+		return dev_err_probe(dev, PTR_ERR(pcf8525->regmap),
+				     "failed to init regmap\n");
+
+	i2c_set_clientdata(client, pcf8525);
+
+	irq = pcf8525_get_inta_irq(client);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "failed to get INTA IRQ\n");
+
+	/* Isolate stale and unused INTA sources before enabling timestamps. */
+	if (irq > 0 || wakeup) {
+		ret = pcf8525_mask_irqs_inta(pcf8525);
+		if (ret)
+			return ret;
+	}
+
+	pcf8525->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(pcf8525->rtc))
+		return dev_err_probe(dev, PTR_ERR(pcf8525->rtc),
+				     "failed to allocate RTC device\n");
+
+	pcf8525->rtc->ops = &pcf8525_rtc_ops;
+	pcf8525->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	pcf8525->rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf8525->rtc->features);
+	set_bit(RTC_FEATURE_BACKUP_SWITCH_MODE, pcf8525->rtc->features);
+	if (irq <= 0 && !wakeup)
+		clear_bit(RTC_FEATURE_ALARM, pcf8525->rtc->features);
+	else if (irq <= 0)
+		set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, pcf8525->rtc->features);
+
+	ret = regmap_clear_bits(pcf8525->regmap, PCF8525_REG_CTRL1,
+				PCF8525_CTRL1_12_24);
+	if (ret)
+		return ret;
+
+	ret = pcf8525_configure_crystal(dev, pcf8525);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_TS_CTL1,
+				 PCF8525_TS_CTL1_TSM | PCF8525_TS_CTL1_TSOFF,
+				 PCF8525_TS_CTL1_TSM);
+	if (ret)
+		return ret;
+
+	ret = regmap_assign_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
+				 PCF8525_CTRL5_TSIE, irq > 0);
+	if (ret)
+		return ret;
+
+	ret = rtc_add_group(pcf8525->rtc, &pcf8525_attr_group);
+	if (ret)
+		return ret;
+
+	/* Wakeup must be set up before registering so wakealarm is exposed. */
+	if (irq > 0 && !(client->flags & I2C_CLIENT_WAKE)) {
+		ret = devm_device_init_wakeup(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (irq > 0) {
+		ret = pcf8525_setup_inta(client, pcf8525, irq);
+		if (ret)
+			return ret;
+	} else if (wakeup) {
+		ret = pcf8525_setup_wakeup_only(dev, pcf8525);
+		if (ret)
+			return ret;
+	}
+
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

