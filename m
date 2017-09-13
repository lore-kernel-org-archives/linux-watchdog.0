Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 13 Sep 2017 20:29:44 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        "fzuuzf@googlemail.com" <fzuuzf@googlemail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maulik Jodhani <maulik.jodhani@xilinx.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL REQUEST] watchdog - v4.14-rc1 Merge Window
Message-ID: <20170913182944.GA2181@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It contains following changes:
* add support for the watchdog on Meson8 and Meson8m2
* add support for MediaTek MT7623 and MT7622 SoC
* Add support for the r8a77995 wdt
* explicitly request exclusive reset control for asm9260_wdt, zx2967_wdt, rt2880_wdt and mt7621_wdt
* improvements on asm9260_wdt, aspeed_wdt, renesas_wdt and cadence_wdt
* Add support for reading freq via CCF + suspend/resume support for of_xilinx_wdt
* constify watchdog_ops and various device-id structures
* Revert of commit 1fccb73011ea8a5fa0c6d357c33fa29c695139ea = "iTCO_wdt: all versions count down twice" (Bug 196509)

This will update the following files:

 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt  |   40 +++
 Documentation/devicetree/bindings/watchdog/meson-wdt.txt   |    6 
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt     |    2 
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt |    1 
 Documentation/watchdog/watchdog-parameters.txt             |    2 
 drivers/watchdog/asm9260_wdt.c                             |    4 
 drivers/watchdog/aspeed_wdt.c                              |  132 ++++++++++++-
 drivers/watchdog/bcm7038_wdt.c                             |    4 
 drivers/watchdog/cadence_wdt.c                             |    6 
 drivers/watchdog/coh901327_wdt.c                           |    2 
 drivers/watchdog/da9063_wdt.c                              |   67 ++----
 drivers/watchdog/diag288_wdt.c                             |    2 
 drivers/watchdog/iTCO_wdt.c                                |   22 +-
 drivers/watchdog/it87_wdt.c                                |    2 
 drivers/watchdog/max77620_wdt.c                            |    2 
 drivers/watchdog/mei_wdt.c                                 |    2 
 drivers/watchdog/meson_wdt.c                               |    2 
 drivers/watchdog/mt7621_wdt.c                              |    4 
 drivers/watchdog/of_xilinx_wdt.c                           |   83 ++++++--
 drivers/watchdog/pcwd_usb.c                                |    2 
 drivers/watchdog/qcom-wdt.c                                |    2 
 drivers/watchdog/renesas_wdt.c                             |   80 ++++---
 drivers/watchdog/rt2880_wdt.c                              |    4 
 drivers/watchdog/sc1200wdt.c                               |    2 
 drivers/watchdog/sp805_wdt.c                               |    2 
 drivers/watchdog/stm32_iwdg.c                              |    2 
 drivers/watchdog/ts72xx_wdt.c                              |    2 
 drivers/watchdog/w83627hf_wdt.c                            |    2 
 drivers/watchdog/ziirave_wdt.c                             |    2 
 drivers/watchdog/zx2967_wdt.c                              |    2 
 30 files changed, 363 insertions(+), 124 deletions(-)

with these Changes:

commit 4cb30b044a8f06e6e6418ae12c3c00bb02679dac
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Sat Aug 26 11:41:06 2017 +0530

    watchdog: mei_wdt: constify mei_cl_device_id
    
    mei_cl_device_id are not supposed to change at runtime. All functions
    working with mei_cl_device_id provided by <linux/mei_cl_bus.h> work
    with const mei_cl_device_id. So mark the non-const structs as const.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 05ce42fff3afb2904647f6a88c6dc613b5a2793a
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Wed Aug 23 22:04:08 2017 +0530

    watchdog: sp805: constify amba_id
    
    amba_id are not supposed to change at runtime. All functions
    working with const amba_id. So mark the non-const structs as const.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 68c82befe4023afd75006676c4bd708dbe98d668
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Mon Aug 21 22:18:38 2017 +0530

    watchdog: ziirave: constify i2c_device_id
    
    i2c_device_id are not supposed to change at runtime. All functions
    working with i2c_device_id provided by <linux/i2c.h> work with
    const i2c_device_id. So mark the non-const structs as const.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 39ad808996dd84f2961e241cb1396b391c6cd039
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Wed Aug 16 10:27:03 2017 +0530

    watchdog: sc1200: constify pnp_device_id
    
    pnp_device_id are not supposed to change at runtime. All functions
    working with pnp_device_id provided by <linux/pnp.h> work with
    const pnp_device_id. So mark the non-const structs as const.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 82f6817fd6409e2253372e7c7b8c1e573390b579
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Thu Aug 17 13:14:25 2017 +0200

    dt-bindings: watchdog: renesas-wdt: Add support for the r8a77995 wdt
    
    Document support for the Watchdog Timer (WDT) Controller in the Renesas
    R-Car D3 (r8a77995) SoC.
    
    No driver update is needed.
    
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Acked-by: Simon Horman <horms+renesas@verge.net.au>
    Acked-by: Rob Herring <robh@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1f185596e7981ea1e606ae8c47b141be729e95ae
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Jul 26 23:54:39 2017 +0200

    watchdog: renesas_wdt: update copyright dates
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9c22b6d33605d4b24e2491fdb743a285e8588738
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Jul 26 23:54:38 2017 +0200

    watchdog: renesas_wdt: make 'clk' a variable local to probe()
    
    It is not needed outside probe() anymore.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3be42941dd9df9b7c5062fc98c416a15bf4bbc0f
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Jul 26 23:54:37 2017 +0200

    watchdog: renesas_wdt: consistently use RuntimePM for clock management
    
    On Renesas R-Car archs, RuntimePM does all the clock handling. So, use
    it consistently to enable/disable the clocks. Also make sure that clocks
    are really enabled around clk_get_rate(). clk_summary looks proper now:
    
    		clock	enable_cnt	prepare_cnt	rate ...
    Before this commit:
    
    At boot:	rwdt	1		1		32768 0 0
    WDT running:	rwdt	2		2		32768 0 0
    
    After this commit:
    
    At boot:	rwdt	0		1		32768 0 0
    WDT running	rwdt	1		1		32768 0 0
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 012c04601f9dc6a268ebff87a890b339af6d25bf
Author: Andrew Jeffery <andrew@aj.id.au>
Date:   Wed Aug 2 14:15:29 2017 +0930

    watchdog: aspeed: Support configuration of external signal properties
    
    Add support for configuring the drive strength and polarity on the
    AST2500, and the pulse duration on both the AST2400 and AST2500.
    
    Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
    Tested-by: Matt Spinler <mspinler@linux.vnet.ibm.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e654f19165483adfc30eeabe69a1efc23182bf0e
Author: Andrew Jeffery <andrew@aj.id.au>
Date:   Wed Aug 2 14:15:28 2017 +0930

    dt-bindings: watchdog: aspeed: External reset signal properties
    
    For the AST2500 and compatible watchdog controllers the external reset
    signal can be configured for push-pull or open-drain drive types, and in
    the case of push-pull driving, active low or high.
    
    Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
    Acked-by: Rob Herring <robh@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ffbb29d62d6bcca3eff88111b58e4865506e95bf
Author: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date:   Mon Jul 17 14:25:38 2017 -0500

    drivers/watchdog: Add optional ASPEED device tree properties
    
    Describe device tree optional properties:
    
      * aspeed,reset-type = "cpu|soc|system|none"
         One of three different, mutually exclusive, values
    
    	"cpu" : ARM CPU reset on signal
    	"soc" : 'System on chip' reset
    	"system" : Full system reset
    
         The value can also be set to "none" which indicates that no
         reset of any kind is to be done via this watchdog.  This assumes
         another watchdog on the chip is to take care of resets.
    
      * aspeed,external-signal - Generate external signal (WDT1 and WDT2 only)
      * aspeed,alt-boot - Boot from alternate block on signal
    
    Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b7f0b8ad25f3f19f7830b3ce5b8fa6f7fe7ae5d5
Author: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date:   Mon Jul 17 14:25:39 2017 -0500

    drivers/watchdog: ASPEED reference dev tree properties for config
    
    Reference the system device tree when configuring the watchdog
    engines. If property 'aspeed,reset_type' is present then set
    reset behavior based on the specified value.  This can be one of
    three different mutually exclusive values
      * cpu - Reset CPU only on watchdog timeout
      * soc - Reset System on Chip
      * system - Full system reset
    
    No reset can also be specified by indicating:
      * none - No reset, assumes another watchdog is responsible for
               this.
    
    Add optional property 'aspeed,external-signal'. If present then
    configure to generate external signal on watchdog timeout.
    
    Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a1f2a82072ea298ae91505c213f6d299ddb5e446
Author: fzuuzf@googlemail.com <fzuuzf@googlemail.com>
Date:   Tue Jul 25 13:25:58 2017 +0200

    watchdog: da9063_wdt: Simplify by removing unneeded struct...
    
    ...da9063_watchdog, which contained nothing but struct watchdog_device and a
    struct da9063 pointer.
    Assign the struct da9063 pointer directly to the struct watchdog_device's
    driver_data field instead of creating struct da9063_watchdog and assigning
    it's address there.
    Spares a pointer's size data memory and an indirection level in the callbacks.
    
    Signed-off-by: Karsten Wiese <fzuuzf@googlemail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit dd0a18ca4cbdce00bc2b2e0510793205af27c7c5
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Sat Jul 22 17:22:59 2017 -0300

    watchdog: bcm7038: Check the return value from clk_prepare_enable()
    
    clk_prepare_enable() may fail, so we should better check its return value
    and propagate it in the case of error.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 15210ad18fcbd7f53f40e26e4391710d271c2daf
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Sat Jul 22 13:04:33 2017 -0300

    watchdog: qcom: Check for platform_get_resource() failure
    
    platform_get_resource() may fail, so we should better check its
    return value and propagate an error in case it fails.
    
    This avoids a NULL pointer dereference a bit later in the code.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 6f671c6b6288fd673e8b8b8acf1070100ba8188a
Author: Michal Simek <michal.simek@xilinx.com>
Date:   Mon Aug 7 13:24:23 2017 +0200

    watchdog: of_xilinx_wdt: Add suspend/resume support
    
    Add suspend/resume support to driver.
    
    Signed-off-by: Michal Simek <michal.simek@xilinx.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b6bc41645547f4e1a1bd882db7fa2b8596197d88
Author: Maulik Jodhani <maulik.jodhani@xilinx.com>
Date:   Mon Aug 7 13:24:22 2017 +0200

    watchdog: of_xilinx_wdt: Add support for reading freq via CCF
    
    Improve CLK handling in the code to read freq via CCF.
    Also disable CLK asap and add clk handling code to start and stop.
    
    Signed-off-by: Maulik Jodhani <maulik.jodhani@xilinx.com>
    Signed-off-by: Michal Simek <michal.simek@xilinx.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e8a7fc711c9aa801cf0e733109e40548b16875a3
Author: Sean Wang <sean.wang@mediatek.com>
Date:   Tue Aug 15 00:41:38 2017 +0800

    dt-bindings: watchdog: mediatek: add support for MediaTek MT7623 and MT7622 SoC
    
    This updates dt-binding documentation for MediaTek MT7622 and
    MT7623 SoC. For the both SoCs supported all rely on the fallback
    binding of the case with "mediatek,mt6589-wdt".
    
    Signed-off-by: Sean Wang <sean.wang@mediatek.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e8c7ebfdb4308d26efda8214da8bfbbd9cc31414
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Sun Aug 13 16:58:28 2017 +0530

    watchdog: max77620_wdt: constify platform_device_id
    
    platform_device_id are not supposed to change at runtime. All functions
    working with platform_device_id provided by <linux/platform_device.h>
    work with const platform_device_id. So mark the non-const structs as
    const.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit cc53e1c2bba50563da8fae057e75a6377b9db696
Author: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Sat Aug 12 14:09:45 2017 +0530

    watchdog: pcwd_usb: constify usb_device_id
    
    usb_device_id are not supposed to change at runtime. All functions
    working with usb_device_id provided by <linux/usb.h> work with
    const usb_device_id. So mark the non-const structs as const.
    
    Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f3a7f6f67fc7ec5bb47a6ad6b947d66759e6d9e4
Author: Michal Simek <michal.simek@xilinx.com>
Date:   Fri Aug 4 09:39:17 2017 +0200

    watchdog: cadence_wdt: Show information when driver is probed
    
    Showing message that driver is loaded is common across drivers.
    This change also fixes checkpatch (--strict) warning
    "Alignment should match open parenthesis".
    
    Signed-off-by: Michal Simek <michal.simek@xilinx.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit db202f4d5c24c0ed44501c1d382e4e971c6d67c7
Author: Michal Simek <michal.simek@xilinx.com>
Date:   Fri Aug 4 09:39:16 2017 +0200

    watchdog: cadence_wdt: Enable access to module parameters
    
    Give read access to module parameters to all and write access to root.
    This change also improves driver error path testing.
    
    Signed-off-by: Michal Simek <michal.simek@xilinx.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 323edb2e27e8e02b0ce25e7caa8288a90a438b99
Author: Julia Lawall <Julia.Lawall@lip6.fr>
Date:   Thu Aug 3 23:21:31 2017 +0200

    watchdog: constify watchdog_ops and watchdog_info structures
    
    These watchdog_ops and watchdog_info structures are only stored
    in the ops and info fields of a watchdog_device structure,
    respectively, which are const.  Thus make the watchdog_ops and
    watchdog_info structures const as well.
    
    Done with the help of Coccinelle.  The rules for the watchdog_ops case are
    as follows:
    
    // <smpl>
    @r disable optional_qualifier@
    identifier i;
    position p;
    @@
    static struct watchdog_ops i@p = { ... };
    
    @ok@
    identifier r.i;
    struct watchdog_device e;
    position p;
    @@
    e.ops = &i@p;
    
    @bad@
    position p != {r.p,ok.p};
    identifier r.i;
    struct watchdog_ops e;
    @@
    e@i@p
    
    @depends on !bad disable optional_qualifier@
    identifier r.i;
    @@
    static
    +const
     struct watchdog_ops i = { ... };
    // </smpl>
    
    Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
    Acked-by: Linus Walleij <linus.walleij@linaro.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d94fa4655ed79784388cb49c17c5e9967ddfb4b9
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Mon Jul 17 19:12:24 2017 +0200

    watchdog: asm9260_wdt: don't round closest with get_timeleft
    
    We should never return more time left than there actually is. So, switch
    to a plain divider instead of DIV_ROUND_CLOSEST.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 03a196f25f5652a3deffc1b8eade8a3c1c39282c
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Jul 19 10:27:55 2017 +0200

    watchdog: renesas_wdt: add another divider option
    
    If we set RWTCSRB to 0, we can gain 4096 as another divider value. This
    is supported by all R-Car Gen2 and Gen3 devices which we aim to support.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 82f64cd20848511f516bd28147a6432497dfb080
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Jul 19 10:27:54 2017 +0200

    watchdog: renesas_wdt: apply better precision
    
    The error margin of the clks_per_second variable was too large and
    caused offsets when used with clock frequencies which left a remainder
    after applying the dividers. Now we always calculate directly using the
    clock rate and the divider using some helper macros. That also means
    that DIV_ROUND_UP moves from probe to the multiplication macro. In
    probe, we don't need to ensure anymore that 'clks_per_sec' would go too
    fast but rather ensure that the lower limit is really at least 1 to
    certainly get a full cycle.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1c1b2434017206b612764fad1820b6dd48cb9e92
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Jul 19 10:27:53 2017 +0200

    watchdog: renesas_wdt: don't round closest with get_timeleft
    
    We should never return more time left than there actually is. So, switch
    to a plain divider instead of DIV_ROUND_CLOSEST.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b51247c8029660a9c49ad48bf38f364479c96215
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Jul 19 10:27:52 2017 +0200

    watchdog: renesas_wdt: check rate also for upper limit
    
    When checking the clock rate, ensure also that counting all 16 bits
    takes at least one second to match the granularity of the framework.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f6159dd4b085ad839ab02c1ba230535c53ef60d4
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Jul 19 10:27:51 2017 +0200

    watchdog: renesas_wdt: avoid (theoretical) type overflow
    
    Because the smallest clock divider we can select is 1, 'clks_per_sec'
    must be the same type as 'rate'.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0bade0215ca4337caa00cd72e88bd71a45396b00
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Wed Jul 19 17:26:38 2017 +0200

    watchdog: mt7621: explicitly request exclusive reset control
    
    Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
    reset lines") started to transition the reset control request API calls
    to explicitly state whether the driver needs exclusive or shared reset
    control behavior. Convert all drivers requesting exclusive resets to the
    explicit API call so the temporary transition helpers can be removed.
    
    No functional changes.
    
    Cc: linux-watchdog@vger.kernel.org
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a248e5e9a7c511ff95c53cc2085920c8f29206aa
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Wed Jul 19 17:26:39 2017 +0200

    watchdog: rt2880: explicitly request exclusive reset control
    
    Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
    reset lines") started to transition the reset control request API calls
    to explicitly state whether the driver needs exclusive or shared reset
    control behavior. Convert all drivers requesting exclusive resets to the
    explicit API call so the temporary transition helpers can be removed.
    
    No functional changes.
    
    Cc: linux-watchdog@vger.kernel.org
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 39055bbb446d6858017a1f454327c2b0d432261b
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Wed Jul 19 17:26:40 2017 +0200

    watchdog: zx2967: explicitly request exclusive reset control
    
    Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
    reset lines") started to transition the reset control request API calls
    to explicitly state whether the driver needs exclusive or shared reset
    control behavior. Convert all drivers requesting exclusive resets to the
    explicit API call so the temporary transition helpers can be removed.
    
    No functional changes.
    
    Cc: linux-watchdog@vger.kernel.org
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit fcc6da076a38f53d6df374fe5c9f1325eea25a00
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Wed Jul 19 17:26:37 2017 +0200

    watchdog: asm9260: explicitly request exclusive reset control
    
    Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
    reset lines") started to transition the reset control request API calls
    to explicitly state whether the driver needs exclusive or shared reset
    control behavior. Convert all drivers requesting exclusive resets to the
    explicit API call so the temporary transition helpers can be removed.
    
    No functional changes.
    
    Cc: linux-watchdog@vger.kernel.org
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 43a64e81b2ac449938ba52a202e3edd23f57ec49
Author: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed Jul 12 00:14:38 2017 +0200

    watchdog: meson-wdt: add support for the watchdog on Meson8 and Meson8m2
    
    The watchdog IP block on Meson8 and Meson8m2 is already supported by the
    existing meson-wdt driver. Meson8 uses the same register bits as Meson6,
    while the newer Meson8m2 SoC uses the same register bits as Meson8b.
    
    Currently watchdog support on Meson8 SoC already works because
    meson8.dtsi simply uses the "amlogic,meson6-wdt" compatible. Adding a
    separate compatible for Meson8 makes this more explicit though.
    
    Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 08b10b57d69bb37d6e70a8db71844527a9f1f41c
Author: Colin Ian King <colin.king@canonical.com>
Date:   Tue Jul 11 16:23:34 2017 +0100

    watchdog: w83627hf: make const array chip_name static
    
    Don't populate array chip_name on the stack but instead make it static.
    Makes the object code smaller by 40 bytes:
    
    Before:
       text	   data	    bss	    dec	    hex	filename
       5641	   2840	    384	   8865	   22a1	drivers/watchdog/w83627hf_wdt.o
    
    After:
       text	   data	    bss	    dec	    hex	filename
       5545	   2896	    384	   8825	   2279	drivers/watchdog/w83627hf_wdt.o
    
    Signed-off-by: Colin Ian King <colin.king@canonical.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9215fc79521a05debba3ba67668caeb65d204cc7
Author: Gustavo A. R. Silva <garsilva@embeddedor.com>
Date:   Fri Jul 7 19:33:30 2017 -0500

    watchdog: coh901327_wdt: constify watchdog_ops structure
    
    Check for watchdog_ops structures that are only stored in the ops field of
    a watchdog_device structure. This field is declared const, so watchdog_ops
    structures that have this property can be declared as const also.
    
    This issue was detected using Coccinelle and the following semantic patch:
    
    @r
    disable optional_qualifier@
    identifier i;
    position p;
    @@
    static struct watchdog_ops i@p = { ... };
    
    @ok@
    identifier r.i;
    struct watchdog_device e;
    position p;
    @@
    e.ops = &i@p;
    
    @bad@
    position p != {r.p,ok.p};
    identifier r.i;
    struct watchdog_ops e;
    @@
    e@i@p
    
    @depends on !bad disable optional_qualifier@
    identifier r.i;
    @@
    static
    +const
     struct watchdog_ops i = { ... };
    
    Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d7b16e75d40e579a58e31f751ac5bb44d2dfbeed
Author: Gustavo A. R. Silva <garsilva@embeddedor.com>
Date:   Fri Jul 7 19:28:57 2017 -0500

    watchdog: stm32_iwdg: constify watchdog_ops structure
    
    Check for watchdog_ops structures that are only stored in the ops field of
    a watchdog_device structure. This field is declared const, so watchdog_ops
    structures that have this property can be declared as const also.
    
    This issue was detected using Coccinelle and the following semantic patch:
    
    @r
    disable optional_qualifier@
    identifier i;
    position p;
    @@
    static struct watchdog_ops i@p = { ... };
    
    @ok@
    identifier r.i;
    struct watchdog_device e;
    position p;
    @@
    e.ops = &i@p;
    
    @bad@
    position p != {r.p,ok.p};
    identifier r.i;
    struct watchdog_ops e;
    @@
    e@i@p
    
    @depends on !bad disable optional_qualifier@
    identifier r.i;
    @@
    static
    +const
     struct watchdog_ops i = { ... };
    
    Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2211a8dce791f49a783959e8e81503e6ad67c70a
Author: Gustavo A. R. Silva <garsilva@embeddedor.com>
Date:   Fri Jul 7 19:23:21 2017 -0500

    watchdog: it87_wdt: constify watchdog_ops structure
    
    Check for watchdog_ops structures that are only stored in the ops field of
    a watchdog_device structure. This field is declared const, so watchdog_ops
    structures that have this property can be declared as const also.
    
    This issue was detected using Coccinelle and the following semantic patch:
    
    @r
    disable optional_qualifier@
    identifier i;
    position p;
    @@
    static struct watchdog_ops i@p = { ... };
    
    @ok@
    identifier r.i;
    struct watchdog_device e;
    position p;
    @@
    e.ops = &i@p;
    
    @bad@
    position p != {r.p,ok.p};
    identifier r.i;
    struct watchdog_ops e;
    @@
    e@i@p
    
    @depends on !bad disable optional_qualifier@
    identifier r.i;
    @@
    static
    +const
     struct watchdog_ops i = { ... };
    
    Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5870ac753bce54ad0550851c65ebba1d7da890ef
Author: Gustavo A. R. Silva <garsilva@embeddedor.com>
Date:   Fri Jul 7 19:18:40 2017 -0500

    watchdog: ts72xx_wdt: constify watchdog_ops structure
    
    Check for watchdog_ops structures that are only stored in the ops field of
    a watchdog_device structure. This field is declared const, so watchdog_ops
    structures that have this property can be declared as const also.
    
    This issue was detected using Coccinelle and the following semantic patch:
    
    @r
    disable optional_qualifier@
    identifier i;
    position p;
    @@
    static struct watchdog_ops i@p = { ... };
    
    @ok@
    identifier r.i;
    struct watchdog_device e;
    position p;
    @@
    e.ops = &i@p;
    
    @bad@
    position p != {r.p,ok.p};
    identifier r.i;
    struct watchdog_ops e;
    @@
    e@i@p
    
    @depends on !bad disable optional_qualifier@
    identifier r.i;
    @@
    static
    +const
     struct watchdog_ops i = { ... };
    
    Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit fc61e83a29308601e6e8a0759e24fc8fe2122692
Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Sep 9 17:41:24 2017 +0200

    watchdog: Revert "iTCO_wdt: all versions count down twice"
    
    This reverts commit 1fccb73011ea8a5fa0c6d357c33fa29c695139ea.
    Reported as Bug 196509 - iTCO_wdt regression reboot before timeout expire
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
index c5e74d7..c5077a1 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -8,9 +8,49 @@ Required properties:
  - reg: physical base address of the controller and length of memory mapped
    region
 
+Optional properties:
+
+ - aspeed,reset-type = "cpu|soc|system|none"
+
+   Reset behavior - Whenever a timeout occurs the watchdog can be programmed
+   to generate one of three different, mutually exclusive, types of resets.
+
+   Type "none" can be specified to indicate that no resets are to be done.
+   This is useful in situations where another watchdog engine on chip is
+   to perform the reset.
+
+   If 'aspeed,reset-type=' is not specfied the default is to enable system
+   reset.
+
+   Reset types:
+
+        - cpu: Reset CPU on watchdog timeout
+
+        - soc: Reset 'System on Chip' on watchdog timeout
+
+        - system: Reset system on watchdog timeout
+
+        - none: No reset is performed on timeout. Assumes another watchdog
+                engine is responsible for this.
+
+ - aspeed,alt-boot:    If property is present then boot from alternate block.
+ - aspeed,external-signal: If property is present then signal is sent to
+			external reset counter (only WDT1 and WDT2). If not
+			specified no external signal is sent.
+ - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
+
+Optional properties for AST2500-compatible watchdogs:
+ - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
+			 drive type to push-pull. The default is open-drain.
+ - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
+			   is configured as push-pull, then set the pulse
+			   polarity to active-high. The default is active-low.
+
 Example:
 
 	wdt1: watchdog@1e785000 {
 		compatible = "aspeed,ast2400-wdt";
 		reg = <0x1e785000 0x1c>;
+		aspeed,reset-type = "system";
+		aspeed,external-signal;
 	};
diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
index ae70185..8a6d84c 100644
--- a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
@@ -2,7 +2,11 @@ Meson SoCs Watchdog timer
 
 Required properties:
 
-- compatible : should be "amlogic,meson6-wdt" or "amlogic,meson8b-wdt"
+- compatible : depending on the SoC this should be one of:
+	"amlogic,meson6-wdt" on Meson6 SoCs
+	"amlogic,meson8-wdt" and "amlogic,meson6-wdt" on Meson8 SoCs
+	"amlogic,meson8b-wdt" on Meson8b SoCs
+	"amlogic,meson8m2-wdt" and "amlogic,meson8b-wdt" on Meson8m2 SoCs
 - reg : Specifies base physical address and size of the registers.
 
 Example:
diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 6a00939..096bbfb 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -4,6 +4,8 @@ Required properties:
 
 - compatible should contain:
 	* "mediatek,mt2701-wdt" for MT2701 compatible watchdog timers
+	* "mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
+	* "mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
 	* "mediatek,mt6589-wdt" for all compatible watchdog timers (MT2701,
 		MT6589)
 
diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 9e306af..bf6d1ca 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	       Examples with soctypes are:
 	         - "renesas,r8a7795-wdt" (R-Car H3)
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
+	         - "renesas,r8a77995-wdt" (R-Car D3)
 	         - "renesas,r7s72100-wdt" (RZ/A1)
 
   When compatible with the generic version, nodes must list the SoC-specific
diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index b352636..6f9d7b4 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -117,7 +117,7 @@ nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
 iTCO_wdt:
 heartbeat: Watchdog heartbeat in seconds.
-	(5<=heartbeat<=74 (TCO v1) or 1226 (TCO v2), default=30)
+	(2<heartbeat<39 (TCO v1) or 613 (TCO v2), default=30)
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 53da001..7dd0da6 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -82,7 +82,7 @@ static unsigned int asm9260_wdt_gettimeleft(struct watchdog_device *wdd)
 
 	counter = ioread32(priv->iobase + HW_WDTV);
 
-	return DIV_ROUND_CLOSEST(counter, priv->wdt_freq);
+	return counter / priv->wdt_freq;
 }
 
 static int asm9260_wdt_updatetimeout(struct watchdog_device *wdd)
@@ -296,7 +296,7 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->rst = devm_reset_control_get(&pdev->dev, "wdt_rst");
+	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, "wdt_rst");
 	if (IS_ERR(priv->rst))
 		return PTR_ERR(priv->rst);
 
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 1c65258..79cc766 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -23,9 +23,21 @@ struct aspeed_wdt {
 	u32			ctrl;
 };
 
+struct aspeed_wdt_config {
+	u32 ext_pulse_width_mask;
+};
+
+static const struct aspeed_wdt_config ast2400_config = {
+	.ext_pulse_width_mask = 0xff,
+};
+
+static const struct aspeed_wdt_config ast2500_config = {
+	.ext_pulse_width_mask = 0xfffff,
+};
+
 static const struct of_device_id aspeed_wdt_of_table[] = {
-	{ .compatible = "aspeed,ast2400-wdt" },
-	{ .compatible = "aspeed,ast2500-wdt" },
+	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
+	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
@@ -36,12 +48,45 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define WDT_CTRL		0x0C
 #define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
 #define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
+#define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
 #define   WDT_CTRL_1MHZ_CLK		BIT(4)
 #define   WDT_CTRL_WDT_EXT		BIT(3)
 #define   WDT_CTRL_WDT_INTR		BIT(2)
 #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
 #define   WDT_CTRL_ENABLE		BIT(0)
 
+/*
+ * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
+ * enabled), specifically:
+ *
+ * * Pulse duration
+ * * Drive mode: push-pull vs open-drain
+ * * Polarity: Active high or active low
+ *
+ * Pulse duration configuration is available on both the AST2400 and AST2500,
+ * though the field changes between SoCs:
+ *
+ * AST2400: Bits 7:0
+ * AST2500: Bits 19:0
+ *
+ * This difference is captured in struct aspeed_wdt_config.
+ *
+ * The AST2500 exposes the drive mode and polarity options, but not in a
+ * regular fashion. For read purposes, bit 31 represents active high or low,
+ * and bit 30 represents push-pull or open-drain. With respect to write, magic
+ * values need to be written to the top byte to change the state of the drive
+ * mode and polarity bits. Any other value written to the top byte has no
+ * effect on the state of the drive mode or polarity bits. However, the pulse
+ * width value must be preserved (as desired) if written.
+ */
+#define WDT_RESET_WIDTH		0x18
+#define   WDT_RESET_WIDTH_ACTIVE_HIGH	BIT(31)
+#define     WDT_ACTIVE_HIGH_MAGIC	(0xA5 << 24)
+#define     WDT_ACTIVE_LOW_MAGIC	(0x5A << 24)
+#define   WDT_RESET_WIDTH_PUSH_PULL	BIT(30)
+#define     WDT_PUSH_PULL_MAGIC		(0xA8 << 24)
+#define     WDT_OPEN_DRAIN_MAGIC	(0x8A << 24)
+
 #define WDT_RESTART_MAGIC	0x4755
 
 /* 32 bits at 1MHz, in milliseconds */
@@ -138,8 +183,13 @@ static const struct watchdog_info aspeed_wdt_info = {
 
 static int aspeed_wdt_probe(struct platform_device *pdev)
 {
+	const struct aspeed_wdt_config *config;
+	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
 	struct resource *res;
+	struct device_node *np;
+	const char *reset_type;
+	u32 duration;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -164,20 +214,88 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
 	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
 
+	np = pdev->dev.of_node;
+
+	ofdid = of_match_node(aspeed_wdt_of_table, np);
+	if (!ofdid)
+		return -EINVAL;
+	config = ofdid->data;
+
+	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
+
 	/*
 	 * Control reset on a per-device basis to ensure the
-	 * host is not affected by a BMC reboot, so only reset
-	 * the SOC and not the full chip
+	 * host is not affected by a BMC reboot
 	 */
-	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
-		WDT_CTRL_1MHZ_CLK |
-		WDT_CTRL_RESET_SYSTEM;
+	ret = of_property_read_string(np, "aspeed,reset-type", &reset_type);
+	if (ret) {
+		wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC | WDT_CTRL_RESET_SYSTEM;
+	} else {
+		if (!strcmp(reset_type, "cpu"))
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU;
+		else if (!strcmp(reset_type, "soc"))
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC;
+		else if (!strcmp(reset_type, "system"))
+			wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
+		else if (strcmp(reset_type, "none"))
+			return -EINVAL;
+	}
+	if (of_property_read_bool(np, "aspeed,external-signal"))
+		wdt->ctrl |= WDT_CTRL_WDT_EXT;
+
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
 
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
 		aspeed_wdt_start(&wdt->wdd);
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	}
 
+	if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
+		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
+
+		reg &= config->ext_pulse_width_mask;
+		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
+			reg |= WDT_PUSH_PULL_MAGIC;
+		else
+			reg |= WDT_OPEN_DRAIN_MAGIC;
+
+		writel(reg, wdt->base + WDT_RESET_WIDTH);
+
+		reg &= config->ext_pulse_width_mask;
+		if (of_property_read_bool(np, "aspeed,ext-active-high"))
+			reg |= WDT_ACTIVE_HIGH_MAGIC;
+		else
+			reg |= WDT_ACTIVE_LOW_MAGIC;
+
+		writel(reg, wdt->base + WDT_RESET_WIDTH);
+	}
+
+	if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
+		u32 max_duration = config->ext_pulse_width_mask + 1;
+
+		if (duration == 0 || duration > max_duration) {
+			dev_err(&pdev->dev, "Invalid pulse duration: %uus\n",
+					duration);
+			duration = max(1U, min(max_duration, duration));
+			dev_info(&pdev->dev, "Pulse duration set to %uus\n",
+					duration);
+		}
+
+		/*
+		 * The watchdog is always configured with a 1MHz source, so
+		 * there is no need to scale the microsecond value. However we
+		 * need to offset it - from the datasheet:
+		 *
+		 * "This register decides the asserting duration of wdt_ext and
+		 * wdt_rstarm signal. The default value is 0xFF. It means the
+		 * default asserting duration of wdt_ext and wdt_rstarm is
+		 * 256us."
+		 *
+		 * This implies a value of 0 gives a 1us pulse.
+		 */
+		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
+	}
+
 	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register\n");
diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index c1b8e53..f88f546 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -136,7 +136,9 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 	wdt->clk = devm_clk_get(dev, NULL);
 	/* If unable to get clock, use default frequency */
 	if (!IS_ERR(wdt->clk)) {
-		clk_prepare_enable(wdt->clk);
+		err = clk_prepare_enable(wdt->clk);
+		if (err)
+			return err;
 		wdt->rate = clk_get_rate(wdt->clk);
 		/* Prevent divide-by-zero exception */
 		if (!wdt->rate)
diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 05c0000..064cf7b 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -52,12 +52,12 @@
 static int wdt_timeout;
 static int nowayout = WATCHDOG_NOWAYOUT;
 
-module_param(wdt_timeout, int, 0);
+module_param(wdt_timeout, int, 0644);
 MODULE_PARM_DESC(wdt_timeout,
 		 "Watchdog time in seconds. (default="
 		 __MODULE_STRING(CDNS_WDT_DEFAULT_TIMEOUT) ")");
 
-module_param(nowayout, int, 0);
+module_param(nowayout, int, 0644);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
@@ -368,7 +368,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, wdt);
 
-	dev_dbg(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
+	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
 		 wdt->regs, cdns_wdt_device->timeout,
 		 nowayout ? ", nowayout" : "");
 
diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 38dd60f..4410337 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -218,7 +218,7 @@ static const struct watchdog_info coh901327_ident = {
 	.identity = DRV_NAME,
 };
 
-static struct watchdog_ops coh901327_ops = {
+static const struct watchdog_ops coh901327_ops = {
 	.owner = THIS_MODULE,
 	.start = coh901327_start,
 	.stop = coh901327_stop,
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 4691c55..2a20fc1 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -36,11 +36,6 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 #define DA9063_WDG_TIMEOUT		wdt_timeout[3]
 #define DA9063_RESET_PROTECTION_MS	256
 
-struct da9063_watchdog {
-	struct da9063 *da9063;
-	struct watchdog_device wdtdev;
-};
-
 static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 {
 	unsigned int i;
@@ -61,14 +56,14 @@ static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
 
 static int da9063_wdt_start(struct watchdog_device *wdd)
 {
-	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	unsigned int selector;
 	int ret;
 
-	selector = da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
-	ret = _da9063_wdt_set_timeout(wdt->da9063, selector);
+	selector = da9063_wdt_timeout_to_sel(wdd->timeout);
+	ret = _da9063_wdt_set_timeout(da9063, selector);
 	if (ret)
-		dev_err(wdt->da9063->dev, "Watchdog failed to start (err = %d)\n",
+		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
 
 	return ret;
@@ -76,13 +71,13 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 
 static int da9063_wdt_stop(struct watchdog_device *wdd)
 {
-	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	int ret;
 
-	ret = regmap_update_bits(wdt->da9063->regmap, DA9063_REG_CONTROL_D,
+	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
 				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
 	if (ret)
-		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err = %d)\n",
+		dev_alert(da9063->dev, "Watchdog failed to stop (err = %d)\n",
 			  ret);
 
 	return ret;
@@ -90,13 +85,13 @@ static int da9063_wdt_stop(struct watchdog_device *wdd)
 
 static int da9063_wdt_ping(struct watchdog_device *wdd)
 {
-	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	int ret;
 
-	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
+	ret = regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
 			   DA9063_WATCHDOG);
 	if (ret)
-		dev_alert(wdt->da9063->dev, "Failed to ping the watchdog (err = %d)\n",
+		dev_alert(da9063->dev, "Failed to ping the watchdog (err = %d)\n",
 			  ret);
 
 	return ret;
@@ -105,14 +100,14 @@ static int da9063_wdt_ping(struct watchdog_device *wdd)
 static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout)
 {
-	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	unsigned int selector;
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(timeout);
-	ret = _da9063_wdt_set_timeout(wdt->da9063, selector);
+	ret = _da9063_wdt_set_timeout(da9063, selector);
 	if (ret)
-		dev_err(wdt->da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
+		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
 	else
 		wdd->timeout = wdt_timeout[selector];
@@ -123,13 +118,13 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 static int da9063_wdt_restart(struct watchdog_device *wdd, unsigned long action,
 			      void *data)
 {
-	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	int ret;
 
-	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
+	ret = regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
 			   DA9063_SHUTDOWN);
 	if (ret)
-		dev_alert(wdt->da9063->dev, "Failed to shutdown (err = %d)\n",
+		dev_alert(da9063->dev, "Failed to shutdown (err = %d)\n",
 			  ret);
 
 	return ret;
@@ -152,7 +147,7 @@ static const struct watchdog_ops da9063_watchdog_ops = {
 static int da9063_wdt_probe(struct platform_device *pdev)
 {
 	struct da9063 *da9063;
-	struct da9063_watchdog *wdt;
+	struct watchdog_device *wdd;
 
 	if (!pdev->dev.parent)
 		return -EINVAL;
@@ -161,27 +156,25 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	if (!da9063)
 		return -EINVAL;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
-	if (!wdt)
+	wdd = devm_kzalloc(&pdev->dev, sizeof(*wdd), GFP_KERNEL);
+	if (!wdd)
 		return -ENOMEM;
 
-	wdt->da9063 = da9063;
-
-	wdt->wdtdev.info = &da9063_watchdog_info;
-	wdt->wdtdev.ops = &da9063_watchdog_ops;
-	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
-	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
-	wdt->wdtdev.min_hw_heartbeat_ms = DA9063_RESET_PROTECTION_MS;
-	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
-	wdt->wdtdev.parent = &pdev->dev;
+	wdd->info = &da9063_watchdog_info;
+	wdd->ops = &da9063_watchdog_ops;
+	wdd->min_timeout = DA9063_WDT_MIN_TIMEOUT;
+	wdd->max_timeout = DA9063_WDT_MAX_TIMEOUT;
+	wdd->min_hw_heartbeat_ms = DA9063_RESET_PROTECTION_MS;
+	wdd->timeout = DA9063_WDG_TIMEOUT;
+	wdd->parent = &pdev->dev;
 
-	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+	wdd->status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
-	watchdog_set_restart_priority(&wdt->wdtdev, 128);
+	watchdog_set_restart_priority(wdd, 128);
 
-	watchdog_set_drvdata(&wdt->wdtdev, wdt);
+	watchdog_set_drvdata(wdd, da9063);
 
-	return devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
+	return devm_watchdog_register_device(&pdev->dev, wdd);
 }
 
 static struct platform_driver da9063_wdt_driver = {
diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 6f59108..806a04a 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -213,7 +213,7 @@ static const struct watchdog_ops wdt_ops = {
 	.set_timeout = wdt_set_timeout,
 };
 
-static struct watchdog_info wdt_info = {
+static const struct watchdog_info wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 	.firmware_version = 0,
 	.identity = "z Watchdog",
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index c4f6587..347f038 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -306,15 +306,16 @@ static int iTCO_wdt_ping(struct watchdog_device *wd_dev)
 
 	iTCO_vendor_pre_keepalive(p->smi_res, wd_dev->timeout);
 
-	/* Reset the timeout status bit so that the timer
-	 * needs to count down twice again before rebooting */
-	outw(0x0008, TCO1_STS(p));	/* write 1 to clear bit */
-
 	/* Reload the timer by writing to the TCO Timer Counter register */
-	if (p->iTCO_version >= 2)
+	if (p->iTCO_version >= 2) {
 		outw(0x01, TCO_RLD(p));
-	else if (p->iTCO_version == 1)
+	} else if (p->iTCO_version == 1) {
+		/* Reset the timeout status bit so that the timer
+		 * needs to count down twice again before rebooting */
+		outw(0x0008, TCO1_STS(p));	/* write 1 to clear bit */
+
 		outb(0x01, TCO_RLD(p));
+	}
 
 	spin_unlock(&p->io_lock);
 	return 0;
@@ -327,8 +328,11 @@ static int iTCO_wdt_set_timeout(struct watchdog_device *wd_dev, unsigned int t)
 	unsigned char val8;
 	unsigned int tmrval;
 
-	/* The timer counts down twice before rebooting */
-	tmrval = seconds_to_ticks(p, t) / 2;
+	tmrval = seconds_to_ticks(p, t);
+
+	/* For TCO v1 the timer counts down twice before rebooting */
+	if (p->iTCO_version == 1)
+		tmrval /= 2;
 
 	/* from the specs: */
 	/* "Values of 0h-3h are ignored and should not be attempted" */
@@ -381,8 +385,6 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 		spin_lock(&p->io_lock);
 		val16 = inw(TCO_RLD(p));
 		val16 &= 0x3ff;
-		if (!(inw(TCO1_STS(p)) & 0x0008))
-			val16 += (inw(TCOv2_TMR(p)) & 0x3ff);
 		spin_unlock(&p->io_lock);
 
 		time_left = ticks_to_seconds(p, val16);
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index dd1e7ea..e96faea 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -253,7 +253,7 @@ static const struct watchdog_info ident = {
 	.identity = WATCHDOG_NAME,
 };
 
-static struct watchdog_ops wdt_ops = {
+static const struct watchdog_ops wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = wdt_start,
 	.stop = wdt_stop,
diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index 68c41fa..2c9f53e 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -201,7 +201,7 @@ static int max77620_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id max77620_wdt_devtype[] = {
+static const struct platform_device_id max77620_wdt_devtype[] = {
 	{ .name = "max77620-watchdog", },
 	{ },
 };
diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index b29c6fd..ea60b29 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -670,7 +670,7 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
 #define MEI_UUID_WD UUID_LE(0x05B79A6F, 0x4628, 0x4D7F, \
 			    0x89, 0x9D, 0xA9, 0x15, 0x14, 0xCB, 0x32, 0xAB)
 
-static struct mei_cl_device_id mei_wdt_tbl[] = {
+static const struct mei_cl_device_id mei_wdt_tbl[] = {
 	{ .uuid = MEI_UUID_WD, .version = MEI_CL_VERSION_ANY },
 	/* required last entry */
 	{ }
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 491b9bf..304274c 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -155,7 +155,9 @@ static const struct watchdog_ops meson_wdt_ops = {
 
 static const struct of_device_id meson_wdt_dt_ids[] = {
 	{ .compatible = "amlogic,meson6-wdt", .data = &meson6_wdt_data },
+	{ .compatible = "amlogic,meson8-wdt", .data = &meson6_wdt_data },
 	{ .compatible = "amlogic,meson8b-wdt", .data = &meson8b_wdt_data },
+	{ .compatible = "amlogic,meson8m2-wdt", .data = &meson8b_wdt_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 48a0606..db38f80 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -105,7 +105,7 @@ static int mt7621_wdt_bootcause(void)
 	return 0;
 }
 
-static struct watchdog_info mt7621_wdt_info = {
+static const struct watchdog_info mt7621_wdt_info = {
 	.identity = "Mediatek Watchdog",
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 };
@@ -135,7 +135,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(mt7621_wdt_base))
 		return PTR_ERR(mt7621_wdt_base);
 
-	mt7621_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
+	mt7621_wdt_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (!IS_ERR(mt7621_wdt_reset))
 		reset_control_deassert(mt7621_wdt_reset);
 
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index fae7fe9..1cf2869 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -51,9 +51,16 @@ struct xwdt_device {
 
 static int xilinx_wdt_start(struct watchdog_device *wdd)
 {
+	int ret;
 	u32 control_status_reg;
 	struct xwdt_device *xdev = watchdog_get_drvdata(wdd);
 
+	ret = clk_enable(xdev->clk);
+	if (ret) {
+		dev_err(wdd->parent, "Failed to enable clock\n");
+		return ret;
+	}
+
 	spin_lock(&xdev->spinlock);
 
 	/* Clean previous status and enable the watchdog timer */
@@ -85,6 +92,9 @@ static int xilinx_wdt_stop(struct watchdog_device *wdd)
 	iowrite32(0, xdev->base + XWT_TWCSR1_OFFSET);
 
 	spin_unlock(&xdev->spinlock);
+
+	clk_disable(xdev->clk);
+
 	pr_info("Stopped!\n");
 
 	return 0;
@@ -167,11 +177,6 @@ static int xwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(xdev->base))
 		return PTR_ERR(xdev->base);
 
-	rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &pfreq);
-	if (rc)
-		dev_warn(&pdev->dev,
-			 "The watchdog clock frequency cannot be obtained\n");
-
 	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
 				  &xdev->wdt_interval);
 	if (rc)
@@ -186,6 +191,26 @@ static int xwdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
 
+	xdev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(xdev->clk)) {
+		if (PTR_ERR(xdev->clk) != -ENOENT)
+			return PTR_ERR(xdev->clk);
+
+		/*
+		 * Clock framework support is optional, continue on
+		 * anyways if we don't find a matching clock.
+		 */
+		xdev->clk = NULL;
+
+		rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+					  &pfreq);
+		if (rc)
+			dev_warn(&pdev->dev,
+				 "The watchdog clock freq cannot be obtained\n");
+	} else {
+		pfreq = clk_get_rate(xdev->clk);
+	}
+
 	/*
 	 * Twice of the 2^wdt_interval / freq  because the first wdt overflow is
 	 * ignored (interrupt), reset is only generated at second wdt overflow
@@ -197,14 +222,6 @@ static int xwdt_probe(struct platform_device *pdev)
 	spin_lock_init(&xdev->spinlock);
 	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
 
-	xdev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(xdev->clk)) {
-		if (PTR_ERR(xdev->clk) == -ENOENT)
-			xdev->clk = NULL;
-		else
-			return PTR_ERR(xdev->clk);
-	}
-
 	rc = clk_prepare_enable(xdev->clk);
 	if (rc) {
 		dev_err(&pdev->dev, "unable to enable clock\n");
@@ -223,6 +240,8 @@ static int xwdt_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
+	clk_disable(xdev->clk);
+
 	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
 		 xdev->base, xilinx_wdt_wdd->timeout);
 
@@ -245,6 +264,43 @@ static int xwdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/**
+ * xwdt_suspend - Suspend the device.
+ *
+ * @dev: handle to the device structure.
+ * Return: 0 always.
+ */
+static int __maybe_unused xwdt_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xwdt_device *xdev = platform_get_drvdata(pdev);
+
+	if (watchdog_active(&xdev->xilinx_wdt_wdd))
+		xilinx_wdt_stop(&xdev->xilinx_wdt_wdd);
+
+	return 0;
+}
+
+/**
+ * xwdt_resume - Resume the device.
+ *
+ * @dev: handle to the device structure.
+ * Return: 0 on success, errno otherwise.
+ */
+static int __maybe_unused xwdt_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xwdt_device *xdev = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	if (watchdog_active(&xdev->xilinx_wdt_wdd))
+		ret = xilinx_wdt_start(&xdev->xilinx_wdt_wdd);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
+
 /* Match table for of_platform binding */
 static const struct of_device_id xwdt_of_match[] = {
 	{ .compatible = "xlnx,xps-timebase-wdt-1.00.a", },
@@ -259,6 +315,7 @@ static struct platform_driver xwdt_driver = {
 	.driver = {
 		.name  = WATCHDOG_NAME,
 		.of_match_table = xwdt_of_match,
+		.pm = &xwdt_pm_ops,
 	},
 };
 
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 5615f40..b9e376c 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -74,7 +74,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 #define USB_PCWD_PRODUCT_ID	0x1140
 
 /* table of devices that work with this driver */
-static struct usb_device_id usb_pcwd_table[] = {
+static const struct usb_device_id usb_pcwd_table[] = {
 	{ USB_DEVICE(USB_PCWD_VENDOR_ID, USB_PCWD_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 4f47b5e..7809713 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -162,6 +162,8 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
 
 	/* We use CPU0's DGT for the watchdog */
 	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index cf61c92..831ef83 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -1,8 +1,8 @@
 /*
  * Watchdog driver for Renesas WDT watchdog
  *
- * Copyright (C) 2015-16 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
- * Copyright (C) 2015-16 Renesas Electronics Corporation
+ * Copyright (C) 2015-17 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015-17 Renesas Electronics Corporation
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
@@ -23,10 +23,22 @@
 #define RWTCSRA_WOVF	BIT(4)
 #define RWTCSRA_WRFLG	BIT(5)
 #define RWTCSRA_TME	BIT(7)
+#define RWTCSRB		8
 
 #define RWDT_DEFAULT_TIMEOUT 60U
 
-static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
+/*
+ * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
+ * divider (12 bits). d is only a factor to fully utilize the WDT counter and
+ * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
+ */
+#define MUL_BY_CLKS_PER_SEC(p, d) \
+	DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
+
+/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
+#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
+
+static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024, 4096 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -36,8 +48,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
-	struct clk *clk;
-	unsigned int clks_per_sec;
+	unsigned long clk_rate;
 	u8 cks;
 };
 
@@ -55,7 +66,7 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
+	rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, wdev->timeout), RWTCNT);
 
 	return 0;
 }
@@ -64,8 +75,9 @@ static int rwdt_start(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	clk_prepare_enable(priv->clk);
+	pm_runtime_get_sync(wdev->parent);
 
+	rwdt_write(priv, 0, RWTCSRB);
 	rwdt_write(priv, priv->cks, RWTCSRA);
 	rwdt_init_timeout(wdev);
 
@@ -82,7 +94,7 @@ static int rwdt_stop(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	rwdt_write(priv, priv->cks, RWTCSRA);
-	clk_disable_unprepare(priv->clk);
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
@@ -92,7 +104,7 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 	u16 val = readw_relaxed(priv->base + RWTCNT);
 
-	return DIV_ROUND_CLOSEST(65536 - val, priv->clks_per_sec);
+	return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
 }
 
 static const struct watchdog_info rwdt_ident = {
@@ -112,8 +124,8 @@ static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
 	struct resource *res;
-	unsigned long rate;
-	unsigned int clks_per_sec;
+	struct clk *clk;
+	unsigned long clks_per_sec;
 	int ret, i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -125,36 +137,40 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	pm_runtime_enable(&pdev->dev);
 
-	rate = clk_get_rate(priv->clk);
-	if (!rate)
-		return -ENOENT;
+	pm_runtime_get_sync(&pdev->dev);
+	priv->clk_rate = clk_get_rate(clk);
+	pm_runtime_put(&pdev->dev);
+
+	if (!priv->clk_rate) {
+		ret = -ENOENT;
+		goto out_pm_disable;
+	}
 
 	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
-		clks_per_sec = DIV_ROUND_UP(rate, clk_divs[i]);
-		if (clks_per_sec) {
-			priv->clks_per_sec = clks_per_sec;
+		clks_per_sec = priv->clk_rate / clk_divs[i];
+		if (clks_per_sec && clks_per_sec < 65536) {
 			priv->cks = i;
 			break;
 		}
 	}
 
-	if (!clks_per_sec) {
+	if (i < 0) {
 		dev_err(&pdev->dev, "Can't find suitable clock divider\n");
-		return -ERANGE;
+		ret = -ERANGE;
+		goto out_pm_disable;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-
 	priv->wdev.info = &rwdt_ident,
 	priv->wdev.ops = &rwdt_ops,
 	priv->wdev.parent = &pdev->dev;
 	priv->wdev.min_timeout = 1;
-	priv->wdev.max_timeout = 65536 / clks_per_sec;
+	priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
 	priv->wdev.timeout = min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
 
 	platform_set_drvdata(pdev, priv);
@@ -167,13 +183,14 @@ static int rwdt_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Specified timeout value invalid, using default\n");
 
 	ret = watchdog_register_device(&priv->wdev);
-	if (ret < 0) {
-		pm_runtime_put(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_pm_disable;
 
 	return 0;
+
+ out_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int rwdt_remove(struct platform_device *pdev)
@@ -181,7 +198,6 @@ static int rwdt_remove(struct platform_device *pdev)
 	struct rwdt_priv *priv = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&priv->wdev);
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 05524ba..98967f0 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -119,7 +119,7 @@ static int rt288x_wdt_bootcause(void)
 	return 0;
 }
 
-static struct watchdog_info rt288x_wdt_info = {
+static const struct watchdog_info rt288x_wdt_info = {
 	.identity = "Ralink Watchdog",
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 };
@@ -152,7 +152,7 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(rt288x_wdt_clk))
 		return PTR_ERR(rt288x_wdt_clk);
 
-	rt288x_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
+	rt288x_wdt_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (!IS_ERR(rt288x_wdt_reset))
 		reset_control_deassert(rt288x_wdt_reset);
 
diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index b34d3d5..8e4e2fc 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -342,7 +342,7 @@ static int __init sc1200wdt_probe(void)
 
 #if defined CONFIG_PNP
 
-static struct pnp_device_id scl200wdt_pnp_devices[] = {
+static const struct pnp_device_id scl200wdt_pnp_devices[] = {
 	/* National Semiconductor PC87307/PC97307 watchdog component */
 	{.id = "NSC0800", .driver_data = 0},
 	{.id = ""},
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index e7a715e..03805bc 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -281,7 +281,7 @@ static int __maybe_unused sp805_wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
 		sp805_wdt_resume);
 
-static struct amba_id sp805_wdt_ids[] = {
+static const struct amba_id sp805_wdt_ids[] = {
 	{
 		.id	= 0x00141805,
 		.mask	= 0x00ffffff,
diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 6c501b7..be64a86 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -140,7 +140,7 @@ static const struct watchdog_info stm32_iwdg_info = {
 	.identity	= "STM32 Independent Watchdog",
 };
 
-static struct watchdog_ops stm32_iwdg_ops = {
+static const struct watchdog_ops stm32_iwdg_ops = {
 	.owner		= THIS_MODULE,
 	.start		= stm32_iwdg_start,
 	.ping		= stm32_iwdg_ping,
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 17c25da..811e43c 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -112,7 +112,7 @@ static const struct watchdog_info ts72xx_wdt_ident = {
 	.identity		= "TS-72XX WDT",
 };
 
-static struct watchdog_ops ts72xx_wdt_ops = {
+static const struct watchdog_ops ts72xx_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= ts72xx_wdt_start,
 	.stop		= ts72xx_wdt_stop,
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index d9ba049..7817836 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -429,7 +429,7 @@ static int __init wdt_init(void)
 {
 	int ret;
 	int chip;
-	const char * const chip_name[] = {
+	static const char * const chip_name[] = {
 		"W83627HF",
 		"W83627S",
 		"W83697HF",
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index b4e0cea..d3594aa 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -737,7 +737,7 @@ static int ziirave_wdt_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct i2c_device_id ziirave_wdt_id[] = {
+static const struct i2c_device_id ziirave_wdt_id[] = {
 	{ "rave-wdt", 0 },
 	{ }
 };
diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
index 69ec585..9261f7c 100644
--- a/drivers/watchdog/zx2967_wdt.c
+++ b/drivers/watchdog/zx2967_wdt.c
@@ -229,7 +229,7 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
 	}
 	clk_set_rate(wdt->clock, ZX2967_WDT_CLK_FREQ);
 
-	rstc = devm_reset_control_get(dev, NULL);
+	rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rstc)) {
 		dev_err(dev, "failed to get rstc");
 		ret = PTR_ERR(rstc);
