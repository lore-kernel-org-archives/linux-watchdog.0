Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36511 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbeBJUgo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 10 Feb 2018 15:36:44 -0500
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Joachim Eastwood <manabian@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] watchdog: lpc18xx: remove assignment of unused ret-value
Date: Sat, 10 Feb 2018 21:36:23 +0100
Message-Id: <20180210203623.17832-4-marcus.folkesson@gmail.com>
In-Reply-To: <20180210203623.17832-1-marcus.folkesson@gmail.com>
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/lpc18xx_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index b4221f43cd94..331cadb459ac 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -265,7 +265,7 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 	lpc18xx_wdt->wdt_dev.parent = dev;
 	watchdog_set_drvdata(&lpc18xx_wdt->wdt_dev, lpc18xx_wdt);
 
-	ret = watchdog_init_timeout(&lpc18xx_wdt->wdt_dev, heartbeat, dev);
+	watchdog_init_timeout(&lpc18xx_wdt->wdt_dev, heartbeat, dev);
 
 	__lpc18xx_wdt_set_timeout(lpc18xx_wdt);
 
-- 
2.15.1

