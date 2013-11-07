Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32256 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab3KGLbW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Nov 2013 06:31:22 -0500
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be
Cc: t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: [PATCH V6 3/3] watchdog: s3c2410_wdt: use syscon regmap interface to
 configure pmu register
Date: Thu, 07 Nov 2013 17:21:18 +0530
Message-id: <1383825078-24515-4-git-send-email-l.krishna@samsung.com>
In-reply-to: <1383825078-24515-1-git-send-email-l.krishna@samsung.com>
References: <1383825078-24515-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The syscon regmap interface is used to configure AUTOMATIC_WDT_RESET_DISABLE
and MASK_WDT_RESET_REQUEST registers of PMU to mask/unmask enable/disable of
watchdog in probe and s2r scenarios.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
 drivers/watchdog/s3c2410_wdt.c                     |  139 ++++++++++++++++++--
 2 files changed, 151 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
index 2aa486c..5dea363 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -5,10 +5,29 @@ after a preset amount of time during which the WDT reset event has not
 occurred.
 
 Required properties:
-- compatible : should be "samsung,s3c2410-wdt"
+- compatible : should be one among the following
+	(a) "samsung,s3c2410-wdt" for Exynos4 and previous SoCs
+	(b) "samsung,exynos5250-wdt" for Exynos5250
+	(c) "samsung,exynos5420-wdt" for Exynos5420
+
 - reg : base physical address of the controller and length of memory mapped
 	region.
 - interrupts : interrupt number to the cpu.
+- samsung,syscon-phandle : reference to syscon node (This property required only
+	in case of compatible being "samsung,exynos5250-wdt" or "samsung,exynos5420-wdt".
+	In case of Exynos5250 and 5420 this property points to syscon node holding the PMU
+	base address)
 
 Optional properties:
 - timeout-sec : contains the watchdog timeout in seconds.
+
+Example:
+
+watchdog@101D0000 {
+	compatible = "samsung,exynos5250-wdt";
+	reg = <0x101D0000 0x100>;
+	interrupts = <0 42 0>;
+	clocks = <&clock 336>;
+	clock-names = "watchdog";
+	samsung,syscon-phandle = <&pmu_sys_reg>;
+};
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 23aad7c..a151c20 100644
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
@@ -84,6 +90,13 @@ MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
 			"0 to reboot (default 0)");
 MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug (default 0)");
 
+struct s3c2410_wdt_variant {
+	int disable_reg;
+	int mask_reset_reg;
+	int mask_bit;
+	u32 quirks;
+};
+
 struct s3c2410_wdt {
 	struct device		*dev;
 	struct clk		*clock;
@@ -94,7 +107,40 @@ struct s3c2410_wdt {
 	unsigned long		wtdat_save;
 	struct watchdog_device	wdt_device;
 	struct notifier_block	freq_transition;
+	struct s3c2410_wdt_variant *pmu_config;
+	struct regmap *pmureg;
+};
+
+#ifdef CONFIG_OF
+static const struct s3c2410_wdt_variant pmu_config_s3c2410 = {
+	.quirks = 0
+};
+
+static const struct s3c2410_wdt_variant pmu_config_5250  = {
+	.disable_reg = WDT_DISABLE_REG_OFFSET,
+	.mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
+	.mask_bit = 20,
+	.quirks = QUIRK_NEEDS_PMU_CONFIG
+};
+
+static const struct s3c2410_wdt_variant pmu_config_5420 = {
+	.disable_reg = WDT_DISABLE_REG_OFFSET,
+	.mask_reset_reg = WDT_MASK_RESET_REG_OFFSET,
+	.mask_bit = 0,
+	.quirks = QUIRK_NEEDS_PMU_CONFIG
+};
+
+static const struct of_device_id s3c2410_wdt_match[] = {
+	{ .compatible = "samsung,s3c2410-wdt",
+	  .data = &pmu_config_s3c2410 },
+	{ .compatible = "samsung,exynos5250-wdt",
+	  .data = &pmu_config_5250 },
+	{ .compatible = "samsung,exynos5420-wdt",
+	  .data = &pmu_config_5420 },
+	{},
 };
+MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
+#endif
 
 /* watchdog control routines */
 
@@ -111,6 +157,30 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
 	return container_of(nb, struct s3c2410_wdt, freq_transition);
 }
 
+static int s3c2410wdt_mask_and_disable_reset(struct s3c2410_wdt *wdt, bool mask)
+{
+	int ret;
+	u32 mask_val = 1 << wdt->pmu_config->mask_bit;
+	u32 val = 0;
+
+	if (mask)
+		val = mask_val;
+
+	ret = regmap_update_bits(wdt->pmureg,
+			wdt->pmu_config->disable_reg,
+			mask_val, val);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(wdt->pmureg,
+			wdt->pmu_config->mask_reset_reg,
+			mask_val, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -332,6 +402,21 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
 }
 #endif
 
+/* s3c2410_get_wdt_driver_data */
+static inline struct s3c2410_wdt_variant *
+get_wdt_drv_data(struct platform_device *pdev)
+{
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
+		return (struct s3c2410_wdt_variant *)match->data;
+	}
+#endif
+	return (struct s3c2410_wdt_variant *)
+		platform_get_device_id(pdev)->driver_data;
+}
+
 static int s3c2410wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev;
@@ -354,6 +439,16 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 	wdt->wdt_device = s3c2410_wdd;
 
+	wdt->pmu_config = get_wdt_drv_data(pdev);
+	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
+		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
+							"samsung,syscon-phandle");
+		if (IS_ERR(wdt->pmureg)) {
+			dev_err(dev, "syscon regmap lookup failed.\n");
+			return PTR_ERR(wdt->pmureg);
+		}
+	}
+
 	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (wdt_irq == NULL) {
 		dev_err(dev, "no irq resource specified\n");
@@ -444,6 +539,14 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		 (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
 		 (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
 
+	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
+		ret = s3c2410wdt_mask_and_disable_reset(wdt, false);
+		if (ret < 0) {
+			dev_warn(wdt->dev, "failed to update pmu register");
+			goto err_cpufreq;
+		}
+	}
+
 	return 0;
 
  err_cpufreq:
@@ -459,8 +562,15 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 static int s3c2410wdt_remove(struct platform_device *dev)
 {
+	int ret;
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
+		ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
+		if (ret < 0)
+			dev_warn(wdt->dev, "failed to update pmu register");
+	}
+
 	watchdog_unregister_device(&wdt->wdt_device);
 
 	s3c2410wdt_cpufreq_deregister(wdt);
@@ -473,8 +583,15 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 
 static void s3c2410wdt_shutdown(struct platform_device *dev)
 {
+	int ret;
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
+		ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
+		if (ret < 0)
+			dev_warn(wdt->dev, "failed to update pmu register");
+	}
+
 	s3c2410wdt_stop(&wdt->wdt_device);
 }
 
@@ -482,12 +599,19 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
 
 static int s3c2410wdt_suspend(struct device *dev)
 {
+	int ret;
 	struct s3c2410_wdt *wdt = dev_get_drvdata(dev);
 
 	/* Save watchdog state, and turn it off. */
 	wdt->wtcon_save = readl(wdt->reg_base + S3C2410_WTCON);
 	wdt->wtdat_save = readl(wdt->reg_base + S3C2410_WTDAT);
 
+	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
+		ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
+		if (ret < 0)
+			dev_warn(wdt->dev, "failed to update pmu register");
+	}
+
 	/* Note that WTCNT doesn't need to be saved. */
 	s3c2410wdt_stop(&wdt->wdt_device);
 
@@ -496,6 +620,7 @@ static int s3c2410wdt_suspend(struct device *dev)
 
 static int s3c2410wdt_resume(struct device *dev)
 {
+	int ret;
 	struct s3c2410_wdt *wdt = dev_get_drvdata(dev);
 
 	/* Restore watchdog state. */
@@ -503,6 +628,12 @@ static int s3c2410wdt_resume(struct device *dev)
 	writel(wdt->wtdat_save, wdt->reg_base + S3C2410_WTCNT);/* Reset count */
 	writel(wdt->wtcon_save, wdt->reg_base + S3C2410_WTCON);
 
+	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
+		ret = s3c2410wdt_mask_and_disable_reset(wdt, false);
+		if (ret < 0)
+			dev_warn(wdt->dev, "failed to update pmu register");
+	}
+
 	dev_info(dev, "watchdog %sabled\n",
 		(wdt->wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
 
@@ -513,14 +644,6 @@ static int s3c2410wdt_resume(struct device *dev)
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

