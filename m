Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:29378 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751365AbdHNQlq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 12:41:46 -0400
From: <sean.wang@mediatek.com>
To: <wim@iguana.be>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <mark.rutland@arm.com>
CC: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2] dt-bindings: watchdog: mediatek: add support for MediaTek MT7623 and MT7622 SoC
Date: Tue, 15 Aug 2017 00:41:38 +0800
Message-ID: <2d18c98edcef994a19e342bea5209ddd0cbd6c25.1502728495.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This updates dt-binding documentation for MediaTek MT7622 and
MT7623 SoC. For the both SoCs supported all rely on the fallback
binding of the case with "mediatek,mt6589-wdt".

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 6a00939..096bbfb 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -4,6 +4,8 @@ Required properties:
 
 - compatible should contain:
 	* "mediatek,mt2701-wdt" for MT2701 compatible watchdog timers
+	* "mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
+	* "mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
 	* "mediatek,mt6589-wdt" for all compatible watchdog timers (MT2701,
 		MT6589)
 
-- 
2.7.4

