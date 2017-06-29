Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:43834 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753512AbdF2VkT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Jun 2017 17:40:19 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v6 07/16] Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
Date: Thu, 29 Jun 2017 23:39:42 +0200
Message-Id: <20170629213951.31176-8-hauke@hauke-m.de>
In-Reply-To: <20170629213951.31176-1-hauke@hauke-m.de>
References: <20170629213951.31176-1-hauke@hauke-m.de>
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
 .../devicetree/bindings/mips/lantiq/rcu.txt        | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
new file mode 100644
index 000000000000..9daaed409ee1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -0,0 +1,98 @@
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
+- compatible	: The first and second values must be:
+		  "lantiq,xrx200-rcu", "simple-mfd", "syscon"
+- reg		: The address and length of the system control registers
+
+
+-------------------------------------------------------------------------------
+Example of the RCU bindings on a xRX200 SoC:
+	rcu0: rcu@203000 {
+		compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
+		reg = <0x203000 0x100>;
+		ranges = <0x0 0x203000 0x100>;
+		big-endian;
+
+		gphy0: gphy@20 {
+			compatible = "lantiq,xrx200a2x-gphy";
+			reg = <0x20 0x4>;
+
+			resets = <&reset0 31 30>, <&reset1 7 7>;
+			reset-names = "gphy", "gphy2";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+		};
+
+		gphy1: gphy@68 {
+			compatible = "lantiq,xrx200a2x-gphy";
+			reg = <0x68 0x4>;
+
+			resets = <&reset0 29 28>, <&reset1 6 6>;
+			reset-names = "gphy", "gphy2";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+		};
+
+		reset0: reset-controller@10 {
+			compatible = "lantiq,xrx200-reset";
+			reg = <0x10 4>, <0x14 4>;
+
+			offset-set = <0x10>;
+			offset-status = <0x14>;
+			#reset-cells = <2>;
+		};
+
+		reset1: reset-controller@48 {
+			compatible = "lantiq,xrx200-reset";
+			reg = <0x48 4>, <0x24 4>;
+
+			offset-set = <0x48>;
+			offset-status = <0x24>;
+			#reset-cells = <2>;
+		};
+
+		usb_phy0: usb2-phy@18 {
+			compatible = "lantiq,xrx200-usb2-phy";
+			reg = <0x18 4>, <0x38 4>;
+			status = "disabled";
+
+			offset-phy = <0x18>;
+			offset-ana = <0x38>;
+			resets = <&reset1 4 4>, <&reset0 4 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		usb_phy1: usb2-phy@34 {
+			compatible = "lantiq,xrx200-usb2-phy";
+			reg = <0x34 4>, <0x3C 4>;
+			status = "disabled";
+
+			offset-phy = <0x34>;
+			offset-ana = <0x3C>;
+			resets = <&reset1 5 4>, <&reset0 4 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		reboot@10 {
+			compatible = "syscon-reboot";
+			reg = <0x10 4>;
+
+			regmap = <&rcu0>;
+			offset = <0x10>;
+			mask = <0x40000000>;
+		};
+	};
+
-- 
2.11.0

