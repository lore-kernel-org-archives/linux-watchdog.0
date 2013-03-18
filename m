Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26845 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3CRHgl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Mar 2013 03:36:41 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJU00KS9IH4VNT0@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 18 Mar 2013 16:36:40 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJU00D3UIH3EB70@mmp1.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 18 Mar 2013 16:36:39 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
In-reply-to: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
Subject: [PATCH 5/7] watchdog: rc32434_wdt: use devm_ioremap_nocache() functions
Date: Mon, 18 Mar 2013 16:36:39 +0900
Message-id: <01b101ce23ab$5401d8b0$fc058a10$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_ioremap_nocache() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/rc32434_wdt.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index f78bc00..9cf6bc7 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -32,6 +32,7 @@
 #include <linux/platform_device.h>	/* For platform_driver framework */
 #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
 #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
+#include <linux/io.h>			/* For devm_ioremap_nocache */
 
 #include <asm/mach-rc32434/integ.h>	/* For the Watchdog registers */
 
@@ -271,7 +272,7 @@ static int rc32434_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	wdt_reg = ioremap_nocache(r->start, resource_size(r));
+	wdt_reg = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
 	if (!wdt_reg) {
 		pr_err("failed to remap I/O resources\n");
 		return -ENXIO;
@@ -293,23 +294,18 @@ static int rc32434_wdt_probe(struct platform_device *pdev)
 	ret = misc_register(&rc32434_wdt_miscdev);
 	if (ret < 0) {
 		pr_err("failed to register watchdog device\n");
-		goto unmap;
+		return ret;
 	}
 
 	pr_info("Watchdog Timer version " VERSION ", timer margin: %d sec\n",
 		timeout);
 
 	return 0;
-
-unmap:
-	iounmap(wdt_reg);
-	return ret;
 }
 
 static int rc32434_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&rc32434_wdt_miscdev);
-	iounmap(wdt_reg);
 	return 0;
 }
 
-- 
1.7.2.5


