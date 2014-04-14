Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v4 0/9] Watchdog support for Armada 375/38x SoC
Date: Mon, 14 Apr 2014 10:23:24 -0300
Message-Id: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Here's the fourth round of the patchset adding support for watchdog
on Armada 375 and Armada 38x SoCs, rebased on v3.15-rc1 and with
collected Tested-by's.

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

Tested on A375-DB, A385-DB, A370-RD and Dove Cubox. Sebastian did more tests
on Dove, and Jason Gunthorpe on Kirkwood.

Changes from v3:

  * Added orion_wdt_get_regs() to do the ioremap'ing (and region request
    for non-shared regions), as previously suggested by Guenter. The probe()
    function is a bit more readable after this.

Changes from v2:

  * Cleaned-up usage of atomic_io_modify(), using it only when needed.
    For instance, the RSTOUT dedicated register on Armada 370/375/380/XP
    can be safely access without any lock.

  * Use devm_ioremap_resource() for the non-shared registers. The shared
    registers need to use devm_ioremap(), which does not request the
    memory region.

Changes from v1:

  * Reworked entirely!

Ezequiel Garcia (9):
  watchdog: orion: Move the register ioremap'ing to its own function
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
 drivers/watchdog/orion_wdt.c                       | 213 ++++++++++++++++++---
 4 files changed, 210 insertions(+), 23 deletions(-)

-- 
1.9.1
