Return-path: <vilhelm.gray@gmail.com>
Date: Wed, 11 May 2016 09:05:51 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: ebc-c384_wdt: Simplify ebc_c384_wdt_start timeout
 computation
Message-ID: <20160511130551.GA16032@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

The ebc_c384_wdt_set_timeout function already rounds up timeout values
greater than 255 to a multiple of 60, so there is no need to round again
in the ebc_c384_wdt_start function; a timeout value greater than 255 in
ebc_c384_wdt_start will divide cleanly by 60.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/watchdog/ebc-c384_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
index 77fda0b..948e687 100644
--- a/drivers/watchdog/ebc-c384_wdt.c
+++ b/drivers/watchdog/ebc-c384_wdt.c
@@ -51,7 +51,7 @@ static int ebc_c384_wdt_start(struct watchdog_device *wdev)
 
 	/* resolution is in minutes for timeouts greater than 255 seconds */
 	if (t > 255)
-		t = DIV_ROUND_UP(t, 60);
+		t /= 60;
 
 	outb(t, PET_ADDR);
 
-- 
2.7.3
