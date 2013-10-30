Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45030 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241Ab3J3Gkx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 02:40:53 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be
Cc: t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: [RESEND] [PATCH V3 2/2] watchdog: s3c2410_wdt: use syscon regmap
 interface to configure pmu register
Date: Wed, 30 Oct 2013 12:31:04 +0530
Message-id: <1383116464-5951-3-git-send-email-l.krishna@samsung.com>
In-reply-to: <1383116464-5951-1-git-send-email-l.krishna@samsung.com>
References: <1383116464-5951-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The syscon regmap interface is used to configure AUTOMATIC_WDT_RESET_DISABLE
and MASK_WDT_RESET_REQUEST registers of PMU to mask/unmask enable/disable of
watchdog in probe and s2r scenarios.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   13 ++-
 drivers/watchdog/s3c2410_wdt.c                     |  114 ++++++++++++++++++--
 2 files changed, 118 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
index 2aa486c..c46c7ce 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -5,10 +5,21 @@ after a preset amount of time during which the WDT reset event has not
 occurred.
 
 Required properties:
-- compatible : should be "samsung,s3c2410-wdt"
+- compatible : should be "samsung,s3c2410-wdt" or "samsung,s3c5250-wdt" or "samsung,s3c5420-wdt"
 - reg : base physical address of the controller and length of memory mapped
 	region.
 - interrupts : interrupt number to the cpu.
+- samsung,pmusysreg : reference node to pmu sysreg (required only in case of Exynos5250 and 5420)
 
 Optional properties:
 - timeout-sec : contains the watchdog timeout in seconds.
+
+watchdog@101D0000 {
+	compatible = "samsung,s3c5250-wdt";
+	reg = <0x101D0000 0x100>;
+	interrupts = <0 42 0>;
+	clocks = <&clock 336>;
+	clock-names = "watchdog";
+	samsung,sysreg = <&pmu_sys_reg>;
+	status = "okay";
+};
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 23aad7c..2a3429c 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -41,6 +41,8 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #define S3C2410_WTCON		0x00
 #define S3C2410_WTDAT		0x04
@@ -61,6 +63,10 @@
 #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
 #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
+#define WDT_DISABLE_REG_OFFSET		0x0408
+#define WDT_MASK_RESET_REG_OFFSET	0x040c
+#define QUIRK_NEEDS_PMU_CONFIG		(1 << 0)
+
 static bool nowayout	= WATCHDOG_NOWAYOUT;
 static int tmr_margin;
 static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
@@ -84,6 +90,12 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
 			"0 to reboot (default 0)");
 MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug (default 0)");
 
+struct pmu_config {
+	int	disable_reg;
+	int	mask_reset_reg;
+	int	mask_bit;
+};
+
 struct s3c2410_wdt {
 	struct device		*dev;
 	struct clk		*clock;
@@ -94,7 +106,34 @@ struct s3c2410_wdt {
 	unsigned long		wtdat_save;
 	struct watchdog_device	wdt_device;
 	struct notifier_block	freq_transition;
+	struct pmu_config	*wdt_pmu_config;
+	struct regmap		*pmureg;
+	unsigned int		quirks;
+};
+
+static struct pmu_config pmu_config_5250  = {
+	.disable_reg = WDT_DISABLE_REG_OFFSET,
+	.mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
+	.mask_bit = 20
+};
+
+static struct pmu_config pmu_config_5420 = {
+	.disable_reg = WDT_DISABLE_REG_OFFSET,
+	.mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
+	.mask_bit = 0
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id s3c2410_wdt_match[] = {
+	{ .compatible = "samsung,s3c2410-wdt" },
+	{ .compatible = "samsung,s3c5250-wdt",
+	  .data = (struct pmu_config *) &pmu_config_5250 },
+	{ .compatible = "samsung,s3c5420-wdt",
+	  .data = (struct pmu_config *) &pmu_config_5420 },
+	{},
 };
+MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
+#endif
 
 /* watchdog control routines */
 
@@ -111,6 +150,40 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
 	return container_of(nb, struct s3c2410_wdt, freq_transition);
 }
 
+static void s3c2410wdt_mask_and_disable_reset(int mask, struct s3c2410_wdt *wdt)
+{
+	unsigned int disable, mask_reset;
+	int ret;
+
+	ret = regmap_read(wdt->pmureg, wdt->wdt_pmu_config->disable_reg,
+								&disable);
+	if (ret < 0) {
+		dev_err(wdt->dev, "%s:%d fail to read disable reg(%d)\n",
+				__func__, __LINE__, ret);
+		return;
+	}
+
+	ret = regmap_read(wdt->pmureg, wdt->wdt_pmu_config->mask_reset_reg,
+								&mask_reset);
+	if (ret < 0) {
+		dev_err(wdt->dev, "%s:%d fail to read mask reset reg(%d)\n",
+				__func__, __LINE__, ret);
+		return;
+	}
+
+	if (mask) {
+		disable |= (1 << wdt->wdt_pmu_config->mask_bit);
+		mask_reset |= (1 << wdt->wdt_pmu_config->mask_bit);
+	} else {
+		disable &= ~(1 << wdt->wdt_pmu_config->mask_bit);
+		mask_reset &= ~(1 << wdt->wdt_pmu_config->mask_bit);
+	}
+
+	regmap_write(wdt->pmureg, wdt->wdt_pmu_config->disable_reg, disable);
+	regmap_write(wdt->pmureg, wdt->wdt_pmu_config->mask_reset_reg,
+								mask_reset);
+}
+
 static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -332,6 +405,14 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
 }
 #endif
 
+/* s3c2410_get_wdt_driver_data */
+static inline unsigned int get_wdt_driver_data(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
+	return (unsigned int)match->data;
+}
+
 static int s3c2410wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev;
@@ -354,6 +435,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 	wdt->wdt_device = s3c2410_wdd;
 
+	wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
+						"samsung,sysreg");
+	if (IS_ERR(wdt->pmureg)) {
+		dev_err(dev, "syscon regmap lookup failed.\n");
+		return PTR_ERR(wdt->pmureg);
+	}
+
+	wdt->wdt_pmu_config = (struct pmu_config *) get_wdt_driver_data(pdev);
+	if (wdt->wdt_pmu_config)
+		wdt->quirks = QUIRK_NEEDS_PMU_CONFIG;
+
 	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (wdt_irq == NULL) {
 		dev_err(dev, "no irq resource specified\n");
@@ -444,6 +536,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		 (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
 		 (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(0, wdt);
 	return 0;
 
  err_cpufreq:
@@ -461,6 +555,9 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 {
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(1, wdt);
+
 	watchdog_unregister_device(&wdt->wdt_device);
 
 	s3c2410wdt_cpufreq_deregister(wdt);
@@ -475,6 +572,9 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
 {
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(1, wdt);
+
 	s3c2410wdt_stop(&wdt->wdt_device);
 }
 
@@ -488,6 +588,9 @@ static int s3c2410wdt_suspend(struct device *dev)
 	wdt->wtcon_save = readl(wdt->reg_base + S3C2410_WTCON);
 	wdt->wtdat_save = readl(wdt->reg_base + S3C2410_WTDAT);
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(1, wdt);
+
 	/* Note that WTCNT doesn't need to be saved. */
 	s3c2410wdt_stop(&wdt->wdt_device);
 
@@ -503,6 +606,9 @@ static int s3c2410wdt_resume(struct device *dev)
 	writel(wdt->wtdat_save, wdt->reg_base + S3C2410_WTCNT);/* Reset count */
 	writel(wdt->wtcon_save, wdt->reg_base + S3C2410_WTCON);
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(0, wdt);
+
 	dev_info(dev, "watchdog %sabled\n",
 		(wdt->wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
 
@@ -513,14 +619,6 @@ static int s3c2410wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops, s3c2410wdt_suspend,
 			s3c2410wdt_resume);
 
-#ifdef CONFIG_OF
-static const struct of_device_id s3c2410_wdt_match[] = {
-	{ .compatible = "samsung,s3c2410-wdt" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
-#endif
-
 static struct platform_driver s3c2410wdt_driver = {
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
-- 
1.7.10.4

