Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60476 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758359Ab3GOXdH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jul 2013 19:33:07 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree-discuss@lists.ozlabs.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 00/10] Orion Watchdog fixes
Date: Mon, 15 Jul 2013 20:32:33 -0300
Message-Id: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchset introduces a bunch of fixes that removes the direct use of
the shared timer control register, and also removes the need to include
a mach-specific header.

With this changes the driver can be included in multiplatforms builds,
and in particular be used for the Armada 370/XP SoC.

I'm sending this early patchset mainly to discuss the possibility of
introducing this changes. As cleared stated in each patch, this series
breaks device-tree compatilibity by changing the meaning of the watchdog
node 'reg' property.

I'm aware of the implications of this, but I'm not sure how 'stable' the
Kirkwood DT is considered. So, given we're currently moving things around,
maybe there is still a chance to do this.

This patchset applies on top of Sebastian Hesselbarth's branch:

  git://github.com/shesselba/linux-dove.git orion-irqchip-for-v3.11_v4

Ezequiel Garcia (10):
  clocksource: orion: Add thread-safe API header
  watchdog: orion: Use thread-safe clocksource API
  watchdog: orion: Rename device-tree binding documentation
  watchdog: orion: Use the proper watchdog register
  watchdog: orion: Add a memory resource for RSTOUT register
  watchdog: orion: Update device-tree binding documentation
  watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
  watchdog: orion: Remove mach-specific unneeded header
  watchdog: orion: Use BIT()
  ARM: kirkwood: Fix the device-tree watchdog's node reg property

 .../watchdog/{marvel.txt => orion-wdt.txt}         |  8 ++--
 arch/arm/boot/dts/kirkwood.dtsi                    |  3 +-
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |  2 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |  2 +
 arch/arm/plat-orion/common.c                       | 10 +++--
 drivers/watchdog/orion_wdt.c                       | 46 +++++++++-------------
 include/linux/time-orion.h                         |  7 ++++
 7 files changed, 42 insertions(+), 36 deletions(-)
 rename Documentation/devicetree/bindings/watchdog/{marvel.txt => orion-wdt.txt} (58%)
 create mode 100644 include/linux/time-orion.h

-- 
1.8.1.5

