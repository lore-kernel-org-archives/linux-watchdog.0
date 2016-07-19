Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:58410 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbcGSLq5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 07:46:57 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] watchdog: renesas-wdt: Add support for the r8a7796 wdt
Date: Tue, 19 Jul 2016 13:46:54 +0200
Message-Id: <1468928814-18817-1-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car M3-W (r8a7796) SoC.

No driver update is needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Acked-by.

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

