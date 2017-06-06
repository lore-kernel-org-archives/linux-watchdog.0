Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36142 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdFFKSM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Jun 2017 06:18:12 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: davinci: Handle return value of clk_prepare_enable
Date: Tue,  6 Jun 2017 15:47:53 +0530
Message-Id: <79da4d6a88384de0b9d8dcea9fc49ca696273576.1496744110.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/davinci_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 0e731d7..1ba9ead 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -173,7 +173,11 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 		return PTR_ERR(davinci_wdt->clk);
 	}
 
-	clk_prepare_enable(davinci_wdt->clk);
+	ret = clk_prepare_enable(davinci_wdt->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to prepare clock\n");
+		return ret;
+	}
 
 	platform_set_drvdata(pdev, davinci_wdt);
 
-- 
1.9.1

