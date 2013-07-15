Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60530 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758370Ab3GOXdo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jul 2013 19:33:44 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree-discuss@lists.ozlabs.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 05/10] watchdog: orion: Add a memory resource for RSTOUT register
Date: Mon, 15 Jul 2013 20:32:38 -0300
Message-Id: <1373931163-12670-6-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of accessing the RSTOUT register directly, this commit
adds a platform memory resource to map this register into the driver.

Note that by adding a required 2nd-cell for the reg property,
this change breaks the device-tree binding compatibility.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  |  1 +
 arch/arm/plat-orion/common.c                      | 10 ++++++----
 drivers/watchdog/orion_wdt.c                      | 18 ++++++++++--------
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index c3f361d..dead75a 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -21,6 +21,7 @@
 #define CPU_RESET		0x00000002
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
+#define RSTOUT_PHYS_BASE	(BRIDGE_PHYS_BASE + 0x0108)
 #define WDT_RESET_OUT_EN	0x00000002
 #define SOFT_RESET_OUT_EN	0x00000004
 
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index aa35de3..ccd91c9 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -18,6 +18,7 @@
 #define CPU_CTRL		(ORION5X_BRIDGE_VIRT_BASE + 0x104)
 
 #define RSTOUTn_MASK		(ORION5X_BRIDGE_VIRT_BASE + 0x108)
+#define RSTOUT_PHYS_BASE	(ORION5X_BRIDGE_PHYS_BASE + 0x108)
 #define WDT_RESET_OUT_EN	0x0002
 
 #define CPU_SOFT_RESET		(ORION5X_BRIDGE_VIRT_BASE + 0x10c)
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 77fac6c..37924f8 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -594,14 +594,16 @@ void __init orion_spi_1_init(unsigned long mapbase)
 /*****************************************************************************
  * Watchdog
  ****************************************************************************/
-static struct resource orion_wdt_resource =
-		DEFINE_RES_MEM(WDT_PHYS_BASE, 0x04);
+static struct resource orion_wdt_resource[] = {
+		DEFINE_RES_MEM(WDT_PHYS_BASE, 0x04),
+		DEFINE_RES_MEM(RSTOUT_PHYS_BASE, 0x04)
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
index 01bcf53..3c9b3d2 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -43,6 +43,7 @@ static unsigned int wdt_max_duration;	/* (seconds) */
 static struct clk *clk;
 static unsigned int wdt_tclk;
 static void __iomem *wdt_reg;
+static void __iomem *rstout_reg;
 static DEFINE_SPINLOCK(wdt_lock);
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
@@ -74,9 +75,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	orion_timer_ctrl_clrset(0, WDT_EN);
 
 	/* Enable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
-	reg |= WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
+	writel(readl(rstout_reg) | WDT_RESET_OUT_EN, rstout_reg);
 
 	spin_unlock(&wdt_lock);
 	return 0;
@@ -84,14 +83,10 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 
 static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 {
-	u32 reg;
-
 	spin_lock(&wdt_lock);
 
 	/* Disable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
-	reg &= ~WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
+	writel(readl(rstout_reg) & ~WDT_RESET_OUT_EN, rstout_reg);
 
 	/* Disable watchdog timer */
 	orion_timer_ctrl_clrset(WDT_EN, 0);
@@ -158,6 +153,13 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!wdt_reg)
 		return -ENOMEM;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+	rstout_reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!rstout_reg)
+		return -ENOMEM;
+
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
 	orion_wdt.timeout = wdt_max_duration;
-- 
1.8.1.5

