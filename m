Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/62] watchdog: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:17 -0800
Message-Id: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches.

To reproduce this series of patches, checkout the tree above, then run
the following commands from the Linux source tree.

sh ~coccinelle-patches/watchdog/make.sh
sh ~coccinelle-patches/watchdog/do-commit.sh

The patch series is based on the following tree and branch.

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
	watchdog-next

----------------------------------------------------------------
Guenter Roeck (62):
      watchdog: asm9260_wdt: Convert to use device managed functions and other improvements
      watchdog: aspeed_wdt: Convert to use device managed functions
      watchdog: at91sam9_wdt: Convert to use device managed functions
      watchdog: atlas7_wdt: Convert to use device managed functions and other improvements
      watchdog: bcm2835_wdt: Convert to use device managed functions and other improvements
      watchdog: bcm47xx_wdt: Convert to use device managed functions
      watchdog: bcm7038_wdt: Convert to use device managed functions and other improvements
      watchdog: bcm_kona_wdt: Convert to use device managed functions and other improvements
      watchdog: cadence_wdt: Convert to use device managed functions and other improvements
      watchdog: coh901327_wdt: Convert to use device managed functions
      watchdog: da9052_wdt: Convert to use device managed functions
      watchdog: da9055_wdt: Convert to use device managed functions
      watchdog: da9062_wdt: Convert to use device managed functions
      watchdog: da9063_wdt: Convert to use device managed functions
      watchdog: davinci_wdt: Convert to use device managed functions and other improvements
      watchdog: digicolor_wdt: Convert to use device managed functions and other improvements
      watchdog: dw_wdt: Convert to use device managed functions
      watchdog: ep93xx_wdt: Convert to use device managed functions
      watchdog: gpio_wdt: Convert to use device managed functions
      watchdog: iTCO_wdt: Replace shutdown function with call to watchdog_stop_on_reboot
      watchdog: imgpdc_wdt: Convert to use device managed functions and other improvements
      watchdog: imx2_wdt: Convert to use device managed functions
      watchdog: intel-mid_wdt: Convert to use device managed functions
      watchdog: jz4740_wdt: Convert to use device managed functions
      watchdog: kempld_wdt: Convert to use device managed functions and other improvements
      watchdog: loongson1_wdt: Convert to use device managed functions
      watchdog: lpc18xx_wdt: Convert to use device managed functions and other improvements
      watchdog: max63xx_wdt: Convert to use device managed functions
      watchdog: max77620_wdt: Convert to use device managed functions
      watchdog: mena21_wdt: Convert to use device managed functions and other improvements
      watchdog: menf21bmc_wdt: Convert to use device managed functions
      watchdog: meson_gxbb_wdt: Convert to use device managed functions and other improvements
      watchdog: meson_wdt: Convert to use device managed functions and other improvements
      watchdog: moxart_wdt: Convert to use device managed functions
      watchdog: mpc8xxx_wdt: Convert to use device managed functions
      watchdog: mt7621_wdt: Convert to use device managed functions and other improvements
      watchdog: mtk_wdt: Convert to use device managed functions and other improvements
      watchdog: nic7018_wdt: Convert to use device managed functions
      watchdog: of_xilinx_wdt: Convert to use device managed functions
      watchdog: omap_wdt: Convert to use device managed functions
      watchdog: orion_wdt: Convert to use device managed functions and other improvements
      watchdog: pic32-dmt: Convert to use device managed functions
      watchdog: pic32-wdt: Convert to use device managed functions
      watchdog: pnx4008_wdt: Convert to use device managed functions
      watchdog: qcom-wdt: Convert to use device managed functions
      watchdog: renesas_wdt: Convert to use device managed functions
      watchdog: retu_wdt: Convert to use device managed functions and other improvements
      watchdog: rt2880_wdt: Convert to use device managed functions and other improvements
      watchdog: sama5d4_wdt: Convert to use device managed functions
      watchdog: sbsa_gwdt: Convert to use device managed functions and other improvements
      watchdog: shwdt: Convert to use device managed functions and other improvements
      watchdog: sirfsoc_wdt: Convert to use device managed functions and other improvements
      watchdog: st_lpc_wdt: Convert to use device managed functions
      watchdog: stmp3xxx_rtc_wdt: Convert to use device managed functions
      watchdog: sunxi_wdt: Convert to use device managed functions and other improvements
      watchdog: tangox_wdt: Convert to use device managed functions
      watchdog: tegra_wdt: Convert to use device managed functions
      watchdog: ts4800_wdt: Convert to use device managed functions
      watchdog: twl4030_wdt: Convert to use device managed functions
      watchdog: txx9wdt: Convert to use device managed functions and other improvements
      watchdog: ux500_wdt: Convert to use device managed functions
      watchdog: wm831x_wdt: Convert to use device managed functions

 drivers/watchdog/asm9260_wdt.c      | 37 ++++++----------
 drivers/watchdog/aspeed_wdt.c       | 14 +-----
 drivers/watchdog/at91sam9_wdt.c     | 48 +++++++-------------
 drivers/watchdog/atlas7_wdt.c       | 43 +++++-------------
 drivers/watchdog/bcm2835_wdt.c      | 27 ++++--------
 drivers/watchdog/bcm47xx_wdt.c      | 31 +++++--------
 drivers/watchdog/bcm7038_wdt.c      | 25 +++++------
 drivers/watchdog/bcm_kona_wdt.c     | 14 ++----
 drivers/watchdog/cadence_wdt.c      | 35 ++++-----------
 drivers/watchdog/coh901327_wdt.c    | 33 +++++---------
 drivers/watchdog/da9052_wdt.c       | 32 ++++----------
 drivers/watchdog/da9055_wdt.c       | 17 +-------
 drivers/watchdog/da9062_wdt.c       | 18 +-------
 drivers/watchdog/da9063_wdt.c       | 18 +-------
 drivers/watchdog/davinci_wdt.c      | 28 +++++-------
 drivers/watchdog/digicolor_wdt.c    | 48 +++++---------------
 drivers/watchdog/dw_wdt.c           | 32 ++++----------
 drivers/watchdog/ep93xx_wdt.c       |  9 +---
 drivers/watchdog/gpio_wdt.c         | 23 ++++------
 drivers/watchdog/iTCO_wdt.c         |  9 +---
 drivers/watchdog/imgpdc_wdt.c       | 42 +++++++-----------
 drivers/watchdog/imx2_wdt.c         | 15 +++----
 drivers/watchdog/intel-mid_wdt.c    | 11 +----
 drivers/watchdog/jz4740_wdt.c       | 22 +++-------
 drivers/watchdog/kempld_wdt.c       | 12 +----
 drivers/watchdog/loongson1_wdt.c    | 31 ++++---------
 drivers/watchdog/lpc18xx_wdt.c      | 58 ++++++++-----------------
 drivers/watchdog/max63xx_wdt.c      | 12 +----
 drivers/watchdog/max77620_wdt.c     |  3 +-
 drivers/watchdog/mena21_wdt.c       | 24 +---------
 drivers/watchdog/menf21bmc_wdt.c    | 15 +------
 drivers/watchdog/meson_gxbb_wdt.c   | 38 +++++-----------
 drivers/watchdog/meson_wdt.c        | 23 +---------
 drivers/watchdog/moxart_wdt.c       |  5 +--
 drivers/watchdog/mpc8xxx_wdt.c      | 25 +++++------
 drivers/watchdog/mt7621_wdt.c       | 17 +-------
 drivers/watchdog/mtk_wdt.c          | 22 +---------
 drivers/watchdog/nic7018_wdt.c      |  4 +-
 drivers/watchdog/of_xilinx_wdt.c    | 28 ++++--------
 drivers/watchdog/omap_wdt.c         |  3 +-
 drivers/watchdog/orion_wdt.c        | 87 +++++++++++++++++--------------------
 drivers/watchdog/pic32-dmt.c        | 29 ++++---------
 drivers/watchdog/pic32-wdt.c        | 34 ++++-----------
 drivers/watchdog/pnx4008_wdt.c      | 23 +++-------
 drivers/watchdog/qcom-wdt.c         | 27 ++++--------
 drivers/watchdog/renesas_wdt.c      |  6 +--
 drivers/watchdog/retu_wdt.c         | 21 +++------
 drivers/watchdog/rt2880_wdt.c       | 17 +-------
 drivers/watchdog/sama5d4_wdt.c      |  4 +-
 drivers/watchdog/sbsa_gwdt.c        | 21 +--------
 drivers/watchdog/shwdt.c            | 11 +----
 drivers/watchdog/sirfsoc_wdt.c      | 13 ++----
 drivers/watchdog/st_lpc_wdt.c       | 11 ++---
 drivers/watchdog/stmp3xxx_rtc_wdt.c |  3 +-
 drivers/watchdog/sunxi_wdt.c        | 24 +---------
 drivers/watchdog/tangox_wdt.c       | 22 ++++------
 drivers/watchdog/tegra_wdt.c        |  4 +-
 drivers/watchdog/ts4800_wdt.c       | 14 +-----
 drivers/watchdog/twl4030_wdt.c      | 17 +-------
 drivers/watchdog/txx9wdt.c          | 46 +++++++-------------
 drivers/watchdog/ux500_wdt.c        | 10 +----
 drivers/watchdog/wm831x_wdt.c       | 31 +++----------
 62 files changed, 387 insertions(+), 1039 deletions(-)
