Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41973 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965545Ab2JDI1H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Oct 2012 04:27:07 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so160767eek.19
        for <linux-watchdog@vger.kernel.org>; Thu, 04 Oct 2012 01:27:07 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [RFC PATCH v2 2/2] watchdog: add timeout-sec property binding to some drivers
Date: Thu,  4 Oct 2012 10:26:59 +0200
Message-Id: <1349339219-1467-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349339219-1467-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349339219-1467-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The binding is provided by the watchdog core.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

f2
---
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 ++++
 .../devicetree/bindings/watchdog/marvel.txt        |  5 +++++
 drivers/watchdog/at91sam9_wdt.c                    | 23 ++++++++++++++++------
 drivers/watchdog/orion_wdt.c                       | 13 ++++++------
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index 2957ebb..ad4cc0a 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -7,9 +7,13 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 
+Optional properties:
+- timeout-sec	: Contains the watchdog timeout in seconds
+
 Example:
 
 	watchdog@fffffd40 {
 		compatible = "atmel,at91sam9260-wdt";
 		reg = <0xfffffd40 0x10>;
+		timeout-sec = <10>;
 	};
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
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index dc42e44..3f66193 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -32,7 +32,6 @@
 #include <linux/timer.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
-#include <linux/of.h>
 
 #include "at91sam9_wdt.h"
 
@@ -57,11 +56,13 @@
 #define WDT_TIMEOUT	(HZ/2)
 
 /* User land timeout */
-#define WDT_HEARTBEAT 15
-static int heartbeat = WDT_HEARTBEAT;
+#define MIN_HEARTBEAT 1
+#define MAX_HEARTBEAT 16
+#define DEF_HEARTBEAT 15
+static int heartbeat = 0;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
-	"(default = " __MODULE_STRING(WDT_HEARTBEAT) ")");
+	"(default = " __MODULE_STRING(DEF_HEARTBEAT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -255,6 +256,11 @@ static struct miscdevice at91wdt_miscdev = {
 	.fops		= &at91wdt_fops,
 };
 
+static struct watchdog_device at91wdt_wdd __initdata = {
+	.min_timeout = MIN_HEARTBEAT,
+	.max_timeout = MAX_HEARTBEAT,
+};
+
 static int __init at91wdt_probe(struct platform_device *pdev)
 {
 	struct resource	*r;
@@ -273,6 +279,11 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if ((heartbeat < MIN_HEARTBEAT) || (heartbeat > MAX_HEARTBEAT)) {
+		at91wdt_wdd.timeout = DEF_HEARTBEAT;
+		watchdog_probe_dt_timeout(&at91wdt_wdd, pdev->dev.of_node);
+	}
+
 	/* Set watchdog */
 	res = at91_wdt_settimeout(ms_to_ticks(WDT_HW_TIMEOUT * 1000));
 	if (res)
@@ -282,12 +293,12 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	if (res)
 		return res;
 
-	at91wdt_private.next_heartbeat = jiffies + heartbeat * HZ;
+	at91wdt_private.next_heartbeat = jiffies + at91wdt_wdd.timeout * HZ;
 	setup_timer(&at91wdt_private.timer, at91_ping, 0);
 	mod_timer(&at91wdt_private.timer, jiffies + WDT_TIMEOUT);
 
 	pr_info("enabled (heartbeat=%d sec, nowayout=%d)\n",
-		heartbeat, nowayout);
+		at91wdt_wdd.timeout, nowayout);
 
 	return 0;
 }
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index c20f96b..14406e6 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -24,7 +24,6 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <mach/bridge-regs.h>
 
 /*
@@ -162,12 +161,14 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	if ((heartbeat < 1) || (heartbeat > wdt_max_duration))
-		heartbeat = wdt_max_duration;
-
-	orion_wdt.timeout = heartbeat;
 	orion_wdt.min_timeout = 1;
 	orion_wdt.max_timeout = wdt_max_duration;
+	if ((heartbeat >= 1) && (heartbeat <= wdt_max_duration)) {
+		orion_wdt.timeout = heartbeat;
+	} else {
+		orion_wdt.timeout = wdt_max_duration;
+		watchdog_probe_dt_timeout(&orion_wdt, pdev->dev.of_node);
+	}
 
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
@@ -177,7 +178,7 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 	}
 
 	pr_info("Initial timeout %d sec%s\n",
-		heartbeat, nowayout ? ", nowayout" : "");
+		orion_wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
 }
 
-- 
1.7.11.3

