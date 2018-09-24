Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:9123 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728808AbeIXUBx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Sep 2018 16:01:53 -0400
From: Chris Brandt <chris.brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v5 2/2] dt-bindings: watchdog: renesas-wdt: Add support for R7S9210
Date: Mon, 24 Sep 2018 08:58:16 -0500
Message-Id: <20180924135816.19474-3-chris.brandt@renesas.com>
In-Reply-To: <20180924135816.19474-1-chris.brandt@renesas.com>
References: <20180924135816.19474-1-chris.brandt@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Document support for RZ/A2

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
 * Added Reviewed-by
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 9407212a85a8..a9e49da6fa24 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -20,6 +20,7 @@ Required properties:
 	         - "renesas,r8a77990-wdt" (R-Car E3)
 	         - "renesas,r8a77995-wdt" (R-Car D3)
 	         - "renesas,r7s72100-wdt" (RZ/A1)
+	         - "renesas,r7s9210-wdt"  (RZ/A2)
 		The generic compatible string must be:
 		 - "renesas,rza-wdt" for RZ/A
 		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G1
-- 
2.16.1
