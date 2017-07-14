Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:52908 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdGNUJI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 16:09:08 -0400
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, shawnguo@kernel.org
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v4 3/8] dt-bindings: bus: Add documentation for the Technologic Systems NBUS
Date: Fri, 14 Jul 2017 16:08:48 -0400
Message-Id: <20170714200853.10362-4-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add binding documentation for the Technologic Systems NBUS that is used
to interface with peripherals in the FPGA of the TS-4600 SoM.

---
Changes v3 -> v4:
  - rebase on master
  - fix vendor prefixes for dts properties (suggested by Rob Herring)
  - v3 was acked by Linus Walleij

Changes v2 -> v3:
  - rebase on master
  - fix typo (suggested by Rob Herring)

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
index 000000000000..2a10d065b9fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ts-nbus.txt
@@ -0,0 +1,50 @@
+Technologic Systems NBUS
+
+The NBUS is a bus used to interface with peripherals in the Technologic
+Systems FPGA on the TS-4600 SoM.
+
+Required properties :
+ - compatible		: "technologic,ts-nbus"
+ - #address-cells	: must be 1
+ - #size-cells		: must be 0
+ - pwms			: The PWM bound to the FPGA
+ - ts,data-gpios	: The 8 GPIO pins connected to the data lines on the FPGA
+ - ts,csn-gpios		: The GPIO pin connected to the csn line on the FPGA
+ - ts,txrx-gpios	: The GPIO pin connected to the txrx line on the FPGA
+ - ts,strobe-gpios	: The GPIO pin connected to the stobe line on the FPGA
+ - ts,ale-gpios		: The GPIO pin connected to the ale line on the FPGA
+ - ts,rdy-gpios		: The GPIO pin connected to the rdy line on the FPGA
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
+
+		watchdog@2a {
+			compatible = "...";
+
+			/* ... */
+		};
+	};
-- 
2.13.0

