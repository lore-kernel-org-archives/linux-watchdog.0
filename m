Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.144.80]:15921 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934221AbdKBUPa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Nov 2017 16:15:30 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 4FC8F60D45
        for <linux-watchdog@vger.kernel.org>; Thu,  2 Nov 2017 14:28:18 -0500 (CDT)
Date: Thu, 2 Nov 2017 14:28:17 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: f71808e_wdt: mark expected switch fall-throughs
Message-ID: <20171102192817.GA20042@embeddedor.com>
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
 drivers/watchdog/f71808e_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 8658dba..e0678c1 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -627,7 +627,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 
 		if (new_options & WDIOS_ENABLECARD)
 			return watchdog_start();
-
+		/* fall through */
 
 	case WDIOC_KEEPALIVE:
 		watchdog_keepalive();
@@ -641,7 +641,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 
 		watchdog_keepalive();
-		/* Fall */
+		/* fall through */
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(watchdog.timeout, uarg.i);
-- 
2.7.4

