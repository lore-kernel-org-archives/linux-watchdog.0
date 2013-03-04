Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45712 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab3CDFRR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 00:17:17 -0500
Received: by mail-pb0-f45.google.com with SMTP id ro8so2871725pbb.4
        for <linux-watchdog@vger.kernel.org>; Sun, 03 Mar 2013 21:17:16 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, thierry.reding@avionic-design.de,
	sachin.kamat@linaro.org
Subject: [PATCH 3/4] watchdog: davinci_wdt: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 10:36:43 +0530
Message-Id: <1362373604-26771-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
References: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/davinci_wdt.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 7df1fdc..100d4fb 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -27,6 +27,7 @@
 #include <linux/device.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/err.h>
 
 #define MODULE_NAME "DAVINCI-WDT: "
 
@@ -221,11 +222,9 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	wdt_base = devm_request_and_ioremap(dev, wdt_mem);
-	if (!wdt_base) {
-		dev_err(dev, "ioremap failed\n");
-		return -EADDRNOTAVAIL;
-	}
+	wdt_base = devm_ioremap_resource(dev, wdt_mem);
+	if (IS_ERR(wdt_base))
+		return PTR_ERR(wdt_base);
 
 	ret = misc_register(&davinci_wdt_miscdev);
 	if (ret < 0) {
-- 
1.7.4.1

