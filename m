Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway32.websitewelcome.com ([192.185.145.187]:23047 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751970AbdKCXD3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Nov 2017 19:03:29 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 59AB23415A0
        for <linux-watchdog@vger.kernel.org>; Fri,  3 Nov 2017 18:03:28 -0500 (CDT)
Date: Fri, 3 Nov 2017 18:03:27 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: watchdog_dev: mark expected switch fall-through
Message-ID: <20171103230327.GA4635@embeddedor.com>
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
 drivers/watchdog/watchdog_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 1e971a5..a79ad5b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -720,7 +720,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		err = watchdog_ping(wdd);
 		if (err < 0)
 			break;
-		/* Fall */
+		/* fall through */
 	case WDIOC_GETTIMEOUT:
 		/* timeout == 0 means that we don't know the timeout */
 		if (wdd->timeout == 0) {
-- 
2.7.4

