Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.nic.cz ([217.31.204.67]:55349 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeIXRLX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Sep 2018 13:11:23 -0400
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: watchdog: Document armada-37xx-wdt binding
Date: Mon, 24 Sep 2018 13:06:52 +0200
Message-Id: <20180924110654.7329-3-marek.behun@nic.cz>
In-Reply-To: <20180924110654.7329-1-marek.behun@nic.cz>
References: <20180924110654.7329-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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
index 000000000000..a8d00c31a1d8
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
+		compatible = "marvell,armada-3700-cpu-misc", "syscon";
+		reg = <0xd000 0x1000>;
+	};
+
+	wdt: watchdog@8300 {
+		compatible = "marvell,armada-3700-wdt";
+		reg = <0x8300 0x40>;
+		marvell,system-controller = <&cpu_misc>;
+		clocks = <&xtalclk>;
+	};
-- 
2.16.4
