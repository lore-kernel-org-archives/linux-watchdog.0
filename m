Return-Path: <anholt@anholt.net>
Return-path: <anholt@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/8] watchdog: bcm2835: Move the driver to the soc/ directory.
Date: Tue, 20 Nov 2018 09:19:53 -0800
Message-Id: <20181120172000.15102-2-eric@anholt.net>
In-Reply-To: <20181120172000.15102-1-eric@anholt.net>
References: <20181120172000.15102-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

The binding for the bcm2835 "wdt" actually covers a large range of the
PM block's register space.  The WDT is not a separate HW block from
the rest of power domain management, so move the driver to the soc/
directory in preparation for expanding its role to cover power
domains.

This move does result in the driver being made mandatory for the
BCM2835 platform, which is probably actually reasonable given that
it's necessary for reboot/halt support.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/soc/bcm/Makefile                              |  1 +
 .../{watchdog/bcm2835_wdt.c => soc/bcm/bcm2835-pm.c}  |  0
 drivers/watchdog/Kconfig                              | 11 -----------
 drivers/watchdog/Makefile                             |  1 -
 4 files changed, 1 insertion(+), 12 deletions(-)
 rename drivers/{watchdog/bcm2835_wdt.c => soc/bcm/bcm2835-pm.c} (100%)

diff --git a/drivers/soc/bcm/Makefile b/drivers/soc/bcm/Makefile
index dc4fced72d21..16504eb694b1 100644
--- a/drivers/soc/bcm/Makefile
+++ b/drivers/soc/bcm/Makefile
@@ -1,2 +1,3 @@
+obj-$(CONFIG_ARCH_BCM2835)      += bcm2835-pm.o
 obj-$(CONFIG_RASPBERRYPI_POWER)	+= raspberrypi-power.o
 obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/soc/bcm/bcm2835-pm.c
similarity index 100%
rename from drivers/watchdog/bcm2835_wdt.c
rename to drivers/soc/bcm/bcm2835-pm.c
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2d64333f4782..796e2a593056 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1573,17 +1573,6 @@ config BCM63XX_WDT
 	  To compile this driver as a loadable module, choose M here.
 	  The module will be called bcm63xx_wdt.
 
-config BCM2835_WDT
-	tristate "Broadcom BCM2835 hardware watchdog"
-	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
-	select WATCHDOG_CORE
-	help
-	  Watchdog driver for the built in watchdog hardware in Broadcom
-	  BCM2835 SoC.
-
-	  To compile this driver as a loadable module, choose M here.
-	  The module will be called bcm2835_wdt.
-
 config BCM_KONA_WDT
 	tristate "BCM Kona Watchdog"
 	depends on ARCH_BCM_MOBILE || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f69cdff5ad7f..1788537e85af 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -70,7 +70,6 @@ obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
 obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
 obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
-obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
 obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
 obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
 obj-$(CONFIG_ST_LPC_WATCHDOG) += st_lpc_wdt.o
-- 
2.19.1
