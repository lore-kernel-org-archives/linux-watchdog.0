Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 11 Jul 2017 17:17:43 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Yannick Fertre <yannick.fertre@st.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [GIT PULL REQUEST] watchdog - v4.13-rc1 Merge Window
Message-ID: <20170711151743.GA31924@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It contains the following:
* Add Renesas RZ/A WDT Watchdog driver
* STM32 Independent WatchDoG (IWDG) support
* UniPhier watchdog support
* Add F71868 support
* Add support for NCT6793D and NCT6795D
* dw_wdt: add reset lines support
* core: add option to avoid early handling of watchdog
* core: introduce watchdog_worker_should_ping helper
* Cleanups and improvements for sama5d4, intel-mid_wdt, s3c2410_wdt, orion_wdt, gpio_wdt,
  it87_wdt, meson_wdt, davinci_wdt, bcm47xx_wdt, zx2967_wdt, cadence_wdt

This will update the following files:

 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt    |   23 
 Documentation/devicetree/bindings/watchdog/dw_wdt.txt        |    3 
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt   |    4 
 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt |   19 
 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt  |   20 
 Documentation/watchdog/watchdog-parameters.txt               |    6 
 drivers/watchdog/Kconfig                                     |   61 -
 drivers/watchdog/Makefile                                    |    3 
 drivers/watchdog/bcm47xx_wdt.c                               |    4 
 drivers/watchdog/cadence_wdt.c                               |    2 
 drivers/watchdog/davinci_wdt.c                               |   10 
 drivers/watchdog/dw_wdt.c                                    |   11 
 drivers/watchdog/f71808e_wdt.c                               |   27 
 drivers/watchdog/gpio_wdt.c                                  |   73 -
 drivers/watchdog/intel-mid_wdt.c                             |   17 
 drivers/watchdog/it87_wdt.c                                  |  588 +----------
 drivers/watchdog/meson_gxbb_wdt.c                            |    4 
 drivers/watchdog/orion_wdt.c                                 |    2 
 drivers/watchdog/rza_wdt.c                                   |  199 +++
 drivers/watchdog/s3c2410_wdt.c                               |   58 -
 drivers/watchdog/sama5d4_wdt.c                               |   19 
 drivers/watchdog/stm32_iwdg.c                                |  253 ++++
 drivers/watchdog/uniphier_wdt.c                              |  268 +++++
 drivers/watchdog/w83627hf_wdt.c                              |   15 
 drivers/watchdog/watchdog_dev.c                              |   32 
 drivers/watchdog/zx2967_wdt.c                                |    2 
 26 files changed, 1077 insertions(+), 646 deletions(-)

with these Changes:

commit c013b65ad8a1e132f733404809afc72f7d00e768
Author: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Tue May 30 10:56:45 2017 +0200

    watchdog: introduce watchdog_worker_should_ping helper
    
    This will be useful when the condition becomes slightly more
    complicated in the next patch.
    
    Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    Reviewed-by: Esben Haabendal <esben@haabendal.dk>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e7bf02895f06c0603af800c4bfce3ca4ede9147d
Author: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date:   Wed Jun 14 16:53:44 2017 +0900

    watchdog: uniphier: add UniPhier watchdog driver
    
    Add a watchdog driver for Socionext UniPhier series SoC.
    Note that the timeout value for this device must be a power
    of 2 because of the specification.
    
    Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e75bf0ea77e9778e9a1975eb9b38698babcbde63
Author: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date:   Wed Jun 14 16:53:43 2017 +0900

    dt-bindings: watchdog: add description for UniPhier WDT controller
    
    Add uniphier-wdt dt-bindings documentation.
    
    Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 011e29e7d93d80c2529ba17109bc4e5d031ea2b1
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Tue Jun 20 11:04:26 2017 +0530

    watchdog: cadence_wdt: make of_device_ids const.
    
    of_device_ids are not supposed to change at runtime. All functions
    working with of_device_ids provided by <linux/of.h> work with const
    of_device_ids. So mark the non-const structs as const.
    
    File size before:
       text	   data	    bss	    dec	    hex	filename
       1962	    612	      4	   2578	    a12	drivers/watchdog/cadence_wdt.o
    
    File size after constify cdns_wdt_of_match:
       text	   data	    bss	    dec	    hex	filename
       2378	    196	      4	   2578	    a12	drivers/watchdog/cadence_wdt.o
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 935988c67406f35e63873ac63e2962664ee99bdc
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Mon Jun 12 12:02:39 2017 +0530

    watchdog: zx2967: constify zx2967_wdt_ops.
    
    File size before:
       text	   data	    bss	    dec	    hex	filename
        988	    288	      0	   1276	    4fc	drivers/watchdog/zx2967_wdt.o
    
    File size After adding 'const':
       text	   data	    bss	    dec	    hex	filename
       1084	    192	      0	   1276	    4fc	drivers/watchdog/zx2967_wdt.o
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d34f1f4800439c8330f05e9f1133317f3b1f8c38
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Mon Jun 12 11:50:26 2017 +0530

    watchdog: bcm47xx_wdt: constify bcm47xx_wdt_hard_ops and bcm47xx_wdt_soft_ops
    
    File size before:
       text	   data	    bss	    dec	    hex	filename
       1282	    388	      1	   1671	    687	drivers/watchdog/bcm47xx_wdt.o
    
    File size After adding 'const':
       text	   data	    bss	    dec	    hex	filename
       1474	    196	      1	   1671	    687	drivers/watchdog/bcm47xx_wdt.o
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 737bcff5faaeea121ccf7c5885507d438c60f06b
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Tue Jun 6 16:08:31 2017 +0530

    watchdog: davinci: Add missing clk_disable_unprepare().
    
    davinci_wdt_probe() can fail here and we must disable clock.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8f11eb58ad5747bab622910cc2efaa45e6a21c1f
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Tue Jun 6 15:47:53 2017 +0530

    watchdog: davinci: Handle return value of clk_prepare_enable
    
    clk_prepare_enable() can fail here and we must check its return value.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 65360944c19814a6d3c0a58c5a983f7198d29c51
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Wed Jun 7 15:04:15 2017 +0530

    watchdog: meson: Handle return value of clk_prepare_enable
    
    clk_prepare_enable() can fail here and we must check its return value.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit cddda07c7b31828f08c18f5898df0e457d280ada
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sat Jun 10 21:04:36 2017 -0700

    watchdog: it87: Add support for various Super-IO chips
    
    Add support for IT8607, IT8622, IT8625, IT8628, IT8655, IT8665,
    and IT8686.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1123c514b11201758674e2b34f297b94509d81db
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sat Jun 10 21:04:35 2017 -0700

    watchdog: it87: Use infrastructure to stop watchdog on reboot
    
    Use watchdog_stop_on_reboot() to stop the watchdog on reboot instead
    of registering a driver-specific notifier.
    
    While at it, reorder remaining include files alphabetically.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 893dc8b5c9785e9ecf5ddfebbd78da6eddcdbac6
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sat Jun 10 21:04:34 2017 -0700

    watchdog: it87: Drop support for resetting watchdog though CIR and Game port
    
    Resetting the watchdog timer on CIR interrupts or on game port interrupts
    is not not supported on recent chips, and doesn't really tell if the system
    is stable. On top of that, at least the bit to enable resetting the
    watchdog through the game port is used differently on recent chips.
    Drop resetting the watchdog on CIR  or game port interrupts to simplify
    the code.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1d7b80394c48a56c705733cb6c044199ffbf1dfd
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sat Jun 10 21:04:33 2017 -0700

    watchdog: it87: Convert to use watchdog core infrastructure
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 733403017399f18c1e31db2470b724e2605618b9
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sat Jun 10 21:04:32 2017 -0700

    watchdog: it87: Drop FSF mailing address
    
    The FSF mailing address may change. Drop it.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 65a3b6935d920a37820226864eb607467e49ba50
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date:   Mon May 22 10:51:39 2017 +0200

    watchdog: dw_wdt: get reset lines from dt
    
    The dw_wdt has an external reset line, that can keep the device in reset
    and therefore rendering it useless and also is the only way of stopping
    the watchdog once it was started.
    
    Get the reset lines for this core from the devicetree. As these lines are
    optional, use devm_reset_control_get_optional_shared. If the reset line
    is not specified in the devicetree, the reset framework will just skip
    deasserting and continue.
    This way all users of the driver will continue to function without
    any harm, even if the reset line is not specified in the devicetree.
    
    Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
    Cc: linux-watchdog@vger.kernel.org
    Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d9c033a1343d91fb1c1eebe66823673c60b91915
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date:   Mon May 22 10:51:38 2017 +0200

    watchdog: bindings: dw_wdt: add reset lines
    
    Document the reset lines holding the watchdog core in reset.
    
    Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
    Cc: Rob Herring <robh+dt@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: linux-watchdog@vger.kernel.org
    Cc: devicetree@vger.kernel.org
    Acked-by: Rob Herring <robh@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3a9aedb282acf1499a31834c457335e4535e4a1d
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Mon May 29 16:21:31 2017 -0700

    watchdog: w83627hf: Add support for NCT6793D and NCT6795D
    
    Both NCT6793D and NCT6795D are compatible to NCT6792D.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2501b015313fe2fa40ed11fa4dd1748e09b7c773
Author: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Date:   Fri May 12 14:05:32 2017 +0200

    watchdog: core: add option to avoid early handling of watchdog
    
    On some systems its desirable to have watchdog reboot the system
    when it does not come up fast enough. This adds a kernel parameter
    to disable the auto-update of watchdog before userspace takes over
    and a kernel option to set the default. The info messages were
    added to shorten error searching on misconfigured systems.
    
    Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 166fbcf88fdafa02f784ec25ac64745c716b2de0
Author: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Date:   Mon Apr 17 22:37:05 2017 +0200

    watchdog: f71808e_wdt: Add F71868 support
    
    This adds support for watchdog part of Fintek F71868 Super I/O chip to
    f71808e_wdt driver.
    
    The F71868 chip is, in general, very similar to a F71869, however it has
    slightly different set of available reset pulse widths.
    
    Tested on MSI A55M-P33 motherboard.
    
    Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 4332d113c66a6ecb3702cb8f265adbbe654f9d5f
Author: Yannick Fertre <yannick.fertre@st.com>
Date:   Thu Apr 6 14:19:25 2017 +0200

    watchdog: Add STM32 IWDG driver
    
    This patch adds IWDG (Independent WatchDoG) support for STM32 platform.
    
    Signed-off-by: Yannick FERTRE <yannick.fertre@st.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5df11427b2d20ac1f4fdd1bcb6319743a4b6797e
Author: Yannick Fertre <yannick.fertre@st.com>
Date:   Thu Apr 6 14:19:24 2017 +0200

    dt-bindings: watchdog: Document STM32 IWDG bindings
    
    This adds documentation of device tree bindings for the STM32 IWDG
    (Independent WatchDoG).
    
    Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f66872b5be147b32806dc98d808ee784fe7965c7
Author: Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue Mar 28 15:43:30 2017 +0100

    Documentation: devicetree: watchdog: da9062/61 watchdog timer binding
    
    Add binding information for DA9062 and DA9061 watchdog.
    
    Example bindings for both DA9062 and DA9061 devices are added. For
    the DA9061 device, a fallback compatible line is added as a valid
    combination of compatible strings.
    
    The original binding for DA9062 (only) used to reside inside the
    Documentation/devicetree/bindings/mfd/da9062.txt MFD document.
    The da9062-watchdog section was deleted in that file and replaced
    with a link to the new DA9061/62 binding information stored in this
    patch.
    
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 03bca15833f2865b11835b7f5bfa594d1aaacecc
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 28 13:12:23 2016 -0800

    watchdog: gpio: Convert to use infrastructure triggered keepalives
    
    The watchdog infrastructure now supports handling watchdog keepalive
    if the watchdog is running while the watchdog device is closed.
    The infrastructure now also supports generating additional heartbeats
    if the maximum hardware timeout is smaller than or close to the
    configured timeout. Convert the driver to use this infrastructure.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ecd94a41debfd21961c9f59f639dce26f2c779f0
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Wed Mar 29 17:34:24 2017 +0200

    watchdog: orion: make license info match the file header
    
    The header says: This file is licensed under the terms of the GNU
    General Public License version 2. The right identifier for
    MODULE_LICENSE is "GPL v2" then.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 08497f22b15affcf08fb2d1173caa73e7ad54df7
Author: Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon Mar 13 21:07:26 2017 +0200

    watchdog: s3c2410: Minor code cleanup
    
    Cleanup the code from minor readability issues (no functional changes):
    1. Fix checkpatch: ERROR: Do not include the paragraph about writing to
       the Free Software Foundation's mailing address.
    2. Fix checkpatch: WARNING: quoted string split across lines
    3. Fix chechpatch: WARNING: Prefer 'unsigned int' to bare use of
       'unsigned'
    4. Use 'dev' consistently in probe function instead of mixing dev with
       &pdev->dev.
    
    Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
    Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a9a02c46624ad112eb07ca26b6a025c1358ed3ad
Author: Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon Mar 13 21:07:25 2017 +0200

    watchdog: s3c2410: Simplify getting driver data
    
    Simplify the flow in helper function for getting the driver data by
    using of_device_get_match_data() and only one if() branch.
    
    The code should be equivalent.
    
    Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 58415efe96670b858eb7b5ab066881ae3f1dad25
Author: Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon Mar 13 21:07:24 2017 +0200

    watchdog: s3c2410: Constify local structures
    
    Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
    modified so they can be made const to increase code safeness.
    
    Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
    Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 954351e8707bcdf6091cc55dab4e9e2453de6655
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Sat Mar 11 00:22:17 2017 +0200

    watchdog: intel-mid_wdt: Keep watchdog running
    
    Firmware followed by bootloader leaves watchdog running.
    
    Keep it running in the driver.
    
    User will not need any additional options to reboot in case of panic
    during boot.
    
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0ab1380804ad709ced066eb10568110987e42570
Author: Chris Brandt <chris.brandt@renesas.com>
Date:   Sat Mar 4 17:37:36 2017 -0500

    watchdog: renesas-wdt: add support for rza
    
    Describe the WDT hardware in the RZ/A series.
    
    Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
    Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Acked-by: Rob Herring <robh@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit aea24187f65e8adb00b2be949cd809fcb2aa241c
Author: Chris Brandt <chris.brandt@renesas.com>
Date:   Sat Mar 4 17:37:35 2017 -0500

    watchdog: add rza_wdt driver
    
    Adds a watchdog timer driver for the Renesas RZ/A Series SoCs. A reset
    handler is also included since a WDT overflow is the only method for
    restarting an RZ/A SoC.
    
    Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5dca80f63eaf18eca2ba3ebf61056feb66103951
Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date:   Thu Mar 2 18:31:14 2017 +0100

    watchdog: sama5d4: Add comment explaining what happens on resume
    
    Because suspending to RAM may lose the register values, they are restored
    on resume. This is currently done unconditionally because there is
    currently no way to know (from the driver) whether they have really been
    lost or are still valid. Writing MR also pings the watchdog and this may
    not be what is expected so add a comment explaining why it happens.
    
    Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 39bd56df7b2dae80d4099c64ad776775a3876ed5
Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date:   Thu Mar 2 18:31:13 2017 +0100

    watchodg: sama5d4: simplify probe
    
    Because the only way to use the driver is to have a device tree enabling
    it, pdev->dev.of_node will never be NULL. Remove the unnecessary check.
    
    Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Greetings,
Wim.
