Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56216 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbeGTL7T (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 20 Jul 2018 07:59:19 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] watchdog: renesas-wdt: Add support for the R8A77990 wdt
Date: Fri, 20 Jul 2018 13:11:25 +0200
Message-Id: <20180720111125.11551-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car E3 (R8A77990) SoC. No driver update is needed.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index f24d802b8056..5d47a262474c 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -16,6 +16,7 @@ Required properties:
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
 		 - "renesas,r8a77965-wdt" (R-Car M3-N)
 	         - "renesas,r8a77970-wdt" (R-Car V3M)
+	         - "renesas,r8a77990-wdt" (R-Car E3)
 	         - "renesas,r8a77995-wdt" (R-Car D3)
 	         - "renesas,r7s72100-wdt" (RZ/A1)
 		The generic compatible string must be:
-- 
2.11.0

