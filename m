Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46764 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607AbbEVTQk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 15:16:40 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 4.2
Date: Fri, 22 May 2015 12:16:12 -0700
Message-Id: <1432322172-18368-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

This is my watchdog pull request for 4.2. The branch is currently based
on v4.1-rc4.

Please consider pulling watchdog updates for Linux 4.2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim-4.2

The tag has been applied on top of the watchdog-next branch. The branch includes
a number of patches I collected over the last few months. It does not include
all submitted patches; only the ones I reviewed and felt comfortable with are
included. Some may already be in your -next branch.

I reviewed all patches and ran build tests as well as source verification tests
with both smatch and spatch. The branch has been on my Linux repository for a
while, so presumably Fenguang's robot will have built the code as well. The most
recent build results are available at http://server.roeck-us.net:8010/builders,
in the watchdog-next column.

If you don't want to apply the entire series, please consider applying whatever
subset you might feel comfortable with.

Thanks,
Guenter
------

The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-wim-4.2

for you to fetch changes up to bebf09e74c36f83e44c25a0542a32a95a5af3b3f:

  watchdog: imgpdc: Add some documentation about the timeout (2015-05-18 17:37:07 -0700)

----------------------------------------------------------------
Watchdog pull request for v4.2

watchdog: imgpdc: Add some documentation about the timeout
watchdog: imgpdc: Fix max timeout
watchdog: dw_wdt: keepalive the watchdog at write time
watchdog: dw_wdt: No need for a spinlock
watchdog: st_wdt: Update IP layout information to include Clocksource
watchdog: imx2_wdt: also set wdog->timeout to new_timeout
watchdog: Allow compile test of GPIO consumers if !GPIOLIB
watchdog: cadence: Add dependency on HAS_IOMEM
watchdog: max63xx_wdt: Constify platform_device_id
watchdog: MAX63XX_WATCHDOG does not depend on ARM
watchdog: omap: assert the counter being stopped before reprogramming
watchdog: imgpdc: Add reboot support
watchdog: imgpdc: Set timeout before starting watchdog
watchdog: imgpdc: Allow timeout to be set in device-tree
watchdog: omap: simplify assignment of bootstatus
watchdog: omap: put struct watchdog_device into driver data
watchdog: omap: use watchdog_init_timeout instead of open coding it
watchdog: omap: clearify device tree documentation
watchdog: digicolor: driver for Conexant Digicolor CX92755 SoC
watchdog: digicolor: document device tree binding
watchdog: at91sam9: use endian agnostic IO
watchdog: st_wdt: Add new driver for ST's LPC Watchdog
ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
mfd: dt-bindings: Provide human readable defines for LPC mode choosing

----------------------------------------------------------------
Andrew Bresticker (3):
      watchdog: imgpdc: Allow timeout to be set in device-tree
      watchdog: imgpdc: Set timeout before starting watchdog
      watchdog: imgpdc: Add reboot support

Baruch Siach (2):
      watchdog: digicolor: document device tree binding
      watchdog: digicolor: driver for Conexant Digicolor CX92755 SoC

Ben Dooks (1):
      watchdog: at91sam9: use endian agnostic IO

Doug Anderson (2):
      watchdog: dw_wdt: No need for a spinlock
      watchdog: dw_wdt: keepalive the watchdog at write time

Ezequiel Garcia (2):
      watchdog: imgpdc: Fix max timeout
      watchdog: imgpdc: Add some documentation about the timeout

Geert Uytterhoeven (1):
      watchdog: Allow compile test of GPIO consumers if !GPIOLIB

Krzysztof Kozlowski (1):
      watchdog: max63xx_wdt: Constify platform_device_id

Lee Jones (4):
      mfd: dt-bindings: Provide human readable defines for LPC mode choosing
      ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
      watchdog: st_wdt: Add new driver for ST's LPC Watchdog
      watchdog: st_wdt: Update IP layout information to include Clocksource

Michael Grzeschik (1):
      watchdog: imx2_wdt: also set wdog->timeout to new_timeout

Richard Weinberger (1):
      watchdog: cadence: Add dependency on HAS_IOMEM

Uwe Kleine-König (5):
      watchdog: omap: clearify device tree documentation
      watchdog: omap: use watchdog_init_timeout instead of open coding it
      watchdog: omap: put struct watchdog_device into driver data
      watchdog: omap: simplify assignment of bootstatus
      watchdog: omap: assert the counter being stopped before reprogramming

Vivien Didelot (1):
      watchdog: MAX63XX_WATCHDOG does not depend on ARM

 .../devicetree/bindings/watchdog/digicolor-wdt.txt |  25 ++
 .../devicetree/bindings/watchdog/omap-wdt.txt      |   9 +-
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/watchdog/Kconfig                           |  28 +-
 drivers/watchdog/Makefile                          |   2 +
 drivers/watchdog/at91sam9_wdt.c                    |   4 +-
 drivers/watchdog/digicolor_wdt.c                   | 205 ++++++++++++
 drivers/watchdog/dw_wdt.c                          |   8 +-
 drivers/watchdog/imgpdc_wdt.c                      |  84 ++++-
 drivers/watchdog/imx2_wdt.c                        |   2 +
 drivers/watchdog/max63xx_wdt.c                     |   2 +-
 drivers/watchdog/omap_wdt.c                        |  73 ++---
 drivers/watchdog/st_lpc_wdt.c                      | 344 +++++++++++++++++++++
 include/dt-bindings/mfd/st-lpc.h                   |  15 +
 14 files changed, 734 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
 create mode 100644 drivers/watchdog/digicolor_wdt.c
 create mode 100644 drivers/watchdog/st_lpc_wdt.c
 create mode 100644 include/dt-bindings/mfd/st-lpc.h
