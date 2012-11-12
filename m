Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:52733 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab2KLSrS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Nov 2012 13:47:18 -0500
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RESEND PATCH v3 6/6] watchdog: omap_wdt: eliminate goto
Date: Mon, 12 Nov 2012 20:47:05 +0200
Message-Id: <1352746025-1669-7-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1352746025-1669-1-git-send-email-aaro.koskinen@iki.fi>
References: <1352746025-1669-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Eliminate a goto to simplify the code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/omap_wdt.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index af1e72e..bee43a9 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -267,8 +267,10 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	__omap_wdt_disable(wdev);
 
 	ret = watchdog_register_device(omap_wdt);
-	if (ret)
-		goto err_misc;
+	if (ret) {
+		pm_runtime_disable(wdev->dev);
+		return ret;
+	}
 
 	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
 		__raw_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
@@ -277,11 +279,6 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(wdev->dev);
 
 	return 0;
-
-err_misc:
-	pm_runtime_disable(wdev->dev);
-
-	return ret;
 }
 
 static void omap_wdt_shutdown(struct platform_device *pdev)
-- 
1.7.2.5

