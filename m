Return-Path: <chrisp@alliedtelesis.co.nz>
Return-path: <chrisp@alliedtelesis.co.nz>
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: linux@roeck-us.net,
	wim@iguana.be,
	gregory.clement@free-electrons.com,
	devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/3] getting more output from orion_wdt
Date: Wed, 11 Oct 2017 15:29:55 +1300
Message-Id: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
List-ID: <linux-watchdog@vger.kernel.org>

On the Armada-38x platforms (and probably 37x/XP) the current behaviour of on
exipry of the watchdog is a silent reboot of the CPU. The Armada-38x does have
an interrupt which if we don't enable the Global WD bit in the RSTOUTn register
gives us a chance to generate some panic messages that may help track down the
cause of the watchdog timeout.

I've been a bit bold and enabled this in the generic armada-38x.dtsi file. I'd
be happy to leave that part out and have the interrupt enabled on a
board-by-board basis if there are objections.

Chris Packham (3):
  watchdog: orion: fix typo
  watchdog: orion: don't enable rstout if an interrupt is configured
  ARM: mvebu: dts: connect interrupt for WD on armada-38x

 arch/arm/boot/dts/armada-38x.dtsi |  1 +
 drivers/watchdog/orion_wdt.c      | 27 ++++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.14.2
