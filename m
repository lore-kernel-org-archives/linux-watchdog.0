Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:40336 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbJ2U1m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 29 Oct 2015 16:27:42 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Cc: shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org,
	dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 0/5] Add board support for TS-4800
Date: Thu, 29 Oct 2015 16:27:25 -0400
Message-Id: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch serie adds support for TS-4800 board. This board,
manufactured by Technologic Systems, is based on an IMX515.

The first stage bootloader, called TS-BOOTROM, enables the watchdog,
so a watchdog driver is required to prevent board from rebooting.

The current device tree is minimal but it allows to get a shell on the
board.

Changes in v2:
 - Added a mfd driver to handle syscon registers
 - The watchdog driver now uses the regmap (created by the mfd driver)
   to access the feed register
 - Remove watchdog's dependency on SOC_IMX51

Damien Riegel (5):
  of: add vendor prefix for Technologic Systems
  mfd: ts4800-syscon: add driver for TS-4800 syscon
  watchdog: ts4800: add driver for TS-4800 watchdog
  ARM: imx_v6_v7_defconfig: add TS-4800 watchdog and syscon
  ARM: dts: TS-4800: add basic device tree

 Documentation/devicetree/bindings/arm/ts.txt       |   6 +
 .../devicetree/bindings/mfd/ts4800-syscon.txt      |  20 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  12 ++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 | 192 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   2 +
 drivers/mfd/Kconfig                                |   8 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/ts4800-syscon.c                        |  95 +++++++++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ts4800_wdt.c                      | 216 +++++++++++++++++++++
 include/linux/mfd/ts4800-syscon.h                  |  24 +++
 14 files changed, 590 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ts.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
 create mode 100644 arch/arm/boot/dts/imx51-ts4800.dts
 create mode 100644 drivers/mfd/ts4800-syscon.c
 create mode 100644 drivers/watchdog/ts4800_wdt.c
 create mode 100644 include/linux/mfd/ts4800-syscon.h

-- 
2.5.0

