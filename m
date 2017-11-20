Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway33.websitewelcome.com ([192.185.145.33]:45659 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751872AbdKTRWY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Nov 2017 12:22:24 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 7E37D1853D9
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Nov 2017 11:22:23 -0600 (CST)
Date: Mon, 20 Nov 2017 11:22:21 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: ib700wdt: mark expected switch fall-through
Message-ID: <20171120172221.GA18165@embeddedor.com>
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
 drivers/watchdog/ib700wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index f2e4e1e..cc26228 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -218,7 +218,7 @@ static long ibwdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (ibwdt_set_heartbeat(new_margin))
 			return -EINVAL;
 		ibwdt_ping();
-		/* Fall */
+		/* fall through */
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout, p);
-- 
2.7.4

