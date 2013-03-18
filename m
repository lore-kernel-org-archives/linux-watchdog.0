Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18660 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3CRHhY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Mar 2013 03:37:24 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJU00LRIIHU2670@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 18 Mar 2013 16:37:23 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
In-reply-to: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
Subject: [PATCH 7/7] watchdog: ts72xx_wdt: use devm_*() functions
Date: Mon, 18 Mar 2013 16:37:23 +0900
Message-id: <01b301ce23ab$6df18e50$49d4aaf0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/ts72xx_wdt.c |   64 +++++++----------------------------------
 1 files changed, 11 insertions(+), 53 deletions(-)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index b8a9245..b19ca75 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -396,7 +396,7 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	struct resource *r1, *r2;
 	int error = 0;
 
-	wdt = kzalloc(sizeof(struct ts72xx_wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_wdt), GFP_KERNEL);
 	if (!wdt) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
 		return -ENOMEM;
@@ -405,44 +405,22 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	r1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r1) {
 		dev_err(&pdev->dev, "failed to get memory resource\n");
-		error = -ENODEV;
-		goto fail;
-	}
-
-	r1 = request_mem_region(r1->start, resource_size(r1), pdev->name);
-	if (!r1) {
-		dev_err(&pdev->dev, "cannot request memory region\n");
-		error = -EBUSY;
-		goto fail;
+		return -ENODEV;
 	}
 
-	wdt->control_reg = ioremap(r1->start, resource_size(r1));
-	if (!wdt->control_reg) {
-		dev_err(&pdev->dev, "failed to map memory\n");
-		error = -ENODEV;
-		goto fail_free_control;
-	}
+	wdt->control_reg = devm_ioremap_resource(&pdev->dev, r1);
+	if (IS_ERR(wdt->control_reg))
+		return PTR_ERR(wdt->control_reg);
 
 	r2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!r2) {
 		dev_err(&pdev->dev, "failed to get memory resource\n");
-		error = -ENODEV;
-		goto fail_unmap_control;
+		return -ENODEV;
 	}
 
-	r2 = request_mem_region(r2->start, resource_size(r2), pdev->name);
-	if (!r2) {
-		dev_err(&pdev->dev, "cannot request memory region\n");
-		error = -EBUSY;
-		goto fail_unmap_control;
-	}
-
-	wdt->feed_reg = ioremap(r2->start, resource_size(r2));
-	if (!wdt->feed_reg) {
-		dev_err(&pdev->dev, "failed to map memory\n");
-		error = -ENODEV;
-		goto fail_free_feed;
-	}
+	wdt->feed_reg = devm_ioremap_resource(&pdev->dev, r2);
+	if (IS_ERR(wdt->feed_reg))
+		return PTR_ERR(wdt->feed_reg);
 
 	platform_set_drvdata(pdev, wdt);
 	ts72xx_wdt_pdev = pdev;
@@ -455,45 +433,25 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	error = misc_register(&ts72xx_wdt_miscdev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register miscdev\n");
-		goto fail_unmap_feed;
+		goto fail;
 	}
 
 	dev_info(&pdev->dev, "TS-72xx Watchdog driver\n");
 
 	return 0;
 
-fail_unmap_feed:
-	platform_set_drvdata(pdev, NULL);
-	iounmap(wdt->feed_reg);
-fail_free_feed:
-	release_mem_region(r2->start, resource_size(r2));
-fail_unmap_control:
-	iounmap(wdt->control_reg);
-fail_free_control:
-	release_mem_region(r1->start, resource_size(r1));
 fail:
-	kfree(wdt);
+	platform_set_drvdata(pdev, NULL);
 	return error;
 }
 
 static int ts72xx_wdt_remove(struct platform_device *pdev)
 {
-	struct ts72xx_wdt *wdt = platform_get_drvdata(pdev);
-	struct resource *res;
 	int error;
 
 	error = misc_deregister(&ts72xx_wdt_miscdev);
 	platform_set_drvdata(pdev, NULL);
 
-	iounmap(wdt->feed_reg);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	release_mem_region(res->start, resource_size(res));
-
-	iounmap(wdt->control_reg);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
-	kfree(wdt);
 	return error;
 }
 
-- 
1.7.2.5


