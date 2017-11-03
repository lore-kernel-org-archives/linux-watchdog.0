Return-Path: <garsilva@embeddedor.com>
Return-path: <garsilva@embeddedor.com>
Date: Fri, 3 Nov 2017 11:02:30 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] watchdog: pcwd_pci: mark expected switch fall-through
Message-ID: <20171103160230.GA9298@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103104737.Horde.jIupkyXRbKxDR--eHgm0-aF@gator4166.hostgator.com>
List-ID: <linux-watchdog@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case I replaced "Fall" with a proper
"fall through" comment, which is what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Place the "fall through" comment outside the unconditional code block.

 drivers/watchdog/pcwd_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index c0d07ee..1f78f09 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -545,8 +545,8 @@ static long pcipcwd_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 
 		pcipcwd_keepalive();
-		/* Fall */
 	}
+		/* fall through */
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(heartbeat, p);
-- 
2.7.4
