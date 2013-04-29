Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62425 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab3D2JQE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 05:16:04 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 2/5] watchdog: imx2_wdt: use devm_clk_get()
Date: Mon, 29 Apr 2013 18:15:53 +0900
Message-id: <000301ce44ba$266397b0$732ac710$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_clk_get() to make cleanup paths more simple.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/imx2_wdt.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index ff90882..0c2b075 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -266,7 +266,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(imx2_wdt.base))
 		return PTR_ERR(imx2_wdt.base);
 
-	imx2_wdt.clk = clk_get(&pdev->dev, NULL);
+	imx2_wdt.clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(imx2_wdt.clk)) {
 		dev_err(&pdev->dev, "can't get Watchdog clock\n");
 		return PTR_ERR(imx2_wdt.clk);
@@ -291,7 +291,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 
 fail:
 	imx2_wdt_miscdev.parent = NULL;
-	clk_put(imx2_wdt.clk);
 	return ret;
 }
 
@@ -304,8 +303,7 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
 
 		dev_crit(imx2_wdt_miscdev.parent,
 			"Device removed: Expect reboot!\n");
-	} else
-		clk_put(imx2_wdt.clk);
+	}
 
 	imx2_wdt_miscdev.parent = NULL;
 	return 0;
-- 
1.7.2.5


