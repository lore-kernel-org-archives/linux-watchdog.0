Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-by2on0105.outbound.protection.outlook.com ([207.46.100.105]:43170
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753429AbbJNLmj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Oct 2015 07:42:39 -0400
From: Zhiqiang Hou <B48286@freescale.com>
To: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <mark.rutland@arm.com>
CC: <Mingkai.Hu@freescale.com>, <Shaohui.Xie@freescale.com>,
	<scottwood@freescale.com>, <bhupesh.sharma@freescale.com>,
	<leoli@freescale.com>, <wsa@the-dreams.de>, <wim@iguana.be>,
	<corbet@lwn.net>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <Wenbin.Song@freescale.com>,
	Hou Zhiqiang <B48286@freescale.com>
Subject: [PATCH V3 6/6] dts/ls1043a: add LS1043ARDB board support
Date: Wed, 14 Oct 2015 19:34:58 +0800
Message-ID: <1444822498-16477-7-git-send-email-B48286@freescale.com>
In-Reply-To: <1444822498-16477-1-git-send-email-B48286@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Shaohui Xie <Shaohui.Xie@freescale.com>

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V3:
 - No change.

V2:
 - Remove the useless compatible "simple-bus" from cpld node.

 arch/arm64/boot/dts/freescale/Makefile            |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 116 ++++++++++++++++++++++
 2 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 57b41c7..33b1e57 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb fsl-ls2080a-rdb.dtb fsl-ls2080a-simu.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb fsl-ls2080a-rdb.dtb fsl-ls2080a-simu.dtb fsl-ls1043a-rdb.dtb
  
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
new file mode 100644
index 0000000..7a351e2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -0,0 +1,116 @@
+/*
+ * Device Tree Include file for Freescale Layerscape-1043A family SoC.
+ *
+ * Copyright 2014-2015, Freescale Semiconductor
+ *
+ * Mingkai Hu <Mingkai.hu@freescale.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "fsl-ls1043a.dtsi"
+
+/ {
+	model = "LS1043A RDB Board";
+};
+
+&i2c0 {
+	status = "okay";
+	ina220@40 {
+		compatible = "ti,ina220";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+	adt7461a@4c {
+		compatible = "adi,adt7461";
+		reg = <0x4c>;
+	};
+	eeprom@56 {
+		compatible = "at24,24c512";
+		reg = <0x52>;
+	};
+	eeprom@57 {
+		compatible = "at24,24c512";
+		reg = <0x53>;
+	};
+	rtc@68 {
+		compatible = "pericom,pt7c4338";
+		reg = <0x68>;
+	};
+};
+
+&ifc {
+	status = "okay";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	/* NOR, NAND Flashes and FPGA on board */
+	ranges = <0x0 0x0 0x0 0x60000000 0x08000000
+		  0x1 0x0 0x0 0x7e800000 0x00010000
+		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
+
+		nor@0,0 {
+			compatible = "cfi-flash";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0x0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		nand@1,0 {
+			compatible = "fsl,ifc-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x1 0x0 0x10000>;
+		};
+
+		cpld: board-control@2,0 {
+			compatible = "fsl,ls1043ardb-cpld";
+			reg = <0x2 0x0 0x0000100>;
+		};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
-- 
2.1.0.27.g96db324

