Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36645 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbdEUNJs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 21 May 2017 09:09:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 06/15] Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
Date: Sun, 21 May 2017 15:09:09 +0200
Message-Id: <20170521130918.27446-7-hauke@hauke-m.de>
In-Reply-To: <20170521130918.27446-1-hauke@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This adds the initial documentation for the RCU module (a MFD device
which provides USB PHYs, reset controllers and more).

The RCU register range is used for multiple purposes. Mostly one device
uses one or multiple register exclusively, but for some registers some
bits are for one driver and some other bits are for a different driver.
With this patch all accesses to the RCU registers will go through
syscon.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/mips/lantiq/rcu.txt        | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
new file mode 100644
index 000000000000..118d04fca582
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -0,0 +1,84 @@
+Lantiq XWAY SoC RCU binding
+===========================
+
+This binding describes the RCU (reset controller unit) multifunction device,
+where each sub-device has it's own set of registers.
+
+The RCU register range is used for multiple purposes. Mostly one device
+uses one or multiple register exclusively, but for some registers some
+bits are for one driver and some other bits are for a different driver.
+With this patch all accesses to the RCU registers will go through
+syscon.
+
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible	: The first and second values must be: "simple-mfd", "syscon"
+- reg		: The address and length of the system control registers
+
+
+-------------------------------------------------------------------------------
+Example of the RCU bindings on a xRX200 SoC:
+	rcu0: rcu@203000 {
+		compatible = "lantiq,rcu-xrx200", "simple-mfd", "syscon";
+		reg = <0x203000 0x100>;
+		big-endian;
+
+		gphy0: gphy@0 {
+			compatible = "lantiq,xrx200a2x-rcu-gphy";
+			lantiq,rcu-syscon = <&rcu0 0x20>;
+			resets = <&reset0 31 30>;
+			reset-names = "gphy";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
+			clock-names = "gphy";
+		};
+
+		gphy1: gphy@1 {
+			compatible = "lantiq,xrx200a2x-rcu-gphy";
+			lantiq,rcu-syscon = <&rcu0 0x68>;
+			resets = <&reset0 29 28>;
+			reset-names = "gphy";
+			lantiq,gphy-mode = <GPHY_MODE_FE>;
+			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
+			clock-names = "gphy";
+		};
+
+		reset0: reset@0 {
+			compatible = "lantiq,rcu-reset";
+			lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
+			#reset-cells = <2>;
+		};
+
+		reset1: reset@1 {
+			compatible = "lantiq,rcu-reset";
+			lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
+			#reset-cells = <2>;
+		};
+
+		usb_phy0: usb2-phy@0 {
+			compatible = "lantiq,xrx200-rcu-usb2-phy";
+
+			lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
+			resets = <&reset1 4 4>, <&reset0 4 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		usb_phy1: usb2-phy@1 {
+			compatible = "lantiq,xrx200-rcu-usb2-phy";
+
+			lantiq,rcu-syscon = <&rcu0 0x34 0x3C>;
+			resets = <&reset1 5 5>, <&reset0 4 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&rcu0>;
+			offset = <0x10>;
+			mask = <0x40000000>;
+		};
+	};
+
-- 
2.11.0

