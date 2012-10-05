Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39673 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab2JEKQR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Oct 2012 06:16:17 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1148438eek.19
        for <linux-watchdog@vger.kernel.org>; Fri, 05 Oct 2012 03:16:16 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [RFC PATCH v3 2/4] watchdog: add timeout-sec property binding to some drivers
Date: Fri,  5 Oct 2012 12:16:07 +0200
Message-Id: <1349432169-13006-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The binding is provided by the watchdog core.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 .../devicetree/bindings/watchdog/atmel-wdt.txt          |  4 ++++
 Documentation/devicetree/bindings/watchdog/marvel.txt   |  5 +++++
 .../devicetree/bindings/watchdog/pnx4008-wdt.txt        |  4 ++++
 drivers/watchdog/Kconfig                                |  1 +
 drivers/watchdog/at91sam9_wdt.c                         | 17 +++++++++++++----
 drivers/watchdog/orion_wdt.c                            |  9 +++------
 drivers/watchdog/pnx4008_wdt.c                          |  7 +++----
 7 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index 2957ebb..27af70d 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -7,9 +7,13 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 
+Optional properties:
+- timeout-sec: Contains the watchdog timeout in seconds
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
diff --git a/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt b/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
index 7c7f688..47461f5 100644
--- a/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
@@ -5,9 +5,13 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 
+Optional properties:
+- timeout-sec: Contains the watchdog timeout in seconds
+
 Example:
 
 	watchdog@4003C000 {
 		compatible = "nxp,pnx4008-wdt";
 		reg = <0x4003C000 0x1000>;
+		timeout-sec = <10>;
 	};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ad1bb93..dda695f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -114,6 +114,7 @@ config AT91RM9200_WATCHDOG
 config AT91SAM9X_WATCHDOG
 	tristate "AT91SAM9X / AT91CAP9 watchdog"
 	depends on ARCH_AT91 && !ARCH_AT91RM9200
+	select WATCHDOG_CORE
 	help
 	  Watchdog timer embedded into AT91SAM9X and AT91CAP9 chips. This will
 	  reboot your system when the timeout is reached.
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index dc42e44..f901cc0 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -32,7 +32,6 @@
 #include <linux/timer.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
-#include <linux/of.h>
 
 #include "at91sam9_wdt.h"
 
@@ -57,8 +56,10 @@
 #define WDT_TIMEOUT	(HZ/2)
 
 /* User land timeout */
+#define MIN_HEARTBEAT 1
+#define MAX_HEARTBEAT 16
 #define WDT_HEARTBEAT 15
-static int heartbeat = WDT_HEARTBEAT;
+static int heartbeat = 0;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
 	"(default = " __MODULE_STRING(WDT_HEARTBEAT) ")");
@@ -255,6 +256,12 @@ static struct miscdevice at91wdt_miscdev = {
 	.fops		= &at91wdt_fops,
 };
 
+static struct watchdog_device at91wdt_wdd __initdata = {
+	.timeout = WDT_HEARTBEAT,
+	.min_timeout = MIN_HEARTBEAT,
+	.max_timeout = MAX_HEARTBEAT,
+};
+
 static int __init at91wdt_probe(struct platform_device *pdev)
 {
 	struct resource	*r;
@@ -273,6 +280,8 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	watchdog_init_timeout(&at91wdt_wdd, heartbeat, pdev->dev.of_node);
+
 	/* Set watchdog */
 	res = at91_wdt_settimeout(ms_to_ticks(WDT_HW_TIMEOUT * 1000));
 	if (res)
@@ -282,12 +291,12 @@ static int __init at91wdt_probe(struct platform_device *pdev)
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
index c20f96b..3417f1b 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -24,7 +24,6 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <mach/bridge-regs.h>
 
 /*
@@ -162,12 +161,10 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	if ((heartbeat < 1) || (heartbeat > wdt_max_duration))
-		heartbeat = wdt_max_duration;
-
-	orion_wdt.timeout = heartbeat;
 	orion_wdt.min_timeout = 1;
 	orion_wdt.max_timeout = wdt_max_duration;
+	orion_wdt.timeout = wdt_max_duration;
+	watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
 
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
@@ -177,7 +174,7 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 	}
 
 	pr_info("Initial timeout %d sec%s\n",
-		heartbeat, nowayout ? ", nowayout" : "");
+		orion_wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
 }
 
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 87722e1..152e9fb 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -142,6 +142,7 @@ static const struct watchdog_ops pnx4008_wdt_ops = {
 static struct watchdog_device pnx4008_wdd = {
 	.info = &pnx4008_wdt_ident,
 	.ops = &pnx4008_wdt_ops,
+	.timeout = DEFAULT_HEARTBEAT,
 	.min_timeout = 1,
 	.max_timeout = MAX_HEARTBEAT,
 };
@@ -151,8 +152,7 @@ static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret = 0;
 
-	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
-		heartbeat = DEFAULT_HEARTBEAT;
+	watchdog_init_timeout(&pnx4008_wdd, heartbeat, pdev->dev.of_node);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt_base = devm_request_and_ioremap(&pdev->dev, r);
@@ -167,7 +167,6 @@ static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	pnx4008_wdd.timeout = heartbeat;
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
@@ -181,7 +180,7 @@ static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "PNX4008 Watchdog Timer: heartbeat %d sec\n",
-			heartbeat);
+		 pnx4008_wdd.timeout);
 
 	return 0;
 
-- 
1.7.11.3

