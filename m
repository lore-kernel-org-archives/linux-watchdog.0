Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41140 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab3CDFRO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 00:17:14 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so2840674pbc.5
        for <linux-watchdog@vger.kernel.org>; Sun, 03 Mar 2013 21:17:14 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, thierry.reding@avionic-design.de,
	sachin.kamat@linaro.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/4] watchdog: ath79_wdt: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 10:36:42 +0530
Message-Id: <1362373604-26771-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
References: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/watchdog/ath79_wdt.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 8987990..d184c48 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -253,11 +253,9 @@ static int ath79_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	wdt_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!wdt_base) {
-		dev_err(&pdev->dev, "unable to remap memory region\n");
-		return -ENOMEM;
-	}
+	wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdt_base))
+		return PTR_ERR(wdt_base);
 
 	wdt_clk = devm_clk_get(&pdev->dev, "wdt");
 	if (IS_ERR(wdt_clk))
-- 
1.7.4.1

