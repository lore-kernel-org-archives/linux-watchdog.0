Return-path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net,
	Richard Weinberger <richard@nod.at>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 15/22] watchdog: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:14 +0100
Message-Id: <1453760661-1444-16-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
List-ID: <linux-watchdog@vger.kernel.org>

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/watchdog/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4f0e7be..0bd559a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -146,6 +146,7 @@ config TANGOX_WATCHDOG
 	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
 	select WATCHDOG_CORE
 	depends on ARCH_TANGOX || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
 	  and SMP87xx (tango4) family chips.
@@ -618,6 +619,7 @@ config DIGICOLOR_WATCHDOG
 config LPC18XX_WATCHDOG
 	tristate "LPC18xx/43xx Watchdog"
 	depends on ARCH_LPC18XX || COMPILE_TEST
+	depends on HAS_IOMEM
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
@@ -1374,6 +1376,7 @@ config BCM_KONA_WDT_DEBUG
 config BCM7038_WDT
 	tristate "BCM7038 Watchdog"
 	select WATCHDOG_CORE
+	depends on HAS_IOMEM
 	help
 	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
 
-- 
1.8.4.5
