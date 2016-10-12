Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([85.17.2.162]:33759 "EHLO spo001.leaseweb.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755919AbcJLSfI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Oct 2016 14:35:08 -0400
Date: Wed, 12 Oct 2016 20:35:05 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: [GIT PULL REQUEST] watchdog - v4.9 merge window
Message-ID: <20161012183505.GA14975@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It contains:
* a new watchdog pretimeout governor framework
* support to upload the firmware on the ziirave_wdt
* several fixes and cleanups

This will update the following files:

 Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt |    3 
 Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt    |    2 
 Documentation/watchdog/watchdog-kernel-api.txt               |   33 
 drivers/watchdog/Kconfig                                     |   49 +
 drivers/watchdog/Makefile                                    |    8 
 drivers/watchdog/asm9260_wdt.c                               |    1 
 drivers/watchdog/bcm7038_wdt.c                               |    2 
 drivers/watchdog/cadence_wdt.c                               |   20 
 drivers/watchdog/dw_wdt.c                                    |   11 
 drivers/watchdog/hpwdt.c                                     |    8 
 drivers/watchdog/iTCO_wdt.c                                  |    2 
 drivers/watchdog/imx2_wdt.c                                  |   60 +
 drivers/watchdog/kempld_wdt.c                                |    2 
 drivers/watchdog/mt7621_wdt.c                                |    1 
 drivers/watchdog/of_xilinx_wdt.c                             |   25 
 drivers/watchdog/pcwd_usb.c                                  |    4 
 drivers/watchdog/pretimeout_noop.c                           |   47 +
 drivers/watchdog/pretimeout_panic.c                          |   47 +
 drivers/watchdog/rn5t618_wdt.c                               |    2 
 drivers/watchdog/rt2880_wdt.c                                |    1 
 drivers/watchdog/softdog.c                                   |   24 
 drivers/watchdog/st_lpc_wdt.c                                |   33 
 drivers/watchdog/tegra_wdt.c                                 |    2 
 drivers/watchdog/txx9wdt.c                                   |    6 
 drivers/watchdog/w83627hf_wdt.c                              |    2 
 drivers/watchdog/watchdog_core.c                             |    2 
 drivers/watchdog/watchdog_dev.c                              |  101 ++
 drivers/watchdog/watchdog_pretimeout.c                       |  220 +++++
 drivers/watchdog/watchdog_pretimeout.h                       |   60 +
 drivers/watchdog/ziirave_wdt.c                               |  409 ++++++++++-
 fs/compat_ioctl.c                                            |    2 
 include/linux/watchdog.h                                     |   24 
 32 files changed, 1132 insertions(+), 81 deletions(-)

with these Changes:

commit 39487f6688a557ebfc69816d7e02f210bf8fb2a3
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Fri Oct 7 15:41:39 2016 +0300

    watchdog: imx2_wdt: add pretimeout function support
    
    The change adds watchdog pretimeout notification handling to imx2_wdt
    driver, if device data contains information about a valid interrupt.
    
    It is unlikely but still possible (e.g. through a software limitation)
    that only a subset of watchdogs on SoC has interrupt lines, hence
    functionally the devices from these two groups have different
    capabilities, and this is reflected in different watchdog_info
    structs assigned to the devices.
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2accf320786210db92f36866cc71fa894f510a4a
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Fri Oct 7 15:41:38 2016 +0300

    watchdog: softdog: implement pretimeout support
    
    Give devices which do not have hardware support for pretimeout at least a
    software version of it.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 89873a711dd20b614abb6e4038fb4b5462f4c701
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Fri Oct 7 15:39:57 2016 +0300

    watchdog: pretimeout: add pretimeout_available_governors attribute
    
    The change adds an option to a user with CONFIG_WATCHDOG_SYSFS and
    CONFIG_WATCHDOG_PRETIMEOUT_GOV enabled to get information about all
    registered watchdog pretimeout governors by reading watchdog device
    attribute named "pretimeout_available_governors".
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 53f96cee1aff74c8ee3c5f7a25df0c01d7117eeb
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Fri Oct 7 15:37:00 2016 +0300

    watchdog: pretimeout: add option to select a pretimeout governor in runtime
    
    The change converts watchdog device attribute "pretimeout_governor" from
    read-only to read-write type to allow users to select a desirable
    watchdog pretimeout governor in runtime, e.g.
    
      % echo -n panic > /sys/..../watchdog/watchdog0/pretimeout
    
    To get this working a list of registered pretimeout governors is created
    and a new helper function watchdog_pretimeout_governor_set() is exported
    to watchdog_dev.c.
    
    If a selected governor is gone, a watchdog device pretimeout notification
    is delegated to a default built-in pretimeout governor.
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit da0d12ff2b829a35e9921918e925d79497b82bef
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Fri Oct 7 15:39:56 2016 +0300

    watchdog: pretimeout: add panic pretimeout governor
    
    The change adds panic watchdog pretimeout governor, on watchdog
    pretimeout event the kernel shall panic. In general watchdog
    pretimeout event means that something essentially bad is going on the
    system, for example a process scheduler stalls or watchdog feeder is
    killed due to OOM, so printing out information attendant to panic and
    before likely unavoidable reboot caused by a watchdog may help to
    determine a root cause of the issue.
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f77710c4cda01ad9c3672fb2f97bdea9a94da92a
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Fri Oct 7 15:39:55 2016 +0300

    watchdog: pretimeout: add noop pretimeout governor
    
    The change adds noop watchdog pretimeout governor, only an
    informational message is printed to the kernel log buffer when a
    watchdog triggers a pretimeout event.
    
    While introducing the first pretimeout governor the selected design
    assumes that the default pretimeout governor is selected by its name
    and it is always built-in, thus the default pretimeout governor can
    not be unregistered and the correspondent check can be removed from
    the watchdog_unregister_governor() function.
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ff84136cb6a4943f489ad037fe93f43be0573c23
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Fri Oct 7 15:39:54 2016 +0300

    watchdog: add watchdog pretimeout governor framework
    
    The change adds a simple watchdog pretimeout framework infrastructure,
    its purpose is to allow users to select a desired handling of watchdog
    pretimeout events, which may be generated by some watchdog devices.
    
    A user selects a default watchdog pretimeout governor during
    compilation stage.
    
    Watchdogs with WDIOF_PRETIMEOUT capability now have one more device
    attribute in sysfs, pretimeout_governor attribute is intended to display
    the selected watchdog pretimeout governor.
    
    The framework has no impact at runtime on watchdog devices with no
    WDIOF_PRETIMEOUT capability set.
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit fc113d54e9d7ef3296cdf2eff49c8ca0a3e5a482
Author: Brian Boylston <brian.boylston@hpe.com>
Date:   Mon Sep 26 13:57:14 2016 -0500

    watchdog: hpwdt: add support for iLO5
    
    iLO5 will offer the same watchdog timer as previous generations, but the
    PCI subsystem vendor ID will be PCI_VENDOR_ID_HP_3PAR (0x1590) instead of
    PCI_VENDOR_ID_HP (0x103c).  Add 0x1590 to the whitelist and be more
    specific when ignoring the 103c,1979 device.
    
    Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 97beb3ae02b02740c2784aa05b591bf5138f45e6
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Aug 31 14:52:42 2016 +0300

    fs: compat_ioctl: add pretimeout functions for watchdogs
    
    Watchdog core now handles those ioctls centrally, so we want 64 bit
    support, too.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Cc: Alexander Viro <viro@zeniv.linux.org.uk>
    Cc: linux-fsdevel@vger.kernel.org
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit df044e02206230c7d79a9aef96a6c087476f5533
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Aug 31 14:52:41 2016 +0300

    watchdog: add pretimeout support to the core
    
    Since the watchdog framework centrializes the IOCTL interfaces of device
    drivers now, SETPRETIMEOUT and GETPRETIMEOUT need to be added in the
    common code.
    
    Signed-off-by: Robin Gong <b38343@freescale.com>
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    [vzapolskiy: added conditional pretimeout sysfs attribute visibility]
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 68d4cb809ef84f9a0ea6a23c4c0dc0ae48355f78
Author: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date:   Wed Aug 31 14:52:49 2016 +0300

    watchdog: imx2_wdt: use preferred BIT macro instead of open coded values
    
    This is a nonfunctional change, declare register bit values with BIT()
    helper macro.
    
    The issues are reported by checkpatch:
    
      CHECK: Prefer using the BIT macro
      #40: FILE: drivers/watchdog/imx2_wdt.c:40:
      +#define IMX2_WDT_WCR_WDA	(1 << 5)	/* -> External Reset WDOG_B */
    
    etc.
    
    Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 7dd2ce7c91bd29d2fb7436cd2a607c7d24835e82
Author: Peter Griffin <peter.griffin@linaro.org>
Date:   Wed Sep 14 14:27:49 2016 +0100

    watchdog: st_wdt: Remove support for obsolete platforms
    
    STiH415/6 SoC support is being removed from the kernel.
    This patch updates the watchdog driver to remove references
    to these obsolete platforms.
    
    Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
    Cc: <linux-watchdog@vger.kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c3025a0b7508c7b9a2db81afd4e81dba9984cef0
Author: Peter Griffin <peter.griffin@linaro.org>
Date:   Wed Sep 14 14:27:48 2016 +0100

    watchdog: bindings: Remove obsolete platforms from dt doc.
    
    STiH415/6 SoC support is being removed from the kernel
    so update the dt bding document to reflect this.
    
    Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
    Cc: <linux-watchdog@vger.kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8355b3f94425ac8b9683869354be935795f055ca
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Mon Sep 12 06:16:51 2016 -0700

    watchdog: mt7621_wdt: Remove assignment of dev pointer
    
    Commit 0254e953537c ("watchdog: Drop pointer to watchdog device from
    struct watchdog_device") removed the dev pointer from struct
    watchdog_device, but this driver was still assigning it, leading to
    a compilation error:
    
    drivers/watchdog/mt7621_wdt.c: In function 'mt7621_wdt_probe':
    drivers/watchdog/mt7621_wdt.c:142:16: error:
    	'struct watchdog_device' has no member named 'dev'
    
    Fix this by removing the assignment.
    
    Fixes: 0254e953537c ("watchdog: Drop pointer to watchdog device ...")
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Cc: stable@vger.kernel.org # v4.5+
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit df9c692b5618914d4ce7c9e3e011c5683fc16226
Author: Matt Redfearn <matt.redfearn@imgtec.com>
Date:   Mon Sep 12 10:35:12 2016 +0100

    watchdog: rt2880_wdt: Remove assignment of dev pointer
    
    Commit 0254e953537c ("watchdog: Drop pointer to watchdog device from
    struct watchdog_device") removed the dev pointer from struct
    watchdog_device, but this driver was still assigning it, leading to a
    compilation error:
    
    drivers/watchdog/rt2880_wdt.c: In function ‘rt288x_wdt_probe’:
    drivers/watchdog/rt2880_wdt.c:161:16: error: ‘struct watchdog_device’
    has no member named ‘dev’
      rt288x_wdt_dev.dev = &pdev->dev;
                    ^
    scripts/Makefile.build:289: recipe for target
    'drivers/watchdog/rt2880_wdt.o' failed
    
    Fix this by removing the assignment.
    
    Fixes: 0254e953537c ("watchdog: Drop pointer to watchdog device ...")
    Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
    Cc: stable@vger.kernel.org # v4.5+
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 85f15cfc213da88d9eb01c943be454328b104f3c
Author: Julia Lawall <Julia.Lawall@lip6.fr>
Date:   Thu Sep 1 19:35:26 2016 +0200

    watchdog: constify watchdog_ops structures
    
    Check for watchdog_ops structures that are only stored in the ops field of
    a watchdog_device structure.  This field is declared const, so watchdog_ops
    structures that have this property can be declared as const also.
    
    The semantic patch that makes this change is as follows:
    (http://coccinelle.lip6.fr/)
    
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
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 7123f253f02b7370ad25d9047fd91a5ef6ae551f
Author: Julia Lawall <Julia.Lawall@lip6.fr>
Date:   Thu Sep 1 19:35:25 2016 +0200

    watchdog: tegra: constify watchdog_ops structures
    
    Check for watchdog_ops structures that are only stored in the ops field of
    a watchdog_device structure.  This field is declared const, so watchdog_ops
    structures that have this property can be declared as const also.
    
    The semantic patch that makes this change is as follows:
    (http://coccinelle.lip6.fr/)
    
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
    Acked-by: Thierry Reding <treding@nvidia.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 6e938f6e86a54ba22324a8e4f8c0fb774cffa273
Author: Julia Lawall <Julia.Lawall@lip6.fr>
Date:   Sun Aug 28 22:26:26 2016 +0200

    watchdog: iTCO_wdt: constify iTCO_wdt_pm structure
    
    iTCO_wdt_pm, of type struct dev_pm_ops, is never modified, so declare it as
    const.
    
    Done with the help of Coccinelle.
    
    Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit eadc4fe17d04723373ada219d382b3b413b21dad
Author: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Date:   Mon Sep 12 12:53:49 2016 +0530

    watchdog: cadence_wdt: Fix the suspend resume
    
    Currently even if no users are there the suspend tries to
    stop the watchdog and resume starts it.
    
    so after resume the watchdog starts and resets the board.
    Fix the same by adding a check for users.
    
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit bfb1f46f69060642d54125cb777c817f3f9436e3
Author: Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun Sep 11 10:59:57 2016 +0200

    watchdog: txx9wdt: Add missing clock (un)prepare calls for CCF
    
    While the custom minimal TXx9 clock implementation doesn't need or use
    clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
    they are mandatory when using the Common Clock Framework.
    
    Hence add them, to prepare for the advent of CCF.
    
    Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 619db74a2ba076d33097f49b17c93369666ac6f5
Author: Markus Elfring <elfring@users.sourceforge.net>
Date:   Mon Aug 15 13:34:47 2016 +0200

    watchdog-asm9260: Delete owner assignment
    
    The field "owner" is set by core. Thus delete an extra initialisation.
    
    Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci
    Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 217209db0204ae1fa5f30af804525863e852c35d
Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date:   Wed Aug 10 18:18:03 2016 +0200

    watchdog: ziirave_wdt: Add support to upload the firmware.
    
    This patch adds and entry to the sysfs to start firmware upload process
    on the specified device with the requested firmware.
    
    The uploading of the firmware needs only to happen once per firmware
    upgrade, as the firmware is stored in persistent storage. If the
    firmware upload or the firmware verification fails then we print and
    error message and exit.
    
    Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9d6b4efc16b3e8e7414fcd6aab8fec42756ba920
Author: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Date:   Fri Aug 12 12:17:01 2016 +0530

    watchdog: xilinx: Add clock support
    
    Add support for the clock. Currently we enable
    at probe and relinquish at remove.
    
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
    Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d2a0015174213cc518b2b83d234c09f548f8ac32
Author: Wolfram Sang <wsa-dev@sang-engineering.com>
Date:   Thu Aug 11 23:23:40 2016 +0200

    watchdog: pcwd_usb: don't print error when allocating urb fails
    
    kmalloc will print enough information in case of failure.
    
    Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c97344f73fdc35b27c7315c5e7c5decd4ce10467
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Tue Aug 9 22:35:58 2016 -0700

    watchdog: dw_wdt: Read clock rate only once and validate it
    
    Coverity reports:
    
    divide_by_zero: In expression readl(dw_wdt->regs + 8) /
    clk_get_rate(dw_wdt->clk), division by expression clk_get_rate(dw_wdt->clk)
    which may be zero has undefined behavior.
    
    The clock used for the watchdog timer won't change its rate, so read it
    only once during probe. Also validate it and abort the probe function
    with an error if it is 0.
    
    Cc: Douglas Anderson <dianders@chromium.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2e91838bf7ffdedabdb29e091207d6531d04ef4f
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Tue Aug 9 22:34:31 2016 -0700

    watchdog: core: Fix devres_alloc() allocation size
    
    Coverity reports:
    
    Passing argument 152UL /* sizeof (*wdd) */ to function __devres_alloc_node
    and then casting the return value to struct watchdog_device ** is
    suspicious.
    
    Allocation size needs to be sizeof(*rcwdd), not sizeof(*wdd).
    
    Fixes: 83fbae5a148c ("watchdog: Add a device managed API for ...")
    Cc: Neil Armstrong <narmstrong@baylibre.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: Neil Armstrong <narmstrong@baylibre.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Greetings,
Wim.

