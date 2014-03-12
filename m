Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37461 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752875AbaCLVMU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 17:12:20 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 0/8] Watchdog support for Armada 375/38x SoC
Date: Wed, 12 Mar 2014 18:11:47 -0300
Message-Id: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Third round of the patchset adding support for watchdog on Armada 375 and
Armada 38x SoCs.

The new Armada 375/385 SoCs have two registers for the watchdog RSTOUT:

 1. It has a dedicated register (similar to the one in A370/XP)
 2. Also has a bit in a shared RSTOUT register.

Therefore, in order to support this two-folded RSTOUT, we extend the 'reg'
property in the watchdog devicetree and require a new pair of cells to specify
the shared RSTOUT.

On the driver side, we need to implement per-SoC stop() and enabled()
functions. Such somewhat complex infrastructure is needed to ensure the driver
performs proper reset of the watchdog timer, by masking and disabling the
RSTOUT before the interrupt is enabled.

I've pushed a branch so people can test this easily, e.g. ensuring
no regressions on Dove, Kirkwood and A370/XP:

https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_a385_a375_v3

Changes from v2:

  * Cleaned-up usage of atomic_io_modify(), using it only when needed.
    For instance, the RSTOUT dedicated register on Armada 370/375/380/XP
    can be safely access without any lock.

  * Use devm_ioremap_resource() for the non-shared registers. The shared
    registers need to use devm_ioremap(), which does not request the
    memory region.

Changes from v1:

  * Reworked entirely!

Ezequiel Garcia (8):
  watchdog: orion: Introduce a SoC-specific RSTOUT mapping
  watchdog: orion: Remove unneeded atomic access
  watchdog: orion: Introduce per-SoC stop() function
  watchdog: orion: Introduce per-SoC enabled() function
  watchdog: orion: Add Armada 375/380 SoC support
  ARM: mvebu: Enable Armada 375 watchdog in the devicetree
  ARM: mvebu: Enable Armada 380/385 watchdog in the devicetree
  ARM: mvebu: Add A375/A380 watchdog binding documentation

 .../devicetree/bindings/watchdog/marvel.txt        |   7 +
 arch/arm/boot/dts/armada-375.dtsi                  |   6 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   7 +
 drivers/watchdog/orion_wdt.c                       | 180 +++++++++++++++++++--
 4 files changed, 188 insertions(+), 12 deletions(-)

-- 
1.9.0

