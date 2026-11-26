Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677112;
	b=SSfkA7dL889U/QCA4T6eILYhQWfIpfVd6m533DWpu3d7m6GhLvE0TvWoUoYf4Kme7FOM
	 u5C1i1LCbv4YVzLABUQTqbbflAWX6rLA7azqGuQQs484mMqESkTWfOp/nyLmX+JIgilID
	 5GLZphmV4QlZK8IZHBMJpIiiOSInKRwvlhMke9gEYaFAnOwhsP744c+EjMp19hDHKCEex
	 zZyDbkosewNiAMQkZx8xTqfZyu8odg3ovFitwWeX9ivnJCtjoOZuymF4lVDgjW3kFO3Qv
	 HvKbDChk37vDHpiuRbeCPnQSdWtbdb0wUvMr2B8QpheCFLS+y6DicgrRRlED9n/KbTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677112;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=veH9m5BZmYfj5IQdhe+I9v8lUnwRituPegvprWuaLog=;
	b=wPhFCn4ayuVqcIQHbVgjgf4R0z3ED6/QMqwH0b8sNyedJR9S4+75QQCP9LxWWdosQAEG
	 L11xd5K3zlDMrS+rlP1wgP6Bl1zqlBBCuupuV1Y8szEDMIwHhDV2MjRYGJbLI9oODyamL
	 N+oSxelrnCUbeGQ90P2gRDleG7EnjVp9l8MVLFBcmUGw/BFxP2yLvQKZSlC1D6Amu76dy
	 4f+DqlaKJ1vjFc8s8PmtzArZdfVofLFZiqf8T199ls/FMSUMOZOK2rXoXzu9GXdHb7dqr
	 qG+QyPOhNsKOVjACH/tQs37K+HLsXrZg6QmxXEXF/+BLPrBYF6fNcBb+j5s6+hynm1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44D606A68D;
	Thu, 26 Nov 2026 07:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A44D606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBC24200023;
	Thu, 26 Nov 2026 08:11:49 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F7B8200010;
	Thu, 26 Nov 2026 08:11:49 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3C23E18000B5;
	Thu, 26 Nov 2026 15:11:46 +0800 (+08)
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
Subject: [PATCH v5 3/4] rtc: pcf8525: Add watchdog support
Date: Thu, 26 Nov 2026 12:41:23 +0530
Message-Id: <20261126071124.2383368-4-shivprakash.gupta@nxp.com>
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

Extend the PCF8525 driver with an optional alarm-only watchdog.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
 drivers/rtc/Kconfig       |   4 +-
 drivers/rtc/rtc-pcf8525.c | 328 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 330 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 848bcde41f2a..68b17ad29ed4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -526,11 +526,13 @@ config RTC_DRV_PCF8523
 config RTC_DRV_PCF8525
 	tristate "NXP PCF8525"
 	select REGMAP_I2C
+	select WATCHDOG_CORE if WATCHDOG
 	help
 	  If you say yes here you get support for the NXP PCF8525 RTC chip.
 	  The PCF8525 is an I2C real-time clock with alarm, external timestamp
 	  capture and recording of the last calendar write, crystal aging offset
-	  correction, and backup power switchover.
+	  correction, backup power switchover, and an integrated watchdog
+	  timer.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8525.
diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
index 2b23b17d6750..25420e7ad21c 100644
--- a/drivers/rtc/rtc-pcf8525.c
+++ b/drivers/rtc/rtc-pcf8525.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * NXP PCF8525 RTC driver with alarm and timestamp support.
+ * NXP PCF8525 RTC driver with alarm, timestamp and watchdog support.
  *
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCF8525.pdf
  */
@@ -17,9 +17,11 @@
 #include <linux/interrupt.h>
 #include <linux/limits.h>
 #include <linux/math.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/pm_wakeup.h>
 #include <linux/property.h>
@@ -28,6 +30,7 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/watchdog.h>
 
 #define PCF8525_REG_CTRL1		0x00
 #define PCF8525_REG_CTRL2		0x01
@@ -51,7 +54,11 @@
 
 #define PCF8525_REG_INTA_MASK1		0x28
 #define PCF8525_REG_INTA_MASK2		0x29
+#define PCF8525_REG_INTB_MASK1		0x2A
+#define PCF8525_REG_INTB_MASK2		0x2B
 
+#define PCF8525_REG_WD_CTL		0x2C
+#define PCF8525_REG_WD_VAL		0x2D
 #define PCF8525_REG_TEMP		0x2E
 
 #define PCF8525_CTRL1_STOP		BIT(5)
@@ -78,6 +85,7 @@
 #define PCF8525_CTRL5_XTL_TYP		BIT(0)
 
 #define PCF8525_CLKOUT_OTPR		BIT(4)
+#define PCF8525_CLKOUT_CLKOE		BIT(3)
 
 #define PCF8525_TS_CTL1_TSM		BIT(7)
 #define PCF8525_TS_CTL1_TSOFF		BIT(6)
@@ -92,10 +100,21 @@
 #define PCF8525_RESET_CPR_CMD		0xA4
 
 /* A set bit in the INTx_MASKy registers masks the interrupt source. */
+#define PCF8525_MASK1_WD_CD		BIT(0)
 #define PCF8525_MASK1_AIE		BIT(2)
 #define PCF8525_MASK1_ALL		GENMASK(5, 0)
 #define PCF8525_MASK2_TSIE		BIT(3)
 
+#define PCF8525_WD_CTL_WD_CD		BIT(7)
+#define PCF8525_WD_CTL_TF_MASK		GENMASK(1, 0)
+#define PCF8525_WD_TF_QUARTER_HZ	2
+
+#define PCF8525_WD_VAL_STOP		0
+#define PCF8525_WD_VAL_MIN		2
+#define PCF8525_WD_VAL_MAX		255
+#define PCF8525_WD_TICK_S		4
+#define PCF8525_WD_DEFAULT_TIMEOUT_S	60
+
 #define PCF8525_AGING_STEP_NUM		298L
 #define PCF8525_AGING_STEP_DEN		10L
 
@@ -103,11 +122,13 @@
 
 struct pcf8525 {
 	struct rtc_device *rtc;
+	struct watchdog_device wdd;
 	struct regmap *regmap;
 	struct mutex ts_mutex;	/* protects the TS1 cache and TSF */
 	time64_t ts;
 	bool ts_valid;
 	bool irq_enabled;
+	int irq_intb;
 };
 
 static const struct regmap_config pcf8525_regmap_cfg = {
@@ -699,6 +720,244 @@ static const struct rtc_class_ops pcf8525_rtc_ops = {
 	.param_set = pcf8525_param_set,
 };
 
+/* WDTF is set when the counter reaches 1, so a value n gives n - 1 ticks. */
+static unsigned int pcf8525_wdt_timeout_to_val(unsigned int timeout)
+{
+	return clamp_val(DIV_ROUND_UP(timeout, PCF8525_WD_TICK_S) + 1,
+			 PCF8525_WD_VAL_MIN, PCF8525_WD_VAL_MAX);
+}
+
+static unsigned int pcf8525_wdt_val_to_timeout(unsigned int val)
+{
+	return (val - 1) * PCF8525_WD_TICK_S;
+}
+
+static int pcf8525_wdt_reload(struct watchdog_device *wdd)
+{
+	struct pcf8525 *pcf8525 = watchdog_get_drvdata(wdd);
+
+	return regmap_write(pcf8525->regmap, PCF8525_REG_WD_VAL,
+			    pcf8525_wdt_timeout_to_val(wdd->timeout));
+}
+
+/*
+ * Load the counter with INTB masked and enable WD_CD and the INTB route last.
+ * @rollback stops the timer if starting fails; resume must keep it running.
+ */
+static int pcf8525_wdt_arm(struct watchdog_device *wdd, bool rollback)
+{
+	struct pcf8525 *pcf8525 = watchdog_get_drvdata(wdd);
+	struct regmap *regmap = pcf8525->regmap;
+	int ret;
+
+	ret = regmap_set_bits(regmap, PCF8525_REG_INTB_MASK1,
+			      PCF8525_MASK1_WD_CD);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(regmap, PCF8525_REG_WD_CTL,
+				PCF8525_WD_CTL_WD_CD);
+	if (ret)
+		return ret;
+
+	ret = pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_WDTF, 0);
+	if (ret)
+		return ret;
+
+	ret = pcf8525_wdt_reload(wdd);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(regmap, PCF8525_REG_WD_CTL,
+			      PCF8525_WD_CTL_WD_CD);
+	if (ret)
+		goto rollback_start;
+
+	ret = regmap_clear_bits(regmap, PCF8525_REG_INTB_MASK1,
+				PCF8525_MASK1_WD_CD);
+	if (!ret || !rollback)
+		return ret;
+
+	regmap_clear_bits(regmap, PCF8525_REG_WD_CTL,
+			  PCF8525_WD_CTL_WD_CD);
+
+rollback_start:
+	if (rollback)
+		regmap_write(regmap, PCF8525_REG_WD_VAL, PCF8525_WD_VAL_STOP);
+
+	return ret;
+}
+
+static int pcf8525_wdt_start(struct watchdog_device *wdd)
+{
+	return pcf8525_wdt_arm(wdd, true);
+}
+
+static int pcf8525_wdt_ping(struct watchdog_device *wdd)
+{
+	return pcf8525_wdt_reload(wdd);
+}
+
+static int pcf8525_wdt_stop(struct watchdog_device *wdd)
+{
+	struct pcf8525 *pcf8525 = watchdog_get_drvdata(wdd);
+
+	/* Loading 0 clears WDTF/nINTB and stops the hardware counter. */
+	return regmap_write(pcf8525->regmap, PCF8525_REG_WD_VAL,
+			    PCF8525_WD_VAL_STOP);
+}
+
+static int pcf8525_wdt_set_timeout(struct watchdog_device *wdd,
+				   unsigned int timeout)
+{
+	wdd->timeout = pcf8525_wdt_val_to_timeout(pcf8525_wdt_timeout_to_val(timeout));
+
+	/* watchdog core reloads an active watchdog after .set_timeout(). */
+	return 0;
+}
+
+static const struct watchdog_info pcf8525_wdt_info = {
+	.identity = "NXP PCF8525 Watchdog",
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
+		   WDIOF_MAGICCLOSE | WDIOF_ALARMONLY,
+};
+
+static const struct watchdog_ops pcf8525_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = pcf8525_wdt_start,
+	.stop = pcf8525_wdt_stop,
+	.ping = pcf8525_wdt_ping,
+	.set_timeout = pcf8525_wdt_set_timeout,
+};
+
+static irqreturn_t pcf8525_wdt_irq(int irq, void *data)
+{
+	struct device *dev = data;
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	unsigned int ctrl2;
+	int ret;
+
+	ret = regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
+	if (ret) {
+		dev_warn_ratelimited(dev, "failed to read watchdog status: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (!(ctrl2 & PCF8525_CTRL2_WDTF))
+		return IRQ_NONE;
+
+	ret = pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_WDTF, 0);
+	if (ret) {
+		dev_warn_ratelimited(dev, "failed to clear watchdog alarm: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	dev_warn_ratelimited(dev, "watchdog alarm expired\n");
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Mask the alarm route; stopping the counter is left to the watchdog core,
+ * which honours nowayout.
+ */
+static void pcf8525_wdt_cleanup(void *data)
+{
+	struct pcf8525 *pcf8525 = data;
+
+	if (watchdog_active(&pcf8525->wdd) ||
+	    watchdog_hw_running(&pcf8525->wdd))
+		return;
+
+	/* Detach WDTF from INTB before the managed IRQ is released. */
+	regmap_set_bits(pcf8525->regmap, PCF8525_REG_INTB_MASK1,
+			PCF8525_MASK1_WD_CD);
+}
+
+static int pcf8525_watchdog_config(struct pcf8525 *pcf8525)
+{
+	struct regmap *regmap = pcf8525->regmap;
+	int ret;
+
+	/* Isolate every INTB source before touching watchdog state. */
+	ret = regmap_set_bits(regmap, PCF8525_REG_INTB_MASK1,
+			      PCF8525_MASK1_ALL);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(regmap, PCF8525_REG_INTB_MASK2,
+			      PCF8525_MASK2_TSIE);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(regmap, PCF8525_REG_INTA_MASK1,
+			      PCF8525_MASK1_WD_CD);
+	if (ret)
+		return ret;
+
+	/* WD_VAL is write-only, so establish a known stopped state. */
+	ret = regmap_write(regmap, PCF8525_REG_WD_VAL, PCF8525_WD_VAL_STOP);
+	if (ret)
+		return ret;
+
+	/* Select the 1/4 Hz clock and keep WD_CD disabled until .start(). */
+	ret = regmap_update_bits(regmap, PCF8525_REG_WD_CTL,
+				 PCF8525_WD_CTL_WD_CD | PCF8525_WD_CTL_TF_MASK,
+				 FIELD_PREP(PCF8525_WD_CTL_TF_MASK,
+					    PCF8525_WD_TF_QUARTER_HZ));
+	if (ret)
+		return ret;
+
+	ret = pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_WDTF, 0);
+	if (ret)
+		return ret;
+
+	/* All INTB sources are quiescent; switch the physical pin last. */
+	return regmap_clear_bits(regmap, PCF8525_REG_CLKOUT,
+				 PCF8525_CLKOUT_CLKOE);
+}
+
+static int pcf8525_watchdog_init(struct device *dev, struct pcf8525 *pcf8525)
+{
+	struct watchdog_device *wdd = &pcf8525->wdd;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_WATCHDOG) || pcf8525->irq_intb <= 0)
+		return 0;
+
+	ret = pcf8525_watchdog_config(pcf8525);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to configure watchdog\n");
+
+	ret = devm_request_threaded_irq(dev, pcf8525->irq_intb, NULL,
+					pcf8525_wdt_irq, IRQF_ONESHOT,
+					"pcf8525-wdt", dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request INTB IRQ\n");
+
+	wdd->parent = dev;
+	wdd->info = &pcf8525_wdt_info;
+	wdd->ops = &pcf8525_wdt_ops;
+	wdd->min_timeout = pcf8525_wdt_val_to_timeout(PCF8525_WD_VAL_MIN);
+	wdd->max_timeout = pcf8525_wdt_val_to_timeout(PCF8525_WD_VAL_MAX);
+	wdd->status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+	wdd->timeout = PCF8525_WD_DEFAULT_TIMEOUT_S;
+	watchdog_init_timeout(wdd, 0, dev);
+	pcf8525_wdt_set_timeout(wdd, wdd->timeout);
+
+	watchdog_set_drvdata(wdd, pcf8525);
+	watchdog_stop_on_reboot(wdd);
+	watchdog_stop_on_unregister(wdd);
+	watchdog_stop_ping_on_suspend(wdd);
+
+	/* Unregister the watchdog, detach INTB, then free the IRQ. */
+	ret = devm_add_action_or_reset(dev, pcf8525_wdt_cleanup, pcf8525);
+	if (ret)
+		return ret;
+
+	return devm_watchdog_register_device(dev, wdd);
+}
+
 static int pcf8525_get_inta_irq(struct i2c_client *client)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&client->dev);
@@ -719,6 +978,31 @@ static int pcf8525_get_inta_irq(struct i2c_client *client)
 	return client->irq;
 }
 
+static int pcf8525_get_intb_irq(struct i2c_client *client)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&client->dev);
+	int irq;
+
+	irq = fwnode_irq_get_byname(fwnode, "intb");
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
+	/* With no interrupt-names, INTB is the optional second interrupt. */
+	irq = fwnode_irq_get(fwnode, 1);
+	if (irq == -ENOENT || irq == -EINVAL || irq == -ENODATA ||
+	    irq == -ENXIO)
+		return 0;
+
+	return irq;
+}
+
 static int pcf8525_mask_irqs_inta(struct pcf8525 *pcf8525)
 {
 	int ret;
@@ -804,6 +1088,38 @@ static int pcf8525_setup_wakeup_only(struct device *dev,
 	return pcf8525_unmask_irqs_inta(pcf8525, false);
 }
 
+static int pcf8525_suspend(struct device *dev)
+{
+	struct pcf8525 *pcf8525 = dev_get_drvdata(dev);
+	int ret;
+
+	if (watchdog_active(&pcf8525->wdd)) {
+		/* Keep the counter and WD_CD state; only detach WDTF from INTB. */
+		ret = regmap_set_bits(pcf8525->regmap, PCF8525_REG_INTB_MASK1,
+				      PCF8525_MASK1_WD_CD);
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
+	if (watchdog_active(&pcf8525->wdd)) {
+		ret = pcf8525_wdt_arm(&pcf8525->wdd, false);
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
@@ -832,6 +1148,11 @@ static int pcf8525_probe(struct i2c_client *client)
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "failed to get INTA IRQ\n");
 
+	pcf8525->irq_intb = pcf8525_get_intb_irq(client);
+	if (pcf8525->irq_intb < 0)
+		return dev_err_probe(dev, pcf8525->irq_intb,
+				     "failed to get INTB IRQ\n");
+
 	/* Isolate stale and unused INTA sources before enabling timestamps. */
 	if (irq > 0 || wakeup) {
 		ret = pcf8525_mask_irqs_inta(pcf8525);
@@ -879,6 +1200,10 @@ static int pcf8525_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = pcf8525_watchdog_init(dev, pcf8525);
+	if (ret)
+		return ret;
+
 	/* Wakeup must be set up before registering so wakealarm is exposed. */
 	if (irq > 0 && !(client->flags & I2C_CLIENT_WAKE)) {
 		ret = devm_device_init_wakeup(dev);
@@ -919,6 +1244,7 @@ static struct i2c_driver pcf8525_driver = {
 	.driver = {
 		.name = "rtc-pcf8525",
 		.of_match_table = pcf8525_of_match,
+		.pm = pm_sleep_ptr(&pcf8525_pm_ops),
 	},
 	.probe = pcf8525_probe,
 	.id_table = pcf8525_i2c_id,
-- 
2.34.1

