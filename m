Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 18 Mar 2016 20:31:40 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Fu Wei <fu.wei@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Jean Delvare <jdelvare@suse.de>,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Rob Kramer <rob@solution-space.com>,
	Sylvain Lemieux <slemieux@tycoint.com>,
	Thierry Reding <treding@nvidia.com>,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [GIT PULL REQUEST] watchdog - v4.6 Merge Window
Message-ID: <20160318193140.GA24025@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It contains:
* new drivers for: NI 903x/913x watchdog driver, WinSystems EBC-C384
  watchdog timer and ARM SBSA watchdog driver
* Support for NCT6102D devices
* Improvements of the generic watchdog framework (improve restart
  handler, make set_timeout optional, introduce infrastructure
  triggered keepalives, ...
* improvements on the pnx4008 watchdog driver
* several smaller fixes and improvements

This will update the following files:

 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt |   31 +
 Documentation/watchdog/watchdog-kernel-api.txt           |   59 +-
 Documentation/watchdog/watchdog-parameters.txt           |   12 
 MAINTAINERS                                              |    6 
 arch/arm/mach-lpc32xx/common.c                           |   15 
 arch/arm/mach-lpc32xx/common.h                           |    1 
 arch/arm/mach-lpc32xx/phy3250.c                          |    1 
 drivers/watchdog/Kconfig                                 |   52 +
 drivers/watchdog/Makefile                                |    3 
 drivers/watchdog/atlas7_wdt.c                            |    5 
 drivers/watchdog/bcm47xx_wdt.c                           |    3 
 drivers/watchdog/da9063_wdt.c                            |    3 
 drivers/watchdog/digicolor_wdt.c                         |    3 
 drivers/watchdog/dw_wdt.c                                |  323 ++++-------
 drivers/watchdog/ebc-c384_wdt.c                          |  188 ++++++
 drivers/watchdog/imgpdc_wdt.c                            |    3 
 drivers/watchdog/imx2_wdt.c                              |   77 --
 drivers/watchdog/lpc18xx_wdt.c                           |    3 
 drivers/watchdog/meson_wdt.c                             |    3 
 drivers/watchdog/moxart_wdt.c                            |    3 
 drivers/watchdog/mtk_wdt.c                               |    3 
 drivers/watchdog/ni903x_wdt.c                            |  270 +++++++++
 drivers/watchdog/pnx4008_wdt.c                           |   42 +
 drivers/watchdog/qcom-wdt.c                              |    3 
 drivers/watchdog/rc32434_wdt.c                           |    2 
 drivers/watchdog/s3c2410_wdt.c                           |   19 
 drivers/watchdog/sbsa_gwdt.c                             |  408 +++++++++++++++
 drivers/watchdog/sunxi_wdt.c                             |    3 
 drivers/watchdog/tangox_wdt.c                            |   14 
 drivers/watchdog/w83627hf_wdt.c                          |   22 
 drivers/watchdog/watchdog_core.c                         |    4 
 drivers/watchdog/watchdog_dev.c                          |  207 ++++++-
 drivers/watchdog/ziirave_wdt.c                           |    2 
 include/linux/watchdog.h                                 |   43 +
 34 files changed, 1482 insertions(+), 354 deletions(-)

with these Changes:

commit d1ed3ba4e3d76b4ebec239c64f990c26d7935700
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Tue Mar 8 18:46:13 2016 -0800

    watchdog: Ensure that wdd is not dereferenced if NULL
    
    Smatch rightfully complains that wdd is dereferenced in the watchdog
    release function after being checked for NULL. Also make sure that it
    is not accessed outside mutex protection to avoid use-after-free problems.
    
    Fixes: e6c71e84e4c0 ("watchdog: Introduce WDOG_HW_RUNNING flag")
    Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 11d7aba9ceb726d86aaaca3eb5f7d79de38989c5
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 28 13:12:20 2016 -0800

    watchdog: imx2: Convert to use infrastructure triggered keepalives
    
    The watchdog infrastructure now supports handling watchdog keepalive
    if the watchdog is running while the watchdog device is closed.
    Convert the driver to use this infrastructure.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f29a72c24ad4927027e77e4eed431a61bc8335b2
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 28 13:12:19 2016 -0800

    watchdog: dw_wdt: Convert to use watchdog infrastructure
    
    Convert driver to use watchdog infrastructure. This includes
    infrastructure support to handle watchdog keepalive if the watchdog
    is running while the watchdog device is closed.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Tested-by: Douglas Anderson <dianders@chromium.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 15013ad813f6544be8e79afc23672745950d59bc
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 28 13:12:18 2016 -0800

    watchdog: Add support for minimum time between heartbeats
    
    Some watchdogs require a minimum time between heartbeats.
    Examples are the watchdogs in DA9062 and AT91SAM9x.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d0684c8a9354953efdea214b437445c00743cf49
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 28 13:12:17 2016 -0800

    watchdog: Make stop function optional
    
    Not all hardware watchdogs can be stopped. The driver for
    such watchdogs would typically only set the WATCHDOG_HW_RUNNING
    flag in its stop function. Make the stop function optional and set
    WATCHDOG_HW_RUNNING in the watchdog core if it is not provided.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ee142889e32f564f9b5e57b68b06693ec5473074
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 28 13:12:16 2016 -0800

    watchdog: Introduce WDOG_HW_RUNNING flag
    
    The WDOG_HW_RUNNING flag is expected to be set by watchdog drivers if
    the hardware watchdog is running. If the flag is set, the watchdog
    subsystem will ping the watchdog even if the watchdog device is closed.
    
    The watchdog driver stop function is now optional and may be omitted
    if the watchdog can not be stopped. If stopping the watchdog is not
    possible but the driver implements a stop function, it is responsible
    to set the WDOG_HW_RUNNING flag in its stop function.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 664a39236e718f9f03fa73fc01006da9ced04efc
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 28 13:12:15 2016 -0800

    watchdog: Introduce hardware maximum heartbeat in watchdog core
    
    Introduce an optional hardware maximum heartbeat in the watchdog core.
    The hardware maximum heartbeat can be lower than the maximum timeout.
    
    Drivers can set the maximum hardware heartbeat value in the watchdog data
    structure. If the configured timeout exceeds the maximum hardware heartbeat,
    the watchdog core enables a timer function to assist sending keepalive
    requests to the watchdog driver.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit fb32e9b9deeb5df2913deb7d2ae8c36f4f66ecf3
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sun Feb 28 13:12:14 2016 -0800

    watchdog: Make set_timeout function optional
    
    For some watchdogs, the watchdog driver handles timeout changes without
    explicitly setting any registers. In this situation, the watchdog driver
    might only set the 'timeout' variable but do nothing else.
    This can as well be handled by the infrastructure, so make the set_timeout
    callback optional. If WDIOF_SETTIMEOUT is configured but the .set_timeout
    callback is not available, update the timeout variable in the
    infrastructure code.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e21f56219bf636b4abd15a0b076a1c5cba381501
Author: Sylvain Lemieux <slemieux@tycoint.com>
Date:   Fri Mar 4 13:44:10 2016 -0500

    arm: lpc32xx: remove restart handler
    
    Remove the restart handler from "mach-lpc32xx";
    this functionality is now available in the
    pnx4008 watchdog driver.
    
    Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0a25345743aeae19ae61bd28b588cd4cb9f0123c
Author: Sylvain Lemieux <slemieux@tycoint.com>
Date:   Fri Mar 4 13:44:09 2016 -0500

    arm: lpc32xx: phy3250 remove restart hook
    
    Remove the restart hook assignment from phy3250;
    this functionality is now managed by
    the pnx4008 watchdog driver.
    
    Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 247dcad5c0361fdae06903f3b10855ba0381802d
Author: Sylvain Lemieux <slemieux@tycoint.com>
Date:   Fri Mar 4 13:44:08 2016 -0500

    watchdog: pnx4008: restart: support "cmd" from userspace
    
    Added support to verify if a "cmd" is passed from the userspace program rebooting the system;
    - if a valid "cmd" is available, handle it;
    - If the received "cmd" is not supported, use the default reboot mode.
    
    Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 25b286c02defa26b136818b17909789102225aa8
Author: Sylvain Lemieux <slemieux@tycoint.com>
Date:   Fri Mar 4 13:44:07 2016 -0500

    watchdog: pnx4008: add support for soft reset
    
    Add support for explicit soft reset using the reboot mode.
    
    The default reboot mode behavior is unchanged;
    you can overwrite the default reboot type in the board specific file
    "DT_MACHINE_START" definition using the "reboot_mode" parameter.
    
    Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 4ed5443d9175f4b6008ca18601672c812a1fe93b
Author: Sylvain Lemieux <slemieux@tycoint.com>
Date:   Fri Mar 4 13:44:06 2016 -0500

    watchdog: pnx4008: add restart handler
    
    Add restart handler capability to the driver;
    the restart handler implementation was taken from
    "mach-lpc32xx" ("lpc23xx_restart" function).
    
    Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 43eec2f50c65bd469989a4dab8c1b5e14d87db84
Author: Sylvain Lemieux <slemieux@tycoint.com>
Date:   Fri Mar 4 13:44:05 2016 -0500

    watchdog: pnx4008: update logging during power-on
    
    There is no need to add the driver name in the text to display
    on the console during the power-on:
    pnx4008-watchdog 4003c000.watchdog: PNX4008 Watchdog Timer: heartbeat 19 sec
    
    Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 84b84bcf4f718b7b9f5296d4068025fea801a0e1
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Thu Mar 3 09:24:12 2016 +0100

    watchdog: tangox_wdt: test clock rate to avoid division by 0
    
    The clk API may return 0 on clk_get_rate, so we should check the result before
    using it as a divisor. For this, refactor the code to use a central
    error path.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ccc8208d0855a5b02a4fc49c141b6f1dbf282304
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Wed Mar 2 23:33:36 2016 +0100

    watchdog: atlas7_wdt: test clock rate to avoid division by 0
    
    The clk API may return 0 on clk_get_rate, so we should check the result before
    using it as a divisor.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 882dec1ff125e9020157d27672ec11c2fdfb82c2
Author: Javier Martinez Canillas <javier@osg.samsung.com>
Date:   Tue Mar 1 13:45:17 2016 -0300

    watchdog: s3c2410_wdt: Add max and min timeout values
    
    The watchdog maximum timeout value is determined by the number of bits
    for the interval timer counter, its source clock frequency, the number
    of bits of the prescaler and maximum divider value.
    
    This can be calculated with the following equation:
    
    max_timeout = counter / (freq / (max_prescale + 1) / max_divider)
    
    Setting a maximum timeout value will allow the watchdog core to refuse
    user-space calls to the WDIOC_SETTIMEOUT ioctl that sets not supported
    timeout values.
    
    For example, systemd tries to set a timeout of 10 minutes on reboot to
    ensure that the machine will be rebooted even if a reboot failed. This
    leads to the following error message on an Exynos5422 Odroid XU4 board:
    
    [  147.986045] s3c2410-wdt 101d0000.watchdog: timeout 600 too big
    
    Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
    Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
    Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 57d2caaabfc744692e36ff83b508d7c52c70e36f
Author: Fu Wei <fu.wei@linaro.org>
Date:   Mon Feb 29 16:46:50 2016 +0800

    Watchdog: introduce ARM SBSA watchdog driver
    
    According to Server Base System Architecture (SBSA) specification,
    the SBSA Generic Watchdog has two stage timeouts: the first signal (WS0)
    is for alerting the system by interrupt, the second one (WS1) is a real
    hardware reset.
    More details about the hardware specification of this device:
    ARM DEN0029B - Server Base System Architecture (SBSA)
    
    This driver can operate ARM SBSA Generic Watchdog as a single stage watchdog
    or a two stages watchdog, it's set up by the module parameter "action".
    In the single stage mode, when the timeout is reached, your system
    will be reset by WS1. The first signal (WS0) is ignored.
    In the two stages mode, when the timeout is reached, the first signal (WS0)
    will trigger panic. If the system is getting into trouble and cannot be reset
    by panic or restart properly by the kdump kernel(if supported), then the
    second stage (as long as the first stage) will be reached, system will be
    reset by WS1. This function can help administrator to backup the system
    context info by panic console output or kdump.
    
    This driver bases on linux kernel watchdog framework, so it can get
    timeout from module parameter and FDT at the driver init stage.
    
    Signed-off-by: Fu Wei <fu.wei@linaro.org>
    Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
    Tested-by: Pratyush Anand <panand@redhat.com>
    Acked-by: Timur Tabi <timur@codeaurora.org>
    Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
    Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 2fc94b5f229a5d9d1db7fd91d0a4808cfeb915f5
Author: Fu Wei <fu.wei@linaro.org>
Date:   Mon Feb 29 16:46:47 2016 +0800

    Documentation: add sbsa-gwdt driver documentation
    
    The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
    introducing SBSA(Server Base System Architecture) Generic Watchdog
    device node info into FDT.
    
    Also add sbsa-gwdt introduction in watchdog-parameters.txt
    
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Fu Wei <fu.wei@linaro.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c36a483d80072f7efdd09e94dd733120dc8ecfb2
Author: William Breathitt Gray <vilhelm.gray@gmail.com>
Date:   Sun Feb 28 23:54:46 2016 -0500

    watchdog: Add watchdog timer support for the WinSystems EBC-C384
    
    The WinSystems EBC-C384 has an onboard watchdog timer. The timeout range
    supported by the watchdog timer is 1 second to 255 minutes. Timeouts
    under 256 seconds have a 1 second granularity, while the rest have a 1
    minute granularity.
    
    This driver adds watchdog timer support for this onboard watchdog timer.
    The timeout may be configured via the timeout module parameter.
    
    Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 70f3997667fb127333862977ba4fd3e855fbf617
Author: Kyle Roeschley <kyle.roeschley@ni.com>
Date:   Thu Feb 25 11:28:00 2016 -0600

    watchdog: ni903x_wdt: Add NI 903x/913x watchdog driver
    
    Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
    time controllers.
    
    Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
    Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 4d8b229d5ea610affe672e919021e9d02cd877da
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Fri Feb 26 17:32:49 2016 -0800

    watchdog: Add 'action' and 'data' parameters to restart handler callback
    
    The 'action' (or restart mode) and data parameters may be used by restart
    handlers, so they should be passed to the restart callback functions.
    
    Cc: Sylvain Lemieux <slemieux@tycoint.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0ce72f354482cfa40fb0a6619511ab94d6daa5e9
Author: Martyn Welch <martyn.welch@collabora.co.uk>
Date:   Fri Feb 26 16:05:12 2016 +0000

    watchdog: ziirave_wdt: Rename "trigger" reset reason "hw watchdog"
    
    The Zodiac watchdog is implemented on a microcontoller. The reset reason
    currently labelled "trigger" is not to detect when the watchdog has
    triggered (as had been initially understood and suggested by the naming),
    but to inform the reader that the watchdog, which in fact has it's own
    hardware watchdog, has been reset because the hardware watchdog has
    triggered. Renaming to "hw watchdog".
    
    Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 10e7ac22cdd4d211cef99afcb9371b70cb175be6
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Sun Feb 28 17:44:09 2016 +0200

    watchdog: rc32434_wdt: fix ioctl error handling
    
    Calling return copy_to_user(...) in an ioctl will not do the right thing
    if there's a pagefault: copy_to_user returns the number of bytes not
    copied in this case.
    
    Fix up watchdog/rc32434_wdt to do
    	return copy_to_user(...)) ?  -EFAULT : 0;
    
    instead.
    
    Cc: stable@vger.kernel.org
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 972ec3510330c9d639c0dd72960e9aa02915855c
Author: Jean Delvare <jdelvare@suse.de>
Date:   Wed Feb 24 16:17:26 2016 +0100

    watchdog: Add hardware dependency to BCM7038 driver
    
    The BCM7038 watchdog driver is specific to Broadcom ARM and MIPS
    SoCs so do not present it on other architectures, unless
    build-testing.
    
    Signed-off-by: Jean Delvare <jdelvare@suse.de>
    Reviewed-by: Justin Chen <justinpopo6@gmail.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c3525e3f09526b3ea2b59bb8f9b78cb2ff19a094
Author: Thierry Reding <treding@nvidia.com>
Date:   Wed Feb 24 15:22:06 2016 +0100

    watchdog: orion: Depend on 32-bit ARM
    
    The driver uses the atomic_io_modify() function to update registers, but
    that function is only available on 32-bit ARM. Recent changes have added
    ARCH_MVEBU support to 64-bit ARM and hence allowed this driver to build
    on 64-bit ARM where this function isn't available and thereby causing
    allmodconfig builds to break.
    
    Signed-off-by: Thierry Reding <treding@nvidia.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0519e91d80148086997aa5f3ab5d15e95151b6b1
Author: Jean Delvare <jdelvare@suse.de>
Date:   Tue Feb 9 11:17:48 2016 +0100

    watchdog: ts4800: add hardware dependency
    
    The Technologic Systems TS-4800 is an i.MX515 board, so its drivers
    are useless unless building a SOC_IMX51 kernel, except for build
    testing purposes.
    
    Signed-off-by: Jean Delvare <jdelvare@suse.de>
    Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
    Cc: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 33f74b893a46448670f11375427f0084753c23b6
Author: Rob Kramer <rob@solution-space.com>
Date:   Mon Feb 8 18:09:49 2016 +0800

    watchdog: w83627hf: Added NCT6102D support.
    
    As used in (and tested on) the ASRock IMB-150 board. Implementation is
    identical to other NCT chips, just with different registers.
    
    Signed-off-by: Rob Kramer <rob@solution-space.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Greetings,
Wim.
