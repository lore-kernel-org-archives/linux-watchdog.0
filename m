Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40168 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab1I1MaW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Sep 2011 08:30:22 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/4] watchdog: new driver for STMP3xxx/MX23/MX28
Date: Wed, 28 Sep 2011 14:29:53 +0200
Message-Id: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Introduce a new user of the watchdog framework :) This is a rewritten driver
for STMP and imx23/28 (which was not compilable anymore due to the missing
mach). Please read the patch descriptions to understand why I think a rewrite
was necessary. The first patch adds an accessor routine to the RTC-driver which
can hopefully go via the watchdog-tree as well. The second patch is a minor
enhancement to the watchdog framework. The third patch adds the new driver,
the fourth removes the old one.

I hope this can make it for 3.2; the old driver was broken (= not compilable)
anyhow, so there cannot be any regression.

Regards,

   Wolfram

Wolfram Sang (4):
  rtc: stmp3xxx: add wdt-accessor function
  watchdog: add define to setup nowayout feature in the status-variable
  watchdog: add new driver for STMP3xxx and i.MX23/28
  watchdog: remove old STMP3XXX driver

 drivers/rtc/rtc-stmp3xxx.c          |   44 +++++
 drivers/watchdog/Kconfig            |   13 +-
 drivers/watchdog/Makefile           |    2 +-
 drivers/watchdog/stmp3xxx_rtc_wdt.c |  147 +++++++++++++++++
 drivers/watchdog/stmp3xxx_wdt.c     |  296 -----------------------------------
 include/linux/watchdog.h            |   14 +-
 6 files changed, 207 insertions(+), 309 deletions(-)
 create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c
 delete mode 100644 drivers/watchdog/stmp3xxx_wdt.c

-- 
1.7.6.3

