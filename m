Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42216 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935059AbdAKAqp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:46:45 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 44/62] watchdog: pnx4008_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:53 -0800
Message-Id: <1484095516-12720-14-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Replace 'goto l; ... l: return e;' with 'return e;'
- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/pnx4008_wdt.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 0529aed158a4..a0cda8748c9b 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -202,6 +202,11 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(wdt_clk);
 	if (ret)
 		return ret;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       wdt_clk);
+	if (ret)
+		return ret;
 
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
@@ -211,28 +216,15 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 
 	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
 
-	ret = watchdog_register_device(&pnx4008_wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, &pnx4008_wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot register watchdog device\n");
-		goto disable_clk;
+		return ret;
 	}
 
 	dev_info(&pdev->dev, "heartbeat %d sec\n", pnx4008_wdd.timeout);
 
 	return 0;
-
-disable_clk:
-	clk_disable_unprepare(wdt_clk);
-	return ret;
-}
-
-static int pnx4008_wdt_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&pnx4008_wdd);
-
-	clk_disable_unprepare(wdt_clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -249,7 +241,6 @@ static struct platform_driver platform_wdt_driver = {
 		.of_match_table = of_match_ptr(pnx4008_wdt_match),
 	},
 	.probe = pnx4008_wdt_probe,
-	.remove = pnx4008_wdt_remove,
 };
 
 module_platform_driver(platform_wdt_driver);
-- 
2.7.4

