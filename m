Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16277 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CFJCK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Mar 2013 04:02:10 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ80057LEFLLGK0@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Wed, 06 Mar 2013 18:02:09 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <00a801ce1a49$247141a0$6d53c4e0$%han@samsung.com>
In-reply-to: <00a801ce1a49$247141a0$6d53c4e0$%han@samsung.com>
Subject: [PATCH 3/5] watchdog: pnx4008_wdt: use devm_clk_get()
Date: Wed, 06 Mar 2013 18:02:09 +0900
Message-id: <00aa01ce1a49$488343e0$d989cba0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_clk_get() to make cleanup paths more simple.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/pnx4008_wdt.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index a3684a3..b30bd43 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -159,13 +159,13 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt_base))
 		return PTR_ERR(wdt_base);
 
-	wdt_clk = clk_get(&pdev->dev, NULL);
+	wdt_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
 
 	ret = clk_enable(wdt_clk);
 	if (ret)
-		goto out;
+		return ret;
 
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
@@ -186,8 +186,6 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 
 disable_clk:
 	clk_disable(wdt_clk);
-out:
-	clk_put(wdt_clk);
 	return ret;
 }
 
@@ -196,7 +194,6 @@ static int pnx4008_wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&pnx4008_wdd);
 
 	clk_disable(wdt_clk);
-	clk_put(wdt_clk);
 
 	return 0;
 }
-- 
1.7.2.5


