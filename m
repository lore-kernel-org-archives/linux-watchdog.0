Return-path: <jtheou@adeneo-embedded.us>
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Guenter Roeck <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jean-Baptiste Theou
	<jtheou@adeneo-embedded.us>
Subject: [PATCH v3 2/2] gpio_wdt: Add option for early registration
Date: Sat, 6 Jun 2015 00:46:26 -0700
Message-ID: <1433576786-14947-2-git-send-email-jtheou@adeneo-embedded.us>
In-Reply-To: <1433576786-14947-1-git-send-email-jtheou@adeneo-embedded.us>
References: <1433576786-14947-1-git-send-email-jtheou@adeneo-embedded.us>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

In some situation, mainly when it's not possible to disable a
watchdog, you may want the watchdog driver to be started as soon
as possible.

Adding GPIO_WATCHDOG_ARCH_INITCALL to raise initcall from
module_init to arch_initcall.

This patch require watchdog registration deferral mechanism

Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
---
Changes in v3:
 - Simplify changes, since the modification is for built-in only

 drivers/watchdog/Kconfig    | 12 ++++++++++++
 drivers/watchdog/gpio_wdt.c |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e5e7c55..7a5c912 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1,3 +1,4 @@
+
 #
 # Watchdog device configuration
 #
@@ -104,6 +105,17 @@ config GPIO_WATCHDOG
 	  If you say yes here you get support for watchdog device
 	  controlled through GPIO-line.
 
+config GPIO_WATCHDOG_ARCH_INITCALL
+	bool "Register the watchdog as early as possible"
+	depends on GPIO_WATCHDOG=y
+	help
+	  In some situations, the default initcall level (module_init)
+	  in not early enough in the boot process to avoid the watchdog
+	  to be triggered.
+	  If you say yes here, the initcall level would be raised to
+	  arch_initcall.
+	  If in doubt, say N.
+
 config MENF21BMC_WATCHDOG
 	tristate "MEN 14F021P00 BMC Watchdog"
 	depends on MFD_MENF21BMC
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index cbc313d..f9149a2 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -267,7 +267,15 @@ static struct platform_driver gpio_wdt_driver = {
 	.probe	= gpio_wdt_probe,
 	.remove	= gpio_wdt_remove,
 };
+#ifdef GPIO_WATCHDOG_ARCH_INITCALL
+static int __init gpio_wdt_init(void)
+{
+	return platform_driver_register(&gpio_wdt_driver);
+}
+arch_initcall(gpio_wdt_init);
+#else
 module_platform_driver(gpio_wdt_driver);
+#endif
 
 MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
 MODULE_DESCRIPTION("GPIO Watchdog");
-- 
2.4.2
