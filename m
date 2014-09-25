Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:52562 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbaIYQS4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Sep 2014 12:18:56 -0400
Received: by mail-pd0-f170.google.com with SMTP id y13so11174734pdi.29
        for <linux-watchdog@vger.kernel.org>; Thu, 25 Sep 2014 09:18:56 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 3.18
Date: Thu, 25 Sep 2014 09:18:50 -0700
Message-Id: <1411661930-8038-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

This is my watchdog pull request for 3.18. The branch is currently base=
d
on v3.17-rc3.

Please consider pulling watchdog updates for Linux 3.18 from signed tag=
:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.=
git watchdog-for-wim-3.18

The tag has been applied on top of the watchdog-next branch. The branch=
 includes
a number of patches I collected over the last few months. It does not i=
nclude
all submitted patches; only the ones I reviewed and felt comfortable wi=
th are
included. Some may already be in your -next branch.

I reviewed all patches and ran build tests as well as source verificati=
on tests
with both smatch and spatch. The branch has been on my Linux repository=
 for a
while, so presumably Fenguang's robot will have built the code as well.=
 The most
recent build results are available at http://server.roeck-us.net:8010/b=
uilders.

If you don't want to apply the entire series, please consider applying =
whatever
subset you might feel comfortable with.

Note that there are a few more patches which I believe are ready to be =
applied,
but are not included in this pull request because they depend on the re=
start
handler patch series. Those patches are

	watchdog: sunxi: Add A31 watchdog support
	watchdog: sunxi: support parameterized compatible strings
	watchdog: imx2_wdt: add restart handler support
	watchdog: dw_wdt: add restart handler support

Not really sure how to handle those. One possibility would be to wait u=
ntil
the restart handler series has been applied. Another possibility would =
be to
send two separate pull requests to Linus.

Thanks,
Guenter

------
The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c=
666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.gi=
t tags/watchdog-for-wim-3.18

for you to fetch changes up to 50861760efa296cc652725313a65e3c9b03156f1=
:

  Merge tag 'mfd-hwmon-leds-watchdog-v3.18' into watchdog-next (2014-09=
-24 09:28:45 -0700)

----------------------------------------------------------------

This tag includes the following commits.

5086176 Merge tag 'mfd-hwmon-leds-watchdog-v3.18' into watchdog-next
9643569 hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver
3843363 leds: leds-menf21bmc: Introduce MEN 14F021P00 BMC LED driver
5033263 watchdog: menf21bmc_wdt: Introduce MEN 14F021P00 BMC Watchdog d=
river
dfbdcd7 mfd: menf21bmc: Introduce MEN 14F021P00 BMC MFD Core driver
826899b watchdog: dw_wdt: initialise TOP_INIT in dw_wdt_set_top()
8ee1313 ARM: meson: add watchdog driver
3136087 ARM: defconfig: update multi_v7_defconfig
b9d2f85 ARM: docs: add documentation binding for meson watchdog
45804ec watchdog: simplify definitions of WATCHDOG_NOWAYOUT(_INIT_STATU=
S)
d9a9e55 watchdog: imx2_wdt: Convert to use regmap framework's endiannes=
s method.
ce495d4 devicetree: Add Cadence WDT devicetree bindings documentation
064a052 watchdog: Add Cadence WDT driver
0a03e7d watchdog: ts72xx_wdt: Kill superfluous variable in remove
6f14d37 powerpc: booke_wdt: Fix build error as a module
a672e8e watchdog: xilinx: Remove .owner field for driver

----------------------------------------------------------------
Andreas Werner (4):
      mfd: menf21bmc: Introduce MEN 14F021P00 BMC MFD Core driver
      watchdog: menf21bmc_wdt: Introduce MEN 14F021P00 BMC Watchdog dri=
ver
      leds: leds-menf21bmc: Introduce MEN 14F021P00 BMC LED driver
      hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver

Carlo Caione (3):
      ARM: docs: add documentation binding for meson watchdog
      ARM: defconfig: update multi_v7_defconfig
      ARM: meson: add watchdog driver

Guenter Roeck (1):
      Merge tag 'mfd-hwmon-leds-watchdog-v3.18' into watchdog-next

Harini Katakam (2):
      watchdog: Add Cadence WDT driver
      devicetree: Add Cadence WDT devicetree bindings documentation

Jisheng Zhang (1):
      watchdog: dw_wdt: initialise TOP_INIT in dw_wdt_set_top()

Michal Simek (1):
      watchdog: xilinx: Remove .owner field for driver

Mika Westerberg (1):
      watchdog: ts72xx_wdt: Kill superfluous variable in remove

Pranith Kumar (1):
      powerpc: booke_wdt: Fix build error as a module

Uwe Kleine-K=C3=B6nig (1):
      watchdog: simplify definitions of WATCHDOG_NOWAYOUT(_INIT_STATUS)

Xiubo Li (1):
      watchdog: imx2_wdt: Convert to use regmap framework's endianness =
method.

 .../devicetree/bindings/watchdog/cadence-wdt.txt   |  24 +
 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |   4 +-
 .../devicetree/bindings/watchdog/meson6-wdt.txt    |  13 +
 Documentation/hwmon/menf21bmc                      |  50 ++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/menf21bmc_hwmon.c                    | 230 +++++++++
 drivers/leds/Kconfig                               |   9 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-menf21bmc.c                      | 131 ++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/menf21bmc.c                            | 132 ++++++
 drivers/watchdog/Kconfig                           |  28 ++
 drivers/watchdog/Makefile                          |   3 +
 drivers/watchdog/booke_wdt.c                       |  28 +-
 drivers/watchdog/cadence_wdt.c                     | 516 +++++++++++++=
++++++++
 drivers/watchdog/dw_wdt.c                          |   4 +-
 drivers/watchdog/imx2_wdt.c                        |   9 +-
 drivers/watchdog/menf21bmc_wdt.c                   | 203 ++++++++
 drivers/watchdog/meson_wdt.c                       | 236 ++++++++++
 drivers/watchdog/of_xilinx_wdt.c                   |   1 -
 drivers/watchdog/ts72xx_wdt.c                      |   6 +-
 include/linux/watchdog.h                           |   9 +-
 25 files changed, 1618 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/cadence-=
wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson6-w=
dt.txt
 create mode 100644 Documentation/hwmon/menf21bmc
 create mode 100644 drivers/hwmon/menf21bmc_hwmon.c
 create mode 100644 drivers/leds/leds-menf21bmc.c
 create mode 100644 drivers/mfd/menf21bmc.c
 create mode 100644 drivers/watchdog/cadence_wdt.c
 create mode 100644 drivers/watchdog/menf21bmc_wdt.c
 create mode 100644 drivers/watchdog/meson_wdt.c
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
