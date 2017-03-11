Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754017AbdCKR0B (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 11 Mar 2017 12:26:01 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 2/8] watchdog: s3c2410: Fix infinite interrupt in soft mode
Date: Sat, 11 Mar 2017 19:25:21 +0200
Message-Id: <20170311172527.16368-3-krzk@kernel.org>
In-Reply-To: <20170311172527.16368-1-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
of an interrupt.  However the interrupt itself was not cleared thus on
first hit, the system enters infinite interrupt handling loop.

On Odroid U3 (Exynos4412), when booted with s3c2410_wdt.soft_noboot=1
argument the console is flooded:
	# killall -9 watchdog
	[   60.523760] s3c2410-wdt 10060000.watchdog: watchdog timer expired (irq)
	[   60.536744] s3c2410-wdt 10060000.watchdog: watchdog timer expired (irq)

Fix this by writing something to the WTCLRINT register to clear the
interrupt.  The register WTCLRINT however appeared in S3C6410 so a new
watchdog quirk and flavor are needed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/watchdog/samsung-wdt.txt    |  9 +++++----
 drivers/watchdog/s3c2410_wdt.c                      | 21 ++++++++++++++++++---
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
index 8f3d96af81d7..1f6e101e299a 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -6,10 +6,11 @@ occurred.
 
 Required properties:
 - compatible : should be one among the following
-	(a) "samsung,s3c2410-wdt" for Exynos4 and previous SoCs
-	(b) "samsung,exynos5250-wdt" for Exynos5250
-	(c) "samsung,exynos5420-wdt" for Exynos5420
-	(c) "samsung,exynos7-wdt" for Exynos7
+	- "samsung,s3c2410-wdt" for S3C2410
+	- "samsung,s3c6410-wdt" for S3C6410, S5PV210 and Exynos4
+	- "samsung,exynos5250-wdt" for Exynos5250
+	- "samsung,exynos5420-wdt" for Exynos5420
+	- "samsung,exynos7-wdt" for Exynos7
 
 - reg : base physical address of the controller and length of memory mapped
 	region.
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 3e216f54cb6f..7db7847a005c 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -46,6 +46,7 @@
 #define S3C2410_WTCON		0x00
 #define S3C2410_WTDAT		0x04
 #define S3C2410_WTCNT		0x08
+#define S3C2410_WTCLRINT	0x0c
 
 #define S3C2410_WTCNT_MAXCNT	0xffff
 
@@ -72,6 +73,7 @@
 #define EXYNOS5_WDT_MASK_RESET_REG_OFFSET	0x040c
 #define QUIRK_HAS_PMU_CONFIG			(1 << 0)
 #define QUIRK_HAS_RST_STAT			(1 << 1)
+#define QUIRK_HAS_WTCLRINT_REG			(1 << 2)
 
 /* These quirks require that we have a PMU register map */
 #define QUIRKS_HAVE_PMUREG			(QUIRK_HAS_PMU_CONFIG | \
@@ -143,13 +145,18 @@ static const struct s3c2410_wdt_variant drv_data_s3c2410 = {
 };
 
 #ifdef CONFIG_OF
+static const struct s3c2410_wdt_variant drv_data_s3c6410 = {
+	.quirks = QUIRK_HAS_WTCLRINT_REG,
+};
+
 static const struct s3c2410_wdt_variant drv_data_exynos5250  = {
 	.disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
 	.mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
 	.mask_bit = 20,
 	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
 	.rst_stat_bit = 20,
-	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
+	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT \
+		  | QUIRK_HAS_WTCLRINT_REG,
 };
 
 static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
@@ -158,7 +165,8 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
 	.mask_bit = 0,
 	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
 	.rst_stat_bit = 9,
-	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
+	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT \
+		  | QUIRK_HAS_WTCLRINT_REG,
 };
 
 static const struct s3c2410_wdt_variant drv_data_exynos7 = {
@@ -167,12 +175,15 @@ static const struct s3c2410_wdt_variant drv_data_exynos7 = {
 	.mask_bit = 23,
 	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
 	.rst_stat_bit = 23,	/* A57 WDTRESET */
-	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
+	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT \
+		  | QUIRK_HAS_WTCLRINT_REG,
 };
 
 static const struct of_device_id s3c2410_wdt_match[] = {
 	{ .compatible = "samsung,s3c2410-wdt",
 	  .data = &drv_data_s3c2410 },
+	{ .compatible = "samsung,s3c6410-wdt",
+	  .data = &drv_data_s3c6410 },
 	{ .compatible = "samsung,exynos5250-wdt",
 	  .data = &drv_data_exynos5250 },
 	{ .compatible = "samsung,exynos5420-wdt",
@@ -418,6 +429,10 @@ static irqreturn_t s3c2410wdt_irq(int irqno, void *param)
 	dev_info(wdt->dev, "watchdog timer expired (irq)\n");
 
 	s3c2410wdt_keepalive(&wdt->wdt_device);
+
+	if (wdt->drv_data->quirks & QUIRK_HAS_WTCLRINT_REG)
+		writel(0x1, wdt->reg_base + S3C2410_WTCLRINT);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.9.3

