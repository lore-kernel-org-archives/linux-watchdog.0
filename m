Return-path: <justinpopo6@gmail.com>
From: Justin Chen <justinpopo6@gmail.com>
To: <linux-kernel@vger.kernel.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux@roeck-us.net>, <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>, Justin
 Chen <justinpopo6@gmail.com>
Subject: [PATCH v3 1/2] watchdog: bcm7038: add device tree binding documentation
Date: Mon, 31 Aug 2015 11:02:42 -0700
Message-ID: <1441044163-16563-2-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1441044163-16563-1-git-send-email-justinpopo6@gmail.com>
References: <1441044163-16563-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Add device tree binding documentation for the watchdog hardware block
on bcm7038 and newer SoCs.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
new file mode 100644
index 0000000..39e5cf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
@@ -0,0 +1,19 @@
+BCM7038 Watchdog timer
+
+Required properties:
+
+- compatible : should be "brcm,bcm7038-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Optional properties:
+
+- clocks: The clock running the watchdog. If no clock is found the
+	  driver will default to 27000000 HZ.
+
+Example:
+
+watchdog {
+	compatible = "brcm,bcm7038-wdt";
+	clocks = <&upg_fixed>;
+	reg = <0xf040a7e8 0x16>;
+};
-- 
2.1.0
