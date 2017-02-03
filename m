Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:49132 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdBCTrd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Feb 2017 14:47:33 -0500
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com,
        horms+renesas@verge.net.au, treding@nvidia.com,
        jonathanh@nvidia.com, f.fainelli@gmail.com, kernel@pengutronix.de,
        shawnguo@kernel.org, linux@armlinux.org.uk, wim@iguana.be,
        mark.rutland@arm.com, damien.riegel@savoirfairelinux.com,
        lucile.quirion@savoirfairelinux.com, olof@lixom.net, arnd@arndb.de,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v2 0/6] Add board support for TS-4600
Date: Fri,  3 Feb 2017 14:47:23 -0500
Message-Id: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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
 arch/arm/boot/dts/imx28-ts4600-common.dtsi         | 126 ++++++++
 arch/arm/boot/dts/imx28-ts4600-rev-a.dts           |  22 ++
 arch/arm/boot/dts/imx28-ts4600-rev-b.dts           |  22 ++
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/ts-nbus.c                              | 357 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ts4600_wdt.c                      | 217 +++++++++++++
 include/linux/ts-nbus.h                            |  26 ++
 14 files changed, 864 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-a.dts
 create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-b.dts
 create mode 100644 drivers/bus/ts-nbus.c
 create mode 100644 drivers/watchdog/ts4600_wdt.c
 create mode 100644 include/linux/ts-nbus.h

-- 
2.11.0

