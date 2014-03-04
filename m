Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41789 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751464AbaCDQH2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Mar 2014 11:07:28 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 0/7] Watchdog support for Armada 375/38x SoC
Date: Tue,  4 Mar 2014 13:07:17 -0300
Message-Id: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Here's a new patchset adding support for watchdog on Armada 375 and
Armada 38x SoCs. Regarding the previous patchset, this time we're handling
the SoCs differences in the watchdog driver itself.

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

Changes from v1:

  * Reworked entirely!

Ezequiel Garcia (7):
  watchdog: orion: Introduce a SoC-specific RSTOUT mapping
  watchdog: orion: Introduce per-SoC stop() function
  watchdog: orion: Introduce per-SoC enabled() function
  watchdog: orion: Add Armada 375/380 SoC support
  ARM: mvebu: Enable Armada 375 watchdog in the devicetree
  ARM: mvebu: Enable Armada 380/385 watchdog in the devicetree
  ARM: mvebu: Add A375/A380 watchdog binding documentation

 .../devicetree/bindings/watchdog/marvel.txt        |   7 +
 arch/arm/boot/dts/armada-375.dtsi                  |   6 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   7 +
 drivers/watchdog/orion_wdt.c                       | 167 +++++++++++++++++++--
 4 files changed, 177 insertions(+), 10 deletions(-)

-- 
1.8.1.5

