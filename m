Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35647 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CFJCw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Mar 2013 04:02:52 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ8006DTEGPN3V0@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Wed, 06 Mar 2013 18:02:49 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <00a801ce1a49$247141a0$6d53c4e0$%han@samsung.com>
In-reply-to: <00a801ce1a49$247141a0$6d53c4e0$%han@samsung.com>
Subject: [PATCH 4/5] watchdog: shwdt: use devm_clk_get()
Date: Wed, 06 Mar 2013 18:02:48 +0900
Message-id: <00ab01ce1a49$5ffe5000$1ffaf000$%han@samsung.com>
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
index 6a89e40..e5fe555 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -240,7 +240,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 
 	wdt->dev = &pdev->dev;
 
-	wdt->clk = clk_get(&pdev->dev, NULL);
+	wdt->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
 		/*
 		 * Clock framework support is optional, continue on
@@ -250,10 +250,8 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	}
 
 	wdt->base = devm_request_and_ioremap(wdt->dev, res);
-	if (unlikely(!wdt->base)) {
-		rc = -EADDRNOTAVAIL;
-		goto err;
-	}
+	if (unlikely(!wdt->base))
+		return -EADDRNOTAVAIL;
 
 	watchdog_set_nowayout(&sh_wdt_dev, nowayout);
 	watchdog_set_drvdata(&sh_wdt_dev, wdt);
@@ -276,7 +274,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	rc = watchdog_register_device(&sh_wdt_dev);
 	if (unlikely(rc)) {
 		dev_err(&pdev->dev, "Can't register watchdog (err=%d)\n", rc);
-		goto err;
+		return rc;
 	}
 
 	init_timer(&wdt->timer);
@@ -291,11 +289,6 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
-
-err:
-	clk_put(wdt->clk);
-
-	return rc;
 }
 
 static int sh_wdt_remove(struct platform_device *pdev)
@@ -307,7 +300,6 @@ static int sh_wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&sh_wdt_dev);
 
 	pm_runtime_disable(&pdev->dev);
-	clk_put(wdt->clk);
 
 	return 0;
 }
-- 
1.7.2.5


