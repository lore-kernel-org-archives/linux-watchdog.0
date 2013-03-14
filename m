Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22042 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab3CNBaX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Mar 2013 21:30:23 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJM009W1MULXPB0@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 14 Mar 2013 10:30:22 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 1/2] watchdog: s3c2410_wdt: use dev_err()/dev_info() instead of
 pr_err()/pr_info()
Date: Thu, 14 Mar 2013 10:30:21 +0900
Message-id: <005e01ce2053$7e483980$7ad8ac80$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

dev_err()/dev_info() are more preferred than pr_err()/pr_info().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index c1a221c..c681353 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -350,7 +350,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 	ret = s3c2410wdt_cpufreq_register();
 	if (ret < 0) {
-		pr_err("failed to register cpufreq\n");
+		dev_err(dev, "failed to register cpufreq\n");
 		goto err_clk;
 	}
 
@@ -465,7 +465,7 @@ static int s3c2410wdt_resume(struct platform_device *dev)
 	writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
 	writel(wtcon_save, wdt_base + S3C2410_WTCON);
 
-	pr_info("watchdog %sabled\n",
+	dev_info(&dev->dev, "watchdog %sabled\n",
 		(wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
 
 	return 0;
-- 
1.7.2.5


