Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16516 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab3CFJDU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Mar 2013 04:03:20 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ80058NEGRLGK0@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Wed, 06 Mar 2013 18:03:19 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <00a801ce1a49$247141a0$6d53c4e0$%han@samsung.com>
In-reply-to: <00a801ce1a49$247141a0$6d53c4e0$%han@samsung.com>
Subject: [PATCH 5/5] watchdog: sp805_wdt: use devm_clk_get()
Date: Wed, 06 Mar 2013 18:03:19 +0900
Message-id: <00ac01ce1a49$72389a50$56a9cef0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_clk_get() to make cleanup paths more simple.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/sp805_wdt.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 8872642..58df98a 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -231,7 +231,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err;
 	}
 
-	wdt->clk = clk_get(&adev->dev, NULL);
+	wdt->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
 		dev_warn(&adev->dev, "Clock not found\n");
 		ret = PTR_ERR(wdt->clk);
@@ -251,15 +251,13 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret) {
 		dev_err(&adev->dev, "watchdog_register_device() failed: %d\n",
 				ret);
-		goto err_register;
+		goto err;
 	}
 	amba_set_drvdata(adev, wdt);
 
 	dev_info(&adev->dev, "registration successful\n");
 	return 0;
 
-err_register:
-	clk_put(wdt->clk);
 err:
 	dev_err(&adev->dev, "Probe Failed!!!\n");
 	return ret;
@@ -272,7 +270,6 @@ static int sp805_wdt_remove(struct amba_device *adev)
 	watchdog_unregister_device(&wdt->wdd);
 	amba_set_drvdata(adev, NULL);
 	watchdog_set_drvdata(&wdt->wdd, NULL);
-	clk_put(wdt->clk);
 
 	return 0;
 }
-- 
1.7.2.5


