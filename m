Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52592 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755218AbbDTNwQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Apr 2015 09:52:16 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 6/7] watchdog: pnx4008_wdt: fix broken email address
Date: Mon, 20 Apr 2015 15:51:43 +0200
Message-Id: <1429537917-7433-6-git-send-email-wsa@the-dreams.de>
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

 drivers/watchdog/pnx4008_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 55e22015010306..b9c6049c3e7860 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -216,7 +216,7 @@ static struct platform_driver platform_wdt_driver = {
 module_platform_driver(platform_wdt_driver);
 
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("PNX4008 Watchdog Driver");
 
 module_param(heartbeat, uint, 0);
-- 
2.1.4

