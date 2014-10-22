Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52472 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751673AbaJVNge (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 09:36:34 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 0/4] Make Armada 375 use the reference clock when possible
Date: Wed, 22 Oct 2014 10:34:40 -0300
Message-Id: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This series adds support for the 25 MHz reference clock available on
Armada 375 SoC to use on the timer and watchdog drivers. It is
similar to the one present in Armada XP SoC.

Given we initially had access to only a very early SoC revision (A375 Z0)
and due to a hardware issue, the timer and watchdog support was originally
submitted to use the core clock.

Now that the A0 SoC revision is out, we can fix this and use the reference
clock. The reason for this change is that the core clock is subject to the
SSCG, so boards where SSCG is enabled exhibit a very large timer drift.

To prevent any compatibility issues when booting with an older devicetree,
this series provides proper fall backs in each case.

The series applies on v3.18-rc1. As usual, any feedback is well received!

Ezequiel Garcia (4):
  clocksource: armada-370-xp: Add missing clock enable
  watchdog: orion: Use the reference clock on Armada 375 SoC
  clocksource: armada-370-xp: Use the reference clock on A375 SoC
  ARM: dts: Enable the reference clock for timer and watchdog on Armada
    375 SoC

 .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++--
 arch/arm/boot/dts/armada-375.dtsi                  | 12 +++++--
 drivers/clocksource/time-armada-370-xp.c           | 30 ++++++++++++++++
 drivers/watchdog/orion_wdt.c                       | 40 +++++++++++++++++++++-
 4 files changed, 86 insertions(+), 5 deletions(-)

-- 
2.1.0

