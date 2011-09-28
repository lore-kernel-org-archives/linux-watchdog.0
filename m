Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40174 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab1I1MaY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Sep 2011 08:30:24 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 3/4] watchdog: add new driver for STMP3xxx and i.MX23/28
Date: Wed, 28 Sep 2011 14:29:56 +0200
Message-Id: <1317212997-26668-4-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
References: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Replace the existing STMP3xxx driver because it has enough drawbacks
that a rewrite is apropriate. The new driver is designed to use the
watchdog framework which makes it a lot smaller. It now uses an exported
function from the RTC driver to set up its registers (the old driver
silently reused the hopefully already remapped RTC registers, uuuh).
Also, this driver is mach independent, while the old one still depends
on a removed mach.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/watchdog/Kconfig            |   10 +++
 drivers/watchdog/Makefile           |    1 +
 drivers/watchdog/stmp3xxx_rtc_wdt.c |  147 +++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/stmp3xxx_rtc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1d8cbe4..5aad0dc 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -305,6 +305,16 @@ config STMP3XXX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called stmp3xxx_wdt.
 
+config STMP3XXX_RTC_WATCHDOG
+	tristate "Freescale STMP3XXX & i.MX23/28 watchdog"
+	depends on RTC_DRV_STMP
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer inside
+	  the RTC for the STMP37XX/378X or i.MX23/28 SoC.
+	  To compile this driver as a module, choose M here: the
+	  module will be called stmp3xxx_rtc_wdt.
+
 config NUC900_WATCHDOG
 	tristate "Nuvoton NUC900 watchdog"
 	depends on ARCH_W90X900
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 55bd574..042076a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_DAVINCI_WATCHDOG) += davinci_wdt.o
 obj-$(CONFIG_ORION_WATCHDOG) += orion_wdt.o
 obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
 obj-$(CONFIG_STMP3XXX_WATCHDOG) += stmp3xxx_wdt.o
+obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
 obj-$(CONFIG_ADX_WATCHDOG) += adx_wdt.o
 obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
new file mode 100644
index 0000000..55645ad
--- /dev/null
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -0,0 +1,147 @@
+/*
+ * Watchdog driver for the RTC based watchdog in STMP3xxx and i.MX23/28
+ *
+ * Author: Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * Copyright (C) 2011 Pengutronix e.K.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+
+#define WDOG_TICK_RATE 1000 /* 1 kHz clock */
+#define STMP3XXX_DEFAULT_TIMEOUT 60
+#define STMP3XXX_MAX_TIMEOUT (UINT_MAX / WDOG_TICK_RATE)
+
+static int timeout = STMP3XXX_DEFAULT_TIMEOUT;
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout period in seconds from 1 to "
+		 __MODULE_STRING(STMP3XXX_MAX_TIMEOUT) ", default "
+		 __MODULE_STRING(STMP3XXX_DEFAULT_TIMEOUT));
+
+/* this function is in the RTC domain */
+extern void stmp3xxx_wdt_setup(struct device *dev, u32 val);
+
+static int wdt_start(struct watchdog_device *wdd)
+{
+	struct platform_device *pdev = watchdog_get_drvdata(wdd);
+
+	stmp3xxx_wdt_setup(pdev->dev.parent, wdd->timeout * WDOG_TICK_RATE);
+	return 0;
+}
+
+static int wdt_stop(struct watchdog_device *wdd)
+{
+	struct platform_device *pdev = watchdog_get_drvdata(wdd);
+
+	stmp3xxx_wdt_setup(pdev->dev.parent, 0);
+	return 0;
+}
+
+static int wdt_set_timeout(struct watchdog_device *wdd, unsigned new_timeout)
+{
+	struct platform_device *pdev = watchdog_get_drvdata(wdd);
+
+	stmp3xxx_wdt_setup(pdev->dev.parent, new_timeout * WDOG_TICK_RATE);
+	return 0;
+}
+
+static const struct watchdog_info stmp3xxx_wdt_ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "STMP3XXX RTC Watchdog",
+};
+
+static const struct watchdog_ops stmp3xxx_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = wdt_start,
+	.stop = wdt_stop,
+	.set_timeout = wdt_set_timeout,
+};
+
+static struct watchdog_device stmp3xxx_wdd = {
+	.info = &stmp3xxx_wdt_ident,
+	.ops = &stmp3xxx_wdt_ops,
+	.min_timeout = 1,
+	.max_timeout = STMP3XXX_MAX_TIMEOUT,
+	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
+};
+
+static int __devinit stmp3xxx_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	watchdog_set_drvdata(&stmp3xxx_wdd, pdev);
+
+	stmp3xxx_wdd.timeout = clamp_t(unsigned, timeout, 1, STMP3XXX_MAX_TIMEOUT);
+
+	ret = watchdog_register_device(&stmp3xxx_wdd);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot register watchdog device\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "initialized watchdog with timeout %ds\n", timeout);
+	return 0;
+}
+
+static int __devexit stmp3xxx_wdt_remove(struct platform_device *pdev)
+{
+	watchdog_unregister_device(&stmp3xxx_wdd);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int stmp3xxx_wdt_suspend(struct platform_device *pdev,
+				pm_message_t state)
+{
+	if (stmp3xxx_wdd.status & WDOG_ACTIVE)
+		wdt_stop(&stmp3xxx_wdd);
+
+	return 0;
+}
+
+static int stmp3xxx_wdt_resume(struct platform_device *pdev)
+{
+	if (stmp3xxx_wdd.status & WDOG_ACTIVE)
+		wdt_start(&stmp3xxx_wdd);
+
+	return 0;
+}
+#else
+#define stmp3xxx_wdt_suspend	NULL
+#define stmp3xxx_wdt_resume	NULL
+#endif
+
+static struct platform_driver stmp3xxx_wdt_driver = {
+	.driver = {
+		.name = "stmp3xxx_rtc_wdt",
+	},
+	.probe = stmp3xxx_wdt_probe,
+	.remove = __devexit_p(stmp3xxx_wdt_remove),
+	.suspend = stmp3xxx_wdt_suspend,
+	.resume = stmp3xxx_wdt_resume,
+};
+
+static int __init stmp3xxx_wdt_init(void)
+{
+	return platform_driver_register(&stmp3xxx_wdt_driver);
+}
+module_init(stmp3xxx_wdt_init);
+
+static void __exit stmp3xxx_wdt_exit(void)
+{
+	return platform_driver_unregister(&stmp3xxx_wdt_driver);
+}
+module_exit(stmp3xxx_wdt_exit);
+
+MODULE_DESCRIPTION("STMP3XXX RTC Watchdog Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.6.3

