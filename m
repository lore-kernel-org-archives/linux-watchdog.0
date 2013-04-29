Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:24915 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab3D2J0O (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 05:26:14 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH RESEND 1/2] watchdog: s3c2410_wdt: use dev_err()/dev_info()
 instead of pr_err()/pr_info()
Date: Mon, 29 Apr 2013 18:26:12 +0900
Message-id: <000701ce44bb$96f4ecd0$c4dec670$@samsung.com>
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
index ee03135..c9f480d 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -349,7 +349,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 	ret = s3c2410wdt_cpufreq_register();
 	if (ret < 0) {
-		pr_err("failed to register cpufreq\n");
+		dev_err(dev, "failed to register cpufreq\n");
 		goto err_clk;
 	}
 
@@ -464,7 +464,7 @@ static int s3c2410wdt_resume(struct platform_device *dev)
 	writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
 	writel(wtcon_save, wdt_base + S3C2410_WTCON);
 
-	pr_info("watchdog %sabled\n",
+	dev_info(&dev->dev, "watchdog %sabled\n",
 		(wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
 
 	return 0;
-- 
1.7.2.5


