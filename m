Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59254 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753009AbaBNWYc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Feb 2014 17:24:32 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v7 01/18] watchdog: orion: Add clock error handling
Date: Fri, 14 Feb 2014 19:24:01 -0300
Message-Id: <1392416658-2780-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit adds a check for clk_prepare_enable success and introduces
an error path to disable the clock properly.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index f7722a4..7f19fa3 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -151,17 +151,24 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "Orion Watchdog missing clock\n");
-		return -ENODEV;
+		return PTR_ERR(clk);
 	}
-	clk_prepare_enable(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
 	wdt_tclk = clk_get_rate(clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto disable_clk;
+	}
+
 	wdt_reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!wdt_reg)
-		return -ENOMEM;
+	if (!wdt_reg) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
@@ -171,14 +178,16 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
-	if (ret) {
-		clk_disable_unprepare(clk);
-		return ret;
-	}
+	if (ret)
+		goto disable_clk;
 
 	pr_info("Initial timeout %d sec%s\n",
 		orion_wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 
 static int orion_wdt_remove(struct platform_device *pdev)
-- 
1.8.1.5

