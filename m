Return-path: <wimvs@spo001.leaseweb.nl>
Date: Wed, 9 Sep 2015 21:58:38 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Greta Zhang <greta.zhang@mediatek.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Pratyush Anand <panand@redhat.com>,
	Timur Tabi <timur@codeaurora.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [GIT PULL REQUEST] watchdog - v4.3-rc1 merge window
Message-ID: <20150909195838.GA12688@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It contains:
* New driver for NXP LPC18xx Watchdog Timer
* New driver for SAMA5D4 watchdog timer
* (nv_tco) add support for MCP79
* Clean-up and improvement of the mpc8xxx watchdog driver
* Improvements on gpio-wdt
* at91sam9_wdt clock improvements
* and other small fixes and improvements

This will update the following files:

 Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt |   35 +
 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt         |    2 
 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt       |   19 
 Documentation/watchdog/src/watchdog-test.c                       |   22 
 drivers/misc/mei/wd.c                                            |    1 
 drivers/watchdog/Kconfig                                         |   22 
 drivers/watchdog/Makefile                                        |    2 
 drivers/watchdog/at91rm9200_wdt.c                                |    2 
 drivers/watchdog/at91sam9_wdt.c                                  |   22 
 drivers/watchdog/at91sam9_wdt.h                                  |    2 
 drivers/watchdog/bcm2835_wdt.c                                   |    1 
 drivers/watchdog/bcm47xx_wdt.c                                   |    1 
 drivers/watchdog/bcm_kona_wdt.c                                  |    1 
 drivers/watchdog/booke_wdt.c                                     |    4 
 drivers/watchdog/coh901327_wdt.c                                 |    1 
 drivers/watchdog/da9052_wdt.c                                    |    1 
 drivers/watchdog/da9055_wdt.c                                    |    1 
 drivers/watchdog/da9062_wdt.c                                    |    1 
 drivers/watchdog/da9063_wdt.c                                    |    1 
 drivers/watchdog/davinci_wdt.c                                   |    1 
 drivers/watchdog/digicolor_wdt.c                                 |    1 
 drivers/watchdog/ep93xx_wdt.c                                    |    1 
 drivers/watchdog/gpio_wdt.c                                      |   65 -
 drivers/watchdog/ie6xx_wdt.c                                     |    1 
 drivers/watchdog/imgpdc_wdt.c                                    |    1 
 drivers/watchdog/intel-mid_wdt.c                                 |    1 
 drivers/watchdog/jz4740_wdt.c                                    |    1 
 drivers/watchdog/lpc18xx_wdt.c                                   |  340 ++++++++++
 drivers/watchdog/mena21_wdt.c                                    |    1 
 drivers/watchdog/menf21bmc_wdt.c                                 |    1 
 drivers/watchdog/mpc8xxx_wdt.c                                   |  156 +---
 drivers/watchdog/mtk_wdt.c                                       |   39 +
 drivers/watchdog/nv_tco.c                                        |    2 
 drivers/watchdog/omap_wdt.c                                      |    1 
 drivers/watchdog/orion_wdt.c                                     |    1 
 drivers/watchdog/pnx4008_wdt.c                                   |    1 
 drivers/watchdog/qcom-wdt.c                                      |    1 
 drivers/watchdog/retu_wdt.c                                      |    1 
 drivers/watchdog/rt2880_wdt.c                                    |    1 
 drivers/watchdog/s3c2410_wdt.c                                   |    1 
 drivers/watchdog/sama5d4_wdt.c                                   |  280 ++++++++
 drivers/watchdog/shwdt.c                                         |    1 
 drivers/watchdog/sirfsoc_wdt.c                                   |    1 
 drivers/watchdog/sp805_wdt.c                                     |    1 
 drivers/watchdog/st_lpc_wdt.c                                    |    1 
 drivers/watchdog/stmp3xxx_rtc_wdt.c                              |    1 
 drivers/watchdog/sunxi_wdt.c                                     |    2 
 drivers/watchdog/tegra_wdt.c                                     |    1 
 drivers/watchdog/twl4030_wdt.c                                   |    1 
 drivers/watchdog/txx9wdt.c                                       |    1 
 drivers/watchdog/ux500_wdt.c                                     |    1 
 drivers/watchdog/via_wdt.c                                       |    1 
 drivers/watchdog/wm831x_wdt.c                                    |    1 
 drivers/watchdog/wm8350_wdt.c                                    |    1 
 54 files changed, 918 insertions(+), 135 deletions(-)

with these Changes:

commit 6551881c86c791237a3bebf11eb3bd70b60ea782
Author: Pratyush Anand <panand@redhat.com>
Date:   Thu Aug 20 14:05:01 2015 +0530

    Watchdog: Fix parent of watchdog_devices
    
    /sys/class/watchdog/watchdogn/device/modalias can help to identify the
    driver/module for a given watchdog node. However, many wdt devices do not
    set their parent and so, we do not see an entry for device in sysfs for
    such devices.
    
    This patch fixes parent of watchdog_device so that
    /sys/class/watchdog/watchdogn/device is populated.
    
    Exceptions: booke, diag288, octeon, softdog and w83627hf -- They do not
    have any parent. Not sure, how we can identify driver for these devices.
    
    Signed-off-by: Pratyush Anand <panand@redhat.com>
    Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
    Acked-by: Lee Jones <lee.jones@linaro.org>
    Acked-by: Lubomir Rintel <lkundrak@v3.sk>
    Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
    Acked-by: Thierry Reding <treding@nvidia.com>
    Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
    Acked-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit bf5125d5e0759a0f513b1bcd33c15edc0cf4c17b
Author: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Date:   Mon Aug 17 09:19:03 2015 -0700

    watchdog: at91rm9200: Correct check for syscon_node_to_regmap() errors
    
    syscon_node_to_regmap() returns a regmap or an ERR_PTR().
    
    Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a97a09bd119fbdf4ba8c634fed8f4148d1def1e0
Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date:   Sun Aug 16 11:23:43 2015 +0200

    watchdog: at91sam9: get and use slow clock
    
    Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
    hang") added a workaround for the slow clock as it is not properly handled
    by its users.
    
    Get and use the slow clock as it is necessary for the at91sam9 watchdog.
    
    Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f4fff94e3e3a712ef062c44b64ecf8f552f48ea4
Author: Wenyou Yang <wenyou.yang@atmel.com>
Date:   Thu Aug 6 18:17:05 2015 +0800

    Documentation: dt: binding: atmel-sama5d4-wdt: for SAMA5D4 watchdog driver
    
    The compatible "atmel,sama5d4-wdt" supports the SAMA5D4 watchdog driver
    and the watchdog's WDT_MR register can be written more than once.
    
    Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 76534860f108b812926a4fbfbdadbfa9cdec89d0
Author: Wenyou Yang <wenyou.yang@atmel.com>
Date:   Thu Aug 6 18:16:46 2015 +0800

    watchdog: add a driver to support SAMA5D4 watchdog timer
    
    From SAMA5D4, the watchdog timer is upgrated with a new feature,
    which is describled as in the datasheet, "WDT_MR can be written
    until a LOCKMR command is issued in WDT_CR".
    That is to say, as long as the bootstrap and u-boot don't issue
    a LOCKMR command, WDT_MR can be written more than once in the driver.
    
    So the SAMA5D4 watchdog driver's implementation is different from
    the at91sam9260 watchdog driver implemented in file at91sam9_wdt.c.
    The user application open the device file to enable the watchdog timer
    hardware, and close to disable it, and set the watchdog timer timeout
    by seting WDV and WDD fields of WDT_MR register, and ping the watchdog
    by issuing WDRSTT command to WDT_CR register with hard-coded key.
    
    Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f8c33e9717150f7b8063d6d77a8ea90adad434e9
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Aug 12 10:15:58 2015 +0200

    watchdog: mpc8xxx: allow to compile for MPC512x
    
    The MPC5125 processor features a watchdog device that is identical to
    the MPC8610 one. So allow to enable the driver for MPC512x kernel
    configurations.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 72cd501e6a9b578cf99ae062477d9c7a938a3238
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Aug 12 10:15:57 2015 +0200

    watchdog: mpc8xxx: use better error code when watchdog cannot be enabled
    
    checkpatch warns about ENOSYS, telling "ENOSYS means 'invalid syscall
    nr' and nothing else". So use ENODEV instead.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 7997ebad4d747ff5561cb5ec0c7423e0d4e628d5
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Aug 12 10:15:56 2015 +0200

    watchdog: mpc8xxx: use dynamic memory for device specific data
    
    Instead of relying on global static memory dynamically allocate the
    needed data. This has the benefit of some saved bytes if the driver is
    not in use and making it possible to bind more than one device (even
    though this has no known use case).
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit de5f71222bd544558d81701454eb457b295de96e
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Aug 12 10:15:55 2015 +0200

    watchdog: mpc8xxx: use devm_ioremap_resource to map memory
    
    This simplifies the error paths and device unbinding.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f0ded83b96d27b27db0015e701cfd916330e3c50
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Aug 12 10:15:54 2015 +0200

    watchdog: mpc8xxx: make use of of_device_get_match_data
    
    This function is new in v4.2-rc1 and makes a forward declaration of the
    match table superfluous which can so be removed.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 50ffb53ef2311e4631086d27783b00db6859c60e
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Aug 12 10:15:53 2015 +0200

    watchdog: mpc8xxx: simplify registration
    
    Since commit ef90174f8210 ("watchdog: watchdog_core: Add watchdog
    registration deferral mechanism") there is no need to delay the call to
    watchdog_register_device any more. So simplify the registration code
    accordingly.
    
    Resetting wd_base to NULL can the also be dropped because nothing
    depends on it being NULL to signal probe failure any more. (The matching
    wd_base = NULL in .remove was missing, too.)
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a57e06f7c6365f7d6e13f35933d3ef329205c1af
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Aug 12 10:15:52 2015 +0200

    watchdog: mpc8xxx: remove dead code
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 6cd8a1b9f71290d58099101e65e7e2279bcdb212
Author: Fengguang Wu <fengguang.wu@intel.com>
Date:   Fri Aug 7 10:28:40 2015 -0700

    watchdog: lpc18xx_wdt_get_timeleft() can be static
    
    Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit cfde37e1ec18dc68a52a1b882390c0f9c52b5f10
Author: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Date:   Sat Aug 1 15:37:17 2015 -0300

    DT: watchdog: Add NXP LPC18xx Watchdog Timer binding documentation
    
    Add the devicetree binding document for NXP LPC18xx Watchdog Timer.
    
    Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 7c25f8c9f67708e6464d2221bc311cbd99e950dc
Author: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Date:   Sat Aug 1 15:37:16 2015 -0300

    watchdog: NXP LPC18xx Watchdog Timer Driver
    
    This commit adds support for the watchdog timer found in NXP LPC SoCs
    family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
    share the same watchdog hardware.
    
    Watchdog driver registers a restart handler that will restart the system
    by performing an incorrect feed after ensuring the watchdog is enabled in
    reset mode.
    
    As watchdog cannot be disabled in hardware, driver's stop routine will
    regularly send a keepalive ping using a timer.
    
    Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 4f2d0b2d1b31cbe704c8f94e74e46cb64187ab0c
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Fri Jul 31 09:21:36 2015 +0200

    watchdog: gpio-wdt: ping already at startup for always running devices
    
    During probe for an always-running watchdog a timer is setup to
    constantly ping the watchdog while the device is not open. The gpio to
    ping the watchdog is setup to inactive.
    
    For a watchdog with hw_algo = "toggle" this results in a ping depending
    on the initial state of the gpio, for hw_algo = "level" no ping is
    generated.
    
    Make sure that the first automatic ping is sent immediately and not only
    when the timer expires the first time. This makes the machine survive in
    case more than half of the watchdog timeout is already elapsed. (Which
    is very probable for the chip I'm faced with that has a timeout of one
    second.)
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0a0a542f6bbb2ebe956f0117c842302442ef52da
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Thu Jul 30 11:32:23 2015 +0200

    watchdog: gpio-wdt: be more strict about hw_algo matching
    
    strncmp(algo, "toggle", 6) doesn't compare the trailing '\0' byte, so
    using
    
    	hw_algo = "toggleboggle"
    
    is recognized the same way as
    
    	hw_algo = "toggle"
    
    . While this doesn't introduce any problems for a device tree that
    sticks to the documented settings it's still ugly.
    
    Fix this by using strcmp to only match on "toggle" and "level".
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ab54d7f017772e89964d4040937a83cd4468562a
Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date:   Fri Jul 31 11:39:39 2015 +0200

    Documentation: watchdog: at91sam9_wdt: add clocks property
    
    The watchdog has an input clock, the slow clock. It is required as it will
    not function without it.
    
    Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit fa928ee8d4af1f70eee77a5ac77c084a0715eb9e
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Wed Jul 29 09:45:36 2015 -0700

    watchdog: booke_wdt: Use infrastructure to check timeout limits
    
    The watchdog infrastructure checks the maximum timeout for us.
    Use it.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 64307b48f79f35d28ed6b44e20b773bc00a0152e
Author: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date:   Mon Jul 27 12:03:30 2015 -0400

    watchdog: (nv_tco) add support for MCP79
    
    Tested on the Nvidia chipset with an SMBus controller PCI ID 0x0AA2
    (as shown in the PCI listing during the boot sequence).
    
    Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0919e4445190da18496d31aac08b90828a47d45f
Author: Francesco Lavra <francescolavra.fl@gmail.com>
Date:   Sat Jul 25 08:25:18 2015 +0200

    watchdog: sunxi: fix activation of system reset
    
    Commit f2147de33470 ("watchdog: sunxi: support parameterized compatible
    strings") introduced a regression in sunxi_wdt_start(), by which
    the system reset function of the watchdog is not enabled upon
    starting the watchdog. As a result, the system is not reset when the
    watchdog expires. Fix it.
    
    Fixes: f2147de33470 ("watchdog: sunxi: support parameterized compatible strings")
    Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
    Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Cc: stable@vger.kernel.org

commit 5724485b185a4ac4bb96149718ff736c5ef5c169
Author: Greta Zhang <greta.zhang@mediatek.com>
Date:   Fri Jul 24 15:28:46 2015 +0800

    watchdog: mtk_wdt: add wdt shutdown callback to disable wdt if enabled
    
    Without .shutdown(), watchdog might reset the system during power off.
    For example, if watchdog's timeout is set to 30s, then it is reset to
    zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
    but watchdog is still running and may trigger reset.
    
    Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
    Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
    Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9fab06920c9207aca8ff4e2416bb10cabc19294a
Author: Greta Zhang <greta.zhang@mediatek.com>
Date:   Fri Jul 24 15:28:45 2015 +0800

    watchdog: mtk_wdt: add suspend/resume support
    
    add mediatek watchdog driver suspend/resume support
    
    Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
    Signed-off-by: Roger Lu <roger.lu@mediatek.com>
    Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
    Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8a340dbbc4b10fe07a924e91979bfc93e966dd65
Author: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu Jul 23 17:21:16 2015 -0300

    watchdog: imgpdc: Unregister restart handler on remove
    
    Commit c631f20068 ("watchdog: imgpdc: Add reboot support") introduced
    a restart handler but forgot to unregister it on driver removal. Fix it.
    
    Fixes: c631f20068 ("watchdog: imgpdc: Add reboot support")
    Reported-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
    Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f15d7114bbdd594f1d8b644a44f647d2b6e9772e
Author: Timur Tabi <timur@codeaurora.org>
Date:   Mon Jun 29 11:46:17 2015 -0500

    Documentation/watchdog: add timeout and ping rate control to watchdog-test.c
    
    The watchdog test program is much more useful if it can configure the
    timeout value and ping rate.  This will allow you to test actual timeouts.
    
    Adds the -t parameter to set the timeout value (in seconds), and -p to set
    the ping rate (number of seconds between pings).
    
    Signed-off-by: Timur Tabi <timur@codeaurora.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
new file mode 100644
index 0000000..f7cc7c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
@@ -0,0 +1,35 @@
+* Atmel SAMA5D4 Watchdog Timer (WDT) Controller
+
+Required properties:
+- compatible: "atmel,sama5d4-wdt"
+- reg: base physical address and length of memory mapped region.
+
+Optional properties:
+- timeout-sec: watchdog timeout value (in seconds).
+- interrupts: interrupt number to the CPU.
+- atmel,watchdog-type: should be "hardware" or "software".
+	"hardware": enable watchdog fault reset. A watchdog fault triggers
+		    watchdog reset.
+	"software": enable watchdog fault interrupt. A watchdog fault asserts
+		    watchdog interrupt.
+- atmel,idle-halt: present if you want to stop the watchdog when the CPU is
+		   in idle state.
+	CAUTION: This property should be used with care, it actually makes the
+	watchdog not counting when the CPU is in idle state, therefore the
+	watchdog reset time depends on mean CPU usage and will not reset at all
+	if the CPU stop working while it is in idle state, which is probably
+	not what you want.
+- atmel,dbg-halt: present if you want to stop the watchdog when the CPU is
+		  in debug state.
+
+Example:
+	watchdog@fc068640 {
+		compatible = "atmel,sama5d4-wdt";
+		reg = <0xfc068640 0x10>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH 5>;
+		timeout-sec = <10>;
+		atmel,watchdog-type = "hardware";
+		atmel,dbg-halt;
+		atmel,idle-halt;
+		status = "okay";
+	};
diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index a4d8697..86fa6de 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 - compatible: must be "atmel,at91sam9260-wdt".
 - reg: physical base address of the controller and length of memory mapped
   region.
+- clocks: phandle to input clock.
 
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
@@ -39,6 +40,7 @@ Example:
 		compatible = "atmel,at91sam9260-wdt";
 		reg = <0xfffffd40 0x10>;
 		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		clocks = <&clk32k>;
 		timeout-sec = <15>;
 		atmel,watchdog-type = "hardware";
 		atmel,reset-type = "all";
diff --git a/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
new file mode 100644
index 0000000..09f6b24
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
@@ -0,0 +1,19 @@
+* NXP LPC18xx Watchdog Timer (WDT)
+
+Required properties:
+- compatible: Should be "nxp,lpc1850-wwdt"
+- reg: Should contain WDT registers location and length
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should contain "wdtclk" and "reg"; the watchdog counter
+               clock and register interface clock respectively.
+- interrupts: Should contain WDT interrupt
+
+Examples:
+
+watchdog@40080000 {
+	compatible = "nxp,lpc1850-wwdt";
+	reg = <0x40080000 0x24>;
+	clocks = <&cgu BASE_SAFE_CLK>, <&ccu1 CLK_CPU_WWDT>;
+	clock-names = "wdtclk", "reg";
+	interrupts = <49>;
+};
diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index 3da8229..fcdde8f 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -41,6 +41,7 @@ static void term(int sig)
 int main(int argc, char *argv[])
 {
     int flags;
+    unsigned int ping_rate = 1;
 
     fd = open("/dev/watchdog", O_WRONLY);
 
@@ -63,22 +64,33 @@ int main(int argc, char *argv[])
 	    fprintf(stderr, "Watchdog card enabled.\n");
 	    fflush(stderr);
 	    goto end;
+	} else if (!strncasecmp(argv[1], "-t", 2) && argv[2]) {
+	    flags = atoi(argv[2]);
+	    ioctl(fd, WDIOC_SETTIMEOUT, &flags);
+	    fprintf(stderr, "Watchdog timeout set to %u seconds.\n", flags);
+	    fflush(stderr);
+	    goto end;
+	} else if (!strncasecmp(argv[1], "-p", 2) && argv[2]) {
+	    ping_rate = strtoul(argv[2], NULL, 0);
+	    fprintf(stderr, "Watchdog ping rate set to %u seconds.\n", ping_rate);
+	    fflush(stderr);
 	} else {
-	    fprintf(stderr, "-d to disable, -e to enable.\n");
+	    fprintf(stderr, "-d to disable, -e to enable, -t <n> to set " \
+		"the timeout,\n-p <n> to set the ping rate, and \n");
 	    fprintf(stderr, "run by itself to tick the card.\n");
 	    fflush(stderr);
 	    goto end;
 	}
-    } else {
-	fprintf(stderr, "Watchdog Ticking Away!\n");
-	fflush(stderr);
     }
 
+    fprintf(stderr, "Watchdog Ticking Away!\n");
+    fflush(stderr);
+
     signal(SIGINT, term);
 
     while(1) {
 	keep_alive();
-	sleep(1);
+	sleep(ping_rate);
     }
 end:
     close(fd);
diff --git a/drivers/misc/mei/wd.c b/drivers/misc/mei/wd.c
index 2bc0f50..b346638 100644
--- a/drivers/misc/mei/wd.c
+++ b/drivers/misc/mei/wd.c
@@ -364,6 +364,7 @@ int mei_watchdog_register(struct mei_device *dev)
 
 	int ret;
 
+	amt_wd_dev.parent = dev->dev;
 	/* unlock to perserve correct locking order */
 	mutex_unlock(&dev->device_lock);
 	ret = watchdog_register_device(&amt_wd_dev);
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 241fafd..ce0658c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -188,6 +188,15 @@ config AT91SAM9X_WATCHDOG
 	  Watchdog timer embedded into AT91SAM9X and AT91CAP9 chips. This will
 	  reboot your system when the timeout is reached.
 
+config SAMA5D4_WATCHDOG
+	tristate "Atmel SAMA5D4 Watchdog Timer"
+	depends on ARCH_AT91
+	select WATCHDOG_CORE
+	help
+	  Atmel SAMA5D4 watchdog timer is embedded into SAMA5D4 chips.
+	  Its Watchdog Timer Mode Register can be written more than once.
+	  This will reboot your system when the timeout is reached.
+
 config CADENCE_WATCHDOG
 	tristate "Cadence Watchdog Timer"
 	depends on HAS_IOMEM
@@ -558,6 +567,17 @@ config DIGICOLOR_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called digicolor_wdt.
 
+config LPC18XX_WATCHDOG
+	tristate "LPC18xx/43xx Watchdog"
+	depends on ARCH_LPC18XX || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  Say Y here if to include support for the watchdog timer
+	  in NXP LPC SoCs family, which includes LPC18xx/LPC43xx
+	  processors.
+	  To compile this driver as a module, choose M here: the
+	  module will be called lpc18xx_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
@@ -1333,7 +1353,7 @@ config MPC5200_WDT
 
 config 8xxx_WDT
 	tristate "MPC8xxx Platform Watchdog Timer"
-	depends on PPC_8xx || PPC_83xx || PPC_86xx
+	depends on PPC_8xx || PPC_83xx || PPC_86xx || PPC_MPC512x
 	select WATCHDOG_CORE
 	help
 	  This driver is for a SoC level watchdog that exists on some
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 59ea9a1..0c616e3 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_KS8695_WATCHDOG) += ks8695_wdt.o
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
+obj-$(CONFIG_SAMA5D4_WATCHDOG) += sama5d4_wdt.o
 obj-$(CONFIG_DW_WATCHDOG) += dw_wdt.o
 obj-$(CONFIG_EP93XX_WATCHDOG) += ep93xx_wdt.o
 obj-$(CONFIG_PNX4008_WATCHDOG) += pnx4008_wdt.o
@@ -66,6 +67,7 @@ obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
 obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
+obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 41cecb5..464bf76 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -244,7 +244,7 @@ static int at91wdt_probe(struct platform_device *pdev)
 	}
 
 	regmap_st = syscon_node_to_regmap(parent->of_node);
-	if (!regmap_st)
+	if (IS_ERR(regmap_st))
 		return -ENODEV;
 
 	res = misc_register(&at91wdt_miscdev);
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index e4698f7..7e6acaf 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -17,6 +17,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -90,6 +91,7 @@ struct at91wdt {
 	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
 	bool nowayout;
 	unsigned int irq;
+	struct clk *sclk;
 };
 
 /* ......................................................................... */
@@ -352,15 +354,25 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
+	wdt->sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(wdt->sclk))
+		return PTR_ERR(wdt->sclk);
+
+	err = clk_prepare_enable(wdt->sclk);
+	if (err) {
+		dev_err(&pdev->dev, "Could not enable slow clock\n");
+		return err;
+	}
+
 	if (pdev->dev.of_node) {
 		err = of_at91wdt_init(pdev->dev.of_node, wdt);
 		if (err)
-			return err;
+			goto err_clk;
 	}
 
 	err = at91_wdt_init(pdev, wdt);
 	if (err)
-		return err;
+		goto err_clk;
 
 	platform_set_drvdata(pdev, wdt);
 
@@ -368,6 +380,11 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		wdt->wdd.timeout, wdt->nowayout);
 
 	return 0;
+
+err_clk:
+	clk_disable_unprepare(wdt->sclk);
+
+	return err;
 }
 
 static int __exit at91wdt_remove(struct platform_device *pdev)
@@ -377,6 +394,7 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 
 	pr_warn("I quit now, hardware will probably reboot!\n");
 	del_timer(&wdt->timer);
+	clk_disable_unprepare(wdt->sclk);
 
 	return 0;
 }
diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
index c6fbb2e..b79a83b 100644
--- a/drivers/watchdog/at91sam9_wdt.h
+++ b/drivers/watchdog/at91sam9_wdt.h
@@ -22,11 +22,13 @@
 
 #define AT91_WDT_MR		0x04			/* Watchdog Mode Register */
 #define		AT91_WDT_WDV		(0xfff << 0)		/* Counter Value */
+#define			AT91_WDT_SET_WDV(x)	((x) & AT91_WDT_WDV)
 #define		AT91_WDT_WDFIEN		(1     << 12)		/* Fault Interrupt Enable */
 #define		AT91_WDT_WDRSTEN	(1     << 13)		/* Reset Processor */
 #define		AT91_WDT_WDRPROC	(1     << 14)		/* Timer Restart */
 #define		AT91_WDT_WDDIS		(1     << 15)		/* Watchdog Disable */
 #define		AT91_WDT_WDD		(0xfff << 16)		/* Delta Value */
+#define			AT91_WDT_SET_WDD(x)	(((x) << 16) & AT91_WDT_WDD)
 #define		AT91_WDT_WDDBGHLT	(1     << 28)		/* Debug Halt */
 #define		AT91_WDT_WDIDLEHLT	(1     << 29)		/* Idle Halt */
 
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 7116968..66c3e65 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -182,6 +182,7 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&bcm2835_wdt_wdd, wdt);
 	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
 	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
+	bcm2835_wdt_wdd.parent = &pdev->dev;
 	err = watchdog_register_device(&bcm2835_wdt_wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device");
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index b28a072..4064a43 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -209,6 +209,7 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 
 	wdt->wdd.info = &bcm47xx_wdt_info;
 	wdt->wdd.timeout = WDT_DEFAULT_TIME;
+	wdt->wdd.parent = &pdev->dev;
 	ret = wdt->wdd.ops->set_timeout(&wdt->wdd, timeout);
 	if (ret)
 		goto err_timer;
diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 22d8ae6..e0c9842 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -319,6 +319,7 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
+	bcm_kona_wdt_wdd.parent = &pdev->dev;
 
 	ret = bcm_kona_wdt_set_timeout_reg(&bcm_kona_wdt_wdd, 0);
 	if (ret) {
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index e96b09b..04da4b6 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -186,8 +186,6 @@ static int booke_wdt_stop(struct watchdog_device *wdog)
 static int booke_wdt_set_timeout(struct watchdog_device *wdt_dev,
 				 unsigned int timeout)
 {
-	if (timeout > MAX_WDT_TIMEOUT)
-		return -EINVAL;
 	wdt_dev->timeout = timeout;
 	booke_wdt_set(wdt_dev);
 
@@ -211,7 +209,6 @@ static struct watchdog_device booke_wdt_dev = {
 	.info = &booke_wdt_info,
 	.ops = &booke_wdt_ops,
 	.min_timeout = 1,
-	.max_timeout = 0xFFFF
 };
 
 static void __exit booke_wdt_exit(void)
@@ -229,6 +226,7 @@ static int __init booke_wdt_init(void)
 	booke_wdt_set_timeout(&booke_wdt_dev,
 			      period_to_sec(booke_wdt_period));
 	watchdog_set_nowayout(&booke_wdt_dev, nowayout);
+	booke_wdt_dev.max_timeout = MAX_WDT_TIMEOUT;
 	if (booke_wdt_enabled)
 		booke_wdt_start(&booke_wdt_dev);
 
diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index ce12f43..a099b77 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -358,6 +358,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	if (ret < 0)
 		coh901327_wdt.timeout = 60;
 
+	coh901327_wdt.parent = &pdev->dev;
 	ret = watchdog_register_device(&coh901327_wdt);
 	if (ret == 0)
 		dev_info(&pdev->dev,
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 2e95896..67e6797 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -195,6 +195,7 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	da9052_wdt->timeout = DA9052_DEF_TIMEOUT;
 	da9052_wdt->info = &da9052_wdt_info;
 	da9052_wdt->ops = &da9052_wdt_ops;
+	da9052_wdt->parent = &pdev->dev;
 	watchdog_set_drvdata(da9052_wdt, driver_data);
 
 	kref_init(&driver_data->kref);
diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 495089d..04d1430 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -161,6 +161,7 @@ static int da9055_wdt_probe(struct platform_device *pdev)
 	da9055_wdt->timeout = DA9055_DEF_TIMEOUT;
 	da9055_wdt->info = &da9055_wdt_info;
 	da9055_wdt->ops = &da9055_wdt_ops;
+	da9055_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(da9055_wdt, nowayout);
 	watchdog_set_drvdata(da9055_wdt, driver_data);
 
diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index b3a870c..7386111 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -210,6 +210,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
 	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+	wdt->wdtdev.parent = &pdev->dev;
 
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 	dev_set_drvdata(&pdev->dev, wdt);
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index e2fe2eb..6bf130b 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -175,6 +175,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
 	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
+	wdt->wdtdev.parent = &pdev->dev;
 
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index cfdf8a4..17454ca 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -179,6 +179,7 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout	= 1;
 	wdd->max_timeout	= MAX_HEARTBEAT;
 	wdd->timeout		= DEFAULT_HEARTBEAT;
+	wdd->parent		= &pdev->dev;
 
 	watchdog_init_timeout(wdd, heartbeat, dev);
 
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 31d8e49..50abe1b 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -143,6 +143,7 @@ static int dc_wdt_probe(struct platform_device *pdev)
 	}
 	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
 	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
+	dc_wdt_wdd.parent = &pdev->dev;
 
 	spin_lock_init(&wdt->lock);
 
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 7a2cc71..0a4d7cc 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -132,6 +132,7 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	val = readl(mmio_base + EP93XX_WATCHDOG);
 	ep93xx_wdt_wdd.bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
 	ep93xx_wdt_wdd.timeout = timeout;
+	ep93xx_wdt_wdd.parent = &pdev->dev;
 
 	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);
 
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 1687cc2..90d59d3 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -50,12 +50,41 @@ static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
 		gpio_direction_input(priv->gpio);
 }
 
+static void gpio_wdt_hwping(unsigned long data)
+{
+	struct watchdog_device *wdd = (struct watchdog_device *)data;
+	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	if (priv->armed && time_after(jiffies, priv->last_jiffies +
+				      msecs_to_jiffies(wdd->timeout * 1000))) {
+		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
+		return;
+	}
+
+	/* Restart timer */
+	mod_timer(&priv->timer, jiffies + priv->hw_margin);
+
+	switch (priv->hw_algo) {
+	case HW_ALGO_TOGGLE:
+		/* Toggle output pin */
+		priv->state = !priv->state;
+		gpio_set_value_cansleep(priv->gpio, priv->state);
+		break;
+	case HW_ALGO_LEVEL:
+		/* Pulse */
+		gpio_set_value_cansleep(priv->gpio, !priv->active_low);
+		udelay(1);
+		gpio_set_value_cansleep(priv->gpio, priv->active_low);
+		break;
+	}
+}
+
 static void gpio_wdt_start_impl(struct gpio_wdt_priv *priv)
 {
 	priv->state = priv->active_low;
 	gpio_direction_output(priv->gpio, priv->state);
 	priv->last_jiffies = jiffies;
-	mod_timer(&priv->timer, priv->last_jiffies + priv->hw_margin);
+	gpio_wdt_hwping((unsigned long)&priv->wdd);
 }
 
 static int gpio_wdt_start(struct watchdog_device *wdd)
@@ -97,35 +126,6 @@ static int gpio_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
 	return gpio_wdt_ping(wdd);
 }
 
-static void gpio_wdt_hwping(unsigned long data)
-{
-	struct watchdog_device *wdd = (struct watchdog_device *)data;
-	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
-
-	if (priv->armed && time_after(jiffies, priv->last_jiffies +
-				      msecs_to_jiffies(wdd->timeout * 1000))) {
-		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
-		return;
-	}
-
-	/* Restart timer */
-	mod_timer(&priv->timer, jiffies + priv->hw_margin);
-
-	switch (priv->hw_algo) {
-	case HW_ALGO_TOGGLE:
-		/* Toggle output pin */
-		priv->state = !priv->state;
-		gpio_set_value_cansleep(priv->gpio, priv->state);
-		break;
-	case HW_ALGO_LEVEL:
-		/* Pulse */
-		gpio_set_value_cansleep(priv->gpio, !priv->active_low);
-		udelay(1);
-		gpio_set_value_cansleep(priv->gpio, priv->active_low);
-		break;
-	}
-}
-
 static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
 			       void *unused)
 {
@@ -182,10 +182,10 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	ret = of_property_read_string(pdev->dev.of_node, "hw_algo", &algo);
 	if (ret)
 		return ret;
-	if (!strncmp(algo, "toggle", 6)) {
+	if (!strcmp(algo, "toggle")) {
 		priv->hw_algo = HW_ALGO_TOGGLE;
 		f = GPIOF_IN;
-	} else if (!strncmp(algo, "level", 5)) {
+	} else if (!strcmp(algo, "level")) {
 		priv->hw_algo = HW_ALGO_LEVEL;
 		f = priv->active_low ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
 	} else {
@@ -217,6 +217,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->wdd.ops		= &gpio_wdt_ops;
 	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
 	priv->wdd.max_timeout	= SOFT_TIMEOUT_MAX;
+	priv->wdd.parent	= &pdev->dev;
 
 	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
 		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 9bc39ae..78c2541 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -267,6 +267,7 @@ static int ie6xx_wdt_probe(struct platform_device *pdev)
 
 	ie6xx_wdt_dev.timeout = timeout;
 	watchdog_set_nowayout(&ie6xx_wdt_dev, nowayout);
+	ie6xx_wdt_dev.parent = &pdev->dev;
 
 	spin_lock_init(&ie6xx_wdt_data.unlock_sequence);
 
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 0f73621..15ab072 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -316,6 +316,7 @@ static int pdc_wdt_remove(struct platform_device *pdev)
 {
 	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
 
+	unregister_restart_handler(&pdc_wdt->restart_handler);
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
 	watchdog_unregister_device(&pdc_wdt->wdt_dev);
 	clk_disable_unprepare(pdc_wdt->wdt_clk);
diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 84f6701..0a436b5 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -137,6 +137,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
 	wdt_dev->max_timeout = MID_WDT_TIMEOUT_MAX;
 	wdt_dev->timeout = MID_WDT_DEFAULT_TIMEOUT;
+	wdt_dev->parent = &pdev->dev;
 
 	watchdog_set_drvdata(wdt_dev, &pdev->dev);
 	platform_set_drvdata(pdev, wdt_dev);
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 4c2cc09..6a7d5c3 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -174,6 +174,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	jz4740_wdt->timeout = heartbeat;
 	jz4740_wdt->min_timeout = 1;
 	jz4740_wdt->max_timeout = MAX_HEARTBEAT;
+	jz4740_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
new file mode 100644
index 0000000..ab7b8b1
--- /dev/null
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -0,0 +1,340 @@
+/*
+ * NXP LPC18xx Watchdog Timer (WDT)
+ *
+ * Copyright (c) 2015 Ariel D'Alessandro <ariel@vanguardiasur.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Notes
+ * -----
+ * The Watchdog consists of a fixed divide-by-4 clock pre-scaler and a 24-bit
+ * counter which decrements on every clock cycle.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+/* Registers */
+#define LPC18XX_WDT_MOD			0x00
+#define LPC18XX_WDT_MOD_WDEN		BIT(0)
+#define LPC18XX_WDT_MOD_WDRESET		BIT(1)
+
+#define LPC18XX_WDT_TC			0x04
+#define LPC18XX_WDT_TC_MIN		0xff
+#define LPC18XX_WDT_TC_MAX		0xffffff
+
+#define LPC18XX_WDT_FEED		0x08
+#define LPC18XX_WDT_FEED_MAGIC1		0xaa
+#define LPC18XX_WDT_FEED_MAGIC2		0x55
+
+#define LPC18XX_WDT_TV			0x0c
+
+/* Clock pre-scaler */
+#define LPC18XX_WDT_CLK_DIV		4
+
+/* Timeout values in seconds */
+#define LPC18XX_WDT_DEF_TIMEOUT		30U
+
+static int heartbeat;
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds (default="
+		 __MODULE_STRING(LPC18XX_WDT_DEF_TIMEOUT) ")");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct lpc18xx_wdt_dev {
+	struct watchdog_device	wdt_dev;
+	struct clk		*reg_clk;
+	struct clk		*wdt_clk;
+	unsigned long		clk_rate;
+	void __iomem		*base;
+	struct timer_list	timer;
+	struct notifier_block	restart_handler;
+	spinlock_t		lock;
+};
+
+static int lpc18xx_wdt_feed(struct watchdog_device *wdt_dev)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned long flags;
+
+	/*
+	 * An abort condition will occur if an interrupt happens during the feed
+	 * sequence.
+	 */
+	spin_lock_irqsave(&lpc18xx_wdt->lock, flags);
+	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+	writel(LPC18XX_WDT_FEED_MAGIC2, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+	spin_unlock_irqrestore(&lpc18xx_wdt->lock, flags);
+
+	return 0;
+}
+
+static void lpc18xx_wdt_timer_feed(unsigned long data)
+{
+	struct watchdog_device *wdt_dev = (struct watchdog_device *)data;
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
+
+	lpc18xx_wdt_feed(wdt_dev);
+
+	/* Use safe value (1/2 of real timeout) */
+	mod_timer(&lpc18xx_wdt->timer, jiffies +
+		  msecs_to_jiffies((wdt_dev->timeout * MSEC_PER_SEC) / 2));
+}
+
+/*
+ * Since LPC18xx Watchdog cannot be disabled in hardware, we must keep feeding
+ * it with a timer until userspace watchdog software takes over.
+ */
+static int lpc18xx_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	lpc18xx_wdt_timer_feed((unsigned long)wdt_dev);
+
+	return 0;
+}
+
+static void __lpc18xx_wdt_set_timeout(struct lpc18xx_wdt_dev *lpc18xx_wdt)
+{
+	unsigned int val;
+
+	val = DIV_ROUND_UP(lpc18xx_wdt->wdt_dev.timeout * lpc18xx_wdt->clk_rate,
+			   LPC18XX_WDT_CLK_DIV);
+	writel(val, lpc18xx_wdt->base + LPC18XX_WDT_TC);
+}
+
+static int lpc18xx_wdt_set_timeout(struct watchdog_device *wdt_dev,
+				   unsigned int new_timeout)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
+
+	lpc18xx_wdt->wdt_dev.timeout = new_timeout;
+	__lpc18xx_wdt_set_timeout(lpc18xx_wdt);
+
+	return 0;
+}
+
+static unsigned int lpc18xx_wdt_get_timeleft(struct watchdog_device *wdt_dev)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned int val;
+
+	val = readl(lpc18xx_wdt->base + LPC18XX_WDT_TV);
+	return (val * LPC18XX_WDT_CLK_DIV) / lpc18xx_wdt->clk_rate;
+}
+
+static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned int val;
+
+	if (timer_pending(&lpc18xx_wdt->timer))
+		del_timer(&lpc18xx_wdt->timer);
+
+	val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
+	val |= LPC18XX_WDT_MOD_WDEN;
+	val |= LPC18XX_WDT_MOD_WDRESET;
+	writel(val, lpc18xx_wdt->base + LPC18XX_WDT_MOD);
+
+	/*
+	 * Setting the WDEN bit in the WDMOD register is not sufficient to
+	 * enable the Watchdog. A valid feed sequence must be completed after
+	 * setting WDEN before the Watchdog is capable of generating a reset.
+	 */
+	lpc18xx_wdt_feed(wdt_dev);
+
+	return 0;
+}
+
+static struct watchdog_info lpc18xx_wdt_info = {
+	.identity	= "NXP LPC18xx Watchdog",
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops lpc18xx_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= lpc18xx_wdt_start,
+	.stop		= lpc18xx_wdt_stop,
+	.ping		= lpc18xx_wdt_feed,
+	.set_timeout	= lpc18xx_wdt_set_timeout,
+	.get_timeleft	= lpc18xx_wdt_get_timeleft,
+};
+
+static int lpc18xx_wdt_restart(struct notifier_block *this, unsigned long mode,
+			       void *cmd)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = container_of(this,
+				struct lpc18xx_wdt_dev, restart_handler);
+	unsigned long flags;
+	int val;
+
+	/*
+	 * Incorrect feed sequence causes immediate watchdog reset if enabled.
+	 */
+	spin_lock_irqsave(&lpc18xx_wdt->lock, flags);
+
+	val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
+	val |= LPC18XX_WDT_MOD_WDEN;
+	val |= LPC18XX_WDT_MOD_WDRESET;
+	writel(val, lpc18xx_wdt->base + LPC18XX_WDT_MOD);
+
+	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+	writel(LPC18XX_WDT_FEED_MAGIC2, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+
+	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+	writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
+
+	spin_unlock_irqrestore(&lpc18xx_wdt->lock, flags);
+
+	return NOTIFY_OK;
+}
+
+static int lpc18xx_wdt_probe(struct platform_device *pdev)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	lpc18xx_wdt = devm_kzalloc(dev, sizeof(*lpc18xx_wdt), GFP_KERNEL);
+	if (!lpc18xx_wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lpc18xx_wdt->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(lpc18xx_wdt->base))
+		return PTR_ERR(lpc18xx_wdt->base);
+
+	lpc18xx_wdt->reg_clk = devm_clk_get(dev, "reg");
+	if (IS_ERR(lpc18xx_wdt->reg_clk)) {
+		dev_err(dev, "failed to get the reg clock\n");
+		return PTR_ERR(lpc18xx_wdt->reg_clk);
+	}
+
+	lpc18xx_wdt->wdt_clk = devm_clk_get(dev, "wdtclk");
+	if (IS_ERR(lpc18xx_wdt->wdt_clk)) {
+		dev_err(dev, "failed to get the wdt clock\n");
+		return PTR_ERR(lpc18xx_wdt->wdt_clk);
+	}
+
+	ret = clk_prepare_enable(lpc18xx_wdt->reg_clk);
+	if (ret) {
+		dev_err(dev, "could not prepare or enable sys clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(lpc18xx_wdt->wdt_clk);
+	if (ret) {
+		dev_err(dev, "could not prepare or enable wdt clock\n");
+		goto disable_reg_clk;
+	}
+
+	/* We use the clock rate to calculate timeouts */
+	lpc18xx_wdt->clk_rate = clk_get_rate(lpc18xx_wdt->wdt_clk);
+	if (lpc18xx_wdt->clk_rate == 0) {
+		dev_err(dev, "failed to get clock rate\n");
+		ret = -EINVAL;
+		goto disable_wdt_clk;
+	}
+
+	lpc18xx_wdt->wdt_dev.info = &lpc18xx_wdt_info;
+	lpc18xx_wdt->wdt_dev.ops = &lpc18xx_wdt_ops;
+
+	lpc18xx_wdt->wdt_dev.min_timeout = DIV_ROUND_UP(LPC18XX_WDT_TC_MIN *
+				LPC18XX_WDT_CLK_DIV, lpc18xx_wdt->clk_rate);
+
+	lpc18xx_wdt->wdt_dev.max_timeout = (LPC18XX_WDT_TC_MAX *
+				LPC18XX_WDT_CLK_DIV) / lpc18xx_wdt->clk_rate;
+
+	lpc18xx_wdt->wdt_dev.timeout = min(lpc18xx_wdt->wdt_dev.max_timeout,
+					   LPC18XX_WDT_DEF_TIMEOUT);
+
+	spin_lock_init(&lpc18xx_wdt->lock);
+
+	lpc18xx_wdt->wdt_dev.parent = dev;
+	watchdog_set_drvdata(&lpc18xx_wdt->wdt_dev, lpc18xx_wdt);
+
+	ret = watchdog_init_timeout(&lpc18xx_wdt->wdt_dev, heartbeat, dev);
+
+	__lpc18xx_wdt_set_timeout(lpc18xx_wdt);
+
+	setup_timer(&lpc18xx_wdt->timer, lpc18xx_wdt_timer_feed,
+		    (unsigned long)&lpc18xx_wdt->wdt_dev);
+
+	watchdog_set_nowayout(&lpc18xx_wdt->wdt_dev, nowayout);
+
+	platform_set_drvdata(pdev, lpc18xx_wdt);
+
+	ret = watchdog_register_device(&lpc18xx_wdt->wdt_dev);
+	if (ret)
+		goto disable_wdt_clk;
+
+	lpc18xx_wdt->restart_handler.notifier_call = lpc18xx_wdt_restart;
+	lpc18xx_wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&lpc18xx_wdt->restart_handler);
+	if (ret)
+		dev_warn(dev, "failed to register restart handler: %d\n", ret);
+
+	return 0;
+
+disable_wdt_clk:
+	clk_disable_unprepare(lpc18xx_wdt->wdt_clk);
+disable_reg_clk:
+	clk_disable_unprepare(lpc18xx_wdt->reg_clk);
+	return ret;
+}
+
+static void lpc18xx_wdt_shutdown(struct platform_device *pdev)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
+
+	lpc18xx_wdt_stop(&lpc18xx_wdt->wdt_dev);
+}
+
+static int lpc18xx_wdt_remove(struct platform_device *pdev)
+{
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&lpc18xx_wdt->restart_handler);
+
+	dev_warn(&pdev->dev, "I quit now, hardware will probably reboot!\n");
+	del_timer(&lpc18xx_wdt->timer);
+
+	watchdog_unregister_device(&lpc18xx_wdt->wdt_dev);
+	clk_disable_unprepare(lpc18xx_wdt->wdt_clk);
+	clk_disable_unprepare(lpc18xx_wdt->reg_clk);
+
+	return 0;
+}
+
+static const struct of_device_id lpc18xx_wdt_match[] = {
+	{ .compatible = "nxp,lpc1850-wwdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lpc18xx_wdt_match);
+
+static struct platform_driver lpc18xx_wdt_driver = {
+	.driver = {
+		.name = "lpc18xx-wdt",
+		.of_match_table	= lpc18xx_wdt_match,
+	},
+	.probe = lpc18xx_wdt_probe,
+	.remove = lpc18xx_wdt_remove,
+	.shutdown = lpc18xx_wdt_shutdown,
+};
+module_platform_driver(lpc18xx_wdt_driver);
+
+MODULE_AUTHOR("Ariel D'Alessandro <ariel@vanguardiasur.com.ar>");
+MODULE_DESCRIPTION("NXP LPC18xx Watchdog Timer Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index d193a5e..6901300 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -197,6 +197,7 @@ static int a21_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&a21_wdt, 30, &pdev->dev);
 	watchdog_set_nowayout(&a21_wdt, nowayout);
 	watchdog_set_drvdata(&a21_wdt, drv);
+	a21_wdt.parent = &pdev->dev;
 
 	reset = a21_wdt_get_bootstatus(drv);
 	if (reset == 2)
diff --git a/drivers/watchdog/menf21bmc_wdt.c b/drivers/watchdog/menf21bmc_wdt.c
index 59f0913..3aefdde 100644
--- a/drivers/watchdog/menf21bmc_wdt.c
+++ b/drivers/watchdog/menf21bmc_wdt.c
@@ -130,6 +130,7 @@ static int menf21bmc_wdt_probe(struct platform_device *pdev)
 	drv_data->wdt.info = &menf21bmc_wdt_info;
 	drv_data->wdt.min_timeout = BMC_WD_TIMEOUT_MIN;
 	drv_data->wdt.max_timeout = BMC_WD_TIMEOUT_MAX;
+	drv_data->wdt.parent = &pdev->dev;
 	drv_data->i2c_client = i2c_client;
 
 	/*
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 689381a..5f2273a 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -50,8 +50,12 @@ struct mpc8xxx_wdt_type {
 	bool hw_enabled;
 };
 
-static struct mpc8xxx_wdt __iomem *wd_base;
-static int mpc8xxx_wdt_init_late(void);
+struct mpc8xxx_wdt_ddata {
+	struct mpc8xxx_wdt __iomem *base;
+	struct watchdog_device wdd;
+	struct timer_list timer;
+	spinlock_t lock;
+};
 
 static u16 timeout = 0xffff;
 module_param(timeout, ushort, 0);
@@ -68,65 +72,59 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 		 "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-/*
- * We always prescale, but if someone really doesn't want to they can set this
- * to 0
- */
-static int prescale = 1;
-
-static DEFINE_SPINLOCK(wdt_spinlock);
-
-static void mpc8xxx_wdt_keepalive(void)
+static void mpc8xxx_wdt_keepalive(struct mpc8xxx_wdt_ddata *ddata)
 {
 	/* Ping the WDT */
-	spin_lock(&wdt_spinlock);
-	out_be16(&wd_base->swsrr, 0x556c);
-	out_be16(&wd_base->swsrr, 0xaa39);
-	spin_unlock(&wdt_spinlock);
+	spin_lock(&ddata->lock);
+	out_be16(&ddata->base->swsrr, 0x556c);
+	out_be16(&ddata->base->swsrr, 0xaa39);
+	spin_unlock(&ddata->lock);
 }
 
-static struct watchdog_device mpc8xxx_wdt_dev;
-static void mpc8xxx_wdt_timer_ping(unsigned long arg);
-static DEFINE_TIMER(wdt_timer, mpc8xxx_wdt_timer_ping, 0,
-		(unsigned long)&mpc8xxx_wdt_dev);
-
 static void mpc8xxx_wdt_timer_ping(unsigned long arg)
 {
-	struct watchdog_device *w = (struct watchdog_device *)arg;
+	struct mpc8xxx_wdt_ddata *ddata = (void *)arg;
 
-	mpc8xxx_wdt_keepalive();
+	mpc8xxx_wdt_keepalive(ddata);
 	/* We're pinging it twice faster than needed, just to be sure. */
-	mod_timer(&wdt_timer, jiffies + HZ * w->timeout / 2);
+	mod_timer(&ddata->timer, jiffies + HZ * ddata->wdd.timeout / 2);
 }
 
 static int mpc8xxx_wdt_start(struct watchdog_device *w)
 {
-	u32 tmp = SWCRR_SWEN;
+	struct mpc8xxx_wdt_ddata *ddata =
+		container_of(w, struct mpc8xxx_wdt_ddata, wdd);
+
+	u32 tmp = SWCRR_SWEN | SWCRR_SWPR;
 
 	/* Good, fire up the show */
-	if (prescale)
-		tmp |= SWCRR_SWPR;
 	if (reset)
 		tmp |= SWCRR_SWRI;
 
 	tmp |= timeout << 16;
 
-	out_be32(&wd_base->swcrr, tmp);
+	out_be32(&ddata->base->swcrr, tmp);
 
-	del_timer_sync(&wdt_timer);
+	del_timer_sync(&ddata->timer);
 
 	return 0;
 }
 
 static int mpc8xxx_wdt_ping(struct watchdog_device *w)
 {
-	mpc8xxx_wdt_keepalive();
+	struct mpc8xxx_wdt_ddata *ddata =
+		container_of(w, struct mpc8xxx_wdt_ddata, wdd);
+
+	mpc8xxx_wdt_keepalive(ddata);
 	return 0;
 }
 
 static int mpc8xxx_wdt_stop(struct watchdog_device *w)
 {
-	mod_timer(&wdt_timer, jiffies);
+	struct mpc8xxx_wdt_ddata *ddata =
+		container_of(w, struct mpc8xxx_wdt_ddata, wdd);
+
+	mod_timer(&ddata->timer, jiffies);
 	return 0;
 }
 
@@ -143,53 +141,57 @@ static struct watchdog_ops mpc8xxx_wdt_ops = {
 	.stop = mpc8xxx_wdt_stop,
 };
 
-static struct watchdog_device mpc8xxx_wdt_dev = {
-	.info = &mpc8xxx_wdt_info,
-	.ops = &mpc8xxx_wdt_ops,
-};
-
-static const struct of_device_id mpc8xxx_wdt_match[];
 static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 {
 	int ret;
-	const struct of_device_id *match;
-	struct device_node *np = ofdev->dev.of_node;
+	struct resource *res;
 	const struct mpc8xxx_wdt_type *wdt_type;
+	struct mpc8xxx_wdt_ddata *ddata;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
 	unsigned int timeout_sec;
 
-	match = of_match_device(mpc8xxx_wdt_match, &ofdev->dev);
-	if (!match)
+	wdt_type = of_device_get_match_data(&ofdev->dev);
+	if (!wdt_type)
 		return -EINVAL;
-	wdt_type = match->data;
 
 	if (!freq || freq == -1)
 		return -EINVAL;
 
-	wd_base = of_iomap(np, 0);
-	if (!wd_base)
+	ddata = devm_kzalloc(&ofdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
 		return -ENOMEM;
 
-	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
+	ddata->base = devm_ioremap_resource(&ofdev->dev, res);
+	if (IS_ERR(ddata->base))
+		return PTR_ERR(ddata->base);
+
+	enabled = in_be32(&ddata->base->swcrr) & SWCRR_SWEN;
 	if (!enabled && wdt_type->hw_enabled) {
 		pr_info("could not be enabled in software\n");
-		ret = -ENOSYS;
-		goto err_unmap;
+		return -ENODEV;
 	}
 
+	spin_lock_init(&ddata->lock);
+	setup_timer(&ddata->timer, mpc8xxx_wdt_timer_ping,
+		    (unsigned long)ddata);
+
+	ddata->wdd.info = &mpc8xxx_wdt_info,
+	ddata->wdd.ops = &mpc8xxx_wdt_ops,
+
 	/* Calculate the timeout in seconds */
-	if (prescale)
-		timeout_sec = (timeout * wdt_type->prescaler) / freq;
-	else
-		timeout_sec = timeout / freq;
-
-	mpc8xxx_wdt_dev.timeout = timeout_sec;
-#ifdef MODULE
-	ret = mpc8xxx_wdt_init_late();
-	if (ret)
-		goto err_unmap;
-#endif
+	timeout_sec = (timeout * wdt_type->prescaler) / freq;
+
+	ddata->wdd.timeout = timeout_sec;
+
+	watchdog_set_nowayout(&ddata->wdd, nowayout);
+
+	ret = watchdog_register_device(&ddata->wdd);
+	if (ret) {
+		pr_err("cannot register watchdog device (err=%d)\n", ret);
+		return ret;
+	}
 
 	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d (%d seconds)\n",
 		reset ? "reset" : "interrupt", timeout, timeout_sec);
@@ -200,21 +202,20 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	 * userspace handles it.
 	 */
 	if (enabled)
-		mod_timer(&wdt_timer, jiffies);
+		mod_timer(&ddata->timer, jiffies);
+
+	platform_set_drvdata(ofdev, ddata);
 	return 0;
-err_unmap:
-	iounmap(wd_base);
-	wd_base = NULL;
-	return ret;
 }
 
 static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
 {
+	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
+
 	pr_crit("Watchdog removed, expect the %s soon!\n",
 		reset ? "reset" : "machine check exception");
-	del_timer_sync(&wdt_timer);
-	watchdog_unregister_device(&mpc8xxx_wdt_dev);
-	iounmap(wd_base);
+	del_timer_sync(&ddata->timer);
+	watchdog_unregister_device(&ddata->wdd);
 
 	return 0;
 }
@@ -253,31 +254,6 @@ static struct platform_driver mpc8xxx_wdt_driver = {
 	},
 };
 
-/*
- * We do wdt initialization in two steps: arch_initcall probes the wdt
- * very early to start pinging the watchdog (misc devices are not yet
- * available), and later module_init() just registers the misc device.
- */
-static int mpc8xxx_wdt_init_late(void)
-{
-	int ret;
-
-	if (!wd_base)
-		return -ENODEV;
-
-	watchdog_set_nowayout(&mpc8xxx_wdt_dev, nowayout);
-
-	ret = watchdog_register_device(&mpc8xxx_wdt_dev);
-	if (ret) {
-		pr_err("cannot register watchdog device (err=%d)\n", ret);
-		return ret;
-	}
-	return 0;
-}
-#ifndef MODULE
-module_init(mpc8xxx_wdt_init_late);
-#endif
-
 static int __init mpc8xxx_wdt_init(void)
 {
 	return platform_driver_register(&mpc8xxx_wdt_driver);
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 938b987..6ad9df9 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -210,6 +210,14 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void mtk_wdt_shutdown(struct platform_device *pdev)
+{
+	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
+
+	if (watchdog_active(&mtk_wdt->wdt_dev))
+		mtk_wdt_stop(&mtk_wdt->wdt_dev);
+}
+
 static int mtk_wdt_remove(struct platform_device *pdev)
 {
 	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
@@ -221,17 +229,48 @@ static int mtk_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mtk_wdt_suspend(struct device *dev)
+{
+	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&mtk_wdt->wdt_dev))
+		mtk_wdt_stop(&mtk_wdt->wdt_dev);
+
+	return 0;
+}
+
+static int mtk_wdt_resume(struct device *dev)
+{
+	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&mtk_wdt->wdt_dev)) {
+		mtk_wdt_start(&mtk_wdt->wdt_dev);
+		mtk_wdt_ping(&mtk_wdt->wdt_dev);
+	}
+
+	return 0;
+}
+#endif
+
 static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
 
+static const struct dev_pm_ops mtk_wdt_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
+				mtk_wdt_resume)
+};
+
 static struct platform_driver mtk_wdt_driver = {
 	.probe		= mtk_wdt_probe,
 	.remove		= mtk_wdt_remove,
+	.shutdown	= mtk_wdt_shutdown,
 	.driver		= {
 		.name		= DRV_NAME,
+		.pm		= &mtk_wdt_pm_ops,
 		.of_match_table	= mtk_wdt_dt_ids,
 	},
 };
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index c028454..bd917bb 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -294,6 +294,8 @@ static const struct pci_device_id tco_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS,
 	  PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS,
+	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, tco_pci_tbl);
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index de911c7..d96bee0 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -253,6 +253,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	wdev->wdog.ops = &omap_wdt_ops;
 	wdev->wdog.min_timeout = TIMER_MARGIN_MIN;
 	wdev->wdog.max_timeout = TIMER_MARGIN_MAX;
+	wdev->wdog.parent = &pdev->dev;
 
 	if (watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev) < 0)
 		wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ef0c628..c6b8f4a 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -567,6 +567,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	dev->wdt.timeout = wdt_max_duration;
 	dev->wdt.max_timeout = wdt_max_duration;
+	dev->wdt.parent = &pdev->dev;
 	watchdog_init_timeout(&dev->wdt, heartbeat, &pdev->dev);
 
 	platform_set_drvdata(pdev, &dev->wdt);
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index b9c6049..4224b3e 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -167,6 +167,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
+	pnx4008_wdd.parent = &pdev->dev;
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
 
 	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index aa03ca8..773dcfa 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -171,6 +171,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.ops = &qcom_wdt_ops;
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
+	wdt->wdd.parent = &pdev->dev;
 
 	/*
 	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
index b7c68e2..39cd51d 100644
--- a/drivers/watchdog/retu_wdt.c
+++ b/drivers/watchdog/retu_wdt.c
@@ -127,6 +127,7 @@ static int retu_wdt_probe(struct platform_device *pdev)
 	retu_wdt->timeout	= RETU_WDT_MAX_TIMER;
 	retu_wdt->min_timeout	= 0;
 	retu_wdt->max_timeout	= RETU_WDT_MAX_TIMER;
+	retu_wdt->parent	= &pdev->dev;
 
 	watchdog_set_drvdata(retu_wdt, wdev);
 	watchdog_set_nowayout(retu_wdt, nowayout);
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index a6f7e2e..1967919 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -161,6 +161,7 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 	rt288x_wdt_dev.dev = &pdev->dev;
 	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
 	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
+	rt288x_wdt_dev.parent = &pdev->dev;
 
 	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
 			      &pdev->dev);
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index e89ae02..d781000 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -607,6 +607,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
 
 	wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
+	wdt->wdt_device.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&wdt->wdt_device);
 	if (ret) {
diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
new file mode 100644
index 0000000..a49634c
--- /dev/null
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -0,0 +1,280 @@
+/*
+ * Driver for Atmel SAMA5D4 Watchdog Timer
+ *
+ * Copyright (C) 2015 Atmel Corporation
+ *
+ * Licensed under GPLv2.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+#include "at91sam9_wdt.h"
+
+/* minimum and maximum watchdog timeout, in seconds */
+#define MIN_WDT_TIMEOUT		1
+#define MAX_WDT_TIMEOUT		16
+#define WDT_DEFAULT_TIMEOUT	MAX_WDT_TIMEOUT
+
+#define WDT_SEC2TICKS(s)	((s) ? (((s) << 8) - 1) : 0)
+
+struct sama5d4_wdt {
+	struct watchdog_device	wdd;
+	void __iomem		*reg_base;
+	u32	config;
+};
+
+static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+module_param(wdt_timeout, int, 0);
+MODULE_PARM_DESC(wdt_timeout,
+	"Watchdog timeout in seconds. (default = "
+	__MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+	"Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+#define wdt_read(wdt, field) \
+	readl_relaxed((wdt)->reg_base + (field))
+
+#define wdt_write(wtd, field, val) \
+	writel_relaxed((val), (wdt)->reg_base + (field))
+
+static int sama5d4_wdt_start(struct watchdog_device *wdd)
+{
+	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 reg;
+
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	reg &= ~AT91_WDT_WDDIS;
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	return 0;
+}
+
+static int sama5d4_wdt_stop(struct watchdog_device *wdd)
+{
+	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 reg;
+
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	reg |= AT91_WDT_WDDIS;
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	return 0;
+}
+
+static int sama5d4_wdt_ping(struct watchdog_device *wdd)
+{
+	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
+
+	return 0;
+}
+
+static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
+				 unsigned int timeout)
+{
+	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 value = WDT_SEC2TICKS(timeout);
+	u32 reg;
+
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	reg &= ~AT91_WDT_WDV;
+	reg &= ~AT91_WDT_WDD;
+	reg |= AT91_WDT_SET_WDV(value);
+	reg |= AT91_WDT_SET_WDD(value);
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	wdd->timeout = timeout;
+
+	return 0;
+}
+
+static const struct watchdog_info sama5d4_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "Atmel SAMA5D4 Watchdog",
+};
+
+static struct watchdog_ops sama5d4_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = sama5d4_wdt_start,
+	.stop = sama5d4_wdt_stop,
+	.ping = sama5d4_wdt_ping,
+	.set_timeout = sama5d4_wdt_set_timeout,
+};
+
+static irqreturn_t sama5d4_wdt_irq_handler(int irq, void *dev_id)
+{
+	struct sama5d4_wdt *wdt = platform_get_drvdata(dev_id);
+
+	if (wdt_read(wdt, AT91_WDT_SR)) {
+		pr_crit("Atmel Watchdog Software Reset\n");
+		emergency_restart();
+		pr_crit("Reboot didn't succeed\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int of_sama5d4_wdt_init(struct device_node *np, struct sama5d4_wdt *wdt)
+{
+	const char *tmp;
+
+	wdt->config = AT91_WDT_WDDIS;
+
+	if (!of_property_read_string(np, "atmel,watchdog-type", &tmp) &&
+	    !strcmp(tmp, "software"))
+		wdt->config |= AT91_WDT_WDFIEN;
+	else
+		wdt->config |= AT91_WDT_WDRSTEN;
+
+	if (of_property_read_bool(np, "atmel,idle-halt"))
+		wdt->config |= AT91_WDT_WDIDLEHLT;
+
+	if (of_property_read_bool(np, "atmel,dbg-halt"))
+		wdt->config |= AT91_WDT_WDDBGHLT;
+
+	return 0;
+}
+
+static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
+{
+	struct watchdog_device *wdd = &wdt->wdd;
+	u32 value = WDT_SEC2TICKS(wdd->timeout);
+	u32 reg;
+
+	/*
+	 * Because the fields WDV and WDD must not be modified when the WDDIS
+	 * bit is set, so clear the WDDIS bit before writing the WDT_MR.
+	 */
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	reg &= ~AT91_WDT_WDDIS;
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	reg = wdt->config;
+	reg |= AT91_WDT_SET_WDD(value);
+	reg |= AT91_WDT_SET_WDV(value);
+
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	return 0;
+}
+
+static int sama5d4_wdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd;
+	struct sama5d4_wdt *wdt;
+	struct resource *res;
+	void __iomem *regs;
+	u32 irq = 0;
+	int ret;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdd = &wdt->wdd;
+	wdd->timeout = wdt_timeout;
+	wdd->info = &sama5d4_wdt_info;
+	wdd->ops = &sama5d4_wdt_ops;
+	wdd->min_timeout = MIN_WDT_TIMEOUT;
+	wdd->max_timeout = MAX_WDT_TIMEOUT;
+
+	watchdog_set_drvdata(wdd, wdt);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	wdt->reg_base = regs;
+
+	if (pdev->dev.of_node) {
+		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+		if (!irq)
+			dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
+
+		ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
+		if (ret)
+			return ret;
+	}
+
+	if ((wdt->config & AT91_WDT_WDFIEN) && irq) {
+		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
+				       IRQF_SHARED | IRQF_IRQPOLL |
+				       IRQF_NO_SUSPEND, pdev->name, pdev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"cannot register interrupt handler\n");
+			return ret;
+		}
+	}
+
+	ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to set timeout value\n");
+		return ret;
+	}
+
+	ret = sama5d4_wdt_init(wdt);
+	if (ret)
+		return ret;
+
+	watchdog_set_nowayout(wdd, nowayout);
+
+	ret = watchdog_register_device(wdd);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register watchdog device\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+
+	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
+		 wdt_timeout, nowayout);
+
+	return 0;
+}
+
+static int sama5d4_wdt_remove(struct platform_device *pdev)
+{
+	struct sama5d4_wdt *wdt = platform_get_drvdata(pdev);
+
+	sama5d4_wdt_stop(&wdt->wdd);
+
+	watchdog_unregister_device(&wdt->wdd);
+
+	return 0;
+}
+
+static const struct of_device_id sama5d4_wdt_of_match[] = {
+	{ .compatible = "atmel,sama5d4-wdt", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sama5d4_wdt_of_match);
+
+static struct platform_driver sama5d4_wdt_driver = {
+	.probe		= sama5d4_wdt_probe,
+	.remove		= sama5d4_wdt_remove,
+	.driver		= {
+		.name	= "sama5d4_wdt",
+		.of_match_table = sama5d4_wdt_of_match,
+	}
+};
+module_platform_driver(sama5d4_wdt_driver);
+
+MODULE_AUTHOR("Atmel Corporation");
+MODULE_DESCRIPTION("Atmel SAMA5D4 Watchdog Timer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 567458b..f908121 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -252,6 +252,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&sh_wdt_dev, nowayout);
 	watchdog_set_drvdata(&sh_wdt_dev, wdt);
+	sh_wdt_dev.parent = &pdev->dev;
 
 	spin_lock_init(&wdt->lock);
 
diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 42fa5c0..d0578ab 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -154,6 +154,7 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
 	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
+	sirfsoc_wdd.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&sirfsoc_wdd);
 	if (ret)
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 4e7fec3..01d8162 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -226,6 +226,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	wdt->adev = adev;
 	wdt->wdd.info = &wdt_info;
 	wdt->wdd.ops = &wdt_ops;
+	wdt->wdd.parent = &adev->dev;
 
 	spin_lock_init(&wdt->lock);
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 6785afd..14e9bad 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -241,6 +241,7 @@ static int st_wdog_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	st_wdog_dev.max_timeout = 0xFFFFFFFF / st_wdog->clkrate;
+	st_wdog_dev.parent = &pdev->dev;
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index e7f0d5b..3ee6128 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -76,6 +76,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
 
 	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, STMP3XXX_MAX_TIMEOUT);
+	stmp3xxx_wdd.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&stmp3xxx_wdd);
 	if (ret < 0) {
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index a29afb3..47bd8a1 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -184,7 +184,7 @@ static int sunxi_wdt_start(struct watchdog_device *wdt_dev)
 	/* Set system reset function */
 	reg = readl(wdt_base + regs->wdt_cfg);
 	reg &= ~(regs->wdt_reset_mask);
-	reg |= ~(regs->wdt_reset_val);
+	reg |= regs->wdt_reset_val;
 	writel(reg, wdt_base + regs->wdt_cfg);
 
 	/* Enable watchdog */
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 30451ea..7f97cdd 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -218,6 +218,7 @@ static int tegra_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &tegra_wdt_ops;
 	wdd->min_timeout = MIN_WDT_TIMEOUT;
 	wdd->max_timeout = MAX_WDT_TIMEOUT;
+	wdd->parent = &pdev->dev;
 
 	watchdog_set_drvdata(wdd, wdt);
 
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 2c1db6f..9bf3cc0 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -83,6 +83,7 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
 	wdt->timeout		= 30;
 	wdt->min_timeout	= 1;
 	wdt->max_timeout	= 30;
+	wdt->parent = &pdev->dev;
 
 	watchdog_set_nowayout(wdt, nowayout);
 	platform_set_drvdata(pdev, wdt);
diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index 7f61593..c2da880 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -131,6 +131,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 	txx9wdt.timeout = timeout;
 	txx9wdt.min_timeout = 1;
 	txx9wdt.max_timeout = WD_MAX_TIMEOUT;
+	txx9wdt.parent = &dev->dev;
 	watchdog_set_nowayout(&txx9wdt, nowayout);
 
 	ret = watchdog_register_device(&txx9wdt);
diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index 9de09ab..37c0843 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -96,6 +96,7 @@ static int ux500_wdt_probe(struct platform_device *pdev)
 			ux500_wdt.max_timeout = WATCHDOG_MAX28;
 	}
 
+	ux500_wdt.parent = &pdev->dev;
 	watchdog_set_nowayout(&ux500_wdt, nowayout);
 
 	/* disable auto off on sleep */
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index 56369c4..5f9cbc3 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -206,6 +206,7 @@ static int wdt_probe(struct pci_dev *pdev,
 		timeout = WDT_TIMEOUT;
 
 	wdt_dev.timeout = timeout;
+	wdt_dev.parent = &pdev->dev;
 	watchdog_set_nowayout(&wdt_dev, nowayout);
 	if (readl(wdt_mem) & VIA_WDT_FIRED)
 		wdt_dev.bootstatus |= WDIOF_CARDRESET;
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 2fa17e7..8d1184a 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -215,6 +215,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 
 	wm831x_wdt->info = &wm831x_wdt_info;
 	wm831x_wdt->ops = &wm831x_wdt_ops;
+	wm831x_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(wm831x_wdt, nowayout);
 	watchdog_set_drvdata(wm831x_wdt, driver_data);
 
diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index 34d272a..4ab4b83 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -151,6 +151,7 @@ static int wm8350_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&wm8350_wdt, nowayout);
 	watchdog_set_drvdata(&wm8350_wdt, wm8350);
+	wm8350_wdt.parent = &pdev->dev;
 
 	/* Default to 4s timeout */
 	wm8350_wdt_set_timeout(&wm8350_wdt, 4);
