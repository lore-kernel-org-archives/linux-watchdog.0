Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56611 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754500AbbG3AW0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 20:22:26 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 02/20] Documentation: watchdog: at91sam9_wdt: add clocks property
Date: Thu, 30 Jul 2015 02:21:48 +0200
Message-Id: <1438215726-27452-3-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog has an input clock, the slow clock. It is required as it will
not function without it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index a4d869744f59..86fa6de1019b 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 - compatible: must be "atmel,at91sam9260-wdt".
 - reg: physical base address of the controller and length of memory mapped
   region.
+- clocks: phandle to input clock.
 
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
@@ -39,6 +40,7 @@ Example:
 		compatible = "atmel,at91sam9260-wdt";
 		reg = <0xfffffd40 0x10>;
 		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		clocks = <&clk32k>;
 		timeout-sec = <15>;
 		atmel,watchdog-type = "hardware";
 		atmel,reset-type = "all";
-- 
2.1.4

