Return-Path: <fabrizio.castro@bp.renesas.com>
Return-path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [RFC 11/37] soc: renesas: rcar-rst: Document generic compatible strings
Date: Thu, 25 Jan 2018 18:02:45 +0000
Message-Id: <1516903391-30467-12-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

>From now on, devices compatible with the generic compatible strings
documented by this commit don't need to modify the corresponding driver
anymore.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index a8014f3..2602a19 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -11,7 +11,10 @@ following functions:
 
 
 Required properties:
-  - compatible: Should be
+  - compatible: Should be a SoC specific string, followed by a generic
+		fallback compatible string when compatible with the generic
+		version.
+		The SoC specific compatible string should be:
 		  - "renesas,<soctype>-reset-wdt" for R-Car Gen1,
 		  - "renesas,<soctype>-rst" for R-Car Gen2 and Gen3, and RZ/G
 		Examples with soctypes are:
@@ -28,12 +31,16 @@ Required properties:
 		  - "renesas,r8a7796-rst" (R-Car M3-W)
 		  - "renesas,r8a77970-rst" (R-Car V3M)
 		  - "renesas,r8a77995-rst" (R-Car D3)
+		The generic compatible string should be:
+		  - "renesas,rcar-gen1-rst" for R-Car Gen1
+		  - "renesas,rcar-gen2-rst" for R-Car Gen2 and RZ/G
+		  - "renesas,rcar-gen3-rst" for R-Car Gen3
   - reg: Address start and address range for the device.
 
 
 Example:
 
 	rst: reset-controller@e6160000 {
-		compatible = "renesas,r8a7795-rst";
+		compatible = "renesas,r8a7795-rst", "renesas,rcar-gen3-rst";
 		reg = <0 0xe6160000 0 0x0200>;
 	};
-- 
2.7.4
