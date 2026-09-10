Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F13BB135;
	Thu, 10 Sep 2026 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020586; cv=none; b=de/SCXjd/8XEMwP4TBrihHTi8ZXQFlhu4CbNbVKegX01CoV/xl/vmL/pKCrAyTkaE+T1lqjtSJxuTEM7WMY04nNL/sv5e1nxrAjZNinrnpSbTmVzm8NKGRa4Sn3uqyXQnh8fEOYuDvi2d2zkMCaCkE2C0k0WN0ziZhBJz3Avnxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020586; c=relaxed/simple;
	bh=x/1eCG0YShWHNVrn1MpvOJB/Gz1gHGwkt7mTFIzXR4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nfrrh4Nwn1L+lNFMlEBW46KbVSOdHkhPDjuvP1l5k3919peFdAUTaNAEr4f825IHZGUqM4cP44n5nVAExBIIwr+mhyvTbyS9ooCktuHCePIByRc4XI2KtpCa3b7H7NqNoBfBB0g8ipX4B7W+nJ5J3OIiNi+CPGV4ZJ7xp5jO3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DC70200386;
	Thu, 10 Sep 2026 08:09:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C173720037D;
	Thu, 10 Sep 2026 08:09:36 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 91A4B180006C;
	Thu, 10 Sep 2026 14:09:33 +0800 (+08)
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
Subject: [PATCH v3 3/4] rtc: pcf8525: Add watchdog support
Date: Thu, 10 Sep 2026 11:39:11 +0530
Message-Id: <20260910060912.2443551-4-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910060912.2443551-1-shivprakash.gupta@nxp.com>
References: <20260910060912.2443551-1-shivprakash.gupta@nxp.com>
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
 drivers/rtc/Kconfig       |   1 +
 drivers/rtc/rtc-pcf8525.c | 366 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 362 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 89ff23ffb9ef..356c2d91e387 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -516,6 +516,7 @@ config RTC_DRV_PCF8523
 config RTC_DRV_PCF8525
 	tristate "NXP PCF8525"
 	select REGMAP_I2C
+	select WATCHDOG_CORE if WATCHDOG
 	help
 	  If you say yes here you get support for the NXP PCF8525 RTC
 	  chips.
diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
index 9da8bcde7ef1..c2eab983f1ff 100644
--- a/drivers/rtc/rtc-pcf8525.c
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -47,6 +47,9 @@
 #include <linux/slab.h>
 #include <linux/bitfield.h>
 #include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/pm.h>
+#include <linux/watchdog.h>
 
 /* Registers */
 #define PCF8525_REG_CTRL1		0x00
@@ -96,6 +99,8 @@
 #define PCF8525_REG_INTB_MASK1		0x2A
 #define PCF8525_REG_INTB_MASK2		0x2B
 
+#define PCF8525_REG_WD_CTL		0x2C
+#define PCF8525_REG_WD_VAL		0x2D
 #define PCF8525_REG_TEMP		0x2E
 
 /* CTRL1 */
@@ -132,6 +137,9 @@
 #define PCF8525_CTRL5_CL		BIT(1)
 #define PCF8525_CTRL5_XTL_TYP		BIT(0)
 
+/* CLKOUT_ctl */
+#define PCF8525_CLKOUT_CLKOE		BIT(3)
+
 /* Timestamp control */
 #define PCF8525_TS_CTL1_TSM             BIT(7)
 #define PCF8525_TS_CTL1_TSOFF           BIT(6)
@@ -150,6 +158,7 @@
 #define PCF8525_RESET_SR_CMD		0x2C /* software reset */
 
 /* Interrupt masks (mask bit = 1 means masked/disabled) - INTA_MASK1 bits */
+#define PCF8525_MASK1_WD_CD		BIT(0)
 #define PCF8525_MASK1_BIE		BIT(1)
 #define PCF8525_MASK1_AIE		BIT(2)
 #define PCF8525_MASK1_OSIE		BIT(3)
@@ -161,6 +170,16 @@
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
@@ -175,11 +194,14 @@
 
 struct pcf8525 {
 	struct rtc_device *rtc;
+	struct watchdog_device wdd;
 	struct regmap *regmap;
 	struct mutex ts_mutex;	/* protects ts[] and ts_valid[] in IRQ mode */
 	bool irq_enabled;
 	time64_t ts[2];
 	bool ts_valid[2];
+	int irq_inta;
+	int irq_intb;
 };
 
 static const struct regmap_config pcf8525_regmap_cfg = {
@@ -879,6 +901,296 @@ static const struct rtc_class_ops pcf8525_rtc_ops = {
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
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_PRETIMEOUT,
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
+	/*
+	 * W0C: clear WDTF. Include AF and MSF in the mask and write 1 to them
+	 * so the RMW does not accidentally clear a concurrently asserted alarm
+	 * or minute/second interrupt flag.
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
+				 PCF8525_CTRL2_WDTF | PCF8525_CTRL2_AF |
+				 PCF8525_CTRL2_MSF,
+				 PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF);
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
+	 * Include AF and MSF in the mask with value=1 to protect them from
+	 * the RMW clearing a concurrently asserted flag.
+	 */
+	ret = regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
+				 PCF8525_CTRL2_WDTF | PCF8525_CTRL2_AF |
+				 PCF8525_CTRL2_MSF,
+				 PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF);
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
+static void pcf8525_mask_intb(void *data)
+{
+	struct pcf8525 *pcf8525 = data;
+	unsigned int m1;
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_INTB_MASK1, &m1);
+	if (!ret) {
+		m1 |= PCF8525_MASK1_WD_CD;
+		regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK1, m1);
+	}
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
+	 * from clock output (CLKOE=1) to open-drain interrupt output before
+	 * the IRQ handler is installed.  Requesting the IRQ while CLKOE=1
+	 * would flood the CPU with spurious interrupts and may cause the
+	 * Linux spurious-interrupt detector to permanently disable the IRQ.
+	 */
+	ret = pcf8525_watchdog_config(dev, pcf8525);
+	if (ret)
+		return ret;
+
+	/* Register a cleanup action to re-mask INTB on driver unbind. */
+	ret = devm_add_action_or_reset(dev, pcf8525_mask_intb, pcf8525);
+	if (ret)
+		return ret;
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
 static int pcf8525_unmask_irqs_intA(struct pcf8525 *pcf8525)
 {
 	/*
@@ -898,8 +1210,9 @@ static int pcf8525_unmask_irqs_intA(struct pcf8525 *pcf8525)
 	if (ret)
 		return ret;
 
-	m1 &= ~PCF8525_MASK1_AIE;    /* unmask alarm interrupt on INTA */
-	m2 &= ~PCF8525_MASK2_TSIE;   /* unmask timestamp interrupt on INTA */
+	m1 |= PCF8525_MASK1_WD_CD;	/* keep watchdog masked on INTA */
+	m1 &= ~PCF8525_MASK1_AIE;	/* unmask alarm interrupt on INTA */
+	m2 &= ~PCF8525_MASK2_TSIE;	/* unmask timestamp interrupt on INTA */
 
 	ret = regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK1, m1);
 	if (ret)
@@ -908,6 +1221,32 @@ static int pcf8525_unmask_irqs_intA(struct pcf8525 *pcf8525)
 	return regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK2, m2);
 }
 
+static int pcf8525_suspend(struct device *dev)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+
+	if (IS_ENABLED(CONFIG_WATCHDOG_CORE) &&
+	    device_property_read_bool(dev, "reset-source") &&
+	    watchdog_active(&pcf8525->wdd))
+		return pcf8525_wdt_stop(&pcf8525->wdd);
+
+	return 0;
+}
+
+static int pcf8525_resume(struct device *dev)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+
+	if (IS_ENABLED(CONFIG_WATCHDOG_CORE) &&
+	    device_property_read_bool(dev, "reset-source") &&
+	    watchdog_active(&pcf8525->wdd))
+		return pcf8525_wdt_ping(&pcf8525->wdd);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pcf8525_pm_ops, pcf8525_suspend, pcf8525_resume);
+
 static int pcf8525_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -927,6 +1266,10 @@ static int pcf8525_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, pcf8525);
 
+	ret = pcf8525_get_irqs(client, pcf8525);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get IRQs\n");
+
 	pcf8525->rtc = devm_rtc_allocate_device(dev);
 	if (IS_ERR(pcf8525->rtc))
 		return dev_err_probe(dev, PTR_ERR(pcf8525->rtc),
@@ -968,8 +1311,8 @@ static int pcf8525_probe(struct i2c_client *client)
 		return ret;
 
 	/* Optional IRQ */
-	if (client->irq > 0) {
-		ret = devm_request_threaded_irq(dev, client->irq,
+	if (pcf8525->irq_inta > 0) {
+		ret = devm_request_threaded_irq(dev, pcf8525->irq_inta,
 						NULL, pcf8525_irq,
 						IRQF_ONESHOT,
 						dev_name(dev), dev);
@@ -984,11 +1327,23 @@ static int pcf8525_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
+		/*
+		 * Register a cleanup action to re-mask INTA interrupts on
+		 * driver unbind so the open-drain line is not left asserted.
+		 */
+		ret = devm_add_action_or_reset(dev, pcf8525_mask_inta, pcf8525);
+		if (ret)
+			return ret;
+
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
@@ -1013,6 +1368,7 @@ static struct i2c_driver pcf8525_driver = {
 	.driver = {
 		.name = "rtc-pcf8525",
 		.of_match_table = pcf8525_of_match,
+		.pm = pm_sleep_ptr(&pcf8525_pm_ops),
 	},
 	.probe = pcf8525_probe,
 	.id_table = pcf8525_i2c_id,
-- 
2.34.1

