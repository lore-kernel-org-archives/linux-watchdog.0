Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55159 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736Ab3ALRO2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 12 Jan 2013 12:14:28 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, zajec5@gmail.com,
	linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs with PMU
Date: Sat, 12 Jan 2013 18:14:06 +0100
Message-Id: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch series improves the functions for setting the watchdog 
driver for bcm47xx based SoCs using ssb and bcma. This makes the 
watchdog driver use the platform device provided by bcma or ssb.

This code is currently based on the linux-watchdog/master tree by 
Wim Van Sebroeck.

v4:
 * Just the parts changing the watchdog driver itself and not ssb or bcma.

v3:
 * Remove changes done to the watchdog driver so John could pull this 
   into wireless-testing, this sill works with the old watchdog driver. 
   The patches changing the watchdog driver will be send later.
   This was done to get this into 3.8 because Wim Van Sebroeck is 
   neither giving an Ack or a Nack on these patches and we want to do 
   more changes to bcma/ssb on top of these.

v2:
 * reword some commit messages
 * rebase on current wireless-testing/master with 
      "ssb: extif: fix compile errors" applied on top of it.
 * do not change value of WDT_SOFTTIMER_MAX
 * moved some small changes in the bcm47xx_wdt.c patches

Hauke Mehrtens (5):
  watchdog: bcm47xx_wdt.c: convert to watchdog core api
  watchdog: bcm47xx_wdt.c: use platform device
  watchdog: bcm47xx_wdt.c: rename ops methods
  watchdog: bcm47xx_wdt.c: rename wdt_time to timeout
  watchdog: bcm47xx_wdt.c: add hard timer

 drivers/watchdog/Kconfig       |    1 +
 drivers/watchdog/bcm47xx_wdt.c |  339 +++++++++++++++++-----------------------
 include/linux/bcm47xx_wdt.h    |    9 ++
 3 files changed, 154 insertions(+), 195 deletions(-)

-- 
1.7.10.4

