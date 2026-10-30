Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358145;
	b=VLlkm5z2tqPsD9TQ7cYzx8LwGUA5rymdHwX4DksKa7xge+ZNbdcYjJ0+3gmoHvxib3sJ
	 jjJ+836woHS1c3MTToNcqZiggaHMv5vJycToqBIb1mgAc/fMLA7HzKGlTb/yWOIt1XVig
	 us7jxbVLdZ3jbX/Vw68h6cJwtCaTDLqxaUrN9TZ+FkJhjjPEFnUfr14BxdjYv2mEQcwLY
	 p12reMQHfjD7X+7KCKu40uIQCvdNdh07V1lmWhHrrisXwgg5stuRvuKRrH8XFDlSCGRt+
	 s5K5+LiOzrZMVUvcP/inXFjcbRft92AAH0GWe+quX5OY0gfANzgRjic0M1IXr1JfzVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358145;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=HlD6Qnp6u7NhqZTEb87dri1jLlXq985xpUCNhneaq9Y=;
	b=SaGJs3/Iug6woGG3QCDNv5wwMQ1r5rP46GJJUr3FOdfpyas3yNs2UQialhqSfx1uHxwW
	 R5K8CnseWT7md4Osr6TQP18S+E6qguokta5WRJxnynn0Vfs7/5NxqFxeLYj1X1xBYceQD
	 umYLJI4w7jA15P4bD7uM1lkUG6AuPm1Tkaf8xFXSBCDELaSCfCtFflKRAI9mlkZyVbhSl
	 Mo6NCr+keHq0vFiHIUbAYfOWIVoLICfkfKp5kFRp7fbs4eR6Gzu1Q+tFTUQME9tatFJJ8
	 IeDh+nUiU5ecc7IO/OtzrVFYjzhDnjCTvJfOtcYNuEi0mXcBrRuT1ZRNql+g/gRVApw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B75606AC3A;
	Fri, 30 Oct 2026 11:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B75606AC3A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FA1C200016;
	Fri, 30 Oct 2026 12:02:18 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A599200009;
	Fri, 30 Oct 2026 12:02:18 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 172C71800068;
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
Subject: [PATCH v4 3/4] rtc: pcf8525: Add watchdog support
Date: Fri, 30 Oct 2026 16:31:38 +0530
Message-Id: <20261030110139.1929109-4-shivprakash.gupta@nxp.com>
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

Extend the PCF8525 driver with an optional hardware watchdog.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
 drivers/rtc/Kconfig       |   4 +-
 drivers/rtc/rtc-pcf8525.c | 263 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 266 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b6c43b173445..bc597af5b4fe 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -516,11 +516,13 @@ config RTC_DRV_PCF8523
 config RTC_DRV_PCF8525
 	tristate "NXP PCF8525"
 	select REGMAP_I2C
+	select WATCHDOG_CORE if WATCHDOG
 	help
 	  If you say yes here you get support for the NXP PCF8525 RTC chip.
 	  The PCF8525 is an I2C real-time clock with alarm, external timestamp
 	  capture and recording of the last calendar write, crystal aging offset
-	  correction, and backup power switchover.
+	  correction, backup power switchover, and an integrated hardware
+	  watchdog timer.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8525.
diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
index 3c5f15f95a9e..f8fbc00bb464 100644
--- a/drivers/rtc/rtc-pcf8525.c
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -22,6 +22,7 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/pm.h>
+#include <linux/watchdog.h>
 
 /* Registers */
 #define PCF8525_REG_CTRL1		0x00
@@ -71,6 +72,8 @@
 #define PCF8525_REG_INTB_MASK1		0x2A
 #define PCF8525_REG_INTB_MASK2		0x2B
 
+#define PCF8525_REG_WD_CTL		0x2C
+#define PCF8525_REG_WD_VAL		0x2D
 #define PCF8525_REG_TEMP		0x2E
 
 /* CTRL1 */
@@ -88,6 +91,9 @@
 #define PCF8525_CTRL2_SMBTO		BIT(0)
 /*
  * All W0C status bits in CTRL2 (writing 1 = no effect, writing 0 = clear).
+ * Include WDTF here so that any regmap_update_bits touching CTRL2 control
+ * bits (AIE, TI_TP, etc.) does not accidentally clear a pending watchdog
+ * timer interrupt by writing 0 to WDTF in the RMW cycle.
  */
 #define PCF8525_CTRL2_W0C_FLAGS		(PCF8525_CTRL2_MSF | \
 					 PCF8525_CTRL2_WDTF | \
@@ -137,6 +143,16 @@
 #define PCF8525_ALM_AE_MONTH		BIT(7)
 #define PCF8525_ALM_AE_YEAR		BIT(6)
 
+/* Watchdog control register bits */
+#define PCF8525_WD_CTL_WD_CD		BIT(7)
+#define PCF8525_WD_CTL_TF0		BIT(0)
+#define PCF8525_WD_CTL_TF1		BIT(1)
+
+#define PCF8525_WD_CLOCK_HZ_X1000	250 /* 1/4 Hz */
+#define PCF8525_WD_MIN_HW_HEARTBEAT_MS	4000
+#define PCF8525_WD_VAL_STOP		0
+#define PCF8525_WD_DEFAULT_TIMEOUT_S	60
+
 #define PCF8525_REG_AGING_OFFSET_HI	0x26
 #define PCF8525_REG_AGING_OFFSET_LO	0x27
 /*
@@ -151,6 +167,7 @@
 
 struct pcf8525 {
 	struct rtc_device *rtc;
+	struct watchdog_device wdd;
 	struct regmap *regmap;
 	struct mutex ts_mutex;	/* protects ts[] and ts_valid[] in IRQ mode */
 	bool irq_enabled;
@@ -906,6 +923,211 @@ static const struct rtc_class_ops pcf8525_rtc_ops = {
 	.param_set = pcf8525_param_set,
 };
 
+static unsigned int pcf8525_wdt_timeout_to_val(unsigned int timeout)
+{
+	unsigned int val;
+
+	val = DIV_ROUND_UP(timeout * PCF8525_WD_CLOCK_HZ_X1000, 1000) + 1;
+
+	if (val < 2)
+		return 2;
+	if (val > 255)
+		return 255;
+
+	return val;
+}
+
+static int pcf8525_wdt_ping(struct watchdog_device *wdd)
+{
+	struct pcf8525 *pcf8525 = watchdog_get_drvdata(wdd);
+	unsigned int wd_val;
+
+	wd_val = pcf8525_wdt_timeout_to_val(wdd->timeout);
+
+	return regmap_write(pcf8525->regmap, PCF8525_REG_WD_VAL, wd_val);
+}
+
+static int pcf8525_wdt_active_ping(struct watchdog_device *wdd)
+{
+	if (watchdog_active(wdd))
+		return pcf8525_wdt_ping(wdd);
+
+	return 0;
+}
+
+static int pcf8525_wdt_start(struct watchdog_device *wdd)
+{
+	return pcf8525_wdt_ping(wdd);
+}
+
+static int pcf8525_wdt_stop(struct watchdog_device *wdd)
+{
+	struct pcf8525 *pcf8525 = watchdog_get_drvdata(wdd);
+
+	return regmap_write(pcf8525->regmap, PCF8525_REG_WD_VAL,
+			    PCF8525_WD_VAL_STOP);
+}
+
+static int pcf8525_watchdog_get_period(int n, int f1000)
+{
+	return (1000 * (n - 1)) / f1000;
+}
+
+static int pcf8525_wdt_set_timeout(struct watchdog_device *wdd,
+				   unsigned int timeout)
+{
+	unsigned int wd_val;
+
+	wd_val = pcf8525_wdt_timeout_to_val(timeout);
+	/* Report the achieved timeout, not the requested value. */
+	wdd->timeout = pcf8525_watchdog_get_period(wd_val,
+						   PCF8525_WD_CLOCK_HZ_X1000);
+
+	return pcf8525_wdt_active_ping(wdd);
+}
+
+static const struct watchdog_info pcf8525_wdt_info = {
+	.identity = "NXP PCF8525 Watchdog",
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+};
+
+static const struct watchdog_ops pcf8525_watchdog_ops = {
+	.owner = THIS_MODULE,
+	.start = pcf8525_wdt_start,
+	.stop = pcf8525_wdt_stop,
+	.ping = pcf8525_wdt_ping,
+	.set_timeout = pcf8525_wdt_set_timeout,
+};
+
+static int pcf8525_watchdog_config(struct device *dev,
+				   struct pcf8525 *pcf8525)
+{
+	unsigned int m1, m2;
+	int ret;
+
+	/*
+	 * WD_VAL is write-only, so a watchdog started by firmware cannot be
+	 * detected reliably. Stop it explicitly to establish a known state
+	 * before registering the Linux watchdog device.
+	 */
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_WD_VAL,
+			   PCF8525_WD_VAL_STOP);
+	if (ret)
+		return ret;
+
+	/* Configure nINTB/CLKOUT as nINTB open-drain interrupt output. */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CLKOUT,
+				 PCF8525_CLKOUT_CLKOE, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Select 1/4 Hz clock source: TF[1:0] = 10.
+	 * Do NOT enable WD_CD yet; enable it only after clearing stale WDTF
+	 * to avoid a spurious INTB assertion on a stale flag.
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_WD_CTL,
+				 PCF8525_WD_CTL_WD_CD |
+				 PCF8525_WD_CTL_TF1 |
+				 PCF8525_WD_CTL_TF0,
+				 PCF8525_WD_CTL_TF1);
+	if (ret)
+		return ret;
+
+	/* Keep watchdog masked on INTA. */
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTA_MASK1, &m1);
+	if (ret)
+		return ret;
+
+	m1 |= PCF8525_MASK1_WD_CD;
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK1, m1);
+	if (ret)
+		return ret;
+
+	/* Read INTB mask; mask all non-watchdog sources on INTB first. */
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTB_MASK1, &m1);
+	if (ret)
+		return ret;
+
+	m1 |= PCF8525_MASK1_BIE |
+	      PCF8525_MASK1_AIE |
+	      PCF8525_MASK1_OSIE |
+	      PCF8525_MASK1_SI |
+	      PCF8525_MASK1_MI |
+	      PCF8525_MASK1_WD_CD;   /* keep WD masked until WDTF is clear */
+
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK1, m1);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTB_MASK2, &m2);
+	if (ret)
+		return ret;
+
+	m2 |= PCF8525_MASK2_TSIE;
+	ret = regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK2, m2);
+	if (ret)
+		return ret;
+
+	/*
+	 * Clear stale WDTF before enabling WD_CD and unmasking INTB to
+	 * avoid asserting the watchdog output immediately.
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
+				 PCF8525_CTRL2_WDTF | PCF8525_CTRL2_AF |
+				 PCF8525_CTRL2_MSF,
+				 PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF);
+	if (ret)
+		return ret;
+
+	/* Enable WD_CD now that WDTF has been cleared. */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_WD_CTL,
+				 PCF8525_WD_CTL_WD_CD,
+				 PCF8525_WD_CTL_WD_CD);
+	if (ret)
+		return ret;
+
+	/* Unmask watchdog on INTB. */
+	m1 &= ~PCF8525_MASK1_WD_CD;
+	return regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK1, m1);
+}
+
+static int pcf8525_watchdog_init(struct device *dev,
+				 struct pcf8525 *pcf8525)
+{
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_WATCHDOG_CORE) ||
+	    !device_property_read_bool(dev, "reset-source"))
+		return 0;
+
+	/*
+	 * Configure the hardware first: this switches the nINTB/CLKOUT pin
+	 * from clock output (CLKOE=1) to open-drain output before the
+	 * watchdog is registered.
+	 */
+	ret = pcf8525_watchdog_config(dev, pcf8525);
+	if (ret)
+		return ret;
+
+	pcf8525->wdd.parent = dev;
+	pcf8525->wdd.info = &pcf8525_wdt_info;
+	pcf8525->wdd.ops = &pcf8525_watchdog_ops;
+	pcf8525->wdd.min_timeout = pcf8525_watchdog_get_period(2,
+							       PCF8525_WD_CLOCK_HZ_X1000);
+	pcf8525->wdd.max_timeout = pcf8525_watchdog_get_period(255,
+							       PCF8525_WD_CLOCK_HZ_X1000);
+	pcf8525->wdd.timeout = PCF8525_WD_DEFAULT_TIMEOUT_S;
+	watchdog_init_timeout(&pcf8525->wdd, 0, dev);
+	pcf8525->wdd.min_hw_heartbeat_ms = PCF8525_WD_MIN_HW_HEARTBEAT_MS;
+	pcf8525->wdd.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+
+	watchdog_set_drvdata(&pcf8525->wdd, pcf8525);
+	watchdog_stop_on_reboot(&pcf8525->wdd);
+
+	return devm_watchdog_register_device(dev, &pcf8525->wdd);
+}
+
 static int pcf8525_get_irqs(struct i2c_client *client, struct pcf8525 *pcf8525)
 {
 	struct device *dev = &client->dev;
@@ -973,6 +1195,42 @@ static int pcf8525_unmask_irqs_inta(struct pcf8525 *pcf8525)
 	return regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK2, m2);
 }
 
+static int pcf8525_suspend(struct device *dev)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	int ret;
+
+	/* Stop watchdog first: failure here must abort suspend. */
+	if (IS_ENABLED(CONFIG_WATCHDOG_CORE) &&
+	    device_property_read_bool(dev, "reset-source") &&
+	    watchdog_active(&pcf8525->wdd)) {
+		ret = pcf8525_wdt_stop(&pcf8525->wdd);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int pcf8525_resume(struct device *dev)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	int ret;
+
+	/* Ping watchdog first to avoid an imminent reset after resume. */
+	if (IS_ENABLED(CONFIG_WATCHDOG_CORE) &&
+	    device_property_read_bool(dev, "reset-source") &&
+	    watchdog_active(&pcf8525->wdd)) {
+		ret = pcf8525_wdt_ping(&pcf8525->wdd);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pcf8525_pm_ops, pcf8525_suspend, pcf8525_resume);
+
 static int pcf8525_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1076,6 +1334,10 @@ static int pcf8525_probe(struct i2c_client *client)
 		set_bit(RTC_FEATURE_ALARM, pcf8525->rtc->features);
 	}
 
+	ret = pcf8525_watchdog_init(dev, pcf8525);
+	if (ret)
+		return ret;
+
 	/* Register device */
 	ret = devm_rtc_register_device(pcf8525->rtc);
 	if (ret)
@@ -1100,6 +1362,7 @@ static struct i2c_driver pcf8525_driver = {
 	.driver = {
 		.name = "rtc-pcf8525",
 		.of_match_table = pcf8525_of_match,
+		.pm = pm_sleep_ptr(&pcf8525_pm_ops),
 	},
 	.probe = pcf8525_probe,
 	.id_table = pcf8525_i2c_id,
-- 
2.34.1

