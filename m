Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32954 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab1LHRTy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 8 Dec 2011 12:19:54 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/3] watchdog: new driver for STMP3xxx/MX23/MX28
Date: Thu,  8 Dec 2011 18:19:40 +0100
Message-Id: <1323364783-1059-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Introduce a new user of the watchdog framework :) This is a rewritten driver
for STMP and imx23/28 (the old one was not compilable anymore due to the
missing mach). Please read the patch descriptions to understand why I think a
rewrite was necessary. The first patch adds an accessor routine to the
RTC-driver which can hopefully go via the watchdog-tree as well. The second
patch adds the new driver, the third removes the old one.

I hope this can make it for 3.3; the old driver was broken (= not compilable)
anyhow, so there cannot be any regression. Tested on a MX28EVK.

Regards,

   Wolfram

Changes since V1:

* don't use EXPORT_SYMBOL for the callback into the RTC anymore.
  Now, the callback is provided via platform_data to make sure it is
  private between RTC and watchdog.

* use more helpers to reduce driver size (module_platform_driver, pm_ops)

Wolfram Sang (3):
  rtc: stmp3xxx: add wdt-accessor function
  watchdog: add new driver for STMP3xxx and i.MX23/28
  watchdog: remove old STMP3XXX driver

 drivers/rtc/rtc-stmp3xxx.c          |   64 ++++++++
 drivers/watchdog/Kconfig            |   13 +-
 drivers/watchdog/Makefile           |    2 +-
 drivers/watchdog/stmp3xxx_rtc_wdt.c |  139 ++++++++++++++++
 drivers/watchdog/stmp3xxx_wdt.c     |  297 -----------------------------------
 include/linux/stmp3xxx_rtc_wdt.h    |   15 ++
 6 files changed, 226 insertions(+), 304 deletions(-)
 create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c
 delete mode 100644 drivers/watchdog/stmp3xxx_wdt.c
 create mode 100644 include/linux/stmp3xxx_rtc_wdt.h

-- 
1.7.7.3

