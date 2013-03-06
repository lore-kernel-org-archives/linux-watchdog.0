Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:9910 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CFJB1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Mar 2013 04:01:27 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ8002IZEDJJHN0@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Wed, 06 Mar 2013 18:01:09 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 1/5] watchdog: dw_wdt: use devm_clk_get()
Date: Wed, 06 Mar 2013 18:01:08 +0900
Message-id: <00a801ce1a49$247141a0$6d53c4e0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_clk_get() to make cleanup paths more simple.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/dw_wdt.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 2037669..2e70fd0 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -305,13 +305,13 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(dw_wdt.regs))
 		return PTR_ERR(dw_wdt.regs);
 
-	dw_wdt.clk = clk_get(&pdev->dev, NULL);
+	dw_wdt.clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dw_wdt.clk))
 		return PTR_ERR(dw_wdt.clk);
 
 	ret = clk_enable(dw_wdt.clk);
 	if (ret)
-		goto out_put_clk;
+		return ret;
 
 	spin_lock_init(&dw_wdt.lock);
 
@@ -327,8 +327,6 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 out_disable_clk:
 	clk_disable(dw_wdt.clk);
-out_put_clk:
-	clk_put(dw_wdt.clk);
 
 	return ret;
 }
@@ -338,7 +336,6 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
 	misc_deregister(&dw_wdt_miscdev);
 
 	clk_disable(dw_wdt.clk);
-	clk_put(dw_wdt.clk);
 
 	return 0;
 }
-- 
1.7.2.5


