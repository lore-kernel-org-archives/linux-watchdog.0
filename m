Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway36.websitewelcome.com ([50.116.127.2]:42696 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750707AbdKCPRm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Nov 2017 11:17:42 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id E9ED640E9EEFD
        for <linux-watchdog@vger.kernel.org>; Fri,  3 Nov 2017 09:53:42 -0500 (CDT)
Date: Fri, 3 Nov 2017 09:53:41 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: pcwd_usb: mark expected switch fall-through
Message-ID: <20171103145341.GA6518@embeddedor.com>
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
 drivers/watchdog/pcwd_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index b9e376c..47fe4c5 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -456,8 +456,8 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 
 		usb_pcwd_keepalive(usb_pcwd_device);
-		/* Fall */
 	}
+		/* fall through */
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(heartbeat, p);
-- 
2.7.4

