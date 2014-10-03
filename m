Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:48641 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751163AbaJCRrj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Oct 2014 13:47:39 -0400
Date: Fri, 3 Oct 2014 19:47:37 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [GIT PULL] watchdog updates for Linux 3.18 (#4)
Message-ID: <20141003174737.GH8811@spo001.leaseweb.nl>
References: <1412351372-4840-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1412351372-4840-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Let me verify tomorrow. What's allready in linux-watchdog-next (and for which I still
need to sent out some mails tomorrow) are all the patches you also have except the patches
that rely on the restart handler. So that's still on my todo list for this weekend.
The first immutable branch (mfd-hwmon-leds-watchdog branch for the menf21) I have also in
my tree. the second one I don't have yet (it's the restart handler patches).

Can you sent me the url for that one also?

For the rest: thanks again for the good job!

Thanks in advance,
Wim.

> Hi Wim,
> 
> Ok, the third pull request was not the last one after all. Lots of activity this
> time around.
> 
> This is my fourth watchdog pull request for 3.18. The branch is currently based
> on v3.17-rc3. Since v3 I added two more patches which I think are ready for
> upstream integration. Also, the Ricoh patch is now the updated version reflecting
> your feedback.
> 
> Please consider pulling watchdog updates for Linux 3.18 from signed tag:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim-3.18-v4
> 
> The tag has been applied on top of the watchdog-next branch. The branch includes
> a number of patches I collected over the last few months. It does not include
> all submitted patches; only the ones I reviewed and felt comfortable with are
> included. Some may already be in your -next branch.
> 
> The pull request includes merges with two immutable branches; this was necessary
> to resolve dependencies. Please see the merge messages for details.
> 
> I reviewed all patches and ran build tests as well as source verification tests
> with both smatch and spatch. Most recent build results are available at
> http://server.roeck-us.net:8010/builders.
> 
> The latest version of this branch has been on my public Linux repository for only
> a short period of time, so it may take a day or so for Fengguang's build bot
> to catch problems if there are any. I'll let you know if that is the case.
> 
> If you don't want to apply the entire series, please consider applying whatever
> subset you might feel comfortable with.
> 
> Thanks,
> Guenter
> 
> ------
> The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:
> 
>   Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-wim-3.18-v4
> 
> for you to fetch changes up to da45a840cb0853c72079a329b583f353dfebdd76:
> 
>   stmp3xxx_rtc_wdt: Add suspend/resume PM support (2014-09-30 06:45:16 -0700)
> 
> ----------------------------------------------------------------
> Note that two immutable branches with required functionality have been merged.
> See the related merge messages below.
> 
> da45a84 stmp3xxx_rtc_wdt: Add suspend/resume PM support
> 781e543 watchdog: add driver for Ricoh RN5T618 watchdog
> cb2d24b watchdog: Add DA9063 PMIC watchdog driver.
> d77481b watchdog: s3c2410_wdt: Add support for Watchdog device on Exynos7
> 68fa4d7 watchdog: sunxi: Add A31 watchdog support
> a3b7089 watchdog: sunxi: support parameterized compatible strings
> c883b8c watchdog: imx2_wdt: add restart handler support
> a1afe15 watchdog: qcom: register a restart notifier
> 8c5fd24 watchdog: s3c2410: add restart handler
> 8c87929 watchdog: dw_wdt: add restart handler support
> d0d3d2b Merge tag 'restart-handler-for-v3.18' into watchdog-next
> 6cd6d94 arm/arm64: unexport restart handlers
> d20a1d9 watchdog: sunxi: register restart handler with kernel restart handler
> 87ffc69 watchdog: alim7101: register restart handler with kernel restart handler
> ad0e0e6 watchdog: moxart: register restart handler with kernel restart handler
> 1a9607a arm: support restart through restart handler call chain
> 1c7ffc3 arm64: support restart through restart handler call chain
> 0713e14 power/restart: call machine_restart instead of arm_pm_restart
> b63adb9 kernel: add support for kernel restart handler call chain
> 584ea96 watchdog: qcom: document device tree bindings
> c79a4a3 watchdog: qcom: add support for KPSS WDT
> 5086176 Merge tag 'mfd-hwmon-leds-watchdog-v3.18' into watchdog-next
> 9643569 hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver
> 3843363 leds: leds-menf21bmc: Introduce MEN 14F021P00 BMC LED driver
> 5033263 watchdog: menf21bmc_wdt: Introduce MEN 14F021P00 BMC Watchdog driver
> dfbdcd7 mfd: menf21bmc: Introduce MEN 14F021P00 BMC MFD Core driver
> 826899b watchdog: dw_wdt: initialise TOP_INIT in dw_wdt_set_top()
> 8ee1313 ARM: meson: add watchdog driver
> 3136087 ARM: defconfig: update multi_v7_defconfig
> b9d2f85 ARM: docs: add documentation binding for meson watchdog
> 45804ec watchdog: simplify definitions of WATCHDOG_NOWAYOUT(_INIT_STATUS)
> d9a9e55 watchdog: imx2_wdt: Convert to use regmap framework's endianness method.
> ce495d4 devicetree: Add Cadence WDT devicetree bindings documentation
> 064a052 watchdog: Add Cadence WDT driver
> 0a03e7d watchdog: ts72xx_wdt: Kill superfluous variable in remove
> 6f14d37 powerpc: booke_wdt: Fix build error as a module
> a672e8e watchdog: xilinx: Remove .owner field for driver
> 
> ----------------------------------------------------------------
> Andreas Werner (4):
>       mfd: menf21bmc: Introduce MEN 14F021P00 BMC MFD Core driver
>       watchdog: menf21bmc_wdt: Introduce MEN 14F021P00 BMC Watchdog driver
>       leds: leds-menf21bmc: Introduce MEN 14F021P00 BMC LED driver
>       hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver
> 
> Beniamino Galvani (1):
>       watchdog: add driver for Ricoh RN5T618 watchdog
> 
> Carlo Caione (3):
>       ARM: docs: add documentation binding for meson watchdog
>       ARM: defconfig: update multi_v7_defconfig
>       ARM: meson: add watchdog driver
> 
> Chen-Yu Tsai (2):
>       watchdog: sunxi: support parameterized compatible strings
>       watchdog: sunxi: Add A31 watchdog support
> 
> Guenter Roeck (10):
>       Merge tag 'mfd-hwmon-leds-watchdog-v3.18' into watchdog-next
>       kernel: add support for kernel restart handler call chain
>       power/restart: call machine_restart instead of arm_pm_restart
>       arm64: support restart through restart handler call chain
>       arm: support restart through restart handler call chain
>       watchdog: moxart: register restart handler with kernel restart handler
>       watchdog: alim7101: register restart handler with kernel restart handler
>       watchdog: sunxi: register restart handler with kernel restart handler
>       arm/arm64: unexport restart handlers
>       Merge tag 'restart-handler-for-v3.18' into watchdog-next
> 
> Harini Katakam (2):
>       watchdog: Add Cadence WDT driver
>       devicetree: Add Cadence WDT devicetree bindings documentation
> 
> Heiko Stübner (1):
>       watchdog: s3c2410: add restart handler
> 
> Janusz Użycki (1):
>       stmp3xxx_rtc_wdt: Add suspend/resume PM support
> 
> Jingchang Lu (1):
>       watchdog: imx2_wdt: add restart handler support
> 
> Jisheng Zhang (2):
>       watchdog: dw_wdt: initialise TOP_INIT in dw_wdt_set_top()
>       watchdog: dw_wdt: add restart handler support
> 
> Josh Cartwright (3):
>       watchdog: qcom: add support for KPSS WDT
>       watchdog: qcom: document device tree bindings
>       watchdog: qcom: register a restart notifier
> 
> Krystian Garbaciak (1):
>       watchdog: Add DA9063 PMIC watchdog driver.
> 
> Michal Simek (1):
>       watchdog: xilinx: Remove .owner field for driver
> 
> Mika Westerberg (1):
>       watchdog: ts72xx_wdt: Kill superfluous variable in remove
> 
> Naveen Krishna Chatradhi (1):
>       watchdog: s3c2410_wdt: Add support for Watchdog device on Exynos7
> 
> Pranith Kumar (1):
>       powerpc: booke_wdt: Fix build error as a module
> 
> Uwe Kleine-König (1):
>       watchdog: simplify definitions of WATCHDOG_NOWAYOUT(_INIT_STATUS)
> 
> Xiubo Li (1):
>       watchdog: imx2_wdt: Convert to use regmap framework's endianness method.
> 
>  .../devicetree/bindings/watchdog/cadence-wdt.txt   |  24 +
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |   4 +-
>  .../devicetree/bindings/watchdog/meson6-wdt.txt    |  13 +
>  .../devicetree/bindings/watchdog/qcom-wdt.txt      |  24 +
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   1 +
>  Documentation/hwmon/menf21bmc                      |  50 ++
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  arch/arm/kernel/process.c                          |  12 +-
>  arch/arm64/kernel/process.c                        |   3 +-
>  drivers/hwmon/Kconfig                              |  10 +
>  drivers/hwmon/Makefile                             |   1 +
>  drivers/hwmon/menf21bmc_hwmon.c                    | 230 +++++++++
>  drivers/leds/Kconfig                               |   9 +
>  drivers/leds/Makefile                              |   1 +
>  drivers/leds/leds-menf21bmc.c                      | 131 ++++++
>  drivers/mfd/Kconfig                                |  15 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/menf21bmc.c                            | 132 ++++++
>  drivers/power/reset/restart-poweroff.c             |   3 +-
>  drivers/watchdog/Kconfig                           |  61 +++
>  drivers/watchdog/Makefile                          |   6 +
>  drivers/watchdog/alim7101_wdt.c                    |  42 +-
>  drivers/watchdog/booke_wdt.c                       |  28 +-
>  drivers/watchdog/cadence_wdt.c                     | 516 +++++++++++++++++++++
>  drivers/watchdog/da9063_wdt.c                      | 191 ++++++++
>  drivers/watchdog/dw_wdt.c                          |  36 +-
>  drivers/watchdog/imx2_wdt.c                        |  46 +-
>  drivers/watchdog/menf21bmc_wdt.c                   | 203 ++++++++
>  drivers/watchdog/meson_wdt.c                       | 236 ++++++++++
>  drivers/watchdog/moxart_wdt.c                      |  32 +-
>  drivers/watchdog/of_xilinx_wdt.c                   |   1 -
>  drivers/watchdog/qcom-wdt.c                        | 224 +++++++++
>  drivers/watchdog/rn5t618_wdt.c                     | 198 ++++++++
>  drivers/watchdog/s3c2410_wdt.c                     |  47 ++
>  drivers/watchdog/stmp3xxx_rtc_wdt.c                |  24 +
>  drivers/watchdog/sunxi_wdt.c                       | 136 ++++--
>  drivers/watchdog/ts72xx_wdt.c                      |   6 +-
>  include/linux/reboot.h                             |   3 +
>  include/linux/watchdog.h                           |   9 +-
>  kernel/reboot.c                                    |  81 ++++
>  40 files changed, 2680 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
>  create mode 100644 Documentation/hwmon/menf21bmc
>  create mode 100644 drivers/hwmon/menf21bmc_hwmon.c
>  create mode 100644 drivers/leds/leds-menf21bmc.c
>  create mode 100644 drivers/mfd/menf21bmc.c
>  create mode 100644 drivers/watchdog/cadence_wdt.c
>  create mode 100644 drivers/watchdog/da9063_wdt.c
>  create mode 100644 drivers/watchdog/menf21bmc_wdt.c
>  create mode 100644 drivers/watchdog/meson_wdt.c
>  create mode 100644 drivers/watchdog/qcom-wdt.c
>  create mode 100644 drivers/watchdog/rn5t618_wdt.c
