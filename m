Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46242 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072AbbDXUU6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 16:20:58 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Felipe Balbi <balbi@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
Date: Fri, 24 Apr 2015 22:20:50 +0200
Message-Id: <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20150424190207.GU19431@pengutronix.de>
References: <20150424190207.GU19431@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ti,hwmods doesn't belong into the compatible section but is a property
on it's own. Also reformat the section of required properties to match the
usual style of dt binding documents.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello Felipe,

what about this patch before the previously sent patch 1?

Best regards
Uwe

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

