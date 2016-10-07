Return-path: <pantelis.antoniou@konsulko.com>
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Rosin <peda@axentia.se>,
	Debjit Ghosh <dghosh@juniper.net>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <groeck@juniper.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 02/10] mfd: ptxpmb-cpld: Add documentation for PTXPMB CPLD
Date: Fri,  7 Oct 2016 18:17:23 +0300
Message-Id: <1475853451-22121-3-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

Add DT bindings document for the PTXPMB CPLD MFD device.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 .../devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt

diff --git a/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt b/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
new file mode 100644
index 0000000..cc3cbb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
@@ -0,0 +1,76 @@
+* Device tree bindings for Juniper's PTXPMB CPLD FPGA MFD driver
+
+The device supports a number I2C muxes, hardware watchdog and a gpio block.
+Those devices bindings are described in the jnx-i2c-mux-ptxpmb-cpld,
+jnx-ptxpmb-wdt and jnx-gpio-ptxpmb-cpld documents.
+
+Required properties:
+
+- compatible:		"jnx,ptxpmb-cpld", "jnx,ngpmb-bcpld". They differ
+			in the i2c-mux blocks.
+
+- reg:			contains offset/length value for device state control
+			registers space.
+
+Optional properties:
+
+- interrupts:		The interrupt line(s) the /IRQ signal(s) for the device is
+			connected to.
+
+- interrupt-parent:	The parent interrupt controller.
+
+Example:
+
+cpld@0,0 {
+	compatible = "jnx,ptxpmb-cpld";
+	reg = <0x0 0 0x10000>;
+
+	cpld-i2c-mux {
+		compatible = "jnx,i2c-mux-ptxpmb-cpld";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c-parent = <&i2c_master_0>;
+
+		num-enable = <1>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PMB devices are accessed through FPC */
+
+			temp-sensor@1a { /* FPC */
+				compatible = "maxim,max6697";
+				reg = <0x1a>;
+				smbus-timeout-disable;
+				resistance-cancellation;
+				alert-mask = <0xff>;
+				over-temperature-mask = <0xff>;
+			};
+		};
+
+		pic0i2c: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PIC 0 */
+		};
+
+		pic1i2c: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PIC 1 */
+		};
+	};
+
+	gpio_cpld: cpld_gpio {
+		compatible = "jnx,gpio-ptxpmb-cpld";
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
-- 
1.9.1
