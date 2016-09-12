Return-path: <shubhrajyoti.datta@xilinx.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To: <linux-watchdog@vger.kernel.org>, <wim@iguana.be>
CC: <linux@roeck-us.net>, <shubhrajyoti.datta@gmail.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv3] watchdog: cadence_wdt: Fix the suspend resume
Date: Mon, 12 Sep 2016 12:53:49 +0530
Message-ID: <1473665029-15999-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Currently even if no users are there the suspend tries to
stop the watchdog and resume starts it.

so after resume the watchdog starts and resets the board.
Fix the same by adding a check for users.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2: use watchdog_active
v3: Add Guenter Roeck reviewed by tag

 drivers/watchdog/cadence_wdt.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 4dda902..0fd267e 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -424,8 +424,10 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
 
-	cdns_wdt_stop(&wdt->cdns_wdt_device);
-	clk_disable_unprepare(wdt->clk);
+	if (watchdog_active(&wdt->cdns_wdt_device)) {
+		cdns_wdt_stop(&wdt->cdns_wdt_device);
+		clk_disable_unprepare(wdt->clk);
+	}
 
 	return 0;
 }
@@ -442,12 +444,14 @@ static int __maybe_unused cdns_wdt_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
 
-	ret = clk_prepare_enable(wdt->clk);
-	if (ret) {
-		dev_err(dev, "unable to enable clock\n");
-		return ret;
+	if (watchdog_active(&wdt->cdns_wdt_device)) {
+		ret = clk_prepare_enable(wdt->clk);
+		if (ret) {
+			dev_err(dev, "unable to enable clock\n");
+			return ret;
+		}
+		cdns_wdt_start(&wdt->cdns_wdt_device);
 	}
-	cdns_wdt_start(&wdt->cdns_wdt_device);
 
 	return 0;
 }
-- 
2.1.1
