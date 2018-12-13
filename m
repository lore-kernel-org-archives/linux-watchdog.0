Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:59664 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbeLMUTA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 13 Dec 2018 15:19:00 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a774c0 support
Date: Thu, 13 Dec 2018 20:18:53 +0000
Message-Id: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

RZ/G2E (R8A774C0) watchdog implementation is compatible with R-Car
Gen3, therefore add relevant documentation.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index a8ee29f..ef2b97b 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -9,6 +9,7 @@ Required properties:
 		 - "renesas,r8a7744-wdt" (RZ/G1N)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
 		 - "renesas,r8a774a1-wdt" (RZ/G2M)
+		 - "renesas,r8a774c0-wdt" (RZ/G2E)
 	         - "renesas,r8a7790-wdt" (R-Car H2)
 	         - "renesas,r8a7791-wdt" (R-Car M2-W)
 	         - "renesas,r8a7792-wdt" (R-Car V2H)
-- 
2.7.4
