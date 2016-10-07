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
Subject: [PATCH 04/10] watchdog: ptxpmb-wdt: Add ptxpmb-wdt device tree bindings
Date: Fri,  7 Oct 2016 18:17:25 +0300
Message-Id: <1475853451-22121-5-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

Add binding document for the watchdog driver of PTXPMB CPLD.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 .../devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt b/Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt
new file mode 100644
index 0000000..34b64f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt
@@ -0,0 +1,17 @@
+Juniper's PTXPMB FPGA watchdog driver
+
+Required properties:
+
+- compatible:	Should be "jnx,ptxpmb-wdt"
+
+Optional properties:
+
+- reg : Specifies base physical address and size of the registers. It is
+  optional since the MFD parent driver supplies it, but can be overridden.
+
+Example:
+
+wdt {
+	compatible = "jnx,ptxpmb-wdt";
+	/* no properties defined */
+};
-- 
1.9.1
