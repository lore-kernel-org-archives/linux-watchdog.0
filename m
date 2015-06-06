Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vpnchicago.adeneo-embedded.us ([65.182.180.190]:23426 "EHLO
	mxadeneo.adeneo-embedded.us" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753082AbbFFBrN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Jun 2015 21:47:13 -0400
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Guenter Roeck <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
Subject: [PATCH v2 3/3] gpio_wdt: Add option for early registration
Date: Fri, 5 Jun 2015 18:46:52 -0700
Message-ID: <1433555212-4729-3-git-send-email-jtheou@adeneo-embedded.us>
In-Reply-To: <1433555212-4729-1-git-send-email-jtheou@adeneo-embedded.us>
References: <1433555212-4729-1-git-send-email-jtheou@adeneo-embedded.us>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In some situation, mainly when it's not possible to disable a
watchdog, you may want the watchdog driver to be started as soon
as possible.

Adding GPIO_WATCHDOG_ARCH_INITCALL to raise initcall from
module_init to arch_initcall. This is only for a built-in
module.

This patch require watchdog registration deferral mechanism

Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
---
 drivers/watchdog/Kconfig    | 14 ++++++++++++++
 drivers/watchdog/gpio_wdt.c | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e5e7c55..a9655a9 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1,3 +1,4 @@
+
 #
 # Watchdog device configuration
 #
@@ -114,6 +115,19 @@ config MENF21BMC_WATCHDOG
 	  This driver can also be built as a module. If so the module
 	  will be called menf21bmc_wdt.
 
+config GPIO_WATCHDOG_ARCH_INITCALL
+	bool "Register the watchdog as early as possible"
+	depends on GPIO_WATCHDOG
+	help
+	  This option make sense only on a built-in situation.
+
+	  In some situation, the default initcall level (module_init)
+	  in not early enough on the boot process to avoid the watchdog
+	  to be trigger.
+	  If you say yes here, the initcall level would be raise to
+	  arch_initcall.
+	  "If in doubt, leave it out" - say N.
+
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
 	depends on MFD_WM831X
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index cbc313d..07a39cd 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -267,8 +267,21 @@ static struct platform_driver gpio_wdt_driver = {
 	.probe	= gpio_wdt_probe,
 	.remove	= gpio_wdt_remove,
 };
+#ifndef GPIO_WATCHDOG_ARCH_INITCALL
 module_platform_driver(gpio_wdt_driver);
+#else
+static int __init gpio_wdt_init(void)
+{
+	return platform_driver_register(&gpio_wdt_driver);
+}
+arch_initcall(gpio_wdt_init);
 
+static void __exit gpio_wdt_exit(void)
+{
+	platform_driver_unregister(&gpio_wdt_driver);
+}
+module_exit(gpio_wdt_exit);
+#endif
 MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
 MODULE_DESCRIPTION("GPIO Watchdog");
 MODULE_LICENSE("GPL");
-- 
2.4.2

