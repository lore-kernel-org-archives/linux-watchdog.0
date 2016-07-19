Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from m12-17.163.com ([220.181.12.17]:50657 "EHLO m12-17.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147AbcGSLXJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 07:23:09 -0400
From: Wei Yongjun <weiyj_lk@163.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH -next] watchdog: pic32-wdt: Fix return value check in pic32_wdt_drv_probe()
Date: Tue, 19 Jul 2016 11:21:56 +0000
Message-Id: <1468927316-32052-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/watchdog/pic32-wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index 2b7a2b2..9456d05 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -183,8 +183,8 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 		return PTR_ERR(wdt->regs);
 
 	wdt->rst_base = devm_ioremap(&pdev->dev, PIC32_BASE_RESET, 0x10);
-	if (IS_ERR(wdt->rst_base))
-		return PTR_ERR(wdt->rst_base);
+	if (!wdt->rst_base)
+		return -ENOMEM;
 
 	wdt->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {


