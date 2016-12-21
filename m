Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:49139 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933598AbcLUBSV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Dec 2016 20:18:21 -0500
From: Vladimir Zapolskiy <vz@mleia.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: sa11x0/pxa: fix error path of driver initialization
Date: Wed, 21 Dec 2016 03:18:16 +0200
Message-Id: <20161221011816.3809-1-vz@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The change corrects release of captured resources on error path, namely
the clock is disabled and put if misc device registration fails and not
enabled clock is not disabled now.

Fixes: 6924089c488e ("watchdog: sa11x0/pxa: get rid of get_clock_tick_rate")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/watchdog/sa1100_wdt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index 8965e3f..d3be4f8 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -188,12 +188,14 @@ static int __init sa1100dog_init(void)
 	pre_margin = oscr_freq * margin;
 
 	ret = misc_register(&sa1100dog_miscdev);
-	if (ret == 0)
+	if (ret == 0) {
 		pr_info("SA1100/PXA2xx Watchdog Timer: timer margin %d sec\n",
 			margin);
-	return ret;
-err:
+		return 0;
+	}
+
 	clk_disable_unprepare(clk);
+err:
 	clk_put(clk);
 	return ret;
 }
-- 
2.10.2

