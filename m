Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:27125 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751722AbeAaSZv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 13:25:51 -0500
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [RFC v4 11/26] dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
Date: Wed, 31 Jan 2018 18:24:15 +0000
Message-Id: <1517423070-24236-12-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit documents the compatibility with R-Car Gen2 and RZ/G
devices by defining the generic compatible string "renesas,rcar-gen2-wdt".
Also, this patch expands the list of SoC-specific compatible strings to
include RZ/G and R-Car Gen2 devices.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3->4:
* Reinstated lost "renesas,rza-wdt" compatible string

 .../devicetree/bindings/watchdog/renesas-wdt.txt      | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index bf6d1ca..4815128 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -1,17 +1,26 @@
 Renesas Watchdog Timer (WDT) Controller
 
 Required properties:
-- compatible : Should be "renesas,<soctype>-wdt", and
-	       "renesas,rcar-gen3-wdt" or "renesas,rza-wdt" as fallback.
+ - compatible : Must be "renesas,<soctype>-wdt", followed by a generic
+		fallback compatible string when compatible with the generic
+		version.
 	       Examples with soctypes are:
+		 - "renesas,r8a7743-wdt" (RZ/G1M)
+		 - "renesas,r8a7745-wdt" (RZ/G1E)
+	         - "renesas,r8a7790-wdt" (R-Car H2)
+	         - "renesas,r8a7791-wdt" (R-Car M2-W)
+	         - "renesas,r8a7792-wdt" (R-Car V2H)
+	         - "renesas,r8a7793-wdt" (R-Car M2-N)
+	         - "renesas,r8a7794-wdt" (R-Car E2)
 	         - "renesas,r8a7795-wdt" (R-Car H3)
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
 	         - "renesas,r8a77995-wdt" (R-Car D3)
 	         - "renesas,r7s72100-wdt" (RZ/A1)
+		The generic compatible string must be:
+		 - "renesas,rza-wdt" for RZ/A
+		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
+		 - "renesas,rcar-gen3-wdt" for R-Car Gen3
 
-  When compatible with the generic version, nodes must list the SoC-specific
-  version corresponding to the platform first, followed by the generic
-  version.
 
 - reg : Should contain WDT registers location and length
 - clocks : the clock feeding the watchdog timer.
-- 
2.7.4

