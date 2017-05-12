Return-path: <str@pengutronix.de>
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 1/3] watchdog: bindings: dw_wdt: add reset lines
Date: Fri, 12 May 2017 15:34:35 +0200
Message-Id: <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
In-Reply-To: <cover.e174fd0fa926fadf54e0f76e07f238bed3e162fc.1494595189.git-series.s.trumtrar@pengutronix.de>
References: <cover.e174fd0fa926fadf54e0f76e07f238bed3e162fc.1494595189.git-series.s.trumtrar@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

Document the reset lines holding the watchdog core in reset.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/watchdog/dw_wdt.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
index 08e16f684f2d..eb0914420c7c 100644
--- a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
@@ -10,6 +10,8 @@ Required Properties:
 Optional Properties:
 
 - interrupts	: The interrupt used for the watchdog timeout warning.
+- resets	: phandle pointing to the system reset controller with
+		line index for the watchdog.
 
 Example:
 
@@ -18,4 +20,5 @@ Example:
 		reg = <0xffd02000 0x1000>;
 		interrupts = <0 171 4>;
 		clocks = <&per_base_clk>;
+		resets = <&rst WDT0_RESET>;
 	};
-- 
git-series 0.9.1
