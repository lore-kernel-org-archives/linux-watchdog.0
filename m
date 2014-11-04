Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34778 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750985AbaKDNXL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Nov 2014 08:23:11 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 0/3] Make Armada 375 use the reference clock when possible
Date: Tue,  4 Nov 2014 10:21:30 -0300
Message-Id: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Daniel, Wim:

Seems we are ready to merge these, unless some objection raises. Do you think
you can take the patches through your trees?

Changes from v2:

  * Fix messed up empty lines, as suggested by Thomas Petazzoni.

Changes from v1:

  * Make the A375 timer and watchdog devicetree binding match the hardware
    and require the two available clocks: core and reference clock.

This series adds support for the 25 MHz reference clock available on
Armada 375 SoC to be used on the timer and watchdog drivers. It is
similar to the one present in Armada XP SoC.

Given we initially had access to only a very early SoC revision (A375 Z1)
and due to a hardware issue, the timer and watchdog support was originally
submitted to use the core clock.

Now that the A0 SoC revision is out, we can fix this and use the reference
clock. The reason for this change is that the core clock is subject to the
SSCG (Spread Spectrum Clock Generator), so boards where SSCG is enabled
exhibit a very large timer drift.

Notice that this change will produce unpleseant results on A375 Z1, given the
reference 25 MHz clock doesn't work properly on that SoC revision.

But since the Z1 revision is not supported by the recently submitted A375
network driver (mvpp2), and therefore nobody is expected to run mainline
(if there are users at all of this early revision), the support will be
dropped entirely in a near future.

To prevent any compatibility issues when booting with an older devicetree,
this series provides proper fall backs in each case.

The series applies on v3.18-rc2.

Ezequiel Garcia (3):
  clocksource: armada-370-xp: Add missing clock enable
  watchdog: orion: Use the reference clock on Armada 375 SoC
  clocksource: armada-370-xp: Use the reference clock on A375 SoC

 .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++--
 .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
 drivers/clocksource/time-armada-370-xp.c           | 30 ++++++++++++++++
 drivers/watchdog/orion_wdt.c                       | 42 +++++++++++++++++++++-
 4 files changed, 90 insertions(+), 4 deletions(-)

-- 
2.1.0

