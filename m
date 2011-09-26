Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36157 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab1IZNkV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Sep 2011 09:40:21 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/2] convert a driver to the framework and add a HOWTO for that
Date: Mon, 26 Sep 2011 15:40:12 +0200
Message-Id: <1317044414-25234-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

These two patches are taken from my earlier series sent to linux-watchdog and
lkml. The review from Randy Dunlap has been worked into the docs. Because of
kernel.org being down, I based these patches onto 3.1-rc7 but they should also
fit to watchdog-next. Those patches are ready for 3.2, so I submit them now.

I still have work ongoing for pnx4008 and stmp3xxx as well as a new driver for
imx1. However, those need some mach specific cleanups beforehand which are
still work in progress. But those conversions will come, too. I don't like
patches lying around forever ;)

Thanks,

   Wolfram


Wolfram Sang (2):
  Documentation: watchdog: add guide how to convert drivers to new framework
  watchdog: s3c2410: convert to use the watchdog framework

 .../watchdog/convert_drivers_to_kernel_api.txt     |  195 ++++++++++++++++++++
 drivers/watchdog/Kconfig                           |    1 +
 drivers/watchdog/s3c2410_wdt.c                     |  176 ++++--------------
 3 files changed, 233 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/watchdog/convert_drivers_to_kernel_api.txt

-- 
1.7.6.3

