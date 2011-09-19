Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:12963
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756430Ab1ISSVT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Sep 2011 14:21:19 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <linux-watchdog@vger.kernel.org>
CC: <kernel@pengutronix.de>, <wim@iguana.be>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] watchdog: imx2_wdt: Do not clear IMX2_WDT_WCR_WDE
Date: Mon, 19 Sep 2011 15:23:59 -0300
Message-ID: <1316456640-32650-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

i.MX reference manual states that software can only write "1" into the WDE bit.

Remove the line that sets 0 to this bit and while at it remove an unneeded extra 
write to register WCR.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/watchdog/imx2_wdt.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index b8ef2c6..19df82d 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -89,13 +89,10 @@ static inline void imx2_wdt_setup(void)
 	val &= ~IMX2_WDT_WCR_WT;
 	/* Generate reset if WDOG times out */
 	val &= ~IMX2_WDT_WCR_WRE;
-	/* Keep Watchdog Disabled */
-	val &= ~IMX2_WDT_WCR_WDE;
+
 	/* Set the watchdog's Time-Out value */
 	val |= WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
 
-	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
-
 	/* enable the watchdog */
 	val |= IMX2_WDT_WCR_WDE;
 	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
-- 
1.6.0.4


