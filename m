Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30072 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab3I0Jz3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 05:55:29 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	kgene.kim@samsung.com
Cc: devicetree@vger.kernel.org, t.figa@samsung.com,
	dianders@chromium.org, linux-watchdog@vger.kernel.org
Subject: [PATCH V2 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
Date: Fri, 27 Sep 2013 15:46:25 +0530
Message-id: <1380276986-24131-4-git-send-email-l.krishna@samsung.com>
In-reply-to: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
References: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch parses the watchdog node to read pmu wdt sys registers addresses
and do mask/unmask enable/disable of WDT in probe and s2r scenarios.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   24 ++++-
 drivers/watchdog/s3c2410_wdt.c                     |   94 ++++++++++++++++++--
 2 files changed, 108 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
index 2aa486c..f78b802 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -5,10 +5,30 @@ after a preset amount of time during which the WDT reset event has not
 occurred.
 
 Required properties:
-- compatible : should be "samsung,s3c2410-wdt"
+- compatible : should be "samsung,s3c2410-wdt" or "samsung,s3c5250-wdt"
 - reg : base physical address of the controller and length of memory mapped
-	region.
+	region and additional (addresses and length of memory mapped regions
+	of) PMU registers for masking/unmasking WDT only in case of Exynos5250 and 5420.
 - interrupts : interrupt number to the cpu.
+- reset-mask-bit: bit number in the PMU registers to program mask/unmask WDT (required only
+	in case	of Exynos5250 and 5420).
 
 Optional properties:
 - timeout-sec : contains the watchdog timeout in seconds.
+
+Examples:
+
+watchdog {
+	compatible = "samsung,s3c2410-wdt";
+	reg = <0x101D0000 0x100>;
+	interrupts = <0 42 0>;
+	status = "disabled";
+};
+
+watchdog {
+        compatible = "samsung,s3c5250-wdt";
+        reg = <0x101D0000 0x100>, <0x10040408 0x4>, <0x1004040c 0x4>;
+        interrupts = <0 42 0>;
+        status = "disabled";
+        reset-mask-bit = <0>;
+};
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 23aad7c..89eabca 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -61,6 +61,8 @@
 #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
 #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
+#define QUIRK_NEEDS_PMU_CONFIG	(1 << 0)
+
 static bool nowayout	= WATCHDOG_NOWAYOUT;
 static int tmr_margin;
 static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
@@ -94,7 +96,21 @@ struct s3c2410_wdt {
 	unsigned long		wtdat_save;
 	struct watchdog_device	wdt_device;
 	struct notifier_block	freq_transition;
+	void __iomem		*pmu_disable_reg;
+	void __iomem		*pmu_mask_reset_reg;
+	int			pmu_mask_bit;
+	unsigned int		quirks;
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id s3c2410_wdt_match[] = {
+	{ .compatible = "samsung,s3c2410-wdt" },
+	{ .compatible = "samsung,s3c5250-wdt",
+	  .data	= (void *) QUIRK_NEEDS_PMU_CONFIG },
+	{},
 };
+MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
+#endif
 
 /* watchdog control routines */
 
@@ -111,6 +127,25 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
 	return container_of(nb, struct s3c2410_wdt, freq_transition);
 }
 
+static void s3c2410wdt_mask_and_disable_reset(int mask, struct s3c2410_wdt *wdt)
+{
+	unsigned int disable, mask_reset;
+
+	disable = readl(wdt->pmu_disable_reg);
+	mask_reset = readl(wdt->pmu_mask_reset_reg);
+
+	if (mask) {
+		disable |= (1 << wdt->pmu_mask_bit);
+		mask_reset |= (1 << wdt->pmu_mask_bit);
+	} else {
+		disable &= ~(1 << wdt->pmu_mask_bit);
+		mask_reset &= ~(1 << wdt->pmu_mask_bit);
+	}
+
+	writel(disable, wdt->pmu_disable_reg);
+	writel(mask_reset, wdt->pmu_mask_reset_reg);
+}
+
 static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -332,6 +367,14 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
 }
 #endif
 
+/* s3c2410_get_wdt_quirks */
+static inline unsigned int s3c2410_get_wdt_quirks(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
+	return (unsigned int)match->data;
+}
+
 static int s3c2410wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev;
@@ -341,6 +384,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	unsigned int wtcon;
 	int started = 0;
 	int ret;
+	struct resource *res;
+	unsigned int mask_bit;
 
 	DBG("%s: probe=%p\n", __func__, pdev);
 
@@ -369,6 +414,37 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	wdt->quirks = s3c2410_get_wdt_quirks(pdev);
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		wdt->pmu_disable_reg = devm_ioremap_resource(&pdev->dev, res);
+
+		if (IS_ERR(wdt->pmu_disable_reg)) {
+			dev_err(dev, "failed to find PMU disable register\n");
+			ret = PTR_ERR(wdt->pmu_disable_reg);
+			goto err;
+		}
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		wdt->pmu_mask_reset_reg = devm_ioremap_resource(&pdev->dev,
+									res);
+
+		if (IS_ERR(wdt->pmu_mask_reset_reg)) {
+			dev_err(dev, "failed to find PMU mask reset register\n");
+			ret = PTR_ERR(wdt->pmu_mask_reset_reg);
+			goto err;
+		}
+
+		if (of_property_read_u32(pdev->dev.of_node, "reset-mask-bit",
+								&mask_bit)) {
+			dev_err(dev, "reset-mask-bit not specified\n");
+			ret = -EINVAL;
+			goto err;
+		} else {
+			wdt->pmu_mask_bit = mask_bit;
+		}
+	}
+
 	DBG("probe: mapped reg_base=%p\n", wdt->reg_base);
 
 	wdt->clock = devm_clk_get(dev, "watchdog");
@@ -444,6 +520,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		 (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
 		 (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(0, wdt);
 	return 0;
 
  err_cpufreq:
@@ -461,6 +539,8 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 {
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(1, wdt);
 	watchdog_unregister_device(&wdt->wdt_device);
 
 	s3c2410wdt_cpufreq_deregister(wdt);
@@ -475,6 +555,8 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
 {
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(1, wdt);
 	s3c2410wdt_stop(&wdt->wdt_device);
 }
 
@@ -488,6 +570,8 @@ static int s3c2410wdt_suspend(struct device *dev)
 	wdt->wtcon_save = readl(wdt->reg_base + S3C2410_WTCON);
 	wdt->wtdat_save = readl(wdt->reg_base + S3C2410_WTDAT);
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(1, wdt);
 	/* Note that WTCNT doesn't need to be saved. */
 	s3c2410wdt_stop(&wdt->wdt_device);
 
@@ -503,6 +587,8 @@ static int s3c2410wdt_resume(struct device *dev)
 	writel(wdt->wtdat_save, wdt->reg_base + S3C2410_WTCNT);/* Reset count */
 	writel(wdt->wtcon_save, wdt->reg_base + S3C2410_WTCON);
 
+	if (wdt->quirks & QUIRK_NEEDS_PMU_CONFIG)
+		s3c2410wdt_mask_and_disable_reset(0, wdt);
 	dev_info(dev, "watchdog %sabled\n",
 		(wdt->wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
 
@@ -513,14 +599,6 @@ static int s3c2410wdt_resume(struct device *dev)
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
1.7.9.5

