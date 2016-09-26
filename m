Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:60832 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941229AbcIZAj0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 25 Sep 2016 20:39:26 -0400
From: Vladimir Zapolskiy <vz@mleia.com>
To: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 2/2] ARM: i.MX: dts: add fsl,imx25-wdt compatible to all relevant watchdog nodes
Date: Mon, 26 Sep 2016 03:39:21 +0300
Message-Id: <1474850361-20884-3-git-send-email-vz@mleia.com>
In-Reply-To: <1474850361-20884-1-git-send-email-vz@mleia.com>
References: <1474850361-20884-1-git-send-email-vz@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Watchdog device controller found on all modern SoCs from i.MX series
and firstly introduced in i.MX25 is not one in one compatible with the
watchdog controllers on i.MX21, i.MX27 and i.MX31, the latter
controlles don't have WICR (and pretimeout notification support) and
WMCR registers. To get benefit from the more advanced watchdog device
and to avoid operations over non-existing registers on legacy SoCs add
fsl,imx25-wdt compatible to descriptions of all i.MX25 compatible
watchdog controllers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/imx35.dtsi   |  3 ++-
 arch/arm/boot/dts/imx50.dtsi   |  3 ++-
 arch/arm/boot/dts/imx51.dtsi   |  6 ++++--
 arch/arm/boot/dts/imx53.dtsi   |  6 ++++--
 arch/arm/boot/dts/imx6qdl.dtsi |  6 ++++--
 arch/arm/boot/dts/imx6sl.dtsi  |  6 ++++--
 arch/arm/boot/dts/imx6sx.dtsi  |  9 ++++++---
 arch/arm/boot/dts/imx6ul.dtsi  |  6 ++++--
 arch/arm/boot/dts/imx7s.dtsi   | 12 ++++++++----
 arch/arm/boot/dts/ls1021a.dtsi |  2 +-
 arch/arm/boot/dts/vfxxx.dtsi   |  3 ++-
 11 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 490b7b4..8fd4482 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -284,7 +284,8 @@
 			};
 
 			wdog: wdog@53fdc000 {
-				compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx35-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x53fdc000 0x4000>;
 				clocks = <&clks 74>;
 				clock-names = "";
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index e245713..5ba6d5a 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -260,7 +260,8 @@
 			};
 
 			wdog1: wdog@53f98000 {
-				compatible = "fsl,imx50-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx50-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index f46fe9b..d91f713 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -345,14 +345,16 @@
 			};
 
 			wdog1: wdog@73f98000 {
-				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx51-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x73f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@73f9c000 {
-				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx51-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x73f9c000 0x4000>;
 				interrupts = <59>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd17037..c9edac2 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -390,14 +390,16 @@
 			};
 
 			wdog1: wdog@53f98000 {
-				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx53-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@53f9c000 {
-				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx53-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x53f9c000 0x4000>;
 				interrupts = <59>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b620ac8..d73edd7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -593,14 +593,16 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6q-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6q-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 5425150..b8c71bd 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -430,14 +430,16 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sl-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sl-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 2863c52..2753c71 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -515,14 +515,16 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
@@ -1178,7 +1180,8 @@
                         };
 
 			wdog3: wdog@02288000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x02288000 0x4000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 33b95d7..fb0373f 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -483,14 +483,16 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6ul-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_WDOG1>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6ul-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_WDOG2>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1e90bdb..e7c047e 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -394,14 +394,16 @@
 			};
 
 			wdog1: wdog@30280000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x30280000 0x10000>;
 				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG1_ROOT_CLK>;
 			};
 
 			wdog2: wdog@30290000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x30290000 0x10000>;
 				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG2_ROOT_CLK>;
@@ -409,7 +411,8 @@
 			};
 
 			wdog3: wdog@302a0000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x302a0000 0x10000>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG3_ROOT_CLK>;
@@ -417,7 +420,8 @@
 			};
 
 			wdog4: wdog@302b0000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x302b0000 0x10000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG4_ROOT_CLK>;
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 368e219..7e36fd8 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -441,7 +441,7 @@
 		};
 
 		wdog0: watchdog@2ad0000 {
-			compatible = "fsl,imx21-wdt";
+			compatible = "fsl,imx25-wdt", "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&platform_clk 1>;
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2c13ec6..35f32ed 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -320,7 +320,8 @@
 			};
 
 			wdoga5: wdog@4003e000 {
-				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,vf610-wdt", "fsl,imx25-wdt",
+					     "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_WDT>;
-- 
2.8.1

