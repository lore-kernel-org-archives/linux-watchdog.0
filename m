Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:63604 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3BMMWn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 07:22:43 -0500
Received: by mail-ea0-f178.google.com with SMTP id a14so491068eaa.9
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 04:22:42 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v8 3/7] watchdog: orion_wdt: add timeout-sec property binding
Date: Wed, 13 Feb 2013 13:22:26 +0100
Message-Id: <1360758150-23004-4-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Only compile tested.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
 Documentation/devicetree/bindings/watchdog/marvel.txt | 5 +++++
 drivers/watchdog/orion_wdt.c                          | 8 +++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 0b2503a..5dc8d30 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -5,10 +5,15 @@ Required Properties:
 - Compatibility : "marvell,orion-wdt"
 - reg		: Address of the timer registers
 
+Optional properties:
+
+- timeout-sec	: Contains the watchdog timeout in seconds
+
 Example:
 
 	wdt@20300 {
 		compatible = "marvell,orion-wdt";
 		reg = <0x20300 0x28>;
+		timeout-sec = <10>;
 		status = "okay";
 	};
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 87ed2b9..3022a38 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -164,12 +164,10 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	if ((heartbeat < 1) || (heartbeat > wdt_max_duration))
-		heartbeat = wdt_max_duration;
-
-	orion_wdt.timeout = heartbeat;
 	orion_wdt.min_timeout = 1;
+	orion_wdt.timeout = wdt_max_duration;
 	orion_wdt.max_timeout = wdt_max_duration;
+	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
 
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
@@ -179,7 +177,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	}
 
 	pr_info("Initial timeout %d sec%s\n",
-		heartbeat, nowayout ? ", nowayout" : "");
+		orion_wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
 }
 
-- 
1.8.1.1

