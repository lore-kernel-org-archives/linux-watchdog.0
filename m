Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43813 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393753AbeKWT17 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Nov 2018 14:27:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so11479410wrs.10
        for <linux-watchdog@vger.kernel.org>; Fri, 23 Nov 2018 00:44:41 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v3 1/3] watchdog: Add pm8916 watchdog driver
Date: Fri, 23 Nov 2018 09:44:36 +0100
Message-Id: <1542962678-13697-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The PM816 module is a versatile PMIC with many diverse functions
integrated, including, a watchdog.
This watchdog is subcomponent of the PON (Power On) peripheral,
in the same way as pwrkey/resin buttons.
It works with two timers (2-stages), the first one generates an
IRQ to the main SoC (APQ8016/MSM8916), the second one performs
the reset.

This driver expects the following device hierarchy:
[pm8916]->[pm8916-pon]->[pm8916-wdt]

It uses the pm8916 regmap to access PM8916 registers.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: SPDX license
     headers ordering
     coding styles / tabs / multi-line comments
     pretimeout / bark interrupt
     WDIOF_MAGICCLOSE flag
     timeout init via fdt
     devm usage
 v3: Remove unused dev/irq variables from pm8916 wdt struct

 drivers/watchdog/Kconfig      |   8 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/pm8916_wdt.c | 211 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/watchdog/pm8916_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2d64333..ef2c2b5 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -847,6 +847,14 @@ config SPRD_WATCHDOG
 	  Say Y here to include watchdog timer supported
 	  by Spreadtrum system.
 
+config PM8916_WATCHDOG
+	tristate "QCOM PM8916 pmic watchdog"
+	depends on OF && MFD_SPMI_PMIC
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support watchdog timer embedded into the
+	  pm8916 module.
+
 # X86 (i386 + ia64 + x86_64) Architecture
 
 config ACQUIRE_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f69cdff..cc90e72 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
 obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
 obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
 obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
+obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
 
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
new file mode 100644
index 0000000..7f10041
--- /dev/null
+++ b/drivers/watchdog/pm8916_wdt.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+#define PON_INT_RT_STS			0x10
+#define PMIC_WD_BARK_STS_BIT		BIT(6)
+
+#define PON_PMIC_WD_RESET_S1_TIMER	0x54
+#define PON_PMIC_WD_RESET_S2_TIMER	0x55
+
+#define PON_PMIC_WD_RESET_S2_CTL	0x56
+#define RESET_TYPE_WARM			0x01
+#define RESET_TYPE_SHUTDOWN		0x04
+#define RESET_TYPE_HARD			0x07
+
+#define PON_PMIC_WD_RESET_S2_CTL2	0x57
+#define S2_RESET_EN_BIT			BIT(7)
+
+#define PON_PMIC_WD_RESET_PET		0x58
+#define WATCHDOG_PET_BIT		BIT(0)
+
+#define PM8916_WDT_DEFAULT_TIMEOUT	32
+#define PM8916_WDT_MIN_TIMEOUT		1
+#define PM8916_WDT_MAX_TIMEOUT		127
+
+struct pm8916_wdt {
+	struct regmap *regmap;
+	struct watchdog_device wdev;
+	u32 baseaddr;
+};
+
+static int pm8916_wdt_start(struct watchdog_device *wdev)
+{
+	struct pm8916_wdt *wdt = watchdog_get_drvdata(wdev);
+
+	return regmap_update_bits(wdt->regmap,
+				  wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL2,
+				  S2_RESET_EN_BIT, S2_RESET_EN_BIT);
+}
+
+static int pm8916_wdt_stop(struct watchdog_device *wdev)
+{
+	struct pm8916_wdt *wdt = watchdog_get_drvdata(wdev);
+
+	return regmap_update_bits(wdt->regmap,
+				  wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL2,
+				  S2_RESET_EN_BIT, 0);
+}
+
+static int pm8916_wdt_ping(struct watchdog_device *wdev)
+{
+	struct pm8916_wdt *wdt = watchdog_get_drvdata(wdev);
+
+	return regmap_update_bits(wdt->regmap,
+				  wdt->baseaddr + PON_PMIC_WD_RESET_PET,
+				  WATCHDOG_PET_BIT, WATCHDOG_PET_BIT);
+}
+
+static int pm8916_wdt_configure_timers(struct watchdog_device *wdev)
+{
+	struct pm8916_wdt *wdt = watchdog_get_drvdata(wdev);
+	int err;
+
+	err = regmap_write(wdt->regmap,
+			   wdt->baseaddr + PON_PMIC_WD_RESET_S1_TIMER,
+			   wdev->timeout - wdev->pretimeout);
+	if (err)
+		return err;
+
+	return regmap_write(wdt->regmap,
+			    wdt->baseaddr + PON_PMIC_WD_RESET_S2_TIMER,
+			    wdev->pretimeout);
+}
+
+static int pm8916_wdt_set_timeout(struct watchdog_device *wdev,
+				  unsigned int timeout)
+{
+	wdev->timeout = timeout;
+
+	return pm8916_wdt_configure_timers(wdev);
+}
+
+static int pm8916_wdt_set_pretimeout(struct watchdog_device *wdev,
+				     unsigned int pretimeout)
+{
+	wdev->pretimeout = pretimeout;
+
+	return pm8916_wdt_configure_timers(wdev);
+}
+
+static irqreturn_t pm8916_wdt_isr(int irq, void *arg)
+{
+	struct pm8916_wdt *wdt = arg;
+	int err, sts;
+
+	err = regmap_read(wdt->regmap, wdt->baseaddr + PON_INT_RT_STS, &sts);
+	if (err)
+		return IRQ_HANDLED;
+
+	if (sts & PMIC_WD_BARK_STS_BIT)
+		watchdog_notify_pretimeout(&wdt->wdev);
+
+	return IRQ_HANDLED;
+}
+
+static const struct watchdog_info pm8916_wdt_ident = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "QCOM PM8916 PON WDT",
+};
+
+static const struct watchdog_info pm8916_wdt_pt_ident = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
+		   WDIOF_PRETIMEOUT,
+	.identity = "QCOM PM8916 PON WDT",
+};
+
+static const struct watchdog_ops pm8916_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = pm8916_wdt_start,
+	.stop = pm8916_wdt_stop,
+	.ping = pm8916_wdt_ping,
+	.set_timeout = pm8916_wdt_set_timeout,
+	.set_pretimeout = pm8916_wdt_set_pretimeout,
+};
+
+static int pm8916_wdt_probe(struct platform_device *pdev)
+{
+	struct pm8916_wdt *wdt;
+	struct device *parent;
+	int err, irq;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	parent = pdev->dev.parent;
+
+	/*
+	 * The pm8916-pon-wdt is a child of the pon device, which is a child
+	 * of the pm8916 mfd device. We want access to the pm8916 registers.
+	 * Retrieve regmap from pm8916 (parent->parent) and base address
+	 * from pm8916-pon (pon).
+	 */
+	wdt->regmap = dev_get_regmap(parent->parent, NULL);
+	if (!wdt->regmap) {
+		dev_err(&pdev->dev, "failed to locate regmap\n");
+		return -ENODEV;
+	}
+
+	err = device_property_read_u32(parent, "reg", &wdt->baseaddr);
+	if (err) {
+		dev_err(&pdev->dev, "failed to get pm8916-pon address\n");
+		return err;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq > 0) {
+		if (devm_request_irq(&pdev->dev, irq, pm8916_wdt_isr, 0,
+				     "pm8916_wdt", wdt))
+			irq = 0;
+	}
+
+	/* Configure watchdog to hard-reset mode */
+	err = regmap_write(wdt->regmap,
+			   wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL,
+			   RESET_TYPE_HARD);
+	if (err) {
+		dev_err(&pdev->dev, "failed configure watchdog\n");
+		return err;
+	}
+
+	wdt->wdev.info = (irq > 0) ? &pm8916_wdt_pt_ident : &pm8916_wdt_ident,
+	wdt->wdev.ops = &pm8916_wdt_ops,
+	wdt->wdev.parent = &pdev->dev;
+	wdt->wdev.min_timeout = PM8916_WDT_MIN_TIMEOUT;
+	wdt->wdev.max_timeout = PM8916_WDT_MAX_TIMEOUT;
+	wdt->wdev.timeout = PM8916_WDT_DEFAULT_TIMEOUT;
+	wdt->wdev.pretimeout = 0;
+	watchdog_set_drvdata(&wdt->wdev, wdt);
+
+	watchdog_init_timeout(&wdt->wdev, 0, &pdev->dev);
+	pm8916_wdt_configure_timers(&wdt->wdev);
+
+	return devm_watchdog_register_device(&pdev->dev, &wdt->wdev);
+}
+
+static const struct of_device_id pm8916_wdt_id_table[] = {
+	{ .compatible = "qcom,pm8916-wdt" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pm8916_wdt_id_table);
+
+static struct platform_driver pm8916_wdt_driver = {
+	.probe = pm8916_wdt_probe,
+	.driver = {
+		.name = "pm8916-wdt",
+		.of_match_table = of_match_ptr(pm8916_wdt_id_table),
+	},
+};
+module_platform_driver(pm8916_wdt_driver);
+
+MODULE_AUTHOR("Loic Poulain <loic.poulain@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm pm8916 watchdog driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
