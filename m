Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39678 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753900AbaAUJMv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:12:51 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a separate resource
Date: Tue, 21 Jan 2014 06:12:31 -0300
Message-Id: <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to support other SoC, it's required to distinguish
the 'control' timer register, from the 'rstout' register
that enables system reset on watchdog expiration.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/watchdog/marvel.txt |  6 ++++--
 arch/arm/mach-dove/include/mach/bridge-regs.h         |  1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h     |  1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h      |  1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h      |  1 +
 arch/arm/plat-orion/common.c                          | 10 ++++++----
 drivers/watchdog/orion_wdt.c                          | 12 ++++++++++--
 7 files changed, 24 insertions(+), 8 deletions(-)

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
index c66d163..3375037 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -594,14 +594,16 @@ void __init orion_spi_1_init(unsigned long mapbase)
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
index 06e766f..9c7d695 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -47,6 +47,7 @@ static unsigned int wdt_max_duration;	/* (seconds) */
 static struct clk *clk;
 static unsigned int wdt_tclk;
 static void __iomem *wdt_reg;
+static void __iomem *wdt_rstout;
 static DEFINE_SPINLOCK(wdt_lock);
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
@@ -74,7 +75,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
 
 	/* Enable reset on watchdog */
-	atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
+	atomic_io_modify(wdt_rstout, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
 
 	spin_unlock(&wdt_lock);
 	return 0;
@@ -85,7 +86,7 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	spin_lock(&wdt_lock);
 
 	/* Disable reset on watchdog */
-	atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, 0);
+	atomic_io_modify(wdt_rstout, WDT_RESET_OUT_EN, 0);
 
 	/* Disable watchdog timer */
 	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, 0);
@@ -158,6 +159,13 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!wdt_reg)
 		return -ENOMEM;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+	wdt_rstout = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!wdt_rstout)
+		return -ENOMEM;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq > 0) {
 		/*
-- 
1.8.1.5

