Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:56141 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753313AbcBVP2K (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 10:28:10 -0500
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, joshc@ni.com, david.madden@ni.com
Subject: [PATCH v3] watchdog: ni903x_wdt: Add NI 903x/913x watchdog driver
Date: Mon, 22 Feb 2016 09:28:23 -0600
Message-Id: <1456154903-22271-1-git-send-email-kyle.roeschley@ni.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
time controllers.

Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
v3: Rename ni9x3x_wdt -> ni903x_wdt
    Remove 64-bit rounding workarounds
    Add WDIOF_MAGICCLOSE
    Cleanup ACPI resource walking
    Fixup acpi_add error handling
    Cleanup includes, formatting, license/copyright

v2: Rename niwatchdog -> ni9x3x_wdt
    Drop custom IOCTLs
    Remove locking, io_size, expired, running, available
    Remove all IRQ code
    Fix error handling in acpi_add
    Remove unnecessary header file

 Documentation/watchdog/watchdog-parameters.txt |   5 +
 drivers/watchdog/Kconfig                       |  11 +
 drivers/watchdog/Makefile                      |   1 +
 drivers/watchdog/ni903x_wdt.c                  | 270 +++++++++++++++++++++++++
 4 files changed, 287 insertions(+)
 create mode 100644 drivers/watchdog/ni903x_wdt.c

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 9f9ec9f..df3e20e 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -200,6 +200,11 @@ mv64x60_wdt:
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
+ni903x_wdt:
+timeout: Intial watchdog timeout in seconds (0<timeout<516, default=60)
+nowayout: Watchdog cannot be stopped once started
+	(default=kernel config parameter)
+-------------------------------------------------
 nuc900_wdt:
 heartbeat: Watchdog heartbeats in seconds.
 	(default = 15)
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0f6d851..8158cd5 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1214,6 +1214,17 @@ config SBC_EPX_C3_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sbc_epx_c3.
 
+config NI903X_WDT
+	tristate "NI 903x/913x Watchdog"
+	depends on X86 && ACPI
+	select WATCHDOG_CORE
+	---help---
+	  This is the driver for the watchdog timer on the National Instruments
+	  903x/913x real-time controllers.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ni903x_wdt.
+
 # M32R Architecture
 
 # M68K Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f566753..5a23529 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
 obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
+obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
 
 # M32R Architecture
 
diff --git a/drivers/watchdog/ni903x_wdt.c b/drivers/watchdog/ni903x_wdt.c
new file mode 100644
index 0000000..dc67742
--- /dev/null
+++ b/drivers/watchdog/ni903x_wdt.c
@@ -0,0 +1,270 @@
+/*
+ * Copyright (C) 2016 National Instruments Corp.
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
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+
+#define NIWD_CONTROL	0x01
+#define NIWD_COUNTER2	0x02
+#define NIWD_COUNTER1	0x03
+#define NIWD_COUNTER0	0x04
+#define NIWD_SEED2	0x05
+#define NIWD_SEED1	0x06
+#define NIWD_SEED0	0x07
+
+#define NIWD_IO_SIZE	0x08
+
+#define NIWD_CONTROL_MODE		0x80
+#define NIWD_CONTROL_PROC_RESET		0x20
+#define NIWD_CONTROL_PET		0x10
+#define NIWD_CONTROL_RUNNING		0x08
+#define NIWD_CONTROL_CAPTURECOUNTER	0x04
+#define NIWD_CONTROL_RESET		0x02
+#define NIWD_CONTROL_ALARM		0x01
+
+#define NIWD_PERIOD_NS		30720
+#define NIWD_MIN_TIMEOUT	1
+#define NIWD_MAX_TIMEOUT	515
+#define NIWD_DEFAULT_TIMEOUT	60
+
+#define NIWD_NAME		"ni903x_wdt"
+
+struct ni903x_wdt {
+	struct device *dev;
+	u16 io_base;
+	struct watchdog_device wdd;
+};
+
+static unsigned int timeout;
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout,
+		 "Watchdog timeout in seconds. (default="
+		 __MODULE_STRING(NIWD_DEFAULT_TIMEOUT) ")");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, S_IRUGO);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static void ni903x_start(struct ni903x_wdt *wdt)
+{
+	u8 control = inb(wdt->io_base + NIWD_CONTROL);
+
+	outb(control | NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
+	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);
+}
+
+static int ni903x_wdd_set_timeout(struct watchdog_device *wdd,
+				  unsigned int timeout)
+{
+	struct ni903x_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
+
+	outb(((0x00FF0000 & counter) >> 16), wdt->io_base + NIWD_SEED2);
+	outb(((0x0000FF00 & counter) >> 8), wdt->io_base + NIWD_SEED1);
+	outb((0x000000FF & counter), wdt->io_base + NIWD_SEED0);
+
+	wdd->timeout = timeout;
+
+	return 0;
+}
+
+static unsigned int ni903x_wdd_get_timeleft(struct watchdog_device *wdd)
+{
+	struct ni903x_wdt *wdt = watchdog_get_drvdata(wdd);
+	u8 control, counter0, counter1, counter2;
+	u32 counter;
+
+	control = inb(wdt->io_base + NIWD_CONTROL);
+	control |= NIWD_CONTROL_CAPTURECOUNTER;
+	outb(control, wdt->io_base + NIWD_CONTROL);
+
+	counter2 = inb(wdt->io_base + NIWD_COUNTER2);
+	counter1 = inb(wdt->io_base + NIWD_COUNTER1);
+	counter0 = inb(wdt->io_base + NIWD_COUNTER0);
+
+	counter = (counter2 << 16) | (counter1 << 8) | counter0;
+
+	return counter / (1000000000 / NIWD_PERIOD_NS);
+}
+
+static int ni903x_wdd_ping(struct watchdog_device *wdd)
+{
+	struct ni903x_wdt *wdt = watchdog_get_drvdata(wdd);
+	u8 control;
+
+	control = inb(wdt->io_base + NIWD_CONTROL);
+	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);
+
+	return 0;
+}
+
+static int ni903x_wdd_start(struct watchdog_device *wdd)
+{
+	struct ni903x_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_PROC_RESET,
+	     wdt->io_base + NIWD_CONTROL);
+
+	ni903x_wdd_set_timeout(wdd, wdd->timeout);
+	ni903x_start(wdt);
+
+	return 0;
+}
+
+static int ni903x_wdd_stop(struct watchdog_device *wdd)
+{
+	struct ni903x_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	outb(NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
+
+	return 0;
+}
+
+static acpi_status ni903x_resources(struct acpi_resource *res, void *data)
+{
+	struct ni903x_wdt *wdt = data;
+	u16 io_size;
+
+	switch (res->type) {
+	case ACPI_RESOURCE_TYPE_IO:
+		if (wdt->io_base != 0) {
+			dev_err(wdt->dev, "too many IO resources\n");
+			return AE_ERROR;
+		}
+
+		wdt->io_base = res->data.io.minimum;
+		io_size = res->data.io.address_length;
+
+		if (io_size < NIWD_IO_SIZE) {
+			dev_err(wdt->dev, "memory region too small\n");
+			return AE_ERROR;
+		}
+
+		if (!devm_request_region(wdt->dev, wdt->io_base, io_size,
+					 NIWD_NAME)) {
+			dev_err(wdt->dev, "failed to get memory region\n");
+			return AE_ERROR;
+		}
+
+		return AE_OK;
+
+	case ACPI_RESOURCE_TYPE_END_TAG:
+	default:
+		/* Ignore unsupported resources, e.g. IRQ */
+		return AE_OK;
+	}
+}
+
+static const struct watchdog_info ni903x_wdd_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "NI Watchdog",
+};
+
+static const struct watchdog_ops ni903x_wdd_ops = {
+	.owner = THIS_MODULE,
+	.start = ni903x_wdd_start,
+	.stop = ni903x_wdd_stop,
+	.ping = ni903x_wdd_ping,
+	.set_timeout = ni903x_wdd_set_timeout,
+	.get_timeleft = ni903x_wdd_get_timeleft,
+};
+
+static int ni903x_acpi_add(struct acpi_device *device)
+{
+	struct device *dev = &device->dev;
+	struct watchdog_device *wdd;
+	struct ni903x_wdt *wdt;
+	acpi_status status;
+	int ret;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	device->driver_data = wdt;
+	wdt->dev = dev;
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     ni903x_resources, wdt);
+	if (ACPI_FAILURE(status) || wdt->io_base == 0) {
+		dev_err(dev, "failed to get resources\n");
+		return -ENODEV;
+	}
+
+	wdd = &wdt->wdd;
+	wdd->info = &ni903x_wdd_info;
+	wdd->ops = &ni903x_wdd_ops;
+	wdd->min_timeout = NIWD_MIN_TIMEOUT;
+	wdd->max_timeout = NIWD_MAX_TIMEOUT;
+	wdd->timeout = NIWD_DEFAULT_TIMEOUT;
+	wdd->parent = dev;
+	watchdog_set_drvdata(wdd, wdt);
+	watchdog_set_nowayout(wdd, nowayout);
+	ret = watchdog_init_timeout(wdd, timeout, dev);
+	if (ret)
+		dev_err(dev, "unable to set timeout value, using default\n");
+
+	ret = watchdog_register_device(wdd);
+	if (ret) {
+		dev_err(dev, "failed to register watchdog\n");
+		return ret;
+	}
+
+	/* Switch from boot mode to user mode */
+	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_MODE,
+	     wdt->io_base + NIWD_CONTROL);
+
+	dev_dbg(dev, "io_base=0x%04X, timeout=%d, nowayout=%d\n",
+		wdt->io_base, timeout, nowayout);
+
+	return 0;
+}
+
+static int ni903x_acpi_remove(struct acpi_device *device)
+{
+	struct ni903x_wdt *wdt = acpi_driver_data(device);
+
+	ni903x_wdd_stop(&wdt->wdd);
+	watchdog_unregister_device(&wdt->wdd);
+
+	return 0;
+}
+
+static const struct acpi_device_id ni903x_device_ids[] = {
+	{"NIC775C", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, ni903x_device_ids);
+
+static struct acpi_driver ni903x_acpi_driver = {
+	.name = NIWD_NAME,
+	.ids = ni903x_device_ids,
+	.ops = {
+		.add = ni903x_acpi_add,
+		.remove = ni903x_acpi_remove,
+	},
+};
+
+module_acpi_driver(ni903x_acpi_driver);
+
+MODULE_DESCRIPTION("NI 903x Watchdog");
+MODULE_AUTHOR("Jeff Westfahl <jeff.westfahl@ni.com>");
+MODULE_AUTHOR("Kyle Roeschley <kyle.roeschley@ni.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.0

