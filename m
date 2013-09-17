Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27655 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab3IQKW3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Sep 2013 06:22:29 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org
Cc: wim@iguana.be, kgene.kim@samsung.com, devicetree@vger.kernel.org,
	t.figa@samsung.com, dianders@chromium.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read PMU
 registers adresses
Date: Tue, 17 Sep 2013 16:13:42 +0530
Message-id: <1379414623-26329-4-git-send-email-l.krishna@samsung.com>
In-reply-to: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch parses the watchdog node to read pmu wdt sys registers addresses
and do mask/unmask enable/disable of WDT in probe and s2r scenarios.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   14 ++++-
 drivers/watchdog/s3c2410_wdt.c                     |   56 ++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
index 2aa486c..4c798e3 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -7,8 +7,20 @@ occurred.
 Required properties:
 - compatible : should be "samsung,s3c2410-wdt"
 - reg : base physical address of the controller and length of memory mapped
-	region.
+	region and the optional (addresses and length of memory mapped regions
+	of) PMU registers for masking/unmasking WDT.
 - interrupts : interrupt number to the cpu.
 
 Optional properties:
 - timeout-sec : contains the watchdog timeout in seconds.
+- reset-mask-bit: bit number in the PMU registers to program mask/unmask WDT.
+
+Example:
+
+watchdog {
+	compatible = "samsung,s3c2410-wdt";
+	reg = <0x101D0000 0x100>, <0x10040408 0x4>, <0x1004040c 0x4>;
+	interrupts = <0 42 0>;
+	status = "disabled";
+	reset-mask-bit = <0>;
+};
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 23aad7c..a68e4dd 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -94,6 +94,9 @@ struct s3c2410_wdt {
 	unsigned long		wtdat_save;
 	struct watchdog_device	wdt_device;
 	struct notifier_block	freq_transition;
+	void __iomem		*pmu_disable_reg;
+	void __iomem		*pmu_mask_reset_reg;
+	int			pmu_mask_bit;
 };
 
 /* watchdog control routines */
@@ -111,6 +114,33 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
 	return container_of(nb, struct s3c2410_wdt, freq_transition);
 }
 
+static void s3c2410wdt_mask_and_disable_reset(int mask, struct s3c2410_wdt *wdt)
+{
+	unsigned int value;
+
+	if (IS_ERR(wdt->pmu_disable_reg) || IS_ERR(wdt->pmu_mask_reset_reg)
+					 || (wdt->pmu_mask_bit < 0))
+		return;
+
+	if (mask) {
+		value = readl(wdt->pmu_disable_reg);
+		value |= (1 << wdt->pmu_mask_bit);
+		writel(value, wdt->pmu_disable_reg);
+
+		value = readl(wdt->pmu_mask_reset_reg);
+		value |= (1 << wdt->pmu_mask_bit);
+		writel(value, wdt->pmu_mask_reset_reg);
+	} else {
+		value = readl(wdt->pmu_disable_reg);
+		value &= ~(1 << wdt->pmu_mask_bit);
+		writel(value, wdt->pmu_disable_reg);
+
+		value = readl(wdt->pmu_mask_reset_reg);
+		value &= ~(1 << wdt->pmu_mask_bit);
+		writel(value, wdt->pmu_mask_reset_reg);
+	}
+}
+
 static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -341,6 +371,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	unsigned int wtcon;
 	int started = 0;
 	int ret;
+	struct resource *res;
+	unsigned int mask_bit;
 
 	DBG("%s: probe=%p\n", __func__, pdev);
 
@@ -369,6 +401,25 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	wdt->pmu_disable_reg = devm_ioremap_resource(&pdev->dev, res);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	wdt->pmu_mask_reset_reg = devm_ioremap_resource(&pdev->dev, res);
+
+	if (!IS_ERR(wdt->pmu_disable_reg) && !IS_ERR(wdt->pmu_mask_reset_reg)) {
+		if (pdev->dev.of_node) {
+			if (of_property_read_u32(pdev->dev.of_node,
+							"reset-mask-bit",
+							&mask_bit)) {
+				dev_warn(dev, "reset-mask-bit not specified\n");
+				wdt->pmu_mask_bit = -EINVAL;
+			} else {
+				wdt->pmu_mask_bit = mask_bit;
+			}
+		}
+	}
+
 	DBG("probe: mapped reg_base=%p\n", wdt->reg_base);
 
 	wdt->clock = devm_clk_get(dev, "watchdog");
@@ -444,6 +495,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		 (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
 		 (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
 
+	s3c2410wdt_mask_and_disable_reset(0, wdt);
 	return 0;
 
  err_cpufreq:
@@ -461,6 +513,7 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 {
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	s3c2410wdt_mask_and_disable_reset(1, wdt);
 	watchdog_unregister_device(&wdt->wdt_device);
 
 	s3c2410wdt_cpufreq_deregister(wdt);
@@ -475,6 +528,7 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
 {
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
+	s3c2410wdt_mask_and_disable_reset(1, wdt);
 	s3c2410wdt_stop(&wdt->wdt_device);
 }
 
@@ -488,6 +542,7 @@ static int s3c2410wdt_suspend(struct device *dev)
 	wdt->wtcon_save = readl(wdt->reg_base + S3C2410_WTCON);
 	wdt->wtdat_save = readl(wdt->reg_base + S3C2410_WTDAT);
 
+	s3c2410wdt_mask_and_disable_reset(1, wdt);
 	/* Note that WTCNT doesn't need to be saved. */
 	s3c2410wdt_stop(&wdt->wdt_device);
 
@@ -503,6 +558,7 @@ static int s3c2410wdt_resume(struct device *dev)
 	writel(wdt->wtdat_save, wdt->reg_base + S3C2410_WTCNT);/* Reset count */
 	writel(wdt->wtcon_save, wdt->reg_base + S3C2410_WTCON);
 
+	s3c2410wdt_mask_and_disable_reset(0, wdt);
 	dev_info(dev, "watchdog %sabled\n",
 		(wdt->wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
 
-- 
1.7.9.5

