Return-path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Felipe Balbi <balbi@ti.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: kernel@pengutronix.de,
	Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 2/4] watchdog: omap: use watchdog_init_timeout instead of open coding it
Date: Mon, 27 Apr 2015 11:22:59 +0200
Message-Id: <1430126581-24946-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Instead of (partly) open coding watchdog_init_timeout to determine the
inital timeout use the core function that exists for exactly this
purpose.

As a side effect the "timeout-sec" device-tree property is recognized now
(though currently unused in the omap device trees).

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Notes:
    Changes since (implicit) v1, sent with
    Message-Id: 1429868913-24049-2-git-send-email-u.kleine-koenig@pengutronix.de:
    
     - reword commit log
     - add Guenter's Reviewed-by tag

 Documentation/devicetree/bindings/watchdog/omap-wdt.txt | 3 +++
 drivers/watchdog/omap_wdt.c                             | 5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
index 597e19d18dca..1fa20e453a2d 100644
--- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
@@ -4,6 +4,9 @@ Required properties:
 - compatible : "ti,omap3-wdt" for OMAP3 or "ti,omap4-wdt" for OMAP4
 - ti,hwmods : Name of the hwmod associated to the WDT
 
+Optional properties:
+- timeout-sec : default watchdog timeout in seconds
+
 Examples:
 
 wdt2: wdt@4a314000 {
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 39a6cfcba016..0eb9ca04e672 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -234,10 +234,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	omap_wdt->min_timeout = TIMER_MARGIN_MIN;
 	omap_wdt->max_timeout = TIMER_MARGIN_MAX;
 
-	if (timer_margin >= TIMER_MARGIN_MIN &&
-	    timer_margin <= TIMER_MARGIN_MAX)
-		omap_wdt->timeout = timer_margin;
-	else
+	if (watchdog_init_timeout(omap_wdt, timer_margin, &pdev->dev) < 0)
 		omap_wdt->timeout = TIMER_MARGIN_DEFAULT;
 
 	watchdog_set_drvdata(omap_wdt, wdev);
-- 
2.1.4
