Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23432 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab3D2JQw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 05:16:52 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 5/5] watchdog: sp805_wdt: use devm_clk_get()
Date: Mon, 29 Apr 2013 18:16:49 +0900
Message-id: <000601ce44ba$47b62bd0$d7228370$@samsung.com>
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


