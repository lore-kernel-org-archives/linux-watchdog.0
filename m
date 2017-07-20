Return-Path: <matthias.bgg@gmail.com>
Return-path: <matthias.bgg@gmail.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
To: wim@iguana.be,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	will.deacon@arm.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <mbrugger@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/4] ARM: mediatek: dts: Cleanup bindings documentation
Date: Thu, 20 Jul 2017 12:22:44 +0200
Message-Id: <20170720102247.12342-1-matthias.bgg@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

This patch cleans up the binding documentation stating explicitly
the binding and it's fallback for every SoC.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 6a00939a059a..b0d8d3a9d79e 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -3,9 +3,8 @@ Mediatek SoCs Watchdog timer
 Required properties:
 
 - compatible should contain:
-	* "mediatek,mt2701-wdt" for MT2701 compatible watchdog timers
-	* "mediatek,mt6589-wdt" for all compatible watchdog timers (MT2701,
-		MT6589)
+	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
+	"mediatek,mt6589-wdt": for MT6589
 
 - reg : Specifies base physical address and size of the registers.
 
-- 
2.12.3
