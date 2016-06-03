Return-path: <narmstrong@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
Date: Fri,  3 Jun 2016 10:36:47 +0200
Message-Id: <1464943007-18000-4-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1464943007-18000-1-git-send-email-narmstrong@baylibre.com>
References: <1464943007-18000-1-git-send-email-narmstrong@baylibre.com>
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 832815d..bcca82f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -136,6 +136,12 @@
 				clocks = <&xtal>;
 				status = "disabled";
 			};
+
+			watchdog@98d0 {
+				compatible = "amlogic,meson-gxbb-wdt";
+				reg = <0x0 0x098d0 0x0 0x10>;
+				clocks = <&xtal>;
+			};
 		};
 
 		gic: interrupt-controller@c4301000 {
-- 
2.7.0
