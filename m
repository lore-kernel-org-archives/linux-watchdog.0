Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:45064 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab3KZQwo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Nov 2013 11:52:44 -0500
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [94.100.177.89])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id B1B9D46E577B
	for <linux-watchdog@vger.kernel.org>; Tue, 26 Nov 2013 20:27:05 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2] watchdog: GPIO-controlled watchdog
Date: Tue, 26 Nov 2013 20:26:28 +0400
Message-Id: <1385483188-12221-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds a watchdog driver for devices controlled through GPIO,
(Analog Devices ADM706, IC 555 etc).

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/watchdog/gpio-wdt.txt      |  23 ++
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/gpio_wdt.c                        | 246 +++++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
 create mode 100644 drivers/watchdog/gpio_wdt.c

diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
new file mode 100644
index 0000000..08ba8e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
@@ -0,0 +1,23 @@
+* GPIO-controlled Watchdog
+
+Required Properties:
+- compatible: Should contain "linux,wdt-gpio".
+- gpios: From common gpio binding; gpio connection to WDT reset pin.
+- wdt-gpio,hw_algo: The algorithm used by the driver. Should be one
+  of the following values:
+  - toggle: Either a high-to-low or a low-to-high transition clears
+    the WDT counter. The watchdog timer is disabled when GPIO is
+    left floating or connected to a three-state buffer.
+  - level: Low or high level starts counting WDT timeout,
+    the opposite level disables the WDT. Active level is determined
+    by the GPIO flags.
+- wdt-gpio,hw_margin_ms: Maximum time to reset watchdog circuit (milliseconds).
+
+Example:
+	watchdog: watchdog {
+		/* ADM706 */
+		compatible = "linux,wdt-gpio";
+		gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
+		wdt-gpio,hw_algo = "toggle";
+		wdt-gpio,hw_margin_ms = <1600>;
+	};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5be6e91..968a882 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -87,6 +87,14 @@ config DA9055_WATCHDOG
 	  This driver can also be built as a module.  If so, the module
 	  will be called da9055_wdt.
 
+config GPIO_WATCHDOG
+	tristate "Watchdog device controlled through GPIO-line"
+	depends on OF_GPIO
+	select WATCHDOG_CORE
+	help
+	  If you say yes here you get support for watchdog device
+	  controlled through GPIO-line.
+
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
 	depends on MFD_WM831X
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 91bd95a..dc17275 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -171,6 +171,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 # Architecture Independent
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
+obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
 obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
 obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
new file mode 100644
index 0000000..c7166be
--- /dev/null
+++ b/drivers/watchdog/gpio_wdt.c
@@ -0,0 +1,246 @@
+/*
+ * Driver for watchdog device controlled through GPIO-line
+ *
+ * Author: 2013, Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+#define SOFT_TIMEOUT_MIN	1
+#define SOFT_TIMEOUT_DEF	60
+#define SOFT_TIMEOUT_MAX	0xffff
+
+enum {
+	HW_ALGO_TOGGLE,
+	HW_ALGO_LEVEL,
+};
+
+struct gpio_wdt_priv {
+	int			gpio;
+	bool			active_low;
+	bool			state;
+	unsigned int		hw_algo;
+	unsigned int		hw_margin;
+	unsigned long		last_jiffies;
+	struct notifier_block	notifier;
+	struct timer_list	timer;
+	struct watchdog_device	wdd;
+};
+
+static int gpio_wdt_disable(struct gpio_wdt_priv *priv)
+{
+	gpio_set_value_cansleep(priv->gpio, !priv->active_low);
+
+	/* Put GPIO back to tristate */
+	if (priv->hw_algo == HW_ALGO_TOGGLE)
+		return gpio_direction_input(priv->gpio);
+
+	return 0;
+}
+
+static int gpio_wdt_start(struct watchdog_device *wdd)
+{
+	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	priv->state = priv->active_low;
+	gpio_direction_output(priv->gpio, priv->state);
+	priv->last_jiffies = jiffies;
+	mod_timer(&priv->timer, priv->last_jiffies + priv->hw_margin);
+
+	return 0;
+}
+
+static int gpio_wdt_stop(struct watchdog_device *wdd)
+{
+	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	mod_timer(&priv->timer, 0);
+
+	return gpio_wdt_disable(priv);
+}
+
+static int gpio_wdt_ping(struct watchdog_device *wdd)
+{
+	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	priv->last_jiffies = jiffies;
+
+	return 0;
+}
+
+static int gpio_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
+{
+	wdd->timeout = t;
+
+	return 0;
+}
+
+static void gpio_wdt_hwping(unsigned long data)
+{
+	struct watchdog_device *wdd = (struct watchdog_device *)data;
+	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	if (time_before(jiffies, priv->last_jiffies +
+			msecs_to_jiffies(wdd->timeout * 1000))) {
+		/* Restart timer */
+		mod_timer(&priv->timer, jiffies + priv->hw_margin);
+
+		switch (priv->hw_algo) {
+		case HW_ALGO_TOGGLE:
+			/* Toggle output pin */
+			priv->state = !priv->state;
+			gpio_set_value_cansleep(priv->gpio, priv->state);
+			break;
+		case HW_ALGO_LEVEL:
+			/* Pulse */
+			gpio_set_value_cansleep(priv->gpio, !priv->active_low);
+			udelay(1);
+			gpio_set_value_cansleep(priv->gpio, priv->active_low);
+			break;
+		}
+	} else
+		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
+}
+
+static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
+			       void *unused)
+{
+	struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
+						  notifier);
+
+	mod_timer(&priv->timer, 0);
+
+	switch (code) {
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		gpio_wdt_disable(priv);
+		break;
+	case SYS_DOWN:
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static const struct watchdog_info gpio_wdt_ident = {
+	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
+			  WDIOF_SETTIMEOUT,
+	.identity	= "GPIO Watchdog",
+};
+
+static const struct watchdog_ops gpio_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= gpio_wdt_start,
+	.stop		= gpio_wdt_stop,
+	.ping		= gpio_wdt_ping,
+	.set_timeout	= gpio_wdt_set_timeout,
+};
+
+static int gpio_wdt_probe(struct platform_device *pdev)
+{
+	struct gpio_wdt_priv *priv;
+	enum of_gpio_flags flags;
+	const __be32 *prp;
+	u32 hw_margin;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
+	if (!gpio_is_valid(priv->gpio))
+		return priv->gpio;
+
+	priv->active_low = !!(flags & OF_GPIO_ACTIVE_LOW);
+
+	ret = devm_gpio_request_one(&pdev->dev, priv->gpio, GPIOF_IN,
+				    dev_name(&pdev->dev));
+	if (ret)
+		return ret;
+
+	prp = of_get_property(pdev->dev.of_node, "wdt-gpio,hw_algo", NULL);
+	if (!prp)
+		return -EINVAL;
+	if (!strncmp((const char *)prp, "toggle", 6))
+		priv->hw_algo = HW_ALGO_TOGGLE;
+	else if (!strncmp((const char *)prp, "level", 5))
+		priv->hw_algo = HW_ALGO_LEVEL;
+	else
+		return -ENOTSUPP;
+
+	prp = of_get_property(pdev->dev.of_node, "wdt-gpio,hw_margin_ms", NULL);
+	if (!prp)
+		return -EINVAL;
+	hw_margin = be32_to_cpu(*prp);
+	/* Disallow values lower than 2 and higher than 65535 ms */
+	if ((hw_margin < 2) || (hw_margin > 65535))
+		return -EINVAL;
+
+	/* Use safe value (2/3 of real timeout) */
+	priv->hw_margin = msecs_to_jiffies(hw_margin * 2 / 3);
+
+	watchdog_set_drvdata(&priv->wdd, priv);
+
+	priv->wdd.info		= &gpio_wdt_ident;
+	priv->wdd.ops		= &gpio_wdt_ops;
+	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
+	priv->wdd.max_timeout	= SOFT_TIMEOUT_MAX;
+
+	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
+		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
+
+	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
+
+	priv->notifier.notifier_call = gpio_wdt_notify_sys;
+	ret = register_reboot_notifier(&priv->notifier);
+	if (ret)
+		return ret;
+
+	return watchdog_register_device(&priv->wdd);
+}
+
+static int gpio_wdt_remove(struct platform_device *pdev)
+{
+	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	del_timer_sync(&priv->timer);
+	unregister_reboot_notifier(&priv->notifier);
+	watchdog_unregister_device(&priv->wdd);
+
+	return 0;
+}
+
+static const struct of_device_id gpio_wdt_dt_ids[] = {
+	{ .compatible = "linux,wdt-gpio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpio_wdt_dt_ids);
+
+static struct platform_driver gpio_wdt_driver = {
+	.driver	= {
+		.name		= "gpio-wdt",
+		.owner		= THIS_MODULE,
+		.of_match_table	= gpio_wdt_dt_ids,
+	},
+	.probe	= gpio_wdt_probe,
+	.remove	= gpio_wdt_remove,
+};
+module_platform_driver(gpio_wdt_driver);
+
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("GPIO Watchdog");
+MODULE_LICENSE("GPL");
-- 
1.8.3.2

