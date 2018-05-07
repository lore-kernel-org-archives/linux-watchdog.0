Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46804 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752025AbeEGM3r (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 May 2018 08:29:47 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] watchdog: renesas-wdt: Add support for the R8A77965 WDT
Date: Mon,  7 May 2018 14:29:42 +0200
Message-Id: <20180507122942.7669-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car M3-N (R8A77965) SoC. No driver update is needed.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[wsa: rebased to v4.17-rc3]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Change since V2: rebase to 4.17-rc3

 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 74b2f03c1515..fa56697a1ba6 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -7,6 +7,7 @@ Required properties:
 	         - "renesas,r7s72100-wdt" (RZ/A1)
 	         - "renesas,r8a7795-wdt" (R-Car H3)
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
+		 - "renesas,r8a77965-wdt" (R-Car M3-N)
 	         - "renesas,r8a77970-wdt" (R-Car V3M)
 	         - "renesas,r8a77995-wdt" (R-Car D3)
 
-- 
2.11.0

