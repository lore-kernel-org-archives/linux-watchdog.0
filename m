Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33808 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965088AbdGTKXB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Jul 2017 06:23:01 -0400
From: Matthias Brugger <matthias.bgg@gmail.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/4] ARM: mediatek: dts: Add mt6796 binding
Date: Thu, 20 Jul 2017 12:22:45 +0200
Message-Id: <20170720102247.12342-2-matthias.bgg@gmail.com>
In-Reply-To: <20170720102247.12342-1-matthias.bgg@gmail.com>
References: <20170720102247.12342-1-matthias.bgg@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

This patch adds the binding for the MT6797 SoC.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index b0d8d3a9d79e..20ada673ab0c 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible should contain:
 	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
 	"mediatek,mt6589-wdt": for MT6589
+	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
 
 - reg : Specifies base physical address and size of the registers.
 
-- 
2.12.3

