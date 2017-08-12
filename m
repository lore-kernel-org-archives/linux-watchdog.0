Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34605 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdHLSns (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 12 Aug 2017 14:43:48 -0400
Received: by mail-lf0-f49.google.com with SMTP id g25so26978782lfh.1
        for <linux-watchdog@vger.kernel.org>; Sat, 12 Aug 2017 11:43:47 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/11] watchdog: ftwdt010/moxart: Merge MOXA ART into FTWDT010
Date: Sat, 12 Aug 2017 20:43:15 +0200
Message-Id: <20170812184318.10144-9-linus.walleij@linaro.org>
In-Reply-To: <20170812184318.10144-1-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

These two drivers is for the same hardware, the only difference
is that Gemini uses the EXTCLK @5MHz by default (it also works
fine using PCLK) while the MOXA ART is using the PCLK to clock
the watchdog.

Delete the old MOXA ART driver and augment the FTWDT010 to
probe on this platform too, fetching the operating frequency
from the PCLK. Select the driver by default for ARCH_MOXART
to make a smooth transition of the platform.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/watchdog/Kconfig        |  11 +--
 drivers/watchdog/Makefile       |   1 -
 drivers/watchdog/ftwdt010_wdt.c |   1 +
 drivers/watchdog/moxart_wdt.c   | 178 ----------------------------------------
 4 files changed, 2 insertions(+), 189 deletions(-)
 delete mode 100644 drivers/watchdog/moxart_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fd44a542036a..beef6bb5c6d9 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -326,6 +326,7 @@ config FTWDT010_WATCHDOG
 	depends on ARM || COMPILE_TEST
 	select WATCHDOG_CORE
 	default ARCH_GEMINI
+	default ARCH_MOXART
 	help
 	  Say Y here if to include support for the Faraday Technology
 	  FTWDT010 watchdog timer embedded in the Cortina Systems Gemini
@@ -609,16 +610,6 @@ config RETU_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called retu_wdt.
 
-config MOXART_WDT
-	tristate "MOXART watchdog"
-	depends on ARCH_MOXART || COMPILE_TEST
-	help
-	  Say Y here to include Watchdog timer support for the watchdog
-	  existing on the MOXA ART SoC series platforms.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called moxart_wdt.
-
 config SIRFSOC_WATCHDOG
 	tristate "SiRFSOC watchdog"
 	depends on ARCH_SIRF || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index df91d7db821c..fcab71f0a1c7 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -68,7 +68,6 @@ obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
 obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
 obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
 obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
-obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
 obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
 obj-$(CONFIG_ST_LPC_WATCHDOG) += st_lpc_wdt.o
 obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index 7fc865eea28d..912b55e67110 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -298,6 +298,7 @@ static const struct dev_pm_ops ftwdt010_wdt_dev_pm_ops = {
 static const struct of_device_id ftwdt010_wdt_match[] = {
 	{ .compatible = "faraday,ftwdt010" },
 	{ .compatible = "cortina,gemini-watchdog" },
+	{ .compatible = "moxa,moxart-watchdog" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ftwdt010_wdt_match);
diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
deleted file mode 100644
index 2c4a73d1e214..000000000000
--- a/drivers/watchdog/moxart_wdt.c
+++ /dev/null
@@ -1,178 +0,0 @@
-/*
- * MOXA ART SoCs watchdog driver.
- *
- * Copyright (C) 2013 Jonas Jensen
- *
- * Jonas Jensen <jonas.jensen@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/watchdog.h>
-#include <linux/moduleparam.h>
-
-#define REG_COUNT			0x4
-#define REG_MODE			0x8
-#define REG_ENABLE			0xC
-
-struct moxart_wdt_dev {
-	struct watchdog_device dev;
-	void __iomem *base;
-	unsigned int clock_frequency;
-};
-
-static int heartbeat;
-
-static int moxart_wdt_restart(struct watchdog_device *wdt_dev,
-			      unsigned long action, void *data)
-{
-	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
-
-	writel(1, moxart_wdt->base + REG_COUNT);
-	writel(0x5ab9, moxart_wdt->base + REG_MODE);
-	writel(0x03, moxart_wdt->base + REG_ENABLE);
-
-	return 0;
-}
-
-static int moxart_wdt_stop(struct watchdog_device *wdt_dev)
-{
-	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
-
-	writel(0, moxart_wdt->base + REG_ENABLE);
-
-	return 0;
-}
-
-static int moxart_wdt_start(struct watchdog_device *wdt_dev)
-{
-	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
-
-	writel(moxart_wdt->clock_frequency * wdt_dev->timeout,
-	       moxart_wdt->base + REG_COUNT);
-	writel(0x5ab9, moxart_wdt->base + REG_MODE);
-	writel(0x03, moxart_wdt->base + REG_ENABLE);
-
-	return 0;
-}
-
-static int moxart_wdt_set_timeout(struct watchdog_device *wdt_dev,
-				  unsigned int timeout)
-{
-	wdt_dev->timeout = timeout;
-
-	return 0;
-}
-
-static const struct watchdog_info moxart_wdt_info = {
-	.identity       = "moxart-wdt",
-	.options        = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
-			  WDIOF_MAGICCLOSE,
-};
-
-static const struct watchdog_ops moxart_wdt_ops = {
-	.owner          = THIS_MODULE,
-	.start          = moxart_wdt_start,
-	.stop           = moxart_wdt_stop,
-	.set_timeout    = moxart_wdt_set_timeout,
-	.restart        = moxart_wdt_restart,
-};
-
-static int moxart_wdt_probe(struct platform_device *pdev)
-{
-	struct moxart_wdt_dev *moxart_wdt;
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
-	struct resource *res;
-	struct clk *clk;
-	int err;
-	unsigned int max_timeout;
-	bool nowayout = WATCHDOG_NOWAYOUT;
-
-	moxart_wdt = devm_kzalloc(dev, sizeof(*moxart_wdt), GFP_KERNEL);
-	if (!moxart_wdt)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, moxart_wdt);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	moxart_wdt->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(moxart_wdt->base))
-		return PTR_ERR(moxart_wdt->base);
-
-	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk)) {
-		pr_err("%s: of_clk_get failed\n", __func__);
-		return PTR_ERR(clk);
-	}
-
-	moxart_wdt->clock_frequency = clk_get_rate(clk);
-	if (moxart_wdt->clock_frequency == 0) {
-		pr_err("%s: incorrect clock frequency\n", __func__);
-		return -EINVAL;
-	}
-
-	max_timeout = UINT_MAX / moxart_wdt->clock_frequency;
-
-	moxart_wdt->dev.info = &moxart_wdt_info;
-	moxart_wdt->dev.ops = &moxart_wdt_ops;
-	moxart_wdt->dev.timeout = max_timeout;
-	moxart_wdt->dev.min_timeout = 1;
-	moxart_wdt->dev.max_timeout = max_timeout;
-	moxart_wdt->dev.parent = dev;
-
-	watchdog_init_timeout(&moxart_wdt->dev, heartbeat, dev);
-	watchdog_set_nowayout(&moxart_wdt->dev, nowayout);
-	watchdog_set_restart_priority(&moxart_wdt->dev, 128);
-
-	watchdog_set_drvdata(&moxart_wdt->dev, moxart_wdt);
-
-	err = watchdog_register_device(&moxart_wdt->dev);
-	if (err)
-		return err;
-
-	dev_dbg(dev, "Watchdog enabled (heartbeat=%d sec, nowayout=%d)\n",
-		moxart_wdt->dev.timeout, nowayout);
-
-	return 0;
-}
-
-static int moxart_wdt_remove(struct platform_device *pdev)
-{
-	struct moxart_wdt_dev *moxart_wdt = platform_get_drvdata(pdev);
-
-	moxart_wdt_stop(&moxart_wdt->dev);
-
-	return 0;
-}
-
-static const struct of_device_id moxart_watchdog_match[] = {
-	{ .compatible = "moxa,moxart-watchdog" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, moxart_watchdog_match);
-
-static struct platform_driver moxart_wdt_driver = {
-	.probe      = moxart_wdt_probe,
-	.remove     = moxart_wdt_remove,
-	.driver     = {
-		.name		= "moxart-watchdog",
-		.of_match_table	= moxart_watchdog_match,
-	},
-};
-module_platform_driver(moxart_wdt_driver);
-
-module_param(heartbeat, int, 0);
-MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds");
-
-MODULE_DESCRIPTION("MOXART watchdog driver");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Jonas Jensen <jonas.jensen@gmail.com>");
-- 
2.13.4

