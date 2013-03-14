Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22356 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab3CNBb0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Mar 2013 21:31:26 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJM0006HMW6PAB0@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 14 Mar 2013 10:31:25 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <005e01ce2053$7e483980$7ad8ac80$%han@samsung.com>
In-reply-to: <005e01ce2053$7e483980$7ad8ac80$%han@samsung.com>
Subject: [PATCH 2/2] watchdog: s3c2410_wdt: convert s3c2410wdt to dev_pm_ops
Date: Thu, 14 Mar 2013 10:31:21 +0900
Message-id: <005f01ce2053$a23cefc0$e6b6cf40$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of using legacy suspend/resume methods, using newer
dev_pm_ops structure allows better control over power management.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index c681353..803e77d 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -440,12 +440,12 @@ static void s3c2410wdt_shutdown(struct platform_device *dev)
 	s3c2410wdt_stop(&s3c2410_wdd);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
 static unsigned long wtcon_save;
 static unsigned long wtdat_save;
 
-static int s3c2410wdt_suspend(struct platform_device *dev, pm_message_t state)
+static int s3c2410wdt_suspend(struct device *dev)
 {
 	/* Save watchdog state, and turn it off. */
 	wtcon_save = readl(wdt_base + S3C2410_WTCON);
@@ -457,7 +457,7 @@ static int s3c2410wdt_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int s3c2410wdt_resume(struct platform_device *dev)
+static int s3c2410wdt_resume(struct device *dev)
 {
 	/* Restore watchdog state. */
 
@@ -465,16 +465,15 @@ static int s3c2410wdt_resume(struct platform_device *dev)
 	writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
 	writel(wtcon_save, wdt_base + S3C2410_WTCON);
 
-	dev_info(&dev->dev, "watchdog %sabled\n",
+	dev_info(dev, "watchdog %sabled\n",
 		(wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
 
 	return 0;
 }
+#endif
 
-#else
-#define s3c2410wdt_suspend NULL
-#define s3c2410wdt_resume  NULL
-#endif /* CONFIG_PM */
+static SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops, s3c2410wdt_suspend,
+			s3c2410wdt_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id s3c2410_wdt_match[] = {
@@ -488,11 +487,10 @@ static struct platform_driver s3c2410wdt_driver = {
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
 	.shutdown	= s3c2410wdt_shutdown,
-	.suspend	= s3c2410wdt_suspend,
-	.resume		= s3c2410wdt_resume,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c2410-wdt",
+		.pm	= &s3c2410wdt_pm_ops,
 		.of_match_table	= of_match_ptr(s3c2410_wdt_match),
 	},
 };
-- 
1.7.2.5


