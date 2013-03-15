Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:47956 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab3COJnu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Mar 2013 05:43:50 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJP00LML4BI8XU0@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Fri, 15 Mar 2013 18:43:47 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJP008734CVMZ40@mmp1.samsung.com> for
 linux-watchdog@vger.kernel.org; Fri, 15 Mar 2013 18:43:43 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 1/2] watchdog: mtx1-wdt: use devm_gpio_request_one()
Date: Fri, 15 Mar 2013 18:43:43 +0900
Message-id: <000001ce2161$94ebf8c0$bec3ea40$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_gpio_request_one() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/mtx-1_wdt.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 14dab6f..b434111 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -209,7 +209,7 @@ static int mtx1_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	mtx1_wdt_device.gpio = pdev->resource[0].start;
-	ret = gpio_request_one(mtx1_wdt_device.gpio,
+	ret = devm_gpio_request_one(&pdev->dev, mtx1_wdt_device.gpio,
 				GPIOF_OUT_INIT_HIGH, "mtx1-wdt");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request gpio");
@@ -241,7 +241,6 @@ static int mtx1_wdt_remove(struct platform_device *pdev)
 		wait_for_completion(&mtx1_wdt_device.stop);
 	}
 
-	gpio_free(mtx1_wdt_device.gpio);
 	misc_deregister(&mtx1_wdt_misc);
 	return 0;
 }
-- 
1.7.2.5


