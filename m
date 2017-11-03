Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway32.websitewelcome.com ([192.185.145.187]:44632 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752329AbdKCXHZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Nov 2017 19:07:25 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id AC9FA413C8A
        for <linux-watchdog@vger.kernel.org>; Fri,  3 Nov 2017 18:07:24 -0500 (CDT)
Date: Fri, 3 Nov 2017 18:07:23 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] watchdog: wdt_pci: mark expected switch fall-through
Message-ID: <20171103230723.GA5105@embeddedor.com>
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
 drivers/watchdog/wdt_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index bc7addc..10e2cda0 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -430,7 +430,7 @@ static long wdtpci_ioctl(struct file *file, unsigned int cmd,
 		if (wdtpci_set_heartbeat(new_heartbeat))
 			return -EINVAL;
 		wdtpci_ping();
-		/* Fall */
+		/* fall through */
 	case WDIOC_GETTIMEOUT:
 		return put_user(heartbeat, p);
 	default:
-- 
2.7.4

