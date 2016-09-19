Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:29998 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbcISTUB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 15:20:01 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 0/4] kill get_clock_tick_rate()
Date: Mon, 19 Sep 2016 21:12:11 +0200
Message-Id: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

This serie aims at killing get_clock_tick_rate() from pxa and sa1100 and replace
it by clock API calls.

I'd like to have this reviewed and acked afterwards at least by :
 - Russell for the mach-sa1100 and sa1100_wdt.c
 - Stephen or Michael for the clk-pxa25x.c
 - Thomas or Daniel for the clocksource part
 - Wim for sa1100_wdt.c

If the review converges, I'd also like to take it through the pxa/for-next tree,
or alternatively Russell's tree if there is a dependency I'm not seeing, for
v4.10 cycle.

Cheers.

Robert Jarzmik (3):
  ARM: sa11x0/pxa: acquire timer rate from the clock rate
  watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
  ARM: sa11x0/pxa: get rid of get_clock_tick_rate

Russell King - ARM Linux (1):
  clk: pxa25x: OSTIMER0 clocks from the main oscillator

 arch/arm/mach-pxa/generic.c                  | 18 +-----------------
 arch/arm/mach-pxa/include/mach/hardware.h    |  2 --
 arch/arm/mach-sa1100/generic.c               |  2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h |  4 ----
 drivers/clk/pxa/clk-pxa25x.c                 |  2 +-
 drivers/clocksource/pxa_timer.c              | 11 +++++------
 drivers/watchdog/sa1100_wdt.c                | 24 +++++++++++++++++++++++-
 include/clocksource/pxa.h                    |  3 +--
 8 files changed, 32 insertions(+), 34 deletions(-)

-- 
2.1.4

