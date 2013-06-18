Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43421 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933103Ab3FRQWG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 12:22:06 -0400
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/2] Watchdog: allow orion_wdt to be built for Dove
Message-Id: <E1Uoyd2-0001Cp-KL@rmk-PC.arm.linux.org.uk>
Date: Tue, 18 Jun 2013 17:19:32 +0100
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog infrastructure in Dove is no different from that in
Orion5x or Kirkwood, so let's enable it for Dove.  The only things
missing are a few register settings in Dove's bridge-regs.h.

Rather than duplicating the same register bit masks for the RSTOUTn_MASK
and BRIDGE_CAUSE registers, move the definitions into the watchdog
driver itself.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-dove/include/mach/bridge-regs.h     |    1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 --
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  |    3 ---
 drivers/watchdog/Kconfig                          |    2 +-
 drivers/watchdog/orion_wdt.c                      |    3 +++
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
index 99f259e..5362df3 100644
--- a/arch/arm/mach-dove/include/mach/bridge-regs.h
+++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
@@ -26,6 +26,7 @@
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define  SOFT_RESET		0x00000001
 
+#define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE + 0x0110)
 #define  BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
 #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0200)
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 5c82b7d..95a4c87 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -20,14 +20,12 @@
 #define CPU_RESET		0x00000002
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
-#define WDT_RESET_OUT_EN	0x00000002
 #define SOFT_RESET_OUT_EN	0x00000004
 
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define SOFT_RESET		0x00000001
 
 #define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE + 0x0110)
-#define WDT_INT_REQ		0x0008
 
 #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index 461fd69..f727d03 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -18,7 +18,6 @@
 #define CPU_CTRL		(ORION5X_BRIDGE_VIRT_BASE + 0x104)
 
 #define RSTOUTn_MASK		(ORION5X_BRIDGE_VIRT_BASE + 0x108)
-#define WDT_RESET_OUT_EN	0x0002
 
 #define CPU_SOFT_RESET		(ORION5X_BRIDGE_VIRT_BASE + 0x10c)
 
@@ -26,8 +25,6 @@
 
 #define POWER_MNG_CTRL_REG	(ORION5X_BRIDGE_VIRT_BASE + 0x11C)
 
-#define WDT_INT_REQ		0x0008
-
 #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
 #define MAIN_IRQ_CAUSE		(ORION5X_BRIDGE_VIRT_BASE + 0x200)
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e89fc31..c077ae9 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -291,7 +291,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_KIRKWOOD
+	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index da57798..4074244 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -38,6 +38,9 @@
 #define WDT_IN_USE		0
 #define WDT_OK_TO_CLOSE		1
 
+#define WDT_RESET_OUT_EN	BIT(1)
+#define WDT_INT_REQ		BIT(3)
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 static unsigned int wdt_max_duration;	/* (seconds) */
-- 
1.7.4.4

