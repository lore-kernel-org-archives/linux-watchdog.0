Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:41872 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeGFIzN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Jul 2018 04:55:13 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: watchdog: renesas-wdt: Add support for the R8A77990 wdt
Date: Fri,  6 Jul 2018 10:55:08 +0200
Message-Id: <20180706085508.30791-1-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car E3 (R8A77990) SoC.

No driver update is needed.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Reviewed-by, Acked-by.
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index f24d802b8056f6c6..5d47a262474cfe0e 100644
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
2.17.1

