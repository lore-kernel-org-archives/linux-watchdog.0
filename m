Return-path: <slemieux.tyco@gmail.com>
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org,
	wim@iguana.be,
	stigge@antcom.de,
	vz@mleia.com
Subject: [PATCH v5 1/6] watchdog: pnx4008: update logging during power-on
Date: Mon, 29 Feb 2016 12:31:03 -0500
Message-Id: <1456767068-14449-2-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

There is no need add the driver name in the text to display
on the console during the power-on:
pnx4008-watchdog 4003c000.watchdog: PNX4008 Watchdog Timer: heartbeat 19 sec

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes from v4 to v5:
- Added Reviewed-by from v4.

Changes from v3 to v4:
- none.

Changes from v2 to v3:
- none.

Changes from v1 to v2:
- new patch in v2.

 drivers/watchdog/pnx4008_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 313cd1c..88264a2 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -178,8 +178,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	dev_info(&pdev->dev, "PNX4008 Watchdog Timer: heartbeat %d sec\n",
-		 pnx4008_wdd.timeout);
+	dev_info(&pdev->dev, "heartbeat %d sec\n", pnx4008_wdd.timeout);
 
 	return 0;
 
-- 
1.8.3.1
