Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 16 Jan 2016 17:19:08 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Carlo Caione <carlo@endlessm.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Denis Turischev <denis.turischev@compulab.co.il>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Geliang Tang <geliangtang@163.com>,
	Guenter Roeck <linux@roeck-us.net>, Guo Zeng <Guo.Zeng@csr.com>,
	Harald Geyer <harald@ccbib.org>, Huang Rui <ray.huang@amd.com>,
	Jisheng Zhang <jszhang@marvell.com>,
	John Crispin <blogic@openwrt.org>,
	Li RongQing <roy.qing.li@gmail.com>, Mans Rullgard <mans@mansr.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Mingarelli@spo001.leaseweb.nl, Thomas <thomas.mingarelli@hpe.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Pratyush Anand <panand@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [GIT PULL REQUEST] watchdog - v4.5 Merge Window
Message-ID: <20160116161908.GA26913@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

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

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
new file mode 100644
index 0000000..736046b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-watchdog
@@ -0,0 +1,51 @@
+What:		/sys/class/watchdog/watchdogn/bootstatus
+Date:		August 2015
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. It contains status of the watchdog
+		device at boot. It is equivalent to WDIOC_GETBOOTSTATUS of
+		ioctl interface.
+
+What:		/sys/class/watchdog/watchdogn/identity
+Date:		August 2015
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. It contains identity string of
+		watchdog device.
+
+What:		/sys/class/watchdog/watchdogn/nowayout
+Date:		August 2015
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. While reading, it gives '1' if that
+		device supports nowayout feature else, it gives '0'.
+
+What:		/sys/class/watchdog/watchdogn/state
+Date:		August 2015
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. It gives active/inactive status of
+		watchdog device.
+
+What:		/sys/class/watchdog/watchdogn/status
+Date:		August 2015
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. It contains watchdog device's
+		internal status bits. It is equivalent to WDIOC_GETSTATUS
+		of ioctl interface.
+
+What:		/sys/class/watchdog/watchdogn/timeleft
+Date:		August 2015
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. It contains value of time left for
+		reset generation. It is equivalent to WDIOC_GETTIMELEFT of
+		ioctl interface.
+
+What:		/sys/class/watchdog/watchdogn/timeout
+Date:		August 2015
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. It is read to know about current
+		value of timeout programmed.
diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
new file mode 100644
index 0000000..75b265a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
@@ -0,0 +1,35 @@
+Alphascale asm9260 Watchdog timer
+
+Required properties:
+
+- compatible : should be "alphascale,asm9260-wdt".
+- reg : Specifies base physical address and size of the registers.
+- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
+- clock-names : should be set to
+	"mod" - source for tick counter.
+	"ahb" - ahb gate.
+- resets : phandle pointing to the system reset controller with
+	line index for the watchdog.
+- reset-names : should be set to "wdt_rst".
+
+Optional properties:
+- timeout-sec : shall contain the default watchdog timeout in seconds,
+	if unset, the default timeout is 30 seconds.
+- alphascale,mode : three modes are supported
+	"hw" - hw reset (default).
+	"sw" - sw reset.
+	"debug" - no action is taken.
+
+Example:
+
+watchdog0: watchdog@80048000 {
+	compatible = "alphascale,asm9260-wdt";
+	reg = <0x80048000 0x10>;
+	clocks = <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
+	clock-names = "mod", "ahb";
+	interrupts = <55>;
+	resets = <&rst WDT_RESET>;
+	reset-names = "wdt_rst";
+	timeout-sec = <30>;
+	alphascale,mode = "hw";
+};
diff --git a/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
new file mode 100644
index 0000000..c15ef0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
@@ -0,0 +1,12 @@
+Ralink Watchdog Timers
+
+Required properties:
+- compatible: must be "mediatek,mt7621-wdt"
+- reg: physical base address of the controller and length of the register range
+
+Example:
+
+	watchdog@100 {
+		compatible = "mediatek,mt7621-wdt";
+		reg = <0x100 0x10>;
+	};
diff --git a/Documentation/devicetree/bindings/watchdog/sigma,smp8642-wdt.txt b/Documentation/devicetree/bindings/watchdog/sigma,smp8642-wdt.txt
new file mode 100644
index 0000000..5b7ec2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sigma,smp8642-wdt.txt
@@ -0,0 +1,18 @@
+Sigma Designs SMP86xx/SMP87xx watchdog
+
+Required properties:
+- compatible: Should be "sigma,smp8642-wdt"
+- reg: Specifies the physical address region
+- clocks: Should be a phandle to the clock
+
+Optional properties:
+- timeout-sec: watchdog timeout in seconds
+
+Example:
+
+watchdog@1fd00 {
+	compatible = "sigma,smp8642-wdt";
+	reg = <0x1fd00 8>;
+	clocks = <&xtal_in_clk>;
+	timeout-sec = <30>;
+};
diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
new file mode 100644
index 0000000..8f6caad
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
@@ -0,0 +1,25 @@
+Technologic Systems Watchdog
+
+Required properties:
+- compatible: must be "technologic,ts4800-wdt"
+- syscon: phandle / integer array that points to the syscon node which
+          describes the FPGA's syscon registers.
+          - phandle to FPGA's syscon
+          - offset to the watchdog register
+
+Optional property:
+- timeout-sec: contains the watchdog timeout in seconds.
+
+Example:
+
+syscon: syscon@b0010000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0xb0010000 0x3d>;
+	reg-io-width = <2>;
+
+	wdt@e {
+		compatible = "technologic,ts4800-wdt";
+		syscon = <&syscon 0xe>;
+		timeout-sec = <10>;
+	};
+}
diff --git a/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt b/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
new file mode 100644
index 0000000..3d87818
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
@@ -0,0 +1,19 @@
+Zodiac RAVE Watchdog Timer
+
+Required properties:
+- compatible: must be "zii,rave-wdt"
+- reg: i2c slave address of device, usually 0x38
+
+Optional Properties:
+- timeout-sec: Watchdog timeout value in seconds.
+- reset-duration-ms: Duration of the pulse generated when the watchdog times
+  out. Value in milliseconds.
+
+Example:
+
+	watchdog@38 {
+		compatible = "zii,rave-wdt";
+		reg = <0x38>;
+		timeout-sec = <30>;
+		reset-duration-ms = <30>;
+	};
diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index d8b0d33..55120a0 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -44,17 +44,18 @@ The watchdog device structure looks like this:
 
 struct watchdog_device {
 	int id;
-	struct cdev cdev;
-	struct device *dev;
 	struct device *parent;
+	const struct attribute_group **groups;
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	struct notifier_block reboot_nb;
+	struct notifier_block restart_nb;
 	void *driver_data;
-	struct mutex lock;
+	struct watchdog_core_data *wd_data;
 	unsigned long status;
 	struct list_head deferred;
 };
@@ -64,27 +65,32 @@ It contains following fields:
   /dev/watchdog0 cdev (dynamic major, minor 0) as well as the old
   /dev/watchdog miscdev. The id is set automatically when calling
   watchdog_register_device.
-* cdev: cdev for the dynamic /dev/watchdog<id> device nodes. This
-  field is also populated by watchdog_register_device.
-* dev: device under the watchdog class (created by watchdog_register_device).
 * parent: set this to the parent device (or NULL) before calling
   watchdog_register_device.
+* groups: List of sysfs attribute groups to create when creating the watchdog
+  device.
 * info: a pointer to a watchdog_info structure. This structure gives some
   additional information about the watchdog timer itself. (Like it's unique name)
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
 * timeout: the watchdog timer's timeout value (in seconds).
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
 * max_timeout: the watchdog timer's maximum timeout value (in seconds).
+* reboot_nb: notifier block that is registered for reboot notifications, for
+  internal use only. If the driver calls watchdog_stop_on_reboot, watchdog core
+  will stop the watchdog on such notifications.
+* restart_nb: notifier block that is registered for machine restart, for
+  internal use only. If a watchdog is capable of restarting the machine, it
+  should define ops->restart. Priority can be changed through
+  watchdog_set_restart_priority.
 * bootstatus: status of the device after booting (reported with watchdog
   WDIOF_* status bits).
 * driver_data: a pointer to the drivers private data of a watchdog device.
   This data should only be accessed via the watchdog_set_drvdata and
   watchdog_get_drvdata routines.
-* lock: Mutex for WatchDog Timer Driver Core internal use only.
+* wd_data: a pointer to watchdog core internal data.
 * status: this field contains a number of status bits that give extra
   information about the status of the device (Like: is the watchdog timer
-  running/active, is the nowayout bit set, is the device opened via
-  the /dev/watchdog interface or not, ...).
+  running/active, or is the nowayout bit set).
 * deferred: entry in wtd_deferred_reg_list which is used to
   register early initialized watchdogs.
 
@@ -100,8 +106,9 @@ struct watchdog_ops {
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
-	void (*ref)(struct watchdog_device *);
-	void (*unref)(struct watchdog_device *);
+	int (*restart)(struct watchdog_device *);
+	void (*ref)(struct watchdog_device *) __deprecated;
+	void (*unref)(struct watchdog_device *) __deprecated;
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
@@ -110,20 +117,6 @@ driver's operations. This module owner will be used to lock the module when
 the watchdog is active. (This to avoid a system crash when you unload the
 module and /dev/watchdog is still open).
 
-If the watchdog_device struct is dynamically allocated, just locking the module
-is not enough and a driver also needs to define the ref and unref operations to
-ensure the structure holding the watchdog_device does not go away.
-
-The simplest (and usually sufficient) implementation of this is to:
-1) Add a kref struct to the same structure which is holding the watchdog_device
-2) Define a release callback for the kref which frees the struct holding both
-3) Call kref_init on this kref *before* calling watchdog_register_device()
-4) Define a ref operation calling kref_get on this kref
-5) Define a unref operation calling kref_put on this kref
-6) When it is time to cleanup:
- * Do not kfree() the struct holding both, the last kref_put will do this!
- * *After* calling watchdog_unregister_device() call kref_put on the kref
-
 Some operations are mandatory and some are optional. The mandatory operations
 are:
 * start: this is a pointer to the routine that starts the watchdog timer
@@ -164,34 +157,23 @@ they are supported. These optional routines/operations are:
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
 * get_timeleft: this routines returns the time that's left before a reset.
-* ref: the operation that calls kref_get on the kref of a dynamically
-  allocated watchdog_device struct.
-* unref: the operation that calls kref_put on the kref of a dynamically
-  allocated watchdog_device struct.
+* restart: this routine restarts the machine. It returns 0 on success or a
+  negative errno code for failure.
 * ioctl: if this routine is present then it will be called first before we do
   our own internal ioctl call handling. This routine should return -ENOIOCTLCMD
   if a command is not supported. The parameters that are passed to the ioctl
   call are: watchdog_device, cmd and arg.
 
+The 'ref' and 'unref' operations are no longer used and deprecated.
+
 The status bits should (preferably) be set with the set_bit and clear_bit alike
 bit-operations. The status bits that are defined are:
 * WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
   is active or not. When the watchdog is active after booting, then you should
   set this status bit (Note: when you register the watchdog timer device with
   this bit set, then opening /dev/watchdog will skip the start operation)
-* WDOG_DEV_OPEN: this status bit shows whether or not the watchdog device
-  was opened via /dev/watchdog.
-  (This bit should only be used by the WatchDog Timer Driver Core).
-* WDOG_ALLOW_RELEASE: this bit stores whether or not the magic close character
-  has been sent (so that we can support the magic close feature).
-  (This bit should only be used by the WatchDog Timer Driver Core).
 * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the watchdog.
   If this bit is set then the watchdog timer will not be able to stop.
-* WDOG_UNREGISTERED: this bit gets set by the WatchDog Timer Driver Core
-  after calling watchdog_unregister_device, and then checked before calling
-  any watchdog_ops, so that you can be sure that no operations (other then
-  unref) will get called after unregister, even if userspace still holds a
-  reference to /dev/watchdog
 
   To set the WDOG_NO_WAY_OUT status bit (before registering your watchdog
   timer device) you can either:
@@ -231,3 +213,18 @@ the device tree (if the module timeout parameter is invalid). Best practice is
 to set the default timeout value as timeout value in the watchdog_device and
 then use this function to set the user "preferred" timeout value.
 This routine returns zero on success and a negative errno code for failure.
+
+To disable the watchdog on reboot, the user must call the following helper:
+
+static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd);
+
+To change the priority of the restart handler the following helper should be
+used:
+
+void watchdog_set_restart_priority(struct watchdog_device *wdd, int priority);
+
+User should follow the following guidelines for setting the priority:
+* 0: should be called in last resort, has limited restart capabilities
+* 128: default restart handler, use if no other handler is expected to be
+  available, and/or if restart is sufficient to restart the entire system
+* 255: highest priority, will preempt all other restart handlers
diff --git a/MAINTAINERS b/MAINTAINERS
index cba790b..b1e3da7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11602,6 +11602,7 @@ F:	drivers/input/tablet/wacom_serial4.c
 
 WATCHDOG DEVICE DRIVERS
 M:	Wim Van Sebroeck <wim@iguana.be>
+R:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-watchdog@vger.kernel.org
 W:	http://www.linux-watchdog.org/
 T:	git git://www.linux-watchdog.org/linux-watchdog.git
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 7386819..68c350c 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -30,7 +30,6 @@
 #include <linux/watchdog.h>
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
-#include <linux/kref.h>
 #include <linux/slab.h>
 #include "sch56xx-common.h"
 
@@ -67,7 +66,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 struct sch56xx_watchdog_data {
 	u16 addr;
 	struct mutex *io_lock;
-	struct kref kref;
 	struct watchdog_info wdinfo;
 	struct watchdog_device wddev;
 	u8 watchdog_preset;
@@ -258,15 +256,6 @@ EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
  * Watchdog routines
  */
 
-/* Release our data struct when we're unregistered *and*
-   all references to our watchdog device are released */
-static void watchdog_release_resources(struct kref *r)
-{
-	struct sch56xx_watchdog_data *data =
-		container_of(r, struct sch56xx_watchdog_data, kref);
-	kfree(data);
-}
-
 static int watchdog_set_timeout(struct watchdog_device *wddev,
 				unsigned int timeout)
 {
@@ -395,28 +384,12 @@ static int watchdog_stop(struct watchdog_device *wddev)
 	return 0;
 }
 
-static void watchdog_ref(struct watchdog_device *wddev)
-{
-	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
-
-	kref_get(&data->kref);
-}
-
-static void watchdog_unref(struct watchdog_device *wddev)
-{
-	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
-
-	kref_put(&data->kref, watchdog_release_resources);
-}
-
 static const struct watchdog_ops watchdog_ops = {
 	.owner		= THIS_MODULE,
 	.start		= watchdog_start,
 	.stop		= watchdog_stop,
 	.ping		= watchdog_trigger,
 	.set_timeout	= watchdog_set_timeout,
-	.ref		= watchdog_ref,
-	.unref		= watchdog_unref,
 };
 
 struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
@@ -448,7 +421,6 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
 
 	data->addr = addr;
 	data->io_lock = io_lock;
-	kref_init(&data->kref);
 
 	strlcpy(data->wdinfo.identity, "sch56xx watchdog",
 		sizeof(data->wdinfo.identity));
@@ -494,8 +466,7 @@ EXPORT_SYMBOL(sch56xx_watchdog_register);
 void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data)
 {
 	watchdog_unregister_device(&data->wddev);
-	kref_put(&data->kref, watchdog_release_resources);
-	/* Don't touch data after this it may have been free-ed! */
+	kfree(data);
 }
 EXPORT_SYMBOL(sch56xx_watchdog_unregister);
 
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1c427be..4f0e7be 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -46,6 +46,13 @@ config WATCHDOG_NOWAYOUT
 	  get killed. If you say Y here, the watchdog cannot be stopped once
 	  it has been started.
 
+config WATCHDOG_SYSFS
+	bool "Read different watchdog information through sysfs"
+	default n
+	help
+	  Say Y here if you want to enable watchdog device status read through
+	  sysfs attributes.
+
 #
 # General Watchdog drivers
 #
@@ -135,6 +142,16 @@ config MENF21BMC_WATCHDOG
 	  This driver can also be built as a module. If so the module
 	  will be called menf21bmc_wdt.
 
+config TANGOX_WATCHDOG
+	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
+	select WATCHDOG_CORE
+	depends on ARCH_TANGOX || COMPILE_TEST
+	help
+	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
+	  and SMP87xx (tango4) family chips.
+
+	  This driver can be built as a module. The module name is tangox_wdt.
+
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
 	depends on MFD_WM831X
@@ -161,6 +178,17 @@ config XILINX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called of_xilinx_wdt.
 
+config ZIIRAVE_WATCHDOG
+	tristate "Zodiac RAVE Watchdog Timer"
+	depends on I2C
+	select WATCHDOG_CORE
+	help
+	  Watchdog driver for the Zodiac Aerospace RAVE Switch Watchdog
+	  Processor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ziirave_wdt.
+
 # ALPHA Architecture
 
 # ARM Architecture
@@ -173,6 +201,16 @@ config ARM_SP805_WATCHDOG
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
 	  the timeout is reached.
 
+config ASM9260_WATCHDOG
+	tristate "Alphascale ASM9260 watchdog"
+	depends on MACH_ASM9260
+	depends on OF
+	select WATCHDOG_CORE
+	select RESET_CONTROLLER
+	help
+	  Watchdog timer embedded into Alphascale asm9260 chips. This will reboot your
+	  system when the timeout is reached.
+
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
 	depends on SOC_AT91RM9200 && MFD_SYSCON
@@ -426,6 +464,16 @@ config NUC900_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called nuc900_wdt.
 
+config TS4800_WATCHDOG
+	tristate "TS-4800 Watchdog"
+	depends on HAS_IOMEM && OF
+	select WATCHDOG_CORE
+	select MFD_SYSCON
+	help
+	  Technologic Systems TS-4800 has watchdog timer implemented in
+	  an external FPGA. Say Y here if you want to support for the
+	  watchdog timer on TS-4800 board.
+
 config TS72XX_WATCHDOG
 	tristate "TS-72XX SBC Watchdog"
 	depends on MACH_TS72XX
@@ -578,6 +626,16 @@ config LPC18XX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called lpc18xx_wdt.
 
+config ATLAS7_WATCHDOG
+	tristate "CSRatlas7 watchdog"
+	depends on ARCH_ATLAS7
+	help
+	  Say Y here to include Watchdog timer support for the watchdog
+	  existing on the CSRatlas7 series platforms.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called atlas7_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
@@ -1345,6 +1403,13 @@ config RALINK_WDT
 	help
 	  Hardware driver for the Ralink SoC Watchdog Timer.
 
+config MT7621_WDT
+	tristate "Mediatek SoC watchdog"
+	select WATCHDOG_CORE
+	depends on SOC_MT7620 || SOC_MT7621
+	help
+	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
+
 # PARISC Architecture
 
 # POWERPC Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 53d4827..f566753 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 
 # ARM Architecture
 obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
+obj-$(CONFIG_ASM9260_WATCHDOG) += asm9260_wdt.o
 obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
 obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
 obj-$(CONFIG_CADENCE_WATCHDOG) += cadence_wdt.o
@@ -53,6 +54,7 @@ obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
 obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
 obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
+obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
 obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
 obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
@@ -69,6 +71,7 @@ obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
+obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
@@ -149,6 +152,7 @@ octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
 obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
 obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
 obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
+obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
 
 # PARISC Architecture
 
@@ -187,8 +191,10 @@ obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
 obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
 obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
 obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
+obj-$(CONFIG_TANGOX_WATCHDOG) += tangox_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
 obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
 obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
+obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
new file mode 100644
index 0000000..c9686b2
--- /dev/null
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -0,0 +1,403 @@
+/*
+ * Watchdog driver for Alphascale ASM9260.
+ *
+ * Copyright (c) 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/reset.h>
+#include <linux/watchdog.h>
+
+#define CLOCK_FREQ	1000000
+
+/* Watchdog Mode register */
+#define HW_WDMOD			0x00
+/* Wake interrupt. Set by HW, can't be cleared. */
+#define BM_MOD_WDINT			BIT(3)
+/* This bit set if timeout reached. Cleared by SW. */
+#define BM_MOD_WDTOF			BIT(2)
+/* HW Reset on timeout */
+#define BM_MOD_WDRESET			BIT(1)
+/* WD enable */
+#define BM_MOD_WDEN			BIT(0)
+
+/*
+ * Watchdog Timer Constant register
+ * Minimal value is 0xff, the meaning of this value
+ * depends on used clock: T = WDCLK * (0xff + 1) * 4
+ */
+#define HW_WDTC				0x04
+#define BM_WDTC_MAX(freq)		(0x7fffffff / (freq))
+
+/* Watchdog Feed register */
+#define HW_WDFEED			0x08
+
+/* Watchdog Timer Value register */
+#define HW_WDTV				0x0c
+
+#define ASM9260_WDT_DEFAULT_TIMEOUT	30
+
+enum asm9260_wdt_mode {
+	HW_RESET,
+	SW_RESET,
+	DEBUG,
+};
+
+struct asm9260_wdt_priv {
+	struct device		*dev;
+	struct watchdog_device	wdd;
+	struct clk		*clk;
+	struct clk		*clk_ahb;
+	struct reset_control	*rst;
+	struct notifier_block	restart_handler;
+
+	void __iomem		*iobase;
+	int			irq;
+	unsigned long		wdt_freq;
+	enum asm9260_wdt_mode	mode;
+};
+
+static int asm9260_wdt_feed(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	iowrite32(0xaa, priv->iobase + HW_WDFEED);
+	iowrite32(0x55, priv->iobase + HW_WDFEED);
+
+	return 0;
+}
+
+static unsigned int asm9260_wdt_gettimeleft(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+	u32 counter;
+
+	counter = ioread32(priv->iobase + HW_WDTV);
+
+	return DIV_ROUND_CLOSEST(counter, priv->wdt_freq);
+}
+
+static int asm9260_wdt_updatetimeout(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+	u32 counter;
+
+	counter = wdd->timeout * priv->wdt_freq;
+
+	iowrite32(counter, priv->iobase + HW_WDTC);
+
+	return 0;
+}
+
+static int asm9260_wdt_enable(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+	u32 mode = 0;
+
+	if (priv->mode == HW_RESET)
+		mode = BM_MOD_WDRESET;
+
+	iowrite32(BM_MOD_WDEN | mode, priv->iobase + HW_WDMOD);
+
+	asm9260_wdt_updatetimeout(wdd);
+
+	asm9260_wdt_feed(wdd);
+
+	return 0;
+}
+
+static int asm9260_wdt_disable(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	/* The only way to disable WD is to reset it. */
+	reset_control_assert(priv->rst);
+	reset_control_deassert(priv->rst);
+
+	return 0;
+}
+
+static int asm9260_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
+{
+	wdd->timeout = to;
+	asm9260_wdt_updatetimeout(wdd);
+
+	return 0;
+}
+
+static void asm9260_wdt_sys_reset(struct asm9260_wdt_priv *priv)
+{
+	/* init WD if it was not started */
+
+	iowrite32(BM_MOD_WDEN | BM_MOD_WDRESET, priv->iobase + HW_WDMOD);
+
+	iowrite32(0xff, priv->iobase + HW_WDTC);
+	/* first pass correct sequence */
+	asm9260_wdt_feed(&priv->wdd);
+	/*
+	 * Then write wrong pattern to the feed to trigger reset
+	 * ASAP.
+	 */
+	iowrite32(0xff, priv->iobase + HW_WDFEED);
+
+	mdelay(1000);
+}
+
+static irqreturn_t asm9260_wdt_irq(int irq, void *devid)
+{
+	struct asm9260_wdt_priv *priv = devid;
+	u32 stat;
+
+	stat = ioread32(priv->iobase + HW_WDMOD);
+	if (!(stat & BM_MOD_WDINT))
+		return IRQ_NONE;
+
+	if (priv->mode == DEBUG) {
+		dev_info(priv->dev, "Watchdog Timeout. Do nothing.\n");
+	} else {
+		dev_info(priv->dev, "Watchdog Timeout. Doing SW Reset.\n");
+		asm9260_wdt_sys_reset(priv);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int asm9260_restart_handler(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	struct asm9260_wdt_priv *priv =
+		container_of(this, struct asm9260_wdt_priv, restart_handler);
+
+	asm9260_wdt_sys_reset(priv);
+
+	return NOTIFY_DONE;
+}
+
+static const struct watchdog_info asm9260_wdt_ident = {
+	.options          =     WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING
+				| WDIOF_MAGICCLOSE,
+	.identity         =	"Alphascale asm9260 Watchdog",
+};
+
+static struct watchdog_ops asm9260_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= asm9260_wdt_enable,
+	.stop		= asm9260_wdt_disable,
+	.get_timeleft	= asm9260_wdt_gettimeleft,
+	.ping		= asm9260_wdt_feed,
+	.set_timeout	= asm9260_wdt_settimeout,
+};
+
+static int asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
+{
+	int err;
+	unsigned long clk;
+
+	priv->clk = devm_clk_get(priv->dev, "mod");
+	if (IS_ERR(priv->clk)) {
+		dev_err(priv->dev, "Failed to get \"mod\" clk\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	/* configure AHB clock */
+	priv->clk_ahb = devm_clk_get(priv->dev, "ahb");
+	if (IS_ERR(priv->clk_ahb)) {
+		dev_err(priv->dev, "Failed to get \"ahb\" clk\n");
+		return PTR_ERR(priv->clk_ahb);
+	}
+
+	err = clk_prepare_enable(priv->clk_ahb);
+	if (err) {
+		dev_err(priv->dev, "Failed to enable ahb_clk!\n");
+		return err;
+	}
+
+	err = clk_set_rate(priv->clk, CLOCK_FREQ);
+	if (err) {
+		clk_disable_unprepare(priv->clk_ahb);
+		dev_err(priv->dev, "Failed to set rate!\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(priv->clk);
+	if (err) {
+		clk_disable_unprepare(priv->clk_ahb);
+		dev_err(priv->dev, "Failed to enable clk!\n");
+		return err;
+	}
+
+	/* wdt has internal divider */
+	clk = clk_get_rate(priv->clk);
+	if (!clk) {
+		clk_disable_unprepare(priv->clk);
+		clk_disable_unprepare(priv->clk_ahb);
+		dev_err(priv->dev, "Failed, clk is 0!\n");
+		return -EINVAL;
+	}
+
+	priv->wdt_freq = clk / 2;
+
+	return 0;
+}
+
+static void asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
+{
+	const char *tmp;
+	int ret;
+
+	/* default mode */
+	priv->mode = HW_RESET;
+
+	ret = of_property_read_string(priv->dev->of_node,
+				      "alphascale,mode", &tmp);
+	if (ret < 0)
+		return;
+
+	if (!strcmp(tmp, "hw"))
+		priv->mode = HW_RESET;
+	else if (!strcmp(tmp, "sw"))
+		priv->mode = SW_RESET;
+	else if (!strcmp(tmp, "debug"))
+		priv->mode = DEBUG;
+	else
+		dev_warn(priv->dev, "unknown reset-type: %s. Using default \"hw\" mode.",
+			 tmp);
+}
+
+static int asm9260_wdt_probe(struct platform_device *pdev)
+{
+	struct asm9260_wdt_priv *priv;
+	struct watchdog_device *wdd;
+	struct resource *res;
+	int ret;
+	const char * const mode_name[] = { "hw", "sw", "debug", };
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct asm9260_wdt_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->iobase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->iobase))
+		return PTR_ERR(priv->iobase);
+
+	ret = asm9260_wdt_get_dt_clks(priv);
+	if (ret)
+		return ret;
+
+	priv->rst = devm_reset_control_get(&pdev->dev, "wdt_rst");
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	wdd = &priv->wdd;
+	wdd->info = &asm9260_wdt_ident;
+	wdd->ops = &asm9260_wdt_ops;
+	wdd->min_timeout = 1;
+	wdd->max_timeout = BM_WDTC_MAX(priv->wdt_freq);
+	wdd->parent = &pdev->dev;
+
+	watchdog_set_drvdata(wdd, priv);
+
+	/*
+	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
+	 * default, unless the max timeout is less than 30 seconds, then use
+	 * the max instead.
+	 */
+	wdd->timeout = ASM9260_WDT_DEFAULT_TIMEOUT;
+	watchdog_init_timeout(wdd, 0, &pdev->dev);
+
+	asm9260_wdt_get_dt_mode(priv);
+
+	if (priv->mode != HW_RESET)
+		priv->irq = platform_get_irq(pdev, 0);
+
+	if (priv->irq > 0) {
+		/*
+		 * Not all supported platforms specify an interrupt for the
+		 * watchdog, so let's make it optional.
+		 */
+		ret = devm_request_irq(&pdev->dev, priv->irq,
+				       asm9260_wdt_irq, 0, pdev->name, priv);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "failed to request IRQ\n");
+	}
+
+	ret = watchdog_register_device(wdd);
+	if (ret)
+		goto clk_off;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->restart_handler.notifier_call = asm9260_restart_handler;
+	priv->restart_handler.priority = 128;
+	ret = register_restart_handler(&priv->restart_handler);
+	if (ret)
+		dev_warn(&pdev->dev, "cannot register restart handler\n");
+
+	dev_info(&pdev->dev, "Watchdog enabled (timeout: %d sec, mode: %s)\n",
+		 wdd->timeout, mode_name[priv->mode]);
+	return 0;
+
+clk_off:
+	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_ahb);
+	return ret;
+}
+
+static void asm9260_wdt_shutdown(struct platform_device *pdev)
+{
+	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	asm9260_wdt_disable(&priv->wdd);
+}
+
+static int asm9260_wdt_remove(struct platform_device *pdev)
+{
+	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	asm9260_wdt_disable(&priv->wdd);
+
+	unregister_restart_handler(&priv->restart_handler);
+
+	watchdog_unregister_device(&priv->wdd);
+
+	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_ahb);
+
+	return 0;
+}
+
+static const struct of_device_id asm9260_wdt_of_match[] = {
+	{ .compatible = "alphascale,asm9260-wdt"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, asm9260_wdt_of_match);
+
+static struct platform_driver asm9260_wdt_driver = {
+	.driver = {
+		.name = "asm9260-wdt",
+		.owner = THIS_MODULE,
+		.of_match_table	= asm9260_wdt_of_match,
+	},
+	.probe = asm9260_wdt_probe,
+	.remove = asm9260_wdt_remove,
+	.shutdown = asm9260_wdt_shutdown,
+};
+module_platform_driver(asm9260_wdt_driver);
+
+MODULE_DESCRIPTION("asm9260 WatchDog Timer Driver");
+MODULE_AUTHOR("Oleksij Rempel <linux@rempel-privat.de>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
new file mode 100644
index 0000000..df6d924
--- /dev/null
+++ b/drivers/watchdog/atlas7_wdt.c
@@ -0,0 +1,242 @@
+/*
+ * Watchdog driver for CSR Atlas7
+ *
+ * Copyright (c) 2015 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+#define ATLAS7_TIMER_WDT_INDEX		5
+#define ATLAS7_WDT_DEFAULT_TIMEOUT	20
+
+#define ATLAS7_WDT_CNT_CTRL	(0 + 4 * ATLAS7_TIMER_WDT_INDEX)
+#define ATLAS7_WDT_CNT_MATCH	(0x18 + 4 * ATLAS7_TIMER_WDT_INDEX)
+#define ATLAS7_WDT_CNT		(0x48 +  4 * ATLAS7_TIMER_WDT_INDEX)
+#define ATLAS7_WDT_CNT_EN	(BIT(0) | BIT(1))
+#define ATLAS7_WDT_EN		0x64
+
+static unsigned int timeout = ATLAS7_WDT_DEFAULT_TIMEOUT;
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+module_param(timeout, uint, 0);
+module_param(nowayout, bool, 0);
+
+MODULE_PARM_DESC(timeout, "Default watchdog timeout (in seconds)");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct atlas7_wdog {
+	struct device *dev;
+	void __iomem *base;
+	unsigned long tick_rate;
+	struct clk *clk;
+};
+
+static unsigned int atlas7_wdt_gettimeleft(struct watchdog_device *wdd)
+{
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+	u32 counter, match, delta;
+
+	counter = readl(wdt->base + ATLAS7_WDT_CNT);
+	match = readl(wdt->base + ATLAS7_WDT_CNT_MATCH);
+	delta = match - counter;
+
+	return  delta / wdt->tick_rate;
+}
+
+static int atlas7_wdt_ping(struct watchdog_device *wdd)
+{
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+	u32 counter, match, delta;
+
+	counter = readl(wdt->base + ATLAS7_WDT_CNT);
+	delta = wdd->timeout * wdt->tick_rate;
+	match = counter + delta;
+
+	writel(match, wdt->base + ATLAS7_WDT_CNT_MATCH);
+
+	return 0;
+}
+
+static int atlas7_wdt_enable(struct watchdog_device *wdd)
+{
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+
+	atlas7_wdt_ping(wdd);
+
+	writel(readl(wdt->base + ATLAS7_WDT_CNT_CTRL) | ATLAS7_WDT_CNT_EN,
+	      wdt->base + ATLAS7_WDT_CNT_CTRL);
+	writel(1, wdt->base + ATLAS7_WDT_EN);
+
+	return 0;
+}
+
+static int atlas7_wdt_disable(struct watchdog_device *wdd)
+{
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+
+	writel(0, wdt->base + ATLAS7_WDT_EN);
+	writel(readl(wdt->base + ATLAS7_WDT_CNT_CTRL) & ~ATLAS7_WDT_CNT_EN,
+	      wdt->base + ATLAS7_WDT_CNT_CTRL);
+
+	return 0;
+}
+
+static int atlas7_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
+{
+	wdd->timeout = to;
+
+	return 0;
+}
+
+#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
+
+static const struct watchdog_info atlas7_wdt_ident = {
+	.options = OPTIONS,
+	.firmware_version = 0,
+	.identity = "atlas7 Watchdog",
+};
+
+static struct watchdog_ops atlas7_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = atlas7_wdt_enable,
+	.stop = atlas7_wdt_disable,
+	.get_timeleft = atlas7_wdt_gettimeleft,
+	.ping = atlas7_wdt_ping,
+	.set_timeout = atlas7_wdt_settimeout,
+};
+
+static struct watchdog_device atlas7_wdd = {
+	.info = &atlas7_wdt_ident,
+	.ops = &atlas7_wdt_ops,
+	.timeout = ATLAS7_WDT_DEFAULT_TIMEOUT,
+};
+
+static const struct of_device_id atlas7_wdt_ids[] = {
+	{ .compatible = "sirf,atlas7-tick"},
+	{}
+};
+
+static int atlas7_wdt_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct atlas7_wdog *wdt;
+	struct resource *res;
+	struct clk *clk;
+	int ret;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&pdev->dev, "clk enable failed\n");
+		goto err;
+	}
+
+	/* disable watchdog hardware */
+	writel(0, wdt->base + ATLAS7_WDT_CNT_CTRL);
+
+	wdt->tick_rate = clk_get_rate(clk);
+	wdt->clk = clk;
+	atlas7_wdd.min_timeout = 1;
+	atlas7_wdd.max_timeout = UINT_MAX / wdt->tick_rate;
+
+	watchdog_init_timeout(&atlas7_wdd, 0, &pdev->dev);
+	watchdog_set_nowayout(&atlas7_wdd, nowayout);
+
+	watchdog_set_drvdata(&atlas7_wdd, wdt);
+	platform_set_drvdata(pdev, &atlas7_wdd);
+
+	ret = watchdog_register_device(&atlas7_wdd);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	clk_disable_unprepare(clk);
+err:
+	clk_put(clk);
+	return ret;
+}
+
+static void atlas7_wdt_shutdown(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+
+	atlas7_wdt_disable(wdd);
+	clk_disable_unprepare(wdt->clk);
+}
+
+static int atlas7_wdt_remove(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
+
+	atlas7_wdt_shutdown(pdev);
+	clk_put(wdt->clk);
+	return 0;
+}
+
+static int __maybe_unused atlas7_wdt_suspend(struct device *dev)
+{
+	/*
+	 * NOTE:timer controller registers settings are saved
+	 * and restored back by the timer-atlas7.c
+	 */
+	return 0;
+}
+
+static int __maybe_unused atlas7_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	/*
+	 * NOTE: Since timer controller registers settings are saved
+	 * and restored back by the timer-atlas7.c, so we need not
+	 * update WD settings except refreshing timeout.
+	 */
+	atlas7_wdt_ping(wdd);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(atlas7_wdt_pm_ops,
+		atlas7_wdt_suspend, atlas7_wdt_resume);
+
+MODULE_DEVICE_TABLE(of, atlas7_wdt_ids);
+
+static struct platform_driver atlas7_wdt_driver = {
+	.driver = {
+		.name = "atlas7-wdt",
+		.pm = &atlas7_wdt_pm_ops,
+		.of_match_table	= atlas7_wdt_ids,
+	},
+	.probe = atlas7_wdt_probe,
+	.remove = atlas7_wdt_remove,
+	.shutdown = atlas7_wdt_shutdown,
+};
+module_platform_driver(atlas7_wdt_driver);
+
+MODULE_DESCRIPTION("CSRatlas7 watchdog driver");
+MODULE_AUTHOR("Guo Zeng <Guo.Zeng@csr.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:atlas7-wdt");
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 8a5ce5b..2e6164c 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -79,7 +79,6 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
 	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
 
 	writel_relaxed(PM_PASSWORD | PM_RSTC_RESET, wdt->base + PM_RSTC);
-	dev_info(wdog->dev, "Watchdog timer stopped");
 	return 0;
 }
 
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 4064a43..df1c2a4 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/timer.h>
@@ -88,12 +87,22 @@ static int bcm47xx_wdt_hard_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static int bcm47xx_wdt_restart(struct watchdog_device *wdd)
+{
+	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
+
+	wdt->timer_set(wdt, 1);
+
+	return 0;
+}
+
 static struct watchdog_ops bcm47xx_wdt_hard_ops = {
 	.owner		= THIS_MODULE,
 	.start		= bcm47xx_wdt_hard_start,
 	.stop		= bcm47xx_wdt_hard_stop,
 	.ping		= bcm47xx_wdt_hard_keepalive,
 	.set_timeout	= bcm47xx_wdt_hard_set_timeout,
+	.restart        = bcm47xx_wdt_restart,
 };
 
 static void bcm47xx_wdt_soft_timer_tick(unsigned long data)
@@ -158,34 +167,13 @@ static const struct watchdog_info bcm47xx_wdt_info = {
 				WDIOF_MAGICCLOSE,
 };
 
-static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
-				  unsigned long code, void *unused)
-{
-	struct bcm47xx_wdt *wdt;
-
-	wdt = container_of(this, struct bcm47xx_wdt, notifier);
-	if (code == SYS_DOWN || code == SYS_HALT)
-		wdt->wdd.ops->stop(&wdt->wdd);
-	return NOTIFY_DONE;
-}
-
-static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned long mode,
-			       void *cmd)
-{
-	struct bcm47xx_wdt *wdt;
-
-	wdt = container_of(this, struct bcm47xx_wdt, restart_handler);
-	wdt->timer_set(wdt, 1);
-
-	return NOTIFY_DONE;
-}
-
 static struct watchdog_ops bcm47xx_wdt_soft_ops = {
 	.owner		= THIS_MODULE,
 	.start		= bcm47xx_wdt_soft_start,
 	.stop		= bcm47xx_wdt_soft_stop,
 	.ping		= bcm47xx_wdt_soft_keepalive,
 	.set_timeout	= bcm47xx_wdt_soft_set_timeout,
+	.restart        = bcm47xx_wdt_restart,
 };
 
 static int bcm47xx_wdt_probe(struct platform_device *pdev)
@@ -214,32 +202,18 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_timer;
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
-
-	wdt->notifier.notifier_call = &bcm47xx_wdt_notify_sys;
-
-	ret = register_reboot_notifier(&wdt->notifier);
-	if (ret)
-		goto err_timer;
-
-	wdt->restart_handler.notifier_call = &bcm47xx_wdt_restart;
-	wdt->restart_handler.priority = 64;
-	ret = register_restart_handler(&wdt->restart_handler);
-	if (ret)
-		goto err_notifier;
+	watchdog_set_restart_priority(&wdt->wdd, 64);
+	watchdog_stop_on_reboot(&wdt->wdd);
 
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret)
-		goto err_handler;
+		goto err_timer;
 
 	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
 		timeout, nowayout ? ", nowayout" : "",
 		soft ? ", Software Timer" : "");
 	return 0;
 
-err_handler:
-	unregister_restart_handler(&wdt->restart_handler);
-err_notifier:
-	unregister_reboot_notifier(&wdt->notifier);
 err_timer:
 	if (soft)
 		del_timer_sync(&wdt->soft_timer);
@@ -255,7 +229,6 @@ static int bcm47xx_wdt_remove(struct platform_device *pdev)
 		return -ENXIO;
 
 	watchdog_unregister_device(&wdt->wdd);
-	unregister_reboot_notifier(&wdt->notifier);
 
 	return 0;
 }
diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index bcfd2a2..4dda902 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #define CDNS_WDT_DEFAULT_TIMEOUT	10
@@ -72,7 +71,6 @@ MODULE_PARM_DESC(nowayout,
  * @ctrl_clksel: counter clock prescaler selection
  * @io_lock: spinlock for IO register access
  * @cdns_wdt_device: watchdog device structure
- * @cdns_wdt_notifier: notifier structure
  *
  * Structure containing parameters specific to cadence watchdog.
  */
@@ -84,7 +82,6 @@ struct cdns_wdt {
 	u32			ctrl_clksel;
 	spinlock_t		io_lock;
 	struct watchdog_device	cdns_wdt_device;
-	struct notifier_block	cdns_wdt_notifier;
 };
 
 /* Write access to Registers */
@@ -280,29 +277,6 @@ static struct watchdog_ops cdns_wdt_ops = {
 	.set_timeout = cdns_wdt_settimeout,
 };
 
-/**
- * cdns_wdt_notify_sys - Notifier for reboot or shutdown.
- *
- * @this: handle to notifier block
- * @code: turn off indicator
- * @unused: unused
- * Return: NOTIFY_DONE
- *
- * This notifier is invoked whenever the system reboot or shutdown occur
- * because we need to disable the WDT before system goes down as WDT might
- * reset on the next boot.
- */
-static int cdns_wdt_notify_sys(struct notifier_block *this, unsigned long code,
-			       void *unused)
-{
-	struct cdns_wdt *wdt = container_of(this, struct cdns_wdt,
-					    cdns_wdt_notifier);
-	if (code == SYS_DOWN || code == SYS_HALT)
-		cdns_wdt_stop(&wdt->cdns_wdt_device);
-
-	return NOTIFY_DONE;
-}
-
 /************************Platform Operations*****************************/
 /**
  * cdns_wdt_probe - Probe call for the device.
@@ -360,6 +334,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	}
 
 	watchdog_set_nowayout(cdns_wdt_device, nowayout);
+	watchdog_stop_on_reboot(cdns_wdt_device);
 	watchdog_set_drvdata(cdns_wdt_device, wdt);
 
 	wdt->clk = devm_clk_get(&pdev->dev, NULL);
@@ -386,14 +361,6 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 
 	spin_lock_init(&wdt->io_lock);
 
-	wdt->cdns_wdt_notifier.notifier_call = &cdns_wdt_notify_sys;
-	ret = register_reboot_notifier(&wdt->cdns_wdt_notifier);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "cannot register reboot notifier err=%d)\n",
-			ret);
-		goto err_clk_disable;
-	}
-
 	ret = watchdog_register_device(cdns_wdt_device);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register wdt device\n");
@@ -427,7 +394,6 @@ static int cdns_wdt_remove(struct platform_device *pdev)
 
 	cdns_wdt_stop(&wdt->cdns_wdt_device);
 	watchdog_unregister_device(&wdt->cdns_wdt_device);
-	unregister_reboot_notifier(&wdt->cdns_wdt_notifier);
 	clk_disable_unprepare(wdt->clk);
 
 	return 0;
@@ -455,8 +421,7 @@ static void cdns_wdt_shutdown(struct platform_device *pdev)
  */
 static int __maybe_unused cdns_wdt_suspend(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
 
 	cdns_wdt_stop(&wdt->cdns_wdt_device);
@@ -474,8 +439,7 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
 static int __maybe_unused cdns_wdt_resume(struct device *dev)
 {
 	int ret;
-	struct platform_device *pdev = container_of(dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
 
 	ret = clk_prepare_enable(wdt->clk);
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 67e6797..2fc19a3 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -31,7 +31,6 @@
 struct da9052_wdt_data {
 	struct watchdog_device wdt;
 	struct da9052 *da9052;
-	struct kref kref;
 	unsigned long jpast;
 };
 
@@ -51,10 +50,6 @@ static const struct {
 };
 
 
-static void da9052_wdt_release_resources(struct kref *r)
-{
-}
-
 static int da9052_wdt_set_timeout(struct watchdog_device *wdt_dev,
 				  unsigned int timeout)
 {
@@ -104,20 +99,6 @@ static int da9052_wdt_set_timeout(struct watchdog_device *wdt_dev,
 	return 0;
 }
 
-static void da9052_wdt_ref(struct watchdog_device *wdt_dev)
-{
-	struct da9052_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
-
-	kref_get(&driver_data->kref);
-}
-
-static void da9052_wdt_unref(struct watchdog_device *wdt_dev)
-{
-	struct da9052_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
-
-	kref_put(&driver_data->kref, da9052_wdt_release_resources);
-}
-
 static int da9052_wdt_start(struct watchdog_device *wdt_dev)
 {
 	return da9052_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
@@ -170,8 +151,6 @@ static const struct watchdog_ops da9052_wdt_ops = {
 	.stop = da9052_wdt_stop,
 	.ping = da9052_wdt_ping,
 	.set_timeout = da9052_wdt_set_timeout,
-	.ref = da9052_wdt_ref,
-	.unref = da9052_wdt_unref,
 };
 
 
@@ -198,8 +177,6 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	da9052_wdt->parent = &pdev->dev;
 	watchdog_set_drvdata(da9052_wdt, driver_data);
 
-	kref_init(&driver_data->kref);
-
 	ret = da9052_reg_update(da9052, DA9052_CONTROL_D_REG,
 				DA9052_CONTROLD_TWDSCALE, 0);
 	if (ret < 0) {
@@ -225,7 +202,6 @@ static int da9052_wdt_remove(struct platform_device *pdev)
 	struct da9052_wdt_data *driver_data = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&driver_data->wdt);
-	kref_put(&driver_data->kref, da9052_wdt_release_resources);
 
 	return 0;
 }
diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 04d1430..8377c43 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -35,7 +35,6 @@ MODULE_PARM_DESC(nowayout,
 struct da9055_wdt_data {
 	struct watchdog_device wdt;
 	struct da9055 *da9055;
-	struct kref kref;
 };
 
 static const struct {
@@ -99,24 +98,6 @@ static int da9055_wdt_ping(struct watchdog_device *wdt_dev)
 				 DA9055_WATCHDOG_MASK, 1);
 }
 
-static void da9055_wdt_release_resources(struct kref *r)
-{
-}
-
-static void da9055_wdt_ref(struct watchdog_device *wdt_dev)
-{
-	struct da9055_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
-
-	kref_get(&driver_data->kref);
-}
-
-static void da9055_wdt_unref(struct watchdog_device *wdt_dev)
-{
-	struct da9055_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
-
-	kref_put(&driver_data->kref, da9055_wdt_release_resources);
-}
-
 static int da9055_wdt_start(struct watchdog_device *wdt_dev)
 {
 	return da9055_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
@@ -138,8 +119,6 @@ static const struct watchdog_ops da9055_wdt_ops = {
 	.stop = da9055_wdt_stop,
 	.ping = da9055_wdt_ping,
 	.set_timeout = da9055_wdt_set_timeout,
-	.ref = da9055_wdt_ref,
-	.unref = da9055_wdt_unref,
 };
 
 static int da9055_wdt_probe(struct platform_device *pdev)
@@ -165,8 +144,6 @@ static int da9055_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(da9055_wdt, nowayout);
 	watchdog_set_drvdata(da9055_wdt, driver_data);
 
-	kref_init(&driver_data->kref);
-
 	ret = da9055_wdt_stop(da9055_wdt);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to stop watchdog, %d\n", ret);
@@ -189,7 +166,6 @@ static int da9055_wdt_remove(struct platform_device *pdev)
 	struct da9055_wdt_data *driver_data = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&driver_data->wdt);
-	kref_put(&driver_data->kref, da9055_wdt_release_resources);
 
 	return 0;
 }
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 6bf130b..11e8875 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/mfd/da9063/registers.h>
 #include <linux/mfd/da9063/core.h>
-#include <linux/reboot.h>
 #include <linux/regmap.h>
 
 /*
@@ -39,7 +38,6 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 struct da9063_watchdog {
 	struct da9063 *da9063;
 	struct watchdog_device wdtdev;
-	struct notifier_block restart_handler;
 };
 
 static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
@@ -121,12 +119,9 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	return ret;
 }
 
-static int da9063_wdt_restart_handler(struct notifier_block *this,
-				      unsigned long mode, void *cmd)
+static int da9063_wdt_restart(struct watchdog_device *wdd)
 {
-	struct da9063_watchdog *wdt = container_of(this,
-						   struct da9063_watchdog,
-						   restart_handler);
+	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
 
 	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
@@ -135,7 +130,7 @@ static int da9063_wdt_restart_handler(struct notifier_block *this,
 		dev_alert(wdt->da9063->dev, "Failed to shutdown (err = %d)\n",
 			  ret);
 
-	return NOTIFY_DONE;
+	return ret;
 }
 
 static const struct watchdog_info da9063_watchdog_info = {
@@ -149,6 +144,7 @@ static const struct watchdog_ops da9063_watchdog_ops = {
 	.stop = da9063_wdt_stop,
 	.ping = da9063_wdt_ping,
 	.set_timeout = da9063_wdt_set_timeout,
+	.restart = da9063_wdt_restart,
 };
 
 static int da9063_wdt_probe(struct platform_device *pdev)
@@ -179,6 +175,8 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
+	watchdog_set_restart_priority(&wdt->wdtdev, 128);
+
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 	dev_set_drvdata(&pdev->dev, wdt);
 
@@ -186,13 +184,6 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	wdt->restart_handler.notifier_call = da9063_wdt_restart_handler;
-	wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&wdt->restart_handler);
-	if (ret)
-		dev_err(wdt->da9063->dev,
-			"Failed to register restart handler (err = %d)\n", ret);
-
 	return 0;
 }
 
@@ -200,8 +191,6 @@ static int da9063_wdt_remove(struct platform_device *pdev)
 {
 	struct da9063_watchdog *wdt = dev_get_drvdata(&pdev->dev);
 
-	unregister_restart_handler(&wdt->restart_handler);
-
 	watchdog_unregister_device(&wdt->wdtdev);
 
 	return 0;
diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 3db9d0e..861d3d3 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -106,6 +106,10 @@ static int __diag288_lpar(unsigned int func, unsigned int timeout,
 	return __diag288(func, timeout, action, 0);
 }
 
+static unsigned long wdt_status;
+
+#define DIAG_WDOG_BUSY	0
+
 static int wdt_start(struct watchdog_device *dev)
 {
 	char *ebc_cmd;
@@ -113,12 +117,17 @@ static int wdt_start(struct watchdog_device *dev)
 	int ret;
 	unsigned int func;
 
+	if (test_and_set_bit(DIAG_WDOG_BUSY, &wdt_status))
+		return -EBUSY;
+
 	ret = -ENODEV;
 
 	if (MACHINE_IS_VM) {
 		ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
-		if (!ebc_cmd)
+		if (!ebc_cmd) {
+			clear_bit(DIAG_WDOG_BUSY, &wdt_status);
 			return -ENOMEM;
+		}
 		len = strlcpy(ebc_cmd, wdt_cmd, MAX_CMDLEN);
 		ASCEBC(ebc_cmd, MAX_CMDLEN);
 		EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
@@ -135,6 +144,7 @@ static int wdt_start(struct watchdog_device *dev)
 
 	if (ret) {
 		pr_err("The watchdog cannot be activated\n");
+		clear_bit(DIAG_WDOG_BUSY, &wdt_status);
 		return ret;
 	}
 	return 0;
@@ -146,6 +156,9 @@ static int wdt_stop(struct watchdog_device *dev)
 
 	diag_stat_inc(DIAG_STAT_X288);
 	ret = __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
+
+	clear_bit(DIAG_WDOG_BUSY, &wdt_status);
+
 	return ret;
 }
 
@@ -220,17 +233,10 @@ static struct watchdog_device wdt_dev = {
  * It makes no sense to go into suspend while the watchdog is running.
  * Depending on the memory size, the watchdog might trigger, while we
  * are still saving the memory.
- * We reuse the open flag to ensure that suspend and watchdog open are
- * exclusive operations
  */
 static int wdt_suspend(void)
 {
-	if (test_and_set_bit(WDOG_DEV_OPEN, &wdt_dev.status)) {
-		pr_err("Linux cannot be suspended while the watchdog is in use\n");
-		return notifier_from_errno(-EBUSY);
-	}
-	if (test_bit(WDOG_ACTIVE, &wdt_dev.status)) {
-		clear_bit(WDOG_DEV_OPEN, &wdt_dev.status);
+	if (test_and_set_bit(DIAG_WDOG_BUSY, &wdt_status)) {
 		pr_err("Linux cannot be suspended while the watchdog is in use\n");
 		return notifier_from_errno(-EBUSY);
 	}
@@ -239,7 +245,7 @@ static int wdt_suspend(void)
 
 static int wdt_resume(void)
 {
-	clear_bit(WDOG_DEV_OPEN, &wdt_dev.status);
+	clear_bit(DIAG_WDOG_BUSY, &wdt_status);
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 50abe1b..1ccb0b2 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/watchdog.h>
-#include <linux/reboot.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 
@@ -28,7 +27,6 @@
 struct dc_wdt {
 	void __iomem		*base;
 	struct clk		*clk;
-	struct notifier_block	restart_handler;
 	spinlock_t		lock;
 };
 
@@ -50,16 +48,15 @@ static void dc_wdt_set(struct dc_wdt *wdt, u32 ticks)
 	spin_unlock_irqrestore(&wdt->lock, flags);
 }
 
-static int dc_restart_handler(struct notifier_block *this, unsigned long mode,
-			      void *cmd)
+static int dc_wdt_restart(struct watchdog_device *wdog)
 {
-	struct dc_wdt *wdt = container_of(this, struct dc_wdt, restart_handler);
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 
 	dc_wdt_set(wdt, 1);
 	/* wait for reset to assert... */
 	mdelay(500);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int dc_wdt_start(struct watchdog_device *wdog)
@@ -104,6 +101,7 @@ static struct watchdog_ops dc_wdt_ops = {
 	.stop		= dc_wdt_stop,
 	.set_timeout	= dc_wdt_set_timeout,
 	.get_timeleft	= dc_wdt_get_timeleft,
+	.restart        = dc_wdt_restart,
 };
 
 static struct watchdog_info dc_wdt_info = {
@@ -148,6 +146,7 @@ static int dc_wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 
 	watchdog_set_drvdata(&dc_wdt_wdd, wdt);
+	watchdog_set_restart_priority(&dc_wdt_wdd, 128);
 	watchdog_init_timeout(&dc_wdt_wdd, timeout, dev);
 	ret = watchdog_register_device(&dc_wdt_wdd);
 	if (ret) {
@@ -155,12 +154,6 @@ static int dc_wdt_probe(struct platform_device *pdev)
 		goto err_iounmap;
 	}
 
-	wdt->restart_handler.notifier_call = dc_restart_handler;
-	wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&wdt->restart_handler);
-	if (ret)
-		dev_warn(&pdev->dev, "cannot register restart handler\n");
-
 	return 0;
 
 err_iounmap:
@@ -172,7 +165,6 @@ static int dc_wdt_remove(struct platform_device *pdev)
 {
 	struct dc_wdt *wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&wdt->restart_handler);
 	watchdog_unregister_device(&dc_wdt_wdd);
 	iounmap(wdt->base);
 
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 6ea0634..8fefa4a 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -81,7 +81,7 @@ static inline int dw_wdt_top_in_seconds(unsigned top)
 	 * There are 16 possible timeout values in 0..15 where the number of
 	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
 	 */
-	return (1 << (16 + top)) / clk_get_rate(dw_wdt.clk);
+	return (1U << (16 + top)) / clk_get_rate(dw_wdt.clk);
 }
 
 static int dw_wdt_get_top(void)
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 90d59d3..ba066e4 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -12,10 +12,8 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #define SOFT_TIMEOUT_MIN	1
@@ -36,7 +34,6 @@ struct gpio_wdt_priv {
 	unsigned int		hw_algo;
 	unsigned int		hw_margin;
 	unsigned long		last_jiffies;
-	struct notifier_block	notifier;
 	struct timer_list	timer;
 	struct watchdog_device	wdd;
 };
@@ -57,7 +54,8 @@ static void gpio_wdt_hwping(unsigned long data)
 
 	if (priv->armed && time_after(jiffies, priv->last_jiffies +
 				      msecs_to_jiffies(wdd->timeout * 1000))) {
-		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
+		dev_crit(wdd->parent,
+			 "Timer expired. System will reboot soon!\n");
 		return;
 	}
 
@@ -126,26 +124,6 @@ static int gpio_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
 	return gpio_wdt_ping(wdd);
 }
 
-static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
-			       void *unused)
-{
-	struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
-						  notifier);
-
-	mod_timer(&priv->timer, 0);
-
-	switch (code) {
-	case SYS_HALT:
-	case SYS_POWER_OFF:
-		gpio_wdt_disable(priv);
-		break;
-	default:
-		break;
-	}
-
-	return NOTIFY_DONE;
-}
-
 static const struct watchdog_info gpio_wdt_ident = {
 	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
 			  WDIOF_SETTIMEOUT,
@@ -224,23 +202,16 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 
 	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
 
+	watchdog_stop_on_reboot(&priv->wdd);
+
 	ret = watchdog_register_device(&priv->wdd);
 	if (ret)
 		return ret;
 
-	priv->notifier.notifier_call = gpio_wdt_notify_sys;
-	ret = register_reboot_notifier(&priv->notifier);
-	if (ret)
-		goto error_unregister;
-
 	if (priv->always_running)
 		gpio_wdt_start_impl(priv);
 
 	return 0;
-
-error_unregister:
-	watchdog_unregister_device(&priv->wdd);
-	return ret;
 }
 
 static int gpio_wdt_remove(struct platform_device *pdev)
@@ -248,7 +219,6 @@ static int gpio_wdt_remove(struct platform_device *pdev)
 	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
 
 	del_timer_sync(&priv->timer);
-	unregister_reboot_notifier(&priv->notifier);
 	watchdog_unregister_device(&priv->wdd);
 
 	return 0;
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 286369d..92443c3 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -1,11 +1,11 @@
 /*
- *	HP WatchDog Driver
+ *	HPE WatchDog Driver
  *	based on
  *
  *	SoftDog	0.05:	A Software Watchdog Device
  *
- *	(c) Copyright 2007 Hewlett-Packard Development Company, L.P.
- *	Thomas Mingarelli <thomas.mingarelli@hp.com>
+ *	(c) Copyright 2015 Hewlett Packard Enterprise Development LP
+ *	Thomas Mingarelli <thomas.mingarelli@hpe.com>
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -580,7 +580,7 @@ static const struct watchdog_info ident = {
 	.options = WDIOF_SETTIMEOUT |
 		   WDIOF_KEEPALIVEPING |
 		   WDIOF_MAGICCLOSE,
-	.identity = "HP iLO2+ HW Watchdog Timer",
+	.identity = "HPE iLO2+ HW Watchdog Timer",
 };
 
 static long hpwdt_ioctl(struct file *file, unsigned int cmd,
@@ -758,7 +758,7 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 		goto error2;
 
 	dev_info(&dev->dev,
-			"HP Watchdog Timer Driver: NMI decoding initialized"
+			"HPE Watchdog Timer Driver: NMI decoding initialized"
 			", allow kernel dump: %s (default = 1/ON)\n",
 			(allow_kdump == 0) ? "OFF" : "ON");
 	return 0;
@@ -863,7 +863,7 @@ static int hpwdt_init_one(struct pci_dev *dev,
 		goto error_misc_register;
 	}
 
-	dev_info(&dev->dev, "HP Watchdog Timer Driver: %s"
+	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
 			", timer margin: %d seconds (nowayout=%d).\n",
 			HPWDT_VERSION, soft_margin, nowayout);
 	return 0;
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 15ab072..3679f2e 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -45,7 +45,6 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
 
@@ -87,7 +86,6 @@ struct pdc_wdt_dev {
 	struct clk *wdt_clk;
 	struct clk *sys_clk;
 	void __iomem *base;
-	struct notifier_block restart_handler;
 };
 
 static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
@@ -152,6 +150,16 @@ static int pdc_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int pdc_wdt_restart(struct watchdog_device *wdt_dev)
+{
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	/* Assert SOFT_RESET */
+	writel(0x1, wdt->base + PDC_WDT_SOFT_RESET);
+
+	return 0;
+}
+
 static struct watchdog_info pdc_wdt_info = {
 	.identity	= "IMG PDC Watchdog",
 	.options	= WDIOF_SETTIMEOUT |
@@ -165,20 +173,9 @@ static const struct watchdog_ops pdc_wdt_ops = {
 	.stop		= pdc_wdt_stop,
 	.ping		= pdc_wdt_keepalive,
 	.set_timeout	= pdc_wdt_set_timeout,
+	.restart        = pdc_wdt_restart,
 };
 
-static int pdc_wdt_restart(struct notifier_block *this, unsigned long mode,
-			   void *cmd)
-{
-	struct pdc_wdt_dev *wdt = container_of(this, struct pdc_wdt_dev,
-					       restart_handler);
-
-	/* Assert SOFT_RESET */
-	writel(0x1, wdt->base + PDC_WDT_SOFT_RESET);
-
-	return NOTIFY_OK;
-}
-
 static int pdc_wdt_probe(struct platform_device *pdev)
 {
 	u64 div;
@@ -282,6 +279,7 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	}
 
 	watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&pdc_wdt->wdt_dev, 128);
 
 	platform_set_drvdata(pdev, pdc_wdt);
 
@@ -289,13 +287,6 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_wdt_clk;
 
-	pdc_wdt->restart_handler.notifier_call = pdc_wdt_restart;
-	pdc_wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&pdc_wdt->restart_handler);
-	if (ret)
-		dev_warn(&pdev->dev, "failed to register restart handler: %d\n",
-			 ret);
-
 	return 0;
 
 disable_wdt_clk:
@@ -316,7 +307,6 @@ static int pdc_wdt_remove(struct platform_device *pdev)
 {
 	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&pdc_wdt->restart_handler);
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
 	watchdog_unregister_device(&pdc_wdt->wdt_dev);
 	clk_disable_unprepare(pdc_wdt->wdt_clk);
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 29ef719..e47966a 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -29,10 +29,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/timer.h>
 #include <linux/watchdog.h>
@@ -64,7 +62,6 @@ struct imx2_wdt_device {
 	struct regmap *regmap;
 	struct timer_list timer;	/* Pings the watchdog when closed */
 	struct watchdog_device wdog;
-	struct notifier_block restart_handler;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -83,13 +80,11 @@ static const struct watchdog_info imx2_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
-static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
-				void *cmd)
+static int imx2_wdt_restart(struct watchdog_device *wdog)
 {
+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
-	struct imx2_wdt_device *wdev = container_of(this,
-						    struct imx2_wdt_device,
-						    restart_handler);
+
 	/* Assert SRS signal */
 	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
 	/*
@@ -105,7 +100,7 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
 	/* wait for reset to assert... */
 	mdelay(500);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static inline void imx2_wdt_setup(struct watchdog_device *wdog)
@@ -213,6 +208,7 @@ static const struct watchdog_ops imx2_wdt_ops = {
 	.stop = imx2_wdt_stop,
 	.ping = imx2_wdt_ping,
 	.set_timeout = imx2_wdt_set_timeout,
+	.restart = imx2_wdt_restart,
 };
 
 static const struct regmap_config imx2_wdt_regmap_config = {
@@ -275,6 +271,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdog);
 	watchdog_set_drvdata(wdog, wdev);
 	watchdog_set_nowayout(wdog, nowayout);
+	watchdog_set_restart_priority(wdog, 128);
 	watchdog_init_timeout(wdog, timeout, &pdev->dev);
 
 	setup_timer(&wdev->timer, imx2_wdt_timer_ping, (unsigned long)wdog);
@@ -294,12 +291,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	wdev->restart_handler.notifier_call = imx2_restart_handler;
-	wdev->restart_handler.priority = 128;
-	ret = register_restart_handler(&wdev->restart_handler);
-	if (ret)
-		dev_err(&pdev->dev, "cannot register restart handler\n");
-
 	dev_info(&pdev->dev, "timeout %d sec (nowayout=%d)\n",
 		 wdog->timeout, nowayout);
 
@@ -315,8 +306,6 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
 	struct watchdog_device *wdog = platform_get_drvdata(pdev);
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
-	unregister_restart_handler(&wdev->restart_handler);
-
 	watchdog_unregister_device(wdog);
 
 	if (imx2_wdt_is_running(wdev)) {
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index ab7b8b1..6914c83 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 /* Registers */
@@ -59,7 +58,6 @@ struct lpc18xx_wdt_dev {
 	unsigned long		clk_rate;
 	void __iomem		*base;
 	struct timer_list	timer;
-	struct notifier_block	restart_handler;
 	spinlock_t		lock;
 };
 
@@ -155,27 +153,9 @@ static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
-static struct watchdog_info lpc18xx_wdt_info = {
-	.identity	= "NXP LPC18xx Watchdog",
-	.options	= WDIOF_SETTIMEOUT |
-			  WDIOF_KEEPALIVEPING |
-			  WDIOF_MAGICCLOSE,
-};
-
-static const struct watchdog_ops lpc18xx_wdt_ops = {
-	.owner		= THIS_MODULE,
-	.start		= lpc18xx_wdt_start,
-	.stop		= lpc18xx_wdt_stop,
-	.ping		= lpc18xx_wdt_feed,
-	.set_timeout	= lpc18xx_wdt_set_timeout,
-	.get_timeleft	= lpc18xx_wdt_get_timeleft,
-};
-
-static int lpc18xx_wdt_restart(struct notifier_block *this, unsigned long mode,
-			       void *cmd)
+static int lpc18xx_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	struct lpc18xx_wdt_dev *lpc18xx_wdt = container_of(this,
-				struct lpc18xx_wdt_dev, restart_handler);
+	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
 	unsigned long flags;
 	int val;
 
@@ -197,9 +177,26 @@ static int lpc18xx_wdt_restart(struct notifier_block *this, unsigned long mode,
 
 	spin_unlock_irqrestore(&lpc18xx_wdt->lock, flags);
 
-	return NOTIFY_OK;
+	return 0;
 }
 
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
+	.restart        = lpc18xx_wdt_restart,
+};
+
 static int lpc18xx_wdt_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt;
@@ -273,6 +270,7 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 		    (unsigned long)&lpc18xx_wdt->wdt_dev);
 
 	watchdog_set_nowayout(&lpc18xx_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&lpc18xx_wdt->wdt_dev, 128);
 
 	platform_set_drvdata(pdev, lpc18xx_wdt);
 
@@ -280,12 +278,6 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_wdt_clk;
 
-	lpc18xx_wdt->restart_handler.notifier_call = lpc18xx_wdt_restart;
-	lpc18xx_wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&lpc18xx_wdt->restart_handler);
-	if (ret)
-		dev_warn(dev, "failed to register restart handler: %d\n", ret);
-
 	return 0;
 
 disable_wdt_clk:
@@ -306,8 +298,6 @@ static int lpc18xx_wdt_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&lpc18xx_wdt->restart_handler);
-
 	dev_warn(&pdev->dev, "I quit now, hardware will probably reboot!\n");
 	del_timer(&lpc18xx_wdt->timer);
 
diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 098fa9c..af6a7c4 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -100,12 +100,12 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
 	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
 
 	if (timeout != 1 && timeout != 30) {
-		dev_err(wdt->dev, "Only 1 and 30 allowed as timeout\n");
+		dev_err(wdt->parent, "Only 1 and 30 allowed as timeout\n");
 		return -EINVAL;
 	}
 
 	if (timeout == 30 && wdt->timeout == 1) {
-		dev_err(wdt->dev,
+		dev_err(wdt->parent,
 			"Transition from fast to slow mode not allowed\n");
 		return -EINVAL;
 	}
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 1f4155e..aea5d2f 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -17,51 +17,64 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/notifier.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
 #define DRV_NAME		"meson_wdt"
 
 #define MESON_WDT_TC		0x00
-#define MESON_WDT_TC_EN		BIT(22)
-#define MESON_WDT_TC_TM_MASK	0x3fffff
 #define MESON_WDT_DC_RESET	(3 << 24)
 
 #define MESON_WDT_RESET		0x04
 
 #define MESON_WDT_TIMEOUT	30
 #define MESON_WDT_MIN_TIMEOUT	1
-#define MESON_WDT_MAX_TIMEOUT	(MESON_WDT_TC_TM_MASK / 100000)
 
-#define MESON_SEC_TO_TC(s)	((s) * 100000)
+#define MESON_SEC_TO_TC(s, c)	((s) * (c))
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static unsigned int timeout = MESON_WDT_TIMEOUT;
 
+struct meson_wdt_data {
+	unsigned int enable;
+	unsigned int terminal_count_mask;
+	unsigned int count_unit;
+};
+
+static struct meson_wdt_data meson6_wdt_data = {
+	.enable			= BIT(22),
+	.terminal_count_mask	= 0x3fffff,
+	.count_unit		= 100000, /* 10 us */
+};
+
+static struct meson_wdt_data meson8b_wdt_data = {
+	.enable			= BIT(19),
+	.terminal_count_mask	= 0xffff,
+	.count_unit		= 7812, /* 128 us */
+};
+
 struct meson_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
-	struct notifier_block restart_handler;
+	const struct meson_wdt_data *data;
 };
 
-static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
-				void *cmd)
+static int meson_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN;
-	struct meson_wdt_dev *meson_wdt = container_of(this,
-						       struct meson_wdt_dev,
-						       restart_handler);
+	struct meson_wdt_dev *meson_wdt = watchdog_get_drvdata(wdt_dev);
+	u32 tc_reboot = MESON_WDT_DC_RESET;
+
+	tc_reboot |= meson_wdt->data->enable;
 
 	while (1) {
 		writel(tc_reboot, meson_wdt->wdt_base + MESON_WDT_TC);
 		mdelay(5);
 	}
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int meson_wdt_ping(struct watchdog_device *wdt_dev)
@@ -80,8 +93,8 @@ static void meson_wdt_change_timeout(struct watchdog_device *wdt_dev,
 	u32 reg;
 
 	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
-	reg &= ~MESON_WDT_TC_TM_MASK;
-	reg |= MESON_SEC_TO_TC(timeout);
+	reg &= ~meson_wdt->data->terminal_count_mask;
+	reg |= MESON_SEC_TO_TC(timeout, meson_wdt->data->count_unit);
 	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
 }
 
@@ -102,7 +115,7 @@ static int meson_wdt_stop(struct watchdog_device *wdt_dev)
 	u32 reg;
 
 	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
-	reg &= ~MESON_WDT_TC_EN;
+	reg &= ~meson_wdt->data->enable;
 	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
 
 	return 0;
@@ -117,7 +130,7 @@ static int meson_wdt_start(struct watchdog_device *wdt_dev)
 	meson_wdt_ping(wdt_dev);
 
 	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
-	reg |= MESON_WDT_TC_EN;
+	reg |= meson_wdt->data->enable;
 	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
 
 	return 0;
@@ -136,12 +149,21 @@ static const struct watchdog_ops meson_wdt_ops = {
 	.stop		= meson_wdt_stop,
 	.ping		= meson_wdt_ping,
 	.set_timeout	= meson_wdt_set_timeout,
+	.restart        = meson_wdt_restart,
+};
+
+static const struct of_device_id meson_wdt_dt_ids[] = {
+	{ .compatible = "amlogic,meson6-wdt", .data = &meson6_wdt_data },
+	{ .compatible = "amlogic,meson8b-wdt", .data = &meson8b_wdt_data },
+	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
 
 static int meson_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct meson_wdt_dev *meson_wdt;
+	const struct of_device_id *of_id;
 	int err;
 
 	meson_wdt = devm_kzalloc(&pdev->dev, sizeof(*meson_wdt), GFP_KERNEL);
@@ -153,17 +175,28 @@ static int meson_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(meson_wdt->wdt_base))
 		return PTR_ERR(meson_wdt->wdt_base);
 
+	of_id = of_match_device(meson_wdt_dt_ids, &pdev->dev);
+	if (!of_id) {
+		dev_err(&pdev->dev, "Unable to initialize WDT data\n");
+		return -ENODEV;
+	}
+	meson_wdt->data = of_id->data;
+
 	meson_wdt->wdt_dev.parent = &pdev->dev;
 	meson_wdt->wdt_dev.info = &meson_wdt_info;
 	meson_wdt->wdt_dev.ops = &meson_wdt_ops;
-	meson_wdt->wdt_dev.timeout = MESON_WDT_TIMEOUT;
-	meson_wdt->wdt_dev.max_timeout = MESON_WDT_MAX_TIMEOUT;
+	meson_wdt->wdt_dev.max_timeout =
+		meson_wdt->data->terminal_count_mask / meson_wdt->data->count_unit;
 	meson_wdt->wdt_dev.min_timeout = MESON_WDT_MIN_TIMEOUT;
+	meson_wdt->wdt_dev.timeout = min_t(unsigned int,
+					   MESON_WDT_TIMEOUT,
+					   meson_wdt->wdt_dev.max_timeout);
 
 	watchdog_set_drvdata(&meson_wdt->wdt_dev, meson_wdt);
 
 	watchdog_init_timeout(&meson_wdt->wdt_dev, timeout, &pdev->dev);
 	watchdog_set_nowayout(&meson_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&meson_wdt->wdt_dev, 128);
 
 	meson_wdt_stop(&meson_wdt->wdt_dev);
 
@@ -173,13 +206,6 @@ static int meson_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, meson_wdt);
 
-	meson_wdt->restart_handler.notifier_call = meson_restart_handle;
-	meson_wdt->restart_handler.priority = 128;
-	err = register_restart_handler(&meson_wdt->restart_handler);
-	if (err)
-		dev_err(&pdev->dev,
-			"cannot register restart handler (err=%d)\n", err);
-
 	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
 		 meson_wdt->wdt_dev.timeout, nowayout);
 
@@ -190,8 +216,6 @@ static int meson_wdt_remove(struct platform_device *pdev)
 {
 	struct meson_wdt_dev *meson_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&meson_wdt->restart_handler);
-
 	watchdog_unregister_device(&meson_wdt->wdt_dev);
 
 	return 0;
@@ -204,12 +228,6 @@ static void meson_wdt_shutdown(struct platform_device *pdev)
 	meson_wdt_stop(&meson_wdt->wdt_dev);
 }
 
-static const struct of_device_id meson_wdt_dt_ids[] = {
-	{ .compatible = "amlogic,meson6-wdt" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
-
 static struct platform_driver meson_wdt_driver = {
 	.probe		= meson_wdt_probe,
 	.remove		= meson_wdt_remove,
diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 60b0605..885c81b 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -15,9 +15,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-#include <linux/notifier.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 
@@ -29,22 +27,19 @@ struct moxart_wdt_dev {
 	struct watchdog_device dev;
 	void __iomem *base;
 	unsigned int clock_frequency;
-	struct notifier_block restart_handler;
 };
 
 static int heartbeat;
 
-static int moxart_restart_handle(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
+static int moxart_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	struct moxart_wdt_dev *moxart_wdt = container_of(this,
-							 struct moxart_wdt_dev,
-							 restart_handler);
+	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
+
 	writel(1, moxart_wdt->base + REG_COUNT);
 	writel(0x5ab9, moxart_wdt->base + REG_MODE);
 	writel(0x03, moxart_wdt->base + REG_ENABLE);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int moxart_wdt_stop(struct watchdog_device *wdt_dev)
@@ -87,6 +82,7 @@ static const struct watchdog_ops moxart_wdt_ops = {
 	.start          = moxart_wdt_start,
 	.stop           = moxart_wdt_stop,
 	.set_timeout    = moxart_wdt_set_timeout,
+	.restart        = moxart_wdt_restart,
 };
 
 static int moxart_wdt_probe(struct platform_device *pdev)
@@ -134,6 +130,7 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&moxart_wdt->dev, heartbeat, dev);
 	watchdog_set_nowayout(&moxart_wdt->dev, nowayout);
+	watchdog_set_restart_priority(&moxart_wdt->dev, 128);
 
 	watchdog_set_drvdata(&moxart_wdt->dev, moxart_wdt);
 
@@ -141,13 +138,6 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	moxart_wdt->restart_handler.notifier_call = moxart_restart_handle;
-	moxart_wdt->restart_handler.priority = 128;
-	err = register_restart_handler(&moxart_wdt->restart_handler);
-	if (err)
-		dev_err(dev, "cannot register restart notifier (err=%d)\n",
-			err);
-
 	dev_dbg(dev, "Watchdog enabled (heartbeat=%d sec, nowayout=%d)\n",
 		moxart_wdt->dev.timeout, nowayout);
 
@@ -158,7 +148,6 @@ static int moxart_wdt_remove(struct platform_device *pdev)
 {
 	struct moxart_wdt_dev *moxart_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&moxart_wdt->restart_handler);
 	moxart_wdt_stop(&moxart_wdt->dev);
 
 	return 0;
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
new file mode 100644
index 0000000..4a2290f
--- /dev/null
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -0,0 +1,186 @@
+/*
+ * Ralink MT7621/MT7628 built-in hardware watchdog timer
+ *
+ * Copyright (C) 2014 John Crispin <blogic@openwrt.org>
+ *
+ * This driver was based on: drivers/watchdog/rt2880_wdt.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/watchdog.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#define SYSC_RSTSTAT			0x38
+#define WDT_RST_CAUSE			BIT(1)
+
+#define RALINK_WDT_TIMEOUT		30
+
+#define TIMER_REG_TMRSTAT		0x00
+#define TIMER_REG_TMR1LOAD		0x24
+#define TIMER_REG_TMR1CTL		0x20
+
+#define TMR1CTL_ENABLE			BIT(7)
+#define TMR1CTL_RESTART			BIT(9)
+#define TMR1CTL_PRESCALE_SHIFT		16
+
+static void __iomem *mt7621_wdt_base;
+static struct reset_control *mt7621_wdt_reset;
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static inline void rt_wdt_w32(unsigned reg, u32 val)
+{
+	iowrite32(val, mt7621_wdt_base + reg);
+}
+
+static inline u32 rt_wdt_r32(unsigned reg)
+{
+	return ioread32(mt7621_wdt_base + reg);
+}
+
+static int mt7621_wdt_ping(struct watchdog_device *w)
+{
+	rt_wdt_w32(TIMER_REG_TMRSTAT, TMR1CTL_RESTART);
+
+	return 0;
+}
+
+static int mt7621_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
+{
+	w->timeout = t;
+	rt_wdt_w32(TIMER_REG_TMR1LOAD, t * 1000);
+	mt7621_wdt_ping(w);
+
+	return 0;
+}
+
+static int mt7621_wdt_start(struct watchdog_device *w)
+{
+	u32 t;
+
+	/* set the prescaler to 1ms == 1000us */
+	rt_wdt_w32(TIMER_REG_TMR1CTL, 1000 << TMR1CTL_PRESCALE_SHIFT);
+
+	mt7621_wdt_set_timeout(w, w->timeout);
+
+	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t |= TMR1CTL_ENABLE;
+	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+
+	return 0;
+}
+
+static int mt7621_wdt_stop(struct watchdog_device *w)
+{
+	u32 t;
+
+	mt7621_wdt_ping(w);
+
+	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t &= ~TMR1CTL_ENABLE;
+	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+
+	return 0;
+}
+
+static int mt7621_wdt_bootcause(void)
+{
+	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
+		return WDIOF_CARDRESET;
+
+	return 0;
+}
+
+static struct watchdog_info mt7621_wdt_info = {
+	.identity = "Mediatek Watchdog",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
+
+static struct watchdog_ops mt7621_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = mt7621_wdt_start,
+	.stop = mt7621_wdt_stop,
+	.ping = mt7621_wdt_ping,
+	.set_timeout = mt7621_wdt_set_timeout,
+};
+
+static struct watchdog_device mt7621_wdt_dev = {
+	.info = &mt7621_wdt_info,
+	.ops = &mt7621_wdt_ops,
+	.min_timeout = 1,
+	.max_timeout = 0xfffful / 1000,
+};
+
+static int mt7621_wdt_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mt7621_wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mt7621_wdt_base))
+		return PTR_ERR(mt7621_wdt_base);
+
+	mt7621_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (!IS_ERR(mt7621_wdt_reset))
+		reset_control_deassert(mt7621_wdt_reset);
+
+	mt7621_wdt_dev.dev = &pdev->dev;
+	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
+
+	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
+			      &pdev->dev);
+	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
+
+	ret = watchdog_register_device(&mt7621_wdt_dev);
+
+	return 0;
+}
+
+static int mt7621_wdt_remove(struct platform_device *pdev)
+{
+	watchdog_unregister_device(&mt7621_wdt_dev);
+
+	return 0;
+}
+
+static void mt7621_wdt_shutdown(struct platform_device *pdev)
+{
+	mt7621_wdt_stop(&mt7621_wdt_dev);
+}
+
+static const struct of_device_id mt7621_wdt_match[] = {
+	{ .compatible = "mediatek,mt7621-wdt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt7621_wdt_match);
+
+static struct platform_driver mt7621_wdt_driver = {
+	.probe		= mt7621_wdt_probe,
+	.remove		= mt7621_wdt_remove,
+	.shutdown	= mt7621_wdt_shutdown,
+	.driver		= {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= mt7621_wdt_match,
+	},
+};
+
+module_platform_driver(mt7621_wdt_driver);
+
+MODULE_DESCRIPTION("MediaTek MT762x hardware watchdog driver");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index b751f43..b78776c 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -28,8 +28,6 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/delay.h>
 
 #define WDT_MAX_TIMEOUT		31
@@ -64,16 +62,13 @@ static unsigned int timeout = WDT_MAX_TIMEOUT;
 struct mtk_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
-	struct notifier_block restart_handler;
 };
 
-static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
-				void *cmd)
+static int mtk_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	struct mtk_wdt_dev *mtk_wdt;
+	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base;
 
-	mtk_wdt = container_of(this, struct mtk_wdt_dev, restart_handler);
 	wdt_base = mtk_wdt->wdt_base;
 
 	while (1) {
@@ -81,7 +76,7 @@ static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
 		mdelay(5);
 	}
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int mtk_wdt_ping(struct watchdog_device *wdt_dev)
@@ -161,6 +156,7 @@ static const struct watchdog_ops mtk_wdt_ops = {
 	.stop		= mtk_wdt_stop,
 	.ping		= mtk_wdt_ping,
 	.set_timeout	= mtk_wdt_set_timeout,
+	.restart	= mtk_wdt_restart,
 };
 
 static int mtk_wdt_probe(struct platform_device *pdev)
@@ -189,6 +185,7 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&mtk_wdt->wdt_dev, timeout, &pdev->dev);
 	watchdog_set_nowayout(&mtk_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&mtk_wdt->wdt_dev, 128);
 
 	watchdog_set_drvdata(&mtk_wdt->wdt_dev, mtk_wdt);
 
@@ -198,13 +195,6 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	if (unlikely(err))
 		return err;
 
-	mtk_wdt->restart_handler.notifier_call = mtk_reset_handler;
-	mtk_wdt->restart_handler.priority = 128;
-	err = register_restart_handler(&mtk_wdt->restart_handler);
-	if (err)
-		dev_warn(&pdev->dev,
-			"cannot register restart handler (err=%d)\n", err);
-
 	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
 			mtk_wdt->wdt_dev.timeout, nowayout);
 
@@ -223,8 +213,6 @@ static int mtk_wdt_remove(struct platform_device *pdev)
 {
 	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&mtk_wdt->restart_handler);
-
 	watchdog_unregister_device(&mtk_wdt->wdt_dev);
 
 	return 0;
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 6f17c93..1b02bfa 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -271,7 +271,8 @@ static int omap_wdt_probe(struct platform_device *pdev)
 			wdev->wdog.bootstatus = WDIOF_CARDRESET;
 	}
 
-	omap_wdt_disable(wdev);
+	if (!early_enable)
+		omap_wdt_disable(wdev);
 
 	ret = watchdog_register_device(&wdev->wdog);
 	if (ret) {
@@ -283,11 +284,11 @@ static int omap_wdt_probe(struct platform_device *pdev)
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		wdev->wdog.timeout);
 
-	pm_runtime_put_sync(wdev->dev);
-
 	if (early_enable)
 		omap_wdt_start(&wdev->wdog);
 
+	pm_runtime_put(wdev->dev);
+
 	return 0;
 }
 
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 773dcfa..424f9a9 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #define WDT_RST		0x38
@@ -28,7 +27,6 @@ struct qcom_wdt {
 	struct watchdog_device	wdd;
 	struct clk		*clk;
 	unsigned long		rate;
-	struct notifier_block	restart_nb;
 	void __iomem		*base;
 };
 
@@ -72,25 +70,9 @@ static int qcom_wdt_set_timeout(struct watchdog_device *wdd,
 	return qcom_wdt_start(wdd);
 }
 
-static const struct watchdog_ops qcom_wdt_ops = {
-	.start		= qcom_wdt_start,
-	.stop		= qcom_wdt_stop,
-	.ping		= qcom_wdt_ping,
-	.set_timeout	= qcom_wdt_set_timeout,
-	.owner		= THIS_MODULE,
-};
-
-static const struct watchdog_info qcom_wdt_info = {
-	.options	= WDIOF_KEEPALIVEPING
-			| WDIOF_MAGICCLOSE
-			| WDIOF_SETTIMEOUT,
-	.identity	= KBUILD_MODNAME,
-};
-
-static int qcom_wdt_restart(struct notifier_block *nb, unsigned long action,
-			    void *data)
+static int qcom_wdt_restart(struct watchdog_device *wdd)
 {
-	struct qcom_wdt *wdt = container_of(nb, struct qcom_wdt, restart_nb);
+	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
 	u32 timeout;
 
 	/*
@@ -110,9 +92,25 @@ static int qcom_wdt_restart(struct notifier_block *nb, unsigned long action,
 	wmb();
 
 	msleep(150);
-	return NOTIFY_DONE;
+	return 0;
 }
 
+static const struct watchdog_ops qcom_wdt_ops = {
+	.start		= qcom_wdt_start,
+	.stop		= qcom_wdt_stop,
+	.ping		= qcom_wdt_ping,
+	.set_timeout	= qcom_wdt_set_timeout,
+	.restart        = qcom_wdt_restart,
+	.owner		= THIS_MODULE,
+};
+
+static const struct watchdog_info qcom_wdt_info = {
+	.options	= WDIOF_KEEPALIVEPING
+			| WDIOF_MAGICCLOSE
+			| WDIOF_SETTIMEOUT,
+	.identity	= KBUILD_MODNAME,
+};
+
 static int qcom_wdt_probe(struct platform_device *pdev)
 {
 	struct qcom_wdt *wdt;
@@ -166,7 +164,6 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		goto err_clk_unprepare;
 	}
 
-	wdt->wdd.dev = &pdev->dev;
 	wdt->wdd.info = &qcom_wdt_info;
 	wdt->wdd.ops = &qcom_wdt_ops;
 	wdt->wdd.min_timeout = 1;
@@ -187,14 +184,6 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		goto err_clk_unprepare;
 	}
 
-	/*
-	 * WDT restart notifier has priority 0 (use as a last resort)
-	 */
-	wdt->restart_nb.notifier_call = qcom_wdt_restart;
-	ret = register_restart_handler(&wdt->restart_nb);
-	if (ret)
-		dev_err(&pdev->dev, "failed to setup restart handler\n");
-
 	platform_set_drvdata(pdev, wdt);
 	return 0;
 
@@ -207,7 +196,6 @@ static int qcom_wdt_remove(struct platform_device *pdev)
 {
 	struct qcom_wdt *wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&wdt->restart_nb);
 	watchdog_unregister_device(&wdt->wdd);
 	clk_disable_unprepare(wdt->clk);
 	return 0;
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index d781000..0093450 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -41,7 +41,6 @@
 #include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
-#include <linux/reboot.h>
 #include <linux/delay.h>
 
 #define S3C2410_WTCON		0x00
@@ -130,7 +129,6 @@ struct s3c2410_wdt {
 	unsigned long		wtdat_save;
 	struct watchdog_device	wdt_device;
 	struct notifier_block	freq_transition;
-	struct notifier_block	restart_handler;
 	struct s3c2410_wdt_variant *drv_data;
 	struct regmap *pmureg;
 };
@@ -351,6 +349,29 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd, unsigned timeou
 	return 0;
 }
 
+static int s3c2410wdt_restart(struct watchdog_device *wdd)
+{
+	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
+	void __iomem *wdt_base = wdt->reg_base;
+
+	/* disable watchdog, to be safe  */
+	writel(0, wdt_base + S3C2410_WTCON);
+
+	/* put initial values into count and data */
+	writel(0x80, wdt_base + S3C2410_WTCNT);
+	writel(0x80, wdt_base + S3C2410_WTDAT);
+
+	/* set the watchdog to go and reset... */
+	writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV16 |
+		S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x20),
+		wdt_base + S3C2410_WTCON);
+
+	/* wait for reset to assert... */
+	mdelay(500);
+
+	return 0;
+}
+
 #define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
 
 static const struct watchdog_info s3c2410_wdt_ident = {
@@ -365,6 +386,7 @@ static struct watchdog_ops s3c2410wdt_ops = {
 	.stop = s3c2410wdt_stop,
 	.ping = s3c2410wdt_keepalive,
 	.set_timeout = s3c2410wdt_set_heartbeat,
+	.restart = s3c2410wdt_restart,
 };
 
 static struct watchdog_device s3c2410_wdd = {
@@ -452,31 +474,6 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
 }
 #endif
 
-static int s3c2410wdt_restart(struct notifier_block *this,
-			      unsigned long mode, void *cmd)
-{
-	struct s3c2410_wdt *wdt = container_of(this, struct s3c2410_wdt,
-					       restart_handler);
-	void __iomem *wdt_base = wdt->reg_base;
-
-	/* disable watchdog, to be safe  */
-	writel(0, wdt_base + S3C2410_WTCON);
-
-	/* put initial values into count and data */
-	writel(0x80, wdt_base + S3C2410_WTCNT);
-	writel(0x80, wdt_base + S3C2410_WTDAT);
-
-	/* set the watchdog to go and reset... */
-	writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV16 |
-		S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x20),
-		wdt_base + S3C2410_WTCON);
-
-	/* wait for reset to assert... */
-	mdelay(500);
-
-	return NOTIFY_DONE;
-}
-
 static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 {
 	unsigned int rst_stat;
@@ -605,6 +602,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	}
 
 	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
+	watchdog_set_restart_priority(&wdt->wdt_device, 128);
 
 	wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
 	wdt->wdt_device.parent = &pdev->dev;
@@ -632,12 +630,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdt);
 
-	wdt->restart_handler.notifier_call = s3c2410wdt_restart;
-	wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&wdt->restart_handler);
-	if (ret)
-		pr_err("cannot register restart handler, %d\n", ret);
-
 	/* print out a statement of readiness */
 
 	wtcon = readl(wdt->reg_base + S3C2410_WTCON);
@@ -667,8 +659,6 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 	int ret;
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
-	unregister_restart_handler(&wdt->restart_handler);
-
 	ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 0dc5e32..99a06f9 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -43,7 +43,6 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/watchdog.h>
-#include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
@@ -87,6 +86,7 @@ static struct timer_list watchdog_ticktock =
 
 static void watchdog_fire(unsigned long data)
 {
+	module_put(THIS_MODULE);
 	if (soft_noboot)
 		pr_crit("Triggered - Reboot ignored\n");
 	else if (soft_panic) {
@@ -105,13 +105,16 @@ static void watchdog_fire(unsigned long data)
 
 static int softdog_ping(struct watchdog_device *w)
 {
-	mod_timer(&watchdog_ticktock, jiffies+(w->timeout*HZ));
+	if (!mod_timer(&watchdog_ticktock, jiffies+(w->timeout*HZ)))
+		__module_get(THIS_MODULE);
 	return 0;
 }
 
 static int softdog_stop(struct watchdog_device *w)
 {
-	del_timer(&watchdog_ticktock);
+	if (del_timer(&watchdog_ticktock))
+		module_put(THIS_MODULE);
+
 	return 0;
 }
 
@@ -122,26 +125,9 @@ static int softdog_set_timeout(struct watchdog_device *w, unsigned int t)
 }
 
 /*
- *	Notifier for system down
- */
-
-static int softdog_notify_sys(struct notifier_block *this, unsigned long code,
-	void *unused)
-{
-	if (code == SYS_DOWN || code == SYS_HALT)
-		/* Turn the WDT off */
-		softdog_stop(NULL);
-	return NOTIFY_DONE;
-}
-
-/*
  *	Kernel Interfaces
  */
 
-static struct notifier_block softdog_notifier = {
-	.notifier_call	= softdog_notify_sys,
-};
-
 static struct watchdog_info softdog_info = {
 	.identity = "Software Watchdog",
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
@@ -175,18 +161,11 @@ static int __init watchdog_init(void)
 	softdog_dev.timeout = soft_margin;
 
 	watchdog_set_nowayout(&softdog_dev, nowayout);
-
-	ret = register_reboot_notifier(&softdog_notifier);
-	if (ret) {
-		pr_err("cannot register reboot notifier (err=%d)\n", ret);
-		return ret;
-	}
+	watchdog_stop_on_reboot(&softdog_dev);
 
 	ret = watchdog_register_device(&softdog_dev);
-	if (ret) {
-		unregister_reboot_notifier(&softdog_notifier);
+	if (ret)
 		return ret;
-	}
 
 	pr_info("Software Watchdog Timer: 0.08 initialized. soft_noboot=%d soft_margin=%d sec soft_panic=%d (nowayout=%d)\n",
 		soft_noboot, soft_margin, soft_panic, nowayout);
@@ -197,7 +176,6 @@ static int __init watchdog_init(void)
 static void __exit watchdog_exit(void)
 {
 	watchdog_unregister_device(&softdog_dev);
-	unregister_reboot_notifier(&softdog_notifier);
 }
 
 module_init(watchdog_init);
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index eb8044e..6467b91 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -306,6 +306,10 @@ static struct miscdevice sp5100_tco_miscdev = {
 static const struct pci_device_id sp5100_tco_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
 	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
@@ -331,21 +335,24 @@ static unsigned char sp5100_tco_setupdevice(void)
 	if (!sp5100_tco_pci)
 		return 0;
 
-	pr_info("PCI Revision ID: 0x%x\n", sp5100_tco_pci->revision);
+	pr_info("PCI Vendor ID: 0x%x, Device ID: 0x%x, Revision ID: 0x%x\n",
+		sp5100_tco_pci->vendor, sp5100_tco_pci->device,
+		sp5100_tco_pci->revision);
 
 	/*
 	 * Determine type of southbridge chipset.
 	 */
-	if (sp5100_tco_pci->revision >= 0x40) {
-		dev_name = SB800_DEVNAME;
-		index_reg = SB800_IO_PM_INDEX_REG;
-		data_reg = SB800_IO_PM_DATA_REG;
-		base_addr = SB800_PM_WATCHDOG_BASE;
-	} else {
+	if (sp5100_tco_pci->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
+	    sp5100_tco_pci->revision < 0x40) {
 		dev_name = SP5100_DEVNAME;
 		index_reg = SP5100_IO_PM_INDEX_REG;
 		data_reg = SP5100_IO_PM_DATA_REG;
 		base_addr = SP5100_PM_WATCHDOG_BASE;
+	} else {
+		dev_name = SB800_DEVNAME;
+		index_reg = SB800_IO_PM_INDEX_REG;
+		data_reg = SB800_IO_PM_DATA_REG;
+		base_addr = SB800_PM_WATCHDOG_BASE;
 	}
 
 	/* Request the IO ports used by this driver */
@@ -381,7 +388,12 @@ static unsigned char sp5100_tco_setupdevice(void)
 	 * Secondly, Find the watchdog timer MMIO address
 	 * from SBResource_MMIO register.
 	 */
-	if (sp5100_tco_pci->revision >= 0x40) {
+	if (sp5100_tco_pci->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
+	    sp5100_tco_pci->revision < 0x40) {
+		/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
+		pci_read_config_dword(sp5100_tco_pci,
+				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
+	} else {
 		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
 		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
@@ -391,10 +403,6 @@ static unsigned char sp5100_tco_setupdevice(void)
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
-	} else {
-		/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
-		pci_read_config_dword(sp5100_tco_pci,
-				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
 	}
 
 	/* The SBResource_MMIO is enabled and mapped memory space? */
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 3ee6128..d8b11eb 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -14,6 +14,8 @@
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/stmp3xxx_rtc_wdt.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
 #define STMP3XXX_DEFAULT_TIMEOUT 19
@@ -69,6 +71,25 @@ static struct watchdog_device stmp3xxx_wdd = {
 	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
 };
 
+static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
+			  void *unused)
+{
+	switch (code) {
+	case SYS_DOWN:	/* keep enabled, system might crash while going down */
+		break;
+	case SYS_HALT:	/* allow the system to actually halt */
+	case SYS_POWER_OFF:
+		wdt_stop(&stmp3xxx_wdd);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block wdt_notifier = {
+	.notifier_call = wdt_notify_sys,
+};
+
 static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -84,6 +105,9 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (register_reboot_notifier(&wdt_notifier))
+		dev_warn(&pdev->dev, "cannot register reboot notifier\n");
+
 	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
 			stmp3xxx_wdd.timeout);
 	return 0;
@@ -91,6 +115,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 
 static int stmp3xxx_wdt_remove(struct platform_device *pdev)
 {
+	unregister_reboot_notifier(&wdt_notifier);
 	watchdog_unregister_device(&stmp3xxx_wdd);
 	return 0;
 }
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 47bd8a1..e027deb 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -21,11 +21,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -60,7 +58,6 @@ struct sunxi_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
 	const struct sunxi_wdt_reg *wdt_regs;
-	struct notifier_block restart_handler;
 };
 
 /*
@@ -86,12 +83,9 @@ static const int wdt_timeout_map[] = {
 };
 
 
-static int sunxi_restart_handle(struct notifier_block *this, unsigned long mode,
-				void *cmd)
+static int sunxi_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	struct sunxi_wdt_dev *sunxi_wdt = container_of(this,
-						       struct sunxi_wdt_dev,
-						       restart_handler);
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base = sunxi_wdt->wdt_base;
 	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
 	u32 val;
@@ -120,7 +114,7 @@ static int sunxi_restart_handle(struct notifier_block *this, unsigned long mode,
 		val |= WDT_MODE_EN;
 		writel(val, wdt_base + regs->wdt_mode);
 	}
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
@@ -208,6 +202,7 @@ static const struct watchdog_ops sunxi_wdt_ops = {
 	.stop		= sunxi_wdt_stop,
 	.ping		= sunxi_wdt_ping,
 	.set_timeout	= sunxi_wdt_set_timeout,
+	.restart	= sunxi_wdt_restart,
 };
 
 static const struct sunxi_wdt_reg sun4i_wdt_reg = {
@@ -268,6 +263,7 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&sunxi_wdt->wdt_dev, timeout, &pdev->dev);
 	watchdog_set_nowayout(&sunxi_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&sunxi_wdt->wdt_dev, 128);
 
 	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, sunxi_wdt);
 
@@ -277,13 +273,6 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	if (unlikely(err))
 		return err;
 
-	sunxi_wdt->restart_handler.notifier_call = sunxi_restart_handle;
-	sunxi_wdt->restart_handler.priority = 128;
-	err = register_restart_handler(&sunxi_wdt->restart_handler);
-	if (err)
-		dev_err(&pdev->dev,
-			"cannot register restart handler (err=%d)\n", err);
-
 	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
 			sunxi_wdt->wdt_dev.timeout, nowayout);
 
@@ -294,8 +283,6 @@ static int sunxi_wdt_remove(struct platform_device *pdev)
 {
 	struct sunxi_wdt_dev *sunxi_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&sunxi_wdt->restart_handler);
-
 	watchdog_unregister_device(&sunxi_wdt->wdt_dev);
 	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, NULL);
 
diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
new file mode 100644
index 0000000..709c1ed
--- /dev/null
+++ b/drivers/watchdog/tangox_wdt.c
@@ -0,0 +1,225 @@
+/*
+ *  Copyright (C) 2015 Mans Rullgard <mans@mansr.com>
+ *  SMP86xx/SMP87xx Watchdog driver
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+#define DEFAULT_TIMEOUT 30
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static unsigned int timeout;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout");
+
+/*
+ * Counter counts down from programmed value.  Reset asserts when
+ * the counter reaches 1.
+ */
+#define WD_COUNTER		0
+
+#define WD_CONFIG		4
+#define WD_CONFIG_XTAL_IN	BIT(0)
+#define WD_CONFIG_DISABLE	BIT(31)
+
+struct tangox_wdt_device {
+	struct watchdog_device wdt;
+	void __iomem *base;
+	unsigned long clk_rate;
+	struct clk *clk;
+	struct notifier_block restart;
+};
+
+static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
+				  unsigned int new_timeout)
+{
+	wdt->timeout = new_timeout;
+
+	return 0;
+}
+
+static int tangox_wdt_start(struct watchdog_device *wdt)
+{
+	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
+	u32 ticks;
+
+	ticks = 1 + wdt->timeout * dev->clk_rate;
+	writel(ticks, dev->base + WD_COUNTER);
+
+	return 0;
+}
+
+static int tangox_wdt_stop(struct watchdog_device *wdt)
+{
+	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
+
+	writel(0, dev->base + WD_COUNTER);
+
+	return 0;
+}
+
+static unsigned int tangox_wdt_get_timeleft(struct watchdog_device *wdt)
+{
+	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
+	u32 count;
+
+	count = readl(dev->base + WD_COUNTER);
+
+	if (!count)
+		return 0;
+
+	return (count - 1) / dev->clk_rate;
+}
+
+static const struct watchdog_info tangox_wdt_info = {
+	.options  = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "tangox watchdog",
+};
+
+static const struct watchdog_ops tangox_wdt_ops = {
+	.start		= tangox_wdt_start,
+	.stop		= tangox_wdt_stop,
+	.set_timeout	= tangox_wdt_set_timeout,
+	.get_timeleft	= tangox_wdt_get_timeleft,
+};
+
+static int tangox_wdt_restart(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct tangox_wdt_device *dev =
+		container_of(nb, struct tangox_wdt_device, restart);
+
+	writel(1, dev->base + WD_COUNTER);
+
+	return NOTIFY_DONE;
+}
+
+static int tangox_wdt_probe(struct platform_device *pdev)
+{
+	struct tangox_wdt_device *dev;
+	struct resource *res;
+	u32 config;
+	int err;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dev->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
+
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
+
+	err = clk_prepare_enable(dev->clk);
+	if (err)
+		return err;
+
+	dev->clk_rate = clk_get_rate(dev->clk);
+
+	dev->wdt.parent = &pdev->dev;
+	dev->wdt.info = &tangox_wdt_info;
+	dev->wdt.ops = &tangox_wdt_ops;
+	dev->wdt.timeout = DEFAULT_TIMEOUT;
+	dev->wdt.min_timeout = 1;
+	dev->wdt.max_timeout = (U32_MAX - 1) / dev->clk_rate;
+
+	watchdog_init_timeout(&dev->wdt, timeout, &pdev->dev);
+	watchdog_set_nowayout(&dev->wdt, nowayout);
+	watchdog_set_drvdata(&dev->wdt, dev);
+
+	/*
+	 * Deactivate counter if disable bit is set to avoid
+	 * accidental reset.
+	 */
+	config = readl(dev->base + WD_CONFIG);
+	if (config & WD_CONFIG_DISABLE)
+		writel(0, dev->base + WD_COUNTER);
+
+	writel(WD_CONFIG_XTAL_IN, dev->base + WD_CONFIG);
+
+	/*
+	 * Mark as active and restart with configured timeout if
+	 * already running.
+	 */
+	if (readl(dev->base + WD_COUNTER)) {
+		set_bit(WDOG_ACTIVE, &dev->wdt.status);
+		tangox_wdt_start(&dev->wdt);
+	}
+
+	err = watchdog_register_device(&dev->wdt);
+	if (err) {
+		clk_disable_unprepare(dev->clk);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, dev);
+
+	dev->restart.notifier_call = tangox_wdt_restart;
+	dev->restart.priority = 128;
+	err = register_restart_handler(&dev->restart);
+	if (err)
+		dev_warn(&pdev->dev, "failed to register restart handler\n");
+
+	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
+
+	return 0;
+}
+
+static int tangox_wdt_remove(struct platform_device *pdev)
+{
+	struct tangox_wdt_device *dev = platform_get_drvdata(pdev);
+
+	tangox_wdt_stop(&dev->wdt);
+	clk_disable_unprepare(dev->clk);
+
+	unregister_restart_handler(&dev->restart);
+	watchdog_unregister_device(&dev->wdt);
+
+	return 0;
+}
+
+static const struct of_device_id tangox_wdt_dt_ids[] = {
+	{ .compatible = "sigma,smp8642-wdt" },
+	{ .compatible = "sigma,smp8759-wdt" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tangox_wdt_dt_ids);
+
+static struct platform_driver tangox_wdt_driver = {
+	.probe	= tangox_wdt_probe,
+	.remove	= tangox_wdt_remove,
+	.driver	= {
+		.name		= "tangox-wdt",
+		.of_match_table	= tangox_wdt_dt_ids,
+	},
+};
+
+module_platform_driver(tangox_wdt_driver);
+
+MODULE_AUTHOR("Mans Rullgard <mans@mansr.com>");
+MODULE_DESCRIPTION("SMP86xx/SMP87xx Watchdog driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
new file mode 100644
index 0000000..2b8de86
--- /dev/null
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -0,0 +1,215 @@
+/*
+ * Watchdog driver for TS-4800 based boards
+ *
+ * Copyright (c) 2015 - Savoir-faire Linux
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+	"Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+/* possible feed values */
+#define TS4800_WDT_FEED_2S       0x1
+#define TS4800_WDT_FEED_10S      0x2
+#define TS4800_WDT_DISABLE       0x3
+
+struct ts4800_wdt {
+	struct watchdog_device  wdd;
+	struct regmap           *regmap;
+	u32                     feed_offset;
+	u32                     feed_val;
+};
+
+/*
+ * TS-4800 supports the following timeout values:
+ *
+ *   value desc
+ *   ---------------------
+ *     0    feed for 338ms
+ *     1    feed for 2.706s
+ *     2    feed for 10.824s
+ *     3    disable watchdog
+ *
+ * Keep the regmap/timeout map ordered by timeout
+ */
+static const struct {
+	const int timeout;
+	const int regval;
+} ts4800_wdt_map[] = {
+	{ 2,  TS4800_WDT_FEED_2S },
+	{ 10, TS4800_WDT_FEED_10S },
+};
+
+#define MAX_TIMEOUT_INDEX       (ARRAY_SIZE(ts4800_wdt_map) - 1)
+
+static void ts4800_write_feed(struct ts4800_wdt *wdt, u32 val)
+{
+	regmap_write(wdt->regmap, wdt->feed_offset, val);
+}
+
+static int ts4800_wdt_start(struct watchdog_device *wdd)
+{
+	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	ts4800_write_feed(wdt, wdt->feed_val);
+	return 0;
+}
+
+static int ts4800_wdt_stop(struct watchdog_device *wdd)
+{
+	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	ts4800_write_feed(wdt, TS4800_WDT_DISABLE);
+	return 0;
+}
+
+static int ts4800_wdt_set_timeout(struct watchdog_device *wdd,
+				  unsigned int timeout)
+{
+	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
+	int i;
+
+	for (i = 0; i < MAX_TIMEOUT_INDEX; i++) {
+		if (ts4800_wdt_map[i].timeout >= timeout)
+			break;
+	}
+
+	wdd->timeout = ts4800_wdt_map[i].timeout;
+	wdt->feed_val = ts4800_wdt_map[i].regval;
+
+	return 0;
+}
+
+static const struct watchdog_ops ts4800_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = ts4800_wdt_start,
+	.stop = ts4800_wdt_stop,
+	.set_timeout = ts4800_wdt_set_timeout,
+};
+
+static const struct watchdog_info ts4800_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "TS-4800 Watchdog",
+};
+
+static int ts4800_wdt_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *syscon_np;
+	struct watchdog_device *wdd;
+	struct ts4800_wdt *wdt;
+	u32 reg;
+	int ret;
+
+	syscon_np = of_parse_phandle(np, "syscon", 0);
+	if (!syscon_np) {
+		dev_err(&pdev->dev, "no syscon property\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32_index(np, "syscon", 1, &reg);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no offset in syscon\n");
+		return ret;
+	}
+
+	/* allocate memory for watchdog struct */
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	/* set regmap and offset to know where to write */
+	wdt->feed_offset = reg;
+	wdt->regmap = syscon_node_to_regmap(syscon_np);
+	if (IS_ERR(wdt->regmap)) {
+		dev_err(&pdev->dev, "cannot get parent's regmap\n");
+		return PTR_ERR(wdt->regmap);
+	}
+
+	/* Initialize struct watchdog_device */
+	wdd = &wdt->wdd;
+	wdd->parent = &pdev->dev;
+	wdd->info = &ts4800_wdt_info;
+	wdd->ops = &ts4800_wdt_ops;
+	wdd->min_timeout = ts4800_wdt_map[0].timeout;
+	wdd->max_timeout = ts4800_wdt_map[MAX_TIMEOUT_INDEX].timeout;
+
+	watchdog_set_drvdata(wdd, wdt);
+	watchdog_set_nowayout(wdd, nowayout);
+	watchdog_init_timeout(wdd, 0, &pdev->dev);
+
+	/*
+	 * As this watchdog supports only a few values, ts4800_wdt_set_timeout
+	 * must be called to initialize timeout and feed_val with valid values.
+	 * Default to maximum timeout if none, or an invalid one, is provided in
+	 * device tree.
+	 */
+	if (!wdd->timeout)
+		wdd->timeout = wdd->max_timeout;
+	ts4800_wdt_set_timeout(wdd, wdd->timeout);
+
+	/*
+	 * The feed register is write-only, so it is not possible to determine
+	 * watchdog's state. Disable it to be in a known state.
+	 */
+	ts4800_wdt_stop(wdd);
+
+	ret = watchdog_register_device(wdd);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register watchdog device\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+
+	dev_info(&pdev->dev,
+		 "initialized (timeout = %d sec, nowayout = %d)\n",
+		 wdd->timeout, nowayout);
+
+	return 0;
+}
+
+static int ts4800_wdt_remove(struct platform_device *pdev)
+{
+	struct ts4800_wdt *wdt = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&wdt->wdd);
+
+	return 0;
+}
+
+static const struct of_device_id ts4800_wdt_of_match[] = {
+	{ .compatible = "technologic,ts4800-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ts4800_wdt_of_match);
+
+static struct platform_driver ts4800_wdt_driver = {
+	.probe		= ts4800_wdt_probe,
+	.remove		= ts4800_wdt_remove,
+	.driver		= {
+		.name	= "ts4800_wdt",
+		.of_match_table = ts4800_wdt_of_match,
+	},
+};
+
+module_platform_driver(ts4800_wdt_driver);
+
+MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:ts4800_wdt");
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 5824e25..cab14bc 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -36,8 +36,6 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/ioport.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/io.h>
 
@@ -288,18 +286,6 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 }
 
 /*
- *	Notifier for system down
- */
-static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
-	void *unused)
-{
-	if (code == SYS_DOWN || code == SYS_HALT)
-		wdt_set_time(0);	/* Turn the WDT off */
-
-	return NOTIFY_DONE;
-}
-
-/*
  *	Kernel Interfaces
  */
 
@@ -329,10 +315,6 @@ static struct watchdog_device wdt_dev = {
  *	turn the timebomb registers off.
  */
 
-static struct notifier_block wdt_notifier = {
-	.notifier_call = wdt_notify_sys,
-};
-
 static int wdt_find(int addr)
 {
 	u8 val;
@@ -456,6 +438,7 @@ static int __init wdt_init(void)
 
 	watchdog_init_timeout(&wdt_dev, timeout, NULL);
 	watchdog_set_nowayout(&wdt_dev, nowayout);
+	watchdog_stop_on_reboot(&wdt_dev);
 
 	ret = w83627hf_init(&wdt_dev, chip);
 	if (ret) {
@@ -463,30 +446,19 @@ static int __init wdt_init(void)
 		return ret;
 	}
 
-	ret = register_reboot_notifier(&wdt_notifier);
-	if (ret != 0) {
-		pr_err("cannot register reboot notifier (err=%d)\n", ret);
-		return ret;
-	}
-
 	ret = watchdog_register_device(&wdt_dev);
 	if (ret)
-		goto unreg_reboot;
+		return ret;
 
 	pr_info("initialized. timeout=%d sec (nowayout=%d)\n",
 		wdt_dev.timeout, nowayout);
 
 	return ret;
-
-unreg_reboot:
-	unregister_reboot_notifier(&wdt_notifier);
-	return ret;
 }
 
 static void __exit wdt_exit(void)
 {
 	watchdog_unregister_device(&wdt_dev);
-	unregister_reboot_notifier(&wdt_notifier);
 }
 
 module_init(wdt_init);
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 873f139..e600fd9 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -32,6 +32,7 @@
 #include <linux/types.h>	/* For standard types */
 #include <linux/errno.h>	/* For the -ENODEV/... values */
 #include <linux/kernel.h>	/* For printk/panic/... */
+#include <linux/reboot.h>	/* For restart handler */
 #include <linux/watchdog.h>	/* For watchdog specific items */
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/idr.h>		/* For ida_* macros */
@@ -41,7 +42,6 @@
 #include "watchdog_core.h"	/* For watchdog_dev_register/... */
 
 static DEFINE_IDA(watchdog_ida);
-static struct class *watchdog_class;
 
 /*
  * Deferred Registration infrastructure.
@@ -137,9 +137,63 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
+static int watchdog_reboot_notifier(struct notifier_block *nb,
+				    unsigned long code, void *data)
+{
+	struct watchdog_device *wdd = container_of(nb, struct watchdog_device,
+						   reboot_nb);
+
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		if (watchdog_active(wdd)) {
+			int ret;
+
+			ret = wdd->ops->stop(wdd);
+			if (ret)
+				return NOTIFY_BAD;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int watchdog_restart_notifier(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct watchdog_device *wdd = container_of(nb, struct watchdog_device,
+						   restart_nb);
+
+	int ret;
+
+	ret = wdd->ops->restart(wdd);
+	if (ret)
+		return NOTIFY_BAD;
+
+	return NOTIFY_DONE;
+}
+
+/**
+ * watchdog_set_restart_priority - Change priority of restart handler
+ * @wdd: watchdog device
+ * @priority: priority of the restart handler, should follow these guidelines:
+ *   0:   use watchdog's restart function as last resort, has limited restart
+ *        capabilies
+ *   128: default restart handler, use if no other handler is expected to be
+ *        available and/or if restart is sufficient to restart the entire system
+ *   255: preempt all other handlers
+ *
+ * If a wdd->ops->restart function is provided when watchdog_register_device is
+ * called, it will be registered as a restart handler with the priority given
+ * here.
+ */
+void watchdog_set_restart_priority(struct watchdog_device *wdd, int priority)
+{
+	wdd->restart_nb.priority = priority;
+}
+EXPORT_SYMBOL_GPL(watchdog_set_restart_priority);
+
 static int __watchdog_register_device(struct watchdog_device *wdd)
 {
-	int ret, id = -1, devno;
+	int ret, id = -1;
 
 	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
 		return -EINVAL;
@@ -156,8 +210,6 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 	 * corrupted in a later stage then we expect a kernel panic!
 	 */
 
-	mutex_init(&wdd->lock);
-
 	/* Use alias for watchdog id if possible */
 	if (wdd->parent) {
 		ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
@@ -192,14 +244,26 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		}
 	}
 
-	devno = wdd->cdev.dev;
-	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
-					NULL, "watchdog%d", wdd->id);
-	if (IS_ERR(wdd->dev)) {
-		watchdog_dev_unregister(wdd);
-		ida_simple_remove(&watchdog_ida, id);
-		ret = PTR_ERR(wdd->dev);
-		return ret;
+	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
+		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
+
+		ret = register_reboot_notifier(&wdd->reboot_nb);
+		if (ret) {
+			pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
+			       wdd->id, ret);
+			watchdog_dev_unregister(wdd);
+			ida_simple_remove(&watchdog_ida, wdd->id);
+			return ret;
+		}
+	}
+
+	if (wdd->ops->restart) {
+		wdd->restart_nb.notifier_call = watchdog_restart_notifier;
+
+		ret = register_restart_handler(&wdd->restart_nb);
+		if (ret)
+			pr_warn("watchog%d: Cannot register restart handler (%d)\n",
+				wdd->id, ret);
 	}
 
 	return 0;
@@ -232,19 +296,17 @@ EXPORT_SYMBOL_GPL(watchdog_register_device);
 
 static void __watchdog_unregister_device(struct watchdog_device *wdd)
 {
-	int ret;
-	int devno;
-
 	if (wdd == NULL)
 		return;
 
-	devno = wdd->cdev.dev;
-	ret = watchdog_dev_unregister(wdd);
-	if (ret)
-		pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);
-	device_destroy(watchdog_class, devno);
+	if (wdd->ops->restart)
+		unregister_restart_handler(&wdd->restart_nb);
+
+	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
+		unregister_reboot_notifier(&wdd->reboot_nb);
+
+	watchdog_dev_unregister(wdd);
 	ida_simple_remove(&watchdog_ida, wdd->id);
-	wdd->dev = NULL;
 }
 
 /**
@@ -287,17 +349,9 @@ static int __init watchdog_init(void)
 {
 	int err;
 
-	watchdog_class = class_create(THIS_MODULE, "watchdog");
-	if (IS_ERR(watchdog_class)) {
-		pr_err("couldn't create class\n");
-		return PTR_ERR(watchdog_class);
-	}
-
 	err = watchdog_dev_init();
-	if (err < 0) {
-		class_destroy(watchdog_class);
+	if (err < 0)
 		return err;
-	}
 
 	watchdog_deferred_registration();
 	return 0;
@@ -306,7 +360,6 @@ static int __init watchdog_init(void)
 static void __exit watchdog_exit(void)
 {
 	watchdog_dev_exit();
-	class_destroy(watchdog_class);
 	ida_destroy(&watchdog_ida);
 }
 
diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
index 6c95141..86ff962 100644
--- a/drivers/watchdog/watchdog_core.h
+++ b/drivers/watchdog/watchdog_core.h
@@ -32,6 +32,6 @@
  *	Functions/procedures to be called by the core
  */
 extern int watchdog_dev_register(struct watchdog_device *);
-extern int watchdog_dev_unregister(struct watchdog_device *);
+extern void watchdog_dev_unregister(struct watchdog_device *);
 extern int __init watchdog_dev_init(void);
 extern void __exit watchdog_dev_exit(void);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 56a649e..ba2ecce 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -32,27 +32,51 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>	/* For module stuff/... */
-#include <linux/types.h>	/* For standard types (like size_t) */
+#include <linux/cdev.h>		/* For character device */
 #include <linux/errno.h>	/* For the -ENODEV/... values */
-#include <linux/kernel.h>	/* For printk/panic/... */
 #include <linux/fs.h>		/* For file operations */
-#include <linux/watchdog.h>	/* For watchdog specific items */
-#include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
+#include <linux/kernel.h>	/* For printk/panic/... */
+#include <linux/kref.h>		/* For data references */
+#include <linux/miscdevice.h>	/* For handling misc devices */
+#include <linux/module.h>	/* For module stuff/... */
+#include <linux/mutex.h>	/* For mutexes */
+#include <linux/slab.h>		/* For memory functions */
+#include <linux/types.h>	/* For standard types (like size_t) */
+#include <linux/watchdog.h>	/* For watchdog specific items */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
 
 #include "watchdog_core.h"
 
+/*
+ * struct watchdog_core_data - watchdog core internal data
+ * @kref:	Reference count.
+ * @cdev:	The watchdog's Character device.
+ * @wdd:	Pointer to watchdog device.
+ * @lock:	Lock for watchdog core.
+ * @status:	Watchdog core internal status bits.
+ */
+struct watchdog_core_data {
+	struct kref kref;
+	struct cdev cdev;
+	struct watchdog_device *wdd;
+	struct mutex lock;
+	unsigned long status;		/* Internal status bits */
+#define _WDOG_DEV_OPEN		0	/* Opened ? */
+#define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
+};
+
 /* the dev_t structure to store the dynamically allocated watchdog devices */
 static dev_t watchdog_devt;
-/* the watchdog device behind /dev/watchdog */
-static struct watchdog_device *old_wdd;
+/* Reference to watchdog device behind /dev/watchdog */
+static struct watchdog_core_data *old_wd_data;
 
 /*
  *	watchdog_ping: ping the watchdog.
  *	@wdd: the watchdog device to ping
  *
+ *	The caller must hold wd_data->lock.
+ *
  *	If the watchdog has no own ping operation then it needs to be
  *	restarted via the start operation. This wrapper function does
  *	exactly that.
@@ -61,25 +85,16 @@ static struct watchdog_device *old_wdd;
 
 static int watchdog_ping(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_ping;
-	}
+	int err;
 
 	if (!watchdog_active(wdd))
-		goto out_ping;
+		return 0;
 
 	if (wdd->ops->ping)
 		err = wdd->ops->ping(wdd);	/* ping the watchdog */
 	else
 		err = wdd->ops->start(wdd);	/* restart watchdog */
 
-out_ping:
-	mutex_unlock(&wdd->lock);
 	return err;
 }
 
@@ -87,6 +102,8 @@ out_ping:
  *	watchdog_start: wrapper to start the watchdog.
  *	@wdd: the watchdog device to start
  *
+ *	The caller must hold wd_data->lock.
+ *
  *	Start the watchdog if it is not active and mark it active.
  *	This function returns zero on success or a negative errno code for
  *	failure.
@@ -94,24 +111,15 @@ out_ping:
 
 static int watchdog_start(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_start;
-	}
+	int err;
 
 	if (watchdog_active(wdd))
-		goto out_start;
+		return 0;
 
 	err = wdd->ops->start(wdd);
 	if (err == 0)
 		set_bit(WDOG_ACTIVE, &wdd->status);
 
-out_start:
-	mutex_unlock(&wdd->lock);
 	return err;
 }
 
@@ -119,6 +127,8 @@ out_start:
  *	watchdog_stop: wrapper to stop the watchdog.
  *	@wdd: the watchdog device to stop
  *
+ *	The caller must hold wd_data->lock.
+ *
  *	Stop the watchdog if it is still active and unmark it active.
  *	This function returns zero on success or a negative errno code for
  *	failure.
@@ -127,93 +137,59 @@ out_start:
 
 static int watchdog_stop(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_stop;
-	}
+	int err;
 
 	if (!watchdog_active(wdd))
-		goto out_stop;
+		return 0;
 
 	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
-		dev_info(wdd->dev, "nowayout prevents watchdog being stopped!\n");
-		err = -EBUSY;
-		goto out_stop;
+		pr_info("watchdog%d: nowayout prevents watchdog being stopped!\n",
+			wdd->id);
+		return -EBUSY;
 	}
 
 	err = wdd->ops->stop(wdd);
 	if (err == 0)
 		clear_bit(WDOG_ACTIVE, &wdd->status);
 
-out_stop:
-	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_get_status: wrapper to get the watchdog status
  *	@wdd: the watchdog device to get the status from
- *	@status: the status of the watchdog device
+ *
+ *	The caller must hold wd_data->lock.
  *
  *	Get the watchdog's status flags.
  */
 
-static int watchdog_get_status(struct watchdog_device *wdd,
-							unsigned int *status)
+static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	*status = 0;
 	if (!wdd->ops->status)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_status;
-	}
-
-	*status = wdd->ops->status(wdd);
+		return 0;
 
-out_status:
-	mutex_unlock(&wdd->lock);
-	return err;
+	return wdd->ops->status(wdd);
 }
 
 /*
  *	watchdog_set_timeout: set the watchdog timer timeout
  *	@wdd: the watchdog device to set the timeout for
  *	@timeout: timeout to set in seconds
+ *
+ *	The caller must hold wd_data->lock.
  */
 
 static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
-	int err;
-
 	if (!wdd->ops->set_timeout || !(wdd->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
 	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_timeout;
-	}
-
-	err = wdd->ops->set_timeout(wdd, timeout);
-
-out_timeout:
-	mutex_unlock(&wdd->lock);
-	return err;
+	return wdd->ops->set_timeout(wdd, timeout);
 }
 
 /*
@@ -221,59 +197,156 @@ out_timeout:
  *	@wdd: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
  *
+ *	The caller must hold wd_data->lock.
+ *
  *	Get the time before a watchdog will reboot (if not pinged).
  */
 
 static int watchdog_get_timeleft(struct watchdog_device *wdd,
 							unsigned int *timeleft)
 {
-	int err = 0;
-
 	*timeleft = 0;
+
 	if (!wdd->ops->get_timeleft)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&wdd->lock);
+	*timeleft = wdd->ops->get_timeleft(wdd);
 
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_timeleft;
-	}
+	return 0;
+}
 
-	*timeleft = wdd->ops->get_timeleft(wdd);
+#ifdef CONFIG_WATCHDOG_SYSFS
+static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-out_timeleft:
-	mutex_unlock(&wdd->lock);
-	return err;
+	return sprintf(buf, "%d\n", !!test_bit(WDOG_NO_WAY_OUT, &wdd->status));
+}
+static DEVICE_ATTR_RO(nowayout);
+
+static ssize_t status_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+	unsigned int status;
+
+	mutex_lock(&wd_data->lock);
+	status = watchdog_get_status(wdd);
+	mutex_unlock(&wd_data->lock);
+
+	return sprintf(buf, "%u\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
+static ssize_t bootstatus_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", wdd->bootstatus);
+}
+static DEVICE_ATTR_RO(bootstatus);
+
+static ssize_t timeleft_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+	ssize_t status;
+	unsigned int val;
+
+	mutex_lock(&wd_data->lock);
+	status = watchdog_get_timeleft(wdd, &val);
+	mutex_unlock(&wd_data->lock);
+	if (!status)
+		status = sprintf(buf, "%u\n", val);
+
+	return status;
 }
+static DEVICE_ATTR_RO(timeleft);
+
+static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", wdd->timeout);
+}
+static DEVICE_ATTR_RO(timeout);
+
+static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", wdd->info->identity);
+}
+static DEVICE_ATTR_RO(identity);
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	if (watchdog_active(wdd))
+		return sprintf(buf, "active\n");
+
+	return sprintf(buf, "inactive\n");
+}
+static DEVICE_ATTR_RO(state);
+
+static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
+				int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+	umode_t mode = attr->mode;
+
+	if (attr == &dev_attr_status.attr && !wdd->ops->status)
+		mode = 0;
+	else if (attr == &dev_attr_timeleft.attr && !wdd->ops->get_timeleft)
+		mode = 0;
+
+	return mode;
+}
+static struct attribute *wdt_attrs[] = {
+	&dev_attr_state.attr,
+	&dev_attr_identity.attr,
+	&dev_attr_timeout.attr,
+	&dev_attr_timeleft.attr,
+	&dev_attr_bootstatus.attr,
+	&dev_attr_status.attr,
+	&dev_attr_nowayout.attr,
+	NULL,
+};
+
+static const struct attribute_group wdt_group = {
+	.attrs = wdt_attrs,
+	.is_visible = wdt_is_visible,
+};
+__ATTRIBUTE_GROUPS(wdt);
+#else
+#define wdt_groups	NULL
+#endif
 
 /*
  *	watchdog_ioctl_op: call the watchdog drivers ioctl op if defined
  *	@wdd: the watchdog device to do the ioctl on
  *	@cmd: watchdog command
  *	@arg: argument pointer
+ *
+ *	The caller must hold wd_data->lock.
  */
 
 static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
 							unsigned long arg)
 {
-	int err;
-
 	if (!wdd->ops->ioctl)
 		return -ENOIOCTLCMD;
 
-	mutex_lock(&wdd->lock);
-
-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
-		err = -ENODEV;
-		goto out_ioctl;
-	}
-
-	err = wdd->ops->ioctl(wdd, cmd, arg);
-
-out_ioctl:
-	mutex_unlock(&wdd->lock);
-	return err;
+	return wdd->ops->ioctl(wdd, cmd, arg);
 }
 
 /*
@@ -291,10 +364,11 @@ out_ioctl:
 static ssize_t watchdog_write(struct file *file, const char __user *data,
 						size_t len, loff_t *ppos)
 {
-	struct watchdog_device *wdd = file->private_data;
+	struct watchdog_core_data *wd_data = file->private_data;
+	struct watchdog_device *wdd;
+	int err;
 	size_t i;
 	char c;
-	int err;
 
 	if (len == 0)
 		return 0;
@@ -303,18 +377,25 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 	 * Note: just in case someone wrote the magic character
 	 * five months ago...
 	 */
-	clear_bit(WDOG_ALLOW_RELEASE, &wdd->status);
+	clear_bit(_WDOG_ALLOW_RELEASE, &wd_data->status);
 
 	/* scan to see whether or not we got the magic character */
 	for (i = 0; i != len; i++) {
 		if (get_user(c, data + i))
 			return -EFAULT;
 		if (c == 'V')
-			set_bit(WDOG_ALLOW_RELEASE, &wdd->status);
+			set_bit(_WDOG_ALLOW_RELEASE, &wd_data->status);
 	}
 
 	/* someone wrote to us, so we send the watchdog a keepalive ping */
-	err = watchdog_ping(wdd);
+
+	err = -ENODEV;
+	mutex_lock(&wd_data->lock);
+	wdd = wd_data->wdd;
+	if (wdd)
+		err = watchdog_ping(wdd);
+	mutex_unlock(&wd_data->lock);
+
 	if (err < 0)
 		return err;
 
@@ -334,71 +415,94 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 static long watchdog_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
-	struct watchdog_device *wdd = file->private_data;
+	struct watchdog_core_data *wd_data = file->private_data;
 	void __user *argp = (void __user *)arg;
+	struct watchdog_device *wdd;
 	int __user *p = argp;
 	unsigned int val;
 	int err;
 
+	mutex_lock(&wd_data->lock);
+
+	wdd = wd_data->wdd;
+	if (!wdd) {
+		err = -ENODEV;
+		goto out_ioctl;
+	}
+
 	err = watchdog_ioctl_op(wdd, cmd, arg);
 	if (err != -ENOIOCTLCMD)
-		return err;
+		goto out_ioctl;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, wdd->info,
+		err = copy_to_user(argp, wdd->info,
 			sizeof(struct watchdog_info)) ? -EFAULT : 0;
+		break;
 	case WDIOC_GETSTATUS:
-		err = watchdog_get_status(wdd, &val);
-		if (err == -ENODEV)
-			return err;
-		return put_user(val, p);
+		val = watchdog_get_status(wdd);
+		err = put_user(val, p);
+		break;
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(wdd->bootstatus, p);
+		err = put_user(wdd->bootstatus, p);
+		break;
 	case WDIOC_SETOPTIONS:
-		if (get_user(val, p))
-			return -EFAULT;
+		if (get_user(val, p)) {
+			err = -EFAULT;
+			break;
+		}
 		if (val & WDIOS_DISABLECARD) {
 			err = watchdog_stop(wdd);
 			if (err < 0)
-				return err;
+				break;
 		}
-		if (val & WDIOS_ENABLECARD) {
+		if (val & WDIOS_ENABLECARD)
 			err = watchdog_start(wdd);
-			if (err < 0)
-				return err;
-		}
-		return 0;
+		break;
 	case WDIOC_KEEPALIVE:
-		if (!(wdd->info->options & WDIOF_KEEPALIVEPING))
-			return -EOPNOTSUPP;
-		return watchdog_ping(wdd);
+		if (!(wdd->info->options & WDIOF_KEEPALIVEPING)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		err = watchdog_ping(wdd);
+		break;
 	case WDIOC_SETTIMEOUT:
-		if (get_user(val, p))
-			return -EFAULT;
+		if (get_user(val, p)) {
+			err = -EFAULT;
+			break;
+		}
 		err = watchdog_set_timeout(wdd, val);
 		if (err < 0)
-			return err;
+			break;
 		/* If the watchdog is active then we send a keepalive ping
 		 * to make sure that the watchdog keep's running (and if
 		 * possible that it takes the new timeout) */
 		err = watchdog_ping(wdd);
 		if (err < 0)
-			return err;
+			break;
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		/* timeout == 0 means that we don't know the timeout */
-		if (wdd->timeout == 0)
-			return -EOPNOTSUPP;
-		return put_user(wdd->timeout, p);
+		if (wdd->timeout == 0) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		err = put_user(wdd->timeout, p);
+		break;
 	case WDIOC_GETTIMELEFT:
 		err = watchdog_get_timeleft(wdd, &val);
-		if (err)
-			return err;
-		return put_user(val, p);
+		if (err < 0)
+			break;
+		err = put_user(val, p);
+		break;
 	default:
-		return -ENOTTY;
+		err = -ENOTTY;
+		break;
 	}
+
+out_ioctl:
+	mutex_unlock(&wd_data->lock);
+	return err;
 }
 
 /*
@@ -413,45 +517,59 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 
 static int watchdog_open(struct inode *inode, struct file *file)
 {
-	int err = -EBUSY;
+	struct watchdog_core_data *wd_data;
 	struct watchdog_device *wdd;
+	int err;
 
 	/* Get the corresponding watchdog device */
 	if (imajor(inode) == MISC_MAJOR)
-		wdd = old_wdd;
+		wd_data = old_wd_data;
 	else
-		wdd = container_of(inode->i_cdev, struct watchdog_device, cdev);
+		wd_data = container_of(inode->i_cdev, struct watchdog_core_data,
+				       cdev);
 
 	/* the watchdog is single open! */
-	if (test_and_set_bit(WDOG_DEV_OPEN, &wdd->status))
+	if (test_and_set_bit(_WDOG_DEV_OPEN, &wd_data->status))
 		return -EBUSY;
 
+	wdd = wd_data->wdd;
+
 	/*
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!try_module_get(wdd->ops->owner))
-		goto out;
+	if (!try_module_get(wdd->ops->owner)) {
+		err = -EBUSY;
+		goto out_clear;
+	}
 
 	err = watchdog_start(wdd);
 	if (err < 0)
 		goto out_mod;
 
-	file->private_data = wdd;
+	file->private_data = wd_data;
 
-	if (wdd->ops->ref)
-		wdd->ops->ref(wdd);
+	kref_get(&wd_data->kref);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return nonseekable_open(inode, file);
 
 out_mod:
-	module_put(wdd->ops->owner);
-out:
-	clear_bit(WDOG_DEV_OPEN, &wdd->status);
+	module_put(wd_data->wdd->ops->owner);
+out_clear:
+	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 	return err;
 }
 
+static void watchdog_core_data_release(struct kref *kref)
+{
+	struct watchdog_core_data *wd_data;
+
+	wd_data = container_of(kref, struct watchdog_core_data, kref);
+
+	kfree(wd_data);
+}
+
 /*
  *	watchdog_release: release the watchdog device.
  *	@inode: inode of device
@@ -464,9 +582,16 @@ out:
 
 static int watchdog_release(struct inode *inode, struct file *file)
 {
-	struct watchdog_device *wdd = file->private_data;
+	struct watchdog_core_data *wd_data = file->private_data;
+	struct watchdog_device *wdd;
 	int err = -EBUSY;
 
+	mutex_lock(&wd_data->lock);
+
+	wdd = wd_data->wdd;
+	if (!wdd)
+		goto done;
+
 	/*
 	 * We only stop the watchdog if we received the magic character
 	 * or if WDIOF_MAGICCLOSE is not set. If nowayout was set then
@@ -474,29 +599,24 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	 */
 	if (!test_bit(WDOG_ACTIVE, &wdd->status))
 		err = 0;
-	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
+	else if (test_and_clear_bit(_WDOG_ALLOW_RELEASE, &wd_data->status) ||
 		 !(wdd->info->options & WDIOF_MAGICCLOSE))
 		err = watchdog_stop(wdd);
 
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
-		mutex_lock(&wdd->lock);
-		if (!test_bit(WDOG_UNREGISTERED, &wdd->status))
-			dev_crit(wdd->dev, "watchdog did not stop!\n");
-		mutex_unlock(&wdd->lock);
+		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
 		watchdog_ping(wdd);
 	}
 
-	/* Allow the owner module to be unloaded again */
-	module_put(wdd->ops->owner);
-
 	/* make sure that /dev/watchdog can be re-opened */
-	clear_bit(WDOG_DEV_OPEN, &wdd->status);
-
-	/* Note wdd may be gone after this, do not use after this! */
-	if (wdd->ops->unref)
-		wdd->ops->unref(wdd);
+	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 
+done:
+	mutex_unlock(&wd_data->lock);
+	/* Allow the owner module to be unloaded again */
+	module_put(wd_data->cdev.owner);
+	kref_put(&wd_data->kref, watchdog_core_data_release);
 	return 0;
 }
 
@@ -515,20 +635,31 @@ static struct miscdevice watchdog_miscdev = {
 };
 
 /*
- *	watchdog_dev_register: register a watchdog device
+ *	watchdog_cdev_register: register watchdog character device
  *	@wdd: watchdog device
+ *	@devno: character device number
  *
- *	Register a watchdog device including handling the legacy
+ *	Register a watchdog character device including handling the legacy
  *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
  *	thus we set it up like that.
  */
 
-int watchdog_dev_register(struct watchdog_device *wdd)
+static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 {
-	int err, devno;
+	struct watchdog_core_data *wd_data;
+	int err;
+
+	wd_data = kzalloc(sizeof(struct watchdog_core_data), GFP_KERNEL);
+	if (!wd_data)
+		return -ENOMEM;
+	kref_init(&wd_data->kref);
+	mutex_init(&wd_data->lock);
+
+	wd_data->wdd = wdd;
+	wdd->wd_data = wd_data;
 
 	if (wdd->id == 0) {
-		old_wdd = wdd;
+		old_wd_data = wd_data;
 		watchdog_miscdev.parent = wdd->parent;
 		err = misc_register(&watchdog_miscdev);
 		if (err != 0) {
@@ -537,48 +668,106 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 			if (err == -EBUSY)
 				pr_err("%s: a legacy watchdog module is probably present.\n",
 					wdd->info->identity);
-			old_wdd = NULL;
+			old_wd_data = NULL;
+			kfree(wd_data);
 			return err;
 		}
 	}
 
 	/* Fill in the data structures */
-	devno = MKDEV(MAJOR(watchdog_devt), wdd->id);
-	cdev_init(&wdd->cdev, &watchdog_fops);
-	wdd->cdev.owner = wdd->ops->owner;
+	cdev_init(&wd_data->cdev, &watchdog_fops);
+	wd_data->cdev.owner = wdd->ops->owner;
 
 	/* Add the device */
-	err  = cdev_add(&wdd->cdev, devno, 1);
+	err = cdev_add(&wd_data->cdev, devno, 1);
 	if (err) {
 		pr_err("watchdog%d unable to add device %d:%d\n",
 			wdd->id,  MAJOR(watchdog_devt), wdd->id);
 		if (wdd->id == 0) {
 			misc_deregister(&watchdog_miscdev);
-			old_wdd = NULL;
+			old_wd_data = NULL;
+			kref_put(&wd_data->kref, watchdog_core_data_release);
 		}
 	}
 	return err;
 }
 
 /*
- *	watchdog_dev_unregister: unregister a watchdog device
+ *	watchdog_cdev_unregister: unregister watchdog character device
  *	@watchdog: watchdog device
  *
- *	Unregister the watchdog and if needed the legacy /dev/watchdog device.
+ *	Unregister watchdog character device and if needed the legacy
+ *	/dev/watchdog device.
  */
 
-int watchdog_dev_unregister(struct watchdog_device *wdd)
+static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 {
-	mutex_lock(&wdd->lock);
-	set_bit(WDOG_UNREGISTERED, &wdd->status);
-	mutex_unlock(&wdd->lock);
+	struct watchdog_core_data *wd_data = wdd->wd_data;
 
-	cdev_del(&wdd->cdev);
+	cdev_del(&wd_data->cdev);
 	if (wdd->id == 0) {
 		misc_deregister(&watchdog_miscdev);
-		old_wdd = NULL;
+		old_wd_data = NULL;
 	}
-	return 0;
+
+	mutex_lock(&wd_data->lock);
+	wd_data->wdd = NULL;
+	wdd->wd_data = NULL;
+	mutex_unlock(&wd_data->lock);
+
+	kref_put(&wd_data->kref, watchdog_core_data_release);
+}
+
+static struct class watchdog_class = {
+	.name =		"watchdog",
+	.owner =	THIS_MODULE,
+	.dev_groups =	wdt_groups,
+};
+
+/*
+ *	watchdog_dev_register: register a watchdog device
+ *	@wdd: watchdog device
+ *
+ *	Register a watchdog device including handling the legacy
+ *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
+ *	thus we set it up like that.
+ */
+
+int watchdog_dev_register(struct watchdog_device *wdd)
+{
+	struct device *dev;
+	dev_t devno;
+	int ret;
+
+	devno = MKDEV(MAJOR(watchdog_devt), wdd->id);
+
+	ret = watchdog_cdev_register(wdd, devno);
+	if (ret)
+		return ret;
+
+	dev = device_create_with_groups(&watchdog_class, wdd->parent,
+					devno, wdd, wdd->groups,
+					"watchdog%d", wdd->id);
+	if (IS_ERR(dev)) {
+		watchdog_cdev_unregister(wdd);
+		return PTR_ERR(dev);
+	}
+
+	return ret;
+}
+
+/*
+ *	watchdog_dev_unregister: unregister a watchdog device
+ *	@watchdog: watchdog device
+ *
+ *	Unregister watchdog device and if needed the legacy
+ *	/dev/watchdog device.
+ */
+
+void watchdog_dev_unregister(struct watchdog_device *wdd)
+{
+	device_destroy(&watchdog_class, wdd->wd_data->cdev.dev);
+	watchdog_cdev_unregister(wdd);
 }
 
 /*
@@ -589,10 +778,22 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
 
 int __init watchdog_dev_init(void)
 {
-	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
-	if (err < 0)
+	int err;
+
+	err = class_register(&watchdog_class);
+	if (err < 0) {
+		pr_err("couldn't register class\n");
+		return err;
+	}
+
+	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
+	if (err < 0) {
 		pr_err("watchdog: unable to allocate char dev region\n");
-	return err;
+		class_unregister(&watchdog_class);
+		return err;
+	}
+
+	return 0;
 }
 
 /*
@@ -604,4 +805,5 @@ int __init watchdog_dev_init(void)
 void __exit watchdog_dev_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+	class_unregister(&watchdog_class);
 }
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
new file mode 100644
index 0000000..0c7cb73
--- /dev/null
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -0,0 +1,367 @@
+/*
+ * Copyright (C) 2015 Zodiac Inflight Innovations
+ *
+ * Author: Martyn Welch <martyn.welch@collabora.co.uk>
+ *
+ * Based on twl4030_wdt.c by Timo Kokkonen <timo.t.kokkonen at nokia.com>:
+ *
+ * Copyright (C) Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/watchdog.h>
+
+#define ZIIRAVE_TIMEOUT_MIN	3
+#define ZIIRAVE_TIMEOUT_MAX	255
+
+#define ZIIRAVE_PING_VALUE	0x0
+
+#define ZIIRAVE_STATE_INITIAL	0x0
+#define ZIIRAVE_STATE_OFF	0x1
+#define ZIIRAVE_STATE_ON	0x2
+
+static char *ziirave_reasons[] = {"power cycle", "triggered", NULL, NULL,
+				  "host request", NULL, "illegal configuration",
+				  "illegal instruction", "illegal trap",
+				  "unknown"};
+
+#define ZIIRAVE_WDT_FIRM_VER_MAJOR	0x1
+#define ZIIRAVE_WDT_BOOT_VER_MAJOR	0x3
+#define ZIIRAVE_WDT_RESET_REASON	0x5
+#define ZIIRAVE_WDT_STATE		0x6
+#define ZIIRAVE_WDT_TIMEOUT		0x7
+#define ZIIRAVE_WDT_TIME_LEFT		0x8
+#define ZIIRAVE_WDT_PING		0x9
+#define ZIIRAVE_WDT_RESET_DURATION	0xa
+
+struct ziirave_wdt_rev {
+	unsigned char major;
+	unsigned char minor;
+};
+
+struct ziirave_wdt_data {
+	struct watchdog_device wdd;
+	struct ziirave_wdt_rev bootloader_rev;
+	struct ziirave_wdt_rev firmware_rev;
+	int reset_reason;
+};
+
+static int wdt_timeout;
+module_param(wdt_timeout, int, 0);
+MODULE_PARM_DESC(wdt_timeout, "Watchdog timeout in seconds");
+
+static int reset_duration;
+module_param(reset_duration, int, 0);
+MODULE_PARM_DESC(reset_duration,
+		 "Watchdog reset pulse duration in milliseconds");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int ziirave_wdt_revision(struct i2c_client *client,
+				struct ziirave_wdt_rev *rev, u8 command)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, command);
+	if (ret < 0)
+		return ret;
+
+	rev->major = ret;
+
+	ret = i2c_smbus_read_byte_data(client, command + 1);
+	if (ret < 0)
+		return ret;
+
+	rev->minor = ret;
+
+	return 0;
+}
+
+static int ziirave_wdt_set_state(struct watchdog_device *wdd, int state)
+{
+	struct i2c_client *client = to_i2c_client(wdd->parent);
+
+	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_STATE, state);
+}
+
+static int ziirave_wdt_start(struct watchdog_device *wdd)
+{
+	return ziirave_wdt_set_state(wdd, ZIIRAVE_STATE_ON);
+}
+
+static int ziirave_wdt_stop(struct watchdog_device *wdd)
+{
+	return ziirave_wdt_set_state(wdd, ZIIRAVE_STATE_OFF);
+}
+
+static int ziirave_wdt_ping(struct watchdog_device *wdd)
+{
+	struct i2c_client *client = to_i2c_client(wdd->parent);
+
+	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_PING,
+					 ZIIRAVE_PING_VALUE);
+}
+
+static int ziirave_wdt_set_timeout(struct watchdog_device *wdd,
+				   unsigned int timeout)
+{
+	struct i2c_client *client = to_i2c_client(wdd->parent);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_TIMEOUT, timeout);
+	if (!ret)
+		wdd->timeout = timeout;
+
+	return ret;
+}
+
+static unsigned int ziirave_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct i2c_client *client = to_i2c_client(wdd->parent);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIME_LEFT);
+	if (ret < 0)
+		ret = 0;
+
+	return ret;
+}
+
+static const struct watchdog_info ziirave_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "Zodiac RAVE Watchdog",
+};
+
+static const struct watchdog_ops ziirave_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= ziirave_wdt_start,
+	.stop		= ziirave_wdt_stop,
+	.ping		= ziirave_wdt_ping,
+	.set_timeout	= ziirave_wdt_set_timeout,
+	.get_timeleft	= ziirave_wdt_get_timeleft,
+};
+
+static ssize_t ziirave_wdt_sysfs_show_firm(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
+
+	return sprintf(buf, "02.%02u.%02u", w_priv->firmware_rev.major,
+		       w_priv->firmware_rev.minor);
+}
+
+static DEVICE_ATTR(firmware_version, S_IRUGO, ziirave_wdt_sysfs_show_firm,
+		   NULL);
+
+static ssize_t ziirave_wdt_sysfs_show_boot(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
+
+	return sprintf(buf, "01.%02u.%02u", w_priv->bootloader_rev.major,
+		       w_priv->bootloader_rev.minor);
+}
+
+static DEVICE_ATTR(bootloader_version, S_IRUGO, ziirave_wdt_sysfs_show_boot,
+		   NULL);
+
+static ssize_t ziirave_wdt_sysfs_show_reason(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
+
+	return sprintf(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
+}
+
+static DEVICE_ATTR(reset_reason, S_IRUGO, ziirave_wdt_sysfs_show_reason,
+		   NULL);
+
+static struct attribute *ziirave_wdt_attrs[] = {
+	&dev_attr_firmware_version.attr,
+	&dev_attr_bootloader_version.attr,
+	&dev_attr_reset_reason.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(ziirave_wdt);
+
+static int ziirave_wdt_init_duration(struct i2c_client *client)
+{
+	int ret;
+
+	if (!reset_duration) {
+		/* See if the reset pulse duration is provided in an of_node */
+		if (!client->dev.of_node)
+			ret = -ENODEV;
+		else
+			ret = of_property_read_u32(client->dev.of_node,
+						   "reset-duration-ms",
+						   &reset_duration);
+		if (ret) {
+			dev_info(&client->dev,
+				 "Unable to set reset pulse duration, using default\n");
+			return 0;
+		}
+	}
+
+	if (reset_duration < 1 || reset_duration > 255)
+		return -EINVAL;
+
+	dev_info(&client->dev, "Setting reset duration to %dms",
+		 reset_duration);
+
+	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_RESET_DURATION,
+					 reset_duration);
+}
+
+static int ziirave_wdt_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	int ret;
+	struct ziirave_wdt_data *w_priv;
+	int val;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	w_priv = devm_kzalloc(&client->dev, sizeof(*w_priv), GFP_KERNEL);
+	if (!w_priv)
+		return -ENOMEM;
+
+	w_priv->wdd.info = &ziirave_wdt_info;
+	w_priv->wdd.ops = &ziirave_wdt_ops;
+	w_priv->wdd.min_timeout = ZIIRAVE_TIMEOUT_MIN;
+	w_priv->wdd.max_timeout = ZIIRAVE_TIMEOUT_MAX;
+	w_priv->wdd.parent = &client->dev;
+	w_priv->wdd.groups = ziirave_wdt_groups;
+
+	ret = watchdog_init_timeout(&w_priv->wdd, wdt_timeout, &client->dev);
+	if (ret) {
+		dev_info(&client->dev,
+			 "Unable to select timeout value, using default\n");
+	}
+
+	/*
+	 * The default value set in the watchdog should be perfectly valid, so
+	 * pass that in if we haven't provided one via the module parameter or
+	 * of property.
+	 */
+	if (w_priv->wdd.timeout == 0) {
+		val = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIMEOUT);
+		if (val < 0)
+			return val;
+
+		if (val < ZIIRAVE_TIMEOUT_MIN)
+			return -ENODEV;
+
+		w_priv->wdd.timeout = val;
+	} else {
+		ret = ziirave_wdt_set_timeout(&w_priv->wdd,
+					      w_priv->wdd.timeout);
+		if (ret)
+			return ret;
+
+		dev_info(&client->dev, "Timeout set to %ds.",
+			 w_priv->wdd.timeout);
+	}
+
+	watchdog_set_nowayout(&w_priv->wdd, nowayout);
+
+	i2c_set_clientdata(client, w_priv);
+
+	/* If in unconfigured state, set to stopped */
+	val = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_STATE);
+	if (val < 0)
+		return val;
+
+	if (val == ZIIRAVE_STATE_INITIAL)
+		ziirave_wdt_stop(&w_priv->wdd);
+
+	ret = ziirave_wdt_init_duration(client);
+	if (ret)
+		return ret;
+
+	ret = ziirave_wdt_revision(client, &w_priv->firmware_rev,
+				   ZIIRAVE_WDT_FIRM_VER_MAJOR);
+	if (ret)
+		return ret;
+
+	ret = ziirave_wdt_revision(client, &w_priv->bootloader_rev,
+				   ZIIRAVE_WDT_BOOT_VER_MAJOR);
+	if (ret)
+		return ret;
+
+	w_priv->reset_reason = i2c_smbus_read_byte_data(client,
+						ZIIRAVE_WDT_RESET_REASON);
+	if (w_priv->reset_reason < 0)
+		return w_priv->reset_reason;
+
+	if (w_priv->reset_reason >= ARRAY_SIZE(ziirave_reasons) ||
+	    !ziirave_reasons[w_priv->reset_reason])
+		return -ENODEV;
+
+	ret = watchdog_register_device(&w_priv->wdd);
+
+	return ret;
+}
+
+static int ziirave_wdt_remove(struct i2c_client *client)
+{
+	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
+
+	watchdog_unregister_device(&w_priv->wdd);
+
+	return 0;
+}
+
+static struct i2c_device_id ziirave_wdt_id[] = {
+	{ "ziirave-wdt", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ziirave_wdt_id);
+
+static const struct of_device_id zrv_wdt_of_match[] = {
+	{ .compatible = "zii,rave-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, zrv_wdt_of_match);
+
+static struct i2c_driver ziirave_wdt_driver = {
+	.driver = {
+		.name = "ziirave_wdt",
+		.of_match_table = zrv_wdt_of_match,
+	},
+	.probe = ziirave_wdt_probe,
+	.remove = ziirave_wdt_remove,
+	.id_table = ziirave_wdt_id,
+};
+
+module_i2c_driver(ziirave_wdt_driver);
+
+MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.co.uk");
+MODULE_DESCRIPTION("Zodiac Aerospace RAVE Switch Watchdog Processor Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
index 5582c21..8d9d07e 100644
--- a/include/linux/bcm47xx_wdt.h
+++ b/include/linux/bcm47xx_wdt.h
@@ -1,7 +1,6 @@
 #ifndef LINUX_BCM47XX_WDT_H_
 #define LINUX_BCM47XX_WDT_H_
 
-#include <linux/notifier.h>
 #include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -15,8 +14,6 @@ struct bcm47xx_wdt {
 	void *driver_data;
 
 	struct watchdog_device wdd;
-	struct notifier_block notifier;
-	struct notifier_block restart_handler;
 
 	struct timer_list soft_timer;
 	atomic_t soft_ticks;
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 027b1f4..b585fa2 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -12,10 +12,12 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/notifier.h>
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
 struct watchdog_device;
+struct watchdog_core_data;
 
 /** struct watchdog_ops - The watchdog-devices operations
  *
@@ -26,8 +28,7 @@ struct watchdog_device;
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
  * @get_timeleft:The routine that gets the time left before a reset (in seconds).
- * @ref:	The ref operation for dyn. allocated watchdog_device structs
- * @unref:	The unref operation for dyn. allocated watchdog_device structs
+ * @restart:	The routine for restarting the machine.
  * @ioctl:	The routines that handles extra ioctl calls.
  *
  * The watchdog_ops structure contains a list of low-level operations
@@ -45,25 +46,26 @@ struct watchdog_ops {
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
-	void (*ref)(struct watchdog_device *);
-	void (*unref)(struct watchdog_device *);
+	int (*restart)(struct watchdog_device *);
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
 /** struct watchdog_device - The structure that defines a watchdog device
  *
  * @id:		The watchdog's ID. (Allocated by watchdog_register_device)
- * @cdev:	The watchdog's Character device.
- * @dev:	The device for our watchdog
  * @parent:	The parent bus device
+ * @groups:	List of sysfs attribute groups to create when creating the
+ *		watchdog device.
  * @info:	Pointer to a watchdog_info structure.
  * @ops:	Pointer to the list of watchdog operations.
  * @bootstatus:	Status of the watchdog device at boot.
  * @timeout:	The watchdog devices timeout value (in seconds).
  * @min_timeout:The watchdog devices minimum timeout value (in seconds).
  * @max_timeout:The watchdog devices maximum timeout value (in seconds).
- * @driver-data:Pointer to the drivers private data.
- * @lock:	Lock for watchdog core internal use only.
+ * @reboot_nb:	The notifier block to stop watchdog on reboot.
+ * @restart_nb:	The notifier block to register a restart function.
+ * @driver_data:Pointer to the drivers private data.
+ * @wd_data:	Pointer to watchdog core internal data.
  * @status:	Field that contains the devices internal status bits.
  * @deferred: entry in wtd_deferred_reg_list which is used to
  *			   register early initialized watchdogs.
@@ -79,24 +81,23 @@ struct watchdog_ops {
  */
 struct watchdog_device {
 	int id;
-	struct cdev cdev;
-	struct device *dev;
 	struct device *parent;
+	const struct attribute_group **groups;
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	struct notifier_block reboot_nb;
+	struct notifier_block restart_nb;
 	void *driver_data;
-	struct mutex lock;
+	struct watchdog_core_data *wd_data;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
-#define WDOG_DEV_OPEN		1	/* Opened via /dev/watchdog ? */
-#define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
-#define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
-#define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+#define WDOG_NO_WAY_OUT		1	/* Is 'nowayout' feature set ? */
+#define WDOG_STOP_ON_REBOOT	2	/* Should be stopped on reboot */
 	struct list_head deferred;
 };
 
@@ -116,6 +117,12 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
 		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
 }
 
+/* Use the following function to stop the watchdog on reboot */
+static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd)
+{
+	set_bit(WDOG_STOP_ON_REBOOT, &wdd->status);
+}
+
 /* Use the following function to check if a timeout value is invalid */
 static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
 {
@@ -142,6 +149,7 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 }
 
 /* drivers/watchdog/watchdog_core.c */
+void watchdog_set_restart_priority(struct watchdog_device *wdd, int priority);
 extern int watchdog_init_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout_parm, struct device *dev);
 extern int watchdog_register_device(struct watchdog_device *);
