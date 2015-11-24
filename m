Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
	robh+dt@kernel.org,
	shawnguo@kernel.org,
	kernel@pengutronix.de,
	wim@iguana.be,
	sameo@linux.intel.com,
	dinh.linux@gmail.com,
	linux@roeck-us.net,
	Arnd Bergmann <arnd@arndb.de>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v5 0/5] Add board support for TS-4800
Date: Tue, 24 Nov 2015 13:00:48 -0500
Message-Id: <1448388053-30661-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patch serie adds support for TS-4800 board. This board,                                                                              
manufactured by Technologic Systems, is based on an IMX515.

The first stage bootloader, called TS-BOOTROM, enables the watchdog,
so a watchdog driver is required to prevent board from rebooting.

The current device tree is minimal but it allows to get a shell on the
board.

Changes in v5:
 - watchdog: changed iteration stop condition in set_timeout to be less
   error prone

Changes in v4:
 - syscon: rewrite DT property reading to be clearer
 - watchdog: made fixes suggested by Guenter (now uses
   watchdog_init_timeout, u32 instead of u16, fixed error checking in
   probe, cleaned set_timeout)

Changes in v3:
 - Rebased on v4.3
 - Changed vendor prefix from "ts" to "technologic"
 - Added a DT option to generic syscon driver to allow regmap configuration
 - Dropped custom mfd driver, use generic syscon driver instead.

Changes in v2:
 - Added a mfd driver to handle syscon registers
 - The watchdog driver now uses the regmap (created by the mfd driver)
   to access the feed register
 - Remove watchdog's dependency on SOC_IMX51

Damien Riegel (5):
  of: add vendor prefix for Technologic Systems
  mfd: syscon: add a DT property to set value width
  watchdog: ts4800: add driver for TS-4800 watchdog
  ARM: imx_v6_v7_defconfig: add TS-4800 watchdog
  ARM: dts: TS-4800: add basic device tree

 .../devicetree/bindings/arm/technologic.txt        |   6 +
 Documentation/devicetree/bindings/mfd/syscon.txt   |   3 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  25 +++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 | 190 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/mfd/syscon.c                               |  13 ++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ts4800_wdt.c                      | 215 +++++++++++++++++++++
 11 files changed, 467 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
 create mode 100644 arch/arm/boot/dts/imx51-ts4800.dts
 create mode 100644 drivers/watchdog/ts4800_wdt.c

-- 
2.5.0
