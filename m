Return-path: <pantelis.antoniou@konsulko.com>
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jean Delvare <jdelvare@suse.com>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 3/7] watchdog: Add PTX1K I2CS BootFPGA watchdog driver.
Date: Fri,  7 Oct 2016 18:22:00 +0300
Message-Id: <1475853724-22557-4-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

This driver allows using the I2CS watchdog on PTX1K. The
BootFPGA implements a watchdog that allows setting timeout
from predefined set of values from 15 msec to 491 sec.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
Signed-off-by: JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/watchdog/Kconfig           |  15 +++
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/jnx_ptx1kbf_wdt.c | 229 +++++++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/watchdog/jnx_ptx1kbf_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2554f47..a3761eb 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1033,6 +1033,21 @@ config IT87_WDT
 	  To compile this driver as a module, choose M here: the module will
 	  be called it87_wdt.
 
+config JNX_PTX1KBF_WDT
+	tristate "Juniper Networks PTX1000 I2CS BootFPGA Watchdog"
+	depends on X86 && MFD_JUNIPER_PTX1KBF
+	---help---
+	  This is the driver for the watchdog timer built-in on the Juniper
+	  Networks PTX1000 I2CS/BootFPGA and acessible from the LPC bus. The
+	  BootFPGA watchdog allows several predefined thresholds, so this
+	  driver will select a value close to these static values: 15 ms,
+	  30 ms, 60 ms, 120 ms, 240 ms, 480 ms, 960 ms, 1920 ms, 3840 ms,
+	  7680 ms, 15360 ms, 30720 ms, 61440 ms, 122880 ms, 245760 ms and
+	  516096 ms.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called jnx_ptx1kbf_wdt.
+
 config HP_WATCHDOG
 	tristate "HP ProLiant iLO2+ Hardware Watchdog Timer"
 	depends on X86 && PCI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 942b795..f9fafdf 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -111,6 +111,7 @@ endif
 obj-$(CONFIG_IT8712F_WDT) += it8712f_wdt.o
 obj-$(CONFIG_IT87_WDT) += it87_wdt.o
 obj-$(CONFIG_JNX_PTXPMB_WDT) += ptxpmb_wdt.o
+obj-$(CONFIG_JNX_PTX1KBF_WDT) += jnx_ptx1kbf_wdt.o
 obj-$(CONFIG_HP_WATCHDOG) += hpwdt.o
 obj-$(CONFIG_KEMPLD_WDT) += kempld_wdt.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
diff --git a/drivers/watchdog/jnx_ptx1kbf_wdt.c b/drivers/watchdog/jnx_ptx1kbf_wdt.c
new file mode 100644
index 0000000..7d3e0b7
--- /dev/null
+++ b/drivers/watchdog/jnx_ptx1kbf_wdt.c
@@ -0,0 +1,229 @@
+/*
+ * Juniper Networks PTX1K RCB I2CS Boot FPGA watchdog driver
+ *
+ * Copyright (C) 2014 Juniper Networks. All rights reserved.
+ * Author: Georgi Vlaev <gvlaev@juniper.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/watchdog.h>
+#include <linux/mfd/ptx1k-bootfpga.h>
+
+#define WDT_MIN_TIMEOUT		1
+#define WDT_MAX_TIMEOUT		491
+#define WDT_DEFAULT_TIMEOUT	60	/* default heartbeat in seconds */
+
+#define DRVNAME "jnx-ptx1kbf-wdt"
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+
+#define MSW_NOWAYOUT __MODULE_STRING(WATCHDOG_NOWAYOUT)
+MODULE_PARM_DESC(nowayout,
+		 "Cannot be stopped once started (def=" MSW_NOWAYOUT ")");
+
+struct ptx1kbf_wdt {
+	void __iomem *base;
+	struct watchdog_device wdt_dev;
+};
+
+/*
+ * The BOOT_FPGA_WATCHDOG_TIMER_THRESHOLD register defines the watchdog
+ * timer thresholds in ms: 0x0 = 15 ms, 0x1 = 30 ms, ...  0xD = 122880 ms,
+ * 0xE = 245760 ms, 0xF = 492520 ms, or value = (2^index * 15)
+ */
+static int ptx1kbf_index_to_timeout(u8 reg)
+{
+	return ((1 << (reg & WTT_THRESHOLD_MASK)) * 15) / 1000;
+}
+
+static u8 ptx1kbf_timeout_to_index(unsigned int timeout)
+{
+	return fls(timeout * 1000 / 15) & WTT_THRESHOLD_MASK;
+}
+
+static int ptx1kbf_wdt_set_timeout(struct watchdog_device *wdt_dev,
+				   unsigned int timeout)
+{
+	struct ptx1kbf_wdt *wdt = watchdog_get_drvdata(wdt_dev);
+	u8 reg, index;
+
+	if (timeout > WDT_MAX_TIMEOUT)
+		return -EINVAL;
+
+	index = ptx1kbf_timeout_to_index(timeout);
+
+	reg = ioread8(wdt->base + BOOT_FPGA_WATCHDOG_TIMER_THRESHOLD);
+	reg &= ~WTT_THRESHOLD_MASK;
+	reg |= index;
+	iowrite8(reg, wdt->base + BOOT_FPGA_WATCHDOG_TIMER_THRESHOLD);
+
+	/* Set the actual timeout supported by the watchdog */
+	wdt->wdt_dev.timeout = ptx1kbf_index_to_timeout(index);
+
+	return 0;
+}
+
+static int ptx1kbf_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	return ptx1kbf_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+}
+
+static int ptx1kbf_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct ptx1kbf_wdt *wdt = watchdog_get_drvdata(wdt_dev);
+	int ret;
+	u8 reg;
+
+	ret = ptx1kbf_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	if (ret < 0)
+		return ret;
+
+	reg = ioread8(wdt->base + BOOT_FPGA_BOOT_CONTROL);
+	reg |= BC_WDT_ENA;
+	iowrite8(reg, wdt->base + BOOT_FPGA_BOOT_CONTROL);
+
+	return 0;
+}
+
+static int ptx1kbf_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct ptx1kbf_wdt *wdt = watchdog_get_drvdata(wdt_dev);
+	u8 reg;
+
+	reg = ioread8(wdt->base + BOOT_FPGA_BOOT_CONTROL);
+	reg &= ~BC_WDT_ENA;
+	iowrite8(reg, wdt->base + BOOT_FPGA_BOOT_CONTROL);
+
+	return 0;
+}
+
+static struct watchdog_info ptx1kbf_wdt_info = {
+	.options	= WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
+			  WDIOF_MAGICCLOSE,
+	.identity	= "PTX1K BootFPGA Watchdog",
+	.firmware_version = 0,
+};
+
+static const struct watchdog_ops ptx1kbf_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = ptx1kbf_wdt_start,
+	.stop = ptx1kbf_wdt_stop,
+	.ping = ptx1kbf_wdt_ping,
+	.set_timeout = ptx1kbf_wdt_set_timeout,
+};
+
+static int ptx1kbf_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *res;
+	struct ptx1kbf_wdt *wdt;
+	u8 reset_reason1, reset_reason2;
+	unsigned int timeout;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	platform_set_drvdata(pdev, wdt);
+	wdt->wdt_dev.info = &ptx1kbf_wdt_info;
+	wdt->wdt_dev.ops = &ptx1kbf_wdt_ops;
+	wdt->wdt_dev.min_timeout = WDT_MIN_TIMEOUT;
+	wdt->wdt_dev.max_timeout = WDT_MAX_TIMEOUT;
+	wdt->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
+	wdt->wdt_dev.parent = &pdev->dev;
+
+	reset_reason1 = ioread8(wdt->base + BOOT_FPGA_RESET_REASON1);
+	reset_reason2 = ioread8(wdt->base + BOOT_FPGA_RESET_REASON2);
+	if (reset_reason1 & RR1_MSTR)
+		wdt->wdt_dev.bootstatus |= WDIOF_EXTERN1;
+	else if (reset_reason1 & RR1_BUTTON)
+		wdt->wdt_dev.bootstatus |= WDIOF_EXTERN2;
+	else if (reset_reason1 & RR1_WDOG)
+		wdt->wdt_dev.bootstatus |= WDIOF_CARDRESET;
+	else if (reset_reason1 & RR1_POWER_FAIL)
+		wdt->wdt_dev.bootstatus |= WDIOF_POWERUNDER;
+	else if (reset_reason1 & RR1_THERM_TRIP)
+		wdt->wdt_dev.bootstatus |= WDIOF_OVERHEAT;
+	else if (reset_reason1 & RR2_AUTO_POWER_OFF)
+		wdt->wdt_dev.bootstatus |= WDIOF_FANFAULT;
+
+	/* Report the FPGA/WDT version */
+	ptx1kbf_wdt_info.firmware_version =
+				ioread8(wdt->base + BOOT_FPGA_VERSION);
+
+	/*
+	 * The PTX1K BIOS configures the timeout when the FPGA watchdog
+	 * is enabled. Index values < 0x07 set thresholds bellow 1s,
+	 * so we can ignore them
+	 */
+	timeout = ptx1kbf_index_to_timeout(ioread8(wdt->base +
+				BOOT_FPGA_WATCHDOG_TIMER_THRESHOLD));
+
+	watchdog_init_timeout(&wdt->wdt_dev, timeout, &pdev->dev);
+	watchdog_set_nowayout(&wdt->wdt_dev, nowayout);
+	watchdog_set_drvdata(&wdt->wdt_dev, wdt);
+
+	/* Stop the watchdog if BIOS has enabled it */
+	ptx1kbf_wdt_stop(&wdt->wdt_dev);
+
+	ret = watchdog_register_device(&wdt->wdt_dev);
+	if (ret)
+		return ret;
+
+	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
+		 wdt->wdt_dev.timeout, nowayout);
+
+	return 0;
+}
+
+static int ptx1kbf_wdt_remove(struct platform_device *pdev)
+{
+	struct ptx1kbf_wdt *wdt = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&wdt->wdt_dev);
+
+	return 0;
+}
+
+static const struct of_device_id ptx1kbf_wdt_of_ids[] = {
+	{ .compatible = "jnx,ptx1kbf-wdt", NULL },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ptx1kbf_wdt_of_ids);
+
+static struct platform_driver ptx1kbf_wdt_driver = {
+	.probe	= ptx1kbf_wdt_probe,
+	.remove = ptx1kbf_wdt_remove,
+	.driver = {
+		.name = DRVNAME,
+		.owner = THIS_MODULE,
+		.of_match_table = ptx1kbf_wdt_of_ids,
+	},
+};
+
+module_platform_driver(ptx1kbf_wdt_driver);
+
+MODULE_DESCRIPTION("Juniper Networks PTX1K RCB I2CS Boot FPGA watchdog driver");
+MODULE_AUTHOR("Georgi Vlaev <gvlaev@juniper.net>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRVNAME);
-- 
1.9.1
