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
Subject: [PATCH 08/10] gpio: ptxpmb-cpld: Document bindings of PTXPMB's CPLD GPIO
Date: Fri,  7 Oct 2016 18:17:29 +0300
Message-Id: <1475853451-22121-9-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

Add device tree bindings document for the GPIO driver of
Juniper's PTXPMB/NGPMB CPLD.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 .../bindings/gpio/jnx,gpio-ptxpmb-cpld.txt         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/jnx,gpio-ptxpmb-cpld.txt

diff --git a/Documentation/devicetree/bindings/gpio/jnx,gpio-ptxpmb-cpld.txt b/Documentation/devicetree/bindings/gpio/jnx,gpio-ptxpmb-cpld.txt
new file mode 100644
index 0000000..1122021
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/jnx,gpio-ptxpmb-cpld.txt
@@ -0,0 +1,30 @@
+Juniper PTXPMB CPLD GPIO block
+
+Required properties:
+
+- compatible:
+    Must be "jnx,gpio-ptxpmb-cpld"
+
+- #gpio-cells:
+    Should be <2>.  The first cell is the pin number (within the controller's
+    pin space), and the second is used for the following flags:
+	bit[0]: direction (0 = out, 1 = in)
+	bit[1]: init high
+	bit[2]: active low
+
+- gpio-controller:
+    Specifies that the node is a GPIO controller.
+
+Optional properties:
+
+- reg:
+    Address and length of the register set for the device. Usually supplied by
+    the parent MFD driver
+
+Example:
+
+gpio_cpld: cpld_gpio {
+	compatible = "jnx,gpio-ptxpmb-cpld";
+	#gpio-cells = <2>;
+	gpio-controller;
+};
-- 
1.9.1
