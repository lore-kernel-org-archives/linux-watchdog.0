Return-Path: <mgr@pengutronix.de>
Return-path: <mgr@pengutronix.de>
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: lee.jones@linaro.org,
	support.opensource@diasemi.com,
	wim@iguana.be,
	linux@roeck-us.net,
	kernel@pengutronix.de,
	Michael Grzeschik <mgr@pengutronix.de>
Subject: [PATCH 1/6] watchdog: da9062: Add restart handler support
Date: Tue, 17 Oct 2017 17:30:22 +0200
Message-Id: <20171017153027.24665-2-m.grzeschik@pengutronix.de>
In-Reply-To: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Michael Grzeschik <mgr@pengutronix.de>

Register a restart handler for the da9062 watchdog.  System restart is
triggered by sending the shutdown command to the PMIC.
As more-suitable restart handlers may exist, the priority of the
watchdog restart handler is set to 128.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/watchdog/da9062_wdt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 9083d3d922b0b..4349a02215489 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -175,6 +175,25 @@ static int da9062_wdt_set_timeout(struct watchdog_device *wdd,
 	return ret;
 }
 
+static int da9062_wdt_restart(struct watchdog_device *wdd, unsigned long action,
+			      void *data)
+{
+	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = regmap_write(wdt->hw->regmap,
+			   DA9062AA_CONTROL_F,
+			   DA9062AA_SHUTDOWN_MASK);
+	if (ret)
+		dev_alert(wdt->hw->dev, "Failed to shutdown (err = %d)\n",
+			  ret);
+
+	/* wait for reset to assert... */
+	mdelay(500);
+
+	return ret;
+}
+
 static const struct watchdog_info da9062_watchdog_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 	.identity = "DA9062 WDT",
@@ -186,6 +205,7 @@ static const struct watchdog_ops da9062_watchdog_ops = {
 	.stop = da9062_wdt_stop,
 	.ping = da9062_wdt_ping,
 	.set_timeout = da9062_wdt_set_timeout,
+	.restart = da9062_wdt_restart,
 };
 
 static const struct of_device_id da9062_compatible_id_table[] = {
@@ -219,6 +239,8 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 	wdt->wdtdev.parent = &pdev->dev;
 
+	watchdog_set_restart_priority(&wdt->wdtdev, 128);
+
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 
 	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
-- 
2.11.0
