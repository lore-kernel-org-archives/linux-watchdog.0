Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:53505 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3FFTdz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Jun 2013 15:33:55 -0400
Received: by mail-ea0-f182.google.com with SMTP id r16so2998479ead.27
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Jun 2013 12:33:54 -0700 (PDT)
From: Carlo Caione <carlo.caione@gmail.com>
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	maxime.ripard@free-electrons.com, henrik@henriknordstrom.net,
	linux@roeck-us.net
Cc: Carlo Caione <carlo.caione@gmail.com>
Subject: [PATCH v5] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Date: Thu,  6 Jun 2013 21:34:25 +0200
Message-Id: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds the driver for the watchdog found in the Allwinner A10 and
A13 SoCs. It has DT-support and uses the new watchdog framework.

Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
---
 drivers/watchdog/Kconfig     |  10 ++
 drivers/watchdog/Makefile    |   1 +
 drivers/watchdog/sunxi_wdt.c | 231 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/watchdog/sunxi_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e89fc31..8ad2238 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -299,6 +299,16 @@ config ORION_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called orion_wdt.
 
+config SUNXI_WATCHDOG
+	tristate "Allwinner SoCs watchdog support"
+	depends on ARCH_SUNXI
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in Allwinner SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called sunxi_wdt.
+
 config COH901327_WATCHDOG
 	bool "ST-Ericsson COH 901 327 watchdog"
 	depends on ARCH_U300
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index a300b94..5012d5f 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_PNX4008_WATCHDOG) += pnx4008_wdt.o
 obj-$(CONFIG_IOP_WATCHDOG) += iop_wdt.o
 obj-$(CONFIG_DAVINCI_WATCHDOG) += davinci_wdt.o
 obj-$(CONFIG_ORION_WATCHDOG) += orion_wdt.o
+obj-$(CONFIG_SUNXI_WATCHDOG) += sunxi_wdt.o
 obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
 obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
new file mode 100644
index 0000000..69d4d44
--- /dev/null
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -0,0 +1,231 @@
+/*
+ *      sunxi Watchdog Driver
+ *
+ *      Copyright (c) 2013 Carlo Caione
+ *                    2012 Henrik Nordstrom
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ *      Based on xen_wdt.c
+ *      (c) Copyright 2010 Novell, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define WDT_MAX_TIMEOUT         16
+#define WDT_MIN_TIMEOUT         1
+#define WDT_MODE_TIMEOUT(n)     ((n) << 3)
+#define WDT_TIMEOUT_MASK        WDT_MODE_TIMEOUT(0x0F)
+
+#define WDT_CTRL                0x00
+#define WDT_CTRL_RELOAD         ((1 << 0) | (0x0a57 << 1))
+
+#define WDT_MODE                0x04
+#define WDT_MODE_EN             (1 << 0)
+#define WDT_MODE_RST_EN         (1 << 1)
+
+#define DRV_NAME		"sunxi-wdt"
+#define DRV_VERSION		"1.0"
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+static int heartbeat = WDT_MAX_TIMEOUT;
+
+struct sunxi_wdt_dev {
+	struct watchdog_device wdt_dev;
+	void __iomem *wdt_base;
+};
+
+/*
+ * wdt_timeout_map maps the watchdog timer interval value in seconds to
+ * the value of the register WDT_MODE bit 3:6
+ *
+ * [timeout seconds] = register value
+ *
+ */
+
+static const int wdt_timeout_map[] = {
+	[1] = 0b0001,  /* 1s  */
+	[2] = 0b0010,  /* 2s  */
+	[3] = 0b0011,  /* 3s  */
+	[4] = 0b0100,  /* 4s  */
+	[5] = 0b0101,  /* 5s  */
+	[6] = 0b0110,  /* 6s  */
+	[8] = 0b0111,  /* 8s  */
+	[10] = 0b1000, /* 10s */
+	[12] = 0b1001, /* 12s */
+	[14] = 0b1010, /* 14s */
+	[16] = 0b1011, /* 16s */
+};
+
+static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = sunxi_wdt->wdt_base;
+
+	iowrite32(WDT_CTRL_RELOAD, wdt_base + WDT_CTRL);
+
+	return 0;
+}
+
+static int sunxi_wdt_set_timeout(struct watchdog_device *wdt_dev,
+		unsigned int timeout)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = sunxi_wdt->wdt_base;
+	u32 reg;
+
+	if (timeout > WDT_MAX_TIMEOUT)
+		return -EINVAL;
+
+	if (wdt_timeout_map[timeout] == 0)
+		timeout++;
+
+	sunxi_wdt->wdt_dev.timeout = timeout;
+
+	reg = ioread32(wdt_base + WDT_MODE);
+	reg &= ~WDT_TIMEOUT_MASK;
+	reg |= WDT_MODE_TIMEOUT(wdt_timeout_map[timeout]);
+	iowrite32(reg, wdt_base + WDT_MODE);
+
+	sunxi_wdt_ping(wdt_dev);
+
+	return 0;
+}
+
+static int sunxi_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = sunxi_wdt->wdt_base;
+
+	iowrite32(0, wdt_base + WDT_MODE);
+
+	return 0;
+}
+
+static int sunxi_wdt_start(struct watchdog_device *wdt_dev)
+{
+	u32 reg;
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = sunxi_wdt->wdt_base;
+	int ret;
+
+	ret = sunxi_wdt_set_timeout(&sunxi_wdt->wdt_dev,
+			sunxi_wdt->wdt_dev.timeout);
+	if (ret < 0)
+		return ret;
+
+	reg = ioread32(wdt_base + WDT_MODE);
+	reg |= (WDT_MODE_RST_EN | WDT_MODE_EN);
+	iowrite32(reg, wdt_base + WDT_MODE);
+
+	return 0;
+}
+
+static const struct watchdog_info sunxi_wdt_info = {
+	.identity	= DRV_NAME,
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops sunxi_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= sunxi_wdt_start,
+	.stop		= sunxi_wdt_stop,
+	.ping		= sunxi_wdt_ping,
+	.set_timeout	= sunxi_wdt_set_timeout,
+};
+
+static int __init sunxi_wdt_probe(struct platform_device *pdev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt;
+	struct resource *res;
+	int err;
+
+	sunxi_wdt = devm_kzalloc(&pdev->dev, sizeof(*sunxi_wdt), GFP_KERNEL);
+	if (!sunxi_wdt)
+		return -EINVAL;
+
+	platform_set_drvdata(pdev, sunxi_wdt);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sunxi_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(sunxi_wdt->wdt_base))
+		return PTR_ERR(sunxi_wdt->wdt_base);
+
+	sunxi_wdt->wdt_dev.info = &sunxi_wdt_info;
+	sunxi_wdt->wdt_dev.ops = &sunxi_wdt_ops;
+	sunxi_wdt->wdt_dev.timeout = WDT_MAX_TIMEOUT;
+	sunxi_wdt->wdt_dev.max_timeout = WDT_MAX_TIMEOUT;
+	sunxi_wdt->wdt_dev.min_timeout = WDT_MIN_TIMEOUT;
+	sunxi_wdt->wdt_dev.parent = &pdev->dev;
+
+	watchdog_init_timeout(&sunxi_wdt->wdt_dev, heartbeat, &pdev->dev);
+	watchdog_set_nowayout(&sunxi_wdt->wdt_dev, nowayout);
+
+	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, sunxi_wdt);
+
+	err = watchdog_register_device(&sunxi_wdt->wdt_dev);
+	if (unlikely(err))
+		return err;
+
+	dev_info(&pdev->dev, "Watchdog enabled (heartbeat=%d sec, nowayout=%d)",
+			sunxi_wdt->wdt_dev.timeout, nowayout);
+
+	return 0;
+}
+
+static int __exit sunxi_wdt_remove(struct platform_device *pdev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&sunxi_wdt->wdt_dev);
+	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id sunxi_wdt_dt_ids[] = {
+	{ .compatible = "allwinner,sun4i-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
+
+static struct platform_driver sunxi_wdt_driver = {
+	.probe		= sunxi_wdt_probe,
+	.remove		= sunxi_wdt_remove,
+	.driver		= {
+		.owner		= THIS_MODULE,
+		.name		= DRV_NAME,
+		.of_match_table	= of_match_ptr(sunxi_wdt_dt_ids)
+	},
+};
+
+module_platform_driver(sunxi_wdt_driver);
+
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds");
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+		"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Carlo Caione <carlo.caione@gmail.com>");
+MODULE_AUTHOR("Henrik Nordstrom <henrik@henriknordstrom.net>");
+MODULE_DESCRIPTION("sunxi WatchDog Timer Driver");
+MODULE_VERSION(DRV_VERSION);
-- 
1.8.2.3

