Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sun, 31 Jul 2016 15:12:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alexey Kunitskiy <alexey.kv@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Brian Boylston <brian.boylston@hpe.com>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>, Ji-Ze Hong <hpeter@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Matthew McClintock <mmcclint@codeaurora.org>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Pratyush Anand <panand@redhat.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Stefan Christ <s.christ@phytec.de>,
	Timur Tabi <timur@codeaurora.org>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wei Yongjun <weiyj.lk@gmail.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yong@spo001.leaseweb.nl, Jonathan <jonathan.yong@intel.com>
Subject: [GIT PULL REQUEST] watchdog - v4.8 Merge Window
Message-ID: <20160731131246.GA15010@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

This pull request contains
* New driver for the watchdog in Aspeed SoCs
* New driver for the watchdog in Maxim PMIC MAX77620
* New driver for the watchdog in Amlogic Meson GXBB SoC
* Support for the r8a7796 watchdog device
* Support for F81866 watchdog device
* Support for 5th variation of Apollo Lake
* Support for MCP78S chipset
* clean-up of softdog.c watchdog device driver
* pic32-wdt and pic32-dmt fixes
* core: min and max timeout improvements, WDOG_HW_RUNNING improvements, status funtionality
* core: Add a device managed API for watchdog_register_device()
* Documentation/watchdog: watchdog-test improvements
* Several other fixes and improvements

This will update the following files:

 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt     |   16 
 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt |   16 
 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt       |    4 
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt    |    5 
 Documentation/driver-model/devres.txt                         |    3 
 Documentation/watchdog/hpwdt.txt                              |    5 
 Documentation/watchdog/src/watchdog-test.c                    |   39 -
 Documentation/watchdog/watchdog-kernel-api.txt                |    9 
 MAINTAINERS                                                   |    6 
 arch/arm/boot/dts/qcom-apq8064.dtsi                           |    3 
 arch/arm/boot/dts/qcom-ipq4019.dtsi                           |    2 
 arch/arm/boot/dts/qcom-ipq8064.dtsi                           |    3 
 arch/arm/boot/dts/qcom-msm8960.dtsi                           |    3 
 drivers/platform/x86/intel_pmc_ipc.c                          |   10 
 drivers/watchdog/Kconfig                                      |   33 +
 drivers/watchdog/Makefile                                     |    3 
 drivers/watchdog/aspeed_wdt.c                                 |  212 +++++++
 drivers/watchdog/bcm2835_wdt.c                                |   11 
 drivers/watchdog/da9063_wdt.c                                 |    2 
 drivers/watchdog/f71808e_wdt.c                                |   28 -
 drivers/watchdog/gpio_wdt.c                                   |    2 
 drivers/watchdog/iTCO_wdt.c                                   |    2 
 drivers/watchdog/max77620_wdt.c                               |  227 ++++++++
 drivers/watchdog/meson_gxbb_wdt.c                             |  270 ++++++++++
 drivers/watchdog/nv_tco.c                                     |    2 
 drivers/watchdog/pcwd.c                                       |   14 
 drivers/watchdog/pic32-dmt.c                                  |    5 
 drivers/watchdog/pic32-wdt.c                                  |    9 
 drivers/watchdog/qcom-wdt.c                                   |   69 +-
 drivers/watchdog/sbsa_gwdt.c                                  |   16 
 drivers/watchdog/sirfsoc_wdt.c                                |   15 
 drivers/watchdog/softdog.c                                    |   92 ---
 drivers/watchdog/tangox_wdt.c                                 |    4 
 drivers/watchdog/watchdog_core.c                              |   39 +
 drivers/watchdog/watchdog_dev.c                               |   61 +-
 drivers/watchdog/ziirave_wdt.c                                |    2 
 include/linux/watchdog.h                                      |    6 
 37 files changed, 1062 insertions(+), 186 deletions(-)

with these Changes:

commit 1ac06563434e5f3302259608d3589bf7002431fe
Author: Wei Yongjun <weiyj.lk@gmail.com>
Date:   Tue Jul 26 14:50:14 2016 +0000

    watchdog: gpio_wdt: Fix missing platform_set_drvdata() in gpio_wdt_probe()
    
    Add missing platform_set_drvdata() in gpio_wdt_probe(), otherwise
    calling platform_get_drvdata() in remove returns NULL.
    
    This is detected by Coccinelle semantic patch.
    
    Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3c10bbde10fe4dca52726e246cefa6b0a1dfbd3e
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Thu Jul 21 14:21:56 2016 -0700

    watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function
    
    WDOG_HW_RUNNING indicates that the hardware watchdog is running while the
    watchdog device is closed. The flag may be set by the driver when it is
    instantiated to indicate that the watchdog is running, and that the
    watchdog core needs to send heartbeat requests to the driver until the
    watchdog device is opened.
    
    When the watchdog device is closed, the flag can be used by the driver's
    stop function to indicate to the watchdog core that it was unable to stop
    the watchdog, and that the watchdog core needs to send heartbeat requests.
    This only works if the flag is actually cleared when the watchdog is
    stopped. To avoid having to clear the flag in each driver's stop function,
    clear it in the watchdog core before calling the stop function.
    
    Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 138913cb632be12344982e54ccd12f6f15971bf7
Author: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date:   Tue Jul 19 11:22:34 2016 +0000

    watchdog: core: Fix error handling of watchdog_dev_init()
    
    Fix the error handling paths of watchdog_dev_init().
    
    Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit cddd74db8d42b953a0612810f07c99e73deab185
Author: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date:   Tue Jul 19 11:21:56 2016 +0000

    watchdog: pic32-wdt: Fix return value check in pic32_wdt_drv_probe()
    
    In case of error, the function devm_ioremap() returns NULL pointer
    not ERR_PTR(). The IS_ERR() test in the return value check should
    be replaced with NULL test.
    
    Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 919edd5119796f1cc3b47f23e7e15cc0f46942ba
Author: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date:   Tue Jul 19 11:35:11 2016 +0000

    watchdog: pic32-dmt: Remove .owner field for driver
    
    Remove .owner field if calls are used which set it automatically.
    
    Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci
    
    Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit aa4614d15990fcbe93969dee600361d47d28885f
Author: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date:   Tue Jul 19 11:35:19 2016 +0000

    watchdog: pic32-wdt: Remove .owner field for driver
    
    Remove .owner field if calls are used which set it automatically.
    
    Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci
    
    Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c682b5cb7ee0d5430e952956603888d7ffebc27a
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Tue Jul 19 13:46:54 2016 +0200

    watchdog: renesas-wdt: Add support for the r8a7796 wdt
    
    Document support for the Watchdog Timer (WDT) Controller in the Renesas
    R-Car M3-W (r8a7796) SoC.
    
    No driver update is needed.
    
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9dd8d5f870f44597c67d0e5f72753b9d02810308
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Jul 19 17:41:22 2016 +0200

    Documentation/watchdog: check return value for magic close
    
    A recent commit added a write to the watchdog test code for doing the "magic
    close", but that caused a compile-time warning:
    
    Documentation/watchdog/src/watchdog-test.c: In function ‘main’:
    Documentation/watchdog/src/watchdog-test.c:94:5: warning: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Wunused-result]
    
    This changes the code to print a runtime warning if the write fails.
    
    Fixes: 5a2d3de19602 ("Documentation/watchdog: add support for magic close to watchdog-test")
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Timur Tabi <timur@codeaurora.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e035d8f787b1de664fcac5eb84643f8c374284c4
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Jul 17 15:04:12 2016 -0700

    watchdog: sbsa: Drop status function
    
    The watchdog status function is supposed to return WDIOF_ flags,
    not internal status flags. The available WDIOF_ flags are now
    returned by the watchdog core, so the status function in this driver
    is unnecessary.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 90b826f17a4e1c4ff2b3ef69512a6409e94f4d64
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Jul 17 15:04:11 2016 -0700

    watchdog: Implement status function in watchdog core
    
    Up to now, the watchdog status function called a driver function,
    which was supposed to return the watchdog status. All but one
    driver using the watchdog core did not implement this function,
    and the driver implementing it did not implement it correctly
    (the function is supposed to return WDIOF_ flags). At the same time,
    at least some of the status information can be provided by the watchdog
    core.
    
    Provide the available status bits directly from the watchdog driver core.
    Call the driver status function if it exists to get the boot status, but
    always provide WDIOF_MAGICCLOSE and WDIOF_KEEPALIVEPING internally.
    This patch makes the 'status' sysfs attribute always available.
    This attribute is now displayed as hex number with 0x prepended to be
    easier to decode.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c7ef68c32265a396a4d977f896a11a4cebb0ace4
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Jul 17 13:47:47 2016 -0700

    watchdog: tangox: Set max_hw_heartbeat_ms instead of max_timeout
    
    Setting max_hw_heartbeat_ms lets the watchdog core provide a virtual
    timeout if the timeout requested by user space is larger than the maximum
    hardware timeout. Also, it helps the watchdog core to provide heartbeats
    if the hardware watchdog is running while closed.
    
    Fixes: a3e376d26ace ("watchdog: tangox: Mark running watchdog correctly")
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3fbfe9264756d3fd99a9210345016c94ec4ada73
Author: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Thu Jul 14 11:16:26 2016 +0200

    watchdog: change watchdog_need_worker logic
    
    If the driver indicates that the watchdog is running, the framework
    should feed it until userspace opens the device, regardless of whether
    the driver has set max_hw_heartbeat_ms.
    
    This patch only affects the case where wdd->max_hw_heartbeat_ms is
    zero, wdd->timeout is non-zero, the watchdog is not active and the
    hardware device is running (*):
    
    - If wdd->timeout is zero, watchdog_need_worker() returns false both
    before and after this patch, and watchdog_next_keepalive() is not
    called.
    
    - If watchdog_active(wdd), the return value from watchdog_need_worker
    is also the same as before (namely, hm && t > hm). Hence in that case,
    watchdog_next_keepalive() is only called if hm == max_hw_heartbeat_ms
    is non-zero, so the change to min_not_zero there is a no-op.
    
    - If the watchdog is not active and the device is not running, we
    return false from watchdog_need_worker just as before.
    
    That leaves the watchdog_hw_running(wdd) && !watchdog_active(wdd) &&
    wdd->timeout case. Again, it's easy to see that if
    wdd->max_hw_heartbeat_ms is non-zero, we return true from
    watchdog_need_worker with and without this patch, and the logic in
    watchdog_next_keepalive is unchanged. Finally, if
    wdd->max_hw_heartbeat_ms is 0, we used to end up in the
    cancel_delayed_work branch, whereas with this patch we end up
    scheduling a ping timeout_ms/2 from now.
    
    (*) This should imply that no current kernel drivers are affected,
    since the only drivers which explicitly set WDOG_HW_RUNNING are
    imx2_wdt.c and dw_wdt.c, both of which also provide a non-zero value
    for max_hw_heartbeat_ms. The watchdog core also sets WDOG_HW_RUNNING,
    but only when the driver doesn't provide ->stop, in which case it
    must, according to Documentation/watchdog/watchdog-kernel-api.txt, set
    max_hw_heartbeat_ms.
    
    Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 65b5b5e6480718e8cb5b6a1d32a7cb4efb9d93a9
Author: Alexey Kunitskiy <alexey.kv@gmail.com>
Date:   Sun Jul 17 19:34:24 2016 +0300

    watchdog: add support for MCP78S chipset in nv_tco
    
    Add support for MCP78S chipset in nv_tco watchdog driver
    
    Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 960ae4ea776e160b3c47dc4b461e6f42ef2f659a
Author: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Fri Jul 15 10:15:22 2016 +0200

    watchdog: bcm2835_wdt: remove redundant ->set_timeout callback
    
    bcm2835_wdt_set_timeout does exactly what the watchdog framework does
    in the absence of a ->set_timeout callback (see watchdog_set_timeout
    in watchdog_dev.c), so remove it.
    
    Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: Eric Anholt <eric@anholt.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit aea4b477b96a1e098bdd39a7503eb4163cf65dbb
Author: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Fri Jul 15 10:15:21 2016 +0200

    watchdog: bcm2835_wdt: constify _ops and _info structures
    
    These are never modified, so might as well be const.
    
    Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: Eric Anholt <eric@anholt.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 80cdd91d3faf8d25977bcbf74613761eef912aab
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Sun Jul 10 11:11:05 2016 +0200

    dt-bindings: watchdog: Add Meson GXBB Watchdog bindings
    
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 683fa50f0e18cb12da41a7df41cc1fa8b002e071
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Sun Jul 10 11:11:04 2016 +0200

    watchdog: Add Meson GXBB Watchdog Driver
    
    Add watchdog specific driver for Amlogic Meson GXBB SoC.
    
    Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 10073a205df269abcbd9c3fbc690a813827107ef
Author: Matthew McClintock <mmcclint@codeaurora.org>
Date:   Tue Jun 28 11:35:21 2016 -0700

    watchdog: qcom: configure BARK time in addition to BITE time
    
    For certain parts and some versions of TZ, TZ will reset the chip
    when a BARK is triggered even though it was not configured here. So
    by default let's configure this BARK time as well.
    
    Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f0d9d0f4b44ae5503ea368e7f066b20f12ca1d37
Author: Matthew McClintock <mmcclint@codeaurora.org>
Date:   Wed Jun 29 10:50:01 2016 -0700

    watchdog: qcom: add option for standalone watchdog not in timer block
    
    Commit 0dfd582e026a ("watchdog: qcom: use timer devicetree
    binding") moved to use the watchdog as a subset timer
    register block. Some devices have the watchdog completely
    standalone with slightly different register offsets as
    well so let's account for the differences here.
    
    The existing "kpss-standalone" compatible string doesn't
    make it entirely clear exactly what the device is so
    rename to "kpss-wdt" to reflect watchdog timer
    functionality. Also update ipq4019 DTS with an SoC
    specific compatible.
    
    Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
    Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 6e062696d7ffa4e574f74514906e04508917c876
Author: Matthew McClintock <mmcclint@codeaurora.org>
Date:   Wed Jun 29 10:50:00 2016 -0700

    watchdog: qcom: update device tree bindings
    
    Update the compatible string to align with driver and also
    add SoC specific string to DTS.
    
    CC: linux-watchdog@vger.kernel.org
    Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
    Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a74cab40b5dc51b5ed042add1c5d2f5e9a1964bc
Author: Stefan Christ <s.christ@phytec.de>
Date:   Wed Jul 6 10:40:11 2016 +0200

    watchdog: da9063_wdt: don't trigger watchdog too fast
    
    Triggering the watchdog faster than T_WDMIN=256ms leads to resets of the
    DA9063 chip. The datasheet says that the watchdog must only be triggered
    in the timeframe T_WDMIN to T_WDMAX. The T_WDMAX is configured in the
    driver.
    
    Signed-off-by: Stefan Christ <s.christ@phytec.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5a2d3de1960260f34da84ac27bdc1345b541f2e8
Author: Timur Tabi <timur@codeaurora.org>
Date:   Tue Jun 21 18:00:15 2016 -0500

    Documentation/watchdog: add support for magic close to watchdog-test
    
    Some drivers have the WDIOF_MAGICCLOSE set, which means that applications
    need to write 'V' to the watchdog device before closing, otherwise the
    driver won't stop the watchdog timer.
    
    Signed-off-by: Timur Tabi <timur@codeaurora.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ee279c2734b07fb74031b1626b0f097cee9de5c8
Author: Timur Tabi <timur@codeaurora.org>
Date:   Tue Jun 21 18:00:14 2016 -0500

    Documentation/watchdog: use stdout instead of stderr in watchdog-test
    
    The watchdog-test utility outputs all messages to stderr, even those
    that are not error messages.  Output to stdout instead.
    
    Instead of flushing the output after every write, just disabled
    the output buffer.
    
    Also display a dot for every ping of the watchdog, so that the user
    knows that it's working.
    
    Signed-off-by: Timur Tabi <timur@codeaurora.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 334da2d6753ba548851c6329c4b6e74eb731368a
Author: Yong, Jonathan <jonathan.yong@intel.com>
Date:   Fri Jun 17 00:33:32 2016 +0000

    x86: Fix Apollo Lake Watchdog address in PMC driver
    
    The TCO I/O base is 40h rather than the usual 30h, and the re_reboot
    bit is at ACPIBASE+8.
    
    Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3b3a1c8fbb36f8e077b6ac09bcac03024d5bfa5c
Author: Yong, Jonathan <jonathan.yong@intel.com>
Date:   Fri Jun 17 00:33:31 2016 +0000

    watchdog: iTCO-wdt: handle 5th variation for Apollo Lake
    
    The Apollo Lake Watchdog has the no_reboot flag in the 4th bit.
    
    Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit fafdbabaf5c6a949168b384e159152f6e37427ba
Author: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date:   Fri Jun 17 17:12:05 2016 +0000

    watchdog: pic32-dmt: Fix return value check in pic32_dmt_probe()
    
    In case of error, the function devm_kzalloc() returns NULL pointer
    not ERR_PTR(). The IS_ERR() test in the return value check should
    be replaced with NULL test.
    
    Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit db6d2d0e6d24176f524359bff2f209f0c8425496
Author: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date:   Fri Jun 17 17:11:35 2016 +0000

    watchdog: pic32-wdt: Fix return value check in pic32_wdt_drv_probe()
    
    In case of error, the function devm_kzalloc() returns NULL pointer
    not ERR_PTR(). The IS_ERR() test in the return value check should
    be replaced with NULL test.
    
    Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 22daf7a71683185db6bcb089e006be5f99dddf9c
Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date:   Sat Jul 9 11:43:19 2016 +0200

    watchdog: ziirave_wdt: Correct I2C device id to fix module autoloading.
    
    The I2C core removes the manufacturer prefix from the compatible field
    so it reports to user-space the uevent i2c:rave-wdt, but this doesn't
    match with the i2c_device_id (i2c:ziirave-wdt) array so the module is not
    autoloaded. Correct the I2C device id to match with the reported uevent
    and fix the module autoloading functionality.
    
    Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ff9cc8384a3efba7e3daedf66dfd58b0a0fff069
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Wed Jun 8 18:16:15 2016 +0300

    watchdog: drop redundant 'default n' option for WATCHDOG_SYSFS
    
    The option 'default n' and its absence are equal for kbuild,
    which makes explicit 'default n' redundant.
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ff3bb2f5c3cd70f4dd642525916f300bffaff0ae
Author: Laxman Dewangan <ldewangan@nvidia.com>
Date:   Thu Jun 9 18:59:05 2016 +0530

    watchdog: max77620: Add support for watchdog timer
    
    Maxim PMIC MAX77620 is Power management IC which have multiple
    sub blocks like regulators (DCDC/LDOs), GPIO, RTC, Clock, Watchdog
    timer etc.
    
    Add the driver for watchdog timer under watchdog framework.
    The driver implements the watchdog callbacks to start, stop,
    ping and set timeout for watchodg framework.
    
    Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 14b24a88a36602c2c4e3bbb955be1aa9378c3be2
Author: Ji-Ze Hong (Peter Hong) <hpeter@gmail.com>
Date:   Wed Jun 8 14:57:50 2016 +0800

    watchdog: f71808e_wdt: Add F81866 support
    
    Adds watchdog enable support for Fintek F81866 Super-IO chip to
    Fintek wdt driver (f71808e_wdt)
    
    Tested and verified on iBASE MI802 Industrial PC
    
    Datasheet references:
    http://www.alldatasheet.com/datasheet-pdf/pdf/459085/FINTEK/F81866AD-I.html
    
    Suggested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b99c87740541f04cec056978452d7913da6ac9a5
Author: Ben Dooks <ben.dooks@codethink.co.uk>
Date:   Tue Jun 7 12:53:07 2016 +0100

    watchdog: sirf: fix __iomem * warnings
    
    Fix the following warnings from sparse due to casting to/from an __iomem
    annotated variable:
    
    drivers/watchdog/sirfsoc_wdt.c:48:18: warning: incorrect type in assignment (different address spaces)
    drivers/watchdog/sirfsoc_wdt.c:48:18:    expected void [noderef] <asn:2>*wdt_base
    drivers/watchdog/sirfsoc_wdt.c:48:18:    got void *
    drivers/watchdog/sirfsoc_wdt.c:64:18: warning: incorrect type in assignment (different address spaces)
    drivers/watchdog/sirfsoc_wdt.c:64:18:    expected void [noderef] <asn:2>*wdt_base
    drivers/watchdog/sirfsoc_wdt.c:64:18:    got void *
    drivers/watchdog/sirfsoc_wdt.c:82:54: warning: incorrect type in initializer (different address spaces)
    drivers/watchdog/sirfsoc_wdt.c:82:54:    expected void [noderef] <asn:2>*wdt_base
    drivers/watchdog/sirfsoc_wdt.c:82:54:    got void *
    drivers/watchdog/sirfsoc_wdt.c:99:54: warning: incorrect type in initializer (different address spaces)
    drivers/watchdog/sirfsoc_wdt.c:99:54:    expected void [noderef] <asn:2>*wdt_base
    drivers/watchdog/sirfsoc_wdt.c:99:54:    got void *
    drivers/watchdog/sirfsoc_wdt.c:153:44: warning: incorrect type in argument 2 (different address spaces)
    drivers/watchdog/sirfsoc_wdt.c:153:44:    expected void *data
    drivers/watchdog/sirfsoc_wdt.c:153:44:    got void [noderef] <asn:2>*[assigned] base
    
    Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a3e376d26ace6d823f7aa4c63476e7089a6196df
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri May 27 15:28:00 2016 -0700

    watchdog: tangox: Mark running watchdog correctly
    
    A running watchdog is marked with WDOG_HW_RUNNING, not with WDOG_ACTIVE.
    WDOG_ACTIVE indicates that the watchdog device has been opened from user
    space.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f9f535c1b76128f94dae7a4bb41464aacd4c10ec
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri May 27 14:19:06 2016 -0700

    watchdog: Improve description of min_hw_heartbeat_ms
    
    The description of min_hw_heartbeat_ms is misleading and needs some
    improvements.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c3c1e29c8ad11dec67d01203759272da0d0df3aa
Author: Pratyush Anand <panand@redhat.com>
Date:   Tue May 31 14:08:10 2016 +0800

    watchdog: sbsa: Set WDOG_HW_RUNNING, when watchdog is already running.
    
    This patch uses the new flag WDOG_HW_RUNNING in driver.
    According to the definition of this flag, it should be set,
    if watchdog is running after booting, before it's opened.
    
    Signed-off-by: Pratyush Anand <panand@redhat.com>
    Signed-off-by: Fu Wei <fu.wei@linaro.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e05e80eb58cc9679d0ff8de5af095a66ba855e10
Author: Pratyush Anand <panand@redhat.com>
Date:   Tue May 31 14:08:09 2016 +0800

    watchdog: sbsa: Use max_hw_heartbeat_ms instead of max_timeout
    
    Using max_hw_heartbeat_ms instead of max_timeout gives the flexibility to
    achieve higher user "timeout". Therefore, use this new infrastructure.
    
    Signed-off-by: Pratyush Anand <panand@redhat.com>
    Signed-off-by: Fu Wei <fu.wei@linaro.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1894cad9bf2c10359b2b7a0c00e564698f712751
Author: Pratyush Anand <panand@redhat.com>
Date:   Tue May 31 14:08:08 2016 +0800

    watchdog: skip min and max timeout validity check when max_hw_heartbeat_ms is defined
    
    When max_hw_heartbeat_ms has a none zero value, max_timeout is not used.
    So it's value can be 0. In such case if a driver uses min_timeout
    functionality, then check will always fail.
    
    This patch fixes above issue.
    
    Signed-off-by: Pratyush Anand <panand@redhat.com>
    Signed-off-by: Fu Wei <fu.wei@linaro.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b7a8c420f31eaf521f66f093a1a00e92718dd193
Author: William Breathitt Gray <vilhelm.gray@gmail.com>
Date:   Wed Jun 1 09:05:48 2016 -0400

    watchdog: pcwd: Utilize the module_isa_driver macro
    
    This driver does not do anything special in module init/exit. This patch
    eliminates the module init/exit boilerplate code by utilizing the
    module_isa_driver macro.
    
    Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit efa859f7d7860f73396c1ff28017e55b5b403e82
Author: Joel Stanley <joel@jms.id.au>
Date:   Wed May 18 17:51:00 2016 +0930

    watchdog: Add Aspeed watchdog driver
    
    Provides generic watchdog features as well as reboot support for the
    Aspeed SoCs.
    
    Signed-off-by: Joel Stanley <joel@jms.id.au>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0c9444cc9e031541694268e58d4b999a6ee258e3
Author: Joel Stanley <joel@jms.id.au>
Date:   Wed May 18 17:50:59 2016 +0930

    dt-bindings: watchdog: Add Aspeed watchdog timer bindings
    
    Signed-off-by: Joel Stanley <joel@jms.id.au>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 4a23e2bf032fdceecef1ab314c7f84d9c2050490
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed May 25 08:37:49 2016 +0200

    watchdog: softdog: improve coding style
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 61a21274c9eee5a3adb85441a91a071de4260863
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed May 25 08:37:48 2016 +0200

    watchdog: softdog: drop superfluous set_timeout callback
    
    If we leave set_timeout empty, the core will do exactly what is
    implemented here anyway.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e65c5825c6ef850a26cd449157024bad6e2eec9c
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed May 25 08:37:47 2016 +0200

    watchdog: softdog: sort includes to avoid duplicates
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 44ba0f04af44d7f3a157ee655bdfc53660d8faf9
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed May 25 08:37:46 2016 +0200

    watchdog: softdog: remove forward declaration
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0efc70b8238dc6d26289b501f126798b9d0da601
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed May 25 08:37:45 2016 +0200

    watchdog: softdog: consistently use softdog_ prefix
    
    And move module_init/exit to the proper place while here.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e8cf96abba977b6d66bfc2bbc5248a924c9edaec
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed May 25 08:37:44 2016 +0200

    watchdog: softdog: use watchdog core to init timeout value
    
    Error string and comment say we fall back to a default, but in reality
    we bailed out. Refactor the code to use the core helper which then
    matches the described behaviour. While updating the init message anyhow,
    shorten it while we are here; no need for versioning there as well and
    the name is already given via pr_fmt.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9c963ba0e0bacfb13c41d3334630ff67044ac159
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed May 25 08:37:43 2016 +0200

    watchdog: softdog: remove obsolete comments
    
    The history is obsolete, especially since we switched to watchdog
    framework. The section markers also don't make sense anymore given
    the small size of the driver.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 214de83ec2be9309667baf181b14c603aeb962be
Author: Brian Boylston <brian.boylston@hpe.com>
Date:   Wed May 25 11:19:54 2016 -0500

    MAINTAINERS: add entry for HPE watchdog driver
    
    Add a maintainer for the HPE watchdog driver
    
    Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0215efc02e32d0a806ad13be7e43c6784428b334
Author: Brian Boylston <brian.boylston@hpe.com>
Date:   Wed May 25 11:20:15 2016 -0500

    watchdog: hpwdt: remove email address from doc
    
    Remove Tom's email address from the documentation
    
    Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 83fbae5a148cc1cd53e5be1a28edb3b6701b7af2
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Fri May 27 17:33:54 2016 +0200

    watchdog: Add a device managed API for watchdog_register_device()
    
    This helps in reducing code in .remove callbacks and sometimes
    dropping .remove callbacks entirely.
    
    Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
new file mode 100644
index 0000000..c5e74d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -0,0 +1,16 @@
+Aspeed Watchdog Timer
+
+Required properties:
+ - compatible: must be one of:
+	- "aspeed,ast2400-wdt"
+	- "aspeed,ast2500-wdt"
+
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+Example:
+
+	wdt1: watchdog@1e785000 {
+		compatible = "aspeed,ast2400-wdt";
+		reg = <0x1e785000 0x1c>;
+	};
diff --git a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
new file mode 100644
index 0000000..c7fe36f
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
@@ -0,0 +1,16 @@
+Meson GXBB SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "amlogic,meson-gxbb-wdt"
+- reg : Specifies base physical address and size of the registers.
+- clocks : Should be a phandle to the Watchdog clock source, for GXBB the xtal
+	   is the default clock source.
+
+Example:
+
+wdt: watchdog@98d0 {
+	compatible = "amlogic,meson-gxbb-wdt";
+	reg = <0 0x98d0 0x0 0x10>;
+	clocks = <&xtal>;
+};
diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
index 4726924..41aeaa2 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
@@ -7,6 +7,10 @@ Required properties :
 			"qcom,kpss-wdt-msm8960"
 			"qcom,kpss-wdt-apq8064"
 			"qcom,kpss-wdt-ipq8064"
+			"qcom,kpss-wdt-ipq4019"
+			"qcom,kpss-timer"
+			"qcom,scss-timer"
+			"qcom,kpss-wdt"
 
 - reg : shall contain base register location and length
 - clocks : shall contain the input clock
diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index b9512f1..da24e31 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -1,7 +1,11 @@
 Renesas Watchdog Timer (WDT) Controller
 
 Required properties:
-- compatible : Should be "renesas,r8a7795-wdt", or "renesas,rcar-gen3-wdt"
+- compatible : Should be "renesas,<soctype>-wdt", and
+	       "renesas,rcar-gen3-wdt" as fallback.
+	       Examples with soctypes are:
+	         - "renesas,r8a7795-wdt" (R-Car H3)
+	         - "renesas,r8a7796-wdt" (R-Car M3-W)
 
   When compatible with the generic version, nodes must list the SoC-specific
   version corresponding to the platform first, followed by the generic
diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index c63eea0..589296b 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -357,3 +357,6 @@ SLAVE DMA ENGINE
 
 SPI
   devm_spi_register_master()
+
+WATCHDOG
+  devm_watchdog_register_device()
diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
index a40398c..7a9f635 100644
--- a/Documentation/watchdog/hpwdt.txt
+++ b/Documentation/watchdog/hpwdt.txt
@@ -1,9 +1,9 @@
-Last reviewed: 04/04/2016
+Last reviewed: 05/20/2016
 
                      HPE iLO NMI Watchdog Driver
               NMI sourcing for iLO based ProLiant Servers
                      Documentation and Driver by
-              Thomas Mingarelli <thomas.mingarelli@hpe.com>
+                         Thomas Mingarelli
 
  The HPE iLO NMI Watchdog driver is a kernel module that provides basic
  watchdog functionality and the added benefit of NMI sourcing. Both the
@@ -95,4 +95,3 @@ Last reviewed: 04/04/2016
 
 
  -- Tom Mingarelli
-    (thomas.mingarelli@hpe.com)
diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index fcdde8f..6983d05 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -2,6 +2,7 @@
  * Watchdog Driver Test Program
  */
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -13,6 +14,7 @@
 #include <linux/watchdog.h>
 
 int fd;
+const char v = 'V';
 
 /*
  * This function simply sends an IOCTL to the driver, which in turn ticks
@@ -23,6 +25,7 @@ static void keep_alive(void)
 {
     int dummy;
 
+    printf(".");
     ioctl(fd, WDIOC_KEEPALIVE, &dummy);
 }
 
@@ -33,8 +36,13 @@ static void keep_alive(void)
 
 static void term(int sig)
 {
+    int ret = write(fd, &v, 1);
+
     close(fd);
-    fprintf(stderr, "Stopping watchdog ticks...\n");
+    if (ret < 0)
+	printf("\nStopping watchdog ticks failed (%d)...\n", errno);
+    else
+	printf("\nStopping watchdog ticks...\n");
     exit(0);
 }
 
@@ -42,12 +50,14 @@ int main(int argc, char *argv[])
 {
     int flags;
     unsigned int ping_rate = 1;
+    int ret;
+
+    setbuf(stdout, NULL);
 
     fd = open("/dev/watchdog", O_WRONLY);
 
     if (fd == -1) {
-	fprintf(stderr, "Watchdog device not enabled.\n");
-	fflush(stderr);
+	printf("Watchdog device not enabled.\n");
 	exit(-1);
     }
 
@@ -55,36 +65,30 @@ int main(int argc, char *argv[])
 	if (!strncasecmp(argv[1], "-d", 2)) {
 	    flags = WDIOS_DISABLECARD;
 	    ioctl(fd, WDIOC_SETOPTIONS, &flags);
-	    fprintf(stderr, "Watchdog card disabled.\n");
-	    fflush(stderr);
+	    printf("Watchdog card disabled.\n");
 	    goto end;
 	} else if (!strncasecmp(argv[1], "-e", 2)) {
 	    flags = WDIOS_ENABLECARD;
 	    ioctl(fd, WDIOC_SETOPTIONS, &flags);
-	    fprintf(stderr, "Watchdog card enabled.\n");
-	    fflush(stderr);
+	    printf("Watchdog card enabled.\n");
 	    goto end;
 	} else if (!strncasecmp(argv[1], "-t", 2) && argv[2]) {
 	    flags = atoi(argv[2]);
 	    ioctl(fd, WDIOC_SETTIMEOUT, &flags);
-	    fprintf(stderr, "Watchdog timeout set to %u seconds.\n", flags);
-	    fflush(stderr);
+	    printf("Watchdog timeout set to %u seconds.\n", flags);
 	    goto end;
 	} else if (!strncasecmp(argv[1], "-p", 2) && argv[2]) {
 	    ping_rate = strtoul(argv[2], NULL, 0);
-	    fprintf(stderr, "Watchdog ping rate set to %u seconds.\n", ping_rate);
-	    fflush(stderr);
+	    printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
 	} else {
-	    fprintf(stderr, "-d to disable, -e to enable, -t <n> to set " \
+	    printf("-d to disable, -e to enable, -t <n> to set " \
 		"the timeout,\n-p <n> to set the ping rate, and \n");
-	    fprintf(stderr, "run by itself to tick the card.\n");
-	    fflush(stderr);
+	    printf("run by itself to tick the card.\n");
 	    goto end;
 	}
     }
 
-    fprintf(stderr, "Watchdog Ticking Away!\n");
-    fflush(stderr);
+    printf("Watchdog Ticking Away!\n");
 
     signal(SIGINT, term);
 
@@ -93,6 +97,9 @@ int main(int argc, char *argv[])
 	sleep(ping_rate);
     }
 end:
+    ret = write(fd, &v, 1);
+    if (ret < 0)
+	printf("Stopping watchdog ticks failed (%d)...\n", errno);
     close(fd);
     return 0;
 }
diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 917eeea..7f31125 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -82,8 +82,9 @@ It contains following fields:
 * max_timeout: the watchdog timer's maximum timeout value (in seconds),
   as seen from userspace. If set, the maximum configurable value for
   'timeout'. Not used if max_hw_heartbeat_ms is non-zero.
-* min_hw_heartbeat_ms: Minimum time between heartbeats sent to the chip,
-  in milli-seconds.
+* min_hw_heartbeat_ms: Hardware limit for minimum time between heartbeats,
+  in milli-seconds. This value is normally 0; it should only be provided
+  if the hardware can not tolerate lower intervals between heartbeats.
 * max_hw_heartbeat_ms: Maximum hardware heartbeat, in milli-seconds.
   If set, the infrastructure will send heartbeats to the watchdog driver
   if 'timeout' is larger than max_hw_heartbeat_ms, unless WDOG_ACTIVE
@@ -166,6 +167,10 @@ they are supported. These optional routines/operations are:
   info structure).
 * status: this routine checks the status of the watchdog timer device. The
   status of the device is reported with watchdog WDIOF_* status flags/bits.
+  WDIOF_MAGICCLOSE and WDIOF_KEEPALIVEPING are reported by the watchdog core;
+  it is not necessary to report those bits from the driver. Also, if no status
+  function is provided by the driver, the watchdog core reports the status bits
+  provided in the bootstatus variable of struct watchdog_device.
 * set_timeout: this routine checks and changes the timeout of the watchdog
   timer device. It returns 0 on success, -EINVAL for "parameter out of range"
   and -EIO for "could not write value to the watchdog". On success this
diff --git a/MAINTAINERS b/MAINTAINERS
index 1d74837..139a532 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5304,6 +5304,12 @@ T:	git git://linuxtv.org/anttip/media_tree.git
 S:	Maintained
 F:	drivers/media/dvb-frontends/hd29l2*
 
+HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
+M:	Brian Boylston <brian.boylston@hpe.com>
+S:	Supported
+F:	Documentation/watchdog/hpwdt.txt
+F:	drivers/watchdog/hpwdt.c
+
 HEWLETT-PACKARD SMART ARRAY RAID DRIVER (hpsa)
 M:	Don Brace <don.brace@microsemi.com>
 L:	iss_storagedev@hp.com
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index df96ccd..e318d04 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -247,7 +247,8 @@
 		};
 
 		timer@200a000 {
-			compatible = "qcom,kpss-timer", "qcom,msm-timer";
+			compatible = "qcom,kpss-timer",
+				     "qcom,kpss-wdt-apq8064", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
 				     <1 3 0x301>;
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 5c08d19..e625656 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -252,7 +252,7 @@
 		};
 
 		watchdog@b017000 {
-			compatible = "qcom,kpss-standalone";
+			compatible = "qcom,kpss-wdt", "qcom,kpss-wdt-ipq4019";
 			reg = <0xb017000 0x40>;
 			clocks = <&sleep_clk>;
 			timeout-sec = <10>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 2601a90..2e37557 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -122,7 +122,8 @@
 		};
 
 		timer@200a000 {
-			compatible = "qcom,kpss-timer", "qcom,msm-timer";
+			compatible = "qcom,kpss-timer",
+				     "qcom,kpss-wdt-ipq8064", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
 				     <1 3 0x301>,
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index da05e28..288f56e 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -87,7 +87,8 @@
 		};
 
 		timer@200a000 {
-			compatible = "qcom,kpss-timer", "qcom,msm-timer";
+			compatible = "qcom,kpss-timer",
+				     "qcom,kpss-wdt-msm8960", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
 				     <1 3 0x301>;
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 6f497e8..b86e1bc 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -85,7 +85,7 @@
  * platform device and to export resources for those functions.
  */
 #define TCO_DEVICE_NAME			"iTCO_wdt"
-#define SMI_EN_OFFSET			0x30
+#define SMI_EN_OFFSET			0x40
 #define SMI_EN_SIZE			4
 #define TCO_BASE_OFFSET			0x60
 #define TCO_REGS_SIZE			16
@@ -94,6 +94,8 @@
 #define TELEM_SSRAM_SIZE		240
 #define TELEM_PMC_SSRAM_OFFSET		0x1B00
 #define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
+#define TCO_PMC_OFFSET			0x8
+#define TCO_PMC_SIZE			0x4
 
 static const int iTCO_version = 3;
 
@@ -502,7 +504,7 @@ static struct resource tco_res[] = {
 
 static struct itco_wdt_platform_data tco_info = {
 	.name = "Apollo Lake SoC",
-	.version = 3,
+	.version = 5,
 };
 
 #define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
@@ -572,8 +574,8 @@ static int ipc_create_tco_device(void)
 	res->end = res->start + SMI_EN_SIZE - 1;
 
 	res = tco_res + TCO_RESOURCE_GCR_MEM;
-	res->start = ipcdev.gcr_base;
-	res->end = res->start + ipcdev.gcr_size - 1;
+	res->start = ipcdev.gcr_base + TCO_PMC_OFFSET;
+	res->end = res->start + TCO_PMC_SIZE - 1;
 
 	ret = platform_device_add_resources(pdev, tco_res, ARRAY_SIZE(tco_res));
 	if (ret) {
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b4b3e25..1bffe00 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -48,7 +48,6 @@ config WATCHDOG_NOWAYOUT
 
 config WATCHDOG_SYSFS
 	bool "Read different watchdog information through sysfs"
-	default n
 	help
 	  Say Y here if you want to enable watchdog device status read through
 	  sysfs attributes.
@@ -516,6 +515,15 @@ config MAX63XX_WATCHDOG
 	help
 	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
 
+config MAX77620_WATCHDOG
+	tristate "Maxim Max77620 Watchdog Timer"
+	depends on MFD_MAX77620
+	help
+	 This is the driver for the Max77620 watchdog timer.
+	 Say 'Y' here to enable the watchdog timer support for
+	 MAX77620 chips. To compile this driver as a module,
+	 choose M here: the module will be called max77620_wdt.
+
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
 	depends on ARCH_MXC || ARCH_LAYERSCAPE
@@ -609,6 +617,16 @@ config QCOM_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called qcom_wdt.
 
+config MESON_GXBB_WATCHDOG
+	tristate "Amlogic Meson GXBB SoCs watchdog support"
+	depends on ARCH_MESON
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in Amlogic Meson GXBB SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called meson_gxbb_wdt.
+
 config MESON_WATCHDOG
 	tristate "Amlogic Meson SoCs watchdog support"
 	depends on ARCH_MESON
@@ -669,6 +687,19 @@ config RENESAS_WDT
 	  This driver adds watchdog support for the integrated watchdogs in the
 	  Renesas R-Car and other SH-Mobile SoCs (usually named RWDT or SWDT).
 
+config ASPEED_WATCHDOG
+	tristate "Aspeed 2400 watchdog support"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in Apseed BMC SoCs.
+
+	  This driver is required to reboot the SoC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called aspeed_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index a46e7c1..c22ad3e 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_ST_LPC_WATCHDOG) += st_lpc_wdt.o
 obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
 obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
 obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
+obj-$(CONFIG_MESON_GXBB_WATCHDOG) += meson_gxbb_wdt.o
 obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
@@ -74,6 +75,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
 obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
+obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
@@ -203,6 +205,7 @@ obj-$(CONFIG_TANGOX_WATCHDOG) += tangox_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
 obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
 obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
+obj-$(CONFIG_MAX77620_WATCHDOG) += max77620_wdt.o
 obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
new file mode 100644
index 0000000..f5ad802
--- /dev/null
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -0,0 +1,212 @@
+/*
+ * Copyright 2016 IBM Corporation
+ *
+ * Joel Stanley <joel@jms.id.au>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+struct aspeed_wdt {
+	struct watchdog_device	wdd;
+	void __iomem		*base;
+	u32			ctrl;
+};
+
+static const struct of_device_id aspeed_wdt_of_table[] = {
+	{ .compatible = "aspeed,ast2400-wdt" },
+	{ .compatible = "aspeed,ast2500-wdt" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
+
+#define WDT_STATUS		0x00
+#define WDT_RELOAD_VALUE	0x04
+#define WDT_RESTART		0x08
+#define WDT_CTRL		0x0C
+#define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
+#define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
+#define   WDT_CTRL_1MHZ_CLK		BIT(4)
+#define   WDT_CTRL_WDT_EXT		BIT(3)
+#define   WDT_CTRL_WDT_INTR		BIT(2)
+#define   WDT_CTRL_RESET_SYSTEM		BIT(1)
+#define   WDT_CTRL_ENABLE		BIT(0)
+
+#define WDT_RESTART_MAGIC	0x4755
+
+/* 32 bits at 1MHz, in milliseconds */
+#define WDT_MAX_TIMEOUT_MS	4294967
+#define WDT_DEFAULT_TIMEOUT	30
+#define WDT_RATE_1MHZ		1000000
+
+static struct aspeed_wdt *to_aspeed_wdt(struct watchdog_device *wdd)
+{
+	return container_of(wdd, struct aspeed_wdt, wdd);
+}
+
+static void aspeed_wdt_enable(struct aspeed_wdt *wdt, int count)
+{
+	wdt->ctrl |= WDT_CTRL_ENABLE;
+
+	writel(0, wdt->base + WDT_CTRL);
+	writel(count, wdt->base + WDT_RELOAD_VALUE);
+	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
+}
+
+static int aspeed_wdt_start(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	aspeed_wdt_enable(wdt, wdd->timeout * WDT_RATE_1MHZ);
+
+	return 0;
+}
+
+static int aspeed_wdt_stop(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	wdt->ctrl &= ~WDT_CTRL_ENABLE;
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
+
+	return 0;
+}
+
+static int aspeed_wdt_ping(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
+
+	return 0;
+}
+
+static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
+				  unsigned int timeout)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+	u32 actual;
+
+	wdd->timeout = timeout;
+
+	actual = min(timeout, wdd->max_hw_heartbeat_ms * 1000);
+
+	writel(actual * WDT_RATE_1MHZ, wdt->base + WDT_RELOAD_VALUE);
+	writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
+
+	return 0;
+}
+
+static int aspeed_wdt_restart(struct watchdog_device *wdd,
+			      unsigned long action, void *data)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+
+	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
+
+	mdelay(1000);
+
+	return 0;
+}
+
+static const struct watchdog_ops aspeed_wdt_ops = {
+	.start		= aspeed_wdt_start,
+	.stop		= aspeed_wdt_stop,
+	.ping		= aspeed_wdt_ping,
+	.set_timeout	= aspeed_wdt_set_timeout,
+	.restart	= aspeed_wdt_restart,
+	.owner		= THIS_MODULE,
+};
+
+static const struct watchdog_info aspeed_wdt_info = {
+	.options	= WDIOF_KEEPALIVEPING
+			| WDIOF_MAGICCLOSE
+			| WDIOF_SETTIMEOUT,
+	.identity	= KBUILD_MODNAME,
+};
+
+static int aspeed_wdt_remove(struct platform_device *pdev)
+{
+	struct aspeed_wdt *wdt = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&wdt->wdd);
+
+	return 0;
+}
+
+static int aspeed_wdt_probe(struct platform_device *pdev)
+{
+	struct aspeed_wdt *wdt;
+	struct resource *res;
+	int ret;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	/*
+	 * The ast2400 wdt can run at PCLK, or 1MHz. The ast2500 only
+	 * runs at 1MHz. We chose to always run at 1MHz, as there's no
+	 * good reason to have a faster watchdog counter.
+	 */
+	wdt->wdd.info = &aspeed_wdt_info;
+	wdt->wdd.ops = &aspeed_wdt_ops;
+	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
+	wdt->wdd.parent = &pdev->dev;
+
+	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
+	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
+
+	/*
+	 * Control reset on a per-device basis to ensure the
+	 * host is not affected by a BMC reboot, so only reset
+	 * the SOC and not the full chip
+	 */
+	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
+		WDT_CTRL_1MHZ_CLK |
+		WDT_CTRL_RESET_SYSTEM;
+
+	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
+		aspeed_wdt_start(&wdt->wdd);
+		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
+	}
+
+	ret = watchdog_register_device(&wdt->wdd);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+
+	return 0;
+}
+
+static struct platform_driver aspeed_watchdog_driver = {
+	.probe = aspeed_wdt_probe,
+	.remove = aspeed_wdt_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
+	},
+};
+module_platform_driver(aspeed_watchdog_driver);
+
+MODULE_DESCRIPTION("Aspeed Watchdog Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 2e6164c..4dddd82 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -82,12 +82,6 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
 	return 0;
 }
 
-static int bcm2835_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
-{
-	wdog->timeout = t;
-	return 0;
-}
-
 static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
 {
 	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
@@ -96,15 +90,14 @@ static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
 	return WDOG_TICKS_TO_SECS(ret & PM_WDOG_TIME_SET);
 }
 
-static struct watchdog_ops bcm2835_wdt_ops = {
+static const struct watchdog_ops bcm2835_wdt_ops = {
 	.owner =	THIS_MODULE,
 	.start =	bcm2835_wdt_start,
 	.stop =		bcm2835_wdt_stop,
-	.set_timeout =	bcm2835_wdt_set_timeout,
 	.get_timeleft =	bcm2835_wdt_get_timeleft,
 };
 
-static struct watchdog_info bcm2835_wdt_info = {
+static const struct watchdog_info bcm2835_wdt_info = {
 	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
 			WDIOF_KEEPALIVEPING,
 	.identity =	"Broadcom BCM2835 Watchdog timer",
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index a100f64..5d6b4e5 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -34,6 +34,7 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 #define DA9063_WDT_MIN_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MIN]
 #define DA9063_WDT_MAX_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MAX]
 #define DA9063_WDG_TIMEOUT		wdt_timeout[3]
+#define DA9063_RESET_PROTECTION_MS	256
 
 struct da9063_watchdog {
 	struct da9063 *da9063;
@@ -171,6 +172,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.ops = &da9063_watchdog_ops;
 	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
+	wdt->wdtdev.min_hw_heartbeat_ms = DA9063_RESET_PROTECTION_MS;
 	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
 	wdt->wdtdev.parent = &pdev->dev;
 
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index d4ba262..1b7e916 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -45,9 +45,11 @@
 #define SIO_REG_DEVREV		0x22	/* Device revision */
 #define SIO_REG_MANID		0x23	/* Fintek ID (2 bytes) */
 #define SIO_REG_ROM_ADDR_SEL	0x27	/* ROM address select */
+#define SIO_F81866_REG_PORT_SEL	0x27	/* F81866 Multi-Function Register */
 #define SIO_REG_MFUNCT1		0x29	/* Multi function select 1 */
 #define SIO_REG_MFUNCT2		0x2a	/* Multi function select 2 */
 #define SIO_REG_MFUNCT3		0x2b	/* Multi function select 3 */
+#define SIO_F81866_REG_GPIO1	0x2c	/* F81866 GPIO1 Enable Register */
 #define SIO_REG_ENABLE		0x30	/* Logical device enable */
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
@@ -60,6 +62,7 @@
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
 #define SIO_F81865_ID		0x0704	/* Chipset ID */
+#define SIO_F81866_ID		0x1010	/* Chipset ID */
 
 #define F71808FG_REG_WDO_CONF		0xf0
 #define F71808FG_REG_WDT_CONF		0xf5
@@ -116,7 +119,8 @@ module_param(start_withtimeout, uint, 0);
 MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
 	" given initial timeout. Zero (default) disables this feature.");
 
-enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865 };
+enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865,
+	     f81866};
 
 static const char *f71808e_names[] = {
 	"f71808fg",
@@ -126,6 +130,7 @@ static const char *f71808e_names[] = {
 	"f71882fg",
 	"f71889fg",
 	"f81865",
+	"f81866",
 };
 
 /* Super-I/O Function prototypes */
@@ -370,6 +375,22 @@ static int watchdog_start(void)
 		superio_clear_bit(watchdog.sioaddr, SIO_REG_MFUNCT3, 5);
 		break;
 
+	case f81866:
+		/* Set pin 70 to WDTRST# */
+		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
+				  BIT(3) | BIT(0));
+		superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
+				BIT(2));
+		/*
+		 * GPIO1 Control Register when 27h BIT3:2 = 01 & BIT0 = 0.
+		 * The PIN 70(GPIO15/WDTRST) is controlled by 2Ch:
+		 *     BIT5: 0 -> WDTRST#
+		 *           1 -> GPIO15
+		 */
+		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1,
+				  BIT(5));
+		break;
+
 	default:
 		/*
 		 * 'default' label to shut up the compiler and catch
@@ -382,7 +403,7 @@ static int watchdog_start(void)
 	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
 	superio_set_bit(watchdog.sioaddr, SIO_REG_ENABLE, 0);
 
-	if (watchdog.type == f81865)
+	if (watchdog.type == f81865 || watchdog.type == f81866)
 		superio_set_bit(watchdog.sioaddr, F81865_REG_WDO_CONF,
 				F81865_FLAG_WDOUT_EN);
 	else
@@ -788,6 +809,9 @@ static int __init f71808e_find(int sioaddr)
 	case SIO_F81865_ID:
 		watchdog.type = f81865;
 		break;
+	case SIO_F81866_ID:
+		watchdog.type = f81866;
+		break;
 	default:
 		pr_info("Unrecognized Fintek device: %04x\n",
 			(unsigned int)devid);
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index ba066e4..93457ca 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -151,6 +151,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, priv);
+
 	priv->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
 	if (!gpio_is_valid(priv->gpio))
 		return priv->gpio;
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 0acc6c5..54cab18 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -150,6 +150,7 @@ static inline u32 no_reboot_bit(void)
 	u32 enable_bit;
 
 	switch (iTCO_wdt_private.iTCO_version) {
+	case 5:
 	case 3:
 		enable_bit = 0x00000010;
 		break;
@@ -512,6 +513,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 
 	/* Clear out the (probably old) status */
 	switch (iTCO_wdt_private.iTCO_version) {
+	case 5:
 	case 4:
 		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
 		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
new file mode 100644
index 0000000..48b84df
--- /dev/null
+++ b/drivers/watchdog/max77620_wdt.c
@@ -0,0 +1,227 @@
+/*
+ * Maxim MAX77620 Watchdog Driver
+ *
+ * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
+ *
+ * Author: Laxman Dewangan <ldewangan@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/max77620.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/watchdog.h>
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+struct max77620_wdt {
+	struct device			*dev;
+	struct regmap			*rmap;
+	struct watchdog_device		wdt_dev;
+};
+
+static int max77620_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
+
+	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
+				  MAX77620_WDTEN, MAX77620_WDTEN);
+}
+
+static int max77620_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
+
+	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
+				  MAX77620_WDTEN, 0);
+}
+
+static int max77620_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
+
+	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL3,
+				  MAX77620_WDTC_MASK, 0x1);
+}
+
+static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
+				    unsigned int timeout)
+{
+	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned int wdt_timeout;
+	u8 regval;
+	int ret;
+
+	switch (timeout) {
+	case 0 ... 2:
+		regval = MAX77620_TWD_2s;
+		wdt_timeout = 2;
+		break;
+
+	case 3 ... 16:
+		regval = MAX77620_TWD_16s;
+		wdt_timeout = 16;
+		break;
+
+	case 17 ... 64:
+		regval = MAX77620_TWD_64s;
+		wdt_timeout = 64;
+		break;
+
+	default:
+		regval = MAX77620_TWD_128s;
+		wdt_timeout = 128;
+		break;
+	}
+
+	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL3,
+				 MAX77620_WDTC_MASK, 0x1);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
+				 MAX77620_TWD_MASK, regval);
+	if (ret < 0)
+		return ret;
+
+	wdt_dev->timeout = wdt_timeout;
+
+	return 0;
+}
+
+static const struct watchdog_info max77620_wdt_info = {
+	.identity = "max77620-watchdog",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops max77620_wdt_ops = {
+	.start		= max77620_wdt_start,
+	.stop		= max77620_wdt_stop,
+	.ping		= max77620_wdt_ping,
+	.set_timeout	= max77620_wdt_set_timeout,
+};
+
+static int max77620_wdt_probe(struct platform_device *pdev)
+{
+	struct max77620_wdt *wdt;
+	struct watchdog_device *wdt_dev;
+	unsigned int regval;
+	int ret;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->dev = &pdev->dev;
+	wdt->rmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!wdt->rmap) {
+		dev_err(wdt->dev, "Failed to get parent regmap\n");
+		return -ENODEV;
+	}
+
+	wdt_dev = &wdt->wdt_dev;
+	wdt_dev->info = &max77620_wdt_info;
+	wdt_dev->ops = &max77620_wdt_ops;
+	wdt_dev->min_timeout = 2;
+	wdt_dev->max_timeout = 128;
+	wdt_dev->max_hw_heartbeat_ms = 128 * 1000;
+
+	platform_set_drvdata(pdev, wdt);
+
+	/* Enable WD_RST_WK - WDT expire results in a restart */
+	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_ONOFFCNFG2,
+				 MAX77620_ONOFFCNFG2_WD_RST_WK,
+				 MAX77620_ONOFFCNFG2_WD_RST_WK);
+	if (ret < 0) {
+		dev_err(wdt->dev, "Failed to set WD_RST_WK: %d\n", ret);
+		return ret;
+	}
+
+	/* Set WDT clear in OFF and sleep mode */
+	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
+				 MAX77620_WDTOFFC | MAX77620_WDTSLPC,
+				 MAX77620_WDTOFFC | MAX77620_WDTSLPC);
+	if (ret < 0) {
+		dev_err(wdt->dev, "Failed to set WDT OFF mode: %d\n", ret);
+		return ret;
+	}
+
+	/* Check if WDT running and if yes then set flags properly */
+	ret = regmap_read(wdt->rmap, MAX77620_REG_CNFGGLBL2, &regval);
+	if (ret < 0) {
+		dev_err(wdt->dev, "Failed to read WDT CFG register: %d\n", ret);
+		return ret;
+	}
+
+	switch (regval & MAX77620_TWD_MASK) {
+	case MAX77620_TWD_2s:
+		wdt_dev->timeout = 2;
+		break;
+	case MAX77620_TWD_16s:
+		wdt_dev->timeout = 16;
+		break;
+	case MAX77620_TWD_64s:
+		wdt_dev->timeout = 64;
+		break;
+	default:
+		wdt_dev->timeout = 128;
+		break;
+	}
+
+	if (regval & MAX77620_WDTEN)
+		set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
+
+	watchdog_set_nowayout(wdt_dev, nowayout);
+	watchdog_set_drvdata(wdt_dev, wdt);
+
+	ret = watchdog_register_device(wdt_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max77620_wdt_remove(struct platform_device *pdev)
+{
+	struct max77620_wdt *wdt = platform_get_drvdata(pdev);
+
+	max77620_wdt_stop(&wdt->wdt_dev);
+	watchdog_unregister_device(&wdt->wdt_dev);
+
+	return 0;
+}
+
+static struct platform_device_id max77620_wdt_devtype[] = {
+	{ .name = "max77620-watchdog", },
+	{ },
+};
+
+static struct platform_driver max77620_wdt_driver = {
+	.driver	= {
+		.name	= "max77620-watchdog",
+	},
+	.probe	= max77620_wdt_probe,
+	.remove	= max77620_wdt_remove,
+	.id_table = max77620_wdt_devtype,
+};
+
+module_platform_driver(max77620_wdt_driver);
+
+MODULE_DESCRIPTION("Max77620 watchdog timer driver");
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
new file mode 100644
index 0000000..44d180a
--- /dev/null
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -0,0 +1,270 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ *
+ * BSD LICENSE
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define DEFAULT_TIMEOUT	30	/* seconds */
+
+#define GXBB_WDT_CTRL_REG			0x0
+#define GXBB_WDT_TCNT_REG			0x8
+#define GXBB_WDT_RSET_REG			0xc
+
+#define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
+#define GXBB_WDT_CTRL_CLK_EN			BIT(24)
+#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
+#define GXBB_WDT_CTRL_EN			BIT(18)
+#define GXBB_WDT_CTRL_DIV_MASK			(BIT(18) - 1)
+
+#define GXBB_WDT_TCNT_SETUP_MASK		(BIT(16) - 1)
+#define GXBB_WDT_TCNT_CNT_SHIFT			16
+
+struct meson_gxbb_wdt {
+	void __iomem *reg_base;
+	struct watchdog_device wdt_dev;
+	struct clk *clk;
+};
+
+static int meson_gxbb_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
+
+	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) | GXBB_WDT_CTRL_EN,
+	       data->reg_base + GXBB_WDT_CTRL_REG);
+
+	return 0;
+}
+
+static int meson_gxbb_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
+
+	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) & ~GXBB_WDT_CTRL_EN,
+	       data->reg_base + GXBB_WDT_CTRL_REG);
+
+	return 0;
+}
+
+static int meson_gxbb_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
+
+	writel(0, data->reg_base + GXBB_WDT_RSET_REG);
+
+	return 0;
+}
+
+static int meson_gxbb_wdt_set_timeout(struct watchdog_device *wdt_dev,
+				      unsigned int timeout)
+{
+	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
+	unsigned long tcnt = timeout * 1000;
+
+	if (tcnt > GXBB_WDT_TCNT_SETUP_MASK)
+		tcnt = GXBB_WDT_TCNT_SETUP_MASK;
+
+	wdt_dev->timeout = timeout;
+
+	meson_gxbb_wdt_ping(wdt_dev);
+
+	writel(tcnt, data->reg_base + GXBB_WDT_TCNT_REG);
+
+	return 0;
+}
+
+static unsigned int meson_gxbb_wdt_get_timeleft(struct watchdog_device *wdt_dev)
+{
+	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
+	unsigned long reg;
+
+	reg = readl(data->reg_base + GXBB_WDT_TCNT_REG);
+
+	return ((reg >> GXBB_WDT_TCNT_CNT_SHIFT) -
+		(reg & GXBB_WDT_TCNT_SETUP_MASK)) / 1000;
+}
+
+static const struct watchdog_ops meson_gxbb_wdt_ops = {
+	.start = meson_gxbb_wdt_start,
+	.stop = meson_gxbb_wdt_stop,
+	.ping = meson_gxbb_wdt_ping,
+	.set_timeout = meson_gxbb_wdt_set_timeout,
+	.get_timeleft = meson_gxbb_wdt_get_timeleft,
+};
+
+static const struct watchdog_info meson_gxbb_wdt_info = {
+	.identity = "Meson GXBB Watchdog",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
+
+static int __maybe_unused meson_gxbb_wdt_resume(struct device *dev)
+{
+	struct meson_gxbb_wdt *data = dev_get_drvdata(dev);
+
+	if (watchdog_active(&data->wdt_dev))
+		meson_gxbb_wdt_start(&data->wdt_dev);
+
+	return 0;
+}
+
+static int __maybe_unused meson_gxbb_wdt_suspend(struct device *dev)
+{
+	struct meson_gxbb_wdt *data = dev_get_drvdata(dev);
+
+	if (watchdog_active(&data->wdt_dev))
+		meson_gxbb_wdt_stop(&data->wdt_dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops meson_gxbb_wdt_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(meson_gxbb_wdt_suspend, meson_gxbb_wdt_resume)
+};
+
+static const struct of_device_id meson_gxbb_wdt_dt_ids[] = {
+	 { .compatible = "amlogic,meson-gxbb-wdt", },
+	 { /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
+
+static int meson_gxbb_wdt_probe(struct platform_device *pdev)
+{
+	struct meson_gxbb_wdt *data;
+	struct resource *res;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->reg_base))
+		return PTR_ERR(data->reg_base);
+
+	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+
+	clk_prepare_enable(data->clk);
+
+	platform_set_drvdata(pdev, data);
+
+	data->wdt_dev.parent = &pdev->dev;
+	data->wdt_dev.info = &meson_gxbb_wdt_info;
+	data->wdt_dev.ops = &meson_gxbb_wdt_ops;
+	data->wdt_dev.max_hw_heartbeat_ms = GXBB_WDT_TCNT_SETUP_MASK;
+	data->wdt_dev.min_timeout = 1;
+	data->wdt_dev.timeout = DEFAULT_TIMEOUT;
+	watchdog_set_drvdata(&data->wdt_dev, data);
+
+	/* Setup with 1ms timebase */
+	writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
+		GXBB_WDT_CTRL_EE_RESET |
+		GXBB_WDT_CTRL_CLK_EN |
+		GXBB_WDT_CTRL_CLKDIV_EN,
+		data->reg_base + GXBB_WDT_CTRL_REG);
+
+	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
+
+	ret = watchdog_register_device(&data->wdt_dev);
+	if (ret) {
+		clk_disable_unprepare(data->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int meson_gxbb_wdt_remove(struct platform_device *pdev)
+{
+	struct meson_gxbb_wdt *data = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&data->wdt_dev);
+
+	clk_disable_unprepare(data->clk);
+
+	return 0;
+}
+
+static void meson_gxbb_wdt_shutdown(struct platform_device *pdev)
+{
+	struct meson_gxbb_wdt *data = platform_get_drvdata(pdev);
+
+	meson_gxbb_wdt_stop(&data->wdt_dev);
+}
+
+static struct platform_driver meson_gxbb_wdt_driver = {
+	.probe	= meson_gxbb_wdt_probe,
+	.remove	= meson_gxbb_wdt_remove,
+	.shutdown = meson_gxbb_wdt_shutdown,
+	.driver = {
+		.name = "meson-gxbb-wdt",
+		.pm = &meson_gxbb_wdt_pm_ops,
+		.of_match_table	= meson_gxbb_wdt_dt_ids,
+	},
+};
+
+module_platform_driver(meson_gxbb_wdt_driver);
+
+MODULE_ALIAS("platform:meson-gxbb-wdt");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Amlogic Meson GXBB Watchdog timer driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index bd917bb..a0fabf6 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -294,6 +294,8 @@ static const struct pci_device_id tco_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS,
 	  PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS,
+	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS,
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index e936f15..3ad5206 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -992,19 +992,7 @@ static struct isa_driver pcwd_isa_driver = {
 	},
 };
 
-static int __init pcwd_init_module(void)
-{
-	return isa_register_driver(&pcwd_isa_driver, PCWD_ISA_NR_CARDS);
-}
-
-static void __exit pcwd_cleanup_module(void)
-{
-	isa_unregister_driver(&pcwd_isa_driver);
-	pr_info("Watchdog Module Unloaded\n");
-}
-
-module_init(pcwd_init_module);
-module_exit(pcwd_cleanup_module);
+module_isa_driver(pcwd_isa_driver, PCWD_ISA_NR_CARDS);
 
 MODULE_AUTHOR("Ken Hollis <kenji@bitgate.com>, "
 		"Wim Van Sebroeck <wim@iguana.be>");
diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
index 962f58c..c797305 100644
--- a/drivers/watchdog/pic32-dmt.c
+++ b/drivers/watchdog/pic32-dmt.c
@@ -176,8 +176,8 @@ static int pic32_dmt_probe(struct platform_device *pdev)
 	struct watchdog_device *wdd = &pic32_dmt_wdd;
 
 	dmt = devm_kzalloc(&pdev->dev, sizeof(*dmt), GFP_KERNEL);
-	if (IS_ERR(dmt))
-		return PTR_ERR(dmt);
+	if (!dmt)
+		return -ENOMEM;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dmt->regs = devm_ioremap_resource(&pdev->dev, mem);
@@ -245,7 +245,6 @@ static struct platform_driver pic32_dmt_driver = {
 	.remove		= pic32_dmt_remove,
 	.driver		= {
 		.name		= "pic32-dmt",
-		.owner		= THIS_MODULE,
 		.of_match_table = of_match_ptr(pic32_dmt_of_ids),
 	}
 };
diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index 6047aa8..e276106 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -174,8 +174,8 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 	struct resource *mem;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
-	if (IS_ERR(wdt))
-		return PTR_ERR(wdt);
+	if (!wdt)
+		return -ENOMEM;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->regs = devm_ioremap_resource(&pdev->dev, mem);
@@ -183,8 +183,8 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 		return PTR_ERR(wdt->regs);
 
 	wdt->rst_base = devm_ioremap(&pdev->dev, PIC32_BASE_RESET, 0x10);
-	if (IS_ERR(wdt->rst_base))
-		return PTR_ERR(wdt->rst_base);
+	if (!wdt->rst_base)
+		return -ENOMEM;
 
 	wdt->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
@@ -251,7 +251,6 @@ static struct platform_driver pic32_wdt_driver = {
 	.remove		= pic32_wdt_drv_remove,
 	.driver		= {
 		.name		= "pic32-wdt",
-		.owner		= THIS_MODULE,
 		.of_match_table = of_match_ptr(pic32_wdt_dt_ids),
 	}
 };
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index a043fa4..5796b5d 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -18,19 +18,45 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
+#include <linux/of_device.h>
+
+enum wdt_reg {
+	WDT_RST,
+	WDT_EN,
+	WDT_STS,
+	WDT_BARK_TIME,
+	WDT_BITE_TIME,
+};
 
-#define WDT_RST		0x38
-#define WDT_EN		0x40
-#define WDT_STS		0x44
-#define WDT_BITE_TIME	0x5C
+static const u32 reg_offset_data_apcs_tmr[] = {
+	[WDT_RST] = 0x38,
+	[WDT_EN] = 0x40,
+	[WDT_STS] = 0x44,
+	[WDT_BARK_TIME] = 0x4C,
+	[WDT_BITE_TIME] = 0x5C,
+};
+
+static const u32 reg_offset_data_kpss[] = {
+	[WDT_RST] = 0x4,
+	[WDT_EN] = 0x8,
+	[WDT_STS] = 0xC,
+	[WDT_BARK_TIME] = 0x10,
+	[WDT_BITE_TIME] = 0x14,
+};
 
 struct qcom_wdt {
 	struct watchdog_device	wdd;
 	struct clk		*clk;
 	unsigned long		rate;
 	void __iomem		*base;
+	const u32		*layout;
 };
 
+static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
+{
+	return wdt->base + wdt->layout[reg];
+}
+
 static inline
 struct qcom_wdt *to_qcom_wdt(struct watchdog_device *wdd)
 {
@@ -41,10 +67,11 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
 {
 	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
 
-	writel(0, wdt->base + WDT_EN);
-	writel(1, wdt->base + WDT_RST);
-	writel(wdd->timeout * wdt->rate, wdt->base + WDT_BITE_TIME);
-	writel(1, wdt->base + WDT_EN);
+	writel(0, wdt_addr(wdt, WDT_EN));
+	writel(1, wdt_addr(wdt, WDT_RST));
+	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
+	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
+	writel(1, wdt_addr(wdt, WDT_EN));
 	return 0;
 }
 
@@ -52,7 +79,7 @@ static int qcom_wdt_stop(struct watchdog_device *wdd)
 {
 	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
 
-	writel(0, wdt->base + WDT_EN);
+	writel(0, wdt_addr(wdt, WDT_EN));
 	return 0;
 }
 
@@ -60,7 +87,7 @@ static int qcom_wdt_ping(struct watchdog_device *wdd)
 {
 	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
 
-	writel(1, wdt->base + WDT_RST);
+	writel(1, wdt_addr(wdt, WDT_RST));
 	return 0;
 }
 
@@ -83,10 +110,11 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
 	 */
 	timeout = 128 * wdt->rate / 1000;
 
-	writel(0, wdt->base + WDT_EN);
-	writel(1, wdt->base + WDT_RST);
-	writel(timeout, wdt->base + WDT_BITE_TIME);
-	writel(1, wdt->base + WDT_EN);
+	writel(0, wdt_addr(wdt, WDT_EN));
+	writel(1, wdt_addr(wdt, WDT_RST));
+	writel(timeout, wdt_addr(wdt, WDT_BARK_TIME));
+	writel(timeout, wdt_addr(wdt, WDT_BITE_TIME));
+	writel(1, wdt_addr(wdt, WDT_EN));
 
 	/*
 	 * Actually make sure the above sequence hits hardware before sleeping.
@@ -119,9 +147,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	struct qcom_wdt *wdt;
 	struct resource *res;
 	struct device_node *np = pdev->dev.of_node;
+	const u32 *regs;
 	u32 percpu_offset;
 	int ret;
 
+	regs = of_device_get_match_data(&pdev->dev);
+	if (!regs) {
+		dev_err(&pdev->dev, "Unsupported QCOM WDT module\n");
+		return -ENODEV;
+	}
+
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
@@ -172,6 +207,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
 	wdt->wdd.parent = &pdev->dev;
+	wdt->layout = regs;
 
 	if (readl(wdt->base + WDT_STS) & 1)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
@@ -208,8 +244,9 @@ static int qcom_wdt_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_wdt_of_table[] = {
-	{ .compatible = "qcom,kpss-timer" },
-	{ .compatible = "qcom,scss-timer" },
+	{ .compatible = "qcom,kpss-timer", .data = reg_offset_data_apcs_tmr },
+	{ .compatible = "qcom,scss-timer", .data = reg_offset_data_apcs_tmr },
+	{ .compatible = "qcom,kpss-wdt", .data = reg_offset_data_kpss },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index ad383f6..ce0c38b 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -180,15 +180,6 @@ static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
 	return 0;
 }
 
-static unsigned int sbsa_gwdt_status(struct watchdog_device *wdd)
-{
-	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
-	u32 status = readl(gwdt->control_base + SBSA_GWDT_WCS);
-
-	/* is the watchdog timer running? */
-	return (status & SBSA_GWDT_WCS_EN) << WDOG_ACTIVE;
-}
-
 static int sbsa_gwdt_start(struct watchdog_device *wdd)
 {
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
@@ -228,7 +219,6 @@ static struct watchdog_ops sbsa_gwdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= sbsa_gwdt_start,
 	.stop		= sbsa_gwdt_stop,
-	.status		= sbsa_gwdt_status,
 	.ping		= sbsa_gwdt_keepalive,
 	.set_timeout	= sbsa_gwdt_set_timeout,
 	.get_timeleft	= sbsa_gwdt_get_timeleft,
@@ -273,7 +263,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	wdd->info = &sbsa_gwdt_info;
 	wdd->ops = &sbsa_gwdt_ops;
 	wdd->min_timeout = 1;
-	wdd->max_timeout = U32_MAX / gwdt->clk;
+	wdd->max_hw_heartbeat_ms = U32_MAX / gwdt->clk * 1000;
 	wdd->timeout = DEFAULT_TIMEOUT;
 	watchdog_set_drvdata(wdd, gwdt);
 	watchdog_set_nowayout(wdd, nowayout);
@@ -283,6 +273,8 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 		dev_warn(dev, "System reset by WDT.\n");
 		wdd->bootstatus |= WDIOF_CARDRESET;
 	}
+	if (status & SBSA_GWDT_WCS_EN)
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
 
 	if (action) {
 		irq = platform_get_irq(pdev, 0);
@@ -310,7 +302,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	 * the timeout is (WOR * 2), so the maximum timeout should be doubled.
 	 */
 	if (!action)
-		wdd->max_timeout *= 2;
+		wdd->max_hw_heartbeat_ms *= 2;
 
 	watchdog_init_timeout(wdd, timeout, dev);
 	/*
diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index d0578ab..3050a00 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -39,13 +39,18 @@ MODULE_PARM_DESC(timeout, "Default watchdog timeout (in seconds)");
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+static void __iomem *sirfsoc_wdt_base(struct watchdog_device *wdd)
+{
+	return (void __iomem __force *)watchdog_get_drvdata(wdd);
+}
+
 static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
 {
 	u32 counter, match;
 	void __iomem *wdt_base;
 	int time_left;
 
-	wdt_base = watchdog_get_drvdata(wdd);
+	wdt_base = sirfsoc_wdt_base(wdd);
 	counter = readl(wdt_base + SIRFSOC_TIMER_COUNTER_LO);
 	match = readl(wdt_base +
 		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
@@ -61,7 +66,7 @@ static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
 	void __iomem *wdt_base;
 
 	timeout_ticks = wdd->timeout * CLOCK_FREQ;
-	wdt_base = watchdog_get_drvdata(wdd);
+	wdt_base = sirfsoc_wdt_base(wdd);
 
 	/* Enable the latch before reading the LATCH_LO register */
 	writel(1, wdt_base + SIRFSOC_TIMER_LATCH);
@@ -79,7 +84,7 @@ static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
 
 static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
 {
-	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
+	void __iomem *wdt_base = sirfsoc_wdt_base(wdd);
 	sirfsoc_wdt_updatetimeout(wdd);
 
 	/*
@@ -96,7 +101,7 @@ static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
 
 static int sirfsoc_wdt_disable(struct watchdog_device *wdd)
 {
-	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
+	void __iomem *wdt_base = sirfsoc_wdt_base(wdd);
 
 	writel(0, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
 	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
@@ -150,7 +155,7 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	watchdog_set_drvdata(&sirfsoc_wdd, base);
+	watchdog_set_drvdata(&sirfsoc_wdd, (__force void *)base);
 
 	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
 	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 99a06f9..b067edf 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -17,36 +17,19 @@
  *
  *	Software only watchdog driver. Unlike its big brother the WDT501P
  *	driver this won't always recover a failed machine.
- *
- *  03/96: Angelo Haritsis <ah@doc.ic.ac.uk> :
- *	Modularised.
- *	Added soft_margin; use upon insmod to change the timer delay.
- *	NB: uses same minor as wdt (WATCHDOG_MINOR); we could use separate
- *	    minors.
- *
- *  19980911 Alan Cox
- *	Made SMP safe for 2.3.x
- *
- *  20011127 Joel Becker (jlbec@evilplan.org>
- *	Added soft_noboot; Allows testing the softdog trigger without
- *	requiring a recompile.
- *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
- *
- *  20020530 Joel Becker <joel.becker@oracle.com>
- *	Added Matt Domsch's nowayout module option.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/types.h>
+#include <linux/reboot.h>
 #include <linux/timer.h>
+#include <linux/types.h>
 #include <linux/watchdog.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/jiffies.h>
-#include <linux/kernel.h>
 
 #define TIMER_MARGIN	60		/* Default is 60 seconds */
 static unsigned int soft_margin = TIMER_MARGIN;	/* in seconds */
@@ -71,25 +54,12 @@ module_param(soft_panic, int, 0);
 MODULE_PARM_DESC(soft_panic,
 	"Softdog action, set to 1 to panic, 0 to reboot (default=0)");
 
-/*
- *	Our timer
- */
-
-static void watchdog_fire(unsigned long);
-
-static struct timer_list watchdog_ticktock =
-		TIMER_INITIALIZER(watchdog_fire, 0, 0);
-
-/*
- *	If the timer expires..
- */
-
-static void watchdog_fire(unsigned long data)
+static void softdog_fire(unsigned long data)
 {
 	module_put(THIS_MODULE);
-	if (soft_noboot)
+	if (soft_noboot) {
 		pr_crit("Triggered - Reboot ignored\n");
-	else if (soft_panic) {
+	} else if (soft_panic) {
 		pr_crit("Initiating panic\n");
 		panic("Software Watchdog Timer expired");
 	} else {
@@ -99,35 +69,24 @@ static void watchdog_fire(unsigned long data)
 	}
 }
 
-/*
- *	Softdog operations
- */
+static struct timer_list softdog_ticktock =
+		TIMER_INITIALIZER(softdog_fire, 0, 0);
 
 static int softdog_ping(struct watchdog_device *w)
 {
-	if (!mod_timer(&watchdog_ticktock, jiffies+(w->timeout*HZ)))
+	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
 		__module_get(THIS_MODULE);
 	return 0;
 }
 
 static int softdog_stop(struct watchdog_device *w)
 {
-	if (del_timer(&watchdog_ticktock))
+	if (del_timer(&softdog_ticktock))
 		module_put(THIS_MODULE);
 
 	return 0;
 }
 
-static int softdog_set_timeout(struct watchdog_device *w, unsigned int t)
-{
-	w->timeout = t;
-	return 0;
-}
-
-/*
- *	Kernel Interfaces
- */
-
 static struct watchdog_info softdog_info = {
 	.identity = "Software Watchdog",
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
@@ -137,29 +96,21 @@ static struct watchdog_ops softdog_ops = {
 	.owner = THIS_MODULE,
 	.start = softdog_ping,
 	.stop = softdog_stop,
-	.set_timeout = softdog_set_timeout,
 };
 
 static struct watchdog_device softdog_dev = {
 	.info = &softdog_info,
 	.ops = &softdog_ops,
 	.min_timeout = 1,
-	.max_timeout = 0xFFFF
+	.max_timeout = 65535,
+	.timeout = TIMER_MARGIN,
 };
 
-static int __init watchdog_init(void)
+static int __init softdog_init(void)
 {
 	int ret;
 
-	/* Check that the soft_margin value is within it's range;
-	   if not reset to the default */
-	if (soft_margin < 1 || soft_margin > 65535) {
-		pr_info("soft_margin must be 0 < soft_margin < 65536, using %d\n",
-			TIMER_MARGIN);
-		return -EINVAL;
-	}
-	softdog_dev.timeout = soft_margin;
-
+	watchdog_init_timeout(&softdog_dev, soft_margin, NULL);
 	watchdog_set_nowayout(&softdog_dev, nowayout);
 	watchdog_stop_on_reboot(&softdog_dev);
 
@@ -167,19 +118,18 @@ static int __init watchdog_init(void)
 	if (ret)
 		return ret;
 
-	pr_info("Software Watchdog Timer: 0.08 initialized. soft_noboot=%d soft_margin=%d sec soft_panic=%d (nowayout=%d)\n",
-		soft_noboot, soft_margin, soft_panic, nowayout);
+	pr_info("initialized. soft_noboot=%d soft_margin=%d sec soft_panic=%d (nowayout=%d)\n",
+		soft_noboot, softdog_dev.timeout, soft_panic, nowayout);
 
 	return 0;
 }
+module_init(softdog_init);
 
-static void __exit watchdog_exit(void)
+static void __exit softdog_exit(void)
 {
 	watchdog_unregister_device(&softdog_dev);
 }
-
-module_init(watchdog_init);
-module_exit(watchdog_exit);
+module_exit(softdog_exit);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Software Watchdog Device Driver");
diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index cfbed7e..202c4b9 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -149,7 +149,7 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	dev->wdt.ops = &tangox_wdt_ops;
 	dev->wdt.timeout = DEFAULT_TIMEOUT;
 	dev->wdt.min_timeout = 1;
-	dev->wdt.max_timeout = (U32_MAX - 1) / dev->clk_rate;
+	dev->wdt.max_hw_heartbeat_ms = (U32_MAX - 1) / dev->clk_rate;
 
 	watchdog_init_timeout(&dev->wdt, timeout, &pdev->dev);
 	watchdog_set_nowayout(&dev->wdt, nowayout);
@@ -170,7 +170,7 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	 * already running.
 	 */
 	if (readl(dev->base + WD_COUNTER)) {
-		set_bit(WDOG_ACTIVE, &dev->wdt.status);
+		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
 		tangox_wdt_start(&dev->wdt);
 	}
 
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 7c3ba58..6abb83c 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -88,7 +88,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 	 * Check that we have valid min and max timeout values, if
 	 * not reset them both to 0 (=not used or unknown)
 	 */
-	if (wdd->min_timeout > wdd->max_timeout) {
+	if (!wdd->max_hw_heartbeat_ms && wdd->min_timeout > wdd->max_timeout) {
 		pr_info("Invalid min and max timeout values, resetting to 0!\n");
 		wdd->min_timeout = 0;
 		wdd->max_timeout = 0;
@@ -329,6 +329,43 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 
 EXPORT_SYMBOL_GPL(watchdog_unregister_device);
 
+static void devm_watchdog_unregister_device(struct device *dev, void *res)
+{
+	watchdog_unregister_device(*(struct watchdog_device **)res);
+}
+
+/**
+ * devm_watchdog_register_device() - resource managed watchdog_register_device()
+ * @dev: device that is registering this watchdog device
+ * @wdd: watchdog device
+ *
+ * Managed watchdog_register_device(). For watchdog device registered by this
+ * function,  watchdog_unregister_device() is automatically called on driver
+ * detach. See watchdog_register_device() for more information.
+ */
+int devm_watchdog_register_device(struct device *dev,
+				struct watchdog_device *wdd)
+{
+	struct watchdog_device **rcwdd;
+	int ret;
+
+	rcwdd = devres_alloc(devm_watchdog_unregister_device, sizeof(*wdd),
+			     GFP_KERNEL);
+	if (!rcwdd)
+		return -ENOMEM;
+
+	ret = watchdog_register_device(wdd);
+	if (!ret) {
+		*rcwdd = wdd;
+		devres_add(dev, rcwdd);
+	} else {
+		devres_free(rcwdd);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_watchdog_register_device);
+
 static int __init watchdog_deferred_registration(void)
 {
 	mutex_lock(&wtd_deferred_reg_mutex);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 3595cff..040bf83 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -69,6 +69,7 @@ struct watchdog_core_data {
 	unsigned long status;		/* Internal status bits */
 #define _WDOG_DEV_OPEN		0	/* Opened ? */
 #define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
+#define _WDOG_KEEPALIVE		2	/* Did we receive a keepalive ? */
 };
 
 /* the dev_t structure to store the dynamically allocated watchdog devices */
@@ -92,9 +93,13 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 	 *   thus is aware that the framework supports generating heartbeat
 	 *   requests.
 	 * - Userspace requests a longer timeout than the hardware can handle.
+	 *
+	 * Alternatively, if userspace has not opened the watchdog
+	 * device, we take care of feeding the watchdog if it is
+	 * running.
 	 */
-	return hm && ((watchdog_active(wdd) && t > hm) ||
-		      (t && !watchdog_active(wdd) && watchdog_hw_running(wdd)));
+	return (hm && watchdog_active(wdd) && t > hm) ||
+		(t && !watchdog_active(wdd) && watchdog_hw_running(wdd));
 }
 
 static long watchdog_next_keepalive(struct watchdog_device *wdd)
@@ -107,7 +112,7 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
 	unsigned int hw_heartbeat_ms;
 
 	virt_timeout = wd_data->last_keepalive + msecs_to_jiffies(timeout_ms);
-	hw_heartbeat_ms = min(timeout_ms, wdd->max_hw_heartbeat_ms);
+	hw_heartbeat_ms = min_not_zero(timeout_ms, wdd->max_hw_heartbeat_ms);
 	keepalive_interval = msecs_to_jiffies(hw_heartbeat_ms / 2);
 
 	if (!watchdog_active(wdd))
@@ -180,6 +185,8 @@ static int watchdog_ping(struct watchdog_device *wdd)
 	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
 		return 0;
 
+	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
+
 	wd_data->last_keepalive = jiffies;
 	return __watchdog_ping(wdd);
 }
@@ -219,6 +226,8 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (watchdog_active(wdd))
 		return 0;
 
+	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
+
 	started_at = jiffies;
 	if (watchdog_hw_running(wdd) && wdd->ops->ping)
 		err = wdd->ops->ping(wdd);
@@ -258,10 +267,12 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		return -EBUSY;
 	}
 
-	if (wdd->ops->stop)
+	if (wdd->ops->stop) {
+		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
-	else
+	} else {
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	}
 
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
@@ -282,10 +293,27 @@ static int watchdog_stop(struct watchdog_device *wdd)
 
 static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 {
-	if (!wdd->ops->status)
-		return 0;
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+	unsigned int status;
+
+	if (wdd->ops->status)
+		status = wdd->ops->status(wdd);
+	else
+		status = wdd->bootstatus & (WDIOF_CARDRESET |
+					    WDIOF_OVERHEAT |
+					    WDIOF_FANFAULT |
+					    WDIOF_EXTERN1 |
+					    WDIOF_EXTERN2 |
+					    WDIOF_POWERUNDER |
+					    WDIOF_POWEROVER);
 
-	return wdd->ops->status(wdd);
+	if (test_bit(_WDOG_ALLOW_RELEASE, &wd_data->status))
+		status |= WDIOF_MAGICCLOSE;
+
+	if (test_and_clear_bit(_WDOG_KEEPALIVE, &wd_data->status))
+		status |= WDIOF_KEEPALIVEPING;
+
+	return status;
 }
 
 /*
@@ -361,7 +389,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	status = watchdog_get_status(wdd);
 	mutex_unlock(&wd_data->lock);
 
-	return sprintf(buf, "%u\n", status);
+	return sprintf(buf, "0x%x\n", status);
 }
 static DEVICE_ATTR_RO(status);
 
@@ -429,9 +457,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
-	if (attr == &dev_attr_status.attr && !wdd->ops->status)
-		mode = 0;
-	else if (attr == &dev_attr_timeleft.attr && !wdd->ops->get_timeleft)
+	if (attr == &dev_attr_timeleft.attr && !wdd->ops->get_timeleft)
 		mode = 0;
 
 	return mode;
@@ -948,17 +974,22 @@ int __init watchdog_dev_init(void)
 	err = class_register(&watchdog_class);
 	if (err < 0) {
 		pr_err("couldn't register class\n");
-		return err;
+		goto err_register;
 	}
 
 	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
 	if (err < 0) {
 		pr_err("watchdog: unable to allocate char dev region\n");
-		class_unregister(&watchdog_class);
-		return err;
+		goto err_alloc;
 	}
 
 	return 0;
+
+err_alloc:
+	class_unregister(&watchdog_class);
+err_register:
+	destroy_workqueue(watchdog_wq);
+	return err;
 }
 
 /*
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index cbe373d..fa1efef 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -339,7 +339,7 @@ static int ziirave_wdt_remove(struct i2c_client *client)
 }
 
 static struct i2c_device_id ziirave_wdt_id[] = {
-	{ "ziirave-wdt", 0 },
+	{ "rave-wdt", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ziirave_wdt_id);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 51732d6..7047bc7 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -66,7 +66,8 @@ struct watchdog_ops {
  *		as configurable from user space. Only relevant if
  *		max_hw_heartbeat_ms is not provided.
  * @min_hw_heartbeat_ms:
- *		Minimum time between heartbeats, in milli-seconds.
+ *		Hardware limit for minimum time between heartbeats,
+ *		in milli-seconds.
  * @max_hw_heartbeat_ms:
  *		Hardware limit for maximum timeout, in milli-seconds.
  *		Replaces max_timeout if specified.
@@ -180,4 +181,7 @@ extern int watchdog_init_timeout(struct watchdog_device *wdd,
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
+/* devres register variant */
+int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
+
 #endif  /* ifndef _LINUX_WATCHDOG_H */
