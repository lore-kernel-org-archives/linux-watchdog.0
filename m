Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway22.websitewelcome.com ([192.185.47.100]:13722 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751705AbdKTRbY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Nov 2017 12:31:24 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 8DF531FEC7
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Nov 2017 11:06:46 -0600 (CST)
Date: Mon, 20 Nov 2017 11:06:45 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: eurotechwdt: mark expected switch fall-through
Message-ID: <20171120170645.GA17678@embeddedor.com>
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
 drivers/watchdog/eurotechwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index 38e9671..47f77a6 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -290,7 +290,7 @@ static long eurwdt_ioctl(struct file *file,
 		eurwdt_timeout = time;
 		eurwdt_set_timeout(time);
 		spin_unlock(&eurwdt_lock);
-		/* Fall */
+		/* fall through */
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(eurwdt_timeout, p);
-- 
2.7.4

