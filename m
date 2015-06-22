Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33003 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbFVEQv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jun 2015 00:16:51 -0400
Received: by qkhu186 with SMTP id u186so94810294qkh.0
        for <linux-watchdog@vger.kernel.org>; Sun, 21 Jun 2015 21:16:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] watchdog: imx2_wdt: Disable previously acquired clock on error path
Date: Mon, 22 Jun 2015 01:16:19 -0300
Message-Id: <1434946579-9674-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1434946579-9674-1-git-send-email-festevam@gmail.com>
References: <1434946579-9674-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

If watchdog_register_device() fails we should disable the previously
acquired wdev->clk clock on error path.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/watchdog/imx2_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index add1fa0..0bb1a1d 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -291,7 +291,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	ret = watchdog_register_device(wdog);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register watchdog device\n");
-		return ret;
+		goto disable_clk;
 	}
 
 	wdev->restart_handler.notifier_call = imx2_restart_handler;
@@ -304,6 +304,10 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		 wdog->timeout, nowayout);
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(wdev->clk);
+	return ret;
 }
 
 static int __exit imx2_wdt_remove(struct platform_device *pdev)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
