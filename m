Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42169 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752378AbaBFRUg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 12:20:36 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v6 00/19] Armada 370/XP watchdog
Date: Thu,  6 Feb 2014 14:20:07 -0300
Message-Id: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

A new round, adding all Tested,Acked-by's and fixing Russell's comment
about the leaking clock.

This series depends on Sebastian's irqchip fixes to clear bridge irqs cause,
Jason has picked it here:

  http://git.infradead.org/linux-mvebu.git mvebu-next/irqchip-fixes

The first patch (for clocksource) is independent of the others.
Daniel: Will you take it?

Wim: Can we take all the watchdog changes through mvebu, with your Ack?
This way, we can sort out the irqchip dependency.

I've pushed a branch, in case anybody feels like doing a test:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_v6

Ezequiel Garcia (19):
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Add clock error handling
  watchdog: orion: Use atomic access for shared registers
  watchdog: orion: Remove unused macros
  watchdog: orion: Make sure the watchdog is initially stopped
  watchdog: orion: Handle the interrupt so it's properly acked
  watchdog: orion: Make RSTOUT register a separate resource
  watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
  watchdog: orion: Introduce an orion_watchdog device structure
  watchdog: orion: Introduce per-compatible of_device_id data
  watchdog: orion: Add per-compatible clock initialization
  watchdog: orion: Add per-compatible watchdog start implementation
  watchdog: orion: Add support for Armada 370 and Armada XP SoC
  ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
  ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
  ARM: dove: Enable Dove watchdog in the devicetree
  watchdog: orion: Enable the build on ARCH_MVEBU
  ARM: mvebu: Enable watchdog support in defconfig
  ARM: dove: Enable watchdog support in the defconfig

 .../devicetree/bindings/watchdog/marvel.txt        |  11 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
 arch/arm/boot/dts/armada-370.dtsi                  |   5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   6 +
 arch/arm/boot/dts/dove.dtsi                        |   8 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 arch/arm/configs/dove_defconfig                    |   2 +
 arch/arm/configs/mvebu_defconfig                   |   2 +
 arch/arm/mach-dove/include/mach/bridge-regs.h      |   1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   1 +
 arch/arm/plat-orion/common.c                       |  10 +-
 drivers/clocksource/time-orion.c                   |  28 +-
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/orion_wdt.c                       | 367 ++++++++++++++++-----
 16 files changed, 345 insertions(+), 106 deletions(-)

-- 
1.8.1.5

