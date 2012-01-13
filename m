Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18895 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab2AMFNr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Jan 2012 00:13:47 -0500
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Ben Dooks <ben-linux@fluff.org>, kyungmin.park@samsung.com,
	myungjoo.ham@gmail.com
Subject: [PATCH] watchdog: fix error in probe() of s3c2410_wdt (reset at
 booting)
Date: Fri, 13 Jan 2012 14:14:23 +0900
Message-id: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Probe function of s3c2410 watchdog calls request_irq before initializing
required value (wdt_count). This incurs resetting watchdog counter value
and watchdog-reboot during booting up.

This patch addresses such an issue by calling request_irq later.

Error handling in probe function and calling oder in remove function are
also revised accordingly.

Reported-by: Chanwoo Park <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index a79e384..07bd768 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -342,22 +342,17 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 		goto err_map;
 	}
 
-	ret = request_irq(wdt_irq->start, s3c2410wdt_irq, 0, pdev->name, pdev);
-	if (ret != 0) {
-		dev_err(dev, "failed to install irq (%d)\n", ret);
-		goto err_map;
-	}
-
 	wdt_clock = clk_get(&pdev->dev, "watchdog");
 	if (IS_ERR(wdt_clock)) {
 		dev_err(dev, "failed to find watchdog clock source\n");
 		ret = PTR_ERR(wdt_clock);
-		goto err_irq;
+		goto err_map;
 	}
 
 	clk_enable(wdt_clock);
 
-	if (s3c2410wdt_cpufreq_register() < 0) {
+	ret = s3c2410wdt_cpufreq_register();
+	if (ret < 0) {
 		printk(KERN_ERR PFX "failed to register cpufreq\n");
 		goto err_clk;
 	}
@@ -395,6 +390,12 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 		s3c2410wdt_stop(&s3c2410_wdd);
 	}
 
+	ret = request_irq(wdt_irq->start, s3c2410wdt_irq, 0, pdev->name, pdev);
+	if (ret != 0) {
+		dev_err(dev, "failed to install irq (%d)\n", ret);
+		goto err_reg;
+	}
+
 	/* print out a statement of readiness */
 
 	wtcon = readl(wdt_base + S3C2410_WTCON);
@@ -406,6 +407,9 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 
 	return 0;
 
+ err_reg:
+	watchdog_unregister_device(&s3c2410_wdd);
+
  err_cpufreq:
 	s3c2410wdt_cpufreq_deregister();
 
@@ -413,9 +417,6 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 	clk_disable(wdt_clock);
 	clk_put(wdt_clock);
 
- err_irq:
-	free_irq(wdt_irq->start, pdev);
-
  err_map:
 	iounmap(wdt_base);
 
@@ -428,6 +429,9 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 
 static int __devexit s3c2410wdt_remove(struct platform_device *dev)
 {
+	free_irq(wdt_irq->start, dev);
+	wdt_irq = NULL;
+
 	watchdog_unregister_device(&s3c2410_wdd);
 
 	s3c2410wdt_cpufreq_deregister();
@@ -436,9 +440,6 @@ static int __devexit s3c2410wdt_remove(struct platform_device *dev)
 	clk_put(wdt_clock);
 	wdt_clock = NULL;
 
-	free_irq(wdt_irq->start, dev);
-	wdt_irq = NULL;
-
 	iounmap(wdt_base);
 
 	release_mem_region(wdt_mem->start, resource_size(wdt_mem));
-- 
1.7.4.1

