Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52595 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755218AbbDTNwW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Apr 2015 09:52:22 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 7/7] watchdog: stmp3xxx_rtc_wdt: fix broken email address
Date: Mon, 20 Apr 2015 15:51:44 +0200
Message-Id: <1429537917-7433-7-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1429537917-7433-1-git-send-email-wsa@the-dreams.de>
References: <1429537917-7433-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

My Pengutronix address is not valid anymore, redirect people to the Pengutronix
kernel team.

Reported-by: Harald Geyer <harald@ccbib.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Robert Schwebel <r.schwebel@pengutronix.de>
---
These patches shall go via the individual subsystem trees.

 drivers/watchdog/stmp3xxx_rtc_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index a62b1b6decf472..e7f0d5b60d3d4f 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -1,7 +1,7 @@
 /*
  * Watchdog driver for the RTC based watchdog in STMP3xxx and i.MX23/28
  *
- * Author: Wolfram Sang <w.sang@pengutronix.de>
+ * Author: Wolfram Sang <kernel@pengutronix.de>
  *
  * Copyright (C) 2011-12 Wolfram Sang, Pengutronix
  *
@@ -129,4 +129,4 @@ module_platform_driver(stmp3xxx_wdt_driver);
 
 MODULE_DESCRIPTION("STMP3XXX RTC Watchdog Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
-- 
2.1.4

