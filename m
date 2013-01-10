Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9077 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758024Ab3AJCGe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Jan 2013 21:06:34 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MGE00KN40IJOGD0@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 10 Jan 2013 11:06:33 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MGE006DJ0IXXN10@mmp1.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 10 Jan 2013 11:06:33 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroec' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: 
In-reply-to: 
Subject: [PATCH v2] watchdog: s3c2410_wdt: Use devm_* functions
Date: Thu, 10 Jan 2013 11:06:33 +0900
Message-id: <007701cdeed7$1cece940$56c6bbc0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_* functions to make cleanup paths more simple.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Changes since v1:
- modified the commit message

 drivers/watchdog/s3c2410_wdt.c |   42 ++++++++-------------------------------
 1 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 27bcd4e..6419c61 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -309,7 +309,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	unsigned int wtcon;
 	int started = 0;
 	int ret;
-	int size;
 
 	DBG("%s: probe=%p\n", __func__, pdev);
 
@@ -330,28 +329,20 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	}
 
 	/* get the memory region for the watchdog timer */
-
-	size = resource_size(wdt_mem);
-	if (!request_mem_region(wdt_mem->start, size, pdev->name)) {
-		dev_err(dev, "failed to get memory region\n");
-		ret = -EBUSY;
-		goto err;
-	}
-
-	wdt_base = ioremap(wdt_mem->start, size);
+	wdt_base = devm_request_and_ioremap(dev, wdt_mem);
 	if (wdt_base == NULL) {
-		dev_err(dev, "failed to ioremap() region\n");
-		ret = -EINVAL;
-		goto err_req;
+		dev_err(dev, "failed to devm_request_and_ioremap() region\n");
+		ret = -ENOMEM;
+		goto err;
 	}
 
 	DBG("probe: mapped wdt_base=%p\n", wdt_base);
 
-	wdt_clock = clk_get(&pdev->dev, "watchdog");
+	wdt_clock = devm_clk_get(dev, "watchdog");
 	if (IS_ERR(wdt_clock)) {
 		dev_err(dev, "failed to find watchdog clock source\n");
 		ret = PTR_ERR(wdt_clock);
-		goto err_map;
+		goto err;
 	}
 
 	clk_prepare_enable(wdt_clock);
@@ -378,7 +369,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 							"cannot start\n");
 	}
 
-	ret = request_irq(wdt_irq->start, s3c2410wdt_irq, 0, pdev->name, pdev);
+	ret = devm_request_irq(dev, wdt_irq->start, s3c2410wdt_irq, 0,
+				pdev->name, pdev);
 	if (ret != 0) {
 		dev_err(dev, "failed to install irq (%d)\n", ret);
 		goto err_cpufreq;
@@ -389,7 +381,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	ret = watchdog_register_device(&s3c2410_wdd);
 	if (ret) {
 		dev_err(dev, "cannot register watchdog (%d)\n", ret);
-		goto err_irq;
+		goto err_cpufreq;
 	}
 
 	if (tmr_atboot && started == 0) {
@@ -414,23 +406,13 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 	return 0;
 
- err_irq:
-	free_irq(wdt_irq->start, pdev);
-
  err_cpufreq:
 	s3c2410wdt_cpufreq_deregister();
 
  err_clk:
 	clk_disable_unprepare(wdt_clock);
-	clk_put(wdt_clock);
 	wdt_clock = NULL;
 
- err_map:
-	iounmap(wdt_base);
-
- err_req:
-	release_mem_region(wdt_mem->start, size);
-
  err:
 	wdt_irq = NULL;
 	wdt_mem = NULL;
@@ -441,17 +423,11 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 {
 	watchdog_unregister_device(&s3c2410_wdd);
 
-	free_irq(wdt_irq->start, dev);
-
 	s3c2410wdt_cpufreq_deregister();
 
 	clk_disable_unprepare(wdt_clock);
-	clk_put(wdt_clock);
 	wdt_clock = NULL;
 
-	iounmap(wdt_base);
-
-	release_mem_region(wdt_mem->start, resource_size(wdt_mem));
 	wdt_irq = NULL;
 	wdt_mem = NULL;
 	return 0;
-- 
1.7.2.5


