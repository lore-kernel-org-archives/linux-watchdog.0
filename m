Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39635 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752804AbaAUJMe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:12:34 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 00/15] Armada 370/XP watchdog support
Date: Tue, 21 Jan 2014 06:12:26 -0300
Message-Id: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The second patchset to extend Orion watchdog driver adding support for
Armada 370/XP SoC.

On this series I've tried to address all the issues raised when the previous
patchset was submitted. See here [1] for the previous thread.

I suggest that you go through the above thread to get the full picture.
Anyway, long story short, the main two issues are the ones preventing
multiplatform building:

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
  interruption.

  However, there are still a few platforms (orion5x, and legacy
  kirkwood/dove) that doesn't have this bridge irqchip support enabled.
  On these platforms the bridge cause clear is simply *not* done.

  If we are paranoid about this, maybe we can simply add the clear on each
  mach-xxx/irq.c, together with the other irq is initialization.

The rest of the work is mostly the same as v1.

Patches 1-3 introduces the Atomic I/O API needed to access shared registers;
this patch has been properly discussed elsewhere and has been submitted to
the ARM patch tracker for its inclusion in v3.14.

Patches 2-3 uses the atomic I/O API on the clocksource and watchdog drivers.
The orion clocksource patch is submitted here because the register is shared
with the watchdog.

Patch 4 adds the interrupt handling as already explained above.
Patch 5-6 peform the already discussed RSTOUT and BRIDGE CAUSE changes and
allows multiplatform build.

Patches 7-10 extends the orion_wdt driver to support other SoCs.
Patch 11 adds the Armada 370/XP support.

Patches 12-13 updates the devicetree files, patch 14 allows to build
the driver on any Orion platform and finally patch 15 updates the
defconfig.

This series is based on v3.13-rc8 and has been tested on:

 * Kirkwood Openblocks A6
 * Armada 370 Reference Design

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/263459
[2] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/263544

Ezequiel Garcia (15):
  ARM: Introduce atomic MMIO modify
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Use atomic access for shared registers
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
  watchdog: orion: Allow to build on any Orion platform
  ARM: mvebu: Enable watchdog support in defconfig

 .../devicetree/bindings/watchdog/marvel.txt        |   8 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
 arch/arm/boot/dts/armada-370.dtsi                  |   5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   6 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 arch/arm/configs/mvebu_defconfig                   |   2 +
 arch/arm/include/asm/io.h                          |   6 +
 arch/arm/kernel/io.c                               |  35 +++
 arch/arm/mach-dove/include/mach/bridge-regs.h      |   1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   1 +
 arch/arm/plat-orion/common.c                       |  10 +-
 drivers/clocksource/time-orion.c                   |  28 +-
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/orion_wdt.c                       | 316 ++++++++++++++++-----
 16 files changed, 333 insertions(+), 95 deletions(-)

-- 
1.8.1.5

