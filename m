Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34702 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdGVUXS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Jul 2017 16:23:18 -0400
Received: by mail-qk0-f196.google.com with SMTP id q66so6919038qki.1
        for <linux-watchdog@vger.kernel.org>; Sat, 22 Jul 2017 13:23:18 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        wsa+renesas@sang-engineering.com, justinpopo6@gmail.com,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/2] watchdog: bcm7038: Check the return value from clk_prepare_enable()
Date: Sat, 22 Jul 2017 17:22:59 -0300
Message-Id: <1500754979-19836-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1500754979-19836-1-git-send-email-festevam@gmail.com>
References: <1500754979-19836-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/watchdog/bcm7038_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index c1b8e534..f88f546 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -136,7 +136,9 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 	wdt->clk = devm_clk_get(dev, NULL);
 	/* If unable to get clock, use default frequency */
 	if (!IS_ERR(wdt->clk)) {
-		clk_prepare_enable(wdt->clk);
+		err = clk_prepare_enable(wdt->clk);
+		if (err)
+			return err;
 		wdt->rate = clk_get_rate(wdt->clk);
 		/* Prevent divide-by-zero exception */
 		if (!wdt->rate)
-- 
2.7.4

