Return-path: <sebastien.bourdelin@savoirfairelinux.com>
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@savoirfairelinux.com,
	robh@kernel.org,
	linux@roeck-us.net,
	linus.walleij@linaro.org,
	shawnguo@kernel.org
Cc: fabio.estevam@nxp.com,
	mark@embeddedarm.com,
	kris@embeddedarm.com,
	Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v3 0/6] Add board support for TS-4600
Date: Fri,  5 May 2017 15:32:53 -0400
Message-Id: <20170505193259.16517-1-sebastien.bourdelin@savoirfairelinux.com>
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
 arch/arm/boot/dts/imx28-ts4600-common.dtsi         | 126 +++++++
 arch/arm/boot/dts/imx28-ts4600-rev-a.dts           |  22 ++
 arch/arm/boot/dts/imx28-ts4600-rev-b.dts           |  22 ++
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/ts-nbus.c                              | 375 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ts4600_wdt.c                      | 185 ++++++++++
 include/linux/ts-nbus.h                            |  18 +
 14 files changed, 842 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-a.dts
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-b.dts
 create mode 100644 drivers/bus/ts-nbus.c
 create mode 100644 drivers/watchdog/ts4600_wdt.c
 create mode 100644 include/linux/ts-nbus.h

-- 
2.12.0
