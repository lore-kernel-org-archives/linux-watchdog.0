Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63899 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2I0Pkl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Sep 2012 11:40:41 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2046818bkc.19
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Sep 2012 08:40:40 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v5 1/3] watchdog: at91sam9_wdt: add device tree support
Date: Thu, 27 Sep 2012 17:40:30 +0200
Message-Id: <1348760432-12284-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1348760432-12284-1-git-send-email-fabio.porcedda@gmail.com>
References: <1348760432-12284-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tested on an at91sam9260 board (evk-pro3)

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
 drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
new file mode 100644
index 0000000..5947929
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -0,0 +1,19 @@
+* Atmel Watchdog Timers
+
+** at91sam9-wdt
+
+Required properties:
+- compatible: must be "atmel,at91sam9260-wdt".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+Optional properties:
+- heartbeat: contains the watchdog heartbeats in seconds.
+
+Example:
+
+	watchdog@fffffd40 {
+		compatible = "atmel,at91sam9260-wdt";
+		reg = <0xfffffd40 0x10>;
+		heartbeat = <10>;
+	};
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 05e1be8..84658d7 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -32,6 +32,7 @@
 #include <linux/timer.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
+#include <linux/of.h>
 
 #include "at91sam9_wdt.h"
 
@@ -254,6 +255,14 @@ static struct miscdevice at91wdt_miscdev = {
 	.fops		= &at91wdt_fops,
 };
 
+static inline void __init at91wdt_probe_dt(struct device_node *node)
+{
+	if (!node)
+		return;
+
+	of_property_read_u32(node, "heartbeat", &heartbeat);
+}
+
 static int __init at91wdt_probe(struct platform_device *pdev)
 {
 	struct resource	*r;
@@ -272,6 +281,8 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	at91wdt_probe_dt(pdev->dev.of_node);
+
 	/* Set watchdog */
 	res = at91_wdt_settimeout(ms_to_ticks(WDT_HW_TIMEOUT * 1000));
 	if (res)
@@ -302,11 +313,21 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 	return res;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id at91_wdt_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9260-wdt" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
+#endif
+
 static struct platform_driver at91wdt_driver = {
 	.remove		= __exit_p(at91wdt_remove),
 	.driver		= {
 		.name	= "at91_wdt",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(at91_wdt_dt_ids),
 	},
 };
 
-- 
1.7.11.3

