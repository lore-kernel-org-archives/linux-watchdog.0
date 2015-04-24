Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39230 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbbDXJsk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 05:48:40 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@ti.com>,
	kernel@pengutronix.de
Subject: [PATCH 1/3] watchdog: omap: use watchdog_init_timeout
Date: Fri, 24 Apr 2015 11:48:31 +0200
Message-Id: <1429868913-24049-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of (partly) open coding it use the core function. As a side
effect the "timeout-sec" devicetree property is used now.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/watchdog/omap-wdt.txt | 9 +++++----
 drivers/watchdog/omap_wdt.c                             | 5 +----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
index c227970671ea..4f18ec38be2f 100644
--- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
@@ -1,10 +1,11 @@
 TI Watchdog Timer (WDT) Controller for OMAP
 
 Required properties:
-compatible:
-- "ti,omap3-wdt" for OMAP3
-- "ti,omap4-wdt" for OMAP4
-- ti,hwmods: Name of the hwmod associated to the WDT
+- compatible : "ti,omap3-wdt" (for OMAP3) or "ti,omap4-wdt" (for OMAP4)
+- ti,hwmods : Name of the hwmod associated to the WDT
+
+Optional properties:
+- timeout-sec : default watchdog timeout in seconds
 
 Examples:
 
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

