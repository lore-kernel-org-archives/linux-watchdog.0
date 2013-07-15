Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60521 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758431Ab3GOXdi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jul 2013 19:33:38 -0400
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
Subject: [PATCH 04/10] watchdog: orion: Use the proper watchdog register
Date: Mon, 15 Jul 2013 20:32:37 -0300
Message-Id: <1373931163-12670-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Until now the watchdog driver was using the timer control register
to access the watchdog counter register. This is not appropriate,
given the timer control register should be controlled by the clocksource
driver alone.

Fix this by passing the correct register address to the driver and making
direct use of it. Note that this breaks the current device-tree binding
compatibility since it changes the meaning of the 'reg' property.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h | 1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  | 1 +
 arch/arm/plat-orion/common.c                      | 2 +-
 drivers/watchdog/orion_wdt.c                      | 7 +++----
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index d4cbe5e..c3f361d 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -40,6 +40,7 @@
 
 #define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0300)
 #define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE + 0x0300)
+#define WDT_PHYS_BASE		(BRIDGE_PHYS_BASE + 0x0324)
 
 #define L2_CONFIG_REG		(BRIDGE_VIRT_BASE + 0x0128)
 #define L2_WRITETHROUGH		0x00000010
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index 461fd69..aa35de3 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -36,4 +36,5 @@
 
 #define TIMER_VIRT_BASE		(ORION5X_BRIDGE_VIRT_BASE + 0x300)
 #define TIMER_PHYS_BASE		(ORION5X_BRIDGE_PHYS_BASE + 0x300)
+#define WDT_PHYS_BASE		(ORION5X_BRIDGE_PHYS_BASE + 0x324)
 #endif
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index c019b7a..77fac6c 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -595,7 +595,7 @@ void __init orion_spi_1_init(unsigned long mapbase)
  * Watchdog
  ****************************************************************************/
 static struct resource orion_wdt_resource =
-		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x28);
+		DEFINE_RES_MEM(WDT_PHYS_BASE, 0x04);
 
 static struct platform_device orion_wdt_device = {
 	.name		= "orion_wdt",
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index c0597f4..01bcf53 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -32,7 +32,6 @@
  * Watchdog timer block registers.
  */
 #define WDT_EN			0x0010
-#define WDT_VAL			0x0024
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 #define WDT_IN_USE		0
@@ -51,7 +50,7 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	spin_lock(&wdt_lock);
 
 	/* Reload watchdog duration */
-	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
+	writel(wdt_tclk * wdt_dev->timeout, wdt_reg);
 
 	spin_unlock(&wdt_lock);
 	return 0;
@@ -64,7 +63,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	spin_lock(&wdt_lock);
 
 	/* Set watchdog duration */
-	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
+	writel(wdt_tclk * wdt_dev->timeout, wdt_reg);
 
 	/* Clear watchdog timer interrupt */
 	reg = readl(BRIDGE_CAUSE);
@@ -106,7 +105,7 @@ static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 	unsigned int time_left;
 
 	spin_lock(&wdt_lock);
-	time_left = readl(wdt_reg + WDT_VAL) / wdt_tclk;
+	time_left = readl(wdt_reg) / wdt_tclk;
 	spin_unlock(&wdt_lock);
 
 	return time_left;
-- 
1.8.1.5

