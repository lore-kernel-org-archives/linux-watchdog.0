Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51123 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753796AbaA0P1Q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 10:27:16 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v5 00/20] Armada 370/XP watchdog support
Date: Mon, 27 Jan 2014 12:27:00 -0300
Message-Id: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

A new round, mostly fixing some minor nitpicks.

This entire series depends on latest irqchip-orion fixes by Sebastian.
Namely, this one: https://lkml.org/lkml/2014/1/23/594.

How should we handle this dependency?

Changes from v4 are:

  * Provided better commit subject and commit log for patch 7:
    "watchdog: orion: Handle the interrupt so it's properly acked".

  * Corrected the misnamed fuction try_rstout_ioremap().

  * A bunch of s/interruption/interrupt fixes

  * Dropped the '0' as a valid IRQ in the platform_get_irq() check, given
    it should return a positive virq-space number.

Changes from v3 are:

  * It wasn't nice to break DT compatibility by adding a second resource
    requirement, so we provided a fallback to use the RSTOUT address.
    All in all, the solution doesn't look too bad.

  * Added a full watchdog stop at driver probe time, *before* the call
    to request_irq().

    Notice that currently the request_irq() doesn't seem to clear the
    pending interrupt. This means the BRIDGE_CAUSE clear removal is
    still not safe.

    This should be fixed sooner than later and, of course, before this
    gets merged.

  * Rework the interrupt request, to use devm_request_irq() and
    avoid dealing with IRQ releasing.

  * Added proper clock error handling and fixed the probe() error path.

  * Typos and minor issues got fixed

Changes from v2:

 * Add proper error checking on clk_prepare_enable() and return
   PTR_ERR instead of ENODEV. Suggested by Fabio Estevam.

 * After the usage of the atomic I/O and considering the watchdog core
   does its own serialization, the driver's spinlock was completely
   redundant and was removed. Also suggested by Fabio.

 * Instead of making the driver dependent on PLAT_ORION, added a dependency
   to ARCH_MVEBU. This was proposed by Sebastian and Andrew, given
   we're working on PLAT_ORION removal.

Changes from v1:

  * Watchdog RSTOUT enable.
    While v1 enabled the RSTOUT at each machine initialization, Jason Gunthorpe
    later pointed out [2] that such enabling might lead to a spurious watchdog
    trigger, in the event of the watchdog expired event not being cleared.

    Therefore, the current patchset adds RSTOUT as a second address resource
    (or 'reg' entry in devicetree words) to allow different platforms specify
    the corresponding address of the register. This change allows to build the
    driver on multiplatforms builds as helps remove a mach-specific header.

    The drawback of this is that the DT backwards compatibility gets broken;
    this was timely discussed but no better solution was achieved or proposed.

  * BRIDGE CAUSE clear removal
    The watchdog cause clear should be done by the bridge irqchip driver, so
    it's fine to remove it from the watchdog driver and instead request the
    interrupt.

    However, there are still a few platforms (orion5x, and legacy
    kirkwood/dove) that doesn't have this bridge irqchip support enabled.
    On these platforms the bridge cause clear is simply *not* done.

    If we are paranoid about this, maybe we can simply add the clear on each
    mach-xxx/irq.c, together with the other irq is initialization.

Once again, thanks to everyone who helped reviewing this.

Ezequiel Garcia (20):
  ARM: Introduce atomic MMIO modify
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

 .../devicetree/bindings/watchdog/marvel.txt        |   8 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
 arch/arm/boot/dts/armada-370.dtsi                  |   5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   6 +
 arch/arm/boot/dts/dove.dtsi                        |   8 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 arch/arm/configs/dove_defconfig                    |   2 +
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
 drivers/watchdog/orion_wdt.c                       | 369 ++++++++++++++++-----
 18 files changed, 383 insertions(+), 108 deletions(-)

-- 
1.8.1.5

