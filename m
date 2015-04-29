Return-path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Felipe Balbi <balbi@ti.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Lokesh Vutla <lokeshvutla@ti.com>,
	kernel@pengutronix.de,
	unknown author <unknown.author@example.com>
Subject: [PATCH v2 6/4] watchdog: omap: allow to keep timer running at probe time
Date: Wed, 29 Apr 2015 20:38:47 +0200
Message-Id: <1430332727-27491-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

From: unknown author <unknown.author@example.com>

On some machines it might be desirable to keep the watchdog that is
started in the boot ROM running until userspace starts stroking it to be
able to handle boot failures.

To not introduce regressions for users not caring about the watchdog
keep the previous behaviour of disabling the watchdog in the probe
function unless a module parameter stop_at_probe is set to false.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/omap_wdt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index d7619dd7c1ca..5525afadf0ec 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -53,6 +53,11 @@ static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
 MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
 
+static bool stop_at_probe = true;
+module_param(stop_at_probe, bool, 0);
+MODULE_PARM_DESC(stop_at_probe,
+		 "Watchdog is stopped at probe time (default=true)");
+
 #define to_omap_wdt_dev(_wdog)	container_of(_wdog, struct omap_wdt_dev, wdog)
 
 struct omap_wdt_dev {
@@ -254,7 +259,8 @@ static int omap_wdt_probe(struct platform_device *pdev)
 			wdev->wdog.bootstatus = WDIOF_CARDRESET;
 	}
 
-	omap_wdt_disable(wdev);
+	if (stop_at_probe)
+		omap_wdt_disable(wdev);
 
 	ret = watchdog_register_device(&wdev->wdog);
 	if (ret) {
@@ -262,9 +268,9 @@ static int omap_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
+	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec, %sstopped\n",
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
-		wdev->wdog.timeout);
+		wdev->wdog.timeout, stop_at_probe ? "" : "not ");
 
 	pm_runtime_put_sync(wdev->dev);
 
-- 
2.1.4
