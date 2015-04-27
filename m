Return-path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Felipe Balbi <balbi@ti.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: kernel@pengutronix.de,
	Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 1/4] watchdog: omap: clearify device tree documentation
Date: Mon, 27 Apr 2015 11:22:58 +0200
Message-Id: <1430126581-24946-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

ti,hwmods doesn't belong into the compatible section but is a property
on it's own. Also reformat the section of required properties to match the
usual style of dt binding documents.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Notes:
    new in v2

 Documentation/devicetree/bindings/watchdog/omap-wdt.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
index c227970671ea..597e19d18dca 100644
--- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
@@ -1,10 +1,8 @@
 TI Watchdog Timer (WDT) Controller for OMAP
 
 Required properties:
-compatible:
-- "ti,omap3-wdt" for OMAP3
-- "ti,omap4-wdt" for OMAP4
-- ti,hwmods: Name of the hwmod associated to the WDT
+- compatible : "ti,omap3-wdt" for OMAP3 or "ti,omap4-wdt" for OMAP4
+- ti,hwmods : Name of the hwmod associated to the WDT
 
 Examples:
 
-- 
2.1.4
