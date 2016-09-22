Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60024 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752915AbcIVHEq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Sep 2016 03:04:46 -0400
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] watchdog: bindings: dw_wdt: add reset lines
Date: Thu, 22 Sep 2016 09:02:30 +0200
Message-Id: <1474527753-22194-2-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1474527753-22194-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1474527753-22194-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Document the reset lines holding the watchdog core in reset.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/watchdog/dw_wdt.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
index 08e16f684f2d..3bf386c72241 100644
--- a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
@@ -10,6 +10,9 @@ Required Properties:
 Optional Properties:
 
 - interrupts	: The interrupt used for the watchdog timeout warning.
+- resets	: phandle pointing to the system reset controller with
+		line index for the watchdog.
+- reset-names	: must be set to "dw-wdt".
 
 Example:
 
@@ -18,4 +21,6 @@ Example:
 		reg = <0xffd02000 0x1000>;
 		interrupts = <0 171 4>;
 		clocks = <&per_base_clk>;
+		resets = <&rst WDT0_RESET>;
+		reset-names = "dw-wdt";
 	};
-- 
2.8.1

