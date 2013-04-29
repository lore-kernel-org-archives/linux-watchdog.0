Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:23910 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab3D2Je6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 05:34:58 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 2/7] watchdog: bcm63xx_wdt: use devm_ioremap_nocache()
Date: Mon, 29 Apr 2013 18:34:57 +0900
Message-id: <000c01ce44bc$cfed7830$6fc86890$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_ioremap_nocache() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/bcm63xx_wdt.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index b2b80d4..a14a58d 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -249,7 +250,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	bcm63xx_wdt_device.regs = ioremap_nocache(r->start, resource_size(r));
+	bcm63xx_wdt_device.regs = devm_ioremap_nocache(&pdev->dev, r->start,
+							resource_size(r));
 	if (!bcm63xx_wdt_device.regs) {
 		dev_err(&pdev->dev, "failed to remap I/O resources\n");
 		return -ENXIO;
@@ -258,7 +260,7 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, NULL);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
-		goto unmap;
+		return ret;
 	}
 
 	if (bcm63xx_wdt_settimeout(wdt_time)) {
@@ -281,8 +283,6 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 
 unregister_timer:
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
-unmap:
-	iounmap(bcm63xx_wdt_device.regs);
 	return ret;
 }
 
@@ -293,7 +293,6 @@ static int bcm63xx_wdt_remove(struct platform_device *pdev)
 
 	misc_deregister(&bcm63xx_wdt_miscdev);
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
-	iounmap(bcm63xx_wdt_device.regs);
 	return 0;
 }
 
-- 
1.7.2.5


