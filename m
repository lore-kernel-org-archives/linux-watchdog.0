Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:55982 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760373AbcALAXF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jan 2016 19:23:05 -0500
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH 1/2] watchdog: add NI 903x/913x watchdog support
Date: Mon, 11 Jan 2016 18:23:00 -0600
Message-Id: <1452558181-19511-1-git-send-email-kyle.roeschley@ni.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds support for the watchdog timer on NI cRIO-903x and
cDAQ-913x real-time controllers.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
---
 drivers/watchdog/Kconfig        |  11 +
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/niwatchdog.c   | 507 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/Kbuild       |   1 +
 include/uapi/linux/niwatchdog.h |  30 +++
 5 files changed, 550 insertions(+)
 create mode 100644 drivers/watchdog/niwatchdog.c
 create mode 100644 include/uapi/linux/niwatchdog.h

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4f0e7be..cf7f2c2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1212,6 +1212,17 @@ config SBC_EPX_C3_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sbc_epx_c3.
 
+config NI_WATCHDOG
+	bool "NI Watchdog support for NI 903x/913x"
+	depends on X86 && ACPI
+	select WATCHDOG_CORE
+	---help---
+	  This is the driver for the watchdog timer on the National Instruments
+	  903x/913x real-time controllers.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called niwatchdog.
+
 # M32R Architecture
 
 # M68K Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f566753..3cb8ebf 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
 obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
+obj-$(CONFIG_NI_WATCHDOG) += niwatchdog.o
 
 # M32R Architecture
 
diff --git a/drivers/watchdog/niwatchdog.c b/drivers/watchdog/niwatchdog.c
new file mode 100644
index 0000000..3908846
--- /dev/null
+++ b/drivers/watchdog/niwatchdog.c
@@ -0,0 +1,507 @@
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
+#include <linux/niwatchdog.h>
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
+#define NIWD_CONTROL_PROC_INTERRUPT	0x40
+#define NIWD_CONTROL_PROC_RESET		0x20
+#define NIWD_CONTROL_PET		0x10
+#define NIWD_CONTROL_RUNNING		0x08
+#define NIWD_CONTROL_CAPTURECOUNTER	0x04
+#define NIWD_CONTROL_RESET		0x02
+#define NIWD_CONTROL_ALARM		0x01
+
+#define NIWD_PERIOD_NS		30720
+#define NIWD_MAX_COUNTER	0x00FFFFFF
+#define NIWD_MIN_TIMEOUT	1
+#define NIWD_MAX_TIMEOUT	515
+#define NIWD_DEFAULT_TIMEOUT	60
+
+#define to_niwatchdog(_wdog)	container_of(_wdog, struct niwatchdog, wdog)
+
+struct niwatchdog {
+	struct acpi_device *acpi_device;
+	u16 io_base;
+	u16 io_size;
+	u32 irq;
+	spinlock_t lock;
+	struct watchdog_device wdog;
+	atomic_t available;
+	wait_queue_head_t irq_event;
+	u32 running:1;
+	u32 expired:1;
+};
+
+static ssize_t niwatchdog_wdmode_get(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct acpi_device *acpi_device = to_acpi_device(dev);
+	struct niwatchdog *niwatchdog = acpi_device->driver_data;
+	u8 data;
+
+	data = inb(niwatchdog->io_base + NIWD_CONTROL);
+
+	data &= NIWD_CONTROL_MODE;
+
+	return sprintf(buf, "%s\n", data ? "boot" : "user");
+}
+
+static ssize_t niwatchdog_wdmode_set(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct acpi_device *acpi_device = to_acpi_device(dev);
+	struct niwatchdog *niwatchdog = acpi_device->driver_data;
+	u8 data;
+
+	/* you can only switch boot->user */
+	if (strcmp(buf, "user"))
+		return -EINVAL;
+
+	data = inb(niwatchdog->io_base + NIWD_CONTROL);
+
+	/* Check if we're already in user mode. */
+	if (!(data & NIWD_CONTROL_MODE))
+		return count;
+
+	data = NIWD_CONTROL_MODE | NIWD_CONTROL_RESET;
+
+	outb(data, niwatchdog->io_base + NIWD_CONTROL);
+
+	return count;
+}
+
+static DEVICE_ATTR(watchdog_mode, S_IRUSR|S_IWUSR, niwatchdog_wdmode_get,
+	niwatchdog_wdmode_set);
+
+static const struct attribute *niwatchdog_attrs[] = {
+	&dev_attr_watchdog_mode.attr,
+	NULL
+};
+
+static int niwatchdog_counter_set(struct niwatchdog *niwatchdog, u32 counter)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&niwatchdog->lock, flags);
+
+	/* Prevent changing the counter while the watchdog is running. */
+	if (niwatchdog->running) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	outb(((0x00FF0000 & counter) >> 16), niwatchdog->io_base + NIWD_SEED2);
+	outb(((0x0000FF00 & counter) >> 8), niwatchdog->io_base + NIWD_SEED1);
+	outb((0x000000FF & counter), niwatchdog->io_base + NIWD_SEED0);
+
+	ret = 0;
+
+out_unlock:
+	spin_unlock_irqrestore(&niwatchdog->lock, flags);
+
+	return ret;
+}
+
+static int niwatchdog_add_action(struct niwatchdog *niwatchdog, u32 action)
+{
+	u8 action_mask;
+	u8 control;
+	unsigned long flags;
+
+	if (action == NIWATCHDOG_ACTION_INTERRUPT)
+		action_mask = NIWD_CONTROL_PROC_INTERRUPT;
+	else if (action == NIWATCHDOG_ACTION_RESET)
+		action_mask = NIWD_CONTROL_PROC_RESET;
+	else
+		return -ENOTSUPP;
+
+	spin_lock_irqsave(&niwatchdog->lock, flags);
+
+	control = inb(niwatchdog->io_base + NIWD_CONTROL);
+	control |= action_mask;
+	outb(control, niwatchdog->io_base + NIWD_CONTROL);
+
+	spin_unlock_irqrestore(&niwatchdog->lock, flags);
+
+	return 0;
+}
+
+static void niwatchdog_start(struct niwatchdog *niwatchdog)
+{
+	u8 control;
+	unsigned long flags;
+
+	spin_lock_irqsave(&niwatchdog->lock, flags);
+
+	niwatchdog->running = true;
+	niwatchdog->expired = false;
+
+	control = inb(niwatchdog->io_base + NIWD_CONTROL);
+	outb(control | NIWD_CONTROL_RESET, niwatchdog->io_base + NIWD_CONTROL);
+	outb(control | NIWD_CONTROL_PET, niwatchdog->io_base + NIWD_CONTROL);
+
+	spin_unlock_irqrestore(&niwatchdog->lock, flags);
+}
+
+static void niwatchdog_pet(struct niwatchdog *niwatchdog, u32 *state)
+{
+	u8 control;
+	unsigned long flags;
+
+	spin_lock_irqsave(&niwatchdog->lock, flags);
+
+	if (niwatchdog->expired) {
+		*state = NIWATCHDOG_STATE_EXPIRED;
+	} else if (!niwatchdog->running) {
+		*state = NIWATCHDOG_STATE_DISABLED;
+	} else {
+		control = inb(niwatchdog->io_base + NIWD_CONTROL);
+		control |= NIWD_CONTROL_PET;
+		outb(control, niwatchdog->io_base + NIWD_CONTROL);
+
+		*state = NIWATCHDOG_STATE_RUNNING;
+	}
+
+	spin_unlock_irqrestore(&niwatchdog->lock, flags);
+}
+
+static void niwatchdog_reset(struct niwatchdog *niwatchdog)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&niwatchdog->lock, flags);
+
+	niwatchdog->running = false;
+	niwatchdog->expired = false;
+
+	outb(NIWD_CONTROL_RESET, niwatchdog->io_base + NIWD_CONTROL);
+
+	spin_unlock_irqrestore(&niwatchdog->lock, flags);
+}
+
+static void niwatchdog_counter_get(struct niwatchdog *niwatchdog, u32 *counter)
+{
+	u8 control, counter2, counter1, counter0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&niwatchdog->lock, flags);
+
+	control = inb(niwatchdog->io_base + NIWD_CONTROL);
+	control |= NIWD_CONTROL_CAPTURECOUNTER;
+	outb(control, niwatchdog->io_base + NIWD_CONTROL);
+
+	counter2 = inb(niwatchdog->io_base + NIWD_COUNTER2);
+	counter1 = inb(niwatchdog->io_base + NIWD_COUNTER1);
+	counter0 = inb(niwatchdog->io_base + NIWD_COUNTER0);
+
+	*counter = (counter2 << 16) | (counter1 << 8) | counter0;
+
+	spin_unlock_irqrestore(&niwatchdog->lock, flags);
+}
+
+static int niwatchdog_wdd_set_timeout(struct watchdog_device *wdd,
+				      unsigned int timeout)
+{
+	struct niwatchdog *niwatchdog = to_niwatchdog(wdd);
+	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
+
+	niwatchdog_reset(niwatchdog);
+	niwatchdog_counter_set(niwatchdog, counter);
+	niwatchdog_add_action(niwatchdog, NIWATCHDOG_ACTION_RESET);
+
+	return niwatchdog_start(niwatchdog);
+}
+
+static unsigned int niwatchdog_wdd_get_timeleft(struct watchdog_device *wdd)
+{
+	struct niwatchdog *niwatchdog = to_niwatchdog(wdd);
+	u32 counter;
+
+	niwatchdog_counter_get(niwatchdog, &counter);
+	return (unsigned int)((counter * (unsigned long)NIWD_PERIOD_NS) /
+			      1000000000);
+}
+
+static irqreturn_t niwatchdog_irq(int irq, void *data)
+{
+	struct niwatchdog *niwatchdog = data;
+	irqreturn_t ret = IRQ_NONE;
+	u8 control;
+	unsigned long flags;
+
+	spin_lock_irqsave(&niwatchdog->lock, flags);
+
+	control = inb(niwatchdog->io_base + NIWD_CONTROL);
+
+	if (!(NIWD_CONTROL_ALARM & control)) {
+		dev_err(&niwatchdog->acpi_device->dev,
+			"Spurious watchdog interrupt, 0x%02X\n", control);
+		goto out_unlock;
+	}
+
+	niwatchdog->running = false;
+	niwatchdog->expired = true;
+
+	/* Acknowledge the interrupt. */
+	control |= NIWD_CONTROL_RESET;
+	outb(control, niwatchdog->io_base + NIWD_CONTROL);
+
+	/* Signal the watchdog event. */
+	wake_up_all(&niwatchdog->irq_event);
+
+	ret = IRQ_HANDLED;
+
+out_unlock:
+	spin_unlock_irqrestore(&niwatchdog->lock, flags);
+
+	return ret;
+}
+
+static int niwatchdog_wdd_open(struct watchdog_device *wdd)
+{
+	struct niwatchdog *niwatchdog = to_niwatchdog(wdd);
+	u32 counter;
+
+	if (!atomic_dec_and_test(&niwatchdog->available)) {
+		atomic_inc(&niwatchdog->available);
+		return -EBUSY;
+	}
+
+	niwatchdog_reset(niwatchdog);
+
+	counter = wdd->timeout * (1000000000 / NIWD_PERIOD_NS);
+	niwatchdog_counter_set(niwatchdog, counter);
+	niwatchdog_add_action(niwatchdog, NIWATCHDOG_ACTION_RESET);
+
+	niwatchdog_start(niwatchdog);
+
+	return request_irq(niwatchdog->irq, niwatchdog_irq, 0,
+			   NIWATCHDOG_NAME, niwatchdog);
+}
+
+static int niwatchdog_wdd_release(struct watchdog_device *wdd)
+{
+	struct niwatchdog *niwatchdog = to_niwatchdog(wdd);
+
+	niwatchdog_reset(niwatchdog);
+
+	free_irq(niwatchdog->irq, niwatchdog);
+	atomic_inc(&niwatchdog->available);
+	return 0;
+}
+
+static int niwatchdog_ping(struct watchdog_device *wdd)
+{
+	struct niwatchdog *niwatchdog = to_niwatchdog(wdd);
+	__u32 state;
+
+	niwatchdog_pet(niwatchdog, &state);
+	if (state != NIWATCHDOG_STATE_RUNNING)
+		return -state;
+
+	return 0;
+}
+
+static acpi_status niwatchdog_resources(struct acpi_resource *res, void *data)
+{
+	struct niwatchdog *niwatchdog = data;
+
+	switch (res->type) {
+	case ACPI_RESOURCE_TYPE_IO:
+		if ((niwatchdog->io_base != 0) ||
+		    (niwatchdog->io_size != 0)) {
+			dev_err(&niwatchdog->acpi_device->dev,
+			"too many IO resources\n");
+			return AE_ERROR;
+		}
+
+		niwatchdog->io_base = res->data.io.minimum;
+		niwatchdog->io_size = res->data.io.address_length;
+
+		return AE_OK;
+
+	case ACPI_RESOURCE_TYPE_IRQ:
+		if (niwatchdog->irq != 0) {
+			dev_err(&niwatchdog->acpi_device->dev,
+				"too many IRQ resources\n");
+			return AE_ERROR;
+		}
+
+		niwatchdog->irq = res->data.irq.interrupts[0];
+
+		return AE_OK;
+
+	case ACPI_RESOURCE_TYPE_END_TAG:
+		return AE_OK;
+
+	default:
+		dev_err(&niwatchdog->acpi_device->dev,
+			"unsupported resource type %d\n",
+			res->type);
+		return AE_ERROR;
+	}
+
+	return AE_OK;
+}
+
+static int niwatchdog_acpi_remove(struct acpi_device *device)
+{
+	struct niwatchdog *niwatchdog = device->driver_data;
+
+	watchdog_unregister_device(&niwatchdog->wdog);
+
+	sysfs_remove_files(&niwatchdog->acpi_device->dev.kobj,
+			   niwatchdog_attrs);
+
+	if ((niwatchdog->io_base != 0) &&
+	    (niwatchdog->io_size == NIWD_IO_SIZE))
+		release_region(niwatchdog->io_base, niwatchdog->io_size);
+
+	device->driver_data = NULL;
+
+	kfree(niwatchdog);
+
+	return 0;
+}
+
+static const struct watchdog_info niwatchdog_wdd_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "NI Watchdog",
+};
+
+static const struct watchdog_ops niwatchdog_wdd_ops = {
+	.owner		= THIS_MODULE,
+	.start		= niwatchdog_wdd_open,
+	.stop		= niwatchdog_wdd_release,
+	.ping		= niwatchdog_ping,
+	.set_timeout	= niwatchdog_wdd_set_timeout,
+	.get_timeleft	= niwatchdog_wdd_get_timeleft,
+};
+
+static int niwatchdog_acpi_add(struct acpi_device *device)
+{
+	struct niwatchdog *niwatchdog;
+	acpi_status acpi_ret;
+	int err;
+
+	niwatchdog = kzalloc(sizeof(*niwatchdog), GFP_KERNEL);
+
+	if (!niwatchdog)
+		return -ENOMEM;
+
+	device->driver_data = niwatchdog;
+
+	niwatchdog->acpi_device = device;
+
+	acpi_ret = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				       niwatchdog_resources, niwatchdog);
+
+	if (ACPI_FAILURE(acpi_ret) ||
+	    (niwatchdog->io_base == 0) ||
+	    (niwatchdog->io_size != NIWD_IO_SIZE) ||
+	    (niwatchdog->irq == 0)) {
+		niwatchdog_acpi_remove(device);
+		return -ENODEV;
+	}
+
+	if (!request_region(niwatchdog->io_base, niwatchdog->io_size,
+	    NIWATCHDOG_NAME)) {
+		niwatchdog_acpi_remove(device);
+		return -EBUSY;
+	}
+
+	err = sysfs_create_files(&niwatchdog->acpi_device->dev.kobj,
+				 niwatchdog_attrs);
+	if (err) {
+		niwatchdog_acpi_remove(device);
+		return err;
+	}
+
+	spin_lock_init(&niwatchdog->lock);
+
+	atomic_set(&niwatchdog->available, 1);
+	init_waitqueue_head(&niwatchdog->irq_event);
+	niwatchdog->expired = false;
+
+	niwatchdog->wdog.info = &niwatchdog_wdd_info;
+	niwatchdog->wdog.ops = &niwatchdog_wdd_ops;
+	niwatchdog->wdog.min_timeout = NIWD_MIN_TIMEOUT;
+	niwatchdog->wdog.max_timeout = NIWD_MAX_TIMEOUT;
+	niwatchdog->wdog.timeout = NIWD_DEFAULT_TIMEOUT;
+	niwatchdog->wdog.parent = &device->dev;
+	err = watchdog_register_device(&niwatchdog->wdog);
+
+	if (err) {
+		niwatchdog_acpi_remove(device);
+		return err;
+	}
+
+	dev_info(&niwatchdog->acpi_device->dev,
+		 "IO range 0x%04X-0x%04X, IRQ %d\n",
+		 niwatchdog->io_base,
+		 niwatchdog->io_base + niwatchdog->io_size - 1,
+		 niwatchdog->irq);
+
+	return 0;
+}
+
+static const struct acpi_device_id niwatchdog_device_ids[] = {
+	{"NIC775C", 0},
+	{"", 0},
+};
+
+static struct acpi_driver niwatchdog_acpi_driver = {
+	.name = NIWATCHDOG_NAME,
+	.ids = niwatchdog_device_ids,
+	.ops = {
+		.add = niwatchdog_acpi_add,
+		.remove = niwatchdog_acpi_remove,
+		},
+};
+
+static int __init niwatchdog_init(void)
+{
+	return acpi_bus_register_driver(&niwatchdog_acpi_driver);
+}
+
+static void __exit niwatchdog_exit(void)
+{
+	acpi_bus_unregister_driver(&niwatchdog_acpi_driver);
+}
+
+module_init(niwatchdog_init);
+module_exit(niwatchdog_exit);
+
+MODULE_DEVICE_TABLE(acpi, niwatchdog_device_ids);
+MODULE_DESCRIPTION("NI Watchdog");
+MODULE_AUTHOR("Jeff Westfahl <jeff.westfahl@ni.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index 628e6e6..8c5dde3 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -303,6 +303,7 @@ header-y += nfs_fs.h
 header-y += nfs.h
 header-y += nfs_idmap.h
 header-y += nfs_mount.h
+header-y += niwatchdog.h
 header-y += nl80211.h
 header-y += n_r3964.h
 header-y += nubus.h
diff --git a/include/uapi/linux/niwatchdog.h b/include/uapi/linux/niwatchdog.h
new file mode 100644
index 0000000..9d3613d
--- /dev/null
+++ b/include/uapi/linux/niwatchdog.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2012 National Instruments Corp.
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
+#ifndef _LINUX_NIWATCHDOG_H_
+#define _LINUX_NIWATCHDOG_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define NIWATCHDOG_ACTION_INTERRUPT	0
+#define NIWATCHDOG_ACTION_RESET		1
+
+#define NIWATCHDOG_STATE_RUNNING	0
+#define NIWATCHDOG_STATE_EXPIRED	1
+#define NIWATCHDOG_STATE_DISABLED	2
+
+#define NIWATCHDOG_NAME			"niwatchdog"
+
+#endif /* _LINUX_NIWATCHDOG_H_ */
-- 
2.6.4

