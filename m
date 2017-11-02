Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway34.websitewelcome.com ([192.185.150.114]:30257 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934221AbdKBUJ3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Nov 2017 16:09:29 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 40BCF7B8321
        for <linux-watchdog@vger.kernel.org>; Thu,  2 Nov 2017 14:21:40 -0500 (CDT)
Date: Thu, 2 Nov 2017 14:21:36 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: advantechwdt: mark expected switch fall-through
Message-ID: <20171102192136.GA19474@embeddedor.com>
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
 drivers/watchdog/advantechwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index 7d7db0c..f619443 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -181,7 +181,7 @@ static long advwdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (advwdt_set_heartbeat(new_timeout))
 			return -EINVAL;
 		advwdt_ping();
-		/* Fall */
+		/* fall through */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout, p);
 	default:
-- 
2.7.4

