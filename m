Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36362 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950463AbdDYQRi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Apr 2017 12:17:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id v1so4998209pgv.3
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Apr 2017 09:17:38 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: zx2967: remove redundant dev_err call in zx2967_wdt_probe()
Date: Tue, 25 Apr 2017 16:17:33 +0000
Message-Id: <20170425161733.14931-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/watchdog/zx2967_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
index e290d5a..c982527 100644
--- a/drivers/watchdog/zx2967_wdt.c
+++ b/drivers/watchdog/zx2967_wdt.c
@@ -211,10 +211,8 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
 
 	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->reg_base = devm_ioremap_resource(dev, base);
-	if (IS_ERR(wdt->reg_base)) {
-		dev_err(dev, "ioremap failed\n");
+	if (IS_ERR(wdt->reg_base))
 		return PTR_ERR(wdt->reg_base);
-	}
 
 	zx2967_wdt_reset_sysctrl(dev);
 



