Return-Path: <marek.behun@nic.cz>
Return-path: <marek.behun@nic.cz>
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org,
	Guenter Roeck <linux@roeck-us.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: watchdog: Document armada-37xx-wdt binding
Date: Fri,  7 Sep 2018 15:05:51 +0200
Message-Id: <20180907130553.14271-3-marek.behun@nic.cz>
In-Reply-To: <20180907130553.14271-1-marek.behun@nic.cz>
References: <20180907130553.14271-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

This adds device tree binding documentation for the CPU watchdog found
on Armada 37xx SOCs (EspressoBin, Turris Mox).

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../bindings/watchdog/armada-37xx-wdt.txt          | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
new file mode 100644
index 000000000000..4ba9e40ad386
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
@@ -0,0 +1,23 @@
+* Armada 37xx CPU Watchdog Timer Controller
+
+Required properties:
+- compatible : must be "marvell,armada-3700-wdt"
+- reg : base physical address of the controller and length of memory mapped
+	region.
+- clocks : the clock feeding the watchdog timer. See clock-bindings.txt
+- marvell,system-controller : reference to syscon node for the CPU Miscellaneous
+	Registers
+
+Example:
+
+	cpu_misc: system-controller@d000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0xd000 0x1000>;
+	};
+
+	wdt: watchdog-timer@8300 {
+		compatible = "marvell,armada-3700-wdt";
+		reg = <0x8300 0x40>;
+		marvell,system-controller = <&cpu_misc>;
+		clocks = <&xtalclk>;
+	};
-- 
2.16.4
