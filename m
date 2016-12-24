Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([85.17.2.162]:39042 "EHLO spo001.leaseweb.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751995AbcLXOjo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 24 Dec 2016 09:39:44 -0500
Date: Sat, 24 Dec 2016 15:39:41 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL REQUEST] watchdog - v4.10 merge window
Message-ID: <20161224143941.GB672@spo001.leaseweb.nl>
References: <20161223100754.GA19660@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161223100754.GA19660@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Due to time constraints and personal issues Guenter and I decided that this window will be a pull from another location.
We got it wrong the first time, so here is our second request (together with our humble apologies).
(I also hope that Guenters tree is signed, it normally is, but if it isn't then you have another thing to blame us...).

So could you please pull from the 'watchdog-for-linus-v4.10' branch of
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

It contains the following patches:
* Add Loongson1 SoC watchdog driver
* Add da9061 watchdog device
* Add IT8620E watchdog device
* module load /unload fixes for bcm7083_wdt, max77620_wdt and jz4740
* intel-mid_wdt fixes
* and other fixes and cleanups 

This will update the following files:

 MAINTAINERS                        |    2 
 drivers/watchdog/Kconfig           |   49 ++++++----
 drivers/watchdog/Makefile          |    1 
 drivers/watchdog/bcm2835_wdt.c     |   20 ++++
 drivers/watchdog/bcm7038_wdt.c     |    1 
 drivers/watchdog/cpwd.c            |   23 +----
 drivers/watchdog/da9062_wdt.c      |   12 ++
 drivers/watchdog/davinci_wdt.c     |    6 +
 drivers/watchdog/intel-mid_wdt.c   |   22 ++--
 drivers/watchdog/it87_wdt.c        |    4 
 drivers/watchdog/jz4740_wdt.c      |    2 
 drivers/watchdog/loongson1_wdt.c   |  170 +++++++++++++++++++++++++++++++++++++
 drivers/watchdog/max77620_wdt.c    |    1 
 drivers/watchdog/mei_wdt.c         |    2 
 drivers/watchdog/meson_gxbb_wdt.c  |    1 
 drivers/watchdog/mpc8xxx_wdt.c     |    1 
 drivers/watchdog/octeon-wdt-main.c |    1 
 drivers/watchdog/qcom-wdt.c        |    2 
 18 files changed, 262 insertions(+), 58 deletions(-)

with these Changes:

commit 067161281f428aa7c6e153e06aab7b5fe1ed1e98
Author: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Date:   Thu Dec 15 23:52:36 2016 +0100

    watchdog: it87_wdt: add IT8620E ID
    
    This adds IT8620E chip ID to it87_wdt driver.
    Such chip is often found on current Gigabyte motherboards, it is allegedly
    custom made for this manufacturer.
    
    Upon testing it looks like it has a 16-bit timer and cannot be reset via
    game port (only via CIR), so it is similar to IT87{18,20,21,28,83} chips.
    
    Tested on GA-F2A88XM-HD3P board.
    
    Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit f01d74cc5a2aefa0ba16e2821086a1f2d0a2c899
Author: Corentin Labbe <clabbe.montjoie@gmail.com>
Date:   Thu Dec 15 19:03:44 2016 +0100

    watchdog: mpc8xxx: Remove unneeded linux/miscdevice.h include
    
    watchdog/mpc8xxx_wdt.c does not use any miscdevice so this patch remove
    this unnecessary inclusion.
    
    Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 724284a323c4cdea6c1bb1448247ffc858f2bd1d
Author: Corentin Labbe <clabbe.montjoie@gmail.com>
Date:   Thu Dec 15 18:49:29 2016 +0100

    watchdog: octeon: Remove unneeded linux/miscdevice.h include
    
    watchdog/octeon-wdt-main.c does not use any miscdevice so this patch
    remove this unnecessary inclusion.
    
    Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 054ae19422859c394d5f26a8756ed57d332f6284
Author: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Mon Dec 12 10:48:43 2016 +0100

    watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when appropriate
    
    A bootloader may start the watchdog device before handing control to
    the kernel - in that case, we should tell the kernel about it so the
    watchdog framework can keep it alive until userspace opens
    /dev/watchdog0.
    
    Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: Eric Anholt <eric@anholt.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 1d8565ee4f5bd9fccb738e53d6b9fc7a559f7d2b
Author: Yang Ling <gnaygnil@gmail.com>
Date:   Thu Dec 8 00:10:58 2016 +0800

    watchdog: loongson1: Add Loongson1 SoC watchdog driver
    
    Add watchdog timer specific driver for Loongson1 SoC.
    
    Signed-off-by: Yang Ling <gnaygnil@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit b6621df5c87603310c3f94903bb30adbfeb9aa69
Author: Amit Kushwaha <akkushwaha9896@gmail.com>
Date:   Tue Dec 6 10:19:48 2016 -0800

    watchdog: cpwd: remove memory allocate failure message
    
    Replaced goto with a return statement and dropped the kfree()
    calls because memory allocated with devm_kzalloc() is
    automatically freed on driver detach
    
    Signed-off-by: Amit Kushwaha <akkushwaha9896@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 72106c1894aa4e26ab403282cc7617fcb07d3d4d
Author: Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Mon Nov 14 08:22:45 2016 +0000

    watchdog: da9062/61: watchdog driver
    
    The of_device_id match array is added to support "dlg,da9062-watchdog"
    as a valid .compatible string. A MODULE_DEVICE_TABLE() macro is added.
    
    This patch assumes the use of a DA9062 fallback compatible string for the
    DTS to pick up the DA9062 device driver for use with the DA9061 watchdog
    hardware
    
    Copyright header is updated to add DA9061 in its description and the module
    description macro is extended to include DA9061.
    
    Kconfig is updated to reflect support for DA9061/62.
    
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit bb79036215e2ca9d7ef5bd1461981396989c40da
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri Nov 18 17:24:41 2016 +0200

    intel-mid_wdt: Error code is just an integer
    
    Error code when printed is more readable if it's represented as plain decimal
    integer. Otherwise user will see something like
    	intel_mid_wdt: Error stopping watchdog: 0xffffffed
    which is not quite understandable ("Should I interpret it as a bitfield?").
    
    Make it clear to use plaint integer specifier.
    
    While here, move struct device *dev local variable definition to the top of
    functions.
    
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 31ecad65b011d64dfc80cab7c968078171aa2642
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri Nov 18 16:50:02 2016 +0200

    intel-mid_wdt: make sure watchdog is not running at startup
    
    Make sure that the watchdog is not running after loading
    and before it is started by opening /dev/watchdog.
    
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 9eff1140a82db8c5520f76e51c21827b4af670b3
Author: Alexander Usyskin <alexander.usyskin@intel.com>
Date:   Tue Nov 8 17:55:52 2016 +0200

    watchdog: mei_wdt: request stop on reboot to prevent false positive event
    
    Systemd on reboot enables shutdown watchdog that leaves the watchdog
    device open to ensure that even if power down process get stuck the
    platform reboots nonetheless.
    The iamt_wdt is an alarm-only watchdog and can't reboot system, but the
    FW will generate an alarm event reboot was completed in time, as the
    watchdog is not automatically disabled during power cycle.
    So we should request stop watchdog on reboot to eliminate wrong alarm
    from the FW.
    
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
    Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 4cfccbdaa234b6564326ed3bf18c38f73693fe14
Author: Jimmy Vance <jimmy.vance@hpe.com>
Date:   Thu Nov 10 15:25:27 2016 -0500

    watchdog: hpwdt: changed maintainer information
    
    Signed-off-by: Jimmy Vance <jimmy.vance@hpe.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 35ffa961df7ed13b3701bdb546f08849921e50dc
Author: Stephen Boyd <sboyd@codeaurora.org>
Date:   Thu Nov 10 16:02:20 2016 -0800

    watchdog: jz4740: Fix modular build
    
    Compiling this driver as a module causes a build error because a
    semicolon is missing after MODULE_DEVICE_TABLE. Add it.
    
      CC [M]  drivers/watchdog/jz4740_wdt.o
    drivers/watchdog/jz4740_wdt.c:154:1: error: expected ‘,’ or ‘;’ before ‘static’
    drivers/watchdog/jz4740_wdt.c:218:11: error: ‘jz4740_wdt_probe’ undeclared here (not in a function)
    
    Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
    Cc: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit f06f35c66fdbd5ac38901a3305ce763a0cd59375
Author: Christian Lamparter <chunkeey@googlemail.com>
Date:   Mon Nov 14 02:11:16 2016 +0100

    watchdog: qcom: fix kernel panic due to external abort on non-linefetch
    
    This patch fixes a off-by-one in the "watchdog: qcom: add option for
    standalone watchdog not in timer block" patch that causes the
    following panic on boot:
    
    > Unhandled fault: external abort on non-linefetch (0x1008) at 0xc8874002
    > pgd = c0204000
    > [c8874002] *pgd=87806811, *pte=0b017653, *ppte=0b017453
    > Internal error: : 1008 [#1] SMP ARM
    > CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.8.6 #0
    > Hardware name: Generic DT based system
    > PC is at 0xc02222f4
    > LR is at 0x1
    > pc : [<c02222f4>]    lr : [<00000001>]    psr: 00000113
    > sp : c782fc98  ip : 00000003  fp : 00000000
    > r10: 00000004  r9 : c782e000  r8 : c04ab98c
    > r7 : 00000001  r6 : c8874002  r5 : c782fe00  r4 : 00000002
    > r3 : 00000000  r2 : c782fe00  r1 : 00100000  r0 : c8874002
    > Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
    > Control: 10c5387d  Table: 8020406a  DAC: 00000051
    > Process swapper/0 (pid: 1, stack limit = 0xc782e210)
    > Stack: (0xc782fc98 to 0xc7830000)
    > [...]
    
    The WDT_STS (status) needs to be translated via wdt_addr as well.
    
    fixes: f0d9d0f4b44a ("watchdog: qcom: add option for standalone watchdog not in timer block")
    Cc: stable@vger.kernel.org # 4.8
    Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 9b3865749589d67f612d71b447847223b2321408
Author: Tero Kristo <t-kristo@ti.com>
Date:   Thu Nov 24 14:58:28 2016 +0200

    watchdog: davinci: add support for deferred probing
    
    devm_clk_get can fail with EPROBE_DEFER in case the clock provider is
    not ready yet. Handle this case gracefully, rather than dumping out
    a huge warning.
    
    Signed-off-by: Tero Kristo <t-kristo@ti.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 807f0b2d22b0934fc1c67df8a4961044bd76b081
Author: Javier Martinez Canillas <javier@osg.samsung.com>
Date:   Wed Oct 19 16:49:42 2016 -0300

    watchdog: meson: Remove unneeded platform MODULE_ALIAS
    
    The Amlogic Meson is a DT-only platform, which means the devices are
    registered via OF and not using the legacy platform devices support.
    
    So there's no need to have a MODULE_ALIAS("platform:meson-gxbb-wdt")
    since the reported uevent MODALIAS to user-space will be the OF one.
    
    Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
    Acked-by: Kevin Hilman <khilman@baylibre.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 0f3871f8a535d7e79512fe56f4a5a161b3a03422
Author: Robert P. J. Day <rpjday@crashcourse.ca>
Date:   Sun Oct 16 08:10:37 2016 -0400

    watchdog: Standardize leading tabs and spaces in Kconfig file
    
    Replace small number of lines using leading spaces with proper leading
    tabs and spaces -- purely an aesthetic fix.
    
    Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit f99524dced4c89af52a82a369cb61a111b9169b3
Author: Javier Martinez Canillas <javier@osg.samsung.com>
Date:   Fri Oct 14 12:23:51 2016 -0300

    watchdog: max77620_wdt: fix module autoload
    
    If the driver is built as a module, autoload won't work because the module
    alias information is not filled. So user-space can't match the registered
    device with the corresponding module.
    
    Export the module alias information using the MODULE_DEVICE_TABLE() macro.
    
    Before this patch:
    
    $ $ modinfo drivers/watchdog/max77620_wdt.ko | grep alias
    $
    
    After this patch:
    
    modinfo drivers/watchdog/max77620_wdt.ko | grep alias
    alias:          platform:max77620-watchdog
    
    Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 57d77c62536ea0f388c840c8ac7e94be54425308
Author: Javier Martinez Canillas <javier@osg.samsung.com>
Date:   Fri Oct 14 12:23:50 2016 -0300

    watchdog: bcm7038_wdt: fix module autoload
    
    If the driver is built as a module, autoload won't work because the module
    alias information is not filled. So user-space can't match the registered
    device with the corresponding module.
    
    Export the module alias information using the MODULE_DEVICE_TABLE() macro.
    
    Before this patch:
    
    $ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
    $
    
    After this patch:
    
    $ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
    alias:          of:N*T*Cbrcm,bcm7038-wdtC*
    alias:          of:N*T*Cbrcm,bcm7038-wdt
    
    Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>


For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 63cefa6..f5e05d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5613,7 +5613,7 @@ S:	Maintained
 F:	drivers/media/dvb-frontends/hd29l2*
 
 HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
-M:	Brian Boylston <brian.boylston@hpe.com>
+M:	Jimmy Vance <jimmy.vance@hpe.com>
 S:	Supported
 F:	Documentation/watchdog/hpwdt.txt
 F:	drivers/watchdog/hpwdt.c
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3eb58cb..acb00b5 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -72,16 +72,16 @@ config SOFT_WATCHDOG
 	  module will be called softdog.
 
 config DA9052_WATCHDOG
-        tristate "Dialog DA9052 Watchdog"
-        depends on PMIC_DA9052
-        select WATCHDOG_CORE
-        help
-          Support for the watchdog in the DA9052 PMIC. Watchdog trigger
-          cause system reset.
+	tristate "Dialog DA9052 Watchdog"
+	depends on PMIC_DA9052
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the DA9052 PMIC. Watchdog trigger
+	  cause system reset.
 
-          Say Y here to include support for the DA9052 watchdog.
-          Alternatively say M to compile the driver as a module,
-          which will be called da9052_wdt.
+	  Say Y here to include support for the DA9052 watchdog.
+	  Alternatively say M to compile the driver as a module,
+	  which will be called da9052_wdt.
 
 config DA9055_WATCHDOG
 	tristate "Dialog Semiconductor DA9055 Watchdog"
@@ -104,11 +104,11 @@ config DA9063_WATCHDOG
 	  This driver can be built as a module. The module name is da9063_wdt.
 
 config DA9062_WATCHDOG
-	tristate "Dialog DA9062 Watchdog"
+	tristate "Dialog DA9062/61 Watchdog"
 	depends on MFD_DA9062
 	select WATCHDOG_CORE
 	help
-	  Support for the watchdog in the DA9062 PMIC.
+	  Support for the watchdog in the DA9062 and DA9061 PMICs.
 
 	  This driver can be built as a module. The module name is da9062_wdt.
 
@@ -1008,8 +1008,8 @@ config IT87_WDT
 	tristate "IT87 Watchdog Timer"
 	depends on X86
 	---help---
-	  This is the driver for the hardware watchdog on the ITE IT8702,
-	  IT8712, IT8716, IT8718, IT8720, IT8721, IT8726 and IT8728
+	  This is the driver for the hardware watchdog on the ITE IT8620,
+	  IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726 and IT8728
 	  Super I/O chips.
 
 	  If the driver does not work, then make sure that the game port in
@@ -1514,6 +1514,13 @@ config LANTIQ_WDT
 	help
 	  Hardware driver for the Lantiq SoC Watchdog Timer.
 
+config LOONGSON1_WDT
+	tristate "Loongson1 SoC hardware watchdog"
+	depends on MACH_LOONGSON32
+	select WATCHDOG_CORE
+	help
+	  Hardware driver for the Loongson1 SoC Watchdog Timer.
+
 config RALINK_WDT
 	tristate "Ralink SoC watchdog"
 	select WATCHDOG_CORE
@@ -1624,16 +1631,16 @@ config BOOKE_WDT_DEFAULT_TIMEOUT
 	  The value can be overridden by the wdt_period command-line parameter.
 
 config MEN_A21_WDT
-       tristate "MEN A21 VME CPU Carrier Board Watchdog Timer"
-       select WATCHDOG_CORE
-       depends on GPIOLIB || COMPILE_TEST
-       help
-        Watchdog driver for MEN A21 VMEbus CPU Carrier Boards.
+	tristate "MEN A21 VME CPU Carrier Board Watchdog Timer"
+	select WATCHDOG_CORE
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Watchdog driver for MEN A21 VMEbus CPU Carrier Boards.
 
-	The driver can also be built as a module. If so, the module will be
-	called mena21_wdt.
+	  The driver can also be built as a module. If so, the module will be
+	  called mena21_wdt.
 
-	If unsure select N here.
+	  If unsure select N here.
 
 # PPC64 Architecture
 
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index caa9f4a..0c3d35e 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -163,6 +163,7 @@ obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
 obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
 obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
+obj-$(CONFIG_LOONGSON1_WDT) += loongson1_wdt.o
 obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
 obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
 obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 4dddd82..c32c45b 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -55,6 +55,15 @@ struct bcm2835_wdt {
 static unsigned int heartbeat;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
+static bool bcm2835_wdt_is_running(struct bcm2835_wdt *wdt)
+{
+	uint32_t cur;
+
+	cur = readl(wdt->base + PM_RSTC);
+
+	return !!(cur & PM_RSTC_WRCFG_FULL_RESET);
+}
+
 static int bcm2835_wdt_start(struct watchdog_device *wdog)
 {
 	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
@@ -181,6 +190,17 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
 	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
 	bcm2835_wdt_wdd.parent = &pdev->dev;
+	if (bcm2835_wdt_is_running(wdt)) {
+		/*
+		 * The currently active timeout value (set by the
+		 * bootloader) may be different from the module
+		 * heartbeat parameter or the value in device
+		 * tree. But we just need to set WDOG_HW_RUNNING,
+		 * because then the framework will "immediately" ping
+		 * the device, updating the timeout.
+		 */
+		set_bit(WDOG_HW_RUNNING, &bcm2835_wdt_wdd.status);
+	}
 	err = watchdog_register_device(&bcm2835_wdt_wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device");
diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index e238df4..4814c00 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -216,6 +216,7 @@ static const struct of_device_id bcm7038_wdt_match[] = {
 	{ .compatible = "brcm,bcm7038-wdt" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, bcm7038_wdt_match);
 
 static struct platform_driver bcm7038_wdt_driver = {
 	.probe		= bcm7038_wdt_probe,
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 71ee079..3d43775 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -538,12 +538,9 @@ static int cpwd_probe(struct platform_device *op)
 	if (cpwd_device)
 		return -EINVAL;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	err = -ENOMEM;
-	if (!p) {
-		pr_err("Unable to allocate struct cpwd\n");
-		goto out;
-	}
+	p = devm_kzalloc(&op->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
 
 	p->irq = op->archdata.irqs[0];
 
@@ -553,12 +550,12 @@ static int cpwd_probe(struct platform_device *op)
 			     4 * WD_TIMER_REGSZ, DRIVER_NAME);
 	if (!p->regs) {
 		pr_err("Unable to map registers\n");
-		goto out_free;
+		return -ENOMEM;
 	}
 
 	options = of_find_node_by_path("/options");
-	err = -ENODEV;
 	if (!options) {
+		err = -ENODEV;
 		pr_err("Unable to find /options node\n");
 		goto out_iounmap;
 	}
@@ -620,10 +617,7 @@ static int cpwd_probe(struct platform_device *op)
 
 	platform_set_drvdata(op, p);
 	cpwd_device = p;
-	err = 0;
-
-out:
-	return err;
+	return 0;
 
 out_unregister:
 	for (i--; i >= 0; i--)
@@ -632,9 +626,7 @@ out_unregister:
 out_iounmap:
 	of_iounmap(&op->resource[0], p->regs, 4 * WD_TIMER_REGSZ);
 
-out_free:
-	kfree(p);
-	goto out;
+	return err;
 }
 
 static int cpwd_remove(struct platform_device *op)
@@ -659,7 +651,6 @@ static int cpwd_remove(struct platform_device *op)
 		free_irq(p->irq, p);
 
 	of_iounmap(&op->resource[0], p->regs, 4 * WD_TIMER_REGSZ);
-	kfree(p);
 
 	cpwd_device = NULL;
 
diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 7386111..a02cee6 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -1,5 +1,5 @@
 /*
- * da9062_wdt.c - WDT device driver for DA9062
+ * Watchdog device driver for DA9062 and DA9061 PMICs
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  *
  * This program is free software; you can redistribute it and/or
@@ -188,6 +188,13 @@ static const struct watchdog_ops da9062_watchdog_ops = {
 	.set_timeout = da9062_wdt_set_timeout,
 };
 
+static const struct of_device_id da9062_compatible_id_table[] = {
+	{ .compatible = "dlg,da9062-watchdog", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, da9062_compatible_id_table);
+
 static int da9062_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -244,11 +251,12 @@ static struct platform_driver da9062_wdt_driver = {
 	.remove = da9062_wdt_remove,
 	.driver = {
 		.name = "da9062-watchdog",
+		.of_match_table = da9062_compatible_id_table,
 	},
 };
 module_platform_driver(da9062_wdt_driver);
 
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
-MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
+MODULE_DESCRIPTION("WDT device driver for Dialog DA9062 and DA9061");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:da9062-watchdog");
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 17454ca..0e731d7 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -166,8 +166,12 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	davinci_wdt->clk = devm_clk_get(dev, NULL);
-	if (WARN_ON(IS_ERR(davinci_wdt->clk)))
+
+	if (IS_ERR(davinci_wdt->clk)) {
+		if (PTR_ERR(davinci_wdt->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get clock node\n");
 		return PTR_ERR(davinci_wdt->clk);
+	}
 
 	clk_prepare_enable(davinci_wdt->clk);
 
diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index db36d12..a4b7292 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -43,6 +43,7 @@ static inline int wdt_command(int sub, u32 *in, int inlen)
 
 static int wdt_start(struct watchdog_device *wd)
 {
+	struct device *dev = watchdog_get_drvdata(wd);
 	int ret, in_size;
 	int timeout = wd->timeout;
 	struct ipc_wd_start {
@@ -57,36 +58,32 @@ static int wdt_start(struct watchdog_device *wd)
 	in_size = DIV_ROUND_UP(sizeof(ipc_wd_start), 4);
 
 	ret = wdt_command(SCU_WATCHDOG_START, (u32 *)&ipc_wd_start, in_size);
-	if (ret) {
-		struct device *dev = watchdog_get_drvdata(wd);
+	if (ret)
 		dev_crit(dev, "error starting watchdog: %d\n", ret);
-	}
 
 	return ret;
 }
 
 static int wdt_ping(struct watchdog_device *wd)
 {
+	struct device *dev = watchdog_get_drvdata(wd);
 	int ret;
 
 	ret = wdt_command(SCU_WATCHDOG_KEEPALIVE, NULL, 0);
-	if (ret) {
-		struct device *dev = watchdog_get_drvdata(wd);
-		dev_crit(dev, "Error executing keepalive: 0x%x\n", ret);
-	}
+	if (ret)
+		dev_crit(dev, "Error executing keepalive: %d\n", ret);
 
 	return ret;
 }
 
 static int wdt_stop(struct watchdog_device *wd)
 {
+	struct device *dev = watchdog_get_drvdata(wd);
 	int ret;
 
 	ret = wdt_command(SCU_WATCHDOG_STOP, NULL, 0);
-	if (ret) {
-		struct device *dev = watchdog_get_drvdata(wd);
-		dev_crit(dev, "Error stopping watchdog: 0x%x\n", ret);
-	}
+	if (ret)
+		dev_crit(dev, "Error stopping watchdog: %d\n", ret);
 
 	return ret;
 }
@@ -151,6 +148,9 @@ static int mid_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Make sure the watchdog is not running */
+	wdt_stop(wdt_dev);
+
 	ret = watchdog_register_device(wdt_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "error registering watchdog device\n");
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index e54839b..b9878c4 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -12,7 +12,7 @@
  *		    http://www.ite.com.tw/
  *
  *	Support of the watchdog timers, which are available on
- *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
+ *	IT8620, IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
  *	IT8728 and IT8783.
  *
  *	This program is free software; you can redistribute it and/or
@@ -78,6 +78,7 @@
 
 /* Chip Id numbers */
 #define NO_DEV_ID	0xffff
+#define IT8620_ID	0x8620
 #define IT8702_ID	0x8702
 #define IT8705_ID	0x8705
 #define IT8712_ID	0x8712
@@ -630,6 +631,7 @@ static int __init it87_wdt_init(void)
 	case IT8726_ID:
 		max_units = 65535;
 		break;
+	case IT8620_ID:
 	case IT8718_ID:
 	case IT8720_ID:
 	case IT8721_ID:
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index c8d51dd..20627f2 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -148,7 +148,7 @@ static const struct of_device_id jz4740_wdt_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-watchdog", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches)
+MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
 #endif
 
 static int jz4740_wdt_probe(struct platform_device *pdev)
diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
new file mode 100644
index 0000000..3aee50c
--- /dev/null
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -0,0 +1,170 @@
+/*
+ * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+#include <loongson1.h>
+
+#define DEFAULT_HEARTBEAT	30
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0444);
+
+static unsigned int heartbeat;
+module_param(heartbeat, uint, 0444);
+
+struct ls1x_wdt_drvdata {
+	void __iomem *base;
+	struct clk *clk;
+	unsigned long clk_rate;
+	struct watchdog_device wdt;
+};
+
+static int ls1x_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
+
+	writel(0x1, drvdata->base + WDT_SET);
+
+	return 0;
+}
+
+static int ls1x_wdt_set_timeout(struct watchdog_device *wdt_dev,
+				unsigned int timeout)
+{
+	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
+	unsigned int max_hw_heartbeat = wdt_dev->max_hw_heartbeat_ms / 1000;
+	unsigned int counts;
+
+	wdt_dev->timeout = timeout;
+
+	counts = drvdata->clk_rate * min(timeout, max_hw_heartbeat);
+	writel(counts, drvdata->base + WDT_TIMER);
+
+	return 0;
+}
+
+static int ls1x_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
+
+	writel(0x1, drvdata->base + WDT_EN);
+
+	return 0;
+}
+
+static int ls1x_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
+
+	writel(0x0, drvdata->base + WDT_EN);
+
+	return 0;
+}
+
+static const struct watchdog_info ls1x_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "Loongson1 Watchdog",
+};
+
+static const struct watchdog_ops ls1x_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = ls1x_wdt_start,
+	.stop = ls1x_wdt_stop,
+	.ping = ls1x_wdt_ping,
+	.set_timeout = ls1x_wdt_set_timeout,
+};
+
+static int ls1x_wdt_probe(struct platform_device *pdev)
+{
+	struct ls1x_wdt_drvdata *drvdata;
+	struct watchdog_device *ls1x_wdt;
+	unsigned long clk_rate;
+	struct resource *res;
+	int err;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
+
+	drvdata->clk = devm_clk_get(&pdev->dev, pdev->name);
+	if (IS_ERR(drvdata->clk))
+		return PTR_ERR(drvdata->clk);
+
+	err = clk_prepare_enable(drvdata->clk);
+	if (err) {
+		dev_err(&pdev->dev, "clk enable failed\n");
+		return err;
+	}
+
+	clk_rate = clk_get_rate(drvdata->clk);
+	if (!clk_rate) {
+		err = -EINVAL;
+		goto err0;
+	}
+	drvdata->clk_rate = clk_rate;
+
+	ls1x_wdt = &drvdata->wdt;
+	ls1x_wdt->info = &ls1x_wdt_info;
+	ls1x_wdt->ops = &ls1x_wdt_ops;
+	ls1x_wdt->timeout = DEFAULT_HEARTBEAT;
+	ls1x_wdt->min_timeout = 1;
+	ls1x_wdt->max_hw_heartbeat_ms = U32_MAX / clk_rate * 1000;
+	ls1x_wdt->parent = &pdev->dev;
+
+	watchdog_init_timeout(ls1x_wdt, heartbeat, &pdev->dev);
+	watchdog_set_nowayout(ls1x_wdt, nowayout);
+	watchdog_set_drvdata(ls1x_wdt, drvdata);
+
+	err = watchdog_register_device(&drvdata->wdt);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register watchdog device\n");
+		goto err0;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+
+	dev_info(&pdev->dev, "Loongson1 Watchdog driver registered\n");
+
+	return 0;
+err0:
+	clk_disable_unprepare(drvdata->clk);
+	return err;
+}
+
+static int ls1x_wdt_remove(struct platform_device *pdev)
+{
+	struct ls1x_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&drvdata->wdt);
+	clk_disable_unprepare(drvdata->clk);
+
+	return 0;
+}
+
+static struct platform_driver ls1x_wdt_driver = {
+	.probe = ls1x_wdt_probe,
+	.remove = ls1x_wdt_remove,
+	.driver = {
+		.name = "ls1x-wdt",
+	},
+};
+
+module_platform_driver(ls1x_wdt_driver);
+
+MODULE_AUTHOR("Yang Ling <gnaygnil@gmail.com>");
+MODULE_DESCRIPTION("Loongson1 Watchdog Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index 48b84df..68c41fa 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -205,6 +205,7 @@ static struct platform_device_id max77620_wdt_devtype[] = {
 	{ .name = "max77620-watchdog", },
 	{ },
 };
+MODULE_DEVICE_TABLE(platform, max77620_wdt_devtype);
 
 static struct platform_driver max77620_wdt_driver = {
 	.driver	= {
diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index 630bd18..2a9d5cd 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -389,6 +389,8 @@ static int mei_wdt_register(struct mei_wdt *wdt)
 	wdt->wdd.max_timeout = MEI_WDT_MAX_TIMEOUT;
 
 	watchdog_set_drvdata(&wdt->wdd, wdt);
+	watchdog_stop_on_reboot(&wdt->wdd);
+
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret) {
 		dev_err(dev, "unable to register watchdog device = %d.\n", ret);
diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 44d180a..45d4766 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -264,7 +264,6 @@ static struct platform_driver meson_gxbb_wdt_driver = {
 
 module_platform_driver(meson_gxbb_wdt_driver);
 
-MODULE_ALIAS("platform:meson-gxbb-wdt");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
 MODULE_DESCRIPTION("Amlogic Meson GXBB Watchdog timer driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 5f2273a..366e5c7 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/timer.h>
-#include <linux/miscdevice.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index b55981f..8b4fa4d 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -56,7 +56,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/miscdevice.h>
 #include <linux/interrupt.h>
 #include <linux/watchdog.h>
 #include <linux/cpumask.h>
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 5796b5d..4f47b5e 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -209,7 +209,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.parent = &pdev->dev;
 	wdt->layout = regs;
 
-	if (readl(wdt->base + WDT_STS) & 1)
+	if (readl(wdt_addr(wdt, WDT_STS)) & 1)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
 	/*
