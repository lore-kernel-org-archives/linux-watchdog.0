Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:34979 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751593AbdCCSwh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Mar 2017 13:52:37 -0500
From: Chris Brandt <chris.brandt@renesas.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v5 2/3] watchdog: renesas-wdt: add support for rza
Date: Fri,  3 Mar 2017 12:32:00 -0500
Message-Id: <20170303173201.5597-3-chris.brandt@renesas.com>
In-Reply-To: <20170303173201.5597-1-chris.brandt@renesas.com>
References: <20170303173201.5597-1-chris.brandt@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Describe the WDT hardware in the RZ/A series.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v3:
* Add Acked-by, Reviewed-by.
v2:
* added to renesas-wdt.txt instead of creating a new file
* changed commit title
* added "renesas,rza-wdt" as a fallback
* added interrupts property
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index da24e31..9e306af 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -2,10 +2,11 @@ Renesas Watchdog Timer (WDT) Controller
 
 Required properties:
 - compatible : Should be "renesas,<soctype>-wdt", and
-	       "renesas,rcar-gen3-wdt" as fallback.
+	       "renesas,rcar-gen3-wdt" or "renesas,rza-wdt" as fallback.
 	       Examples with soctypes are:
 	         - "renesas,r8a7795-wdt" (R-Car H3)
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
+	         - "renesas,r7s72100-wdt" (RZ/A1)
 
   When compatible with the generic version, nodes must list the SoC-specific
   version corresponding to the platform first, followed by the generic
@@ -17,6 +18,7 @@ Required properties:
 Optional properties:
 - timeout-sec : Contains the watchdog timeout in seconds
 - power-domains : the power domain the WDT belongs to
+- interrupts: Some WDTs have an interrupt when used in interval timer mode
 
 Examples:
 
-- 
2.10.1


