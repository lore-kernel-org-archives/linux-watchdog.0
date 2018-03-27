Return-Path: <gustavo@embeddedor.com>
Return-path: <gustavo@embeddedor.com>
Date: Tue, 27 Mar 2018 14:33:49 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] watchdog: wafer5823wdt: Mark expected switch fall-through
Message-ID: <20180327193349.GA2547@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case I replaced "Fall" with a proper
"Fall through" comment, which is what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/watchdog/wafer5823wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/wafer5823wdt.c b/drivers/watchdog/wafer5823wdt.c
index db0da7e..93c5b61 100644
--- a/drivers/watchdog/wafer5823wdt.c
+++ b/drivers/watchdog/wafer5823wdt.c
@@ -178,7 +178,7 @@ static long wafwdt_ioctl(struct file *file, unsigned int cmd,
 		timeout = new_timeout;
 		wafwdt_stop();
 		wafwdt_start();
-		/* Fall */
+		/* Fall through */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout, p);
 
-- 
2.7.4
