Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:44169 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3BMMWu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 07:22:50 -0500
Received: by mail-ee0-f51.google.com with SMTP id d17so520486eek.38
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 04:22:49 -0800 (PST)
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
Subject: [PATCH v8 6/7] watchdog: at91sam9_wdt: add timeout-sec property binding
Date: Wed, 13 Feb 2013 13:22:29 +0100
Message-Id: <1360758150-23004-7-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tested on at91sam9260 board (evk-pro3).

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt |  4 ++++
 drivers/watchdog/Kconfig                                 |  1 +
 drivers/watchdog/at91sam9_wdt.c                          | 16 +++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index 2957ebb..fcdd48f 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -7,9 +7,13 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 
+Optional properties:
+- timeout-sec: contains the watchdog timeout in seconds.
+
 Example:
 
 	watchdog@fffffd40 {
 		compatible = "atmel,at91sam9260-wdt";
 		reg = <0xfffffd40 0x10>;
+		timeout-sec = <10>;
 	};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5e8a034..c36fcb0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -125,6 +125,7 @@ config AT91RM9200_WATCHDOG
 config AT91SAM9X_WATCHDOG
 	tristate "AT91SAM9X / AT91CAP9 watchdog"
 	depends on ARCH_AT91 && !ARCH_AT91RM9200
+	select WATCHDOG_CORE
 	help
 	  Watchdog timer embedded into AT91SAM9X and AT91CAP9 chips. This will
 	  reboot your system when the timeout is reached.
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 6dad954..29b167a 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -57,8 +57,10 @@
 #define WDT_TIMEOUT	(HZ/2)
 
 /* User land timeout */
+#define MIN_HEARTBEAT 1
+#define MAX_HEARTBEAT 16
 #define WDT_HEARTBEAT 15
-static int heartbeat = WDT_HEARTBEAT;
+static int heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
 	"(default = " __MODULE_STRING(WDT_HEARTBEAT) ")");
@@ -255,6 +257,12 @@ static struct miscdevice at91wdt_miscdev = {
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
@@ -273,6 +281,8 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	watchdog_init_timeout(&at91wdt_wdd, heartbeat, &pdev->dev);
+
 	/* Set watchdog */
 	res = at91_wdt_settimeout(ms_to_ticks(WDT_HW_TIMEOUT * 1000));
 	if (res)
@@ -282,12 +292,12 @@ static int __init at91wdt_probe(struct platform_device *pdev)
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
-- 
1.8.1.1

