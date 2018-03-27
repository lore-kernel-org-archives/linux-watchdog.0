Return-Path: <gustavo@embeddedor.com>
Return-path: <gustavo@embeddedor.com>
Date: Tue, 27 Mar 2018 14:25:40 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] watchdog: sch311x_wdt: Mark expected switch fall-through
Message-ID: <20180327192540.GA2293@embeddedgus>
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
 drivers/watchdog/sch311x_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index 43d0cbb..814cdf5 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -299,7 +299,7 @@ static long sch311x_wdt_ioctl(struct file *file, unsigned int cmd,
 		if (sch311x_wdt_set_heartbeat(new_timeout))
 			return -EINVAL;
 		sch311x_wdt_keepalive();
-		/* Fall */
+		/* Fall through */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout, p);
 	default:
-- 
2.7.4
