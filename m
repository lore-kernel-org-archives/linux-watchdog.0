Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:38125 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758567Ab3BNWCi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Feb 2013 17:02:38 -0500
Received: by mail-la0-f53.google.com with SMTP id fr10so2742182lab.26
        for <linux-watchdog@vger.kernel.org>; Thu, 14 Feb 2013 14:02:36 -0800 (PST)
From: Joachim Eastwood <manabian@gmail.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com,
	plagnioj@jcrosoft.com, Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH] watchdog: at91rm9200: add DT support
Date: Thu, 14 Feb 2013 23:02:29 +0100
Message-Id: <1360879349-17369-1-git-send-email-manabian@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt        | 9 +++++++++
 drivers/watchdog/Kconfig                                         | 2 +-
 drivers/watchdog/at91rm9200_wdt.c                                | 9 +++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
new file mode 100644
index 0000000..d4d86cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
@@ -0,0 +1,9 @@
+Atmel AT91RM9200 System Timer Watchdog
+
+Required properties:
+- compatible: must be "atmel,at91sam9260-wdt".
+
+Example:
+	watchdog@fffffd00 {
+		compatible = "atmel,at91rm9200-wdt";
+	};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7f809fd..82ebff9 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -116,7 +116,7 @@ config ARM_SP805_WATCHDOG
 
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
-	depends on ARCH_AT91RM9200
+	depends on ARCH_AT91
 	help
 	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
 	  system when the timeout is reached.
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 89831ed..1c75260 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -24,6 +24,8 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <mach/at91_st.h>
 
 #define WDT_DEFAULT_TIME	5	/* seconds */
@@ -252,6 +254,12 @@ static int at91wdt_resume(struct platform_device *pdev)
 #define at91wdt_resume	NULL
 #endif
 
+static const struct of_device_id at91_wdt_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
+
 static struct platform_driver at91wdt_driver = {
 	.probe		= at91wdt_probe,
 	.remove		= at91wdt_remove,
@@ -261,6 +269,7 @@ static struct platform_driver at91wdt_driver = {
 	.driver		= {
 		.name	= "at91_wdt",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(at91_wdt_dt_ids),
 	},
 };
 
-- 
1.8.0

