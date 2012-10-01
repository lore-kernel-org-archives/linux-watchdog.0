Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56154 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2JAMYv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 1 Oct 2012 08:24:51 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so4894647bkc.19
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Oct 2012 05:24:50 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v6 2/5] watchdog: orion_wdt: dt: add the timeout property binding
Date: Mon,  1 Oct 2012 14:24:38 +0200
Message-Id: <1349094281-28889-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The binding is provided by the watchdog core.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/marvel.txt | 5 +++++
 drivers/watchdog/orion_wdt.c                          | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 0b2503a..66c2b8c 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -5,10 +5,15 @@ Required Properties:
 - Compatibility : "marvell,orion-wdt"
 - reg		: Address of the timer registers
 
+Optional properties:
+
+- timeout	: Contains the watchdog timeout in seconds
+
 Example:
 
 	wdt@20300 {
 		compatible = "marvell,orion-wdt";
 		reg = <0x20300 0x28>;
+		timeout = <10>;
 		status = "okay";
 	};
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index c20f96b..3dc7481 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -24,7 +24,6 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <mach/bridge-regs.h>
 
 /*
@@ -168,6 +167,7 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 	orion_wdt.timeout = heartbeat;
 	orion_wdt.min_timeout = 1;
 	orion_wdt.max_timeout = wdt_max_duration;
+	watchdog_probe_dt(&orion_wdt, pdev->dev.of_node);
 
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
-- 
1.7.11.3

