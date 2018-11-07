Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:46823 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726544AbeKGQjs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Nov 2018 11:39:48 -0500
From: Ryder Lee <ryder.lee@mediatek.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
Date: Wed, 7 Nov 2018 15:10:36 +0800
Message-ID: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This updates dt-binding documentation for MT7629 SoC

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 859dee1..8682d6a 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -8,6 +8,7 @@ Required properties:
 	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
 	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
 	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
+	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
 
 - reg : Specifies base physical address and size of the registers.
 
-- 
1.9.1
