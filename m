Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49571 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934459AbdAIJvT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jan 2017 04:51:19 -0500
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>, Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: kernel@pengutronix.de, Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dts: teach newer i.MX machines to have the i.MX35 type watchdog
Date: Mon,  9 Jan 2017 10:50:38 +0100
Message-Id: <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Only i.MX35 and newer feature a WMCR register that should be written to. Older
SoCs hang when this address is written.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 2 +-
 arch/arm/boot/dts/imx25.dtsi                               | 2 +-
 arch/arm/boot/dts/imx35.dtsi                               | 2 +-
 arch/arm/boot/dts/imx50.dtsi                               | 2 +-
 arch/arm/boot/dts/imx51.dtsi                               | 2 +-
 arch/arm/boot/dts/imx53.dtsi                               | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                             | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi                              | 4 ++--
 arch/arm/boot/dts/imx6sx.dtsi                              | 6 +++---
 arch/arm/boot/dts/imx6ul.dtsi                              | 4 ++--
 arch/arm/boot/dts/imx7s.dtsi                               | 8 ++++----
 arch/arm/boot/dts/vfxxx.dtsi                               | 2 +-
 12 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
index 107280ef0025..607b010a607a 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -15,7 +15,7 @@ Optional properties:
 Examples:
 
 wdt@73f98000 {
-	compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+	compatible = "fsl,imx51-wdt", "fsl,imx35-wdt";
 	reg = <0x73f98000 0x4000>;
 	interrupts = <58>;
 	big-endian;
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 831d09a28155..d9ef338e8af7 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -504,7 +504,7 @@
 			};
 
 			wdog@53fdc000 {
-				compatible = "fsl,imx25-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx25-wdt", "fsl,imx35-wdt";
 				reg = <0x53fdc000 0x4000>;
 				clocks = <&clks 126>;
 				clock-names = "";
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 9f40e6229189..d9a4e77b74d8 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -286,7 +286,7 @@
 			};
 
 			wdog: wdog@53fdc000 {
-				compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx35-wdt";
 				reg = <0x53fdc000 0x4000>;
 				clocks = <&clks 74>;
 				clock-names = "";
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index fe0221e4cbf7..cf90e3d44f1c 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -270,7 +270,7 @@
 			};
 
 			wdog1: wdog@53f98000 {
-				compatible = "fsl,imx50-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx50-wdt", "fsl,imx35-wdt";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 33526cade735..998bf2ffd90d 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -347,7 +347,7 @@
 			};
 
 			wdog1: wdog@73f98000 {
-				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx51-wdt", "fsl,imx35-wdt";
 				reg = <0x73f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ca51dc03e327..22becf17529a 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -402,7 +402,7 @@
 			};
 
 			wdog1: wdog@53f98000 {
-				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx53-wdt", "fsl,imx35-wdt";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <58>;
 				clocks = <&clks IMX5_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 89b834f3fa17..5ca0ce926ccf 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -594,7 +594,7 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6q-wdt", "fsl,imx35-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 19cbd879c448..43b10ff725e0 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -479,14 +479,14 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sl-wdt", "fsl,imx35-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sl-wdt", "fsl,imx35-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 10f333016197..94d75c55bbef 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -534,14 +534,14 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx35-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx35-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
@@ -1201,7 +1201,7 @@
 			};
 
 			wdog3: wdog@02288000 {
-				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6sx-wdt", "fsl,imx35-wdt";
 				reg = <0x02288000 0x4000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_DUMMY>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 39845a7e0463..e3816e808cfb 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -491,14 +491,14 @@
 			};
 
 			wdog1: wdog@020bc000 {
-				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6ul-wdt", "fsl,imx35-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_WDOG1>;
 			};
 
 			wdog2: wdog@020c0000 {
-				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx6ul-wdt", "fsl,imx35-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_WDOG2>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8ff2cbdd8f0d..1a95803485d5 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -399,14 +399,14 @@
 			};
 
 			wdog1: wdog@30280000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx35-wdt";
 				reg = <0x30280000 0x10000>;
 				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG1_ROOT_CLK>;
 			};
 
 			wdog2: wdog@30290000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx35-wdt";
 				reg = <0x30290000 0x10000>;
 				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG2_ROOT_CLK>;
@@ -414,7 +414,7 @@
 			};
 
 			wdog3: wdog@302a0000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx35-wdt";
 				reg = <0x302a0000 0x10000>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG3_ROOT_CLK>;
@@ -422,7 +422,7 @@
 			};
 
 			wdog4: wdog@302b0000 {
-				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,imx7d-wdt", "fsl,imx35-wdt";
 				reg = <0x302b0000 0x10000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG4_ROOT_CLK>;
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index e9d28474c26a..4ce240790a3d 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -326,7 +326,7 @@
 			};
 
 			wdoga5: wdog@4003e000 {
-				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
+				compatible = "fsl,vf610-wdt", "fsl,imx35-wdt";
 				reg = <0x4003e000 0x1000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_WDT>;
-- 
2.11.0

