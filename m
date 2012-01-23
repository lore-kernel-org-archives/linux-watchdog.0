Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52193 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab2AWTfW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Jan 2012 14:35:22 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH RESEND 0/3] watchdog: new driver for STMP3xxx/MX23/MX28
Date: Mon, 23 Jan 2012 20:33:02 +0100
Message-Id: <1327347185-620-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Introduce a new user of the watchdog framework. This is a rewritten driver
for STMP and imx23/28: Quoting Patch 2/3 for the motivation of a rewrite:

===

Replace the existing STMP3xxx driver because it has enough drawbacks
that a rewrite is apropriate. The new driver is designed to use the
watchdog framework which makes it a lot smaller. It now uses an exported
function from the RTC driver to set up its registers (the old driver
silently reused the hopefully already remapped RTC registers). Also,
this driver is mach independent, while the old one still depends on a
removed mach.

===

The first patch adds an accessor routine to the RTC-driver which can hopefully
go via the watchdog-tree as well (asking for Andrew's ack here).  The second
patch adds the new driver, the third removes the old one.

After missing the last merge window, I really hope we can get it into 3.4. The
old driver was broken (= not compilable) anyhow, so there cannot be any
regression.  Tested on a MX28EVK.

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
 drivers/watchdog/stmp3xxx_rtc_wdt.c |  139 +++++++++++++++++
 drivers/watchdog/stmp3xxx_wdt.c     |  286 -----------------------------------
 include/linux/stmp3xxx_rtc_wdt.h    |   15 ++
 6 files changed, 226 insertions(+), 293 deletions(-)
 create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c
 delete mode 100644 drivers/watchdog/stmp3xxx_wdt.c
 create mode 100644 include/linux/stmp3xxx_rtc_wdt.h

-- 
1.7.2.5

