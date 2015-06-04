Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vpnchicago.adeneo-embedded.us ([65.182.180.190]:39637 "EHLO
	mxadeneo.adeneo-embedded.us" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752773AbbFDT0t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Jun 2015 15:26:49 -0400
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Wim Van Sebroeck <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
Subject: [PATCH 1/1] gpio_wdt: change initcall level
Date: Thu, 4 Jun 2015 12:21:30 -0700
Message-ID: <1433445690-22560-1-git-send-email-jtheou@adeneo-embedded.us>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

gpio_wdt may need to start the GPIO toggle as soon as possible,
when the watchdog cannot be disabled. Raise the initcall to
arch_initcall.

We need to split the initiation, because of miscdev, as done in
mpc8xxx_wdt.c

Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
---
 drivers/watchdog/gpio_wdt.c | 78 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index cbc313d..8ecfe7e 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/of_gpio.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/watchdog.h>
@@ -223,10 +224,11 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 
 	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
 
-	ret = watchdog_register_device(&priv->wdd);
+#ifdef MODULE
+	ret = gpio_wdt_init_late();
 	if (ret)
 		return ret;
-
+#endif
 	priv->notifier.notifier_call = gpio_wdt_notify_sys;
 	ret = register_reboot_notifier(&priv->notifier);
 	if (ret)
@@ -235,10 +237,13 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (priv->always_running)
 		gpio_wdt_start_impl(priv);
 
+	platform_set_drvdata(pdev, priv);
 	return 0;
 
 error_unregister:
-	watchdog_unregister_device(&priv->wdd);
+#ifdef MODULE
+	ret = gpio_wdt_remove_late(&priv->wdd);
+#endif
 	return ret;
 }
 
@@ -267,7 +272,72 @@ static struct platform_driver gpio_wdt_driver = {
 	.probe	= gpio_wdt_probe,
 	.remove	= gpio_wdt_remove,
 };
-module_platform_driver(gpio_wdt_driver);
+
+/*
+ * We do wdt initialization in two steps: arch_initcall probes the wdt
+ * very early to start pinging the watchdog (misc devices are not yet
+ * available), and later module_init() just registers the misc device.
+ */
+static int gpio_wdt_init_late(void)
+{
+	struct platform_device *pdev;
+	struct device_node *wdt_node;
+	struct gpio_wdt_priv *priv;
+	int ret;
+
+	for_each_compatible_node(wdt_node, NULL, "linux,wdt-gpio") {
+		pdev = of_find_device_by_node(wdt_node);
+		priv = platform_get_drvdata(pdev);
+		if (&priv->wdd) {
+			ret = watchdog_register_device(&priv->wdd);
+			if (ret)
+				return ret;
+		} else {
+			dev_err(&pdev->dev, "Unable to register the watchdog\n");
+			return -1;
+		}
+	}
+	return 0;
+}
+#ifndef MODULE
+module_init(gpio_wdt_init_late);
+#endif
+
+#ifdef MODULE
+int gpio_wdt_remove_late(void)
+{
+	struct platform_device *pdev;
+	struct device_node *wdt_node;
+	struct gpio_wdt_priv *priv;
+	int ret;
+
+	for_each_compatible_node(wdt_node, NULL, "linux,wdt-gpio") {
+		pdev = of_find_device_by_node(wdt_node);
+		priv = platform_get_drvdata(pdev);
+		if (&priv->wdd) {
+			ret = watchdog_unregister_device(&priv->wdd);
+			if (ret)
+				return ret;
+		} else {
+			dev_err(&pdev->dev, "Unable to register the watchdog\n");
+			return -1;
+		}
+	}
+	return 0;
+}
+#endif
+
+static int __init gpio_wdt_init(void)
+{
+	return platform_driver_register(&gpio_wdt_driver);
+}
+arch_initcall(gpio_wdt_init);
+
+static void __exit gpio_wdt_exit(void)
+{
+	platform_driver_unregister(&gpio_wdt_driver);
+}
+module_exit(gpio_wdt_exit);
 
 MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
 MODULE_DESCRIPTION("GPIO Watchdog");
-- 
2.4.2

