Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:47082 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938576AbcKXM76 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 Nov 2016 07:59:58 -0500
From: Tero Kristo <t-kristo@ti.com>
To: <wim@iguana.be>
CC: <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog: davinci: add support for deferred probing
Date: Thu, 24 Nov 2016 14:58:28 +0200
Message-ID: <1479992308-27473-1-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

devm_clk_get can fail with EPROBE_DEFER in case the clock provider is
not ready yet. Handle this case gracefully, rather than dumping out
a huge warning.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/watchdog/davinci_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 17454ca..0e731d7 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -166,8 +166,12 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	davinci_wdt->clk = devm_clk_get(dev, NULL);
-	if (WARN_ON(IS_ERR(davinci_wdt->clk)))
+
+	if (IS_ERR(davinci_wdt->clk)) {
+		if (PTR_ERR(davinci_wdt->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get clock node\n");
 		return PTR_ERR(davinci_wdt->clk);
+	}
 
 	clk_prepare_enable(davinci_wdt->clk);
 
-- 
1.9.1

