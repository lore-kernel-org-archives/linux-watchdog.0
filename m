Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:46636 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbeIYXWu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Sep 2018 19:22:50 -0400
From: Biju Das <biju.das@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Biju Das <biju.das@bp.renesas.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a7744 support
Date: Tue, 25 Sep 2018 18:07:21 +0100
Message-Id: <1537895241-7686-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

RZ/G1N (R8A7744) watchdog implementation is compatible with R-Car
Gen2, therefore add relevant documentation.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 9407212..d72d118 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 		version.
 	       Examples with soctypes are:
 		 - "renesas,r8a7743-wdt" (RZ/G1M)
+		 - "renesas,r8a7744-wdt" (RZ/G1N)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
 		 - "renesas,r8a774a1-wdt" (RZ/G2M)
 	         - "renesas,r8a7790-wdt" (R-Car H2)
-- 
2.7.4
