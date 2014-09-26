Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48758 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbaIZUF1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Sep 2014 16:05:27 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so13149869pac.31
        for <linux-watchdog@vger.kernel.org>; Fri, 26 Sep 2014 13:05:26 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 3.18 (take three)
Date: Fri, 26 Sep 2014 13:05:21 -0700
Message-Id: <1411761921-1231-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

This is my third and hopefully last watchdog pull request for 3.18. The branch
is currently based on v3.17-rc3. Since v2 I added for more patches which
I had overlooked earlier.

Please consider pulling watchdog updates for Linux 3.18 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim-3.18-v3

The tag has been applied on top of the watchdog-next branch. The branch includes
a number of patches I collected over the last few months. It does not include
all submitted patches; only the ones I reviewed and felt comfortable with are
included. Some may already be in your -next branch.

The pull request includes merges with two immutable branches; this was necessary
to resolve dependencies. Please see the merge messages for details.

I reviewed all patches and ran build tests as well as source verification tests
with both smatch and spatch. Most recent build results are available at
http://server.roeck-us.net:8010/builders.

The latest version of this branch has been on my public Linux repository for only
a short period of time, so it may take a day or so for Fengguang's build bot
to catch problems if there are any. I'll let you know if that is the case.

If you don't want to apply the entire series, please consider applying whatever
subset you might feel comfortable with.

Thanks,
Guenter

------
The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-wim-3.18-v3

for you to fetch changes up to 7f11f7521442bfbe0cc0f5e775dfad672788e0af:

  watchdog: add driver for Ricoh RN5T618 watchdog (2014-09-26 10:48:01 -0700)

----------------------------------------------------------------
This series contains the following patches.

Note that two immutable branches with required functionality
have been merged. See the merge messages below.

7f11f75 watchdog: add driver for Ricoh RN5T618 watchdog
d77481b watchdog: s3c2410_wdt: Add support for Watchdog device on Exynos7
68fa4d7 watchdog: sunxi: Add A31 watchdog support
a3b7089 watchdog: sunxi: support parameterized compatible strings
c883b8c watchdog: imx2_wdt: add restart handler support
a1afe15 watchdog: qcom: register a restart notifier
8c5fd24 watchdog: s3c2410: add restart handler
8c87929 watchdog: dw_wdt: add restart handler support
d0d3d2b Merge tag 'restart-handler-for-v3.18' into watchdog-next
6cd6d94 arm/arm64: unexport restart handlers
d20a1d9 watchdog: sunxi: register restart handler with kernel restart handler
87ffc69 watchdog: alim7101: register restart handler with kernel restart handler
ad0e0e6 watchdog: moxart: register restart handler with kernel restart handler
1a9607a arm: support restart through restart handler call chain
1c7ffc3 arm64: support restart through restart handler call chain
0713e14 power/restart: call machine_restart instead of arm_pm_restart
b63adb9 kernel: add support for kernel restart handler call chain
584ea96 watchdog: qcom: document device tree bindings
c79a4a3 watchdog: qcom: add support for KPSS WDT
5086176 Merge tag 'mfd-hwmon-leds-watchdog-v3.18' into watchdog-next
9643569 hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver
3843363 leds: leds-menf21bmc: Introduce MEN 14F021P00 BMC LED driver
5033263 watchdog: menf21bmc_wdt: Introduce MEN 14F021P00 BMC Watchdog driver
dfbdcd7 mfd: menf21bmc: Introduce MEN 14F021P00 BMC MFD Core driver
826899b watchdog: dw_wdt: initialise TOP_INIT in dw_wdt_set_top()
8ee1313 ARM: meson: add watchdog driver
3136087 ARM: defconfig: update multi_v7_defconfig
b9d2f85 ARM: docs: add documentation binding for meson watchdog
45804ec watchdog: simplify definitions of WATCHDOG_NOWAYOUT(_INIT_STATUS)
d9a9e55 watchdog: imx2_wdt: Convert to use regmap framework's endianness method.
ce495d4 devicetree: Add Cadence WDT devicetree bindings documentation
064a052 watchdog: Add Cadence WDT driver
0a03e7d watchdog: ts72xx_wdt: Kill superfluous variable in remove
6f14d37 powerpc: booke_wdt: Fix build error as a module
a672e8e watchdog: xilinx: Remove .owner field for driver

----------------------------------------------------------------
Andreas Werner (4):
      mfd: menf21bmc: Introduce MEN 14F021P00 BMC MFD Core driver
      watchdog: menf21bmc_wdt: Introduce MEN 14F021P00 BMC Watchdog driver
      leds: leds-menf21bmc: Introduce MEN 14F021P00 BMC LED driver
      hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver

Beniamino Galvani (1):
      watchdog: add driver for Ricoh RN5T618 watchdog

Carlo Caione (3):
      ARM: docs: add documentation binding for meson watchdog
      ARM: defconfig: update multi_v7_defconfig
      ARM: meson: add watchdog driver

Chen-Yu Tsai (2):
      watchdog: sunxi: support parameterized compatible strings
      watchdog: sunxi: Add A31 watchdog support

Guenter Roeck (10):
      Merge tag 'mfd-hwmon-leds-watchdog-v3.18' into watchdog-next
      kernel: add support for kernel restart handler call chain
      power/restart: call machine_restart instead of arm_pm_restart
      arm64: support restart through restart handler call chain
      arm: support restart through restart handler call chain
      watchdog: moxart: register restart handler with kernel restart handler
      watchdog: alim7101: register restart handler with kernel restart handler
      watchdog: sunxi: register restart handler with kernel restart handler
      arm/arm64: unexport restart handlers
      Merge tag 'restart-handler-for-v3.18' into watchdog-next

Harini Katakam (2):
      watchdog: Add Cadence WDT driver
      devicetree: Add Cadence WDT devicetree bindings documentation

Heiko Stübner (1):
      watchdog: s3c2410: add restart handler

Jingchang Lu (1):
      watchdog: imx2_wdt: add restart handler support

Jisheng Zhang (2):
      watchdog: dw_wdt: initialise TOP_INIT in dw_wdt_set_top()
      watchdog: dw_wdt: add restart handler support

Josh Cartwright (3):
      watchdog: qcom: add support for KPSS WDT
      watchdog: qcom: document device tree bindings
      watchdog: qcom: register a restart notifier

Michal Simek (1):
      watchdog: xilinx: Remove .owner field for driver

Mika Westerberg (1):
      watchdog: ts72xx_wdt: Kill superfluous variable in remove

Naveen Krishna Chatradhi (1):
      watchdog: s3c2410_wdt: Add support for Watchdog device on Exynos7

Pranith Kumar (1):
      powerpc: booke_wdt: Fix build error as a module

Uwe Kleine-König (1):
      watchdog: simplify definitions of WATCHDOG_NOWAYOUT(_INIT_STATUS)

Xiubo Li (1):
      watchdog: imx2_wdt: Convert to use regmap framework's endianness method.

 .../devicetree/bindings/watchdog/cadence-wdt.txt   |  24 +
 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |   4 +-
 .../devicetree/bindings/watchdog/meson6-wdt.txt    |  13 +
 .../devicetree/bindings/watchdog/qcom-wdt.txt      |  24 +
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   1 +
 Documentation/hwmon/menf21bmc                      |  50 ++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/kernel/process.c                          |  12 +-
 arch/arm64/kernel/process.c                        |   3 +-
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/menf21bmc_hwmon.c                    | 230 +++++++++
 drivers/leds/Kconfig                               |   9 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-menf21bmc.c                      | 131 ++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/menf21bmc.c                            | 132 ++++++
 drivers/power/reset/restart-poweroff.c             |   3 +-
 drivers/watchdog/Kconfig                           |  52 +++
 drivers/watchdog/Makefile                          |   5 +
 drivers/watchdog/alim7101_wdt.c                    |  42 +-
 drivers/watchdog/booke_wdt.c                       |  28 +-
 drivers/watchdog/cadence_wdt.c                     | 516 +++++++++++++++++++++
 drivers/watchdog/dw_wdt.c                          |  36 +-
 drivers/watchdog/imx2_wdt.c                        |  46 +-
 drivers/watchdog/menf21bmc_wdt.c                   | 203 ++++++++
 drivers/watchdog/meson_wdt.c                       | 236 ++++++++++
 drivers/watchdog/moxart_wdt.c                      |  32 +-
 drivers/watchdog/of_xilinx_wdt.c                   |   1 -
 drivers/watchdog/qcom-wdt.c                        | 224 +++++++++
 drivers/watchdog/rn5t618_wdt.c                     | 198 ++++++++
 drivers/watchdog/s3c2410_wdt.c                     |  47 ++
 drivers/watchdog/sunxi_wdt.c                       | 136 ++++--
 drivers/watchdog/ts72xx_wdt.c                      |   6 +-
 include/linux/reboot.h                             |   3 +
 include/linux/watchdog.h                           |   9 +-
 kernel/reboot.c                                    |  81 ++++
 38 files changed, 2455 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
 create mode 100644 Documentation/hwmon/menf21bmc
 create mode 100644 drivers/hwmon/menf21bmc_hwmon.c
 create mode 100644 drivers/leds/leds-menf21bmc.c
 create mode 100644 drivers/mfd/menf21bmc.c
 create mode 100644 drivers/watchdog/cadence_wdt.c
 create mode 100644 drivers/watchdog/menf21bmc_wdt.c
 create mode 100644 drivers/watchdog/meson_wdt.c
 create mode 100644 drivers/watchdog/qcom-wdt.c
 create mode 100644 drivers/watchdog/rn5t618_wdt.c
