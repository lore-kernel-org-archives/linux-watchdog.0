Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18393 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3CRHgW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Mar 2013 03:36:22 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJU00K9HIGCQB70@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 18 Mar 2013 16:36:21 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
In-reply-to: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
Subject: [PATCH 4/7] watchdog: nuc900_wdt: use devm_*() functions
Date: Mon, 18 Mar 2013 16:36:21 +0900
Message-id: <01b001ce23ab$49100710$db301530$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/nuc900_wdt.c |   45 ++++++++--------------------------------
 1 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index 04c45a1..89e8991 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -246,7 +246,8 @@ static int nuc900wdt_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
-	nuc900_wdt = kzalloc(sizeof(struct nuc900_wdt), GFP_KERNEL);
+	nuc900_wdt = devm_kzalloc(&pdev->dev, sizeof(struct nuc900_wdt),
+				GFP_KERNEL);
 	if (!nuc900_wdt)
 		return -ENOMEM;
 
@@ -257,30 +258,18 @@ static int nuc900wdt_probe(struct platform_device *pdev)
 	nuc900_wdt->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (nuc900_wdt->res == NULL) {
 		dev_err(&pdev->dev, "no memory resource specified\n");
-		ret = -ENOENT;
-		goto err_get;
+		return -ENOENT;
 	}
 
-	if (!request_mem_region(nuc900_wdt->res->start,
-				resource_size(nuc900_wdt->res), pdev->name)) {
-		dev_err(&pdev->dev, "failed to get memory region\n");
-		ret = -ENOENT;
-		goto err_get;
-	}
-
-	nuc900_wdt->wdt_base = ioremap(nuc900_wdt->res->start,
-					resource_size(nuc900_wdt->res));
-	if (nuc900_wdt->wdt_base == NULL) {
-		dev_err(&pdev->dev, "failed to ioremap() region\n");
-		ret = -EINVAL;
-		goto err_req;
-	}
+	nuc900_wdt->wdt_base = devm_ioremap_resource(&pdev->dev,
+						nuc900_wdt->res);
+	if (IS_ERR(nuc900_wdt->wdt_base))
+		return PTR_ERR(nuc900_wdt->wdt_base);
 
-	nuc900_wdt->wdt_clock = clk_get(&pdev->dev, NULL);
+	nuc900_wdt->wdt_clock = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(nuc900_wdt->wdt_clock)) {
 		dev_err(&pdev->dev, "failed to find watchdog clock source\n");
-		ret = PTR_ERR(nuc900_wdt->wdt_clock);
-		goto err_map;
+		return PTR_ERR(nuc900_wdt->wdt_clock);
 	}
 
 	clk_enable(nuc900_wdt->wdt_clock);
@@ -298,14 +287,6 @@ static int nuc900wdt_probe(struct platform_device *pdev)
 
 err_clk:
 	clk_disable(nuc900_wdt->wdt_clock);
-	clk_put(nuc900_wdt->wdt_clock);
-err_map:
-	iounmap(nuc900_wdt->wdt_base);
-err_req:
-	release_mem_region(nuc900_wdt->res->start,
-					resource_size(nuc900_wdt->res));
-err_get:
-	kfree(nuc900_wdt);
 	return ret;
 }
 
@@ -314,14 +295,6 @@ static int nuc900wdt_remove(struct platform_device *pdev)
 	misc_deregister(&nuc900wdt_miscdev);
 
 	clk_disable(nuc900_wdt->wdt_clock);
-	clk_put(nuc900_wdt->wdt_clock);
-
-	iounmap(nuc900_wdt->wdt_base);
-
-	release_mem_region(nuc900_wdt->res->start,
-					resource_size(nuc900_wdt->res));
-
-	kfree(nuc900_wdt);
 
 	return 0;
 }
-- 
1.7.2.5


