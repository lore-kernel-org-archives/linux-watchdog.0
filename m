Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33825 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdGQPNq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Jul 2017 11:13:46 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/5] watchdog: renesas_wdt: improve precision
Date: Mon, 17 Jul 2017 17:12:25 +0200
Message-Id: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently, the renesas-rwdt driver is not precise with input clocks which have
a remainder after the clock divisors are applied. This series should fix the
situation and also pays attention to ensure variables have proper types and are
divided properly. As a cherry on top, we also get a new divider value to allow
for higher max_timeout :)

Originally brought to attention by this BSP patch:
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=7d56256a4d189a83e278ec2013eb1f3648bc7411

Tested with a Salvator-X (R-Car M3-W) and the clock driver hacked to supply the
internal clock of 32552 Hz instead of the externally supplied 32768 Hz.

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/watchdog-fixes

Please comment or apply...

Thanks,

   Wolfram


Wolfram Sang (5):
  watchdog: renesas_wdt: avoid (theoretical) type overflow
  watchdog: renesas_wdt: check rate also for upper limit
  watchdog: renesas_wdt: don't round closest with get_timeleft
  watchdog: renesas_wdt: apply better precision
  watchdog: renesas_wdt: add another divider option

 drivers/watchdog/renesas_wdt.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

-- 
2.11.0

