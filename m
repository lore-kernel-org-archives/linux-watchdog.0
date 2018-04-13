Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47714 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeDMOZd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 13 Apr 2018 10:25:33 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Subject: [PATCH] watchdog: renesas-wdt: Add support for the R8A77965 WDT
Date: Fri, 13 Apr 2018 16:25:26 +0200
Message-Id: <20180413142526.9321-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car M3N (R8A77965) SoC. No driver update is needed.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[wsa: rebased to top-of-tree]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 123bb1b2654b..291d239fcbca 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -15,6 +15,7 @@ Required properties:
 		 - "renesas,r8a7794-wdt" (R-Car E2)
 		 - "renesas,r8a7795-wdt" (R-Car H3)
 		 - "renesas,r8a7796-wdt" (R-Car M3-W)
+		 - "renesas,r8a77965-wdt" (R-Car M3N)
 		 - "renesas,r8a77970-wdt" (R-Car V3M)
 		 - "renesas,r8a77995-wdt" (R-Car D3)
 	       The generic compatible string must be:
-- 
2.11.0

