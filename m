Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34357 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbdFFKiv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Jun 2017 06:38:51 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: davinci: Add missing clk_disable_unprepare().
Date: Tue,  6 Jun 2017 16:08:31 +0530
Message-Id: <616d54e4ee92f443b52efcd50606baa06e41760e.1496745446.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

davinci_wdt_probe() can fail here and we must disable clock.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/davinci_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 1ba9ead..2f46487 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -202,8 +202,10 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 		return PTR_ERR(davinci_wdt->base);
 
 	ret = watchdog_register_device(wdd);
-	if (ret < 0)
+	if (ret < 0) {
+		clk_disable_unprepare(davinci_wdt->clk);
 		dev_err(dev, "cannot register watchdog device\n");
+	}
 
 	return ret;
 }
-- 
1.9.1

