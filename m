Return-Path: <mathieu@macbookpro.malat.net>
Return-path: <mathieu@macbookpro.malat.net>
From: Mathieu Malaterre <malat@debian.org>
To: 
Cc: Mathieu Malaterre <malat@debian.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	devicetree@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 3/3] MIPS: jz4780: DTS: Probe the jz4740-watchdog driver from devicetree
Date: Fri,  8 Sep 2017 20:35:55 +0200
Message-Id: <20170908183558.1537-3-malat@debian.org>
In-Reply-To: <20170908183558.1537-1-malat@debian.org>
References: <20170908183558.1537-1-malat@debian.org>
List-ID: <linux-watchdog@vger.kernel.org>

The jz4740-watchdog driver supports both jz4740 & jz4780.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 4853ef67b3ab..33d7f49186d6 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -207,6 +207,11 @@
 		status = "disabled";
 	};
 
+	watchdog: jz4780-watchdog@10002000 {
+		compatible = "ingenic,jz4740-watchdog";
+		reg = <0x10002000 0x100>;
+	};
+
 	nemc: nemc@13410000 {
 		compatible = "ingenic,jz4780-nemc";
 		reg = <0x13410000 0x10000>;
-- 
2.11.0
