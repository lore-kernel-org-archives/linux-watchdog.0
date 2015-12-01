Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:58730 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997AbbLANCL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Dec 2015 08:02:11 -0500
To: Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>
From: Simon Arlott <simon@fire.lp0.eu>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	MIPS Mailing List <linux-mips@linux-mips.org>,
	Jonas Gorski <jogo@openwrt.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: [PATCH 01/11] clocksource: Add brcm,bcm6345-timer/brcm,bcm6318-timer
 device tree binding
Message-ID: <565D9A40.60409@simon.arlott.org.uk>
Date: Tue, 1 Dec 2015 13:01:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add device tree bindings for the BCM6345/BCM6318 timers. This is required
for the BCM6345 watchdog which needs to respond to one of the timer
interrupts.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timer/brcm,bcm6318-timer.txt          | 44 ++++++++++++++++++++
 .../bindings/timer/brcm,bcm6345-timer.txt          | 47 ++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
new file mode 100644
index 0000000..cf4be7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
@@ -0,0 +1,44 @@
+Broadcom BCM6318 Timer
+
+This block is a timer that is connected to multiple interrupts on the main
+interrupt controller and functions as a programmable interrupt controller for
+timer events. There is a main timer interrupt for all timers.
+
+- 4 independent timers with their own interrupt, and own maskable level
+  interrupt bit in the main timer interrupt
+
+- 1 watchdog timer with an unmaskable level interrupt bit in the main timer
+  interrupt
+
+- Contains one enable/status word pair
+
+- No atomic set/clear operations
+
+Required properties:
+
+- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6318-timer"
+- reg: specifies the base physical address and size of the registers, excluding
+  the watchdog registers
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 1.
+- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
+  this one is cascaded from
+- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
+  node for the main timer interrupt, followed by the individual timer
+  interrupts; valid values depend on the type of parent interrupt controller
+- clocks: phandle of timer reference clock (periph)
+
+Example:
+
+timer: timer@10000040 {
+	compatible = "brcm,bcm63148-timer", "brcm,bcm6318-timer";
+	reg = <0x10000040 0x28>;
+
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	interrupt-parent = <&periph_intc>;
+	interrupts = <31>, <0>, <1>, <2>, <3>;
+	clock = <&periph_osc>;
+};
diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
new file mode 100644
index 0000000..03250dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
@@ -0,0 +1,47 @@
+Broadcom BCM6345 Timer
+
+This block is a timer that is connected to one interrupt on the main interrupt
+controller and functions as a programmable interrupt controller for timer
+events.
+
+- 3 independent timers with their own maskable level interrupt bit (but not
+  per CPU because there is only one parent interrupt and the timers share it)
+
+- 1 watchdog timer with an unmaskable level interrupt
+
+- Contains one enable/status word pair
+
+- No atomic set/clear operations
+
+The lack of per CPU ability of timers makes them unusable as a set of
+clockevent devices, otherwise they could be attached to the remaining
+interrupts.
+
+Required properties:
+
+- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6345-timer"
+- reg: specifies the base physical address and size of the registers, excluding
+  the watchdog registers
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 1.
+- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
+  this one is cascaded from
+- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
+  node for the timer interrupt; valid values depend on the type of parent
+  interrupt controller
+- clocks: phandle of timer reference clock (periph)
+
+Example:
+
+timer: timer@10000080 {
+	compatible = "brcm,bcm63168-timer", "brcm,bcm6345-timer";
+	reg = <0x10000080 0x1c>;
+
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	interrupt-parent = <&periph_intc>;
+	interrupts = <0>;
+	clock·=·<&periph_osc>;
+};
-- 
2.1.4

-- 
Simon Arlott
