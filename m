Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:58630 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756889AbbDVLMD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Apr 2015 07:12:03 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv7 7/8] watchdog: omap_wdt: Fix memory leak on probe fail
Date: Wed, 22 Apr 2015 14:11:41 +0300
Message-Id: <1429701102-22320-8-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Structures allocated on the beginning of the probe function must be
freed in case of failure.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/omap_wdt.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1e6be9e..bbaf39a 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -226,8 +226,10 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	/* reserve static register mappings */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdev->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(wdev->base))
-		return PTR_ERR(wdev->base);
+	if (IS_ERR(wdev->base)) {
+		ret = PTR_ERR(wdev->base);
+		goto err_ioremap;
+	}
 
 	omap_wdt->info	      = &omap_wdt_info;
 	omap_wdt->ops	      = &omap_wdt_ops;
@@ -258,10 +260,8 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	omap_wdt_disable(wdev);
 
 	ret = watchdog_register_device(omap_wdt);
-	if (ret) {
-		pm_runtime_disable(wdev->dev);
-		return ret;
-	}
+	if (ret)
+		goto err_register_device;
 
 	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
@@ -270,6 +270,14 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(wdev->dev);
 
 	return 0;
+
+err_register_device:
+	pm_runtime_disable(wdev->dev);
+err_ioremap:
+	kfree(wdev);
+	kfree(omap_wdt);
+
+	return ret;
 }
 
 static void omap_wdt_shutdown(struct platform_device *pdev)
-- 
2.1.0

