Return-Path: <geert@linux-m68k.org>
Return-path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: watchdog: renesas-wdt: Add support for the r8a77995 wdt
Date: Thu, 17 Aug 2017 13:14:25 +0200
Message-Id: <1502968465-7809-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car D3 (r8a77995) SoC.

No driver update is needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 9e306afbbd49e91b..bf6d1ca58af7d198 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	       Examples with soctypes are:
 	         - "renesas,r8a7795-wdt" (R-Car H3)
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
+	         - "renesas,r8a77995-wdt" (R-Car D3)
 	         - "renesas,r7s72100-wdt" (RZ/A1)
 
   When compatible with the generic version, nodes must list the SoC-specific
-- 
2.7.4
