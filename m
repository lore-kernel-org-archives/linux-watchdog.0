Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59251 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752978AbaBNWYb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Feb 2014 17:24:31 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v7 00/18] Armada 370/XP SoC watchdog support
Date: Fri, 14 Feb 2014 19:24:00 -0300
Message-Id: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jason, Andrew,

This patchset adds watchdog support for the Armada 370/XP ARM SoCs.
The series was sent seven times:

[v1] http://archive.arm.linux.org.uk/lurker/message/20130827.143424.4e961f2b.ca.html
[v2] http://www.spinics.net/lists/arm-kernel/msg302104.html
[v3] http://www.spinics.net/lists/arm-kernel/msg302245.html
[v4] http://www.spinics.net/lists/arm-kernel/msg302602.html
[v5] http://www.spinics.net/lists/arm-kernel/msg303349.html
[v6] http://www.spinics.net/lists/arm-kernel/msg305547.html
[v7] http://www.spinics.net/lists/arm-kernel/msg306534.html

As you can see, it received numerous feedback, testing and reviews;
we've finally reached agreement and so we'd like to merge this series for
v3.15, if at all possible.

However, the watchdog subsystem maintainer remained completely silent through
the *entire* life of this patchset, and so we've no idea what are his plans
about it.

Do you think this can be merged through Andrew's tree? Or maybe through
Jason Cooper's so the irqchip dependency is easily handled?

Thanks a lot!

Original cover letter
=====================

Yet another round. This time, addressing Guenter's comment about the nowayout
parameter. So, to allow for proper nowayout behavior, we now restrict the
initial watchdog stop; which is only done if the watchdog is not properly
enabled.

I've dropped the clocksource patch which was previously part of the series.
The patch is independent and will be merged through the subsystem maintainer,
Daniel Lezcano.

Also, I've updated the multi_v7_defconfig, as per Jason Cooper request.

This series depends on Sebastian's irqchip fixes to clear the bridge irqs
cause, which Jason picked here:

  http://git.infradead.org/linux-mvebu.git mvebu-next/irqchip-fixes

Wim: Can we take all the watchdog changes through mvebu, with your Ack?
This way, we can sort out the irqchip dependency.

Ezequiel Garcia (18):
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
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/configs/mvebu_defconfig                   |   2 +
 arch/arm/mach-dove/include/mach/bridge-regs.h      |   1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   1 +
 arch/arm/plat-orion/common.c                       |  10 +-
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/orion_wdt.c                       | 381 ++++++++++++++++-----
 16 files changed, 352 insertions(+), 87 deletions(-)

-- 
1.8.1.5

