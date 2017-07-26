Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34838 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbdGZVyz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Jul 2017 17:54:55 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/3] watchdog: renesas_wdt: use standard clock handling
Date: Wed, 26 Jul 2017 23:54:36 +0200
Message-Id: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

As mentioned in a response to a previous patch, clock handling for Renesas
R-Car is done via RuntimePM. Patch 1 implements that consequently. Patch 2
is a cleanup then possible and patch 3 is a trivial copyright update.

This is RFC because I'd like Geert's comments on these patches first which
might take a few days...

Looking forward to other comments, too, of course :)

These patches are on top of the already reviewed 'better-precision' series for
this watchdog. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/watchdog-fixes

These patches have been tested on a Renesas Salvator-X / r8a7796 (R-Car M3-W)

Thanks and kind regards,

   Wolfram


Wolfram Sang (3):
  watchdog: renesas_wdt: consistently use RuntimePM for clock management
  watchdog: renesas_wdt: make 'clk' a variable local to probe()
  watchdog: renesas_wdt: update copyright dates

 drivers/watchdog/renesas_wdt.c | 47 +++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

-- 
2.11.0

