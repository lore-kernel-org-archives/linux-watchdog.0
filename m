Return-path: <wimvs@spo001.leaseweb.nl>
Date: Wed, 30 Sep 2015 11:43:10 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
	Luis de Bethencourt <luis@debethencourt.com>
Subject: [GIT PULL REQUEST] watchdog - v4.3-rc3 Fixes
Message-ID: <20150930094310.GA2890@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It will fix:
* module autoload for 3 OF platform drivers
* poweroff behaviour on bcm2835 watchdog device
* I2C dependencies for iTCO_wdt.c

This will update the following files:

 Kconfig       |    3 ++-
 bcm2835_wdt.c |   10 ++++++++--
 gef_wdt.c     |    1 +
 mena21_wdt.c  |    1 +
 moxart_wdt.c  |    1 +
 5 files changed, 13 insertions(+), 3 deletions(-)

with these Changes:

commit 3cef072d3bbd4344823545e50d8cb240a6d4635d
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri Sep 11 06:28:08 2015 -0700

    watchdog: iTCO: Fix dependencies on I2C
    
    If I2C is built as module, the iTCO watchdog driver must be built as module
    as well. I2C_I801 must only be selected if I2C is configured.
    
    This fixes the following build errors, seen if I2C=m and ITCO_WDT=y.
    
    i2c-i801.c:(.text+0x2bf055): undefined reference to `i2c_del_adapter'
    i2c-i801.c:(.text+0x2c13e0): undefined reference to `i2c_add_adapter'
    i2c-i801.c:(.text+0x2c17bd): undefined reference to `i2c_new_device'
    
    Fixes: 2a7a0e9bf7b3 ("watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint")
    Reviewed-by: Matt Fleming <matt.fleming@intel.com>
    Cc: Lee Jones <lee.jones@linaro.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 898e6861ff7cfc9f539b57859a27fbd1fe4298ae
Author: Noralf Trønnes <noralf@tronnes.org>
Date:   Wed Jun 17 16:04:04 2015 +0200

    watchdog: bcm2835: Fix poweroff behaviour
    
    Currently poweroff/halt results in a reboot on the Raspberry Pi.
    The firmware uses the RSTS register to know which partiton to
    boot from. The partiton value is spread into bits
    0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
    the firmware to indicate halt.
    
    The firmware made this change in 19 Aug 2013 and was matched
    by the downstream commit:
    Changes for new NOOBS multi partition booting from gsh
    
    Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
    Tested-by: Stephen Warren <swarren@wwwdotorg.org>
    Acked-by: Stephen Warren <swarren@wwwdotorg.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c73318f43d3967e3ce810665d9c74a7d238d24d1
Author: Luis de Bethencourt <luis@debethencourt.com>
Date:   Thu Sep 3 13:06:09 2015 +0200

    watchdog: Fix module autoload for OF platform driver
    
    These platform drivers have a OF device ID table but the OF module
    alias information is not created so module autoloading won't work.
    
    Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c68edc1..79e1aa1 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -817,8 +817,9 @@ config ITCO_WDT
 	tristate "Intel TCO Timer/Watchdog"
 	depends on (X86 || IA64) && PCI
 	select WATCHDOG_CORE
+	depends on I2C || I2C=n
 	select LPC_ICH if !EXPERT
-	select I2C_I801 if !EXPERT
+	select I2C_I801 if !EXPERT && I2C
 	---help---
 	  Hardware driver for the intel TCO timer based watchdog devices.
 	  These drivers are included in the Intel 82801 I/O Controller
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 66c3e65..8a5ce5b 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -36,6 +36,13 @@
 #define PM_RSTC_WRCFG_FULL_RESET	0x00000020
 #define PM_RSTC_RESET			0x00000102
 
+/*
+ * The Raspberry Pi firmware uses the RSTS register to know which partiton
+ * to boot from. The partiton value is spread into bits 0, 2, 4, 6, 8, 10.
+ * Partiton 63 is a special partition used by the firmware to indicate halt.
+ */
+#define PM_RSTS_RASPBERRYPI_HALT	0x555
+
 #define SECS_TO_WDOG_TICKS(x) ((x) << 16)
 #define WDOG_TICKS_TO_SECS(x) ((x) >> 16)
 
@@ -151,8 +158,7 @@ static void bcm2835_power_off(void)
 	 * hard reset.
 	 */
 	val = readl_relaxed(wdt->base + PM_RSTS);
-	val &= PM_RSTC_WRCFG_CLR;
-	val |= PM_PASSWORD | PM_RSTS_HADWRH_SET;
+	val |= PM_PASSWORD | PM_RSTS_RASPBERRYPI_HALT;
 	writel_relaxed(val, wdt->base + PM_RSTS);
 
 	/* Continue with normal reset mechanism */
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index cc1bdfc..006e234 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -303,6 +303,7 @@ static const struct of_device_id gef_wdt_ids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, gef_wdt_ids);
 
 static struct platform_driver gef_wdt_driver = {
 	.driver = {
diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 6901300..098fa9c 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -253,6 +253,7 @@ static const struct of_device_id a21_wdt_ids[] = {
 	{ .compatible = "men,a021-wdt" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, a21_wdt_ids);
 
 static struct platform_driver a21_wdt_driver = {
 	.probe = a21_wdt_probe,
diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 2789da2..60b0605 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -168,6 +168,7 @@ static const struct of_device_id moxart_watchdog_match[] = {
 	{ .compatible = "moxa,moxart-watchdog" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, moxart_watchdog_match);
 
 static struct platform_driver moxart_wdt_driver = {
 	.probe      = moxart_wdt_probe,
