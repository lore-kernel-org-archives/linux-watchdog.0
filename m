Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.nic.cz ([217.31.204.67]:60338 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeIDOXJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Sep 2018 10:23:09 -0400
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v2 2/4] dt-bindings: watchdog: Document armada-37xx-wdt binding
Date: Tue,  4 Sep 2018 11:56:25 +0200
Message-Id: <20180904095627.25552-2-marek.behun@nic.cz>
In-Reply-To: <20180904095627.25552-1-marek.behun@nic.cz>
References: <20180904095627.25552-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds device tree binding documentation for the CPU watchdog found
on Armada 37xx SOCs (EspressoBin, Turris Mox).

Signed-off-by: Marek Behún <marek.behun@nic.cz>
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
