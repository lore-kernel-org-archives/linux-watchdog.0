Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43248 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab3CDFRL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 00:17:11 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so2854696pbc.25
        for <linux-watchdog@vger.kernel.org>; Sun, 03 Mar 2013 21:17:11 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, thierry.reding@avionic-design.de,
	sachin.kamat@linaro.org
Subject: [PATCH 1/4] watchdog: s3c2410_wdt: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 10:36:41 +0530
Message-Id: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/watchdog/s3c2410_wdt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index c1a221c..ee03135 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -330,10 +330,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	}
 
 	/* get the memory region for the watchdog timer */
-	wdt_base = devm_request_and_ioremap(dev, wdt_mem);
-	if (wdt_base == NULL) {
-		dev_err(dev, "failed to devm_request_and_ioremap() region\n");
-		ret = -ENOMEM;
+	wdt_base = devm_ioremap_resource(dev, wdt_mem);
+	if (IS_ERR(wdt_base)) {
+		ret = PTR_ERR(wdt_base);
 		goto err;
 	}
 
-- 
1.7.4.1

