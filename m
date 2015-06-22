Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36200 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbFVEQs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jun 2015 00:16:48 -0400
Received: by qgal13 with SMTP id l13so49220596qga.3
        for <linux-watchdog@vger.kernel.org>; Sun, 21 Jun 2015 21:16:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] watchdog: imx2_wdt: Check for clk_prepare_enable() error
Date: Mon, 22 Jun 2015 01:16:18 -0300
Message-Id: <1434946579-9674-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/watchdog/imx2_wdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 2acdd17..add1fa0 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -260,7 +260,9 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	wdog->max_timeout	= IMX2_WDT_MAX_TIME;
 	wdog->parent		= &pdev->dev;
 
-	clk_prepare_enable(wdev->clk);
+	ret = clk_prepare_enable(wdev->clk);
+	if (ret)
+		return ret;
 
 	regmap_read(wdev->regmap, IMX2_WDT_WRSR, &val);
 	wdog->bootstatus = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
@@ -365,8 +367,11 @@ static int imx2_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdog = dev_get_drvdata(dev);
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+	int ret;
 
-	clk_prepare_enable(wdev->clk);
+	ret = clk_prepare_enable(wdev->clk);
+	if (ret)
+		return ret;
 
 	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
 		/*
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
