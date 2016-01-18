Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:42391 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964AbcARIHX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jan 2016 03:07:23 -0500
Date: Mon, 18 Jan 2016 09:07:17 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Carlo Caione <carlo@endlessm.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Denis Turischev <denis.turischev@compulab.co.il>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Geliang Tang <geliangtang@163.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Guo Zeng <Guo.Zeng@csr.com>, Harald Geyer <harald@ccbib.org>,
	Huang Rui <ray.huang@amd.com>,
	Jisheng Zhang <jszhang@marvell.com>,
	John Crispin <blogic@openwrt.org>,
	Li RongQing <roy.qing.li@gmail.com>,
	Mans Rullgard <mans@mansr.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Mingarelli@spo001.leaseweb.nl, Thomas <thomas.mingarelli@hpe.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Pratyush Anand <panand@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Uwe =?us-ascii?B?PT9pc28tODg1OS0xP1E/S2xlaW5lLUs9RjZuaWc/PQ==?=
	<u.kleine-koenig@pengutronix.de>
Subject: [GIT PULL REQUEST] watchdog - v4.5 Merge Window
Message-ID: <20160118080717.GA8649@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

This adds following items:
* watchdog restart handler support
* watchdog reboot notifier support
* watchdog sysfs attributes
* support for the following new devices: AMD Mullins platform, AMD Carrizo platform,
  meson8b SoC, CSRatlas7, TS-4800, Alphascale asm9260-wdt, Zodiac, Sigma Designs
  SMP86xx/SMP87xx
* Changes in refcounting for the watchdog core
* watchdog core improvements
* and small fixes

This will update the following files:

 Documentation/ABI/testing/sysfs-class-watchdog                    |   51 
 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt |   35 
 Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt         |   12 
 Documentation/devicetree/bindings/watchdog/sigma,smp8642-wdt.txt  |   18 
 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt         |   25 
 Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt        |   19 
 Documentation/watchdog/watchdog-kernel-api.txt                    |   77 -
 MAINTAINERS                                                       |    1 
 drivers/hwmon/sch56xx-common.c                                    |   31 
 drivers/watchdog/Kconfig                                          |   65 +
 drivers/watchdog/Makefile                                         |    6 
 drivers/watchdog/asm9260_wdt.c                                    |  403 +++++++
 drivers/watchdog/atlas7_wdt.c                                     |  242 ++++
 drivers/watchdog/bcm2835_wdt.c                                    |    1 
 drivers/watchdog/bcm47xx_wdt.c                                    |   55 
 drivers/watchdog/cadence_wdt.c                                    |   42 
 drivers/watchdog/da9052_wdt.c                                     |   24 
 drivers/watchdog/da9055_wdt.c                                     |   24 
 drivers/watchdog/da9063_wdt.c                                     |   23 
 drivers/watchdog/diag288_wdt.c                                    |   26 
 drivers/watchdog/digicolor_wdt.c                                  |   18 
 drivers/watchdog/dw_wdt.c                                         |    2 
 drivers/watchdog/gpio_wdt.c                                       |   38 
 drivers/watchdog/hpwdt.c                                          |   12 
 drivers/watchdog/imgpdc_wdt.c                                     |   34 
 drivers/watchdog/imx2_wdt.c                                       |   23 
 drivers/watchdog/lpc18xx_wdt.c                                    |   52 
 drivers/watchdog/mena21_wdt.c                                     |    4 
 drivers/watchdog/meson_wdt.c                                      |   88 -
 drivers/watchdog/moxart_wdt.c                                     |   23 
 drivers/watchdog/mt7621_wdt.c                                     |  186 +++
 drivers/watchdog/mtk_wdt.c                                        |   22 
 drivers/watchdog/omap_wdt.c                                       |    7 
 drivers/watchdog/qcom-wdt.c                                       |   50 
 drivers/watchdog/s3c2410_wdt.c                                    |   60 -
 drivers/watchdog/softdog.c                                        |   38 
 drivers/watchdog/sp5100_tco.c                                     |   32 
 drivers/watchdog/stmp3xxx_rtc_wdt.c                               |   25 
 drivers/watchdog/sunxi_wdt.c                                      |   23 
 drivers/watchdog/tangox_wdt.c                                     |  225 +++
 drivers/watchdog/ts4800_wdt.c                                     |  215 +++
 drivers/watchdog/w83627hf_wdt.c                                   |   32 
 drivers/watchdog/watchdog_core.c                                  |  115 +-
 drivers/watchdog/watchdog_core.h                                  |    2 
 drivers/watchdog/watchdog_dev.c                                   |  572 ++++++----
 drivers/watchdog/ziirave_wdt.c                                    |  367 ++++++
 include/linux/bcm47xx_wdt.h                                       |    3 
 include/linux/watchdog.h                                          |   38 
 48 files changed, 2671 insertions(+), 815 deletions(-)

with these Changes:

commit ac36856fe4321454b6789c019c96c3ec854094ed
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Jan 8 11:59:34 2016 +0100

    watchdog: asm9260: remove __init and __exit annotations
    
    The probe and release functions in this driver are marked
    as __init and __exit, but this is wrong as indicated by this
    Kbuild error message:
    
    WARNING: vmlinux.o(.data+0x1d2308): Section mismatch in reference from the variable asm9260_wdt_driver to the function .init.text:asm9260_wdt_probe()
    
    This removes the annotations, to make the sysfs unbind attribute
    and deferred probing work.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Fixes: aae03dc98177 ("watchdog: add Alphascale asm9260-wdt driver")
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0254e953537c92df3e7d0176f401a211e944fd61
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Jan 3 15:11:58 2016 -0800

    watchdog: Drop pointer to watchdog device from struct watchdog_device
    
    The lifetime of the watchdog device pointer is different from the lifetime
    of its character device. Remove it entirely to avoid race conditions.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2c2f3080de7341f58a5d0e8ea31cc66dd369b8f4
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Jan 3 15:11:57 2016 -0800

    watchdog: ziirave: Use watchdog infrastructure to create sysfs attributes
    
    The watchdog core now supports creating driver specific sysfs attributes
    when creating the watchdog device.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit faa584757b63aad42d19f1c6a6eac2c848618f83
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Jan 3 15:11:56 2016 -0800

    watchdog: Add support for creating driver specific sysfs attributes
    
    The Zodiac watchdog driver attaches additional sysfs attributes to the
    watchdog device. This has a number of problems: The watchdog device
    lifetime differs from the driver lifetime, and the device structure
    should therefore not be accessed from drivers. Also, creating sysfs
    attributes after driver registration results in a potential race condition
    if user space expects the attributes to exist but they don't exist yet.
    
    Add support for creating driver specific sysfs attributes to the watchdog
    core to solve the problems.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 62cd1c40ce1c7c16835b599751c7a002eb5bbdf5
Author: Tomas Winkler <tomas.winkler@intel.com>
Date:   Sun Jan 3 13:32:37 2016 +0200

    watchdog: kill unref/ref ops
    
    ref/unref ops are not called at all so even marked them as deprecated
    is misleading, we need to just drop the API.
    
    Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9ca128a99fa56f006fe6c5801896aea5e00f8479
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Mon Jan 4 10:30:47 2016 -0200

    watchdog: stmp3xxx: Remove unused variables
    
    Commit 8d2fa17151ea3 ("watchdog: stmp3xxx: Stop the watchdog on system
    halt") introduced the following build warning:
    
    drivers/watchdog/stmp3xxx_rtc_wdt.c: In function 'wdt_notify_sys':
    drivers/watchdog/stmp3xxx_rtc_wdt.c:78:29: warning: unused variable 'pdata' [-Wunused-variable]
    
    Remove the unused 'pdata' and 'dev' variables.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ab3f09fe16d158cb4f84e558c61ec5d6d601f2e0
Author: John Crispin <blogic@openwrt.org>
Date:   Mon Jan 4 20:36:38 2016 +0100

    watchdog: add MT7621 watchdog support
    
    This patch adds support for the watchdog core found on newer MediaTek Wifi
    SoCs MT7621 and MT7628. There is no symbol for MT7628 as it is a subtype of
    MT7620 so we depend on that instead.
    
    Signed-off-by: John Crispin <blogic@openwrt.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3b8d058cfe6a3b14abee324f4c4b33e64bf61aeb
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri Dec 25 16:01:45 2015 -0800

    hwmon: (sch56xx) Drop watchdog driver data reference count callbacks
    
    Reference counting is now implemented in the watchdog core and no longer
    required in watchdog drivers.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 43f676ace2e0591718ff493d290bc49b35ec2ffc
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri Dec 25 16:01:44 2015 -0800

    watchdog: da9055_wdt: Drop reference counting
    
    Reference counting is now implemented in the watchdog core and no longer
    required in watchdog drivers.
    
    Since it was implememented a no-op, and since the local memory is allocated
    with devm_kzalloc(), the reference counting code in the driver really did
    not really work anyway, and this patch effectively fixes a bug which could
    cause a crash on unloading if the watchdog device was still open.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 756d1e9247dff6d416b0c9e073247f5e808bb5fa
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri Dec 25 16:01:43 2015 -0800

    watchdog: da9052_wdt: Drop reference counting
    
    Reference counting is now implemented in the watchdog core and no longer
    required in watchdog drivers.
    
    Since it was implememented a no-op, and since the local memory is allocated
    with devm_kzalloc(), the reference counting code in the driver really did
    not really work anyway, and this patch effectively fixes a bug which could
    cause a crash on unloading if the watchdog device was still open.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b4ffb1909843b28f3b1b60197d517b123b7a9b66
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri Dec 25 16:01:42 2015 -0800

    watchdog: Separate and maintain variables based on variable lifetime
    
    All variables required by the watchdog core to manage a watchdog are
    currently stored in struct watchdog_device. The lifetime of those
    variables is determined by the watchdog driver. However, the lifetime
    of variables used by the watchdog core differs from the lifetime of
    struct watchdog_device. To remedy this situation, watchdog drivers
    can implement ref and unref callbacks, to be used by the watchdog
    core to lock struct watchdog_device in memory.
    
    While this solves the immediate problem, it depends on watchdog drivers
    to actually implement the ref/unref callbacks. This is error prone,
    often not implemented in the first place, or not implemented correctly.
    
    To solve the problem without requiring driver support, split the variables
    in struct watchdog_device into two data structures - one for variables
    associated with the watchdog driver, one for variables associated with
    the watchdog core. With this approach, the watchdog core can keep track
    of its variable lifetime and no longer depends on ref/unref callbacks
    in the driver. As a side effect, some of the variables originally in
    struct watchdog_driver are now private to the watchdog core and no longer
    visible in watchdog drivers.
    
    As a side effect of the changes made, an ioctl will now always fail
    with -ENODEV after a watchdog device was unregistered with the character
    device still open. Previously, it would only fail with -ENODEV in some
    situations. Also, ioctl operations are now atomic from driver perspective.
    With this change, it is now guaranteed that the driver will not unregister
    a watchdog between a timeout change and the subsequent ping.
    
    The 'ref' and 'unref' callbacks in struct watchdog_driver are no longer
    used and marked as deprecated.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e7d162faa6d067777548cb98d55206cf7cd3438e
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri Dec 25 16:01:41 2015 -0800

    watchdog: diag288: Stop re-using watchdog core internal flags
    
    A watchdog driver should not use watchdog subsystem internal flags.
    Use a driver variable and flag instead to maintain the watchdog state
    and to determine if a suspend operation is possible or not.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 32ecc6392654a0db34b310e8924b5b2c3b8bf503
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri Dec 25 16:01:40 2015 -0800

    watchdog: Create watchdog device in watchdog_dev.c
    
    The watchdog character device is currently created in watchdog_dev.c,
    and the watchdog device in watchdog_core.c. This results in
    cross-dependencies, since device creation needs to know the watchdog
    character device number as well as the watchdog class, both of which
    reside in watchdog_dev.c.
    
    Create the watchdog device in watchdog_dev.c to simplify the code.
    
    Inspired by earlier patch set from Damien Riegel.
    
    Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0933b453f1c7104d873aacf8524f8ac380a7ed08
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Thu Dec 24 14:22:04 2015 -0800

    watchdog: qcom-wdt: Do not set 'dev' in struct watchdog_device
    
    The 'dev' pointer in struct watchdog_device is set by the watchdog core
    when registering the watchdog device and not by the driver. It points to
    the watchdog device, not its parent.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 073523662a821940383eb3bf4064c41b0e3dae0d
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Thu Dec 24 14:22:03 2015 -0800

    watchdog: mena21: Do not use device pointer from struct watchdog_device
    
    The device pointer in struct watchdog_device has a different lifetime
    than the driver code and should not be used in drivers. Use the pointer
    to the parent device instead.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8a7b76be691fa30c7650b8e08aae8a7990c93779
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Thu Dec 24 14:22:02 2015 -0800

    watchdog: gpio: Do not use device pointer from struct watchdog_device
    
    The device pointer in struct watchdog_device has a different lifetime
    than the driver code and should not be used in drivers. Use the pointer
    to the parent device instead.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3d29f80813ba335a21b56debff8e4b92a2772a64
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Thu Dec 24 14:22:01 2015 -0800

    watchdog: tangox: Print info message using pointer to platform device
    
    The device pointer in struct watchdog_device should not be used by drivers
    and may be removed in the near future. Use the platform device pointer for
    info messages instead.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 92b3649525a5c3daf0b395b6daeaed1ce0d235c2
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Thu Dec 24 14:22:00 2015 -0800

    watchdog: bcm2835_wdt: Drop log message if watchdog is stopped
    
    Stopping a watchdog is a normal operation and does not warrant a log
    message.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2bfc9beb61ed042c4c7632bd1c96c9dfbcedcc05
Author: Mans Rullgard <mans@mansr.com>
Date:   Wed Nov 18 17:55:42 2015 +0000

    devicetree: watchdog: add binding for Sigma Designs SMP8642 watchdog
    
    This adds a binding for the watchdog in Sigma Designs SMP8642 and
    similar devices.
    
    Signed-off-by: Mans Rullgard <mans@mansr.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit dca536c433a20f916451d8318f4aa7158c0d811c
Author: Mans Rullgard <mans@mansr.com>
Date:   Thu Nov 19 22:09:05 2015 +0000

    watchdog: add support for Sigma Designs SMP86xx/SMP87xx
    
    This adds support for the Sigma Designs SMP86xx/SMP87xx family built-in
    watchdog.
    
    Signed-off-by: Mans Rullgard <mans@mansr.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5c6bb88a1b8890225d83fd00d14cf10ae00df91f
Author: Martyn Welch <martyn.welch@collabora.co.uk>
Date:   Wed Nov 25 12:03:34 2015 +0000

    Add binding documentation for Zodiac Watchdog Timer
    
    This patchs adds documentation for the binding of the Zodiac RAVE
    Switch Watchdog Processor. This is an i2c based watchdog.
    
    Cc: Pawel Moll <pawel.moll@arm.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
    Cc: Kumar Gala <galak@codeaurora.org>
    Cc: devicetree@vger.kernel.org
    Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2a7b753a285ebe1d067b1af98e5aad0cc981fffd
Author: Martyn Welch <martyn.welch@collabora.co.uk>
Date:   Tue Dec 1 15:32:47 2015 +0000

    watchdog: Zodiac Aerospace RAVE Switch Watchdog Processor Driver
    
    This patch adds a driver for the Zodiac Aerospace RAVE Watchdog Procesor.
    This device implements a watchdog timer, accessible over I2C.
    
    Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a62a7231899606655e98f060e52c4760cf556811
Author: Oleksij Rempel <linux@rempel-privat.de>
Date:   Wed Nov 25 20:33:23 2015 +0100

    DT: watchdog: add Alphascale asm9260 watchdog binding documentation.
    
    Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit aae03dc981772ce8fca7eb4f899a22014bc4c38e
Author: Oleksij Rempel <linux@rempel-privat.de>
Date:   Wed Nov 25 20:33:22 2015 +0100

    watchdog: add Alphascale asm9260-wdt driver
    
    Add WD support for Alphascale asm9260 SoC. This driver
    provide support for different function modes:
    - HW mode to trigger SoC reset on timeout
    - SW mode do soft reset if needed
    - DEBUG mode
    
    Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit bf9006399939762e6cd32445e848e56727df9d98
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Tue Dec 8 11:37:28 2015 -0500

    watchdog: ts4800: add driver for TS-4800 watchdog
    
    This watchdog is instantiated in a FPGA that is memory mapped. It is
    made of only one register, called the feed register. Writing to this
    register will re-arm the watchdog for a given time (and enable it if it
    was disable). It can be disabled by writing a special value into it.
    
    It is part of a syscon block, and the watchdog register offset in this
    block varies from board to board. This offset is passed in the syscon
    property after the phandle to the syscon node.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b466ee89509a1593441537f34c313edafe2ba47c
Author: Guo Zeng <Guo.Zeng@csr.com>
Date:   Wed Dec 2 03:37:47 2015 +0000

    watchdog: atlas7: add watchdog driver of CSRatlas7
    
    This patch adds watchdog driver for CSRatlas7 platform.
    On CSRatlas7, the 6th timer can act as a watchdog timer
    when the Watchdog mode is enabled.
    
    Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
    Signed-off-by: William Wang <William.Wang@csr.com>
    Signed-off-by: Barry Song <Baohua.Song@csr.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 71388840ec360e0489be7a75971b595c729b5323
Author: Carlo Caione <carlo@endlessm.com>
Date:   Sun Nov 8 13:18:55 2015 +0100

    watchdog: meson: Add meson8b SoC specific data
    
    Add SoC specific data in the watchdog driver for the meson8b SoC.
    
    Signed-off-by: Carlo Caione <carlo@endlessm.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 943bf1f6466f81e3ac4322c6887a4f4d68452e7f
Author: Carlo Caione <carlo@endlessm.com>
Date:   Sun Nov 8 13:18:54 2015 +0100

    watchdog: meson: Enable meson SoC specific data
    
    With this patch we refactor the driver code to enable watchdog support
    for all platforms based on Amlogic meson SoCs.
    The new default timeout is also now chosen considering the maximum
    timeout allowed by the SoC.
    
    Signed-off-by: Carlo Caione <carlo@endlessm.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ca22e79f5667faf7f6ed238e04075aeff936bbab
Author: Mingarelli, Thomas <thomas.mingarelli@hpe.com>
Date:   Mon Dec 14 20:22:09 2015 +0000

    watchdog: hpwdt: HP rebranding
    
    This patch is for the rebranding changes for the corporate split at HP.
    There are no functional changes with this patch.
    
    Signed-off-by: Tom Mingarelli <thomas.mingarelli@hpe.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 62e21f5d90f162208e43b8a248b01e1a4a24ecbd
Author: Geliang Tang <geliangtang@163.com>
Date:   Sun Dec 27 21:15:47 2015 +0800

    watchdog: cadence_wdt: use to_platform_device()
    
    Use to_platform_device() instead of open-coding it.
    
    Signed-off-by: Geliang Tang <geliangtang@163.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8605fec1ce2a397f738f1c394be7847dacf31b0c
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Tue Dec 15 11:37:41 2015 +0100

    watchdog: omap: don't disable the timer when it should be enabled early
    
    With the early_enable module parameter the watchdog can be started
    during driver probe time. If this is requested the bets are good that
    the timer is already running, so to narrow the gap where the timer is
    disabled only call the disable function when the timer shouldn't be
    started.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a6392490fbb18f71d228d9c517516fa78fb23883
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Tue Dec 15 11:37:40 2015 +0100

    watchdog: omap: don't disable runtime pm before starting device
    
    omap_wdt_start calls pm_runtime_get_sync so dropping a reference just
    before calling omap_wdt_start doesn't make much sense. Moreover there is
    no point to use the synchronous variant of pm_runtime_put because the
    driver doesn't care if the clock is disabled before or after
    omap_wdt_probe returns.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3024e0d13b0f34536f94bf0d7cc11443beeee9c5
Author: Jisheng Zhang <jszhang@marvell.com>
Date:   Tue Dec 15 22:25:27 2015 +0800

    watchdog: dw_wdt: fix signedness bug in dw_wdt_top_in_seconds()
    
    On 64bit platforms, "(1 << (16 + top)) / clk_get_rate(dw_wdt.clk)" is
    sign-extended to 64bit then converted to unsigned 64bit, finally divide
    the clk rate. If the top is the maximum TOP i.e 15, "(1 << (16 +15))"
    will be sign-extended to 0xffffffff80000000, then converted to unsigned
    0xffffffff80000000, which is a huge number, thus the final result is
    wrong.
    
    We fix this issue by giving usigned value(1U in this case) at first.
    
    Let's assume clk rate is 25MHZ,
    Before the patch:
    dw_wdt_top_in_seconds(15) = -864612050
    
    After the patch:
    dw_wdt_top_in_seconds(15) = 85
    
    Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5889f06bd31d542766046faa6b17d957c08e1484
Author: Li RongQing <roy.qing.li@gmail.com>
Date:   Thu Dec 17 21:30:02 2015 +0800

    watchdog: refuse to unload softdog module when its timer is running
    
    the softdog has static variables which are accessed if its timer is
    still running after the driver is unloaded. and lead to crash:
    
       $modprobe softdog
       $echo 1 >/dev/watchdog
       $modprobe -r softdog
    
       CPU 20 Unable to handle kernel paging request at virtual address
       Oops[#1]:
       CPU: 20 PID: 0 Comm: swapper/20 Not tainted 4.1.13-WR8.0.0.0_standard
       ...
       Modules linked in: [last unloaded: softdog]
        ....
       Call Trace:
       [<ffffffff801e142c>] cascade+0x34/0xb0
       [<ffffffff801e1964>] run_timer_softirq+0x30c/0x368
       [<ffffffff80181044>] __do_softirq+0x1ec/0x418
       [<ffffffff801815d0>] irq_exit+0x90/0x98
       [<ffffffff8010749c>] plat_irq_dispatch+0xa4/0x140
       [<ffffffff80152740>] ret_from_irq+0x0/0x4
       [<ffffffff801529e0>] __r4k_wait+0x20/0x40
       [<ffffffff801c2278>] cpu_startup_entry+0x2a0/0x368
       [<ffffffff8015fa64>] start_secondary+0x444/0x4d8
    
    add the module ref when timer is running to avoid to unload the softdog
    module
    
    Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8d2fa17151ea33a98b5f70839fd2ffa3bce51de5
Author: Harald Geyer <harald@ccbib.org>
Date:   Sat Dec 12 14:32:15 2015 +0000

    watchdog: stmp3xxx: Stop the watchdog on system halt
    
    This allows the system to actually halt even if userspace forgot to
    disable the watchdog first. Old behaviour was that the watchdog forced
    the system to boot again.
    
    Signed-off-by: Harald Geyer <harald@ccbib.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit bdecfcdb5461834aab24002bb18d3cbdd907b7fb
Author: Huang Rui <ray.huang@amd.com>
Date:   Mon Nov 23 18:07:35 2015 +0800

    sp5100_tco: fix the device check for SB800 and later chipsets
    
    For SB800 and later chipsets, the register definitions are the same
    with SB800. And for SB700 and older chipsets, the definitions should
    be same with SP5100/SB7x0.
    
    Signed-off-by: Huang Rui <ray.huang@amd.com>
    Cc: Denis Turischev <denis.turischev@compulab.co.il>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit cca118fa2a0a94e0f0b3c8dd1dda922cdee45089
Author: Huang Rui <ray.huang@amd.com>
Date:   Mon Nov 23 18:07:36 2015 +0800

    sp5100_tco: Add AMD Carrizo platform support
    
    sp5100_tco watchdog is also supported on AMD KernCZ chipset of Carrizo
    platform.
    
    Signed-off-by: Huang Rui <ray.huang@amd.com>
    Cc: Denis Turischev <denis.turischev@compulab.co.il>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 190aa4304de6fe2185d96392ddf56580fa133e99
Author: Denis Turischev <denis.turischev@compulab.co.il>
Date:   Tue Nov 24 10:46:12 2015 +0200

    sp5100_tco: Add AMD Mullins platform support
    
    AMD Mullins watchdog is fully compatible to the previous Hudson chipset,
    reuse the existent sp5100_tco driver.
    
    Signed-off-by: Denis Turischev <denis.turischev@compulab.co.il>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 33b711269ade3f6bc9d9d15e4343e6fa922d999b
Author: Pratyush Anand <panand@redhat.com>
Date:   Thu Dec 17 17:53:59 2015 +0530

    watchdog: Read device status through sysfs attributes
    
    This patch adds following attributes to watchdog device's sysfs interface
    to read its different status.
    
    * state - reads whether device is active or not
    * identity - reads Watchdog device's identity string.
    * timeout - reads current timeout.
    * timeleft - reads timeleft before watchdog generates a reset
    * bootstatus - reads status of the watchdog device at boot
    * status - reads watchdog device's  internal status bits
    * nowayout - reads whether nowayout feature was set or not
    
    Testing with iTCO_wdt:
     # cd /sys/class/watchdog/watchdog1/
     # ls
    bootstatus  dev  device  identity  nowayout  power  state
    subsystem  timeleft  timeout  uevent
     # cat identity
    iTCO_wdt
     # cat timeout
    30
     # cat state
    inactive
     # echo > /dev/watchdog1
     # cat timeleft
    26
     # cat state
    active
     # cat bootstatus
    0
     # cat nowayout
    0
    
    Signed-off-by: Pratyush Anand <panand@redhat.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 906d7a5cfeda508e7361f021605579a00cd82815
Author: Pratyush Anand <panand@redhat.com>
Date:   Thu Dec 17 17:53:58 2015 +0530

    watchdog: Use static struct class watchdog_class in stead of pointer
    
    We need few sysfs attributes to know different status of a watchdog device.
    To do that, we need to associate .dev_groups with watchdog_class. So
    convert it from pointer to static.
    Putting this static struct in watchdog_dev.c, so that static device
    attributes defined in that file can be attached to it.
    
    Signed-off-by: Pratyush Anand <panand@redhat.com>
    Suggested-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d68106bbec2c2a33faacd50a1f7d24954701f505
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Fri Nov 20 16:54:56 2015 -0500

    watchdog: w83627hf_wdt: use core reboot notifier
    
    Get rid of the custom reboot notifier block registration and use the one
    provided by the watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 84ebcc17f281ed6ce1e6a7b4b0d9f15da727edd5
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Fri Nov 20 16:54:55 2015 -0500

    watchdog: softdog: use core reboot notifier
    
    Get rid of the custom reboot notifier block registration and use the one
    provided by the watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 28e805b44d52900fc5b05b35ef3945dc6db336a1
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Fri Nov 20 16:54:54 2015 -0500

    watchdog: gpio_wdt: use core reboot notifier
    
    Get rid of the custom reboot notifier block registration and use the one
    provided by the watchdog core.
    
    Note that this watchdog used to stop unconditionnaly on SYS_HALT and
    SYS_POWER_OFF. The core function now calls ops->stop on SYS_HALT and
    SYS_DOWN. To prevent the watchdog from being stopped on reboot, the
    "always-running" property must be set, otherwise it will now be stopped.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5e1f976f43dc6b5903ee4b78536347b5004cefe4
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Fri Nov 20 16:54:53 2015 -0500

    watchdog: cadence_wdt: use core reboot notifier
    
    Get rid of the custom reboot notifier block registration and use the one
    provided by the watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2786aadeab263609eb690ca37e7dfd3b9ffa3625
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Fri Nov 20 16:54:52 2015 -0500

    watchdog: bcm47xx_wdt: use core reboot notifier
    
    Get rid of the custom reboot notifier block registration and use the one
    provided by the watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e131319669e0ef5e6fcd75174daeffa40492135c
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Fri Nov 20 16:54:51 2015 -0500

    watchdog: core: add reboot notifier support
    
    Many watchdog drivers register a reboot notifier in order to stop the
    watchdog on system reboot. Thus we can factorize this code in the
    watchdog core.
    
    For that purpose, a new notifier block is added in watchdog_device for
    internal use only, as well as a new watchdog_stop_on_reboot helper
    function.
    
    If this helper is called, watchdog core registers the related notifier
    block and will stop the watchdog when SYS_HALT or SYS_DOWN is received.
    
    Since this operation can be critical on some platforms, abort the device
    registration if the reboot notifier registration fails.
    
    Suggested-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0ebad1e5e5bae3e59125675d37a70d946f283fef
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:11 2015 -0500

    watchdog: sunxi_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c71f5cd25f946fe1eb13bb25230ce0a957c9ac16
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:10 2015 -0500

    watchdog: s3c2410_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 80969a68ffed12f82e2a29908306ff43a6861a61
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:09 2015 -0500

    watchdog: qcom-wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e86adc3f631bd9d773f1028d6d88c9f5a02b07a5
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:08 2015 -0500

    watchdog: mtk_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 46c17f0f91729404b3578570302db88039fee8b5
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:07 2015 -0500

    watchdog: moxart_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1b6fd59ad810a5fe003521789e7d9e996883450a
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:06 2015 -0500

    watchdog: meson_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2de4e5a67660b79535659f5961a10beaf551b49b
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:05 2015 -0500

    watchdog: lpc18xx_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2d9d24755e7669ec39c946918038ce646e75a67a
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:04 2015 -0500

    watchdog: imx2_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0f10d9c57e56baaf90027bc8bda8ba9e033357e3
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:03 2015 -0500

    watchdog: imgpdc_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d3b081857cef5e25d53e5299a2816d1938dae553
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:02 2015 -0500

    watchdog: digicolor_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f79781ceadf979e1dcfe366f18ca44f6bc78814f
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:01 2015 -0500

    watchdog: da9063_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 65a4a1dc31ad9d73918971f1b89c617812c494bf
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:28:00 2015 -0500

    watchdog: bcm47xx_wdt: use core restart handler
    
    Get rid of the custom restart handler by using the one provided by the
    watchdog core.
    
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2165bf524da5f5e496d1cdb8c5afae1345ecce1e
Author: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date:   Mon Nov 16 12:27:59 2015 -0500

    watchdog: core: add restart handler support
    
    Many watchdog drivers implement the same code to register a restart
    handler. This patch provides a generic way to set such a function.
    
    The patch adds a new restart watchdog operation. If a restart priority
    greater than 0 is needed, the driver can call
    watchdog_set_restart_priority to set it.
    
    Suggested-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1f32f83e5d81c1e99a1c16366e71d5867cd1e364
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sat Dec 5 22:18:25 2015 -0800

    MAINTAINERS: Add Guenter Roeck as reviewer of watchdog drivers
    
    Guenter has been reviewing watchdog drivers for years, so we might
    as well make it official.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

The overal diff is to long to include this time.

Greetings,
Wim.

