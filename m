Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44865 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbbKXNWe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 08:22:34 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] Watchdog updates for Linux v4.5 (v1)
Date: Tue, 24 Nov 2015 05:22:30 -0800
Message-Id: <1448371350-29585-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

This is my first watchdog pull request for v4.5. The branch is currently based
on v4.4-rc2.

Please consider pulling watchdog updates for Linux v.5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim-4.5-v1

The tag has been applied on top of the watchdog-next branch. The branch includes
a number of patches I collected over the last few months. It does not include
all submitted patches; only the ones I reviewed and felt comfortable with are
included. Some may already be in your -next branch.

I reviewed all patches and ran build tests as well as source verification
tests with both smatch and sparse. Fenguang's 0-day build system reported
a successful build. The most recent build results are available at
http://server.roeck-us.net:8010/builders, in the watchdog-next column.

If you don't want to apply the entire series, please consider applying whatever
subset you might feel comfortable with.

Since there are some infrastructure changes, specifically the addition of reboot
and restart notifiers to the watchdog core, it would be great to know which
of the patches are acceptable to you or, in other words, if any of the changes
will need to be reworked or are unacceptable. This would simplify work on
ongoing infrastructure enhancements (hardware maximum timeout, pretimeout,
and possibly others) a lot.

Thanks,
Guenter

------
The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-wim-4.5-v1

for you to fetch changes up to 86d616e098b444a22e18c578ae9df6f306003128:

  watchdog: w83627hf_wdt: use core reboot notifier (2015-11-22 17:15:02 -0800)

----------------------------------------------------------------
Watchdog patches queued for v4.5 (v1)

watchdog: w83627hf_wdt: use core reboot notifier
watchdog: softdog: use core reboot notifier
watchdog: gpio_wdt: use core reboot notifier
watchdog: cadence_wdt: use core reboot notifier
watchdog: bcm47xx_wdt: use core reboot notifier
watchdog: core: add reboot notifier support
devicetree: watchdog: add binding for Sigma Designs SMP8642 watchdog
watchdog: add support for Sigma Designs SMP86xx/SMP87xx
watchdog: mtk_wdt: Use MODE_KEY when stopping the watchdog
watchdog: sunxi_wdt: use core restart handler
watchdog: s3c2410_wdt: use core restart handler
watchdog: qcom-wdt: use core restart handler
watchdog: mtk_wdt: use core restart handler
watchdog: moxart_wdt: use core restart handler
watchdog: meson_wdt: use core restart handler
watchdog: lpc18xx_wdt: use core restart handler
watchdog: imx2_wdt: use core restart handler
watchdog: imgpdc_wdt: use core restart handler
watchdog: digicolor_wdt: use core restart handler
watchdog: da9063_wdt: use core restart handler
watchdog: bcm47xx_wdt: use core restart handler
watchdog: core: add restart handler support
watchdog: Add support for Freescale Layerscape platforms
watchdog: pnx4008: fix warnings caused by enabling unprepared clock
watchdog: pnx4008: make global wdt_clk static
watchdog: omap_wdt: fix null pointer dereference
watchdog: w83977f_wdt: underflow in wdt_set_timeout()
watchdog: tegra: Stop watchdog first if restarting
watchdog: Read device status through sysfs attributes
watchdog: Use static struct class watchdog_class in stead of pointer

----------------------------------------------------------------
Andrew Chew (1):
      watchdog: tegra: Stop watchdog first if restarting

Damien Riegel (19):
      watchdog: core: add restart handler support
      watchdog: bcm47xx_wdt: use core restart handler
      watchdog: da9063_wdt: use core restart handler
      watchdog: digicolor_wdt: use core restart handler
      watchdog: imgpdc_wdt: use core restart handler
      watchdog: imx2_wdt: use core restart handler
      watchdog: lpc18xx_wdt: use core restart handler
      watchdog: meson_wdt: use core restart handler
      watchdog: moxart_wdt: use core restart handler
      watchdog: mtk_wdt: use core restart handler
      watchdog: qcom-wdt: use core restart handler
      watchdog: s3c2410_wdt: use core restart handler
      watchdog: sunxi_wdt: use core restart handler
      watchdog: core: add reboot notifier support
      watchdog: bcm47xx_wdt: use core reboot notifier
      watchdog: cadence_wdt: use core reboot notifier
      watchdog: gpio_wdt: use core reboot notifier
      watchdog: softdog: use core reboot notifier
      watchdog: w83627hf_wdt: use core reboot notifier

Dan Carpenter (1):
      watchdog: w83977f_wdt: underflow in wdt_set_timeout()

Mans Rullgard (1):
      watchdog: add support for Sigma Designs SMP86xx/SMP87xx

MÃ¥ns RullgÃ¥rd (1):
      devicetree: watchdog: add binding for Sigma Designs SMP8642 watchdog

Nicolas Boichat (1):
      watchdog: mtk_wdt: Use MODE_KEY when stopping the watchdog

Peter Robinson (1):
      watchdog: omap_wdt: fix null pointer dereference

Pratyush Anand (2):
      watchdog: Use static struct class watchdog_class in stead of pointer
      watchdog: Read device status through sysfs attributes

Shaohui Xie (1):
      watchdog: Add support for Freescale Layerscape platforms

Vladimir Zapolskiy (2):
      watchdog: pnx4008: make global wdt_clk static
      watchdog: pnx4008: fix warnings caused by enabling unprepared clock

 Documentation/ABI/testing/sysfs-class-watchdog     |  51 +++++
 .../bindings/watchdog/sigma,smp8642-wdt.txt        |  18 ++
 Documentation/watchdog/watchdog-kernel-api.txt     |  27 +++
 drivers/watchdog/Kconfig                           |  12 +-
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bcm47xx_wdt.c                     |  55 ++---
 drivers/watchdog/cadence_wdt.c                     |  36 +---
 drivers/watchdog/da9063_wdt.c                      |  23 +--
 drivers/watchdog/digicolor_wdt.c                   |  18 +-
 drivers/watchdog/gpio_wdt.c                        |  35 +---
 drivers/watchdog/imgpdc_wdt.c                      |  34 ++--
 drivers/watchdog/imx2_wdt.c                        |  23 +--
 drivers/watchdog/lpc18xx_wdt.c                     |  52 ++---
 drivers/watchdog/meson_wdt.c                       |  23 +--
 drivers/watchdog/moxart_wdt.c                      |  23 +--
 drivers/watchdog/mtk_wdt.c                         |  23 +--
 drivers/watchdog/omap_wdt.c                        |   2 +-
 drivers/watchdog/pnx4008_wdt.c                     |   8 +-
 drivers/watchdog/qcom-wdt.c                        |  49 ++---
 drivers/watchdog/s3c2410_wdt.c                     |  60 +++---
 drivers/watchdog/softdog.c                         |  30 +--
 drivers/watchdog/sunxi_wdt.c                       |  23 +--
 drivers/watchdog/tangox_wdt.c                      | 225 +++++++++++++++++++++
 drivers/watchdog/tegra_wdt.c                       |   4 +-
 drivers/watchdog/w83627hf_wdt.c                    |  32 +--
 drivers/watchdog/w83977f_wdt.c                     |   2 +-
 drivers/watchdog/watchdog_core.c                   | 102 ++++++++--
 drivers/watchdog/watchdog_core.h                   |   2 +-
 drivers/watchdog/watchdog_dev.c                    | 136 ++++++++++++-
 include/linux/bcm47xx_wdt.h                        |   3 -
 include/linux/watchdog.h                           |  15 ++
 31 files changed, 715 insertions(+), 432 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-watchdog
 create mode 100644 Documentation/devicetree/bindings/watchdog/sigma,smp8642-wdt.txt
 create mode 100644 drivers/watchdog/tangox_wdt.c
