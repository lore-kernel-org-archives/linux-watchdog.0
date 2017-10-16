Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:50203 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755144AbdJPU4t (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Oct 2017 16:56:49 -0400
Received: by mail-lf0-f47.google.com with SMTP id a132so18451708lfa.7
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Oct 2017 13:56:48 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5 v2] watchdog: gemini/ftwdt010: rename driver and symbols
Date: Mon, 16 Oct 2017 22:54:24 +0200
Message-Id: <20171016205427.4297-2-linus.walleij@linaro.org>
In-Reply-To: <20171016205427.4297-1-linus.walleij@linaro.org>
References: <20171016205427.4297-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This renames all the driver files and symbols for the Gemini
watchdog to FTWDT010 as it has been revealed that this IP block
is a generic watchdog timer from Faraday Technology used in
several SoC designs.

Select this driver by default for the Gemini, it is a sensible
driver to always have enabled.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fixed speling in commit message, rebased.
---
 drivers/watchdog/Kconfig                          |  14 +--
 drivers/watchdog/Makefile                         |   2 +-
 drivers/watchdog/{gemini_wdt.c => ftwdt010_wdt.c} | 117 +++++++++++-----------
 3 files changed, 68 insertions(+), 65 deletions(-)
 rename drivers/watchdog/{gemini_wdt.c => ftwdt010_wdt.c} (50%)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c722cbfdc7e6..fd44a542036a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -321,16 +321,18 @@ config 977_WATCHDOG
 
 	  Not sure? It's safe to say N.
 
-config GEMINI_WATCHDOG
-	tristate "Gemini watchdog"
-	depends on ARCH_GEMINI
+config FTWDT010_WATCHDOG
+	tristate "Faraday Technology FTWDT010 watchdog"
+	depends on ARM || COMPILE_TEST
 	select WATCHDOG_CORE
+	default ARCH_GEMINI
 	help
-	  Say Y here if to include support for the watchdog timer
-	  embedded in the Cortina Systems Gemini family of devices.
+	  Say Y here if to include support for the Faraday Technology
+	  FTWDT010 watchdog timer embedded in the Cortina Systems Gemini
+	  family of devices.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called gemini_wdt.
+	  module will be called ftwdt010_wdt.
 
 config IXP4XX_WATCHDOG
 	tristate "IXP4xx Watchdog"
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 56adf9fa67d0..df91d7db821c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_OMAP_WATCHDOG) += omap_wdt.o
 obj-$(CONFIG_TWL4030_WATCHDOG) += twl4030_wdt.o
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
-obj-$(CONFIG_GEMINI_WATCHDOG) += gemini_wdt.o
+obj-$(CONFIG_FTWDT010_WATCHDOG) += ftwdt010_wdt.o
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_KS8695_WATCHDOG) += ks8695_wdt.o
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
diff --git a/drivers/watchdog/gemini_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
similarity index 50%
rename from drivers/watchdog/gemini_wdt.c
rename to drivers/watchdog/ftwdt010_wdt.c
index 8155aa619e4c..637ffd812f0b 100644
--- a/drivers/watchdog/gemini_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -1,5 +1,5 @@
 /*
- * Watchdog driver for Cortina Systems Gemini SoC
+ * Watchdog driver for Faraday Technology FTWDT010
  *
  * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
  *
@@ -22,10 +22,10 @@
 #include <linux/slab.h>
 #include <linux/watchdog.h>
 
-#define GEMINI_WDCOUNTER	0x0
-#define GEMINI_WDLOAD		0x4
-#define GEMINI_WDRESTART	0x8
-#define GEMINI_WDCR		0xC
+#define FTWDT010_WDCOUNTER	0x0
+#define FTWDT010_WDLOAD		0x4
+#define FTWDT010_WDRESTART	0x8
+#define FTWDT010_WDCR		0xC
 
 #define WDRESTART_MAGIC		0x5AB9
 
@@ -35,79 +35,79 @@
 
 #define WDT_CLOCK		5000000		/* 5 MHz */
 
-struct gemini_wdt {
+struct ftwdt010_wdt {
 	struct watchdog_device	wdd;
 	struct device		*dev;
 	void __iomem		*base;
 };
 
 static inline
-struct gemini_wdt *to_gemini_wdt(struct watchdog_device *wdd)
+struct ftwdt010_wdt *to_ftwdt010_wdt(struct watchdog_device *wdd)
 {
-	return container_of(wdd, struct gemini_wdt, wdd);
+	return container_of(wdd, struct ftwdt010_wdt, wdd);
 }
 
-static int gemini_wdt_start(struct watchdog_device *wdd)
+static int ftwdt010_wdt_start(struct watchdog_device *wdd)
 {
-	struct gemini_wdt *gwdt = to_gemini_wdt(wdd);
+	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
 
-	writel(wdd->timeout * WDT_CLOCK, gwdt->base + GEMINI_WDLOAD);
-	writel(WDRESTART_MAGIC, gwdt->base + GEMINI_WDRESTART);
+	writel(wdd->timeout * WDT_CLOCK, gwdt->base + FTWDT010_WDLOAD);
+	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
 	/* set clock before enabling */
 	writel(WDCR_CLOCK_5MHZ | WDCR_SYS_RST,
-			gwdt->base + GEMINI_WDCR);
+			gwdt->base + FTWDT010_WDCR);
 	writel(WDCR_CLOCK_5MHZ | WDCR_SYS_RST | WDCR_ENABLE,
-			gwdt->base + GEMINI_WDCR);
+			gwdt->base + FTWDT010_WDCR);
 
 	return 0;
 }
 
-static int gemini_wdt_stop(struct watchdog_device *wdd)
+static int ftwdt010_wdt_stop(struct watchdog_device *wdd)
 {
-	struct gemini_wdt *gwdt = to_gemini_wdt(wdd);
+	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
 
-	writel(0, gwdt->base + GEMINI_WDCR);
+	writel(0, gwdt->base + FTWDT010_WDCR);
 
 	return 0;
 }
 
-static int gemini_wdt_ping(struct watchdog_device *wdd)
+static int ftwdt010_wdt_ping(struct watchdog_device *wdd)
 {
-	struct gemini_wdt *gwdt = to_gemini_wdt(wdd);
+	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
 
-	writel(WDRESTART_MAGIC, gwdt->base + GEMINI_WDRESTART);
+	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
 
 	return 0;
 }
 
-static int gemini_wdt_set_timeout(struct watchdog_device *wdd,
+static int ftwdt010_wdt_set_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout)
 {
 	wdd->timeout = timeout;
 	if (watchdog_active(wdd))
-		gemini_wdt_start(wdd);
+		ftwdt010_wdt_start(wdd);
 
 	return 0;
 }
 
-static irqreturn_t gemini_wdt_interrupt(int irq, void *data)
+static irqreturn_t ftwdt010_wdt_interrupt(int irq, void *data)
 {
-	struct gemini_wdt *gwdt = data;
+	struct ftwdt010_wdt *gwdt = data;
 
 	watchdog_notify_pretimeout(&gwdt->wdd);
 
 	return IRQ_HANDLED;
 }
 
-static const struct watchdog_ops gemini_wdt_ops = {
-	.start		= gemini_wdt_start,
-	.stop		= gemini_wdt_stop,
-	.ping		= gemini_wdt_ping,
-	.set_timeout	= gemini_wdt_set_timeout,
+static const struct watchdog_ops ftwdt010_wdt_ops = {
+	.start		= ftwdt010_wdt_start,
+	.stop		= ftwdt010_wdt_stop,
+	.ping		= ftwdt010_wdt_ping,
+	.set_timeout	= ftwdt010_wdt_set_timeout,
 	.owner		= THIS_MODULE,
 };
 
-static const struct watchdog_info gemini_wdt_info = {
+static const struct watchdog_info ftwdt010_wdt_info = {
 	.options	= WDIOF_KEEPALIVEPING
 			| WDIOF_MAGICCLOSE
 			| WDIOF_SETTIMEOUT,
@@ -115,11 +115,11 @@ static const struct watchdog_info gemini_wdt_info = {
 };
 
 
-static int gemini_wdt_probe(struct platform_device *pdev)
+static int ftwdt010_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct gemini_wdt *gwdt;
+	struct ftwdt010_wdt *gwdt;
 	unsigned int reg;
 	int irq;
 	int ret;
@@ -138,8 +138,8 @@ static int gemini_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	gwdt->dev = dev;
-	gwdt->wdd.info = &gemini_wdt_info;
-	gwdt->wdd.ops = &gemini_wdt_ops;
+	gwdt->wdd.info = &ftwdt010_wdt_info;
+	gwdt->wdd.ops = &ftwdt010_wdt_ops;
 	gwdt->wdd.min_timeout = 1;
 	gwdt->wdd.max_timeout = 0xFFFFFFFF / WDT_CLOCK;
 	gwdt->wdd.parent = dev;
@@ -151,14 +151,14 @@ static int gemini_wdt_probe(struct platform_device *pdev)
 	gwdt->wdd.timeout = 13U;
 	watchdog_init_timeout(&gwdt->wdd, 0, dev);
 
-	reg = readw(gwdt->base + GEMINI_WDCR);
+	reg = readw(gwdt->base + FTWDT010_WDCR);
 	if (reg & WDCR_ENABLE) {
 		/* Watchdog was enabled by the bootloader, disable it. */
 		reg &= ~WDCR_ENABLE;
-		writel(reg, gwdt->base + GEMINI_WDCR);
+		writel(reg, gwdt->base + FTWDT010_WDCR);
 	}
 
-	ret = devm_request_irq(dev, irq, gemini_wdt_interrupt, 0,
+	ret = devm_request_irq(dev, irq, ftwdt010_wdt_interrupt, 0,
 			       "watchdog bark", gwdt);
 	if (ret)
 		return ret;
@@ -171,59 +171,60 @@ static int gemini_wdt_probe(struct platform_device *pdev)
 
 	/* Set up platform driver data */
 	platform_set_drvdata(pdev, gwdt);
-	dev_info(dev, "Gemini watchdog driver enabled\n");
+	dev_info(dev, "FTWDT010 watchdog driver enabled\n");
 
 	return 0;
 }
 
-static int __maybe_unused gemini_wdt_suspend(struct device *dev)
+static int __maybe_unused ftwdt010_wdt_suspend(struct device *dev)
 {
-	struct gemini_wdt *gwdt = dev_get_drvdata(dev);
+	struct ftwdt010_wdt *gwdt = dev_get_drvdata(dev);
 	unsigned int reg;
 
-	reg = readw(gwdt->base + GEMINI_WDCR);
+	reg = readw(gwdt->base + FTWDT010_WDCR);
 	reg &= ~WDCR_ENABLE;
-	writel(reg, gwdt->base + GEMINI_WDCR);
+	writel(reg, gwdt->base + FTWDT010_WDCR);
 
 	return 0;
 }
 
-static int __maybe_unused gemini_wdt_resume(struct device *dev)
+static int __maybe_unused ftwdt010_wdt_resume(struct device *dev)
 {
-	struct gemini_wdt *gwdt = dev_get_drvdata(dev);
+	struct ftwdt010_wdt *gwdt = dev_get_drvdata(dev);
 	unsigned int reg;
 
 	if (watchdog_active(&gwdt->wdd)) {
-		reg = readw(gwdt->base + GEMINI_WDCR);
+		reg = readw(gwdt->base + FTWDT010_WDCR);
 		reg |= WDCR_ENABLE;
-		writel(reg, gwdt->base + GEMINI_WDCR);
+		writel(reg, gwdt->base + FTWDT010_WDCR);
 	}
 
 	return 0;
 }
 
-static const struct dev_pm_ops gemini_wdt_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(gemini_wdt_suspend,
-				gemini_wdt_resume)
+static const struct dev_pm_ops ftwdt010_wdt_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ftwdt010_wdt_suspend,
+				ftwdt010_wdt_resume)
 };
 
 #ifdef CONFIG_OF
-static const struct of_device_id gemini_wdt_match[] = {
+static const struct of_device_id ftwdt010_wdt_match[] = {
+	{ .compatible = "faraday,ftwdt010" },
 	{ .compatible = "cortina,gemini-watchdog" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, gemini_wdt_match);
+MODULE_DEVICE_TABLE(of, ftwdt010_wdt_match);
 #endif
 
-static struct platform_driver gemini_wdt_driver = {
-	.probe		= gemini_wdt_probe,
+static struct platform_driver ftwdt010_wdt_driver = {
+	.probe		= ftwdt010_wdt_probe,
 	.driver		= {
-		.name	= "gemini-wdt",
-		.of_match_table = of_match_ptr(gemini_wdt_match),
-		.pm = &gemini_wdt_dev_pm_ops,
+		.name	= "ftwdt010-wdt",
+		.of_match_table = of_match_ptr(ftwdt010_wdt_match),
+		.pm = &ftwdt010_wdt_dev_pm_ops,
 	},
 };
-module_platform_driver(gemini_wdt_driver);
+module_platform_driver(ftwdt010_wdt_driver);
 MODULE_AUTHOR("Linus Walleij");
-MODULE_DESCRIPTION("Watchdog driver for Gemini");
+MODULE_DESCRIPTION("Watchdog driver for Faraday Technology FTWDT010");
 MODULE_LICENSE("GPL");
-- 
2.13.6

