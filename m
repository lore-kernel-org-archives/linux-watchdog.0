Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:59696 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbbKVOO0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Nov 2015 09:14:26 -0500
Subject: [PATCH 10/10] watchdog: bcm63xx_wdt: Use brcm,bcm6345-wdt device tree
 binding
To: Guenter Roeck <linux@roeck-us.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonas Gorski <jogo@openwrt.org>
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5651CDB6.5030406@simon.arlott.org.uk>
Date: Sun, 22 Nov 2015 14:14:14 +0000
MIME-Version: 1.0
In-Reply-To: <5651CB13.4090704@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add of_match_table for "brcm,bcm6345-wdt".

Use a NULL clock name when not on mach-bcm63xx so that the device tree
clock name does not have to be "periph".

Allow the watchdog to be selected on BMIPS_GENERIC and select the BCM6345
timer interrupt handler.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 drivers/watchdog/Kconfig       |  3 ++-
 drivers/watchdog/bcm63xx_wdt.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6815b74..0c50add 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1272,8 +1272,9 @@ config OCTEON_WDT
 
 config BCM63XX_WDT
 	tristate "Broadcom BCM63xx hardware watchdog"
-	depends on BCM63XX
+	depends on BCM63XX || BMIPS_GENERIC
 	select WATCHDOG_CORE
+	select BCM6345_L2_TIMER_IRQ if BMIPS_GENERIC
 	help
 	  Watchdog driver for the built in watchdog hardware in Broadcom
 	  BCM63xx SoC.
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 9989efe..51b855e 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -31,7 +32,11 @@
 
 #define PFX KBUILD_MODNAME
 
-#define WDT_CLK_NAME		"periph"
+#ifdef CONFIG_BCM63XX
+# define WDT_CLK_NAME		"periph"
+#else
+# define WDT_CLK_NAME		NULL
+#endif
 
 struct bcm63xx_wdt_hw {
 	raw_spinlock_t lock;
@@ -285,12 +290,19 @@ static void bcm63xx_wdt_shutdown(struct platform_device *pdev)
 	bcm63xx_wdt_stop(wdd);
 }
 
+static const struct of_device_id bcm63xx_wdt_dt_ids[] = {
+	{ .compatible = "brcm,bcm6345-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bcm63xx_wdt_dt_ids);
+
 static struct platform_driver bcm63xx_wdt_driver = {
 	.probe	= bcm63xx_wdt_probe,
 	.remove = bcm63xx_wdt_remove,
 	.shutdown = bcm63xx_wdt_shutdown,
 	.driver = {
 		.name = "bcm63xx-wdt",
+		.of_match_table = bcm63xx_wdt_dt_ids,
 	}
 };
 
-- 
2.1.4

-- 
Simon Arlott
