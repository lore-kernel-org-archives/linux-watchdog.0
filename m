Return-Path: <chris.brandt@renesas.com>
Return-path: <chris.brandt@renesas.com>
From: Chris Brandt <chris.brandt@renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>,
	Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v3 2/2] dt-bindings: watchdog: renesas-wdt: Add support for R7S9210
Date: Thu,  6 Sep 2018 20:22:43 -0500
Message-Id: <20180907012243.86603-3-chris.brandt@renesas.com>
In-Reply-To: <20180907012243.86603-1-chris.brandt@renesas.com>
References: <20180907012243.86603-1-chris.brandt@renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

Document support for RZ/A2

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 5d47a262474c..45a709dd0345 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -19,6 +19,7 @@ Required properties:
 	         - "renesas,r8a77990-wdt" (R-Car E3)
 	         - "renesas,r8a77995-wdt" (R-Car D3)
 	         - "renesas,r7s72100-wdt" (RZ/A1)
+	         - "renesas,r7s9210-wdt"  (RZ/A2)
 		The generic compatible string must be:
 		 - "renesas,rza-wdt" for RZ/A
 		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
-- 
2.16.1
