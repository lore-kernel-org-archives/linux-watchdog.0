Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:48163 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965332AbbJ0UmR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 16:42:17 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 0/4] Add board support for TS-4800
Date: Tue, 27 Oct 2015 16:33:37 -0400
Message-Id: <1445978021-13961-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch serie adds support for TS-4800 board. This board,
manufactured by Technologic Systems, is based on an IMX515.

The first stage bootloader, called TS-BOOTROM, enables the watchdog,
so a watchdog driver is required to prevent board from rebooting.

The current device tree is minimal but it allows to get a shell on the
board.

Damien Riegel (4):
  of: add vendor prefix for Technologic Systems
  watchdog: ts4800: add new driver for TS-4800 watchdog
  ARM: imx_v6_v7_defconfig: add TS-4800 watchdog
  ARM: dts: TS-4800: add basic device tree

 Documentation/devicetree/bindings/arm/ts.txt       |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  12 ++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 | 186 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/watchdog/Kconfig                           |   9 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ts4800_wdt.c                      | 212 +++++++++++++++++++++
 9 files changed, 430 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ts.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
 create mode 100644 arch/arm/boot/dts/imx51-ts4800.dts
 create mode 100644 drivers/watchdog/ts4800_wdt.c

-- 
2.5.0

