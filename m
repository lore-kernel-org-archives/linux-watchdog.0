Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50761 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbdE1Sk3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 28 May 2017 14:40:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 05/16] watchdog: lantiq: add device tree binding documentation
Date: Sun, 28 May 2017 20:39:55 +0200
Message-Id: <20170528184006.31668-6-hauke@hauke-m.de>
In-Reply-To: <20170528184006.31668-1-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The binding was not documented before, add the documentation now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
new file mode 100644
index 000000000000..675c30e23b65
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
@@ -0,0 +1,28 @@
+Lantiq WTD watchdog binding
+============================
+
+This describes the binding of the Lantiq watchdog driver.
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible		: Should be one of
+				"lantiq,wdt"
+				"lantiq,wdt-xrx100"
+				"lantiq,wdt-falcon"
+
+Optional properties:
+- regmap		: A phandle to the RCU syscon
+- offset-status		: Offset of the reset cause register
+- mask-status		: Mask of the reset cause register value
+
+
+-------------------------------------------------------------------------------
+Example for the watchdog on the xRX200 SoCs:
+		watchdog@803F0 {
+			compatible = "lantiq,wdt-xrx200", "lantiq,wdt-xrx100";
+			reg = <0x803F0 0x10>;
+
+			regmap = <&rcu0>;
+			offset-status = <0x14>;
+			mask-status = <0x80000000>;
+		};
-- 
2.11.0

