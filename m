Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35573 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbcDAPOI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 Apr 2016 11:14:08 -0400
Received: by mail-pa0-f54.google.com with SMTP id td3so92488032pab.2
        for <linux-watchdog@vger.kernel.org>; Fri, 01 Apr 2016 08:14:08 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: linux-watchdog@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>, Stefan Roese <sr@denx.de>,
	Iain Paton <ipaton0@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 2/2] ARM: dts: imx: ventana: Add wdt ext-reset support
Date: Fri,  1 Apr 2016 08:16:44 -0700
Message-Id: <1459523804-11390-3-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1459523804-11390-1-git-send-email-tharvey@gateworks.com>
References: <1459523804-11390-1-git-send-email-tharvey@gateworks.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Gateworks Ventana boards have a PMIC that can be used to regulate the
CPU voltage rails for DVFS support. In order to ensure this PMIC is properly
reset the watchdog needs to be configured to assert its external reset
signal.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Stefan Roese <sr@denx.de>
Cc: Iain Paton <ipaton0@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
----
v5:
 - changed property to 'fsl,ext-reset-output'
v4:
 - put property in wdoggrp

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 12 ++++++++++++
 6 files changed, 77 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 9d7ab6c..1340e27 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -228,6 +228,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw51xx {
 		pinctrl_enet: enetgrp {
@@ -364,5 +370,11 @@
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 8dd74e9..8cccc4a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -353,6 +353,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw52xx {
 		pinctrl_audmux: audmuxgrp {
@@ -549,5 +555,11 @@
 				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index ec3fe74..5f700cc 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -351,6 +351,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw53xx {
 		pinctrl_audmux: audmuxgrp {
@@ -539,5 +545,11 @@
 				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 367cc49..d19b4cc 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -453,6 +453,17 @@
 	status = "okay";
 };
 
+&wdog1 {
+	status = "disabled";
+};
+
+&wdog2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
 &iomuxc {
 	imx6qdl-gw54xx {
 		pinctrl_audmux: audmuxgrp {
@@ -654,5 +665,11 @@
 				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT3__WDOG2_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 118bea5..4b9fef8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -239,6 +239,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw51xx {
 		pinctrl_flexcan1: flexcan1grp {
@@ -333,5 +339,11 @@
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index f27f184..805e236 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -197,6 +197,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw552x {
 		pinctrl_gpio_leds: gpioledsgrp {
@@ -286,5 +292,11 @@
 				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
 			>;
                 };
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
-- 
1.9.1

