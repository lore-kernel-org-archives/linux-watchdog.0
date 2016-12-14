Return-path: <sebastien.bourdelin@savoirfairelinux.com>
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@savoirfairelinux.com
Cc: mark@embeddedarm.com,
	kris@embeddedarm.com,
	horms+renesas@verge.net.au,
	treding@nvidia.com,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	fabio.estevam@nxp.com,
	kernel@pengutronix.de,
	shawnguo@kernel.org,
	linux@armlinux.org.uk,
	linux@roeck-us.net,
	wim@iguana.be,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	damien.riegel@savoirfairelinux.com,
	lucile.quirion@savoirfairelinux.com,
	olof@lixom.net,
	arnd@arndb.de,
	suzuki.poulose@arm.com,
	linus.walleij@linaro.org,
	will.deacon@arm.com,
	yamada.masahiro@socionext.com,
	Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH 0/6] Add board support for TS-4600
Date: Wed, 14 Dec 2016 18:12:30 -0500
Message-Id: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patch serie adds support for the TS-4600 boards rev A and B. These
boards, manufactured by Technologic Systems, are based on an i.MX28.

This serie include the support for the watchdog which could be enable
at Linux boot time depending on the bootloader.

The watchdog and few peripherals are implemented in a FPGA, and can
only be access using a custom GPIOs bit-banged bus which is called the
NBUS by Technologic Systems.
A driver for this bus is also included and used by the watchdog.

Sebastien Bourdelin (6):
  of: documentation: add bindings documentation for TS-4600
  ARM: dts: TS-4600: add basic device tree
  dt-bindings: bus: Add documentation for the Technologic Systems NBUS
  bus: add driver for the Technologic Systems NBUS
  ARM: dts: TS-4600: add NBUS support
  watchdog: ts4600: add driver for TS-4600 watchdog

 .../devicetree/bindings/arm/technologic.txt        |   5 +
 Documentation/devicetree/bindings/bus/ts-nbus.txt  |  50 +++
 .../devicetree/bindings/watchdog/ts4600-wdt.txt    |  16 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx28-ts4600-common.dtsi         | 126 ++++++
 arch/arm/boot/dts/imx28-ts4600-rev-a.dts           |  22 +
 arch/arm/boot/dts/imx28-ts4600-rev-b.dts           |  22 +
 drivers/bus/Kconfig                                |   9 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/ts-nbus.c                              | 451 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ts4600_wdt.c                      | 213 ++++++++++
 include/linux/ts-nbus.h                            |  17 +
 14 files changed, 945 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-a.dts
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-b.dts
 create mode 100644 drivers/bus/ts-nbus.c
 create mode 100644 drivers/watchdog/ts4600_wdt.c
 create mode 100644 include/linux/ts-nbus.h

-- 
2.10.2
