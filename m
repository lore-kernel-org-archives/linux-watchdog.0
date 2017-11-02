Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway32.websitewelcome.com ([192.185.145.189]:19082 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932547AbdKBTtx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Nov 2017 15:49:53 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 2500723348A
        for <linux-watchdog@vger.kernel.org>; Thu,  2 Nov 2017 14:25:11 -0500 (CDT)
Date: Thu, 2 Nov 2017 14:25:09 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: alim1535_wdt: mark expected switch fall-through
Message-ID: <20171102192509.GA19908@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case I replaced "Fall" with a proper
"fall through" comment, which is what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/watchdog/alim1535_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/alim1535_wdt.c b/drivers/watchdog/alim1535_wdt.c
index 3a17fbd..60f0c2e 100644
--- a/drivers/watchdog/alim1535_wdt.c
+++ b/drivers/watchdog/alim1535_wdt.c
@@ -223,8 +223,8 @@ static long ali_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (ali_settimer(new_timeout))
 			return -EINVAL;
 		ali_keepalive();
-		/* Fall */
 	}
+		/* fall through */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout, p);
 	default:
-- 
2.7.4

