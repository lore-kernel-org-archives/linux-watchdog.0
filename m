Return-path: <pantelis.antoniou@konsulko.com>
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jean Delvare <jdelvare@suse.com>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 4/7] watchdog: ptx1kbf-wdt: Add ptx1kbf device tree bindings
Date: Fri,  7 Oct 2016 18:22:01 +0300
Message-Id: <1475853724-22557-5-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

Add binding document for the watchdog driver of PTX1K Boot FPGA.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 .../devicetree/bindings/watchdog/jnx-ptx1kbf-wdt.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/jnx-ptx1kbf-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/jnx-ptx1kbf-wdt.txt b/Documentation/devicetree/bindings/watchdog/jnx-ptx1kbf-wdt.txt
new file mode 100644
index 0000000..0aa8086
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/jnx-ptx1kbf-wdt.txt
@@ -0,0 +1,17 @@
+Juniper's PTX1K Boot FPGA watchdog driver
+
+Required properties:
+
+- compatible:	Should be "jnx,ptx1kbf-wdt"
+
+Optional properties:
+
+- reg : Specifies base physical address and size of the registers. It is
+  optional since the MFD parent driver supplies it, but can be overridden.
+
+Example:
+
+wdt {
+	compatible = "jnx,ptx1kbf-wdt";
+	/* no properties defined */
+};
-- 
1.9.1
