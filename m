Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [213.199.154.187] ([213.199.154.187]:4295 "EHLO
	db8outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751223AbaAMMBS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Jan 2014 07:01:18 -0500
From: Anson Huang <b20788@freescale.com>
To: <wim@iguana.be>, <shawn.guo@linaro.org>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog: imx2_wdt: disable watchdog timer during low power mode
Date: Mon, 13 Jan 2014 19:58:34 +0800
Message-ID: <1389614314-8987-1-git-send-email-b20788@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We should set watchdog timer to be disabled in low power mode,
as there is no service running in background, otherwise, system
will reset unexpected.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/watchdog/imx2_wdt.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index b4786bc..dd51d95 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -2,6 +2,7 @@
  * Watchdog driver for IMX2 and later processors
  *
  *  Copyright (C) 2010 Wolfram Sang, Pengutronix e.K. <w.sang@pengutronix.de>
+ *  Copyright (C) 2014 Freescale Semiconductor, Inc.
  *
  * some parts adapted by similar drivers from Darius Augulis and Vladimir
  * Zapolskiy, additional improvements by Wim Van Sebroeck.
@@ -40,6 +41,7 @@
 #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
 #define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
 #define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
+#define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog timer Suspend */
 
 #define IMX2_WDT_WSR		0x02		/* Service Register */
 #define IMX2_WDT_SEQ1		0x5555		/* -> service sequence 1 */
@@ -87,6 +89,8 @@ static inline void imx2_wdt_setup(void)
 {
 	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
 
+	/* Suspend timer in low power mode, write once-only */
+	val |= IMX2_WDT_WCR_WDZST;
 	/* Strip the old watchdog Time-Out value */
 	val &= ~IMX2_WDT_WCR_WT;
 	/* Generate reset if WDOG times out */
-- 
1.7.9.5


