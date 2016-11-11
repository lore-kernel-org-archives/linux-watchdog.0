Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbcKKACX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 10 Nov 2016 19:02:23 -0500
From: Stephen Boyd <sboyd@codeaurora.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: jz4740: Fix modular build
Date: Thu, 10 Nov 2016 16:02:20 -0800
Message-Id: <20161111000220.12989-1-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Compiling this driver as a module causes a build error because a
semicolon is missing after MODULE_DEVICE_TABLE. Add it.

  CC [M]  drivers/watchdog/jz4740_wdt.o
drivers/watchdog/jz4740_wdt.c:154:1: error: expected ‘,’ or ‘;’ before ‘static’
drivers/watchdog/jz4740_wdt.c:218:11: error: ‘jz4740_wdt_probe’ undeclared here (not in a function)

Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/watchdog/jz4740_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index c8d51ddb26d5..20627f22baf6 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -148,7 +148,7 @@ static const struct of_device_id jz4740_wdt_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-watchdog", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches)
+MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
 #endif
 
 static int jz4740_wdt_probe(struct platform_device *pdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

