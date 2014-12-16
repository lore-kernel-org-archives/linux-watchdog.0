Return-path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] watchdog: imx2_wdt: Fix the argument of watchdog_active()
Date: Mon, 15 Dec 2014 22:49:59 -0200
Message-Id: <1418690999-28294-1-git-send-email-festevam@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following build warning by passing the expected argument type to 
watchdog_active():

drivers/watchdog/imx2_wdt.c: In function 'imx2_wdt_suspend':
drivers/watchdog/imx2_wdt.c:340:2: warning: passing argument 1 of 'watchdog_active' from incompatible pointer type [enabled by default]
In file included from drivers/watchdog/imx2_wdt.c:38:0:
include/linux/watchdog.h:104:20: note: expected 'struct watchdog_device *' but argument is of type 'struct watchdog_device **'

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/watchdog/imx2_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 51d940b..d6add51 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -337,7 +337,7 @@ static int imx2_wdt_suspend(struct device *dev)
 	imx2_wdt_ping(wdog);
 
 	/* Watchdog has been stopped but IP block is still running */
-	if (!watchdog_active(&wdog) && imx2_wdt_is_running(wdev))
+	if (!watchdog_active(wdog) && imx2_wdt_is_running(wdev))
 		del_timer_sync(&wdev->timer);
 
 	clk_disable_unprepare(wdev->clk);
-- 
1.9.1
