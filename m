Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49402 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751527AbaAVXFC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 18:05:02 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v4 00/18] Armada 370/XP watchdog support
Date: Wed, 22 Jan 2014 20:04:57 -0300
Message-Id: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

After some lengthy discussion on the [v2] and [v3] patchsets, here's a new
round. I hope I haven't forgotten anything.

[v2] http://www.spinics.net/lists/arm-kernel/msg302104.html

[v3] http://www.spinics.net/lists/arm-kernel/msg302245.html

The main changes from v3 are:

  * It wasn't nice to break DT compatibility by adding a second resource
    requirement, so we provided a fallback to use the RSTOUT address.
    All in all, the solution doesn't look too bad.

  * Added a full watchdog stop at driver probe time, *before* the call
    to request_irq().

    Notice that currently the request_irq() doesn't seem to clear the
    pending interruption. This means the BRIDGE_CAUSE clear removal is
    still not safe.

    This should be fixed sooner than later and, of course, before this
    gets merged.

  * Rework the interruption request, to use devm_request_irq() and
    avoid dealing with IRQ releasing.

  * Added proper clock error handling and fixed the probe() error path.

  * Typos and minor issues got fixed

Thanks to everyone who has helped reviewing the previous sets! It's certainly
easier to move forward when you get so much nice feedback...

Ezequiel Garcia (18):
  ARM: Introduce atomic MMIO modify
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Add clock error handling
  watchdog: orion: Use atomic access for shared registers
  watchdog: orion: Remove unused macros
  watchdog: orion: Make sure the watchdog is initially stopped
  watchdog: orion: Handle IRQ
  watchdog: orion: Make RSTOUT register a separate resource
  watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
  watchdog: orion: Introduce an orion_watchdog device structure
  watchdog: orion: Introduce per-compatible of_device_id data
  watchdog: orion: Add per-compatible clock initialization
  watchdog: orion: Add per-compatible watchdog start implementation
  watchdog: orion: Add support for Armada 370 and Armada XP SoC
  ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
  ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
  watchdog: orion: Enable the build on ARCH_MVEBU
  ARM: mvebu: Enable watchdog support in defconfig

 .../devicetree/bindings/watchdog/marvel.txt        |   8 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
 arch/arm/boot/dts/armada-370.dtsi                  |   5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   6 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 arch/arm/configs/mvebu_defconfig                   |   2 +
 arch/arm/include/asm/io.h                          |   6 +
 arch/arm/kernel/io.c                               |  35 ++
 arch/arm/mach-dove/include/mach/bridge-regs.h      |   1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   1 +
 arch/arm/plat-orion/common.c                       |  10 +-
 drivers/clocksource/time-orion.c                   |  28 +-
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/orion_wdt.c                       | 370 ++++++++++++++++-----
 16 files changed, 373 insertions(+), 109 deletions(-)

-- 
1.8.1.5

