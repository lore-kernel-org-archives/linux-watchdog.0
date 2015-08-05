Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:12296 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbbHEJFy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 05:05:54 -0400
From: Wenyou Yang <wenyou.yang@atmel.com>
To: <wim@iguana.be>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>
CC: <sylvain.rochet@finsecur.com>, <nicolas.ferre@atmel.com>,
	<boris.brezillon@free-electrons.com>, <wenyou.yang@atmel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/2] drivers: watchdog: add a driver to support SAMA5D4 watchdog timer
Date: Wed, 5 Aug 2015 16:57:21 +0800
Message-ID: <1438765043-11030-2-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1438765043-11030-1-git-send-email-wenyou.yang@atmel.com>
References: <1438765043-11030-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

>From SAMA5D4, the watchdog timer is upgrated with a new feature,
which is describled as in the datasheet, "WDT_MR can be written
until a LOCKMR command is issued in WDT_CR".
That is to say, as long as the bootstrap and u-boot don't issue
a LOCKMR command, WDT_MR can be written more than once in the driver.

So the SAMA5D4 watchdog driver's implementation is different from
the at91sam9260 watchdog driver implemented in file at91sam9_wdt.c.
The user application open the device file to enable the watchdog timer
hardware, and close to disable it, and set the watchdog timer timeout
by seting WDV and WDD fields of WDT_MR register, and ping the watchdog
by issuing WDRSTT command to WDT_CR register with hard-coded key.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/watchdog/Kconfig            |    9 ++
 drivers/watchdog/Makefile           |    1 +
 drivers/watchdog/at91_sama5d4_wdt.c |  279 +++++++++++++++++++++++++++++++++++
 drivers/watchdog/at91sam9_wdt.h     |    2 +
 4 files changed, 291 insertions(+)
 create mode 100644 drivers/watchdog/at91_sama5d4_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e5e7c55..4ce8346 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -152,6 +152,15 @@ config ARM_SP805_WATCHDOG
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
 	  the timeout is reached.
 
+config AT91_SAMA5D4_WATCHDOG
+	tristate "Atmel SAMA5D4 Watchdog Timer"
+	depends on ARCH_AT91
+	select WATCHDOG_CORE
+	help
+	  Atmel SAMA5D4 watchdog timer is embedded into SAMA5D4 chips.
+	  Its Watchdog Timer Mode Register can be written more than once.
+	  This will reboot your system when the timeout is reached.
+
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
 	depends on SOC_AT91RM9200 && MFD_SYSCON
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 5c19294..c57569c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 
 # ARM Architecture
 obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
+obj-$(CONFIG_AT91_SAMA5D4_WATCHDOG) += at91_sama5d4_wdt.o
 obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
 obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
 obj-$(CONFIG_CADENCE_WATCHDOG) += cadence_wdt.o
diff --git a/drivers/watchdog/at91_sama5d4_wdt.c b/drivers/watchdog/at91_sama5d4_wdt.c
new file mode 100644
index 0000000..f2e1995
--- /dev/null
+++ b/drivers/watchdog/at91_sama5d4_wdt.c
@@ -0,0 +1,279 @@
+/*
+ * Driver for Atmel SAMA5D4 Watchdog Timer
+ *
+ * Copyright (C) 2015 Atmel Corporation
+ *
+ * Licensed under GPLv2.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+#include "at91sam9_wdt.h"
+
+/* minimum and maximum watchdog timeout, in seconds */
+#define MIN_WDT_TIMEOUT		1
+#define MAX_WDT_TIMEOUT		16
+#define WDT_DEFAULT_TIMEOUT	MAX_WDT_TIMEOUT
+
+#define WDT_SEC2TICKS(s)	((s) ? (((s) << 8) - 1) : 0)
+
+struct atmel_wdt {
+	struct watchdog_device	wdd;
+	void __iomem		*reg_base;
+	u32	config;
+};
+
+static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+module_param(wdt_timeout, int, 0);
+MODULE_PARM_DESC(wdt_timeout,
+	"Watchdog wdt_timeout in seconds. (default = "
+	__MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+	"Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+#define wdt_read(wdt, field) \
+	readl_relaxed((wdt)->reg_base + (field))
+
+#define wdt_write(wtd, field, val) \
+	writel_relaxed((val), (wdt)->reg_base + (field))
+
+static int atmel_wdt_start(struct watchdog_device *wdd)
+{
+	struct atmel_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 reg;
+
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	reg &= ~AT91_WDT_WDDIS;
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	return 0;
+}
+
+static int atmel_wdt_stop(struct watchdog_device *wdd)
+{
+	struct atmel_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 reg;
+
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	reg |= AT91_WDT_WDDIS;
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	return 0;
+}
+
+static int atmel_wdt_ping(struct watchdog_device *wdd)
+{
+	struct atmel_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
+
+	return 0;
+}
+
+static int atmel_wdt_set_timeout(struct watchdog_device *wdd,
+				 unsigned int timeout)
+{
+	struct atmel_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 value = WDT_SEC2TICKS(timeout);
+	u32 reg;
+
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	reg &= ~AT91_WDT_WDV;
+	reg &= ~AT91_WDT_WDD;
+	reg |= AT91_WDT_SET_WDV(value);
+	reg |= AT91_WDT_SET_WDD(value);
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	wdd->timeout = timeout;
+
+	return 0;
+}
+
+static const struct watchdog_info atmel_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.firmware_version = 0,
+	.identity = "Atmel SAMA5D4 Watchdog",
+};
+
+static struct watchdog_ops atmel_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = atmel_wdt_start,
+	.stop = atmel_wdt_stop,
+	.ping = atmel_wdt_ping,
+	.set_timeout = atmel_wdt_set_timeout,
+};
+
+static irqreturn_t atmel_wdt_irq_handler(int irq, void *dev_id)
+{
+	struct atmel_wdt *wdt = platform_get_drvdata(dev_id);
+
+	if (wdt_read(wdt, AT91_WDT_SR)) {
+		pr_crit("Atmel Watchdog Software Reset\n");
+		emergency_restart();
+		pr_crit("Reboot didn't ?????\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int of_atmel_wdt_init(struct device_node *np, struct atmel_wdt *wdt)
+{
+	const char *tmp;
+
+	wdt->config = AT91_WDT_WDDIS;
+
+	if (!of_property_read_string(np, "atmel,watchdog-type", &tmp) &&
+	    !strcmp(tmp, "software"))
+		wdt->config |= AT91_WDT_WDFIEN;
+	else
+		wdt->config |= AT91_WDT_WDRSTEN;
+
+	if (of_property_read_bool(np, "atmel,idle-halt"))
+		wdt->config |= AT91_WDT_WDIDLEHLT;
+
+	if (of_property_read_bool(np, "atmel,dbg-halt"))
+		wdt->config |= AT91_WDT_WDDBGHLT;
+
+	return 0;
+}
+
+static int atmel_wdt_init(struct atmel_wdt *wdt)
+{
+	struct watchdog_device *wdd = &wdt->wdd;
+	u32 value = WDT_SEC2TICKS(wdd->timeout);
+	u32 reg;
+
+	/*
+	 * Because the fields WDV and WDD must not be modified when the WDDIS
+	 * bit is set, so clear the WDDIS bit before writing the WDT_MR.
+	 */
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	reg &= ~AT91_WDT_WDDIS;
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	reg = wdt->config;
+	reg |= AT91_WDT_SET_WDD(value);
+	reg |= AT91_WDT_SET_WDV(value);
+
+	wdt_write(wdt, AT91_WDT_MR, reg);
+
+	return 0;
+}
+
+static int atmel_wdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd;
+	struct atmel_wdt *wdt;
+	struct resource *res;
+	void __iomem *regs;
+	int ret, irq = -1;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdd = &wdt->wdd;
+	wdd->timeout = wdt_timeout;
+	wdd->info = &atmel_wdt_info;
+	wdd->ops = &atmel_wdt_ops;
+	wdd->min_timeout = MIN_WDT_TIMEOUT;
+	wdd->max_timeout = MAX_WDT_TIMEOUT;
+
+	watchdog_set_drvdata(wdd, wdt);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	wdt->reg_base = regs;
+
+	if (pdev->dev.of_node) {
+		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+		if (!irq)
+			dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
+
+		ret = of_atmel_wdt_init(pdev->dev.of_node, wdt);
+		if (ret)
+			return ret;
+	}
+
+	if ((wdt->config & AT91_WDT_WDFIEN) && irq > 0) {
+		ret = devm_request_irq(&pdev->dev, irq, atmel_wdt_irq_handler,
+				       0, pdev->name, pdev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"cannot register interrupt handler\n");
+			return ret;
+		}
+	}
+
+	ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to set timeout value\n");
+		return ret;
+	}
+
+	ret = atmel_wdt_init(wdt);
+	if (ret)
+		return ret;
+
+	watchdog_set_nowayout(wdd, nowayout);
+
+	ret = watchdog_register_device(wdd);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register watchdog device\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+
+	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
+		 wdt_timeout, nowayout);
+
+	return 0;
+}
+
+static int atmel_wdt_remove(struct platform_device *pdev)
+{
+	struct atmel_wdt *wdt = platform_get_drvdata(pdev);
+
+	atmel_wdt_stop(&wdt->wdd);
+
+	watchdog_unregister_device(&wdt->wdd);
+
+	return 0;
+}
+
+static const struct of_device_id atmel_wdt_of_match[] = {
+	{ .compatible = "atmel,sama5d4-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, atmel_wdt_of_match);
+
+static struct platform_driver atmel_wdt_driver = {
+	.probe		= atmel_wdt_probe,
+	.remove		= atmel_wdt_remove,
+	.driver		= {
+		.name	= "sama5d4 wdt",
+		.of_match_table = atmel_wdt_of_match,
+	},
+};
+module_platform_driver(atmel_wdt_driver);
+
+MODULE_AUTHOR("Atmel Corporation");
+MODULE_DESCRIPTION("Atmel SAMA5D4 Watchdog Timer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
index c6fbb2e6..b79a83b 100644
--- a/drivers/watchdog/at91sam9_wdt.h
+++ b/drivers/watchdog/at91sam9_wdt.h
@@ -22,11 +22,13 @@
 
 #define AT91_WDT_MR		0x04			/* Watchdog Mode Register */
 #define		AT91_WDT_WDV		(0xfff << 0)		/* Counter Value */
+#define			AT91_WDT_SET_WDV(x)	((x) & AT91_WDT_WDV)
 #define		AT91_WDT_WDFIEN		(1     << 12)		/* Fault Interrupt Enable */
 #define		AT91_WDT_WDRSTEN	(1     << 13)		/* Reset Processor */
 #define		AT91_WDT_WDRPROC	(1     << 14)		/* Timer Restart */
 #define		AT91_WDT_WDDIS		(1     << 15)		/* Watchdog Disable */
 #define		AT91_WDT_WDD		(0xfff << 16)		/* Delta Value */
+#define			AT91_WDT_SET_WDD(x)	(((x) << 16) & AT91_WDT_WDD)
 #define		AT91_WDT_WDDBGHLT	(1     << 28)		/* Debug Halt */
 #define		AT91_WDT_WDIDLEHLT	(1     << 29)		/* Idle Halt */
 
-- 
1.7.9.5

