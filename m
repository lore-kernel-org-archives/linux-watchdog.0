Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:38225 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933002AbcHaLw7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Aug 2016 07:52:59 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v5 09/10] watchdog: imx2_wdt: use preferred BIT macro instead of open coded values
Date: Wed, 31 Aug 2016 14:52:49 +0300
Message-ID: <1472644370-16982-10-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a nonfunctional change, declare register bit values with BIT()
helper macro.

The issues are reported by checkpatch:

  CHECK: Prefer using the BIT macro
  #40: FILE: drivers/watchdog/imx2_wdt.c:40:
  +#define IMX2_WDT_WCR_WDA	(1 << 5)	/* -> External Reset WDOG_B */

etc.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
New change in the series, practically this trivial change is
independent on the previous ones, but it's worth to have it
for a cleaner version of v5 10/10 change.

 drivers/watchdog/imx2_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 62f346bb4348..d17643eb7683 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -37,18 +37,18 @@
 
 #define IMX2_WDT_WCR		0x00		/* Control Register */
 #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
-#define IMX2_WDT_WCR_WDA	(1 << 5)	/* -> External Reset WDOG_B */
-#define IMX2_WDT_WCR_SRS	(1 << 4)	/* -> Software Reset Signal */
-#define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
-#define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
-#define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog timer Suspend */
+#define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
+#define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
+#define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
+#define IMX2_WDT_WCR_WDE	BIT(2)		/* -> Watchdog Enable */
+#define IMX2_WDT_WCR_WDZST	BIT(0)		/* -> Watchdog timer Suspend */
 
 #define IMX2_WDT_WSR		0x02		/* Service Register */
 #define IMX2_WDT_SEQ1		0x5555		/* -> service sequence 1 */
 #define IMX2_WDT_SEQ2		0xAAAA		/* -> service sequence 2 */
 
 #define IMX2_WDT_WRSR		0x04		/* Reset Status Register */
-#define IMX2_WDT_WRSR_TOUT	(1 << 1)	/* -> Reset due to Timeout */
+#define IMX2_WDT_WRSR_TOUT	BIT(1)		/* -> Reset due to Timeout */
 
 #define IMX2_WDT_WMCR		0x08		/* Misc Register */
 
-- 
2.8.1

