Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53887 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBZUdA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 26 Feb 2017 15:33:00 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog updates for v4.11
Date: Sun, 26 Feb 2017 12:32:56 -0800
Message-Id: <1488141176-28178-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Wim asked me to handle the watchdog pull request this time around.

Please pull watchdog updates for Linux v4.11 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-linus-v4.11

[ Yes, I know, I rebased to v4.10 which I should not have done.
  Me trying to resolve some conflicts with a patch which didn't
  apply anyway and therefore had to be dropped. Grumble on myself.
  Anyway, only late changes are the s3c2410 patches which I wanted
  in specifically for 's3c2410: Fix infinite interrupt...'.
  Everything else has been in my tree on kernel.org for a while.
  All patches have passed kerneltests.org as well as 0day tests. ]

Thanks,
Guenter
------

The following changes since commit c470abd4fde40ea6a0846a2beab642a578c0b8cd:

  Linux 4.10 (2017-02-19 14:34:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-linus-v4.11

for you to fetch changes up to e3a60ead2c9b813db832a35e50ebbc6b552a35e3:

  watchdog: s3c2410: Add prefix to local function (2017-02-24 14:00:23 -0800)

----------------------------------------------------------------
Watchdog updates for v4.11

Key changes:

- New drivers:
  Cortina Gemini
  ZTE's zx2967 family
  NIC7018
- Convert to use device managed functions:
  ebc-c384_wdt, tegra_wdt, da9063_wdt, da9062_wdt, da9055_wdt, da9052_wdt,
  bcm2835_wdt, mena21_wdt, wm831x_wdt, digicolor_wdt, intel-mid_wdt,
  meson_wdt, sunxi_wdt, aspeed_wdt, coh901327_wdt, iTCO_wdt
- Use watchdog core to install restart handler:
  tangox, dw_wdt, bcm2835_wdt, asm9260_wdt, bcm47xx_wdt
- Convert ts72xx_wdt driver to watchdog core
- Let core handle heartbeat in ep93xx_wdt driver
- Enable COMPILE_TEST where possible
- Various other improvements

----------------------------------------------------------------
Alexandre Belloni (2):
      watchdog: sama5d4: Cache MR instead of a partial config
      watchdog: sama5d4: Implement resume hook

Baoyou Xie (2):
      dt: bindings: add documentation for zx2967 family watchdog controller
      watchdog: zx2967: add watchdog controller driver for ZTE's zx2967 family

Bhumika Goyal (4):
      watchdog: booke_wdt: add __ro_after_init to booke_wdt_info
      watchdog: pika_wdt: add __ro_after_init to ident
      watchdog: constify watchdog_info structures
      watchdog: constify watchdog_ops structures

Colin Ian King (1):
      watchdog: orion: fix spelling mistake: "harcoded" -> "hardcoded"

Guenter Roeck (31):
      watchdog: pnx833x_wdt: Mark as broken
      watchdog: Enable COMPILE_TEST where possible
      watchdog: iTCO_wdt: Use allocated data structures
      watchdog: iTCO_wdt: Use device managed resources
      watchdog: iTCO_wdt: Use pdev for platform device and pci_dev for pci device
      watchdog: iTCO_wdt: Simplify module init function
      watchdog: bcm47xx_wdt: Don't validate platform data on remove
      watchdog: asm9260_wdt: Use watchdog core to install restart handler
      watchdog: bcm2835_wdt: Use watchdog core to install restart handler
      watchdog: dw_wdt: Use watchdog core to install restart handler
      watchdog: tangox: Use watchdog core to install restart handler
      watchdog: coh901327_wdt: Simplify error handling in probe function
      watchdog: coh901327_wdt: Keep clock enabled after loading driver
      watchdog: coh901327_wdt: Use devm_ioremap_resource to map resources
      watchdog: coh901327_wdt: Use dev variable instead of pdev->dev
      watchdog: aspeed_wdt: Convert to use device managed functions
      watchdog: sunxi_wdt: Convert to use device managed functions and other improvements
      watchdog: meson_wdt: Convert to use device managed functions and other improvements
      watchdog: intel-mid_wdt: Convert to use device managed functions
      watchdog: iTCO_wdt: Replace shutdown function with call to watchdog_stop_on_reboot
      watchdog: digicolor_wdt: Convert to use device managed functions and other improvements
      watchdog: wm831x_wdt: Convert to use device managed functions
      watchdog: mena21_wdt: Convert to use device managed functions and other improvements
      watchdog: bcm2835_wdt: Convert to use device managed functions and other improvements
      watchdog: da9052_wdt: Convert to use device managed functions
      watchdog: da9055_wdt: Convert to use device managed functions
      watchdog: da9062_wdt: Convert to use device managed functions
      watchdog: da9063_wdt: Convert to use device managed functions
      watchdog: tegra_wdt: Convert to use device managed functions
      watchdog: Introduce watchdog_stop_on_unregister helper
      watchdog: RDC321X_WDT always depends on PCI

H Hartley Sweeten (2):
      watchdog: ep93xx_wdt: cleanup and let the core handle the heartbeat
      watchdog: ts72xx_wdt: convert driver to watchdog core

Hui Chun Ong (1):
      watchdog: nic7018_wdt: Add NIC7018 watchdog driver

John Crispin (1):
      watchdog: update my email address

Krzysztof Kozlowski (5):
      watchdog: s3c2410: Remove confusing CONFIG prefix from local defines
      watchdog: s3c2410: Fix infinite interrupt in soft mode
      watchdog: s3c2410: Use dev_dbg instead of pr_info
      watchdog: s3c2410: Select MFD_SYSCON on all Exynos platforms
      watchdog: s3c2410: Add prefix to local function

Linus Walleij (2):
      watchdog: add DT bindings for Cortina Gemini
      watchdog: add driver for Cortina Gemini watchdog

Vladimir Zapolskiy (1):
      watchdog: sa11x0/pxa: fix error path of driver initialization

William Breathitt Gray (1):
      watchdog: ebc-c384_wdt: Utilize devm_ functions in driver probe callback

Wolfram Sang (1):
      watchdog: softdog: make pretimeout support a compile option

 .../bindings/watchdog/cortina,gemin-watchdog.txt   |  17 +
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   9 +-
 .../bindings/watchdog/zte,zx2967-wdt.txt           |  32 ++
 Documentation/watchdog/watchdog-kernel-api.txt     |   6 +
 Documentation/watchdog/watchdog-parameters.txt     |   5 +
 drivers/watchdog/Kconfig                           | 161 +++++---
 drivers/watchdog/Makefile                          |   3 +
 drivers/watchdog/asm9260_wdt.c                     |  24 +-
 drivers/watchdog/aspeed_wdt.c                      |  14 +-
 drivers/watchdog/atlas7_wdt.c                      |   2 +-
 drivers/watchdog/bcm2835_wdt.c                     |  84 ++--
 drivers/watchdog/bcm47xx_wdt.c                     |   3 -
 drivers/watchdog/bcm7038_wdt.c                     |   2 +-
 drivers/watchdog/bcm_kona_wdt.c                    |   4 +-
 drivers/watchdog/booke_wdt.c                       |   4 +-
 drivers/watchdog/cadence_wdt.c                     |   2 +-
 drivers/watchdog/coh901327_wdt.c                   |  88 +---
 drivers/watchdog/da9052_wdt.c                      |  34 +-
 drivers/watchdog/da9055_wdt.c                      |  19 +-
 drivers/watchdog/da9062_wdt.c                      |  18 +-
 drivers/watchdog/da9063_wdt.c                      |  18 +-
 drivers/watchdog/diag288_wdt.c                     |   2 +-
 drivers/watchdog/digicolor_wdt.c                   |  52 +--
 drivers/watchdog/dw_wdt.c                          |  23 +-
 drivers/watchdog/ebc-c384_wdt.c                    |  14 +-
 drivers/watchdog/ep93xx_wdt.c                      | 116 +++---
 drivers/watchdog/gemini_wdt.c                      | 229 +++++++++++
 drivers/watchdog/iTCO_wdt.c                        | 426 +++++++++-----------
 drivers/watchdog/imgpdc_wdt.c                      |   2 +-
 drivers/watchdog/intel-mid_wdt.c                   |  11 +-
 drivers/watchdog/kempld_wdt.c                      |   2 +-
 drivers/watchdog/lantiq_wdt.c                      |   4 +-
 drivers/watchdog/lpc18xx_wdt.c                     |   2 +-
 drivers/watchdog/mena21_wdt.c                      |  24 +-
 drivers/watchdog/meson_wdt.c                       |  23 +-
 drivers/watchdog/mt7621_wdt.c                      |   6 +-
 drivers/watchdog/nic7018_wdt.c                     | 265 ++++++++++++
 drivers/watchdog/orion_wdt.c                       |   2 +-
 drivers/watchdog/pika_wdt.c                        |   2 +-
 drivers/watchdog/rn5t618_wdt.c                     |   2 +-
 drivers/watchdog/rt2880_wdt.c                      |   4 +-
 drivers/watchdog/s3c2410_wdt.c                     |  73 ++--
 drivers/watchdog/sa1100_wdt.c                      |   8 +-
 drivers/watchdog/sama5d4_wdt.c                     |  64 +--
 drivers/watchdog/sbsa_gwdt.c                       |   4 +-
 drivers/watchdog/sirfsoc_wdt.c                     |   2 +-
 drivers/watchdog/softdog.c                         |  21 +-
 drivers/watchdog/sun4v_wdt.c                       |   2 +-
 drivers/watchdog/sunxi_wdt.c                       |  24 +-
 drivers/watchdog/tangox_wdt.c                      |  34 +-
 drivers/watchdog/tegra_wdt.c                       |   4 +-
 drivers/watchdog/ts72xx_wdt.c                      | 447 ++++-----------------
 drivers/watchdog/w83627hf_wdt.c                    |   2 +-
 drivers/watchdog/watchdog_dev.c                    |   5 +
 drivers/watchdog/wm831x_wdt.c                      |  31 +-
 drivers/watchdog/zx2967_wdt.c                      | 291 ++++++++++++++
 include/linux/watchdog.h                           |   7 +
 57 files changed, 1536 insertions(+), 1243 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
 create mode 100644 drivers/watchdog/gemini_wdt.c
 create mode 100644 drivers/watchdog/nic7018_wdt.c
 create mode 100644 drivers/watchdog/zx2967_wdt.c
