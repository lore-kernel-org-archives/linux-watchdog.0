Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36938 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212Ab1JCRup (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Oct 2011 13:50:45 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH v2 0/5] add stmp-watchdog driver
Date: Mon,  3 Oct 2011 18:49:57 +0100
Message-Id: <1317664202-4085-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Here is the second series to add a new driver for the STMP3xxx/imx23/28 SoCs.
The callback for setting up the watchdog is now exported via platform_data and
not EXPORT_SYMBOL_GPL to ensure it will only be used by the watchdog driver.
Minor simplifications have been integrated into the watchdog driver.

There is another patch reenabling the nowayout feature on the newly converted
s3c-driver. It is included here because it depends on the new define in 2/5.

This series (as well as my previous patches for 3.2) can be found at:

git://git.pengutronix.de/git/wsa/linux-2.6.git watchdog-for-3.2

Regards,

   Wolfram

Wolfram Sang (5):
  rtc: stmp3xxx: add wdt-accessor function
  watchdog: add define to setup nowayout feature in the status-variable
  watchdog: s3c2410: re-add nowayout feature
  watchdog: add new driver for STMP3xxx and i.MX23/28
  watchdog: remove old STMP3XXX driver

 drivers/rtc/rtc-stmp3xxx.c          |   64 ++++++++
 drivers/watchdog/Kconfig            |   13 +-
 drivers/watchdog/Makefile           |    2 +-
 drivers/watchdog/s3c2410_wdt.c      |    3 +
 drivers/watchdog/stmp3xxx_rtc_wdt.c |  148 +++++++++++++++++
 drivers/watchdog/stmp3xxx_wdt.c     |  296 -----------------------------------
 include/linux/stmp3xxx_rtc_wdt.h    |   15 ++
 include/linux/watchdog.h            |   14 +-
 8 files changed, 246 insertions(+), 309 deletions(-)
 create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c
 delete mode 100644 drivers/watchdog/stmp3xxx_wdt.c
 create mode 100644 include/linux/stmp3xxx_rtc_wdt.h

-- 
1.7.2.5

