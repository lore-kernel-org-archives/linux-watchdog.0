Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:49186 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdBCTrd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Feb 2017 14:47:33 -0500
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com,
        horms+renesas@verge.net.au, treding@nvidia.com,
        jonathanh@nvidia.com, f.fainelli@gmail.com, kernel@pengutronix.de,
        shawnguo@kernel.org, linux@armlinux.org.uk, wim@iguana.be,
        mark.rutland@arm.com, damien.riegel@savoirfairelinux.com,
        lucile.quirion@savoirfairelinux.com, olof@lixom.net, arnd@arndb.de,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v2 3/6] dt-bindings: bus: Add documentation for the Technologic Systems NBUS
Date: Fri,  3 Feb 2017 14:47:26 -0500
Message-Id: <20170203194729.20995-4-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add binding documentation for the Technologic Systems NBUS that is used
to interface with peripherals in the FPGA of the TS-4600 SoM.

---
Changes v1 -> v2:
  - rebase on master
  - remove the simple-bus compatibility as the root node will now
  populate child nodes (suggested by Rob Herring)
  - use the ts vendor prefix for gpios (suggested by Rob Herring)

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/bus/ts-nbus.txt | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt

diff --git a/Documentation/devicetree/bindings/bus/ts-nbus.txt b/Documentation/devicetree/bindings/bus/ts-nbus.txt
new file mode 100644
index 000000000000..c8a1f2cbe6a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ts-nbus.txt
@@ -0,0 +1,50 @@
+Technologic Systems NBUS
+
+The NBUS is a bus used to interface with peripherals in the Technologic
+Systems FPGA on the TS-4600 SoM.
+
+Required properties :
+ - compatible     : "technologic,ts-nbus"
+ - #address-cells : must be 1
+ - #size-cells    : must be 0
+ - pws            : The PWM binded to the FPGA
+ - data-gpios	  : The GPIO pin connected to the data line on the FPGA
+ - csn-gpios	  : The GPIO pin connected to the csn line on the FPGA
+ - txrx-gpios	  : The GPIO pin connected to the txrx line on the FPGA
+ - strobe-gpios	  : The GPIO pin connected to the stobe line on the FPGA
+ - ale-gpios	  : The GPIO pin connected to the ale line on the FPGA
+ - rdy-gpios	  : The GPIO pin connected to the rdy line on the FPGA
+
+Child nodes:
+
+The NBUS node can contain zero or more child nodes representing peripherals
+on the bus.
+
+Example:
+
+	nbus {
+		compatible = "technologic,ts-nbus";
+		pinctrl-0 = <&nbus_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pwms = <&pwm 2 83>;
+		ts-data-gpios   = <&gpio0 0 GPIO_ACTIVE_HIGH
+				   &gpio0 1 GPIO_ACTIVE_HIGH
+				   &gpio0 2 GPIO_ACTIVE_HIGH
+				   &gpio0 3 GPIO_ACTIVE_HIGH
+				   &gpio0 4 GPIO_ACTIVE_HIGH
+				   &gpio0 5 GPIO_ACTIVE_HIGH
+				   &gpio0 6 GPIO_ACTIVE_HIGH
+				   &gpio0 7 GPIO_ACTIVE_HIGH>;
+		ts-csn-gpios    = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		ts-txrx-gpios   = <&gpio0 24 GPIO_ACTIVE_HIGH>;
+		ts-strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
+		ts-ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+		ts-rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+
+		watchdog@2a {
+			compatible = "...";
+
+			/* ... */
+		};
+	};
-- 
2.11.0

