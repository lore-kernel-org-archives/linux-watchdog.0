Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:19374
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756568Ab1ISSV2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Sep 2011 14:21:28 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <linux-watchdog@vger.kernel.org>
CC: <kernel@pengutronix.de>, <wim@iguana.be>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] watchdog: imx2_wdt: Disable watchdog during low-power modes
Date: Mon, 19 Sep 2011 15:24:00 -0300
Message-ID: <1316456640-32650-2-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1316456640-32650-1-git-send-email-fabio.estevam@freescale.com>
References: <1316456640-32650-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Activate WDZST so that the watchdog timer does not count during low power modes.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/watchdog/imx2_wdt.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 19df82d..e1a9abb 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -41,6 +41,7 @@
 #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
 #define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
 #define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
+#define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog Low Power */
 
 #define IMX2_WDT_WSR		0x02		/* Service Register */
 #define IMX2_WDT_SEQ1		0x5555		/* -> service sequence 1 */
@@ -93,6 +94,9 @@ static inline void imx2_wdt_setup(void)
 	/* Set the watchdog's Time-Out value */
 	val |= WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
 
+	/* Disable watchdog suring low power modes */
+	val |= IMX2_WDT_WCR_WDZST;
+
 	/* enable the watchdog */
 	val |= IMX2_WDT_WCR_WDE;
 	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
-- 
1.6.0.4


