Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62516 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835Ab3D2JQe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 05:16:34 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 4/5] watchdog: shwdt: use devm_clk_get()
Date: Mon, 29 Apr 2013 18:16:33 +0900
Message-id: <000501ce44ba$3df0f350$b9d2d9f0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_clk_get() to make cleanup paths more simple.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/shwdt.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 6185af2..ea2154b 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -241,7 +241,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 
 	wdt->dev = &pdev->dev;
 
-	wdt->clk = clk_get(&pdev->dev, NULL);
+	wdt->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
 		/*
 		 * Clock framework support is optional, continue on
@@ -251,10 +251,8 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	}
 
 	wdt->base = devm_ioremap_resource(wdt->dev, res);
-	if (IS_ERR(wdt->base)) {
-		rc = PTR_ERR(wdt->base);
-		goto err;
-	}
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
 
 	watchdog_set_nowayout(&sh_wdt_dev, nowayout);
 	watchdog_set_drvdata(&sh_wdt_dev, wdt);
@@ -277,7 +275,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	rc = watchdog_register_device(&sh_wdt_dev);
 	if (unlikely(rc)) {
 		dev_err(&pdev->dev, "Can't register watchdog (err=%d)\n", rc);
-		goto err;
+		return rc;
 	}
 
 	init_timer(&wdt->timer);
@@ -292,11 +290,6 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
-
-err:
-	clk_put(wdt->clk);
-
-	return rc;
 }
 
 static int sh_wdt_remove(struct platform_device *pdev)
@@ -308,7 +301,6 @@ static int sh_wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&sh_wdt_dev);
 
 	pm_runtime_disable(&pdev->dev);
-	clk_put(wdt->clk);
 
 	return 0;
 }
-- 
1.7.2.5


