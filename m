Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20868 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab3D2JPe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 05:15:34 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 1/5] watchdog: dw_wdt: use devm_clk_get()
Date: Mon, 29 Apr 2013 18:15:26 +0900
Message-id: <000201ce44ba$160fc0a0$422f41e0$@samsung.com>
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


