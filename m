Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:52944 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbdGNUJJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 16:09:09 -0400
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, shawnguo@kernel.org
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v4 5/8] ARM: dts: TS-4600: add NBUS support
Date: Fri, 14 Jul 2017 16:08:50 -0400
Message-Id: <20170714200853.10362-6-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit enables the NBUS on the TS-4600, using the ts-nbus driver.

---
Changes v3 -> v4:
  - rebase on master
  - fix vendor prefixes for dts properties (suggested by Rob Herring)
  - v3 was acked by Linus Walleij

Changes v2 -> v3:
  - rebase on master

Changes v1 -> v2:
  - rebase on master
  - remove the simple-bus compatibility as the root node will now
  populate the child nodes (suggested by Rob Herring)
  - add the vendor prefix to all gpio (suggested by Rob Herring)

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx28-ts4600-common.dtsi | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-ts4600-common.dtsi b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
index 04bd5a5c0cb4..a90bd934e4a3 100644
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
+		compatible = "technologic,ts-nbus";
+		pinctrl-0 = <&nbus_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pwms = <&pwm 2 83>;
+		ts,data-gpios   = <&gpio0 0 GPIO_ACTIVE_HIGH
+				   &gpio0 1 GPIO_ACTIVE_HIGH
+				   &gpio0 2 GPIO_ACTIVE_HIGH
+				   &gpio0 3 GPIO_ACTIVE_HIGH
+				   &gpio0 4 GPIO_ACTIVE_HIGH
+				   &gpio0 5 GPIO_ACTIVE_HIGH
+				   &gpio0 6 GPIO_ACTIVE_HIGH
+				   &gpio0 7 GPIO_ACTIVE_HIGH>;
+		ts,csn-gpios    = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		ts,txrx-gpios   = <&gpio0 24 GPIO_ACTIVE_HIGH>;
+		ts,strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
+		ts,ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+		ts,rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+	};
+
 };
-- 
2.13.0

