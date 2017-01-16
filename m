Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34505 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdAPEUQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 15 Jan 2017 23:20:16 -0500
Received: by mail-pg0-f42.google.com with SMTP id 14so11882706pgg.1
        for <linux-watchdog@vger.kernel.org>; Sun, 15 Jan 2017 20:20:16 -0800 (PST)
From: Baoyou Xie <baoyou.xie@linaro.org>
To: jun.nie@linaro.org, wim@iguana.be, linux@roeck-us.net,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        baoyou.xie@linaro.org, xie.baoyou@zte.com.cn,
        chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Subject: [PATCH v1 1/3] dt: bindings: add documentation for zx2967 family watchdog controller
Date: Mon, 16 Jan 2017 12:19:53 +0800
Message-Id: <1484540395-3335-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds dt-binding documentation for zx2967 family
watchdog controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 .../bindings/watchdog/zte,zx2967-wdt.txt           | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
new file mode 100644
index 0000000..0fe0d40
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
@@ -0,0 +1,29 @@
+ZTE zx2967 Watchdog timer
+
+Required properties:
+
+- compatible : should be one of the following.
+       * zte,zx296718-wdt
+- reg : Specifies base physical address and size of the registers.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- clock-names: "wdtclk" for the watchdog clock.
+- resets : Reference to the reset controller controlling the watchdog
+           controller.
+- reset-names : Must include the following entries:
+       * wdtrst
+
+Optional properties:
+
+- reset-mask-config : Mask and configuare value that be wrote to aon-sysctrl.
+
+Example:
+
+wdt_ares: watchdog@1465000 {
+	compatible = "zte,zx296718-wdt";
+	reg = <0x1465000 0x1000>;
+	clocks = <&topcrm WDT_WCLK>;
+	clock-names = "wdtclk";
+	resets = <&toprst 35>;
+	reset-names = "wdtrst";
+	reset-mask-config = <1 0x115>;
+};
-- 
2.7.4

