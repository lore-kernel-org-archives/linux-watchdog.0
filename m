Return-path: <simon@fire.lp0.eu>
Subject: [PATCH 03/11] watchdog: Add brcm,bcm6345-wdt device tree binding
To: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>
References: <565D9A40.60409@simon.arlott.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 MIPS Mailing List <linux-mips@linux-mips.org>,
 Jonas Gorski <jogo@openwrt.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Kevin Cernekee <cernekee@gmail.com>,
 Wim Van Sebroeck <wim@iguana.be>, Maxime Bizon <mbizon@freebox.fr>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565D9AB3.2060504@simon.arlott.org.uk>
Date: Tue, 1 Dec 2015 13:03:47 +0000
MIME-Version: 1.0
In-Reply-To: <565D9A40.60409@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Add device tree binding for the BCM6345 watchdog.

This uses the BCM6345 timer for its warning interrupt.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/watchdog/brcm,bcm6345-wdt.txt         | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt
new file mode 100644
index 0000000..9d852d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm6345-wdt.txt
@@ -0,0 +1,35 @@
+BCM6345 Watchdog timer
+
+Required properties:
+
+- compatible: should be "brcm,bcm63<soc>-wdt", "brcm,bcm6345-wdt"
+- reg: Specifies base physical address and size of the registers.
+- clocks: Specify the clock used for timing
+
+Optional properties:
+
+- interrupt-parent: phandle to the interrupt controller
+- interrupts: Specify the interrupt used for the watchdog timout warning
+- timeout-sec: Contains the default watchdog timeout in seconds
+
+Example:
+
+watchdog {
+	compatible = "brcm,bcm63168-wdt", "brcm,bcm6345-wdt";
+	reg = <0x1000009c 0x0c>;
+	clocks = <&periph_clk>;
+
+	interrupt-parent = <&timer>;
+	interrupts = <3>;
+	timeout-sec = <30>;
+};
+
+watchdog {
+	compatible = "brcm,bcm6318-wdt", "brcm,bcm6345-wdt";
+	reg = <0x10000068 0x0c>;
+	clocks = <&periph_clk>;
+
+	interrupt-parent = <&timer>;
+	interrupts = <3>;
+	timeout-sec = <30>;
+};
-- 
2.1.4


-- 
Simon Arlott
