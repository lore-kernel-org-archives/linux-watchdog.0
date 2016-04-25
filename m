Return-path: <knpo@ieee.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
 Linux Watchdog <linux-watchdog@vger.kernel.org>
From: Knud Poulsen <knpo@ieee.org>
Subject: [PATCH] watchdog: f71808e_wdt: Fix typo
Message-ID: <571E3917.5030704@ieee.org>
Date: Mon, 25 Apr 2016 17:34:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Spelling/ typo

Signed-off-by: Knud Poulsen <knpo@ieee.org>
---
 drivers/watchdog/f71808e_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 016bd93..f6d7add 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -38,7 +38,7 @@

 #define SIO_F71808FG_LD_WDT	0x07	/* Watchdog timer logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
-#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
+#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */

 #define SIO_REG_LDSEL		0x07	/* Logical device select */
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
-- 
2.5.5
