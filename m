Return-path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v7] watchdog: Add DA9063 PMIC watchdog driver.
Date: Sun, 28 Sep 2014 19:05:45 +0200
Message-Id: <1411923945-3538-1-git-send-email-mpa@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>

This driver supports the watchdog device inside the DA9063 PMIC.

Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v7:
     - Remove unnecessary range checks
     - Realign line breaks
     - Cleanup use of unsigned int for selector and timeouts
    
    Changes in v6:
     - Fix compile error
    
    Changes in v5:
     - Kconfig: Add note about the module name.
     - Change selector variables to int
     - Style fixes
     - use unsigned int to remove gcc verbose warning
     - Integrate _kick() and _disable() into the calling functions
    
    Changes in v4:
     - Fixed indentation
     - Fixed lock without unlock
     - Check for parent device and device driver data in probe(). If not present,
       this is an invalid prober initialization, return -EINVAL.
    
    Changes in v3:
     - Cleanup error handling for timeout selection and setting
     - Fix race condition due to late wdt drvdata setup
     - Remove static struct watchdog_device. It is not initialized in the probe
       function
     - Use WATCHDOG_NOWAYOUT_INIT_STATUS for the status
     - Remove 0 shift using DA9063_TWDSCALE_SHIFT

 drivers/watchdog/Kconfig      |   9 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/da9063_wdt.c | 191 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/watchdog/da9063_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f57312fced80..669de63a7a48 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -87,6 +87,15 @@ config DA9055_WATCHDOG
 	  This driver can also be built as a module.  If so, the module
 	  will be called da9055_wdt.
 
+config DA9063_WATCHDOG
+	tristate "Dialog DA9063 Watchdog"
+	depends on MFD_DA9063
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the DA9063 PMIC.
+
+	  This driver can be built as a module. The module name is da9063_wdt.
+
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
 	depends on OF_GPIO
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 468c3204c3b1..6c467a9821fe 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -173,6 +173,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 # Architecture Independent
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
+obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
 obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
 obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
new file mode 100644
index 000000000000..2cd6b2c2dd2a
--- /dev/null
+++ b/drivers/watchdog/da9063_wdt.c
@@ -0,0 +1,191 @@
+/*
+ * Watchdog driver for DA9063 PMICs.
+ *
+ * Copyright(c) 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/mfd/da9063/registers.h>
+#include <linux/mfd/da9063/core.h>
+#include <linux/regmap.h>
+
+/*
+ * Watchdog selector to timeout in seconds.
+ *   0: WDT disabled;
+ *   others: timeout = 2048 ms * 2^(TWDSCALE-1).
+ */
+static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
+#define DA9063_TWDSCALE_DISABLE		0
+#define DA9063_TWDSCALE_MIN		1
+#define DA9063_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
+#define DA9063_WDT_MIN_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MIN]
+#define DA9063_WDT_MAX_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MAX]
+#define DA9063_WDG_TIMEOUT		wdt_timeout[3]
+
+struct da9063_watchdog {
+	struct da9063 *da9063;
+	struct watchdog_device wdtdev;
+};
+
+static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
+{
+	unsigned int i;
+
+	for (i = DA9063_TWDSCALE_MIN; i <= DA9063_TWDSCALE_MAX; i++) {
+		if (wdt_timeout[i] >= secs)
+			return i;
+	}
+
+	return DA9063_TWDSCALE_MAX;
+}
+
+static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
+{
+	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
+				  DA9063_TWDSCALE_MASK, regval);
+}
+
+static int da9063_wdt_start(struct watchdog_device *wdd)
+{
+	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int selector;
+	int ret;
+
+	selector = da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
+	ret = _da9063_wdt_set_timeout(wdt->da9063, selector);
+	if (ret)
+		dev_err(wdt->da9063->dev, "Watchdog failed to start (err = %d)\n",
+			ret);
+
+	return ret;
+}
+
+static int da9063_wdt_stop(struct watchdog_device *wdd)
+{
+	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = regmap_update_bits(wdt->da9063->regmap, DA9063_REG_CONTROL_D,
+				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
+	if (ret)
+		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err = %d)\n",
+			  ret);
+
+	return ret;
+}
+
+static int da9063_wdt_ping(struct watchdog_device *wdd)
+{
+	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
+			   DA9063_WATCHDOG);
+	if (ret)
+		dev_alert(wdt->da9063->dev, "Failed to ping the watchdog (err = %d)\n",
+			  ret);
+
+	return ret;
+}
+
+static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
+				  unsigned int timeout)
+{
+	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int selector;
+	int ret;
+
+	selector = da9063_wdt_timeout_to_sel(timeout);
+	ret = _da9063_wdt_set_timeout(wdt->da9063, selector);
+	if (ret)
+		dev_err(wdt->da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
+			ret);
+	else
+		wdd->timeout = wdt_timeout[selector];
+
+	return ret;
+}
+
+static const struct watchdog_info da9063_watchdog_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "DA9063 Watchdog",
+};
+
+static const struct watchdog_ops da9063_watchdog_ops = {
+	.owner = THIS_MODULE,
+	.start = da9063_wdt_start,
+	.stop = da9063_wdt_stop,
+	.ping = da9063_wdt_ping,
+	.set_timeout = da9063_wdt_set_timeout,
+};
+
+static int da9063_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct da9063 *da9063;
+	struct da9063_watchdog *wdt;
+
+	if (!pdev->dev.parent)
+		return -EINVAL;
+
+	da9063 = dev_get_drvdata(pdev->dev.parent);
+	if (!da9063)
+		return -EINVAL;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->da9063 = da9063;
+
+	wdt->wdtdev.info = &da9063_watchdog_info;
+	wdt->wdtdev.ops = &da9063_watchdog_ops;
+	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
+	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
+	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
+
+	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+
+	watchdog_set_drvdata(&wdt->wdtdev, wdt);
+	dev_set_drvdata(&pdev->dev, wdt);
+
+	ret = watchdog_register_device(&wdt->wdtdev);
+
+	return ret;
+}
+
+static int da9063_wdt_remove(struct platform_device *pdev)
+{
+	struct da9063_watchdog *wdt = dev_get_drvdata(&pdev->dev);
+
+	watchdog_unregister_device(&wdt->wdtdev);
+
+	return 0;
+}
+
+static struct platform_driver da9063_wdt_driver = {
+	.probe = da9063_wdt_probe,
+	.remove = da9063_wdt_remove,
+	.driver = {
+		.name = DA9063_DRVNAME_WATCHDOG,
+	},
+};
+module_platform_driver(da9063_wdt_driver);
+
+MODULE_AUTHOR("Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>");
+MODULE_DESCRIPTION("Watchdog driver for Dialog DA9063");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DA9063_DRVNAME_WATCHDOG);
-- 
2.1.0
