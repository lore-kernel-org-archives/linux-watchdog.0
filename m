Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43375 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab1GNKxL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2011 06:53:11 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/3] watchdog: remove empty pms
Date: Thu, 14 Jul 2011 12:53:00 +0200
Message-Id: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

While checking what watchdog drivers usually do in suspend/resume to
spot common behaviour for the watchdog framework, I found these drivers
which do nothing but add some cruft. Remove it, it is superfluous. New
approaches should probably be done with pm_ops anyway.

Wolfram Sang (3):
  watchdog: at91: remove empty pm-functions
  watchdog: iTCO: remove empty pm-functions
  watchdog: sch311x: remove empty pm-functions

 drivers/watchdog/at91sam9_wdt.c |   19 -------------------
 drivers/watchdog/iTCO_wdt.c     |    5 -----
 drivers/watchdog/sch311x_wdt.c  |    5 -----
 3 files changed, 0 insertions(+), 29 deletions(-)

-- 
1.7.5.4

