Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:41564 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753647AbbGAVh5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Jul 2015 17:37:57 -0400
Date: Wed, 1 Jul 2015 23:37:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Lars Poeschel <poeschel@lemonage.de>,
	Jean-Baptiste Theou <jtheou@adeneo-embedded.us>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jean Delvare <jdelvare@suse.de>,
	S Twiss <stwiss.opensource@diasemi.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Doug Anderson <dianders@chromium.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Baruch Siach <baruch@tkos.co.il>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL REQUEST] watchdog - v4.2 merge window
Message-ID: <20150701213746.GA22755@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It contains:
* new driver for ST's LPC Watchdog
* new driver for Conexant Digicolor CX92755 SoC
* new driver for DA9062 watchdog
* Addition of the watchdog registration deferral mechanism
* several improvements on omap_wdt
* several improvements and reboot-support for imgpdc_wdt
* max63xx_wdt improvements
* imx2_wdt improvements
* dw_wdt improvements
* and other small improvements and fixes

This will update the following files:

 Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt |   25 
 Documentation/devicetree/bindings/watchdog/omap-wdt.txt      |    6 
 Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt    |   38 +
 Documentation/watchdog/watchdog-kernel-api.txt               |    7 
 Documentation/watchdog/watchdog-parameters.txt               |    3 
 arch/arm/configs/multi_v7_defconfig                          |    1 
 drivers/watchdog/Kconfig                                     |   48 +
 drivers/watchdog/Makefile                                    |    3 
 drivers/watchdog/at91sam9_wdt.c                              |    4 
 drivers/watchdog/da9062_wdt.c                                |  253 ++++++++
 drivers/watchdog/digicolor_wdt.c                             |  205 ++++++
 drivers/watchdog/dw_wdt.c                                    |    8 
 drivers/watchdog/gpio_wdt.c                                  |    9 
 drivers/watchdog/hpwdt.c                                     |   16 
 drivers/watchdog/imgpdc_wdt.c                                |   84 ++
 drivers/watchdog/imx2_wdt.c                                  |   18 
 drivers/watchdog/max63xx_wdt.c                               |  172 +++--
 drivers/watchdog/mena21_wdt.c                                |    5 
 drivers/watchdog/omap_wdt.c                                  |   92 +-
 drivers/watchdog/omap_wdt.h                                  |    1 
 drivers/watchdog/st_lpc_wdt.c                                |  344 +++++++++++
 drivers/watchdog/watchdog_core.c                             |  118 +++
 include/dt-bindings/mfd/st-lpc.h                             |   15 
 include/linux/watchdog.h                                     |    3 
 24 files changed, 1323 insertions(+), 155 deletions(-)

with these Changes:

commit b2102eb36e7909c779e46f66595fda75aa219f4c
Author: Lars Poeschel <poeschel@lemonage.de>
Date:   Thu Jun 25 12:21:51 2015 +0200

    watchdog: omap_wdt: early_enable module parameter
    
    Add a early_enable module parameter to the omap_wdt that starts the
    watchdog on module insertion. The default value is 0 which does not
    start the watchdog - which also does not change the behavior if the
    parameter is not given.
    
    Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5e53c8ed813d6100d2cebbf83f2192b201f70772
Author: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
Date:   Tue Jun 9 09:55:03 2015 -0700

    watchdog: gpio_wdt: Add option for early registration
    
    In some situation, mainly when it's not possible to disable a
    watchdog, you may want the watchdog driver to be started as soon
    as possible.
    
    Adding GPIO_WATCHDOG_ARCH_INITCALL to raise initcall from
    module_init to arch_initcall.
    
    This patch require watchdog registration deferral mechanism
    
    Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ef90174f821041313d42d99c1c8b35a3af64a910
Author: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
Date:   Tue Jun 9 09:55:02 2015 -0700

    watchdog: watchdog_core: Add watchdog registration deferral mechanism
    
    Currently, watchdog subsystem require the misc subsystem to
    register a watchdog. This may not be the case in case of an
    early registration of a watchdog, which can be required when
    the watchdog cannot be disabled.
    
    This patch introduces a deferral mechanism to remove this requirement.
    
    Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b9be9660ba2d23259e4a430a44167ef441dc5fe6
Author: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date:   Wed Jun 17 18:58:58 2015 -0400

    watchdog: max63xx: dynamically allocate device
    
    This patch removes the static watchdog device for a new max63xx_wdt data
    structure, and constifies the max63xx_timeout data.
    
    The new structure contains pointers to pin access routines, which
    abstracts mmap-specific code. This will ease future accesses like GPIO.
    
    Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit db11cba205b6710a71ef52a0f24e0ef059f29f1c
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Mon Jun 22 01:16:19 2015 -0300

    watchdog: imx2_wdt: Disable previously acquired clock on error path
    
    If watchdog_register_device() fails we should disable the previously
    acquired wdev->clk clock on error path.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit aefb163cb2b876bcbbceee47e3e4f22ed7364630
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Mon Jun 22 01:16:18 2015 -0300

    watchdog: imx2_wdt: Check for clk_prepare_enable() error
    
    clk_prepare_enable() may fail, so we should better check its return value
    and propagate it in the case of error.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 46c80b20d07e9309677d81e1226dc30a055b63b7
Author: Jean Delvare <jdelvare@suse.de>
Date:   Sun Jun 21 09:32:33 2015 +0200

    watchdog: hpwdt: Add support for WDIOC_SETOPTIONS
    
    WDIOC_SETOPTIONS makes it possible to disable and re-enable the
    watchdog timer while the hpwdt driver is loaded.
    
    Signed-off-by: Jean Delvare <jdelvare@suse.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a47911e99fe8d2080426951711a7e776d331ba77
Author: Lars Poeschel <poeschel@lemonage.de>
Date:   Wed Jun 17 11:13:27 2015 +0200

    watchdog: docs: omap_wdt also understands nowayout
    
    The omap_wdt kernel driver also understands the nowayout module
    parameter. This updates the watchdog-parameters.txt to reflect this fact.
    
    Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 452fafed839eb008a8ed9072d63449cb76de617e
Author: Lars Poeschel <poeschel@lemonage.de>
Date:   Wed Jun 17 10:58:59 2015 +0200

    watchdog: omap_wdt: implement get_timeleft
    
    The omap watchdog hardware is able to read the watchdog timer counter
    register. This implements this functionality in the omap_wdt driver, so
    one is can read the time until the watchdog will trigger the reset in
    seconds using WDIOC_GETTIMELEFT.
    
    Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 7a7cb009dcbae5588d8836cd7b4f7255db2e489b
Author: S Twiss <stwiss.opensource@diasemi.com>
Date:   Thu May 28 14:33:31 2015 +0100

    watchdog: da9062: DA9062 watchdog driver
    
    Add watchdog driver support for DA9062
    
    Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8135193ceba383e336b2449589db930ea02807d2
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Tue Jun 2 15:46:18 2015 +0300

    watchdog: imx2_wdt: set watchdog parent device
    
    If on watchdog device registration a parent device is not set, then
    the registered watchdog is considered to be a virtual device:
    
      /sys/devices/virtual/watchdog/watchdog0
      /sys/devices/virtual/watchdog/watchdog1
    
    Setting a correct reference to a platform device allows to
    distinguish multiple instances of iMX2+ hardware watchdogs:
    
      /sys/devices/soc0/soc/2000000.aips-bus/20bc000.wdog/watchdog/watchdog0
      /sys/devices/soc0/soc/2000000.aips-bus/20c0000.wdog/watchdog/watchdog1
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 57337db1b9f96b897d2404531d8b6375667723fa
Author: Johannes Thumshirn <jthumshirn@suse.de>
Date:   Tue Jun 2 12:25:26 2015 +0200

    watchdog: mena21_wdt: Fix possible NULL pointer dereference
    
    In a21_wdt_remove() we do a watchdog_unregister_device() on struct
    a21_wdt_drv->wdt but never assign it.
    
    Also move the dev_set_drvdata() call in front of the watchdog_register_device()
    call, so it doesn't look like an error.
    
    Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 04b1a62e6bb9b217847be874fe37a6b85ddff67e
Author: Doug Anderson <dianders@chromium.org>
Date:   Thu May 7 21:27:45 2015 -0700

    watchdog: dw_wdt: keepalive the watchdog at write time
    
    If you've got code that does this in a tight loop
      1. Open watchdog
      2. Send 'expect close'
      3. Close watchdog
    ...you'll eventually trigger a watchdog reset.  You can reproduce this
    by using daisydog (1) and running:
      while true; do daisydog -c > /dev/null; done
    
    The problem is that each time you write to the watchdog for 'expect
    close' it moves the timer .5 seconds out.  The timer thus never fires
    and never pats the watchdog for you.
    
    1: http://git.chromium.org/gitweb/?p=chromiumos/third_party/daisydog.git
    
    Signed-off-by: Doug Anderson <dianders@chromium.org>
    Tested-by: Jisheng Zhang <jszhang@marvell.com>
    Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 7fb466a7a7362de19b8f2aa07cffa79e527cf070
Author: Doug Anderson <dianders@chromium.org>
Date:   Thu May 7 21:27:44 2015 -0700

    watchdog: dw_wdt: No need for a spinlock
    
    Right now the dw_wdt uses a spinlock to protect dw_wdt_open().  The
    problem is that while holding the spinlock we call:
    -> dw_wdt_set_top()
       -> dw_wdt_top_in_seconds()
          -> clk_get_rate()
             -> clk_prepare_lock()
                -> mutex_lock()
    
    Locking a mutex while holding a spinlock is not allowed and leads to
    warnings like "BUG: spinlock wrong CPU on CPU#1", among other
    problems.
    
    There's no reason to use a spinlock.  Only dw_wdt_open() was protected
    and the test_and_set_bit() at the start of that function protects us
    anyway.
    
    Signed-off-by: Doug Anderson <dianders@chromium.org>
    Tested-by: Jisheng Zhang <jszhang@marvell.com>
    Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 30dd4a8f08b570b5ed978fd937fdb5c31194be41
Author: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date:   Wed May 6 13:17:59 2015 +0200

    watchdog: imx2_wdt: also set wdog->timeout to new_timeout
    
    Commit faad5de0b104 ("watchdog: imx2_wdt: convert to watchdog core api")
    removes the custom ioctl function. The generic ioctl handler is not
    setting the wdog->timeout to the new_timeout but handing this preset
    value back to the userspace. This patch sets the new value in the
    drivers set_timeout function to fix that problem.
    
    Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 21a926a340723035b5c569046056d65f80013e12
Author: Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue May 5 18:32:42 2015 +0200

    watchdog: Allow compile test of GPIO consumers if !GPIOLIB
    
    The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
    not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
    functionality only, can still be compiled if GPIOLIB is not enabled.
    
    Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
    appropriate.
    
    Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Cc: linux-watchdog@vger.kernel.org

commit 6960d4851f72148182892de68ea2a3ea2f525d4c
Author: Richard Weinberger <richard@nod.at>
Date:   Mon May 4 21:01:25 2015 +0200

    watchdog: cadence: Add dependency on HAS_IOMEM
    
    Not all architectures have io memory.
    
    Fixes:
    drivers/built-in.o: In function `cdns_wdt_probe':
    cadence_wdt.c:(.text+0x33b7c9): undefined reference to `devm_ioremap_resource'
    
    Signed-off-by: Richard Weinberger <richard@nod.at>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8c7c72c9bcd4bc76a2c04d6e1d06340082d399ec
Author: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Date:   Sat May 2 00:36:52 2015 +0900

    watchdog: max63xx_wdt: Constify platform_device_id
    
    The platform_device_id is not modified by the driver and core uses it as
    const.
    
    Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 04658449dc65911b418d1bf032a67c73027cb70f
Author: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date:   Thu Jan 29 12:15:42 2015 -0500

    watchdog: MAX63XX_WATCHDOG does not depend on ARM
    
    Remove the ARM Kconfig dependency since the Maxim MAX63xx devices are
    architecture independent.
    
    Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c1f263878e99e44c6e23fee0dfe01ef05ad83024
Author: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Date:   Mon May 11 14:41:05 2015 -0300

    watchdog: imgpdc: Add some documentation about the timeout
    
    This watchdog hardware can be configured in terms of power-of-two
    clock cycles. Therefore, the watchdog timeout configured by the user
    will be rounded-up to the next possible hardware timeout.
    
    This commit adds a comment explaining this.
    
    Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit deb8d50eb40085d304b42a524d4ba326fcecc73d
Author: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Date:   Mon May 11 14:41:04 2015 -0300

    watchdog: imgpdc: Fix max timeout
    
    Maximum timeout is currently set in clock cycles, but the watchdog
    core expects it to be in seconds. Fix it.
    
    Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c631f20068369a8b901574df9c7bfc57ce13de75
Author: Andrew Bresticker <abrestic@chromium.org>
Date:   Fri Apr 3 10:05:22 2015 -0700

    watchdog: imgpdc: Add reboot support
    
    Register a restart handler that will restart the system by writing
    to the watchdog's SOFT_RESET register.
    
    Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
    Reviewed-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Cc: James Hogan <james.hogan@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8aa453a533faf383fe711aa8dedcf421563ddf66
Author: Andrew Bresticker <abrestic@chromium.org>
Date:   Fri Apr 3 10:05:21 2015 -0700

    watchdog: imgpdc: Set timeout before starting watchdog
    
    Set up the watchdog for the specified timeout before attempting to start it.
    
    Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
    Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
    Reviewed-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Cc: James Hogan <james.hogan@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 7094e1dd2ba98f1eb534c262deebbc65e34fe132
Author: Andrew Bresticker <abrestic@chromium.org>
Date:   Fri Apr 3 10:05:20 2015 -0700

    watchdog: imgpdc: Allow timeout to be set in device-tree
    
    Since the heartbeat is statically initialized to its default value,
    watchdog_init_timeout() will never look in the device-tree for a
    timeout-sec value.  Instead of statically initializing heartbeat,
    fall back to the default timeout value if watchdog_init_timeout()
    fails.
    
    Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
    Reviewed-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Cc: James Hogan <james.hogan@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 530c11d432727c697629ad5f9d00ee8e2864d453
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Apr 29 20:38:46 2015 +0200

    watchdog: omap: assert the counter being stopped before reprogramming
    
    The omap watchdog has the annoying behaviour that writes to most
    registers don't have any effect when the watchdog is already running.
    Quoting the AM335x reference manual:
    
    	To modify the timer counter value (the WDT_WCRR register),
    	prescaler ratio (the WDT_WCLR[4:2] PTV bit field), delay
    	configuration value (the WDT_WDLY[31:0] DLY_VALUE bit field), or
    	the load value (the WDT_WLDR[31:0] TIMER_LOAD bit field), the
    	watchdog timer must be disabled by using the start/stop sequence
    	(the WDT_WSPR register).
    
    Currently the timer is stopped in the .probe callback but still there
    are possibilities that yield to a situation where omap_wdt_start is
    entered with the timer running (e.g. when /dev/watchdog is closed
    without stopping and then reopened). In such a case programming the
    timeout silently fails!
    
    To circumvent this stop the timer before reprogramming.
    
    Assuming one of the first things the watchdog user does is setting the
    timeout explicitly nothing too bad should happen because this explicit
    setting works fine.
    
    Fixes: 7768a13c252a ("[PATCH] OMAP: Add Watchdog driver support")
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0b3330f310b520f53a88a06bf44a4a6fda6b1a88
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Mon Apr 27 11:23:01 2015 +0200

    watchdog: omap: simplify assignment of bootstatus
    
    Instead of using an over-long expression involving the ?: operator use
    an if and instead of an else branch rely on the fact that the data
    structure was allocated using devm_kzalloc. This also allows to put the
    used helper variable into a more local scope.
    
    There is no functional change.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Felipe Balbi <balbi@ti.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d2f78268ba583f75d5a67d44b8ef4b1560d6f597
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Mon Apr 27 11:23:00 2015 +0200

    watchdog: omap: put struct watchdog_device into driver data
    
    This way only a single allocation is needed (per device). Also this
    simplifies the data structure used by the driver because there is no
    need anymore to link from one struct to the other (by means of
    watchdog_{set,get}_drvdata).
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a4f741e3e157c3a5c8aea5f2ea62b692fbf17338
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Mon Apr 27 11:22:59 2015 +0200

    watchdog: omap: use watchdog_init_timeout instead of open coding it
    
    Instead of (partly) open coding watchdog_init_timeout to determine the
    inital timeout use the core function that exists for exactly this
    purpose.
    
    As a side effect the "timeout-sec" device-tree property is recognized now
    (though currently unused in the omap device trees).
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 83efa1cbcff406f0305d4b227d356d6bdce8cb13
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Mon Apr 27 11:22:58 2015 +0200

    watchdog: omap: clearify device tree documentation
    
    ti,hwmods doesn't belong into the compatible section but is a property
    on it's own. Also reformat the section of required properties to match the
    usual style of dt binding documents.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Felipe Balbi <balbi@ti.com>
    Acked-by: Felipe Balbi <balbi@ti.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 336694a01dae7e788630f8043dae30337047b51b
Author: Baruch Siach <baruch@tkos.co.il>
Date:   Tue Mar 31 09:14:59 2015 +0300

    watchdog: digicolor: driver for Conexant Digicolor CX92755 SoC
    
    This commit add a driver for the watchdog functionality of the Conexant CX92755
    SoC, from the Digicolor series of SoCs. Of 8 system timers provided by the
    CX92755, the first one, timer A, can reset the chip when its counter reaches
    zero. This driver uses this capability to provide userspace with a standard
    watchdog, using the watchdog timer driver core framework. This driver also
    implements a reboot handler for the reboot(2) system call.
    
    The watchdog driver shares the timer registers with the CX92755 timer driver
    (drivers/clocksource/timer-digicolor.c). The timer driver, however, uses only
    timers other than A, so both drivers should coexist.
    
    Signed-off-by: Baruch Siach <baruch@tkos.co.il>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b0abc8ff75e25901fe4afcd62d5e4315df4a8138
Author: Baruch Siach <baruch@tkos.co.il>
Date:   Tue Mar 31 09:14:58 2015 +0300

    watchdog: digicolor: document device tree binding
    
    Add a device tree binding documentation to the watchdog hardware block on the
    Conexant CX92755 SoC. The CX92755 is from the Digicolor SoCs series. Other SoCs
    in that series may share the same hardware block.
    
    Signed-off-by: Baruch Siach <baruch@tkos.co.il>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit feccebe9a9a28f0feeb69b7995a8008478094337
Author: Ben Dooks <ben.dooks@codethink.co.uk>
Date:   Thu Mar 26 14:34:14 2015 +0000

    watchdog: at91sam9: use endian agnostic IO
    
    Use endian agnostic IO functions for the watchdog driver for when it
    is enabled on ATSAMA5D36 devices running in big endian.
    
    Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
    Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 79cb097676cf4fd424f0ea4df22877104401c5f9
Author: Lee Jones <lee.jones@linaro.org>
Date:   Tue May 12 13:58:13 2015 +0100

    watchdog: st_wdt: Update IP layout information to include Clocksource
    
    Initial submission adding support for this IP only included Watchdog and
    the Real-Time Clock.  Now the third (and final) device is enabled this
    trivial patch is required to update the comment in the Watchdog driver
    to encompass Clocksource.
    
    Signed-off-by: Lee Jones <lee.jones@linaro.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f27925a6c18d51768a4910445b53f896f36ec587
Author: Lee Jones <lee.jones@linaro.org>
Date:   Thu Apr 9 15:47:31 2015 +0100

    watchdog: st_wdt: Add new driver for ST's LPC Watchdog
    
    Signed-off-by: David Paris <david.paris@st.com>
    Signed-off-by: Lee Jones <lee.jones@linaro.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 6f48fdf3bb86a173655502f178f6972291c2c0c5
Author: Lee Jones <lee.jones@linaro.org>
Date:   Thu Apr 9 15:47:30 2015 +0100

    watchdog: bindings: Provide ST bindings for ST's LPC Watchdog device
    
    On current ST platforms the LPC controls a number of functions including
    Watchdog and Real Time Clock.  This patch provides the bindings used to
    configure LPC in Watchdog mode.
    
    Signed-off-by: Lee Jones <lee.jones@linaro.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 97faf05aa63683d288423230b26bb57c781b2edd
Author: Lee Jones <lee.jones@linaro.org>
Date:   Thu Apr 9 15:47:27 2015 +0100

    ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
    
    Signed-off-by: Lee Jones <lee.jones@linaro.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 08e525c02770792154e75fc029b756eb7e0d9abc
Author: Lee Jones <lee.jones@linaro.org>
Date:   Thu Apr 9 15:47:26 2015 +0100

    mfd: dt-bindings: Provide human readable defines for LPC mode choosing
    
    ST's Low Power Controller can currently operate in two supported modes;
    Watchdog and Real Time Clock.  These defines will aid engineers to easily
    identify the selected mode.
    
    Signed-off-by: Lee Jones <lee.jones@linaro.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt b/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
new file mode 100644
index 0000000..a882967
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
@@ -0,0 +1,25 @@
+Conexant Digicolor SoCs Watchdog timer
+
+The watchdog functionality in Conexant Digicolor SoCs relies on the so called
+"Agent Communication" block. This block includes the eight programmable system
+timer counters. The first timer (called "Timer A") is the only one that can be
+used as watchdog.
+
+Required properties:
+
+- compatible : Should be "cnxt,cx92755-wdt"
+- reg : Specifies base physical address and size of the registers
+- clocks : phandle; specifies the clock that drives the timer
+
+Optional properties:
+
+- timeout-sec : Contains the watchdog timeout in seconds
+
+Example:
+
+	watchdog@f0000fc0 {
+		compatible = "cnxt,cx92755-wdt";
+		reg = <0xf0000fc0 0x8>;
+		clocks = <&main_clk>;
+		timeout-sec = <15>;
+	};
diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
index c227970..1fa20e4 100644
--- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
@@ -1,10 +1,11 @@
 TI Watchdog Timer (WDT) Controller for OMAP
 
 Required properties:
-compatible:
-- "ti,omap3-wdt" for OMAP3
-- "ti,omap4-wdt" for OMAP4
-- ti,hwmods: Name of the hwmod associated to the WDT
+- compatible : "ti,omap3-wdt" for OMAP3 or "ti,omap4-wdt" for OMAP4
+- ti,hwmods : Name of the hwmod associated to the WDT
+
+Optional properties:
+- timeout-sec : default watchdog timeout in seconds
 
 Examples:
 
diff --git a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
new file mode 100644
index 0000000..388c88a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
@@ -0,0 +1,38 @@
+STMicroelectronics Low Power Controller (LPC) - Watchdog
+========================================================
+
+LPC currently supports Watchdog OR Real Time Clock functionality.
+
+[See: ../rtc/rtc-st-lpc.txt for RTC options]
+
+Required properties
+
+- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
+				  "st,stih415-lpc" "st,stid127-lpc"
+- reg		: LPC registers base address + size
+- interrupts    : LPC interrupt line number and associated flags
+- clocks	: Clock used by LPC device (See: ../clock/clock-bindings.txt)
+- st,lpc-mode	: The LPC can run either one of two modes ST_LPC_MODE_RTC [0] or
+		  ST_LPC_MODE_WDT [1].  One (and only one) mode must be
+		  selected.
+
+Required properties [watchdog mode]
+
+- st,syscfg	: Phandle to syscfg node used to enable watchdog and configure
+		  CPU reset type.
+- timeout-sec	: Watchdog timeout in seconds
+
+Optional properties [watchdog mode]
+
+- st,warm-reset	: If present reset type will be 'warm' - if not it will be cold
+
+Example:
+	lpc@fde05000 {
+		compatible	= "st,stih407-lpc";
+		reg		= <0xfde05000 0x1000>;
+		clocks 		= <&clk_s_d3_flexgen CLK_LPC_0>;
+		st,syscfg	= <&syscfg_core>;
+		timeout-sec	= <120>;
+		st,lpc-mode	= <ST_LPC_MODE_WDT>;
+		st,warm-reset;
+	};
diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index a0438f3..d8b0d33 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -36,6 +36,10 @@ The watchdog_unregister_device routine deregisters a registered watchdog timer
 device. The parameter of this routine is the pointer to the registered
 watchdog_device structure.
 
+The watchdog subsystem includes an registration deferral mechanism,
+which allows you to register an watchdog as early as you wish during
+the boot process.
+
 The watchdog device structure looks like this:
 
 struct watchdog_device {
@@ -52,6 +56,7 @@ struct watchdog_device {
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
+	struct list_head deferred;
 };
 
 It contains following fields:
@@ -80,6 +85,8 @@ It contains following fields:
   information about the status of the device (Like: is the watchdog timer
   running/active, is the nowayout bit set, is the device opened via
   the /dev/watchdog interface or not, ...).
+* deferred: entry in wtd_deferred_reg_list which is used to
+  register early initialized watchdogs.
 
 The list of watchdog operations is defined as:
 
diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 692791c..9f9ec9f 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -208,6 +208,9 @@ nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
 omap_wdt:
 timer_margin: initial watchdog timeout (in seconds)
+early_enable: Watchdog is started on module insertion (default=0
+nowayout: Watchdog cannot be stopped once started
+	(default=kernel config parameter)
 -------------------------------------------------
 orion_wdt:
 heartbeat: Initial watchdog heartbeat in seconds
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fbbb191..1e8c00c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -337,6 +337,7 @@ CONFIG_WATCHDOG=y
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MESON_WATCHDOG=y
 CONFIG_MFD_AS3711=y
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e5e7c55..241fafd 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1,3 +1,4 @@
+
 #
 # Watchdog device configuration
 #
@@ -96,6 +97,15 @@ config DA9063_WATCHDOG
 
 	  This driver can be built as a module. The module name is da9063_wdt.
 
+config DA9062_WATCHDOG
+	tristate "Dialog DA9062 Watchdog"
+	depends on MFD_DA9062
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the DA9062 PMIC.
+
+	  This driver can be built as a module. The module name is da9062_wdt.
+
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
 	depends on OF_GPIO
@@ -104,6 +114,17 @@ config GPIO_WATCHDOG
 	  If you say yes here you get support for watchdog device
 	  controlled through GPIO-line.
 
+config GPIO_WATCHDOG_ARCH_INITCALL
+	bool "Register the watchdog as early as possible"
+	depends on GPIO_WATCHDOG=y
+	help
+	  In some situations, the default initcall level (module_init)
+	  in not early enough in the boot process to avoid the watchdog
+	  to be triggered.
+	  If you say yes here, the initcall level would be raised to
+	  arch_initcall.
+	  If in doubt, say N.
+
 config MENF21BMC_WATCHDOG
 	tristate "MEN 14F021P00 BMC Watchdog"
 	depends on MFD_MENF21BMC
@@ -169,6 +190,7 @@ config AT91SAM9X_WATCHDOG
 
 config CADENCE_WATCHDOG
 	tristate "Cadence Watchdog Timer"
+	depends on HAS_IOMEM
 	select WATCHDOG_CORE
 	help
 	  Say Y here if you want to include support for the watchdog
@@ -408,7 +430,7 @@ config TS72XX_WATCHDOG
 
 config MAX63XX_WATCHDOG
 	tristate "Max63xx watchdog"
-	depends on ARM && HAS_IOMEM
+	depends on HAS_IOMEM
 	select WATCHDOG_CORE
 	help
 	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
@@ -470,6 +492,18 @@ config SIRFSOC_WATCHDOG
 	  Support for CSR SiRFprimaII and SiRFatlasVI watchdog. When
 	  the watchdog triggers the system will be reset.
 
+config ST_LPC_WATCHDOG
+	tristate "STMicroelectronics LPC Watchdog"
+	depends on ARCH_STI
+	depends on OF
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include STMicroelectronics Low Power Controller
+	  (LPC) based Watchdog timer support.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called st_lpc_wdt.
+
 config TEGRA_WATCHDOG
 	tristate "Tegra watchdog"
 	depends on (ARCH_TEGRA || COMPILE_TEST) && HAS_IOMEM
@@ -514,6 +548,16 @@ config MEDIATEK_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called mtk_wdt.
 
+config DIGICOLOR_WATCHDOG
+	tristate "Conexant Digicolor SoCs watchdog support"
+	depends on ARCH_DIGICOLOR
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in Conexant Digicolor SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called digicolor_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
@@ -1343,7 +1387,7 @@ config BOOKE_WDT_DEFAULT_TIMEOUT
 config MEN_A21_WDT
        tristate "MEN A21 VME CPU Carrier Board Watchdog Timer"
        select WATCHDOG_CORE
-       depends on GPIOLIB
+       depends on GPIOLIB || COMPILE_TEST
        help
         Watchdog driver for MEN A21 VMEbus CPU Carrier Boards.
 
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 5c19294..59ea9a1 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -59,11 +59,13 @@ obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
 obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
 obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
 obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
+obj-$(CONFIG_ST_LPC_WATCHDOG) += st_lpc_wdt.o
 obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
 obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
 obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
 obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
+obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
@@ -179,6 +181,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 # Architecture Independent
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
+obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
 obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
 obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 1443b3c..e4698f7 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -40,9 +40,9 @@
 #define DRV_NAME "AT91SAM9 Watchdog"
 
 #define wdt_read(wdt, field) \
-	__raw_readl((wdt)->base + (field))
+	readl_relaxed((wdt)->base + (field))
 #define wdt_write(wtd, field, val) \
-	__raw_writel((val), (wdt)->base + (field))
+	writel_relaxed((val), (wdt)->base + (field))
 
 /* AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
  * use this to convert a watchdog
diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
new file mode 100644
index 0000000..b3a870c
--- /dev/null
+++ b/drivers/watchdog/da9062_wdt.c
@@ -0,0 +1,253 @@
+/*
+ * da9062_wdt.c - WDT device driver for DA9062
+ * Copyright (C) 2015  Dialog Semiconductor Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/mfd/da9062/registers.h>
+#include <linux/mfd/da9062/core.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
+#define DA9062_TWDSCALE_DISABLE		0
+#define DA9062_TWDSCALE_MIN		1
+#define DA9062_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
+#define DA9062_WDT_MIN_TIMEOUT		wdt_timeout[DA9062_TWDSCALE_MIN]
+#define DA9062_WDT_MAX_TIMEOUT		wdt_timeout[DA9062_TWDSCALE_MAX]
+#define DA9062_WDG_DEFAULT_TIMEOUT	wdt_timeout[DA9062_TWDSCALE_MAX-1]
+#define DA9062_RESET_PROTECTION_MS	300
+
+struct da9062_watchdog {
+	struct da9062 *hw;
+	struct watchdog_device wdtdev;
+	unsigned long j_time_stamp;
+};
+
+static void da9062_set_window_start(struct da9062_watchdog *wdt)
+{
+	wdt->j_time_stamp = jiffies;
+}
+
+static void da9062_apply_window_protection(struct da9062_watchdog *wdt)
+{
+	unsigned long delay = msecs_to_jiffies(DA9062_RESET_PROTECTION_MS);
+	unsigned long timeout = wdt->j_time_stamp + delay;
+	unsigned long now = jiffies;
+	unsigned int diff_ms;
+
+	/* if time-limit has not elapsed then wait for remainder */
+	if (time_before(now, timeout)) {
+		diff_ms = jiffies_to_msecs(timeout-now);
+		dev_dbg(wdt->hw->dev,
+			"Kicked too quickly. Delaying %u msecs\n", diff_ms);
+		msleep(diff_ms);
+	}
+}
+
+static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
+{
+	unsigned int i;
+
+	for (i = DA9062_TWDSCALE_MIN; i <= DA9062_TWDSCALE_MAX; i++) {
+		if (wdt_timeout[i] >= secs)
+			return i;
+	}
+
+	return DA9062_TWDSCALE_MAX;
+}
+
+static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
+{
+	int ret;
+
+	da9062_apply_window_protection(wdt);
+
+	ret = regmap_update_bits(wdt->hw->regmap,
+			   DA9062AA_CONTROL_F,
+			   DA9062AA_WATCHDOG_MASK,
+			   DA9062AA_WATCHDOG_MASK);
+
+	da9062_set_window_start(wdt);
+
+	return ret;
+}
+
+static int da9062_wdt_update_timeout_register(struct da9062_watchdog *wdt,
+					      unsigned int regval)
+{
+	struct da9062 *chip = wdt->hw;
+	int ret;
+
+	ret = da9062_reset_watchdog_timer(wdt);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(chip->regmap,
+				  DA9062AA_CONTROL_D,
+				  DA9062AA_TWDSCALE_MASK,
+				  regval);
+}
+
+static int da9062_wdt_start(struct watchdog_device *wdd)
+{
+	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int selector;
+	int ret;
+
+	selector = da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
+	ret = da9062_wdt_update_timeout_register(wdt, selector);
+	if (ret)
+		dev_err(wdt->hw->dev, "Watchdog failed to start (err = %d)\n",
+			ret);
+
+	return ret;
+}
+
+static int da9062_wdt_stop(struct watchdog_device *wdd)
+{
+	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = da9062_reset_watchdog_timer(wdt);
+	if (ret) {
+		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(wdt->hw->regmap,
+				 DA9062AA_CONTROL_D,
+				 DA9062AA_TWDSCALE_MASK,
+				 DA9062_TWDSCALE_DISABLE);
+	if (ret)
+		dev_err(wdt->hw->dev, "Watchdog failed to stop (err = %d)\n",
+			ret);
+
+	return ret;
+}
+
+static int da9062_wdt_ping(struct watchdog_device *wdd)
+{
+	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = da9062_reset_watchdog_timer(wdt);
+	if (ret)
+		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n",
+			ret);
+
+	return ret;
+}
+
+static int da9062_wdt_set_timeout(struct watchdog_device *wdd,
+				  unsigned int timeout)
+{
+	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int selector;
+	int ret;
+
+	selector = da9062_wdt_timeout_to_sel(timeout);
+	ret = da9062_wdt_update_timeout_register(wdt, selector);
+	if (ret)
+		dev_err(wdt->hw->dev, "Failed to set watchdog timeout (err = %d)\n",
+			ret);
+	else
+		wdd->timeout = wdt_timeout[selector];
+
+	return ret;
+}
+
+static const struct watchdog_info da9062_watchdog_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "DA9062 WDT",
+};
+
+static const struct watchdog_ops da9062_watchdog_ops = {
+	.owner = THIS_MODULE,
+	.start = da9062_wdt_start,
+	.stop = da9062_wdt_stop,
+	.ping = da9062_wdt_ping,
+	.set_timeout = da9062_wdt_set_timeout,
+};
+
+static int da9062_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct da9062 *chip;
+	struct da9062_watchdog *wdt;
+
+	chip = dev_get_drvdata(pdev->dev.parent);
+	if (!chip)
+		return -EINVAL;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->hw = chip;
+
+	wdt->wdtdev.info = &da9062_watchdog_info;
+	wdt->wdtdev.ops = &da9062_watchdog_ops;
+	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
+	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
+	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
+	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+
+	watchdog_set_drvdata(&wdt->wdtdev, wdt);
+	dev_set_drvdata(&pdev->dev, wdt);
+
+	ret = watchdog_register_device(&wdt->wdtdev);
+	if (ret < 0) {
+		dev_err(wdt->hw->dev,
+			"watchdog registration failed (%d)\n", ret);
+		return ret;
+	}
+
+	da9062_set_window_start(wdt);
+
+	ret = da9062_wdt_ping(&wdt->wdtdev);
+	if (ret < 0)
+		watchdog_unregister_device(&wdt->wdtdev);
+
+	return ret;
+}
+
+static int da9062_wdt_remove(struct platform_device *pdev)
+{
+	struct da9062_watchdog *wdt = dev_get_drvdata(&pdev->dev);
+
+	watchdog_unregister_device(&wdt->wdtdev);
+	return 0;
+}
+
+static struct platform_driver da9062_wdt_driver = {
+	.probe = da9062_wdt_probe,
+	.remove = da9062_wdt_remove,
+	.driver = {
+		.name = "da9062-watchdog",
+	},
+};
+module_platform_driver(da9062_wdt_driver);
+
+MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
+MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:da9062-watchdog");
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
new file mode 100644
index 0000000..31d8e49
--- /dev/null
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -0,0 +1,205 @@
+/*
+ * Watchdog driver for Conexant Digicolor
+ *
+ * Copyright (C) 2015 Paradox Innovation Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+
+#define TIMER_A_CONTROL		0
+#define TIMER_A_COUNT		4
+
+#define TIMER_A_ENABLE_COUNT	BIT(0)
+#define TIMER_A_ENABLE_WATCHDOG	BIT(1)
+
+struct dc_wdt {
+	void __iomem		*base;
+	struct clk		*clk;
+	struct notifier_block	restart_handler;
+	spinlock_t		lock;
+};
+
+static unsigned timeout;
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
+
+static void dc_wdt_set(struct dc_wdt *wdt, u32 ticks)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdt->lock, flags);
+
+	writel_relaxed(0, wdt->base + TIMER_A_CONTROL);
+	writel_relaxed(ticks, wdt->base + TIMER_A_COUNT);
+	writel_relaxed(TIMER_A_ENABLE_COUNT | TIMER_A_ENABLE_WATCHDOG,
+		       wdt->base + TIMER_A_CONTROL);
+
+	spin_unlock_irqrestore(&wdt->lock, flags);
+}
+
+static int dc_restart_handler(struct notifier_block *this, unsigned long mode,
+			      void *cmd)
+{
+	struct dc_wdt *wdt = container_of(this, struct dc_wdt, restart_handler);
+
+	dc_wdt_set(wdt, 1);
+	/* wait for reset to assert... */
+	mdelay(500);
+
+	return NOTIFY_DONE;
+}
+
+static int dc_wdt_start(struct watchdog_device *wdog)
+{
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
+
+	dc_wdt_set(wdt, wdog->timeout * clk_get_rate(wdt->clk));
+
+	return 0;
+}
+
+static int dc_wdt_stop(struct watchdog_device *wdog)
+{
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
+
+	writel_relaxed(0, wdt->base + TIMER_A_CONTROL);
+
+	return 0;
+}
+
+static int dc_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
+{
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
+
+	dc_wdt_set(wdt, t * clk_get_rate(wdt->clk));
+	wdog->timeout = t;
+
+	return 0;
+}
+
+static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
+	uint32_t count = readl_relaxed(wdt->base + TIMER_A_COUNT);
+
+	return count / clk_get_rate(wdt->clk);
+}
+
+static struct watchdog_ops dc_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= dc_wdt_start,
+	.stop		= dc_wdt_stop,
+	.set_timeout	= dc_wdt_set_timeout,
+	.get_timeleft	= dc_wdt_get_timeleft,
+};
+
+static struct watchdog_info dc_wdt_info = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE
+			| WDIOF_KEEPALIVEPING,
+	.identity	= "Conexant Digicolor Watchdog",
+};
+
+static struct watchdog_device dc_wdt_wdd = {
+	.info		= &dc_wdt_info,
+	.ops		= &dc_wdt_ops,
+	.min_timeout	= 1,
+};
+
+static int dc_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct dc_wdt *wdt;
+	int ret;
+
+	wdt = devm_kzalloc(dev, sizeof(struct dc_wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, wdt);
+
+	wdt->base = of_iomap(np, 0);
+	if (!wdt->base) {
+		dev_err(dev, "Failed to remap watchdog regs");
+		return -ENODEV;
+	}
+
+	wdt->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(wdt->clk)) {
+		ret = PTR_ERR(wdt->clk);
+		goto err_iounmap;
+	}
+	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
+	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
+
+	spin_lock_init(&wdt->lock);
+
+	watchdog_set_drvdata(&dc_wdt_wdd, wdt);
+	watchdog_init_timeout(&dc_wdt_wdd, timeout, dev);
+	ret = watchdog_register_device(&dc_wdt_wdd);
+	if (ret) {
+		dev_err(dev, "Failed to register watchdog device");
+		goto err_iounmap;
+	}
+
+	wdt->restart_handler.notifier_call = dc_restart_handler;
+	wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&wdt->restart_handler);
+	if (ret)
+		dev_warn(&pdev->dev, "cannot register restart handler\n");
+
+	return 0;
+
+err_iounmap:
+	iounmap(wdt->base);
+	return ret;
+}
+
+static int dc_wdt_remove(struct platform_device *pdev)
+{
+	struct dc_wdt *wdt = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&wdt->restart_handler);
+	watchdog_unregister_device(&dc_wdt_wdd);
+	iounmap(wdt->base);
+
+	return 0;
+}
+
+static void dc_wdt_shutdown(struct platform_device *pdev)
+{
+	dc_wdt_stop(&dc_wdt_wdd);
+}
+
+static const struct of_device_id dc_wdt_of_match[] = {
+	{ .compatible = "cnxt,cx92755-wdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dc_wdt_of_match);
+
+static struct platform_driver dc_wdt_driver = {
+	.probe		= dc_wdt_probe,
+	.remove		= dc_wdt_remove,
+	.shutdown	= dc_wdt_shutdown,
+	.driver = {
+		.name =		"digicolor-wdt",
+		.of_match_table = dc_wdt_of_match,
+	},
+};
+module_platform_driver(dc_wdt_driver);
+
+MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
+MODULE_DESCRIPTION("Driver for Conexant Digicolor watchdog timer");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index d0bb949..6ea0634 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -35,7 +35,6 @@
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
-#include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
@@ -61,7 +60,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 #define WDT_TIMEOUT		(HZ / 2)
 
 static struct {
-	spinlock_t		lock;
 	void __iomem		*regs;
 	struct clk		*clk;
 	unsigned long		in_use;
@@ -177,7 +175,6 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 	/* Make sure we don't get unloaded. */
 	__module_get(THIS_MODULE);
 
-	spin_lock(&dw_wdt.lock);
 	if (!dw_wdt_is_enabled()) {
 		/*
 		 * The watchdog is not currently enabled. Set the timeout to
@@ -190,8 +187,6 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 
 	dw_wdt_set_next_heartbeat();
 
-	spin_unlock(&dw_wdt.lock);
-
 	return nonseekable_open(inode, filp);
 }
 
@@ -220,6 +215,7 @@ static ssize_t dw_wdt_write(struct file *filp, const char __user *buf,
 	}
 
 	dw_wdt_set_next_heartbeat();
+	dw_wdt_keepalive();
 	mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
 
 	return len;
@@ -348,8 +344,6 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	spin_lock_init(&dw_wdt.lock);
-
 	ret = misc_register(&dw_wdt_miscdev);
 	if (ret)
 		goto out_disable_clk;
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index cbc313d..1687cc2 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -267,7 +267,16 @@ static struct platform_driver gpio_wdt_driver = {
 	.probe	= gpio_wdt_probe,
 	.remove	= gpio_wdt_remove,
 };
+
+#ifdef CONFIG_GPIO_WATCHDOG_ARCH_INITCALL
+static int __init gpio_wdt_init(void)
+{
+	return platform_driver_register(&gpio_wdt_driver);
+}
+arch_initcall(gpio_wdt_init);
+#else
 module_platform_driver(gpio_wdt_driver);
+#endif
 
 MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
 MODULE_DESCRIPTION("GPIO Watchdog");
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ada3e44..286369d 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -588,7 +588,7 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
 {
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
-	int new_margin;
+	int new_margin, options;
 	int ret = -ENOTTY;
 
 	switch (cmd) {
@@ -608,6 +608,20 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
 		ret = 0;
 		break;
 
+	case WDIOC_SETOPTIONS:
+		ret = get_user(options, p);
+		if (ret)
+			break;
+
+		if (options & WDIOS_DISABLECARD)
+			hpwdt_stop();
+
+		if (options & WDIOS_ENABLECARD) {
+			hpwdt_start();
+			hpwdt_ping();
+		}
+		break;
+
 	case WDIOC_SETTIMEOUT:
 		ret = get_user(new_margin, p);
 		if (ret)
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 0deaa4f..0f73621 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -9,6 +9,35 @@
  *
  * Based on drivers/watchdog/sunxi_wdt.c Copyright (c) 2013 Carlo Caione
  *                                                     2012 Henrik Nordstrom
+ *
+ * Notes
+ * -----
+ * The timeout value is rounded to the next power of two clock cycles.
+ * This is configured using the PDC_WDT_CONFIG register, according to this
+ * formula:
+ *
+ *     timeout = 2^(delay + 1) clock cycles
+ *
+ * Where 'delay' is the value written in PDC_WDT_CONFIG register.
+ *
+ * Therefore, the hardware only allows to program watchdog timeouts, expressed
+ * as a power of two number of watchdog clock cycles. The current implementation
+ * guarantees that the actual watchdog timeout will be _at least_ the value
+ * programmed in the imgpdg_wdt driver.
+ *
+ * The following table shows how the user-configured timeout relates
+ * to the actual hardware timeout (watchdog clock @ 40000 Hz):
+ *
+ * input timeout | WD_DELAY | actual timeout
+ * -----------------------------------
+ *      10       |   18     |  13 seconds
+ *      20       |   19     |  26 seconds
+ *      30       |   20     |  52 seconds
+ *      60       |   21     |  104 seconds
+ *
+ * Albeit coarse, this granularity would suffice most watchdog uses.
+ * If the platform allows it, the user should be able to change the watchdog
+ * clock rate and achieve a finer timeout granularity.
  */
 
 #include <linux/clk.h>
@@ -16,6 +45,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
 
@@ -42,7 +72,7 @@
 #define PDC_WDT_MIN_TIMEOUT		1
 #define PDC_WDT_DEF_TIMEOUT		64
 
-static int heartbeat = PDC_WDT_DEF_TIMEOUT;
+static int heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
 	"(default=" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
@@ -57,6 +87,7 @@ struct pdc_wdt_dev {
 	struct clk *wdt_clk;
 	struct clk *sys_clk;
 	void __iomem *base;
+	struct notifier_block restart_handler;
 };
 
 static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
@@ -84,18 +115,24 @@ static int pdc_wdt_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static void __pdc_wdt_set_timeout(struct pdc_wdt_dev *wdt)
+{
+	unsigned long clk_rate = clk_get_rate(wdt->wdt_clk);
+	unsigned int val;
+
+	val = readl(wdt->base + PDC_WDT_CONFIG) & ~PDC_WDT_CONFIG_DELAY_MASK;
+	val |= order_base_2(wdt->wdt_dev.timeout * clk_rate) - 1;
+	writel(val, wdt->base + PDC_WDT_CONFIG);
+}
+
 static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
 			       unsigned int new_timeout)
 {
-	unsigned int val;
 	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
-	unsigned long clk_rate = clk_get_rate(wdt->wdt_clk);
 
 	wdt->wdt_dev.timeout = new_timeout;
 
-	val = readl(wdt->base + PDC_WDT_CONFIG) & ~PDC_WDT_CONFIG_DELAY_MASK;
-	val |= order_base_2(new_timeout * clk_rate) - 1;
-	writel(val, wdt->base + PDC_WDT_CONFIG);
+	__pdc_wdt_set_timeout(wdt);
 
 	return 0;
 }
@@ -106,6 +143,8 @@ static int pdc_wdt_start(struct watchdog_device *wdt_dev)
 	unsigned int val;
 	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
 
+	__pdc_wdt_set_timeout(wdt);
+
 	val = readl(wdt->base + PDC_WDT_CONFIG);
 	val |= PDC_WDT_CONFIG_ENABLE;
 	writel(val, wdt->base + PDC_WDT_CONFIG);
@@ -128,8 +167,21 @@ static const struct watchdog_ops pdc_wdt_ops = {
 	.set_timeout	= pdc_wdt_set_timeout,
 };
 
+static int pdc_wdt_restart(struct notifier_block *this, unsigned long mode,
+			   void *cmd)
+{
+	struct pdc_wdt_dev *wdt = container_of(this, struct pdc_wdt_dev,
+					       restart_handler);
+
+	/* Assert SOFT_RESET */
+	writel(0x1, wdt->base + PDC_WDT_SOFT_RESET);
+
+	return NOTIFY_OK;
+}
+
 static int pdc_wdt_probe(struct platform_device *pdev)
 {
+	u64 div;
 	int ret, val;
 	unsigned long clk_rate;
 	struct resource *res;
@@ -189,16 +241,15 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 
 	pdc_wdt->wdt_dev.info = &pdc_wdt_info;
 	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
-	pdc_wdt->wdt_dev.max_timeout = 1 << PDC_WDT_CONFIG_DELAY_MASK;
+
+	div = 1ULL << (PDC_WDT_CONFIG_DELAY_MASK + 1);
+	do_div(div, clk_rate);
+	pdc_wdt->wdt_dev.max_timeout = div;
+	pdc_wdt->wdt_dev.timeout = PDC_WDT_DEF_TIMEOUT;
 	pdc_wdt->wdt_dev.parent = &pdev->dev;
 	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
 
-	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
-	if (ret < 0) {
-		pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
-		dev_warn(&pdev->dev,
-			 "Initial timeout out of range! setting max timeout\n");
-	}
+	watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
 
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
 
@@ -238,6 +289,13 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_wdt_clk;
 
+	pdc_wdt->restart_handler.notifier_call = pdc_wdt_restart;
+	pdc_wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&pdc_wdt->restart_handler);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to register restart handler: %d\n",
+			 ret);
+
 	return 0;
 
 disable_wdt_clk:
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5e6d808..0bb1a1d 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -166,6 +166,8 @@ static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
+	wdog->timeout = new_timeout;
+
 	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
 			   WDOG_SEC_TO_COUNT(new_timeout));
 	return 0;
@@ -256,8 +258,11 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	wdog->ops		= &imx2_wdt_ops;
 	wdog->min_timeout	= 1;
 	wdog->max_timeout	= IMX2_WDT_MAX_TIME;
+	wdog->parent		= &pdev->dev;
 
-	clk_prepare_enable(wdev->clk);
+	ret = clk_prepare_enable(wdev->clk);
+	if (ret)
+		return ret;
 
 	regmap_read(wdev->regmap, IMX2_WDT_WRSR, &val);
 	wdog->bootstatus = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
@@ -286,7 +291,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	ret = watchdog_register_device(wdog);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register watchdog device\n");
-		return ret;
+		goto disable_clk;
 	}
 
 	wdev->restart_handler.notifier_call = imx2_restart_handler;
@@ -299,6 +304,10 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		 wdog->timeout, nowayout);
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(wdev->clk);
+	return ret;
 }
 
 static int __exit imx2_wdt_remove(struct platform_device *pdev)
@@ -362,8 +371,11 @@ static int imx2_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdog = dev_get_drvdata(dev);
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+	int ret;
 
-	clk_prepare_enable(wdev->clk);
+	ret = clk_prepare_enable(wdev->clk);
+	if (ret)
+		return ret;
 
 	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
 		/*
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 08da311..f36ca4b 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -39,10 +39,22 @@ static bool nowayout  = WATCHDOG_NOWAYOUT;
 #define MAX6369_WDSET	(7 << 0)
 #define MAX6369_WDI	(1 << 3)
 
-static DEFINE_SPINLOCK(io_lock);
+#define MAX6369_WDSET_DISABLED	3
 
 static int nodelay;
-static void __iomem	*wdt_base;
+
+struct max63xx_wdt {
+	struct watchdog_device wdd;
+	const struct max63xx_timeout *timeout;
+
+	/* memory mapping */
+	void __iomem *base;
+	spinlock_t lock;
+
+	/* WDI and WSET bits write access routines */
+	void (*ping)(struct max63xx_wdt *wdt);
+	void (*set)(struct max63xx_wdt *wdt, u8 set);
+};
 
 /*
  * The timeout values used are actually the absolute minimum the chip
@@ -59,25 +71,25 @@ static void __iomem	*wdt_base;
 
 /* Timeouts in second */
 struct max63xx_timeout {
-	u8 wdset;
-	u8 tdelay;
-	u8 twd;
+	const u8 wdset;
+	const u8 tdelay;
+	const u8 twd;
 };
 
-static struct max63xx_timeout max6369_table[] = {
+static const struct max63xx_timeout max6369_table[] = {
 	{ 5,  1,  1 },
 	{ 6, 10, 10 },
 	{ 7, 60, 60 },
 	{ },
 };
 
-static struct max63xx_timeout max6371_table[] = {
+static const struct max63xx_timeout max6371_table[] = {
 	{ 6, 60,  3 },
 	{ 7, 60, 60 },
 	{ },
 };
 
-static struct max63xx_timeout max6373_table[] = {
+static const struct max63xx_timeout max6373_table[] = {
 	{ 2, 60,  1 },
 	{ 5,  0,  1 },
 	{ 1,  3,  3 },
@@ -86,8 +98,6 @@ static struct max63xx_timeout max6373_table[] = {
 	{ },
 };
 
-static struct max63xx_timeout *current_timeout;
-
 static struct max63xx_timeout *
 max63xx_select_timeout(struct max63xx_timeout *table, int value)
 {
@@ -108,59 +118,32 @@ max63xx_select_timeout(struct max63xx_timeout *table, int value)
 
 static int max63xx_wdt_ping(struct watchdog_device *wdd)
 {
-	u8 val;
-
-	spin_lock(&io_lock);
+	struct max63xx_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	val = __raw_readb(wdt_base);
-
-	__raw_writeb(val | MAX6369_WDI, wdt_base);
-	__raw_writeb(val & ~MAX6369_WDI, wdt_base);
-
-	spin_unlock(&io_lock);
+	wdt->ping(wdt);
 	return 0;
 }
 
 static int max63xx_wdt_start(struct watchdog_device *wdd)
 {
-	struct max63xx_timeout *entry = watchdog_get_drvdata(wdd);
-	u8 val;
+	struct max63xx_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	spin_lock(&io_lock);
-
-	val = __raw_readb(wdt_base);
-	val &= ~MAX6369_WDSET;
-	val |= entry->wdset;
-	__raw_writeb(val, wdt_base);
-
-	spin_unlock(&io_lock);
+	wdt->set(wdt, wdt->timeout->wdset);
 
 	/* check for a edge triggered startup */
-	if (entry->tdelay == 0)
-		max63xx_wdt_ping(wdd);
+	if (wdt->timeout->tdelay == 0)
+		wdt->ping(wdt);
 	return 0;
 }
 
 static int max63xx_wdt_stop(struct watchdog_device *wdd)
 {
-	u8 val;
+	struct max63xx_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	spin_lock(&io_lock);
-
-	val = __raw_readb(wdt_base);
-	val &= ~MAX6369_WDSET;
-	val |= 3;
-	__raw_writeb(val, wdt_base);
-
-	spin_unlock(&io_lock);
+	wdt->set(wdt, MAX6369_WDSET_DISABLED);
 	return 0;
 }
 
-static const struct watchdog_info max63xx_wdt_info = {
-	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-	.identity = "max63xx Watchdog",
-};
-
 static const struct watchdog_ops max63xx_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = max63xx_wdt_start,
@@ -168,53 +151,108 @@ static const struct watchdog_ops max63xx_wdt_ops = {
 	.ping = max63xx_wdt_ping,
 };
 
-static struct watchdog_device max63xx_wdt_dev = {
-	.info = &max63xx_wdt_info,
-	.ops = &max63xx_wdt_ops,
+static const struct watchdog_info max63xx_wdt_info = {
+	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "max63xx Watchdog",
 };
 
+static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
+{
+	u8 val;
+
+	spin_lock(&wdt->lock);
+
+	val = __raw_readb(wdt->base);
+
+	__raw_writeb(val | MAX6369_WDI, wdt->base);
+	__raw_writeb(val & ~MAX6369_WDI, wdt->base);
+
+	spin_unlock(&wdt->lock);
+}
+
+static void max63xx_mmap_set(struct max63xx_wdt *wdt, u8 set)
+{
+	u8 val;
+
+	spin_lock(&wdt->lock);
+
+	val = __raw_readb(wdt->base);
+	val &= ~MAX6369_WDSET;
+	val |= set & MAX6369_WDSET;
+	__raw_writeb(val, wdt->base);
+
+	spin_unlock(&wdt->lock);
+}
+
+static int max63xx_mmap_init(struct platform_device *p, struct max63xx_wdt *wdt)
+{
+	struct resource *mem = platform_get_resource(p, IORESOURCE_MEM, 0);
+
+	wdt->base = devm_ioremap_resource(&p->dev, mem);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	spin_lock_init(&wdt->lock);
+
+	wdt->ping = max63xx_mmap_ping;
+	wdt->set = max63xx_mmap_set;
+	return 0;
+}
+
 static int max63xx_wdt_probe(struct platform_device *pdev)
 {
-	struct resource	*wdt_mem;
+	struct max63xx_wdt *wdt;
 	struct max63xx_timeout *table;
+	int err;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
 
 	table = (struct max63xx_timeout *)pdev->id_entry->driver_data;
 
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat = DEFAULT_HEARTBEAT;
 
-	dev_info(&pdev->dev, "requesting %ds heartbeat\n", heartbeat);
-	current_timeout = max63xx_select_timeout(table, heartbeat);
-
-	if (!current_timeout) {
-		dev_err(&pdev->dev, "unable to satisfy heartbeat request\n");
+	wdt->timeout = max63xx_select_timeout(table, heartbeat);
+	if (!wdt->timeout) {
+		dev_err(&pdev->dev, "unable to satisfy %ds heartbeat request\n",
+			heartbeat);
 		return -EINVAL;
 	}
 
-	dev_info(&pdev->dev, "using %ds heartbeat with %ds initial delay\n",
-		 current_timeout->twd, current_timeout->tdelay);
+	err = max63xx_mmap_init(pdev, wdt);
+	if (err)
+		return err;
+
+	platform_set_drvdata(pdev, &wdt->wdd);
+	watchdog_set_drvdata(&wdt->wdd, wdt);
 
-	heartbeat = current_timeout->twd;
+	wdt->wdd.parent = &pdev->dev;
+	wdt->wdd.timeout = wdt->timeout->twd;
+	wdt->wdd.info = &max63xx_wdt_info;
+	wdt->wdd.ops = &max63xx_wdt_ops;
 
-	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt_base = devm_ioremap_resource(&pdev->dev, wdt_mem);
-	if (IS_ERR(wdt_base))
-		return PTR_ERR(wdt_base);
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
 
-	max63xx_wdt_dev.timeout = heartbeat;
-	watchdog_set_nowayout(&max63xx_wdt_dev, nowayout);
-	watchdog_set_drvdata(&max63xx_wdt_dev, current_timeout);
+	err = watchdog_register_device(&wdt->wdd);
+	if (err)
+		return err;
 
-	return watchdog_register_device(&max63xx_wdt_dev);
+	dev_info(&pdev->dev, "using %ds heartbeat with %ds initial delay\n",
+		 wdt->timeout->twd, wdt->timeout->tdelay);
+	return 0;
 }
 
 static int max63xx_wdt_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&max63xx_wdt_dev);
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(wdd);
 	return 0;
 }
 
-static struct platform_device_id max63xx_id_table[] = {
+static const struct platform_device_id max63xx_id_table[] = {
 	{ "max6369_wdt", (kernel_ulong_t)max6369_table, },
 	{ "max6370_wdt", (kernel_ulong_t)max6369_table, },
 	{ "max6371_wdt", (kernel_ulong_t)max6371_table, },
diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 96dbba9..d193a5e 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -208,14 +208,15 @@ static int a21_wdt_probe(struct platform_device *pdev)
 	else if (reset == 7)
 		a21_wdt.bootstatus |= WDIOF_EXTERN2;
 
+	drv->wdt = a21_wdt;
+	dev_set_drvdata(&pdev->dev, drv);
+
 	ret = watchdog_register_device(&a21_wdt);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register watchdog device\n");
 		goto err_register_wd;
 	}
 
-	dev_set_drvdata(&pdev->dev, drv);
-
 	dev_info(&pdev->dev, "MEN A21 watchdog timer driver enabled\n");
 
 	return 0;
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1e6be9e..de911c7 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -53,7 +53,15 @@ static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
 MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
 
+#define to_omap_wdt_dev(_wdog)	container_of(_wdog, struct omap_wdt_dev, wdog)
+
+static bool early_enable;
+module_param(early_enable, bool, 0);
+MODULE_PARM_DESC(early_enable,
+	"Watchdog is started on module insertion (default=0)");
+
 struct omap_wdt_dev {
+	struct watchdog_device wdog;
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
 	bool		omap_wdt_users;
@@ -123,7 +131,7 @@ static void omap_wdt_set_timer(struct omap_wdt_dev *wdev,
 
 static int omap_wdt_start(struct watchdog_device *wdog)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 	void __iomem *base = wdev->base;
 
 	mutex_lock(&wdev->lock);
@@ -132,6 +140,13 @@ static int omap_wdt_start(struct watchdog_device *wdog)
 
 	pm_runtime_get_sync(wdev->dev);
 
+	/*
+	 * Make sure the watchdog is disabled. This is unfortunately required
+	 * because writing to various registers with the watchdog running has no
+	 * effect.
+	 */
+	omap_wdt_disable(wdev);
+
 	/* initialize prescaler */
 	while (readl_relaxed(base + OMAP_WATCHDOG_WPS) & 0x01)
 		cpu_relax();
@@ -151,7 +166,7 @@ static int omap_wdt_start(struct watchdog_device *wdog)
 
 static int omap_wdt_stop(struct watchdog_device *wdog)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
 	mutex_lock(&wdev->lock);
 	omap_wdt_disable(wdev);
@@ -163,7 +178,7 @@ static int omap_wdt_stop(struct watchdog_device *wdog)
 
 static int omap_wdt_ping(struct watchdog_device *wdog)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
 	mutex_lock(&wdev->lock);
 	omap_wdt_reload(wdev);
@@ -175,7 +190,7 @@ static int omap_wdt_ping(struct watchdog_device *wdog)
 static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int timeout)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
 	mutex_lock(&wdev->lock);
 	omap_wdt_disable(wdev);
@@ -188,6 +203,16 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 	return 0;
 }
 
+static unsigned int omap_wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	void __iomem *base = wdev->base;
+	u32 value;
+
+	value = readl_relaxed(base + OMAP_WATCHDOG_CRR);
+	return GET_WCCR_SECS(value);
+}
+
 static const struct watchdog_info omap_wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity = "OMAP Watchdog",
@@ -199,21 +224,16 @@ static const struct watchdog_ops omap_wdt_ops = {
 	.stop		= omap_wdt_stop,
 	.ping		= omap_wdt_ping,
 	.set_timeout	= omap_wdt_set_timeout,
+	.get_timeleft	= omap_wdt_get_timeleft,
 };
 
 static int omap_wdt_probe(struct platform_device *pdev)
 {
 	struct omap_wd_timer_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct watchdog_device *omap_wdt;
 	struct resource *res;
 	struct omap_wdt_dev *wdev;
-	u32 rs;
 	int ret;
 
-	omap_wdt = devm_kzalloc(&pdev->dev, sizeof(*omap_wdt), GFP_KERNEL);
-	if (!omap_wdt)
-		return -ENOMEM;
-
 	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
 	if (!wdev)
 		return -ENOMEM;
@@ -229,35 +249,30 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdev->base))
 		return PTR_ERR(wdev->base);
 
-	omap_wdt->info	      = &omap_wdt_info;
-	omap_wdt->ops	      = &omap_wdt_ops;
-	omap_wdt->min_timeout = TIMER_MARGIN_MIN;
-	omap_wdt->max_timeout = TIMER_MARGIN_MAX;
+	wdev->wdog.info = &omap_wdt_info;
+	wdev->wdog.ops = &omap_wdt_ops;
+	wdev->wdog.min_timeout = TIMER_MARGIN_MIN;
+	wdev->wdog.max_timeout = TIMER_MARGIN_MAX;
 
-	if (timer_margin >= TIMER_MARGIN_MIN &&
-	    timer_margin <= TIMER_MARGIN_MAX)
-		omap_wdt->timeout = timer_margin;
-	else
-		omap_wdt->timeout = TIMER_MARGIN_DEFAULT;
+	if (watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev) < 0)
+		wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
 
-	watchdog_set_drvdata(omap_wdt, wdev);
-	watchdog_set_nowayout(omap_wdt, nowayout);
+	watchdog_set_nowayout(&wdev->wdog, nowayout);
 
-	platform_set_drvdata(pdev, omap_wdt);
+	platform_set_drvdata(pdev, wdev);
 
 	pm_runtime_enable(wdev->dev);
 	pm_runtime_get_sync(wdev->dev);
 
-	if (pdata && pdata->read_reset_sources)
-		rs = pdata->read_reset_sources();
-	else
-		rs = 0;
-	omap_wdt->bootstatus = (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
-				WDIOF_CARDRESET : 0;
+	if (pdata && pdata->read_reset_sources) {
+		u32 rs = pdata->read_reset_sources();
+		if (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT))
+			wdev->wdog.bootstatus = WDIOF_CARDRESET;
+	}
 
 	omap_wdt_disable(wdev);
 
-	ret = watchdog_register_device(omap_wdt);
+	ret = watchdog_register_device(&wdev->wdog);
 	if (ret) {
 		pm_runtime_disable(wdev->dev);
 		return ret;
@@ -265,17 +280,19 @@ static int omap_wdt_probe(struct platform_device *pdev)
 
 	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
-		omap_wdt->timeout);
+		wdev->wdog.timeout);
 
 	pm_runtime_put_sync(wdev->dev);
 
+	if (early_enable)
+		omap_wdt_start(&wdev->wdog);
+
 	return 0;
 }
 
 static void omap_wdt_shutdown(struct platform_device *pdev)
 {
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	mutex_lock(&wdev->lock);
 	if (wdev->omap_wdt_users) {
@@ -287,11 +304,10 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 
 static int omap_wdt_remove(struct platform_device *pdev)
 {
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(wdev->dev);
-	watchdog_unregister_device(wdog);
+	watchdog_unregister_device(&wdev->wdog);
 
 	return 0;
 }
@@ -306,8 +322,7 @@ static int omap_wdt_remove(struct platform_device *pdev)
 
 static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	mutex_lock(&wdev->lock);
 	if (wdev->omap_wdt_users) {
@@ -321,8 +336,7 @@ static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 
 static int omap_wdt_resume(struct platform_device *pdev)
 {
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	mutex_lock(&wdev->lock);
 	if (wdev->omap_wdt_users) {
diff --git a/drivers/watchdog/omap_wdt.h b/drivers/watchdog/omap_wdt.h
index 09b774c..42f31ec 100644
--- a/drivers/watchdog/omap_wdt.h
+++ b/drivers/watchdog/omap_wdt.h
@@ -50,5 +50,6 @@
 
 #define PTV			0	/* prescale */
 #define GET_WLDR_VAL(secs)	(0xffffffff - ((secs) * (32768/(1<<PTV))) + 1)
+#define GET_WCCR_SECS(val)	((0xffffffff - (val) + 1) / (32768/(1<<PTV)))
 
 #endif				/* _OMAP_WATCHDOG_H */
diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
new file mode 100644
index 0000000..6785afd
--- /dev/null
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -0,0 +1,344 @@
+/*
+ * ST's LPC Watchdog
+ *
+ * Copyright (C) 2014 STMicroelectronics -- All Rights Reserved
+ *
+ * Author: David Paris <david.paris@st.com> for STMicroelectronics
+ *         Lee Jones <lee.jones@linaro.org> for STMicroelectronics
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+#include <dt-bindings/mfd/st-lpc.h>
+
+/* Low Power Alarm */
+#define LPC_LPA_LSB_OFF			0x410
+#define LPC_LPA_START_OFF		0x418
+
+/* LPC as WDT */
+#define LPC_WDT_OFF			0x510
+
+static struct watchdog_device st_wdog_dev;
+
+struct st_wdog_syscfg {
+	unsigned int reset_type_reg;
+	unsigned int reset_type_mask;
+	unsigned int enable_reg;
+	unsigned int enable_mask;
+};
+
+struct st_wdog {
+	void __iomem *base;
+	struct device *dev;
+	struct regmap *regmap;
+	struct st_wdog_syscfg *syscfg;
+	struct clk *clk;
+	unsigned long clkrate;
+	bool warm_reset;
+};
+
+static struct st_wdog_syscfg stid127_syscfg = {
+	.reset_type_reg		= 0x004,
+	.reset_type_mask	= BIT(2),
+	.enable_reg		= 0x000,
+	.enable_mask		= BIT(2),
+};
+
+static struct st_wdog_syscfg stih415_syscfg = {
+	.reset_type_reg		= 0x0B8,
+	.reset_type_mask	= BIT(6),
+	.enable_reg		= 0x0B4,
+	.enable_mask		= BIT(7),
+};
+
+static struct st_wdog_syscfg stih416_syscfg = {
+	.reset_type_reg		= 0x88C,
+	.reset_type_mask	= BIT(6),
+	.enable_reg		= 0x888,
+	.enable_mask		= BIT(7),
+};
+
+static struct st_wdog_syscfg stih407_syscfg = {
+	.enable_reg		= 0x204,
+	.enable_mask		= BIT(19),
+};
+
+static const struct of_device_id st_wdog_match[] = {
+	{
+		.compatible = "st,stih407-lpc",
+		.data = &stih407_syscfg,
+	},
+	{
+		.compatible = "st,stih416-lpc",
+		.data = &stih416_syscfg,
+	},
+	{
+		.compatible = "st,stih415-lpc",
+		.data = &stih415_syscfg,
+	},
+	{
+		.compatible = "st,stid127-lpc",
+		.data = &stid127_syscfg,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_wdog_match);
+
+static void st_wdog_setup(struct st_wdog *st_wdog, bool enable)
+{
+	/* Type of watchdog reset - 0: Cold 1: Warm */
+	if (st_wdog->syscfg->reset_type_reg)
+		regmap_update_bits(st_wdog->regmap,
+				   st_wdog->syscfg->reset_type_reg,
+				   st_wdog->syscfg->reset_type_mask,
+				   st_wdog->warm_reset);
+
+	/* Mask/unmask watchdog reset */
+	regmap_update_bits(st_wdog->regmap,
+			   st_wdog->syscfg->enable_reg,
+			   st_wdog->syscfg->enable_mask,
+			   enable ? 0 : st_wdog->syscfg->enable_mask);
+}
+
+static void st_wdog_load_timer(struct st_wdog *st_wdog, unsigned int timeout)
+{
+	unsigned long clkrate = st_wdog->clkrate;
+
+	writel_relaxed(timeout * clkrate, st_wdog->base + LPC_LPA_LSB_OFF);
+	writel_relaxed(1, st_wdog->base + LPC_LPA_START_OFF);
+}
+
+static int st_wdog_start(struct watchdog_device *wdd)
+{
+	struct st_wdog *st_wdog = watchdog_get_drvdata(wdd);
+
+	writel_relaxed(1, st_wdog->base + LPC_WDT_OFF);
+
+	return 0;
+}
+
+static int st_wdog_stop(struct watchdog_device *wdd)
+{
+	struct st_wdog *st_wdog = watchdog_get_drvdata(wdd);
+
+	writel_relaxed(0, st_wdog->base + LPC_WDT_OFF);
+
+	return 0;
+}
+
+static int st_wdog_set_timeout(struct watchdog_device *wdd,
+			       unsigned int timeout)
+{
+	struct st_wdog *st_wdog = watchdog_get_drvdata(wdd);
+
+	wdd->timeout = timeout;
+	st_wdog_load_timer(st_wdog, timeout);
+
+	return 0;
+}
+
+static int st_wdog_keepalive(struct watchdog_device *wdd)
+{
+	struct st_wdog *st_wdog = watchdog_get_drvdata(wdd);
+
+	st_wdog_load_timer(st_wdog, wdd->timeout);
+
+	return 0;
+}
+
+static const struct watchdog_info st_wdog_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "ST LPC WDT",
+};
+
+static const struct watchdog_ops st_wdog_ops = {
+	.owner		= THIS_MODULE,
+	.start		= st_wdog_start,
+	.stop		= st_wdog_stop,
+	.ping		= st_wdog_keepalive,
+	.set_timeout	= st_wdog_set_timeout,
+};
+
+static struct watchdog_device st_wdog_dev = {
+	.info		= &st_wdog_info,
+	.ops		= &st_wdog_ops,
+};
+
+static int st_wdog_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct device_node *np = pdev->dev.of_node;
+	struct st_wdog *st_wdog;
+	struct regmap *regmap;
+	struct resource *res;
+	struct clk *clk;
+	void __iomem *base;
+	uint32_t mode;
+	int ret;
+
+	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
+	if (ret) {
+		dev_err(&pdev->dev, "An LPC mode must be provided\n");
+		return -EINVAL;
+	}
+
+	/* LPC can either run as a Clocksource or in RTC or WDT mode */
+	if (mode != ST_LPC_MODE_WDT)
+		return -ENODEV;
+
+	st_wdog = devm_kzalloc(&pdev->dev, sizeof(*st_wdog), GFP_KERNEL);
+	if (!st_wdog)
+		return -ENOMEM;
+
+	match = of_match_device(st_wdog_match, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "Couldn't match device\n");
+		return -ENODEV;
+	}
+	st_wdog->syscfg	= (struct st_wdog_syscfg *)match->data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(regmap)) {
+		dev_err(&pdev->dev, "No syscfg phandle specified\n");
+		return PTR_ERR(regmap);
+	}
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Unable to request clock\n");
+		return PTR_ERR(clk);
+	}
+
+	st_wdog->dev		= &pdev->dev;
+	st_wdog->base		= base;
+	st_wdog->clk		= clk;
+	st_wdog->regmap		= regmap;
+	st_wdog->warm_reset	= of_property_read_bool(np, "st,warm_reset");
+	st_wdog->clkrate	= clk_get_rate(st_wdog->clk);
+
+	if (!st_wdog->clkrate) {
+		dev_err(&pdev->dev, "Unable to fetch clock rate\n");
+		return -EINVAL;
+	}
+	st_wdog_dev.max_timeout = 0xFFFFFFFF / st_wdog->clkrate;
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable clock\n");
+		return ret;
+	}
+
+	watchdog_set_drvdata(&st_wdog_dev, st_wdog);
+	watchdog_set_nowayout(&st_wdog_dev, WATCHDOG_NOWAYOUT);
+
+	/* Init Watchdog timeout with value in DT */
+	ret = watchdog_init_timeout(&st_wdog_dev, 0, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to initialise watchdog timeout\n");
+		clk_disable_unprepare(clk);
+		return ret;
+	}
+
+	ret = watchdog_register_device(&st_wdog_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to register watchdog\n");
+		clk_disable_unprepare(clk);
+		return ret;
+	}
+
+	st_wdog_setup(st_wdog, true);
+
+	dev_info(&pdev->dev, "LPC Watchdog driver registered, reset type is %s",
+		 st_wdog->warm_reset ? "warm" : "cold");
+
+	return ret;
+}
+
+static int st_wdog_remove(struct platform_device *pdev)
+{
+	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
+
+	st_wdog_setup(st_wdog, false);
+	watchdog_unregister_device(&st_wdog_dev);
+	clk_disable_unprepare(st_wdog->clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int st_wdog_suspend(struct device *dev)
+{
+	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
+
+	if (watchdog_active(&st_wdog_dev))
+		st_wdog_stop(&st_wdog_dev);
+
+	st_wdog_setup(st_wdog, false);
+
+	clk_disable(st_wdog->clk);
+
+	return 0;
+}
+
+static int st_wdog_resume(struct device *dev)
+{
+	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
+	int ret;
+
+	ret = clk_enable(st_wdog->clk);
+	if (ret) {
+		dev_err(dev, "Unable to re-enable clock\n");
+		watchdog_unregister_device(&st_wdog_dev);
+		clk_unprepare(st_wdog->clk);
+		return ret;
+	}
+
+	st_wdog_setup(st_wdog, true);
+
+	if (watchdog_active(&st_wdog_dev)) {
+		st_wdog_load_timer(st_wdog, st_wdog_dev.timeout);
+		st_wdog_start(&st_wdog_dev);
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(st_wdog_pm_ops,
+			 st_wdog_suspend,
+			 st_wdog_resume);
+
+static struct platform_driver st_wdog_driver = {
+	.driver	= {
+		.name = "st-lpc-wdt",
+		.pm = &st_wdog_pm_ops,
+		.of_match_table = st_wdog_match,
+	},
+	.probe = st_wdog_probe,
+	.remove = st_wdog_remove,
+};
+module_platform_driver(st_wdog_driver);
+
+MODULE_AUTHOR("David Paris <david.paris@st.com>");
+MODULE_DESCRIPTION("ST LPC Watchdog Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..1a80594 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,6 +43,45 @@
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
+/*
+ * Deferred Registration infrastructure.
+ *
+ * Sometimes watchdog drivers needs to be loaded as soon as possible,
+ * for example when it's impossible to disable it. To do so,
+ * raising the initcall level of the watchdog driver is a solution.
+ * But in such case, the miscdev is maybe not ready (subsys_initcall), and
+ * watchdog_core need miscdev to register the watchdog as a char device.
+ *
+ * The deferred registration infrastructure offer a way for the watchdog
+ * subsystem to register a watchdog properly, even before miscdev is ready.
+ */
+
+static DEFINE_MUTEX(wtd_deferred_reg_mutex);
+static LIST_HEAD(wtd_deferred_reg_list);
+static bool wtd_deferred_reg_done;
+
+static int watchdog_deferred_registration_add(struct watchdog_device *wdd)
+{
+	list_add_tail(&wdd->deferred,
+		      &wtd_deferred_reg_list);
+	return 0;
+}
+
+static void watchdog_deferred_registration_del(struct watchdog_device *wdd)
+{
+	struct list_head *p, *n;
+	struct watchdog_device *wdd_tmp;
+
+	list_for_each_safe(p, n, &wtd_deferred_reg_list) {
+		wdd_tmp = list_entry(p, struct watchdog_device,
+				     deferred);
+		if (wdd_tmp == wdd) {
+			list_del(&wdd_tmp->deferred);
+			break;
+		}
+	}
+}
+
 static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 {
 	/*
@@ -98,17 +137,7 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
-/**
- * watchdog_register_device() - register a watchdog device
- * @wdd: watchdog device
- *
- * Register a watchdog device with the kernel so that the
- * watchdog timer can be accessed from userspace.
- *
- * A zero is returned on success and a negative errno code for
- * failure.
- */
-int watchdog_register_device(struct watchdog_device *wdd)
+static int __watchdog_register_device(struct watchdog_device *wdd)
 {
 	int ret, id, devno;
 
@@ -164,16 +193,33 @@ int watchdog_register_device(struct watchdog_device *wdd)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(watchdog_register_device);
 
 /**
- * watchdog_unregister_device() - unregister a watchdog device
- * @wdd: watchdog device to unregister
+ * watchdog_register_device() - register a watchdog device
+ * @wdd: watchdog device
  *
- * Unregister a watchdog device that was previously successfully
- * registered with watchdog_register_device().
+ * Register a watchdog device with the kernel so that the
+ * watchdog timer can be accessed from userspace.
+ *
+ * A zero is returned on success and a negative errno code for
+ * failure.
  */
-void watchdog_unregister_device(struct watchdog_device *wdd)
+
+int watchdog_register_device(struct watchdog_device *wdd)
+{
+	int ret;
+
+	mutex_lock(&wtd_deferred_reg_mutex);
+	if (wtd_deferred_reg_done)
+		ret = __watchdog_register_device(wdd);
+	else
+		ret = watchdog_deferred_registration_add(wdd);
+	mutex_unlock(&wtd_deferred_reg_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(watchdog_register_device);
+
+static void __watchdog_unregister_device(struct watchdog_device *wdd)
 {
 	int ret;
 	int devno;
@@ -189,8 +235,43 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 	ida_simple_remove(&watchdog_ida, wdd->id);
 	wdd->dev = NULL;
 }
+
+/**
+ * watchdog_unregister_device() - unregister a watchdog device
+ * @wdd: watchdog device to unregister
+ *
+ * Unregister a watchdog device that was previously successfully
+ * registered with watchdog_register_device().
+ */
+
+void watchdog_unregister_device(struct watchdog_device *wdd)
+{
+	mutex_lock(&wtd_deferred_reg_mutex);
+	if (wtd_deferred_reg_done)
+		__watchdog_unregister_device(wdd);
+	else
+		watchdog_deferred_registration_del(wdd);
+	mutex_unlock(&wtd_deferred_reg_mutex);
+}
+
 EXPORT_SYMBOL_GPL(watchdog_unregister_device);
 
+static int __init watchdog_deferred_registration(void)
+{
+	mutex_lock(&wtd_deferred_reg_mutex);
+	wtd_deferred_reg_done = true;
+	while (!list_empty(&wtd_deferred_reg_list)) {
+		struct watchdog_device *wdd;
+
+		wdd = list_first_entry(&wtd_deferred_reg_list,
+				       struct watchdog_device, deferred);
+		list_del(&wdd->deferred);
+		__watchdog_register_device(wdd);
+	}
+	mutex_unlock(&wtd_deferred_reg_mutex);
+	return 0;
+}
+
 static int __init watchdog_init(void)
 {
 	int err;
@@ -207,6 +288,7 @@ static int __init watchdog_init(void)
 		return err;
 	}
 
+	watchdog_deferred_registration();
 	return 0;
 }
 
@@ -217,7 +299,7 @@ static void __exit watchdog_exit(void)
 	ida_destroy(&watchdog_ida);
 }
 
-subsys_initcall(watchdog_init);
+subsys_initcall_sync(watchdog_init);
 module_exit(watchdog_exit);
 
 MODULE_AUTHOR("Alan Cox <alan@lxorguk.ukuu.org.uk>");
diff --git a/include/dt-bindings/mfd/st-lpc.h b/include/dt-bindings/mfd/st-lpc.h
new file mode 100644
index 0000000..e3e6c75
--- /dev/null
+++ b/include/dt-bindings/mfd/st-lpc.h
@@ -0,0 +1,15 @@
+/*
+ * This header provides shared DT/Driver defines for ST's LPC device
+ *
+ * Copyright (C) 2014 STMicroelectronics -- All Rights Reserved
+ *
+ * Author: Lee Jones <lee.jones@linaro.org> for STMicroelectronics
+ */
+
+#ifndef __DT_BINDINGS_ST_LPC_H__
+#define __DT_BINDINGS_ST_LPC_H__
+
+#define ST_LPC_MODE_RTC		0
+#define ST_LPC_MODE_WDT		1
+
+#endif /* __DT_BINDINGS_ST_LPC_H__ */
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index a746bf5..f47fead 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -65,6 +65,8 @@ struct watchdog_ops {
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
+ * @deferred: entry in wtd_deferred_reg_list which is used to
+ *			   register early initialized watchdogs.
  *
  * The watchdog_device structure contains all information about a
  * watchdog timer device.
@@ -95,6 +97,7 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+	struct list_head deferred;
 };
 
 #define WATCHDOG_NOWAYOUT		IS_BUILTIN(CONFIG_WATCHDOG_NOWAYOUT)
