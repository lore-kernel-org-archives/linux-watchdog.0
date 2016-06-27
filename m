Return-path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] watchdog: renesas-wdt: Add support for the r8a7796 wdt
Date: Mon, 27 Jun 2016 19:50:45 +0200
Message-Id: <1467049847-7469-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1467049847-7469-1-git-send-email-geert+renesas@glider.be>
References: <1467049847-7469-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car M3-W (r8a7796) SoC.

No driver update is needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index b9512f1eb80a0205..da24e31334177768 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -1,7 +1,11 @@
 Renesas Watchdog Timer (WDT) Controller
 
 Required properties:
-- compatible : Should be "renesas,r8a7795-wdt", or "renesas,rcar-gen3-wdt"
+- compatible : Should be "renesas,<soctype>-wdt", and
+	       "renesas,rcar-gen3-wdt" as fallback.
+	       Examples with soctypes are:
+	         - "renesas,r8a7795-wdt" (R-Car H3)
+	         - "renesas,r8a7796-wdt" (R-Car M3-W)
 
   When compatible with the generic version, nodes must list the SoC-specific
   version corresponding to the platform first, followed by the generic
-- 
1.9.1
