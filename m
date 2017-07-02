Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46912 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752204AbdGBWlY (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 2 Jul 2017 18:41:24 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v7 05/16] watchdog: lantiq: add device tree binding documentation
Date: Mon,  3 Jul 2017 00:40:40 +0200
Message-Id: <20170702224051.15109-6-hauke@hauke-m.de>
In-Reply-To: <20170702224051.15109-1-hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The binding was not documented before, add the documentation now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
new file mode 100644
index 000000000000..c3967feebb6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
@@ -0,0 +1,24 @@
+Lantiq WTD watchdog binding
+============================
+
+This describes the binding of the Lantiq watchdog driver.
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible		: Should be one of
+				"lantiq,wdt"
+				"lantiq,xrx100-wdt"
+				"lantiq,xrx200-wdt"
+				"lantiq,falcon-wdt"
+- lantiq,rcu		: A phandle to the RCU syscon (required for
+			  "lantiq,falcon-wdt", "lantiq,xrx200-wdt" and
+			  "lantiq,xrx100-wdt")
+
+-------------------------------------------------------------------------------
+Example for the watchdog on the xRX200 SoCs:
+		watchdog@803f0 {
+			compatible = "lantiq,xrx200-wdt", "lantiq,xrx100-wdt";
+			reg = <0x803f0 0x10>;
+
+			lantiq,rcu = <&rcu0>;
+		};
-- 
2.11.0

