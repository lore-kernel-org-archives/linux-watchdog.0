Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37209 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461AbcCBWdr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2016 17:33:47 -0500
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/6] treewide: test clock rate to avoid division by 0
Date: Wed,  2 Mar 2016 23:33:31 +0100
Message-Id: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Here is the outcome of researching if the result of clk_get_rate() was directly
used as a divisor without checking if it is 0. Inspired by a Coverity report.

Wolfram Sang (6):
  ide: palm_bk3710: test clock rate to avoid division by 0
  net: ethernet: renesas: ravb_main: test clock rate to avoid division
    by 0
  pwm: pwm-img: test clock rate to avoid division by 0
  pwm: pwm-lpc18xx-sct: test clock rate to avoid division by 0
  watchdog: atlas7_wdt: test clock rate to avoid division by 0
  watchdog: tangox_wdt: test clock rate to avoid division by 0

 drivers/ide/palm_bk3710.c                | 2 ++
 drivers/net/ethernet/renesas/ravb_main.c | 3 +++
 drivers/pwm/pwm-img.c                    | 5 +++++
 drivers/pwm/pwm-lpc18xx-sct.c            | 2 ++
 drivers/watchdog/atlas7_wdt.c            | 5 +++++
 drivers/watchdog/tangox_wdt.c            | 2 ++
 6 files changed, 19 insertions(+)

-- 
2.7.0

