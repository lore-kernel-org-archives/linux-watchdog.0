Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34752 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935075AbdGTKXD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Jul 2017 06:23:03 -0400
From: Matthias Brugger <matthias.bgg@gmail.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 3/4] arm64: dts: mediatek: add watchdog to MT6796
Date: Thu, 20 Jul 2017 12:22:46 +0200
Message-Id: <20170720102247.12342-3-matthias.bgg@gmail.com>
In-Reply-To: <20170720102247.12342-1-matthias.bgg@gmail.com>
References: <20170720102247.12342-1-matthias.bgg@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

This patch adds the watchdog driver to the MT6796 SoC.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 31088a9f71de..1cb45219ef05 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -147,6 +147,11 @@
 		infracfg = <&infrasys>;
 	};
 
+	watchdog: watchdog@10007000 {
+		compatible = "mediatek,mt6797-wdt", "mediatek,mt6589-wdt";
+		reg = <0 0x10007000 0 0x100>;
+	};
+
 	apmixedsys: apmixed@1000c000 {
 		compatible = "mediatek,mt6797-apmixedsys";
 		reg = <0 0x1000c000 0 0x1000>;
-- 
2.12.3

