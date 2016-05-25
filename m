Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 May 2016 19:06:02 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <groeck@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, Knud Poulsen <knpo@ieee.org>,
        Lucas Stach <dev@lynxeye.de>,
        Muhammad Falak R Wani <falakreyaz@gmail.com>,
        Nigel Croxon <nigel.croxon@hpe.com>,
        Richard Cochran <rcochran@linutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [GIT PULL REQUEST] watchdog - v4.7 Merge Window
Message-ID: <20160525170602.GA31968@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

This adds following changes:
* Add support for Fintek F81865 Super-IO chip
* Add support for watchdogs (RWDT and SWDT) found on RCar Gen3 based SoCs from Renesas
* octeon: Handle the FROZEN hot plug notifier actions
* f71808e_wdt fixes and cleanups
* Some small improvements in code and documentation

This will update the following files:

 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt |    4 
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt |   25 +
 Documentation/watchdog/hpwdt.txt                           |   57 +--
 Documentation/watchdog/watchdog-parameters.txt             |    4 
 MAINTAINERS                                                |    1 
 arch/arm64/configs/defconfig                               |    2 
 drivers/watchdog/Kconfig                                   |    8 
 drivers/watchdog/Makefile                                  |    1 
 drivers/watchdog/cpwd.c                                    |    4 
 drivers/watchdog/f71808e_wdt.c                             |   30 +
 drivers/watchdog/imx2_wdt.c                                |   19 +
 drivers/watchdog/jz4740_wdt.c                              |    4 
 drivers/watchdog/octeon-wdt-main.c                         |    2 
 drivers/watchdog/qcom-wdt.c                                |    7 
 drivers/watchdog/renesas_wdt.c                             |  213 +++++++++++++
 drivers/watchdog/shwdt.c                                   |    4 
 drivers/watchdog/sp5100_tco.c                              |   15 
 drivers/watchdog/watchdog_core.c                           |    2 
 drivers/watchdog/watchdog_dev.c                            |    1 
 19 files changed, 349 insertions(+), 54 deletions(-)

with these Changes:

commit 540be8b2add1a18a4289b11c1a9b6956eb846630
Author: Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun May 22 11:06:29 2016 +0200

    MAINTAINERS: Add file patterns for watchdog device tree bindings
    
    Submitters of device tree binding documentation may forget to CC
    the subsystem maintainer if this is missing.
    
    Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Cc: linux-watchdog@vger.kernel.org

commit ae67643edc6edcab41d8d5d35cb796416b253a01
Author: William Breathitt Gray <vilhelm.gray@gmail.com>
Date:   Wed May 11 08:47:46 2016 -0400

    Documentation: Add ebc-c384_wdt watchdog-parameters.txt entry
    
    The WinSystems EBC-C384 watchdog timer driver supports two module
    parameters: timeout and nowayout. These parameters should be documented
    in the watchdog-parameters.txt file.
    
    Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 12fe36e2ca0e474a2d7b48ab018d16977f9745a4
Author: Muhammad Falak R Wani <falakreyaz@gmail.com>
Date:   Fri May 6 18:29:41 2016 +0530

    watchdog: shwdt: Use setup_timer()
    
    The function setup_timer combines the initialization of a timer with
    the initialization of the timer's function and data fields.
    The multiline code for timer initialization is now replaced
    with function setup_timer.
    
    Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d904ac34bdbcf62a50c745cfe991681ae3948e4e
Author: Muhammad Falak R Wani <falakreyaz@gmail.com>
Date:   Fri May 6 18:29:40 2016 +0530

    watchdog: cpwd: Use setup_timer()
    
    The function setup_timer combines the initialization of a timer with
    the initialization of the timer's function and data fields.
    The multiline code for timer initialization is now replaced
    with function setup_timer.
    
    Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit fc4d2c7390dde766ec62f8f83be06e9227e9eb7a
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Fri Apr 1 13:56:26 2016 +0200

    arm64: defconfig: enable Renesas Watchdog Timer
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit bd99b68ed7f96c9c845aad2a25f84145213058f2
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Fri Apr 1 13:56:23 2016 +0200

    watchdog: renesas-wdt: add driver
    
    Add support for watchdogs (RWDT and SWDT) found on RCar Gen3 based SoCs
    from Renesas.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e26e74b15468b42c47cf9b045539720006abb1e4
Author: Colin Ian King <colin.king@canonical.com>
Date:   Tue Apr 26 18:18:49 2016 +0100

    watchdog: remove error message when unable to allocate watchdog device
    
    The dev_err message is superfluous because the failure is already
    printed by dev_kzalloc, so remove it.
    
    Signed-off-by: Colin Ian King <colin.king@canonical.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b97cb21a46341575c6cbe3d327a08b99030c3aee
Author: Knud Poulsen <knpo@ieee.org>
Date:   Tue Apr 26 08:44:16 2016 +0200

    watchdog: f71808e_wdt: Fix WDTMOUT_STS register read
    
    Tested and verified on Lanner LEC-3030 Industrial PC (with F81865)
    
    Datasheet verified for
     F71808, F71858, F71862, F71869, F71869A, F71882, F71889, F81865
    
    Datasheet references:
    F71808A:
     http://www.electronicsdatasheets.com/download/534cf560e34e2406135f4658.pdf?format=pdf
    F71858:
     http://www.electronicsdatasheets.com/download/534cf55fe34e2406135f4635.pdf?format=pdf
    F71862:
     http://www.hardwaresecrets.com/datasheets/F71862_V027P.pdf
    F71869:
     http://www.clubedohardware.com.br/datasheets/366451_F71869.pdf
    F71869A:
     http://www.chipset-ic.com/datasheet/F71869AD.pdf
    F71882:
     http://www.digchip.com/datasheets/parts/datasheet/931/F71882-pdf.php
    F71889:
     http://pdf1.alldatasheet.com/datasheet-pdf/view/406312/FINTEK/F71889.html
    F81865:
     http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
     http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html
    
    Signed-off-by: Knud Poulsen <knpo@ieee.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 85c130a8bf542205a84edbca225972375fcb07eb
Author: Knud Poulsen <knpo@ieee.org>
Date:   Mon Apr 25 17:34:47 2016 +0200

    watchdog: f71808e_wdt: Fix typo
    
    Spelling/ typo
    
    Signed-off-by: Knud Poulsen <knpo@ieee.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ea0c03e80ccd99cb0ab208397da5a417dabf9a22
Author: Knud Poulsen <knpo@ieee.org>
Date:   Mon Apr 25 12:28:51 2016 +0200

    watchdog: f71808e_wdt: Add F81865 support
    
    Adds watchdog enable support for Fintek F81865 Super-IO chip to
    Fintek wdt driver (f71808e_wdt)
    
    Tested and verified on Lanner LEC-3030 Industrial PC
    
    Datasheet references:
    http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
    http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html
    
    Signed-off-by: Knud Poulsen <knpo@ieee.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 46856fabe40cc80f92134683cdec7dc0fc8f4000
Author: Lucas Stach <dev@lynxeye.de>
Date:   Tue May 3 19:15:58 2016 +0200

    watchdog: sp5100_tco: properly check for new register layouts
    
    Commits 190aa4304de6 (Add AMD Mullins platform support) and
    cca118fa2a0a94 (Add AMD Carrizo platform support) enabled the
    driver on a lot more devices, but the following commit missed
    a single location in the code when checking if the SB800 register
    offsets should be used. This leads to the wrong register being
    written which in turn causes ACPI to go haywire.
    
    Fix this by introducing a helper function to check for the new
    register layout and use this consistently.
    
    https://bugzilla.kernel.org/show_bug.cgi?id=114201
    https://bugzilla.redhat.com/show_bug.cgi?id=1329910
    Fixes: bdecfcdb5461 (sp5100_tco: fix the device check for SB800
    and later chipsets)
    Cc: stable@vger.kernel.org (4.5+)
    Signed-off-by: Lucas Stach <dev@lynxeye.de>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e1f30282a1d3d0c75d5a08e47c6ac1563065be52
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Thu Apr 21 07:38:14 2016 -0700

    watchdog: core: Fix circular locking dependency
    
    lockdep reports the following circular locking dependency.
    
    ======================================================
    INFO: possible circular locking dependency detected ]
    4.6.0-rc3-00191-gfabf418 #162 Not tainted
    -------------------------------------------------------
    systemd/1 is trying to acquire lock:
    ((&(&wd_data->work)->work)){+.+...}, at: [<80141650>] flush_work+0x0/0x280
    
    but task is already holding lock:
    
    (&wd_data->lock){+.+...}, at: [<804acfa8>] watchdog_release+0x18/0x190
    
    which lock already depends on the new lock.
    the existing dependency chain (in reverse order) is:
    
    -> #1 (&wd_data->lock){+.+...}:
    	[<80662310>] mutex_lock_nested+0x64/0x4a8
    	[<804aca4c>] watchdog_ping_work+0x18/0x4c
    	[<80143128>] process_one_work+0x1ac/0x500
    	[<801434b4>] worker_thread+0x38/0x554
    	[<80149510>] kthread+0xf4/0x108
    	[<80107c10>] ret_from_fork+0x14/0x24
    
    -> #0 ((&(&wd_data->work)->work)){+.+...}:
    	[<8017c4e8>] lock_acquire+0x70/0x90
    	[<8014169c>] flush_work+0x4c/0x280
    	[<801440f8>] __cancel_work_timer+0x9c/0x1e0
    	[<804acfcc>] watchdog_release+0x3c/0x190
    	[<8022c5e8>] __fput+0x80/0x1c8
    	[<80147b28>] task_work_run+0x94/0xc8
    	[<8010b998>] do_work_pending+0x8c/0xb4
    	[<80107ba8>] slow_work_pending+0xc/0x20
    
    other info that might help us debug this:
    Possible unsafe locking scenario:
    
    CPU0                    CPU1
    ----                    ----
    lock(&wd_data->lock);
                            lock((&(&wd_data->work)->work));
                            lock(&wd_data->lock);
    lock((&(&wd_data->work)->work));
    
    *** DEADLOCK ***
    
    1 lock held by systemd/1:
    
    stack backtrace:
    CPU: 2 PID: 1 Comm: systemd Not tainted 4.6.0-rc3-00191-gfabf418 #162
    Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
    [<8010f5e4>] (unwind_backtrace) from [<8010c038>] (show_stack+0x10/0x14)
    [<8010c038>] (show_stack) from [<8039d7fc>] (dump_stack+0xa8/0xd4)
    [<8039d7fc>] (dump_stack) from [<80177ee0>] (print_circular_bug+0x214/0x334)
    [<80177ee0>] (print_circular_bug) from [<80179230>] (check_prevs_add+0x4dc/0x8e8)
    [<80179230>] (check_prevs_add) from [<8017b3d8>] (__lock_acquire+0xc6c/0x14ec)
    [<8017b3d8>] (__lock_acquire) from [<8017c4e8>] (lock_acquire+0x70/0x90)
    [<8017c4e8>] (lock_acquire) from [<8014169c>] (flush_work+0x4c/0x280)
    [<8014169c>] (flush_work) from [<801440f8>] (__cancel_work_timer+0x9c/0x1e0)
    [<801440f8>] (__cancel_work_timer) from [<804acfcc>] (watchdog_release+0x3c/0x190)
    [<804acfcc>] (watchdog_release) from [<8022c5e8>] (__fput+0x80/0x1c8)
    [<8022c5e8>] (__fput) from [<80147b28>] (task_work_run+0x94/0xc8)
    [<80147b28>] (task_work_run) from [<8010b998>] (do_work_pending+0x8c/0xb4)
    [<8010b998>] (do_work_pending) from [<80107ba8>] (slow_work_pending+0xc/0x20)
    
    Turns out the call to cancel_delayed_work_sync() in watchdog_release()
    is not necessary and can be dropped. If the worker is no longer necessary,
    the subsequent call to watchdog_update_worker() will cancel it. If it is
    already running, it won't do anything, since the worker function checks
    if it needs to ping the watchdog or not.
    
    Reported-by: Clemens Gruber <clemens.gruber@pqgruber.com>
    Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
    Fixes: 11d7aba9ceb7 ("watchdog: imx2: Convert to use infrastructure triggered keepalives")
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Cc: stable <stable@vger.kernel.org>

commit 358d5a565fa6a5f51fcd04f8e890a0a474a814fe
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Tue Apr 12 17:56:11 2016 +0200

    watchdog: core: fix trivial typo in a comment
    
    Let's have balanced round brackets.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 84df082cad236a6ec70df1fbbf3d8dcb5c5f994e
Author: Nigel Croxon <nigel.croxon@hpe.com>
Date:   Wed Apr 6 14:40:05 2016 -0400

    watchdog: hpwdt: Adjust documentation to match latest kernel module parameters.
    
    Adjust documentation to match latest kernel module parameters.
    
    Signed-off-by: Nigel Croxon <nigel.croxon@hpe.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit bc677ff42e81bbf78308a7b66cf7b63b0f5c26b0
Author: Tim Harvey <tharvey@gateworks.com>
Date:   Fri Apr 1 08:16:43 2016 -0700

    watchdog: imx2_wdt: add external reset support via dt prop
    
    The IMX6 watchdog supports assertion of a signal (WDOG_B) which
    can be pinmux'd to an external pin. This is typically used for boards that
    have PMIC's in control of the IMX6 power rails. In fact, failure to use
    such an external reset on boards with external PMIC's can result in various
    hangs due to the IMX6 not being fully reset [1] as well as the board failing
    to reset because its PMIC has not been reset to provide adequate voltage for
    the CPU when coming out of reset at 800Mhz.
    
    This uses a new device-tree property 'fsl,ext-reset-output' to indicate the
    board has such a reset and to cause the watchdog to be configured to assert
    WDOG_B instead of an internal reset both on a watchdog timeout and in
    system_restart.
    
    [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
    
    Cc: Fabio Estevam <festevam@gmail.com>
    Cc: Lucas Stach <l.stach@pengutronix.de>
    Cc: Stefan Roese <sr@denx.de>
    Cc: Iain Paton <ipaton0@gmail.com>
    Cc: Sascha Hauer <s.hauer@pengutronix.de>
    Signed-off-by: Tim Harvey <tharvey@gateworks.com>
    Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
    Acked-by: Shawn Guo <shawn.guo@linaro.org>
    Tested-by: Akshay Bhat <akshay.bhat@timesys.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ebbf677a3fb54fda56c58fc985c4617c215da6a0
Author: Richard Cochran <rcochran@linutronix.de>
Date:   Fri Mar 18 22:26:08 2016 +0100

    watchdog: octeon: Handle the FROZEN hot plug notifier actions.
    
    When performing a suspend operation, the kernel brings all of the
    non-boot CPUs offline, calling the hot plug notifiers with the flag,
    CPU_TASKS_FROZEN, set in the action code.  Similarly, during resume,
    the CPUs are brought back online, but again the notifiers have the
    FROZEN flag set.
    
    While some very few drivers really need to treat suspend/resume
    specially, this driver unintentionally ignores the notifications.
    
    This patch changes the driver to disable the watchdog interrupt
    whenever the CPU goes offline, and to enable it whenever the CPU goes
    back online.  As a result, the suspended state is no longer a special
    case that leaves the watchdog active.
    
    Signed-off-by: Richard Cochran <rcochran@linutronix.de>
    Cc: linux-watchdog@vger.kernel.org
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b6ef36d2c1e391adc1fe1b2dd2a0f887a9f3052b
Author: Guenter Roeck <groeck@chromium.org>
Date:   Mon Apr 4 17:37:46 2016 -0700

    watchdog: qcom: Report reboot reason
    
    The Qualcom watchdog timer block reports if the system was reset by the
    watchdog. Pass the information to user space.
    
    Reviewed-by: Grant Grundler <grundler@chromium.org>
    Tested-by: Grant Grundler <grundler@chromium.org>
    Signed-off-by: Guenter Roeck <groeck@chromium.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
index 8dab6fd..107280e 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -5,10 +5,12 @@ Required properties:
 - reg : Should contain WDT registers location and length
 - interrupts : Should contain WDT interrupt
 
-Optional property:
+Optional properties:
 - big-endian: If present the watchdog device's registers are implemented
   in big endian mode, otherwise in native mode(same with CPU), for more
   detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
+- fsl,ext-reset-output: If present the watchdog device is configured to
+  assert its external reset (WDOG_B) instead of issuing a software reset.
 
 Examples:
 
diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
new file mode 100644
index 0000000..b9512f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -0,0 +1,25 @@
+Renesas Watchdog Timer (WDT) Controller
+
+Required properties:
+- compatible : Should be "renesas,r8a7795-wdt", or "renesas,rcar-gen3-wdt"
+
+  When compatible with the generic version, nodes must list the SoC-specific
+  version corresponding to the platform first, followed by the generic
+  version.
+
+- reg : Should contain WDT registers location and length
+- clocks : the clock feeding the watchdog timer.
+
+Optional properties:
+- timeout-sec : Contains the watchdog timeout in seconds
+- power-domains : the power domain the WDT belongs to
+
+Examples:
+
+	wdt0: watchdog@e6020000 {
+		compatible = "renesas,r8a7795-wdt", "renesas,rcar-gen3-wdt";
+		reg = <0 0xe6020000 0 0x0c>;
+		clocks = <&cpg CPG_MOD 402>;
+		power-domains = <&cpg>;
+		timeout-sec = <60>;
+	};
diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
index 9488078..a40398c 100644
--- a/Documentation/watchdog/hpwdt.txt
+++ b/Documentation/watchdog/hpwdt.txt
@@ -1,64 +1,67 @@
-Last reviewed: 06/02/2009
+Last reviewed: 04/04/2016
 
-                     HP iLO2 NMI Watchdog Driver
-              NMI sourcing for iLO2 based ProLiant Servers
+                     HPE iLO NMI Watchdog Driver
+              NMI sourcing for iLO based ProLiant Servers
                      Documentation and Driver by
-              Thomas Mingarelli <thomas.mingarelli@hp.com>
+              Thomas Mingarelli <thomas.mingarelli@hpe.com>
 
- The HP iLO2 NMI Watchdog driver is a kernel module that provides basic
+ The HPE iLO NMI Watchdog driver is a kernel module that provides basic
  watchdog functionality and the added benefit of NMI sourcing. Both the
  watchdog functionality and the NMI sourcing capability need to be enabled
  by the user. Remember that the two modes are not dependent on one another.
  A user can have the NMI sourcing without the watchdog timer and vice-versa.
+ All references to iLO in this document imply it also works on iLO2 and all
+ subsequent generations.
 
  Watchdog functionality is enabled like any other common watchdog driver. That
  is, an application needs to be started that kicks off the watchdog timer. A
  basic application exists in the Documentation/watchdog/src directory called
  watchdog-test.c. Simply compile the C file and kick it off. If the system
- gets into a bad state and hangs, the HP ProLiant iLO 2 timer register will
+ gets into a bad state and hangs, the HPE ProLiant iLO timer register will
  not be updated in a timely fashion and a hardware system reset (also known as
  an Automatic Server Recovery (ASR)) event will occur.
 
- The hpwdt driver also has four (4) module parameters. They are the following:
+ The hpwdt driver also has three (3) module parameters. They are the following:
 
- soft_margin - allows the user to set the watchdog timer value
- allow_kdump - allows the user to save off a kernel dump image after an NMI
+ soft_margin - allows the user to set the watchdog timer value.
+               Default value is 30 seconds.
+ allow_kdump - allows the user to save off a kernel dump image after an NMI.
+               Default value is 1/ON
  nowayout    - basic watchdog parameter that does not allow the timer to
                be restarted or an impending ASR to be escaped.
- priority    - determines whether or not the hpwdt driver is first on the
-               die_notify list to handle NMIs or last. The default value
-               for this module parameter is 0 or LAST. If the user wants to
-               enable NMI sourcing then reload the hpwdt driver with
-               priority=1 (and boot with nmi_watchdog=0).
+               Default value is set when compiling the kernel. If it is set
+               to "Y", then there is no way of disabling the watchdog once
+               it has been started.
 
  NOTE: More information about watchdog drivers in general, including the ioctl
        interface to /dev/watchdog can be found in
        Documentation/watchdog/watchdog-api.txt and Documentation/IPMI.txt.
 
- The priority parameter was introduced due to other kernel software that relied
- on handling NMIs (like oprofile). Keeping hpwdt's priority at 0 (or LAST)
- enables the users of NMIs for non critical events to be work as expected.
-
  The NMI sourcing capability is disabled by default due to the inability to
  distinguish between "NMI Watchdog Ticks" and "HW generated NMI events" in the
  Linux kernel. What this means is that the hpwdt nmi handler code is called
  each time the NMI signal fires off. This could amount to several thousands of
  NMIs in a matter of seconds. If a user sees the Linux kernel's "dazed and
  confused" message in the logs or if the system gets into a hung state, then
- the hpwdt driver can be reloaded with the "priority" module parameter set
- (priority=1).
+ the hpwdt driver can be reloaded.
 
  1. If the kernel has not been booted with nmi_watchdog turned off then
-    edit /boot/grub/menu.lst and place the nmi_watchdog=0 at the end of the
-    currently booting kernel line.
+    edit and place the nmi_watchdog=0 at the end of the currently booting
+    kernel line. Depending on your Linux distribution and platform setup:
+    For non-UEFI systems
+       /boot/grub/grub.conf   or
+       /boot/grub/menu.lst
+    For UEFI systems
+      /boot/efi/EFI/distroname/grub.conf   or
+      /boot/efi/efi/distroname/elilo.conf
  2. reboot the sever
- 3. Once the system comes up perform a rmmod hpwdt
- 4. insmod /lib/modules/`uname -r`/kernel/drivers/char/watchdog/hpwdt.ko priority=1
+ 3. Once the system comes up perform a modprobe -r hpwdt
+ 4. modprobe /lib/modules/`uname -r`/kernel/drivers/watchdog/hpwdt.ko
 
  Now, the hpwdt can successfully receive and source the NMI and provide a log
- message that details the reason for the NMI (as determined by the HP BIOS).
+ message that details the reason for the NMI (as determined by the HPE BIOS).
 
- Below is a list of NMIs the HP BIOS understands along with the associated
+ Below is a list of NMIs the HPE BIOS understands along with the associated
  code (reason):
 
 	No source found                00h
@@ -92,4 +95,4 @@ Last reviewed: 06/02/2009
 
 
  -- Tom Mingarelli
-    (thomas.mingarelli@hp.com)
+    (thomas.mingarelli@hpe.com)
diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index c161399..a8d3642 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -86,6 +86,10 @@ nowayout: Watchdog cannot be stopped once started
 davinci_wdt:
 heartbeat: Watchdog heartbeat period in seconds from 1 to 600, default 60
 -------------------------------------------------
+ebc-c384_wdt:
+timeout: Watchdog timeout in seconds. (1<=timeout<=15300, default=60)
+nowayout: Watchdog cannot be stopped once started
+-------------------------------------------------
 ep93xx_wdt:
 nowayout: Watchdog cannot be stopped once started
 timeout: Watchdog timeout in seconds. (1<=timeout<=3600, default=TBD)
diff --git a/MAINTAINERS b/MAINTAINERS
index a727d99..f69706d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12073,6 +12073,7 @@ L:	linux-watchdog@vger.kernel.org
 W:	http://www.linux-watchdog.org/
 T:	git git://www.linux-watchdog.org/linux-watchdog.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/
 F:	Documentation/watchdog/
 F:	drivers/watchdog/
 F:	include/linux/watchdog.h
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a44ef99..2578d55 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -171,6 +171,8 @@ CONFIG_POWER_RESET_SYSCON=y
 CONFIG_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_RENESAS_WDT=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_REGULATOR=y
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fb94765..3902c9c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -661,6 +661,14 @@ config ATLAS7_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called atlas7_wdt.
 
+config RENESAS_WDT
+	tristate "Renesas WDT Watchdog"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This driver adds watchdog support for the integrated watchdogs in the
+	  Renesas R-Car and other SH-Mobile SoCs (usually named RWDT or SWDT).
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index feb6270..2cbc970 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
+obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 0200768..71ee079 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -611,9 +611,7 @@ static int cpwd_probe(struct platform_device *op)
 	}
 
 	if (p->broken) {
-		init_timer(&cpwd_timer);
-		cpwd_timer.function	= cpwd_brokentimer;
-		cpwd_timer.data		= (unsigned long) p;
+		setup_timer(&cpwd_timer, cpwd_brokentimer, (unsigned long)p);
 		cpwd_timer.expires	= WD_BTIMEOUT;
 
 		pr_info("PLD defect workaround enabled for model %s\n",
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 016bd93..d4ba262 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -38,7 +38,7 @@
 
 #define SIO_F71808FG_LD_WDT	0x07	/* Watchdog timer logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
-#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
+#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
 
 #define SIO_REG_LDSEL		0x07	/* Logical device select */
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
@@ -59,6 +59,7 @@
 #define SIO_F71869A_ID		0x1007	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
+#define SIO_F81865_ID		0x0704	/* Chipset ID */
 
 #define F71808FG_REG_WDO_CONF		0xf0
 #define F71808FG_REG_WDT_CONF		0xf5
@@ -66,11 +67,14 @@
 
 #define F71808FG_FLAG_WDOUT_EN		7
 
-#define F71808FG_FLAG_WDTMOUT_STS	5
+#define F71808FG_FLAG_WDTMOUT_STS	6
 #define F71808FG_FLAG_WD_EN		5
 #define F71808FG_FLAG_WD_PULSE		4
 #define F71808FG_FLAG_WD_UNIT		3
 
+#define F81865_REG_WDO_CONF		0xfa
+#define F81865_FLAG_WDOUT_EN		0
+
 /* Default values */
 #define WATCHDOG_TIMEOUT	60	/* 1 minute default timeout */
 #define WATCHDOG_MAX_TIMEOUT	(60 * 255)
@@ -112,7 +116,7 @@ module_param(start_withtimeout, uint, 0);
 MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
 	" given initial timeout. Zero (default) disables this feature.");
 
-enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg };
+enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865 };
 
 static const char *f71808e_names[] = {
 	"f71808fg",
@@ -121,6 +125,7 @@ static const char *f71808e_names[] = {
 	"f71869",
 	"f71882fg",
 	"f71889fg",
+	"f81865",
 };
 
 /* Super-I/O Function prototypes */
@@ -360,6 +365,11 @@ static int watchdog_start(void)
 			superio_inb(watchdog.sioaddr, SIO_REG_MFUNCT3) & 0xcf);
 		break;
 
+	case f81865:
+		/* Set pin 70 to WDTRST# */
+		superio_clear_bit(watchdog.sioaddr, SIO_REG_MFUNCT3, 5);
+		break;
+
 	default:
 		/*
 		 * 'default' label to shut up the compiler and catch
@@ -371,8 +381,13 @@ static int watchdog_start(void)
 
 	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
 	superio_set_bit(watchdog.sioaddr, SIO_REG_ENABLE, 0);
-	superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDO_CONF,
-			F71808FG_FLAG_WDOUT_EN);
+
+	if (watchdog.type == f81865)
+		superio_set_bit(watchdog.sioaddr, F81865_REG_WDO_CONF,
+				F81865_FLAG_WDOUT_EN);
+	else
+		superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDO_CONF,
+				F71808FG_FLAG_WDOUT_EN);
 
 	superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDT_CONF,
 			F71808FG_FLAG_WD_EN);
@@ -655,7 +670,7 @@ static int __init watchdog_init(int sioaddr)
 	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
 
 	wdt_conf = superio_inb(sioaddr, F71808FG_REG_WDT_CONF);
-	watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
+	watchdog.caused_reboot = wdt_conf & BIT(F71808FG_FLAG_WDTMOUT_STS);
 
 	superio_exit(sioaddr);
 
@@ -770,6 +785,9 @@ static int __init f71808e_find(int sioaddr)
 		/* Confirmed (by datasheet) not to have a watchdog. */
 		err = -ENODEV;
 		goto exit;
+	case SIO_F81865_ID:
+		watchdog.type = f81865;
+		break;
 	default:
 		pr_info("Unrecognized Fintek device: %04x\n",
 			(unsigned int)devid);
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 331aed8..62f346b 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -37,6 +37,8 @@
 
 #define IMX2_WDT_WCR		0x00		/* Control Register */
 #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
+#define IMX2_WDT_WCR_WDA	(1 << 5)	/* -> External Reset WDOG_B */
+#define IMX2_WDT_WCR_SRS	(1 << 4)	/* -> Software Reset Signal */
 #define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
 #define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
 #define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog timer Suspend */
@@ -59,6 +61,7 @@ struct imx2_wdt_device {
 	struct clk *clk;
 	struct regmap *regmap;
 	struct watchdog_device wdog;
+	bool ext_reset;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -83,6 +86,12 @@ static int imx2_wdt_restart(struct watchdog_device *wdog, unsigned long action,
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
 
+	/* Use internal reset or external - not both */
+	if (wdev->ext_reset)
+		wcr_enable |= IMX2_WDT_WCR_SRS; /* do not assert int reset */
+	else
+		wcr_enable |= IMX2_WDT_WCR_WDA; /* do not assert ext-reset */
+
 	/* Assert SRS signal */
 	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
 	/*
@@ -112,8 +121,12 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
 	val |= IMX2_WDT_WCR_WDZST;
 	/* Strip the old watchdog Time-Out value */
 	val &= ~IMX2_WDT_WCR_WT;
-	/* Generate reset if WDOG times out */
-	val &= ~IMX2_WDT_WCR_WRE;
+	/* Generate internal chip-level reset if WDOG times out */
+	if (!wdev->ext_reset)
+		val &= ~IMX2_WDT_WCR_WRE;
+	/* Or if external-reset assert WDOG_B reset only on time-out */
+	else
+		val |= IMX2_WDT_WCR_WRE;
 	/* Keep Watchdog Disabled */
 	val &= ~IMX2_WDT_WCR_WDE;
 	/* Set the watchdog's Time-Out value */
@@ -230,6 +243,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	regmap_read(wdev->regmap, IMX2_WDT_WRSR, &val);
 	wdog->bootstatus = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
 
+	wdev->ext_reset = of_property_read_bool(pdev->dev.of_node,
+						"fsl,ext-reset-output");
 	wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
 	if (wdog->timeout != timeout)
 		dev_warn(&pdev->dev, "Initial timeout out of range! Clamped from %u to %u\n",
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 6a7d5c3..c8d51dd 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -160,10 +160,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
 			       GFP_KERNEL);
-	if (!drvdata) {
-		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
+	if (!drvdata)
 		return -ENOMEM;
-	}
 
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat = DEFAULT_HEARTBEAT;
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 14521c8..b55981f 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -431,7 +431,7 @@ static int octeon_wdt_cpu_callback(struct notifier_block *nfb,
 {
 	unsigned int cpu = (unsigned long)hcpu;
 
-	switch (action) {
+	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_DOWN_PREPARE:
 		octeon_wdt_disable_interrupt(cpu);
 		break;
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 20563cc..a043fa4 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -21,6 +21,7 @@
 
 #define WDT_RST		0x38
 #define WDT_EN		0x40
+#define WDT_STS		0x44
 #define WDT_BITE_TIME	0x5C
 
 struct qcom_wdt {
@@ -108,7 +109,8 @@ static const struct watchdog_ops qcom_wdt_ops = {
 static const struct watchdog_info qcom_wdt_info = {
 	.options	= WDIOF_KEEPALIVEPING
 			| WDIOF_MAGICCLOSE
-			| WDIOF_SETTIMEOUT,
+			| WDIOF_SETTIMEOUT
+			| WDIOF_CARDRESET,
 	.identity	= KBUILD_MODNAME,
 };
 
@@ -171,6 +173,9 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
 	wdt->wdd.parent = &pdev->dev;
 
+	if (readl(wdt->base + WDT_STS) & 1)
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
 	/*
 	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
 	 * default, unless the max timeout is less than 30 seconds, then use
diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
new file mode 100644
index 0000000..cf61c92
--- /dev/null
+++ b/drivers/watchdog/renesas_wdt.c
@@ -0,0 +1,213 @@
+/*
+ * Watchdog driver for Renesas WDT watchdog
+ *
+ * Copyright (C) 2015-16 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015-16 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/watchdog.h>
+
+#define RWTCNT		0
+#define RWTCSRA		4
+#define RWTCSRA_WOVF	BIT(4)
+#define RWTCSRA_WRFLG	BIT(5)
+#define RWTCSRA_TME	BIT(7)
+
+#define RWDT_DEFAULT_TIMEOUT 60U
+
+static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct rwdt_priv {
+	void __iomem *base;
+	struct watchdog_device wdev;
+	struct clk *clk;
+	unsigned int clks_per_sec;
+	u8 cks;
+};
+
+static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned int reg)
+{
+	if (reg == RWTCNT)
+		val |= 0x5a5a0000;
+	else
+		val |= 0xa5a5a500;
+
+	writel_relaxed(val, priv->base + reg);
+}
+
+static int rwdt_init_timeout(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
+
+	return 0;
+}
+
+static int rwdt_start(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	clk_prepare_enable(priv->clk);
+
+	rwdt_write(priv, priv->cks, RWTCSRA);
+	rwdt_init_timeout(wdev);
+
+	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
+		cpu_relax();
+
+	rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
+
+	return 0;
+}
+
+static int rwdt_stop(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	rwdt_write(priv, priv->cks, RWTCSRA);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+	u16 val = readw_relaxed(priv->base + RWTCNT);
+
+	return DIV_ROUND_CLOSEST(65536 - val, priv->clks_per_sec);
+}
+
+static const struct watchdog_info rwdt_ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.identity = "Renesas WDT Watchdog",
+};
+
+static const struct watchdog_ops rwdt_ops = {
+	.owner = THIS_MODULE,
+	.start = rwdt_start,
+	.stop = rwdt_stop,
+	.ping = rwdt_init_timeout,
+	.get_timeleft = rwdt_get_timeleft,
+};
+
+static int rwdt_probe(struct platform_device *pdev)
+{
+	struct rwdt_priv *priv;
+	struct resource *res;
+	unsigned long rate;
+	unsigned int clks_per_sec;
+	int ret, i;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -ENOENT;
+
+	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
+		clks_per_sec = DIV_ROUND_UP(rate, clk_divs[i]);
+		if (clks_per_sec) {
+			priv->clks_per_sec = clks_per_sec;
+			priv->cks = i;
+			break;
+		}
+	}
+
+	if (!clks_per_sec) {
+		dev_err(&pdev->dev, "Can't find suitable clock divider\n");
+		return -ERANGE;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	priv->wdev.info = &rwdt_ident,
+	priv->wdev.ops = &rwdt_ops,
+	priv->wdev.parent = &pdev->dev;
+	priv->wdev.min_timeout = 1;
+	priv->wdev.max_timeout = 65536 / clks_per_sec;
+	priv->wdev.timeout = min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
+
+	platform_set_drvdata(pdev, priv);
+	watchdog_set_drvdata(&priv->wdev, priv);
+	watchdog_set_nowayout(&priv->wdev, nowayout);
+
+	/* This overrides the default timeout only if DT configuration was found */
+	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
+	if (ret)
+		dev_warn(&pdev->dev, "Specified timeout value invalid, using default\n");
+
+	ret = watchdog_register_device(&priv->wdev);
+	if (ret < 0) {
+		pm_runtime_put(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rwdt_remove(struct platform_device *pdev)
+{
+	struct rwdt_priv *priv = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&priv->wdev);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+/*
+ * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
+ * to work there, one also needs a RESET (RST) driver which does not exist yet
+ * due to HW issues. This needs to be solved before adding compatibles here.
+ */
+static const struct of_device_id rwdt_ids[] = {
+	{ .compatible = "renesas,rcar-gen3-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rwdt_ids);
+
+static struct platform_driver rwdt_driver = {
+	.driver = {
+		.name = "renesas_wdt",
+		.of_match_table = rwdt_ids,
+	},
+	.probe = rwdt_probe,
+	.remove = rwdt_remove,
+};
+module_platform_driver(rwdt_driver);
+
+MODULE_DESCRIPTION("Renesas WDT Watchdog Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wolfram Sang <wsa@sang-engineering.com>");
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index f908121..517a733 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -275,9 +275,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	init_timer(&wdt->timer);
-	wdt->timer.function	= sh_wdt_ping;
-	wdt->timer.data		= (unsigned long)wdt;
+	setup_timer(&wdt->timer, sh_wdt_ping, (unsigned long)wdt);
 	wdt->timer.expires	= next_ping_period(clock_division_ratio);
 
 	dev_info(&pdev->dev, "initialized.\n");
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 6467b91..028618c 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -73,6 +73,13 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started."
 /*
  * Some TCO specific functions
  */
+
+static bool tco_has_sp5100_reg_layout(struct pci_dev *dev)
+{
+	return dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
+	       dev->revision < 0x40;
+}
+
 static void tco_timer_start(void)
 {
 	u32 val;
@@ -129,7 +136,7 @@ static void tco_timer_enable(void)
 {
 	int val;
 
-	if (sp5100_tco_pci->revision >= 0x40) {
+	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
 		/* For SB800 or later */
 		/* Set the Watchdog timer resolution to 1 sec */
 		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
@@ -342,8 +349,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 	/*
 	 * Determine type of southbridge chipset.
 	 */
-	if (sp5100_tco_pci->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
-	    sp5100_tco_pci->revision < 0x40) {
+	if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
 		dev_name = SP5100_DEVNAME;
 		index_reg = SP5100_IO_PM_INDEX_REG;
 		data_reg = SP5100_IO_PM_DATA_REG;
@@ -388,8 +394,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 	 * Secondly, Find the watchdog timer MMIO address
 	 * from SBResource_MMIO register.
 	 */
-	if (sp5100_tco_pci->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
-	    sp5100_tco_pci->revision < 0x40) {
+	if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
 		/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
 		pci_read_config_dword(sp5100_tco_pci,
 				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index c1658fe..6249ed3 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -104,7 +104,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
  * timeout module parameter (if it is valid value) or the timeout-sec property
  * (only if it is a valid value and the timeout_parm is out of bounds).
  * If none of them are valid then we keep the old value (which should normally
- * be the default timeout value.
+ * be the default timeout value).
  *
  * A zero is returned on success and -EINVAL for failure.
  */
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e2c5abb..3595cff 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -736,7 +736,6 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		watchdog_ping(wdd);
 	}
 
-	cancel_delayed_work_sync(&wd_data->work);
 	watchdog_update_worker(wdd);
 
 	/* make sure that /dev/watchdog can be re-opened */
