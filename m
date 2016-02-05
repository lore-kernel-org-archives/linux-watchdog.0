Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:35048 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751827AbcBEB2B (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Feb 2016 20:28:01 -0500
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, joshc@ni.com
Subject: [RFC 1/4] watchdog: ni9x3x_wdt: Add NI 903x/913x watchdog driver
Date: Thu, 4 Feb 2016 19:28:00 -0600
Message-Id: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
time controllers.

Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
 drivers/watchdog/Kconfig      |  11 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/ni9x3x_wdt.c | 264 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/watchdog/ni9x3x_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0f6d851..18bd13a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1214,6 +1214,17 @@ config SBC_EPX_C3_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sbc_epx_c3.
 
+config NI9X3X_WDT
+	tristate "NI 903x/913x Watchdog"
+	depends on X86 && ACPI
+	select WATCHDOG_CORE
+	---help---
+	  This is the driver for the watchdog timer on the National Instruments
+	  903x/913x real-time controllers.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ni9x3x_wdt.
+
 # M32R Architecture
 
 # M68K Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f566753..527978b 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
 obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
+obj-$(CONFIG_NI9X3X_WDT) += ni9x3x_wdt.o
 
 # M32R Architecture
 
diff --git a/drivers/watchdog/ni9x3x_wdt.c b/drivers/watchdog/ni9x3x_wdt.c
new file mode 100644
index 0000000..2cb5627
--- /dev/null
+++ b/drivers/watchdog/ni9x3x_wdt.c
@@ -0,0 +1,264 @@
+/*
+ * Copyright (C) 2013 National Instruments Corp.
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
+#include <linux/interrupt.h>
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
+#define NI9X3X_WDT_NAME		"ni9x3x_wdt"
+
+#define to_ni9x3x_wdt(_wdog)	container_of(_wdog, struct ni9x3x_wdt, wdog)
+
+struct ni9x3x_wdt {
+	struct acpi_device *acpi_device;
+	u16 io_base;
+	u16 io_size;
+	spinlock_t lock;
+	struct watchdog_device wdog;
+};
+
+static void ni9x3x_wdt_start(struct ni9x3x_wdt *wdt)
+{
+	u8 control = inb(wdt->io_base + NIWD_CONTROL);
+
+	outb(control | NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
+	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);
+}
+
+static int ni9x3x_wdt_wdd_set_timeout(struct watchdog_device *wdd,
+				      unsigned int timeout)
+{
+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
+	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
+
+	outb(((0x00FF0000 & counter) >> 16), wdt->io_base + NIWD_SEED2);
+	outb(((0x0000FF00 & counter) >> 8), wdt->io_base + NIWD_SEED1);
+	outb((0x000000FF & counter), wdt->io_base + NIWD_SEED0);
+
+	return 0;
+}
+
+static unsigned int ni9x3x_wdt_wdd_get_timeleft(struct watchdog_device *wdd)
+{
+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
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
+	counter = (counter * (u64)NIWD_PERIOD_NS) / 1000000000;
+
+	return (unsigned int)counter;
+}
+
+static int ni9x3x_wdt_wdd_start(struct watchdog_device *wdd)
+{
+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
+
+	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_PROC_RESET,
+	     wdt->io_base + NIWD_CONTROL);
+
+	ni9x3x_wdt_wdd_set_timeout(wdd, wdd->timeout);
+	ni9x3x_wdt_start(wdt);
+
+	return 0;
+}
+
+static int ni9x3x_wdt_wdd_stop(struct watchdog_device *wdd)
+{
+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
+
+	outb(NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
+
+	return 0;
+}
+
+static int ni9x3x_wdt_wdd_ping(struct watchdog_device *wdd)
+{
+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
+	u8 control;
+
+	control = inb(wdt->io_base + NIWD_CONTROL);
+	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);
+
+	return 0;
+}
+
+static acpi_status ni9x3x_wdt_resources(struct acpi_resource *res, void *data)
+{
+	struct ni9x3x_wdt *wdt = data;
+
+	switch (res->type) {
+	case ACPI_RESOURCE_TYPE_IO:
+		if (wdt->io_base != 0 || wdt->io_size != 0) {
+			dev_err(&wdt->acpi_device->dev,
+				 "too many IO resources\n");
+			return AE_ERROR;
+		}
+
+		wdt->io_base = res->data.io.minimum;
+		wdt->io_size = res->data.io.address_length;
+
+		return AE_OK;
+
+	case ACPI_RESOURCE_TYPE_END_TAG:
+		return AE_OK;
+
+	default:
+		dev_err(&wdt->acpi_device->dev,
+			"unsupported resource type %d\n", res->type);
+		return AE_ERROR;
+	}
+
+	return AE_OK;
+}
+
+static int ni9x3x_wdt_acpi_remove(struct acpi_device *device)
+{
+	struct ni9x3x_wdt *wdt = acpi_driver_data(device);
+
+	ni9x3x_wdt_wdd_stop(&wdt->wdog);
+	watchdog_unregister_device(&wdt->wdog);
+
+	return 0;
+}
+
+static const struct watchdog_info ni9x3x_wdt_wdd_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "NI Watchdog",
+};
+
+static const struct watchdog_ops ni9x3x_wdt_wdd_ops = {
+	.owner		= THIS_MODULE,
+	.start		= ni9x3x_wdt_wdd_start,
+	.stop		= ni9x3x_wdt_wdd_stop,
+	.ping		= ni9x3x_wdt_wdd_ping,
+	.set_timeout	= ni9x3x_wdt_wdd_set_timeout,
+	.get_timeleft	= ni9x3x_wdt_wdd_get_timeleft,
+};
+
+static int ni9x3x_wdt_acpi_add(struct acpi_device *device)
+{
+	struct ni9x3x_wdt *wdt;
+	acpi_status status;
+	int ret;
+
+	wdt = devm_kzalloc(&device->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	device->driver_data = wdt;
+	wdt->acpi_device = device;
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     ni9x3x_wdt_resources, wdt);
+	if (ACPI_FAILURE(status) || wdt->io_base == 0 ||
+	    wdt->io_size != NIWD_IO_SIZE) {
+		dev_err(&device->dev, "failed to get resources\n");
+		return -ENODEV;
+	}
+
+	if (!devm_request_region(&device->dev, wdt->io_base, wdt->io_size,
+				 NI9X3X_WDT_NAME)) {
+		dev_err(&device->dev, "failed to get memory region\n");
+		return -EBUSY;
+	}
+
+	spin_lock_init(&wdt->lock);
+
+	wdt->wdog.info = &ni9x3x_wdt_wdd_info;
+	wdt->wdog.ops = &ni9x3x_wdt_wdd_ops;
+	wdt->wdog.min_timeout = NIWD_MIN_TIMEOUT;
+	wdt->wdog.max_timeout = NIWD_MAX_TIMEOUT;
+	wdt->wdog.timeout = NIWD_DEFAULT_TIMEOUT;
+	wdt->wdog.parent = &device->dev;
+
+	ret = watchdog_register_device(&wdt->wdog);
+	if (ret) {
+		dev_err(&device->dev, "failed to register watchdog\n");
+		return ret;
+	}
+
+	/* Switch from boot mode to user mode */
+	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_MODE,
+	     wdt->io_base + NIWD_CONTROL);
+
+	dev_info(&wdt->acpi_device->dev, "IO range 0x%04X-0x%04X\n",
+		 wdt->io_base, wdt->io_base + wdt->io_size - 1);
+	return 0;
+}
+
+static const struct acpi_device_id ni9x3x_wdt_device_ids[] = {
+	{"NIC775C", 0},
+	{"", 0},
+};
+
+static struct acpi_driver ni9x3x_wdt_acpi_driver = {
+	.name = NI9X3X_WDT_NAME,
+	.ids = ni9x3x_wdt_device_ids,
+	.ops = {
+		.add = ni9x3x_wdt_acpi_add,
+		.remove = ni9x3x_wdt_acpi_remove,
+		},
+};
+
+static int __init ni9x3x_wdt_init(void)
+{
+	return acpi_bus_register_driver(&ni9x3x_wdt_acpi_driver);
+}
+
+static void __exit ni9x3x_wdt_exit(void)
+{
+	acpi_bus_unregister_driver(&ni9x3x_wdt_acpi_driver);
+}
+
+module_init(ni9x3x_wdt_init);
+module_exit(ni9x3x_wdt_exit);
+
+MODULE_DEVICE_TABLE(acpi, ni9x3x_wdt_device_ids);
+MODULE_DESCRIPTION("NI Watchdog");
+MODULE_AUTHOR("Jeff Westfahl <jeff.westfahl@ni.com>");
+MODULE_AUTHOR("Kyle Roeschley <kyle.roeschley@ni.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.0

