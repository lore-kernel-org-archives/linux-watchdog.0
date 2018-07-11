Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:44378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbeGKNN3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jul 2018 09:13:29 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "Eric Long" <eric.long@spreadtrum.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-watchdog@vger.kernel.org>
Subject: [PATCH -next] watchdog: sprd_wdt: Remove redundant dev_err call in sprd_wdt_probe()
Date: Wed, 11 Jul 2018 13:17:55 +0000
Message-ID: <1531315075-183834-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/watchdog/sprd_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index a8b280f..6bcfabb 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -277,10 +277,8 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 
 	wdt_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->base = devm_ioremap_resource(&pdev->dev, wdt_res);
-	if (IS_ERR(wdt->base)) {
-		dev_err(&pdev->dev, "failed to map memory resource\n");
+	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
-	}
 
 	wdt->enable = devm_clk_get(&pdev->dev, "enable");
 	if (IS_ERR(wdt->enable)) {

