Return-Path: <fabrizio.castro@bp.renesas.com>
Return-path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a774a1 support
Date: Tue, 14 Aug 2018 13:33:48 +0100
Message-Id: <1534250028-15770-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

RZ/G2M (R8A774A1) watchdog implementation is compatible with R-Car
Gen3, therefore add relevant documentation.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 5d47a26..9407212 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -7,6 +7,7 @@ Required properties:
 	       Examples with soctypes are:
 		 - "renesas,r8a7743-wdt" (RZ/G1M)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
+		 - "renesas,r8a774a1-wdt" (RZ/G2M)
 	         - "renesas,r8a7790-wdt" (R-Car H2)
 	         - "renesas,r8a7791-wdt" (R-Car M2-W)
 	         - "renesas,r8a7792-wdt" (R-Car V2H)
@@ -21,8 +22,8 @@ Required properties:
 	         - "renesas,r7s72100-wdt" (RZ/A1)
 		The generic compatible string must be:
 		 - "renesas,rza-wdt" for RZ/A
-		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
-		 - "renesas,rcar-gen3-wdt" for R-Car Gen3
+		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G1
+		 - "renesas,rcar-gen3-wdt" for R-Car Gen3 and RZ/G2
 
 - reg : Should contain WDT registers location and length
 - clocks : the clock feeding the watchdog timer.
-- 
2.7.4
