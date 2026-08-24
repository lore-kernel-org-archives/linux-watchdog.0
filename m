Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617C3E558F;
	Mon, 24 Aug 2026 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554549; cv=none; b=JpWBRJmaCOQnpl7fVEy/D3THF+ifexU6yuOcY5fV361d+/b7owZunDKQ0I0NcjhxyKedAyw8yfqQqAFtDT1g49J0zlveT0v4mkA9LG3Jg/908JOzSEvrSWf2Deu5/5IKB86Jvi4Mz/0pzkqo0AKwgykj6KNZDE8riwS4oDzmE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554549; c=relaxed/simple;
	bh=17cFDI+vC2mcwCOQ7lmR2Wz2xQtdZy1UFS9rXnh5L58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1cSRw5L4jCl0SgkGbhHL7Fgxcm8qkvCeCJP5jPQwoC7nEkXaoxXapJdEmNnapQaS6wcfNcI+iZniLffTT00dzce6tyihv/1s/UpHsnmQ7k3Z1AJrizs4UBVcbMU/TOoWmzDUlJrHZYVno2zdLQh4nqhnem1iefuMwUwz4VjldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F3CE11A0098;
	Mon, 24 Aug 2026 08:55:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C7FE91A009B;
	Mon, 24 Aug 2026 08:55:45 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9D3D21800229;
	Mon, 24 Aug 2026 14:55:42 +0800 (+08)
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
Subject: [PATCH v2 3/4] rtc: pcf8525: Add watchdog support
Date: Mon, 24 Aug 2026 12:25:30 +0530
Message-Id: <20260824065531.693701-4-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824065531.693701-1-shivprakash.gupta@nxp.com>
References: <20260824065531.693701-1-shivprakash.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add watchdog support for NXP PCF8525 real time clock(RTC) device

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
Changes in v2:
- Clear stale WDTF before unmasking watchdog interrupt on INTB to prevent
  boot loop when battery-backed flag persists across resets
- Add watchdog_notify_pretimeout() call in INTB IRQ handler
- Set WDOG_HW_RUNNING if bootloader left watchdog running at probe time
- Fix Kconfig indentation: use spaces instead of tab for select line
---
 drivers/rtc/Kconfig       |   1 +
 drivers/rtc/rtc-pcf8525.c | 272 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 270 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3c22c7253aae..23bf5fa15f84 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -516,6 +516,7 @@ config RTC_DRV_PCF8523
 config RTC_DRV_PCF8525
         tristate "NXP PCF8525"
         select REGMAP_I2C
+        select WATCHDOG_CORE if WATCHDOG
         help
           If you say yes here you get support for the NXP PCF8525 RTC
           chips.
diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
index 843d4bb26684..415615ea0a40 100644
--- a/drivers/rtc/rtc-pcf8525.c
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -46,6 +46,8 @@
 #include <linux/slab.h>
 #include <linux/bitfield.h>
 #include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/watchdog.h>
 
 /* Registers */
 #define PCF8525_REG_CTRL1		0x00
@@ -95,6 +97,8 @@
 #define PCF8525_REG_INTB_MASK1		0x2A
 #define PCF8525_REG_INTB_MASK2		0x2B
 
+#define PCF8525_REG_WD_CTL              0x2C
+#define PCF8525_REG_WD_VAL              0x2D
 #define PCF8525_REG_TEMP		0x2E
 
 /* CTRL1 */
@@ -105,6 +109,7 @@
 /* CTRL2 */
 #define PCF8525_CTRL2_MSF		BIT(7)
 #define PCF8525_CTRL2_TI_TP		BIT(6)
+#define PCF8525_CTRL2_WDTF              BIT(5)
 #define PCF8525_CTRL2_AF		BIT(4)
 #define PCF8525_CTRL2_OSFE_MASK		GENMASK(3, 2)
 #define PCF8525_CTRL2_AIE		BIT(1)
@@ -121,6 +126,9 @@
 #define PCF8525_CTRL5_CL		BIT(1)
 #define PCF8525_CTRL5_XTL_TYP		BIT(0)
 
+/* CLKOUT_ctl */
+#define PCF8525_CLKOUT_CLKOE            BIT(3)
+
 /* Timestamp control */
 #define PCF8525_TS_CTL1_TSM             BIT(7)
 #define PCF8525_TS_CTL1_TSOFF           BIT(6)
@@ -139,6 +147,7 @@
 #define PCF8525_RESET_SR_CMD		0x2C /* software reset */
 
 /* Interrupt masks (mask bit = 1 means masked/disabled) - INTA_MASK1 bits */
+#define PCF8525_MASK1_WD_CD            BIT(0)
 #define PCF8525_MASK1_BIE		BIT(1)
 #define PCF8525_MASK1_AIE		BIT(2)
 #define PCF8525_MASK1_OSIE		BIT(3)
@@ -149,6 +158,14 @@
 
 #define PCF8525_ALM_AE_MONTH		BIT(7)
 #define PCF8525_ALM_AE_YEAR		BIT(6)
+#define PCF8525_WD_CTL_WD_CD            BIT(7)
+#define PCF8525_WD_CTL_TF0              BIT(0)
+#define PCF8525_WD_CTL_TF1              BIT(1)
+
+#define PCF8525_WD_CLOCK_HZ_X1000       250 /* 1/4 Hz */
+#define PCF8525_WD_MIN_HW_HEARTBEAT_MS  4000
+#define PCF8525_WD_VAL_STOP             0
+#define PCF8525_WD_DEFAULT_TIMEOUT_S    60
 
 #define PCF8525_REG_AGING_OFFSET_HI	0x26
 #define PCF8525_REG_AGING_OFFSET_LO	0x27
@@ -164,11 +181,14 @@
 
 struct pcf8525 {
 	struct rtc_device *rtc;
+	struct watchdog_device wdd;
 	struct regmap *regmap;
 	spinlock_t ts_lock;	/* protects ts[] and ts_valid[] */
 	bool irq_enabled;
 	time64_t ts[2];
 	bool ts_valid[2];
+	int irq_inta;
+	int irq_intb;
 };
 
 static const struct regmap_config pcf8525_regmap_cfg = {
@@ -177,6 +197,243 @@ static const struct regmap_config pcf8525_regmap_cfg = {
 	.max_register = PCF8525_REG_TEMP,
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
+				    PCF8525_WD_VAL_STOP);
+}
+
+static int pcf8525_wdt_set_timeout(struct watchdog_device *wdd,
+				   unsigned int timeout)
+{
+	wdd->timeout = timeout;
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
+static int pcf8525_watchdog_get_period(int n, int f1000)
+{
+	return (1000 * (n - 1)) / f1000;
+}
+
+static irqreturn_t pcf8525_wdt_irq(int irq, void *data)
+{
+	struct device *dev = data;
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int ctrl2;
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
+	if (ret)
+		return IRQ_NONE;
+
+	if (!(ctrl2 & PCF8525_CTRL2_WDTF))
+		return IRQ_NONE;
+
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
+				 PCF8525_CTRL2_WDTF, 0);
+	if (ret)
+		return IRQ_NONE;
+
+	watchdog_notify_pretimeout(&pcf8525->wdd);
+	return IRQ_HANDLED;
+}
+
+static int pcf8525_watchdog_config(struct device *dev,
+				   struct pcf8525 *pcf8525)
+{
+	unsigned int m1, m2;
+	int ret;
+
+	/* Configure nINTB/CLKOUT as nINTB open-drain interrupt output. */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CLKOUT,
+				 PCF8525_CLKOUT_CLKOE, 0);
+	if (ret)
+		return ret;
+
+	/* Enable watchdog interrupt and select 1/4 Hz source: TF[1:0] = 10. */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_WD_CTL,
+				 PCF8525_WD_CTL_WD_CD |
+				 PCF8525_WD_CTL_TF1 |
+				 PCF8525_WD_CTL_TF0,
+				 PCF8525_WD_CTL_WD_CD |
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
+	/* Route watchdog only to INTB, and keep RTC interrupts masked on INTB. */
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTB_MASK1, &m1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Clear any stale WDTF before unmasking the watchdog on INTB.
+	 * With battery backup the flag survives a power cycle and would
+	 * assert INTB immediately on the next boot, causing an infinite
+	 * reset loop if INTB is wired to a hardware reset line.
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
+				 PCF8525_CTRL2_WDTF, 0);
+	if (ret)
+		return ret;
+
+	m1 |= PCF8525_MASK1_BIE |
+	      PCF8525_MASK1_AIE |
+	      PCF8525_MASK1_OSIE |
+	      PCF8525_MASK1_SI |
+	      PCF8525_MASK1_MI;
+	m1 &= ~PCF8525_MASK1_WD_CD;
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
+
+	return regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK2, m2);
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
+	if (pcf8525->irq_intb > 0) {
+		ret = devm_request_threaded_irq(dev, pcf8525->irq_intb,
+						NULL, pcf8525_wdt_irq,
+						IRQF_ONESHOT,
+						"pcf8525-wdt", dev);
+		if (ret)
+			return ret;
+	}
+
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
+	/*
+	 * If the watchdog countdown register is non-zero the bootloader
+	 * left the watchdog running.  Tell the watchdog core so that it
+	 * keeps pinging the hardware until userspace takes over.
+	 */
+	{
+		unsigned int wd_val;
+
+		if (!regmap_read(pcf8525->regmap, PCF8525_REG_WD_VAL, &wd_val) &&
+		    wd_val != 0)
+			set_bit(WDOG_HW_RUNNING, &pcf8525->wdd.status);
+	}
+
+	return devm_watchdog_register_device(dev, &pcf8525->wdd);
+}
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
+	irq = fwnode_irq_get_byname(dev_fwnode(dev), "intb");
+	if (irq == -ENOENT || irq == -EINVAL)
+		irq = 0;
+	else if (irq < 0)
+		return irq;
+	pcf8525->irq_intb = irq;
+
+	return 0;
+}
+
 /*
  * Configure only the crystal fields explicitly provided by firmware.
  * If a property is absent, preserve the current hardware setting.
@@ -832,6 +1089,7 @@ static int pcf8525_unmask_irqs_intA(struct pcf8525 *pcf8525)
 	if (ret)
 		return ret;
 
+	m1 |= PCF8525_MASK1_WD_CD;
 	m1 &= ~PCF8525_MASK1_AIE;    /* unmask alarm interrupt on INTA */
 	m2 &= ~PCF8525_MASK2_TSIE;   /* unmask timestamp interrupt on INTA */
 
@@ -861,6 +1119,10 @@ static int pcf8525_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, pcf8525);
 
+	ret = pcf8525_get_irqs(client, pcf8525);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get IRQs\n");
+
 	pcf8525->rtc = devm_rtc_allocate_device(dev);
 	if (IS_ERR(pcf8525->rtc))
 		return dev_err_probe(dev, PTR_ERR(pcf8525->rtc),
@@ -902,8 +1164,8 @@ static int pcf8525_probe(struct i2c_client *client)
 		return ret;
 
 	/* Optional IRQ */
-	if (client->irq > 0) {
-		ret = devm_request_threaded_irq(dev, client->irq,
+	if (pcf8525->irq_inta > 0) {
+		ret = devm_request_threaded_irq(dev, pcf8525->irq_inta,
 						NULL, pcf8525_irq,
 						IRQF_ONESHOT,
 						dev_name(dev), dev);
@@ -919,10 +1181,14 @@ static int pcf8525_probe(struct i2c_client *client)
 			return ret;
 
 		device_init_wakeup(dev, true);
-		dev_pm_set_wake_irq(dev, client->irq);
+		dev_pm_set_wake_irq(dev, pcf8525->irq_inta);
 		set_bit(RTC_FEATURE_ALARM, pcf8525->rtc->features);
 	}
 
+	ret = pcf8525_watchdog_init(dev, pcf8525);
+	if (ret)
+		return ret;
+
 	/* Register device */
 	ret = devm_rtc_register_device(pcf8525->rtc);
 	if (ret)
-- 
2.34.1

