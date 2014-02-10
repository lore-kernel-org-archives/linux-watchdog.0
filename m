Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v7 06/18] watchdog: orion: Make RSTOUT register a separate resource
Date: Mon, 10 Feb 2014 20:00:25 -0300
Message-Id: <1392073237-2554-7-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

In order to support other SoC, it's required to distinguish
the 'control' timer register, from the 'rstout' register
that enables system reset on watchdog expiration.

To prevent a compatibility break, this commit adds a fallback
to a hardcoded RSTOUT address.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/watchdog/marvel.txt        |  6 ++-
 arch/arm/mach-dove/include/mach/bridge-regs.h      |  1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |  1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |  1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |  1 +
 arch/arm/plat-orion/common.c                       | 10 +++--
 drivers/watchdog/orion_wdt.c                       | 47 ++++++++++++++++++++--
 7 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 0731fbd..1544fe9 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -3,7 +3,9 @@
 Required Properties:
 
 - Compatibility : "marvell,orion-wdt"
-- reg		: Address of the timer registers
+- reg		: Should contain two entries: first one with the
+		  timer control address, second one with the
+		  rstout enable address.
 
 Optional properties:
 
@@ -14,7 +16,7 @@ Example:
 
 	wdt@20300 {
 		compatible = "marvell,orion-wdt";
-		reg = <0x20300 0x28>;
+		reg = <0x20300 0x28>, <0x20108 0x4>;
 		interrupts = <3>;
 		timeout-sec = <10>;
 		status = "okay";
diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
index 5362df3..f4a5b34 100644
--- a/arch/arm/mach-dove/include/mach/bridge-regs.h
+++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
@@ -21,6 +21,7 @@
 #define  CPU_CTRL_PCIE1_LINK	0x00000008
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
+#define RSTOUTn_MASK_PHYS	(BRIDGE_PHYS_BASE + 0x0108)
 #define  SOFT_RESET_OUT_EN	0x00000004
 
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 8b9d1c9..60f6421 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -21,6 +21,7 @@
 #define CPU_RESET		0x00000002
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
+#define RSTOUTn_MASK_PHYS	(BRIDGE_PHYS_BASE + 0x0108)
 #define SOFT_RESET_OUT_EN	0x00000004
 
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
index 5f03484..e20d6da 100644
--- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
@@ -15,6 +15,7 @@
 #define L2_WRITETHROUGH		0x00020000
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
+#define RSTOUTn_MASK_PHYS	(BRIDGE_PHYS_BASE + 0x0108)
 #define SOFT_RESET_OUT_EN	0x00000004
 
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index f727d03..5766e3f 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -18,6 +18,7 @@
 #define CPU_CTRL		(ORION5X_BRIDGE_VIRT_BASE + 0x104)
 
 #define RSTOUTn_MASK		(ORION5X_BRIDGE_VIRT_BASE + 0x108)
+#define RSTOUTn_MASK_PHYS	(ORION5X_BRIDGE_PHYS_BASE + 0x108)
 
 #define CPU_SOFT_RESET		(ORION5X_BRIDGE_VIRT_BASE + 0x10c)
 
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 830ff07..3ec6e8e 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -595,14 +595,16 @@ void __init orion_spi_1_init(unsigned long mapbase)
 /*****************************************************************************
  * Watchdog
  ****************************************************************************/
-static struct resource orion_wdt_resource =
-		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x28);
+static struct resource orion_wdt_resource[] = {
+		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x04),
+		DEFINE_RES_MEM(RSTOUTn_MASK_PHYS, 0x04),
+};
 
 static struct platform_device orion_wdt_device = {
 	.name		= "orion_wdt",
 	.id		= -1,
-	.num_resources	= 1,
-	.resource	= &orion_wdt_resource,
+	.num_resources	= ARRAY_SIZE(orion_wdt_resource),
+	.resource	= orion_wdt_resource,
 };
 
 void __init orion_wdt_init(void)
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index b7067ac..6061b83 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -26,6 +26,12 @@
 #include <linux/of.h>
 #include <mach/bridge-regs.h>
 
+/* RSTOUT mask register physical address for Orion5x, Kirkwood and Dove */
+#define ORION_RSTOUT_MASK_OFFSET	0x20108
+
+/* Internal registers can be configured at any 1 MiB aligned address */
+#define INTERNAL_REGS_MASK		~(SZ_1M - 1)
+
 /*
  * Watchdog timer block registers.
  */
@@ -44,6 +50,7 @@ static unsigned int wdt_max_duration;	/* (seconds) */
 static struct clk *clk;
 static unsigned int wdt_tclk;
 static void __iomem *wdt_reg;
+static void __iomem *wdt_rstout;
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
@@ -64,14 +71,14 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
 
 	/* Enable reset on watchdog */
-	atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
+	atomic_io_modify(wdt_rstout, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
 	return 0;
 }
 
 static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	/* Disable reset on watchdog */
-	atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, 0);
+	atomic_io_modify(wdt_rstout, WDT_RESET_OUT_EN, 0);
 
 	/* Disable watchdog timer */
 	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, 0);
@@ -82,7 +89,7 @@ static int orion_wdt_enabled(void)
 {
 	bool enabled, running;
 
-	enabled = readl(RSTOUTn_MASK) & WDT_RESET_OUT_EN;
+	enabled = readl(wdt_rstout) & WDT_RESET_OUT_EN;
 	running = readl(wdt_reg + TIMER_CTRL) & WDT_EN;
 
 	return enabled && running;
@@ -126,6 +133,33 @@ static irqreturn_t orion_wdt_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+/*
+ * The original devicetree binding for this driver specified only
+ * one memory resource, so in order to keep DT backwards compatibility
+ * we try to fallback to a hardcoded register address, if the resource
+ * is missing from the devicetree.
+ */
+static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
+					      phys_addr_t internal_regs)
+{
+	struct resource *res;
+	phys_addr_t rstout;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res)
+		return devm_ioremap(&pdev->dev, res->start,
+				    resource_size(res));
+
+	/* This workaround works only for "orion-wdt", DT-enabled */
+	if (!of_device_is_compatible(pdev->dev.of_node, "marvell,orion-wdt"))
+		return NULL;
+
+	rstout = internal_regs + ORION_RSTOUT_MASK_OFFSET;
+
+	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg 0x%x\n", rstout);
+	return devm_ioremap(&pdev->dev, rstout, 0x4);
+}
+
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -153,6 +187,13 @@ static int orion_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
+	wdt_rstout = orion_wdt_ioremap_rstout(pdev, res->start &
+						    INTERNAL_REGS_MASK);
+	if (!wdt_rstout) {
+		ret = -ENODEV;
+		goto disable_clk;
+	}
+
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
 	orion_wdt.timeout = wdt_max_duration;
-- 
1.8.1.5
