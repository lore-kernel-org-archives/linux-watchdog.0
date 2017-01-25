Return-path: <baoyou.xie@linaro.org>
From: Baoyou Xie <baoyou.xie@linaro.org>
To: jun.nie@linaro.org,
	wim@iguana.be,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	baoyou.xie@linaro.org,
	xie.baoyou@zte.com.cn,
	chen.chaokai@zte.com.cn,
	wang.qiang01@zte.com.cn
Subject: [PATCH v6 1/3] dt: bindings: add documentation for zx2967 family watchdog controller
Date: Wed, 25 Jan 2017 10:44:47 +0800
Message-Id: <1485312289-18354-1-git-send-email-baoyou.xie@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

This patch adds dt-binding documentation for zx2967 family
watchdog controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/watchdog/zte,zx2967-wdt.txt           | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
new file mode 100644
index 0000000..06ce677
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
@@ -0,0 +1,32 @@
+ZTE zx2967 Watchdog timer
+
+Required properties:
+
+- compatible : should be one of the following.
+       * zte,zx296718-wdt
+- reg : Specifies base physical address and size of the registers.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- resets : Reference to the reset controller controlling the watchdog
+           controller.
+
+Optional properties:
+
+- timeout-sec : Contains the watchdog timeout in seconds.
+- zte,wdt-reset-sysctrl : Directs how to reset system by the watchdog.
+	if we don't want to restart system when watchdog been triggered,
+	it's not required, vice versa.
+	It should include following fields.
+	  * phandle of aon-sysctrl.
+	  * offset of register that be written, should be 0xb0.
+	  * configure value that be written to aon-sysctrl.
+	  * bit mask, corresponding bits will be affected.
+
+Example:
+
+wdt: watchdog@1465000 {
+	compatible = "zte,zx296718-wdt";
+	reg = <0x1465000 0x1000>;
+	clocks = <&topcrm WDT_WCLK>;
+	resets = <&toprst 35>;
+	zte,wdt-reset-sysctrl = <&aon_sysctrl 0xb0 1 0x115>;
+};
-- 
2.7.4
