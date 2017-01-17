Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:47526 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdAQBYr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 20:24:47 -0500
From: Vladimir Zapolskiy <vz@mleia.com>
To: Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] ARM: dts: imx: add fsl,imx35-wdt compatible to all relevant watchdog nodes
Date: Tue, 17 Jan 2017 03:23:36 +0200
Message-Id: <20170117012336.6891-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Watchdog device controller found on all modern SoCs from i.MX series
and firstly introduced in i.MX35 is not one in one compatible with the
watchdog controllers on i.MX21, i.MX27 and i.MX31, the latter
controlles don't have WICR (and pretimeout notification support) and
WMCR registers. To get benefit from the more advanced watchdog device
and to avoid operations over non-existing registers on legacy SoCs add
fsl,imx35-wdt compatible to descriptions of all i.MX35 compatible
watchdog controllers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
RFC change is found at https://patchwork.kernel.org/patch/9350007

Changes from RFC to v1:
* added the same change to devicetree bindings documentation, thanks
  to Baruch Siach for review,
* replaced a new shared compatible derived from i.MX25 with an earlier
  from i.MX35 SoC one, thanks to Uwe Kleine-König for review.

Compatible "fsl,imx21-wdt" is preserved as a generic one, because
interface to a watchdog controller on i.MX35 is a superset of the
interface to a i.MX21 watchdog controller.

 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt |  2 +-
 arch/arm/boot/dts/imx25.dtsi                               |  3 ++-
 arch/arm/boot/dts/imx50.dtsi                               |  3 ++-
 arch/arm/boot/dts/imx51.dtsi                               |  6 ++++--
 arch/arm/boot/dts/imx53.dtsi                               |  6 ++++--
 arch/arm/boot/dts/imx6qdl.dtsi                             |  6 ++++--
 arch/arm/boot/dts/imx6sl.dtsi                              |  6 ++++--
 arch/arm/boot/dts/imx6sx.dtsi                              |  9 ++++++---
 arch/arm/boot/dts/imx6ul.dtsi                              |  6 ++++--
 arch/arm/boot/dts/imx7s.dtsi                               | 12 ++++++++----
 arch/arm/boot/dts/ls1021a.dtsi                             |  2 +-
 arch/arm/boot/dts/vfxxx.dtsi                               |  3 ++-
 12 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
index 107280e..9551088 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -15,7 +15,7 @@ Optional properties:
 Examples:
 
 wdt@73f98000 {
-	compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+	compatible = "fsl,imx51-wdt", "fsl,imx35-wdt", "fsl,imx21-wdt";
 	reg = <0x73f98000 0x4000>;
 	interrupts = <58>;
 	big-endian;
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 213d86e..1194fe2 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -505,7 +505,8 @@
 			};
 
 			wdog@53fdc000 {
-				compatible = "fsl,imx25-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx25-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x53fdc000 0x4000>;
 				clocks = <&clks 126>;
 				clock-names = "";
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index fe0221e..476f54e 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -270,7 +270,8 @@
 			};
 
 			wdog1: wdog@53f98000 {
-				compatible = "fsl,imx50-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx50-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 33526ca..a67870b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -347,14 +347,16 @@
 			};
 
 			wdog1: wdog@73f98000 {
-				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx51-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x73f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@73f9c000 {
-				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx51-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x73f9c000 0x4000>;
 				interrupts = <59>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ca51dc0..4d0c5c8 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -402,14 +402,16 @@
 			};
 
 			wdog1: wdog@53f98000 {
-				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx53-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@53f9c000 {
-				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx53-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x53f9c000 0x4000>;
 				interrupts = <59>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 53e6e63..16ee492 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -594,14 +594,16 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6q-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6q-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 4fd6de2..794f44d 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -479,14 +479,16 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sl-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sl-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 076a30f..e36ead9 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -534,14 +534,16 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
@@ -1200,7 +1202,8 @@
 			};
 
 			wdog3: wdog@02288000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x02288000 0x4000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 0f69a3f..33d9a2c 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -491,14 +491,16 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6ul-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_WDOG1>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6ul-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_WDOG2>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8db1eb9..ba38b69 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -399,14 +399,16 @@
 			};
 
 			wdog1: wdog@30280000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x30280000 0x10000>;
 				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG1_ROOT_CLK>;
 			};
 
 			wdog2: wdog@30290000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x30290000 0x10000>;
 				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG2_ROOT_CLK>;
@@ -414,7 +416,8 @@
 			};
 
 			wdog3: wdog@302a0000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x302a0000 0x10000>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG3_ROOT_CLK>;
@@ -422,7 +425,8 @@
 			};
 
 			wdog4: wdog@302b0000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x302b0000 0x10000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG4_ROOT_CLK>;
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 282d854..41f5afa 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -521,7 +521,7 @@
 		};
 
 		wdog0: watchdog@2ad0000 {
-			compatible = "fsl,imx21-wdt";
+			compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&platform_clk 1>;
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 5d654b5..360d590 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -326,7 +326,8 @@
 			};
 
 			wdoga5: wdog@4003e000 {
-				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,vf610-wdt", "fsl,imx35-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_WDT>;
-- 
2.10.2

