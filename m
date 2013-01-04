Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39917 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab3ADN7D (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Jan 2013 08:59:03 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/3] improved watchdog driver for STMP3xyz/imx23/imx28
Date: Fri,  4 Jan 2013 14:58:46 +0100
Message-Id: <1357307929-1666-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Geez, this should have been sent a year ago but it dropped off somehow.
Introduce a new user of the watchdog framework. This is a rewritten driver
for STMP and imx23/28: Quoting Patch 2/3 for the motivation of a rewrite:

===

Replace the existing STMP3xxx driver because it has enough drawbacks
that a rewrite is apropriate. The new driver is designed to use the
watchdog framework which makes it a lot smaller and avoids open coding
the watchdog API again. It also uses now an explicitly exported function
from the RTC driver to set up its registers (the old driver silently
reused the hopefully(!) already remapped RTC registers). Also, this
driver is mach independent, while the old one depends on a mach replaced
by another one a year ago. Since the user interface is still the
standard watchdog API, users don't need to adapt.

===

The first patch adds an accessor routine to the RTC-driver which can hopefully
go via the watchdog-tree as well (asking for Andrew's ack here). It is needed
because the old driver silently assumed its IO area to be already remapped by
the RTC driver. The second patch adds the new driver, the third removes the old
one. The old driver was broken (= not compilable, no arch for it) anyhow, so
there cannot be any regression. Based on 3.8-rc2 and tested on various MX28
boards.

Thanks,

   Wolfram


Wolfram Sang (3):
  rtc: stmp3xxx: add wdt-accessor function
  watchdog: add new driver for STMP3xxx and i.MX23/28
  watchdog: remove old STMP3xxx driver

 drivers/rtc/rtc-stmp3xxx.c          |   64 ++++++++
 drivers/watchdog/Kconfig            |   13 +-
 drivers/watchdog/Makefile           |    2 +-
 drivers/watchdog/stmp3xxx_rtc_wdt.c |  111 ++++++++++++++
 drivers/watchdog/stmp3xxx_wdt.c     |  288 -----------------------------------
 include/linux/stmp3xxx_rtc_wdt.h    |   15 ++
 6 files changed, 198 insertions(+), 295 deletions(-)
 create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c
 delete mode 100644 drivers/watchdog/stmp3xxx_wdt.c
 create mode 100644 include/linux/stmp3xxx_rtc_wdt.h

-- 
1.7.10.4

