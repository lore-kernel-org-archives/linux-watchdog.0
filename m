Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:38156 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbaBZMux (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 26 Feb 2014 07:50:53 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 0/2] Watchdog on Armada 375 SoC
Date: Wed, 26 Feb 2014 09:50:45 -0300
Message-Id: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that we have watchdog support on Armada 370/XP SoC, and that the basic
infrastructure for Armada 375 SoC is in place, we can add watchdog support
on Armada 375 as well.

However, there's a specificity we need to handle in order to support watchdog,
related to the RSTOUT. First of all, let's review how we're currently handling
the RSTOUT in the SoCs supported by the orion-wdt driver.

Kirkwood/Dove
-------------

Has one bit for watchdog RSTOUT as part of the RSTOUT global register
that's shared with the system-controller. This could be handled by
mvebu/system-controller.c but instead it's handled in the driver, in order
to prevent a spurious wdt trigger.

In this patch [1] we suggested to handle RSTOUT in the system-controller,
but Jason Gunthorpe explained [2] it could cause a spurious trigger.

Armada 370/XP
-------------

Has a dedicated watchdog RSTOUT register. This is not shared but used by the
watchdog driver only, so in this case it's completely natural to deal with it
in the driver.

For the above reason, we decided to support the watchdog by extending the 'reg'
property to set the watchdog counter and the RSTOUT register offsets:

	watchdog-timer@20300 {
		compatible = "marvell,{soc}-wdt";
		reg = <0x20300 0x28>, <{RSOUT} 0x4>;
	};

Armada 375
----------

Here we found both the above RSTOUT:

1. It has the same dedicated register as A370/XP (0x20704)
2. Also has a bit in the shared RSTOUT register (0x18254)

Solutions
---------

1.

A possible solution is to extend the reg property in the watchdog devicetree
and allow for a new optional pair of cells to complete the specification of the
RSTOUT.

	watchdog-timer@20300 {
		compatible = "marvell,orion-wdt";
		reg = <0x20300 0x28
		       {shared RSOUT} 0x4
		       0x0 0x0>;
	};

	watchdog-timer@20300 {
		compatible = "marvell,armada-370-wdt";
		reg = <0x20300 0x28
		       0x0 0x0
		       {dedicated RSOUT} 0x4>;
	};

	watchdog-timer@20300 {
		compatible = "marvell,armada-375-wdt";
		reg = <0x20300 0x28>
		       shared RSTOUT 0x4
		       {dedicated RSOUT} 0x4>;
	};

2.

Another solution is to add a per-SoC initialization callback in
mvebu/system-controller.c and use it to unmask the Armada 375 shared
RSTOUT watchdog bit, allowing to use the already existent devicetree
binding.

In this scheme, the watchdog in A375 can be handled by the orion-wdt
driver, using the "armada-370-wdt" compatible string.

The current patchset goes with the latter, and implements such solution.

Patch 1 adds the devicetree node and depends on the mvebu/dt-3xx branch.
Patch 2 adds the system-controller RSTOUT unmask and depends on the
mvebu/soc-3xx branch.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/194958.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/195039.html

Ezequiel Garcia (2):
  ARM: mvebu: Enable Armada 375 watchdog in the devicetree
  ARM: mvebu: system-controller: Add A375 initialization

 arch/arm/boot/dts/armada-375.dtsi       |  6 ++++++
 arch/arm/mach-mvebu/system-controller.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

-- 
1.8.1.5

