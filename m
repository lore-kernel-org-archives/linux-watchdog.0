Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41059 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab3CDFRU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 00:17:20 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so2952572pad.30
        for <linux-watchdog@vger.kernel.org>; Sun, 03 Mar 2013 21:17:19 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, thierry.reding@avionic-design.de,
	sachin.kamat@linaro.org, Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 4/4] watchdog: shwdt: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 10:36:44 +0530
Message-Id: <1362373604-26771-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
References: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 drivers/watchdog/shwdt.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 6a89e40..6185af2 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 #include <asm/watchdog.h>
 
 #define DRV_NAME "sh-wdt"
@@ -249,9 +250,9 @@ static int sh_wdt_probe(struct platform_device *pdev)
 		wdt->clk = NULL;
 	}
 
-	wdt->base = devm_request_and_ioremap(wdt->dev, res);
-	if (unlikely(!wdt->base)) {
-		rc = -EADDRNOTAVAIL;
+	wdt->base = devm_ioremap_resource(wdt->dev, res);
+	if (IS_ERR(wdt->base)) {
+		rc = PTR_ERR(wdt->base);
 		goto err;
 	}
 
-- 
1.7.4.1

