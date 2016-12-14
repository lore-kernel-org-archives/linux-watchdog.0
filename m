Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:44938 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934118AbcLNXMv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Dec 2016 18:12:51 -0500
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com
Cc: mark@embeddedarm.com, kris@embeddedarm.com,
        horms+renesas@verge.net.au, treding@nvidia.com,
        jonathanh@nvidia.com, f.fainelli@gmail.com, fabio.estevam@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org, linux@armlinux.org.uk,
        linux@roeck-us.net, wim@iguana.be, mark.rutland@arm.com,
        robh+dt@kernel.org, damien.riegel@savoirfairelinux.com,
        lucile.quirion@savoirfairelinux.com, olof@lixom.net, arnd@arndb.de,
        suzuki.poulose@arm.com, linus.walleij@linaro.org,
        will.deacon@arm.com, yamada.masahiro@socionext.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH 5/6] ARM: dts: TS-4600: add NBUS support
Date: Wed, 14 Dec 2016 18:12:35 -0500
Message-Id: <20161214231237.17496-6-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit enables the NBUS on the TS-4600, using the ts-nbus driver.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx28-ts4600-common.dtsi | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-ts4600-common.dtsi b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
index 04bd5a5..b668933 100644
--- a/arch/arm/boot/dts/imx28-ts4600-common.dtsi
+++ b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
@@ -44,6 +44,28 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				nbus_pins: nbus_pins {
+					fsl,pinmux-ids = <
+						MX28_PAD_GPMI_D00__GPIO_0_0
+						MX28_PAD_GPMI_D01__GPIO_0_1
+						MX28_PAD_GPMI_D02__GPIO_0_2
+						MX28_PAD_GPMI_D03__GPIO_0_3
+						MX28_PAD_GPMI_D04__GPIO_0_4
+						MX28_PAD_GPMI_D05__GPIO_0_5
+						MX28_PAD_GPMI_D06__GPIO_0_6
+						MX28_PAD_GPMI_D07__GPIO_0_7
+						MX28_PAD_GPMI_CE0N__GPIO_0_16
+						MX28_PAD_GPMI_RDY1__GPIO_0_21
+						MX28_PAD_GPMI_RDN__GPIO_0_24
+						MX28_PAD_GPMI_WRN__GPIO_0_25
+						MX28_PAD_GPMI_ALE__GPIO_0_26
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+
+				};
+
 			};
 		};
 
@@ -75,4 +97,25 @@
 		};
 	};
 
+	nbus {
+		compatible = "technologic,ts-nbus", "simple-bus";
+		pinctrl-0 = <&nbus_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pwms = <&pwm 2 83>;
+		data-gpios   = <&gpio0 0 GPIO_ACTIVE_HIGH
+				&gpio0 1 GPIO_ACTIVE_HIGH
+				&gpio0 2 GPIO_ACTIVE_HIGH
+				&gpio0 3 GPIO_ACTIVE_HIGH
+				&gpio0 4 GPIO_ACTIVE_HIGH
+				&gpio0 5 GPIO_ACTIVE_HIGH
+				&gpio0 6 GPIO_ACTIVE_HIGH
+				&gpio0 7 GPIO_ACTIVE_HIGH>;
+		csn-gpios    = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		txrx-gpios   = <&gpio0 24 GPIO_ACTIVE_HIGH>;
+		strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
+		ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+		rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+	};
+
 };
-- 
2.10.2

