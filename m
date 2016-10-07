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
Subject: [PATCH 2/7] mfd: dt-bindings: Add bindings for the Juniper PTX1K Boot FPGA
Date: Fri,  7 Oct 2016 18:21:59 +0300
Message-Id: <1475853724-22557-3-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

Add device tree bindings for the Juniper PTX1K Boot FPGA MFD driver.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 .../devicetree/bindings/mfd/jnx-ptx1k-bootfpga.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/jnx-ptx1k-bootfpga.txt

diff --git a/Documentation/devicetree/bindings/mfd/jnx-ptx1k-bootfpga.txt b/Documentation/devicetree/bindings/mfd/jnx-ptx1k-bootfpga.txt
new file mode 100644
index 0000000..596dec7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/jnx-ptx1k-bootfpga.txt
@@ -0,0 +1,34 @@
+* Device tree bindings for Juniper's PTX1K boot FPGA MFD driver
+
+The device supports a hardware watchdog, a flash MTD device and
+a hwmon sensor device. The bindings of those drivers are described
+in the jnx-ptx1kbf-wdt, jnx-ptx1kbf-mtd and jnx-ptx1kbf-hwmon documents.
+
+Required properties:
+
+- compatible:		"ptx1k-bootfpga"
+
+- reg:			contains offset/length value for device state control
+			registers space.
+
+Example:
+
+bootfpga@10000 {
+	compatible = "jnx,ptx1k-bootfpga";
+	reg = <0x10000 0x100>;
+
+	wdt {
+		compatible = "jnx,ptx1kbf-wdt";
+		/* no properties required */
+	};
+
+	mtd {
+		compatible = "jnx,ptx1kbf-mtd";
+		/* use the full device */
+	};
+
+	hwmon {
+		compatible = "jnx,ptx1kbf-hwmon";
+		/* no properties required */
+	};
+};
-- 
1.9.1
