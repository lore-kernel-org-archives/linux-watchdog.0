Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49276 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756402AbdDQTaH (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Apr 2017 15:30:07 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/13] Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
Date: Mon, 17 Apr 2017 21:29:41 +0200
Message-Id: <20170417192942.32219-13-hauke@hauke-m.de>
In-Reply-To: <20170417192942.32219-1-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This adds the initial documentation for the RCU module (a MFD device
which provides USB PHYs, reset controllers and more).

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/mips/lantiq/rcu.txt        | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
new file mode 100644
index 000000000000..9e5b1e7493e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -0,0 +1,82 @@
+Lantiq XWAY SoC RCU binding
+===========================
+
+This binding describes the RCU (reset controller unit) multifunction device,
+where each sub-device has it's own set of registers.
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
+		compatible = "simple-mfd", "syscon";
+		reg = <0x203000 0x100>;
+		big-endian;
+
+		gphy0: rcu_gphy@0 {
+			compatible = "lantiq,xrx200a2x-rcu-gphy";
+			lantiq,rcu-syscon = <&rcu0 0x20>;
+			resets = <&rcu_reset0 31>;
+			reset-names = "gphy";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
+			clock-names = "gphy";
+		};
+
+		gphy1: rcu_gphy@1 {
+			compatible = "lantiq,xrx200a2x-rcu-gphy";
+			lantiq,rcu-syscon = <&rcu0 0x68>;
+			resets = <&rcu_reset0 29>;
+			reset-names = "gphy";
+			lantiq,gphy-mode = <GPHY_MODE_FE>;
+			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
+			clock-names = "gphy";
+		};
+
+		rcu_reset0: rcu_reset@0 {
+			compatible = "lantiq,rcu-reset";
+			lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
+			#reset-cells = <1>;
+			reset-request = <31>, <29>, <21>, <19>, <16>, <12>;
+			reset-status  = <30>, <28>, <16>, <25>, <5>,  <24>;
+		};
+
+		rcu_reset1: rcu_reset@1 {
+			compatible = "lantiq,rcu-reset";
+			lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
+			#reset-cells = <1>;
+		};
+
+		usb_phys0: rcu-usb2-phy@0 {
+			compatible = "lantiq,xrx200-rcu-usb2-phy";
+
+			lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
+			resets = <&rcu_reset1 4>, <&rcu_reset0 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		usb_phys1: rcu-usb2-phy@1 {
+			compatible = "lantiq,xrx200-rcu-usb2-phy";
+
+			lantiq,rcu-syscon = <&rcu0 0x34 0x3C>;
+			resets = <&rcu_reset1 5>, <&rcu_reset0 4>;
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
+
+		/* more sub-device nodes (USB PHY, etc.) */
+	};
+
-- 
2.11.0

