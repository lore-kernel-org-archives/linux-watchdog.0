Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53437 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754486AbdERInB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 18 May 2017 04:43:01 -0400
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v3 1/3] watchdog: bindings: dw_wdt: add reset lines
Date: Thu, 18 May 2017 10:42:36 +0200
Message-Id: <77954d7b338db9956e15298064f21c028c2070f3.1495096910.git-series.s.trumtrar@pengutronix.de>
In-Reply-To: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
References: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
In-Reply-To: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
References: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Document the reset lines holding the watchdog core in reset.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
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
