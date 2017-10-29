Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19362 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdJ2Juo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 29 Oct 2017 05:50:44 -0400
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, lee.jones@linaro.org, andy@infradead.org,
        souvik.k.chakravarty@intel.com
Cc: linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sathyaosid@gmail.com,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v8 4/7] platform: x86: Add generic Intel IPC driver
Date: Sun, 29 Oct 2017 02:49:57 -0700
Message-Id: <5c66498c110e52343d810db9c281fe72d0d299cc.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently intel_scu_ipc.c, intel_pmc_ipc.c and intel_punit_ipc.c
redundantly implements the same IPC features and has lot of code
duplication between them. This driver addresses this issue by grouping
the common IPC functionalities under the same driver.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 MAINTAINERS                                     |   7 +
 drivers/platform/x86/Kconfig                    |   8 +
 drivers/platform/x86/Makefile                   |   1 +
 drivers/platform/x86/intel_ipc_dev.c            | 563 ++++++++++++++++++++++++
 include/linux/platform_data/x86/intel_ipc_dev.h | 246 +++++++++++
 5 files changed, 825 insertions(+)
 create mode 100644 drivers/platform/x86/intel_ipc_dev.c
 create mode 100644 include/linux/platform_data/x86/intel_ipc_dev.h

Changes since v7:
 * Fixed style issues.
 * Added MAINTAINER info.

Changes since v6:
 * None

Changes since v5:
 * Added structures to group intel_ipc_cmd() intel_ipc_raw_cmd()
   arguments.

Changes since v4:
 * None

Changes since v3:
 * Fixed NULL pointer exception in intel_ipc_dev_get().
 * Fixed error in check for duplicate intel_ipc_dev.
 * Added custom interrupt handler support.
 * Used char array for error string conversion.
 * Added put dev support.
 * Added devm_* variant of intel_ipc_dev_get().

Changes since v2:
 * Added ipc_dev_cmd API support.

diff --git a/MAINTAINERS b/MAINTAINERS
index d85c089..a2a9a9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6970,6 +6970,13 @@ R:	Dan Williams <dan.j.williams@intel.com>
 S:	Odd fixes
 F:	drivers/dma/iop-adma.c
 
+INTEL IPC CORE DRIVER
+M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/intel_ipc_dev.c
+F:	include/linux/platform_data/x86/intel_ipc_dev.h
+
 INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
 M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 45f4e79..9df7cda 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1140,6 +1140,14 @@ config SILEAD_DMI
 	  with the OS-image for the device. This option supplies the missing
 	  information. Enable this for x86 tablets with Silead touchscreens.
 
+config INTEL_IPC_DEV
+	bool "Intel IPC Device Driver"
+	depends on X86_64
+	---help---
+	  This driver implements core features of Intel IPC device. Devices
+	  like PMC, SCU, PUNIT, etc can use interfaces provided by this
+	  driver to implement IPC protocol of their respective device.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 91cec17..04e11ce 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -83,3 +83,4 @@ obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
 obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_MLX_CPLD_PLATFORM)	+= mlxcpld-hotplug.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
+obj-$(CONFIG_INTEL_IPC_DEV)	+= intel_ipc_dev.o
diff --git a/drivers/platform/x86/intel_ipc_dev.c b/drivers/platform/x86/intel_ipc_dev.c
new file mode 100644
index 0000000..0edcf23
--- /dev/null
+++ b/drivers/platform/x86/intel_ipc_dev.c
@@ -0,0 +1,563 @@
+/*
+ * intel_ipc_dev.c: Intel IPC device class driver
+ *
+ * (C) Copyright 2017 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/platform_data/x86/intel_ipc_dev.h>
+#include <linux/regmap.h>
+
+/* mutex to sync different ipc devices in same channel */
+static struct mutex channel_lock[IPC_CHANNEL_MAX];
+
+static char *ipc_err_sources[] = {
+	[IPC_DEV_ERR_NONE] =
+		"No error",
+	[IPC_DEV_ERR_CMD_NOT_SUPPORTED] =
+		"Command not-supported/Invalid",
+	[IPC_DEV_ERR_CMD_NOT_SERVICED] =
+		"Command not-serviced/Invalid param",
+	[IPC_DEV_ERR_UNABLE_TO_SERVICE] =
+		"Unable-to-service/Cmd-timeout",
+	[IPC_DEV_ERR_CMD_INVALID] =
+		"Command-invalid/Cmd-locked",
+	[IPC_DEV_ERR_CMD_FAILED] =
+		"Command-failed/Invalid-VR-id",
+	[IPC_DEV_ERR_EMSECURITY] =
+		"Invalid Battery/VR-Error",
+	[IPC_DEV_ERR_UNSIGNEDKERNEL] =
+		"Unsigned kernel",
+};
+
+static void ipc_channel_lock_init(void)
+{
+	int i;
+
+	for (i = 0; i < IPC_CHANNEL_MAX; i++)
+		mutex_init(&channel_lock[i]);
+}
+
+static struct class intel_ipc_class = {
+	.name = "intel_ipc",
+	.owner = THIS_MODULE,
+};
+
+static int ipc_dev_lock(struct intel_ipc_dev *ipc_dev)
+{
+	int chan_type;
+
+	if (!ipc_dev || !ipc_dev->cfg)
+		return -ENODEV;
+
+	chan_type = ipc_dev->cfg->chan_type;
+	if (chan_type > IPC_CHANNEL_MAX)
+		return -EINVAL;
+
+	/* acquire channel lock */
+	mutex_lock(&channel_lock[chan_type]);
+
+	/* acquire IPC device lock */
+	mutex_lock(&ipc_dev->lock);
+
+	return 0;
+}
+
+static int ipc_dev_unlock(struct intel_ipc_dev *ipc_dev)
+{
+	int chan_type;
+
+	if (!ipc_dev || !ipc_dev->cfg)
+		return -ENODEV;
+
+	chan_type = ipc_dev->cfg->chan_type;
+	if (chan_type > IPC_CHANNEL_MAX)
+		return -EINVAL;
+
+	/* release IPC device lock */
+	mutex_unlock(&ipc_dev->lock);
+
+	/* release channel lock */
+	mutex_unlock(&channel_lock[chan_type]);
+
+	return 0;
+}
+
+static const char *ipc_dev_err_string(struct intel_ipc_dev *ipc_dev,
+	int error)
+{
+	if (error < IPC_DEV_ERR_MAX)
+		return ipc_err_sources[error];
+
+	return "Unknown Command";
+}
+
+/* Helper function to send given command to IPC device */
+static inline void ipc_dev_send_cmd(struct intel_ipc_dev *ipc_dev, u32 cmd)
+{
+	ipc_dev->cmd = cmd;
+
+	if (ipc_dev->cfg->mode == IPC_DEV_MODE_IRQ)
+		reinit_completion(&ipc_dev->cmd_complete);
+
+	if (ipc_dev->ops->enable_msi)
+		cmd = ipc_dev->ops->enable_msi(cmd);
+
+	regmap_write(ipc_dev->cfg->cmd_regs, ipc_dev->cfg->cmd_reg, cmd);
+}
+
+static inline int ipc_dev_status_busy(struct intel_ipc_dev *ipc_dev)
+{
+	int status;
+
+	regmap_read(ipc_dev->cfg->cmd_regs, ipc_dev->cfg->status_reg, &status);
+
+	if (ipc_dev->ops->busy_check)
+		return ipc_dev->ops->busy_check(status);
+
+	return 0;
+}
+
+/* Check the status of IPC command and return err code if failed */
+static int ipc_dev_check_status(struct intel_ipc_dev *ipc_dev)
+{
+	int loop_count = IPC_DEV_CMD_LOOP_CNT;
+	int status;
+	int ret = 0;
+
+	if (ipc_dev->cfg->mode == IPC_DEV_MODE_IRQ) {
+		if (!wait_for_completion_timeout(&ipc_dev->cmd_complete,
+				IPC_DEV_CMD_TIMEOUT))
+			ret = -ETIMEDOUT;
+	} else {
+		while (ipc_dev_status_busy(ipc_dev) && --loop_count)
+			udelay(1);
+		if (!loop_count)
+			ret = -ETIMEDOUT;
+	}
+
+	if (ret < 0) {
+		dev_err(&ipc_dev->dev,
+				"IPC timed out, CMD=0x%x\n", ipc_dev->cmd);
+		return ret;
+	}
+
+	regmap_read(ipc_dev->cfg->cmd_regs, ipc_dev->cfg->status_reg, &status);
+
+	if (ipc_dev->ops->to_err_code)
+		ret = ipc_dev->ops->to_err_code(status);
+
+	if (ret) {
+		dev_err(&ipc_dev->dev,
+				"IPC failed: %s, STS=0x%x, CMD=0x%x\n",
+				ipc_dev_err_string(ipc_dev, ret),
+				status, ipc_dev->cmd);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * ipc_dev_simple_cmd() - Send simple IPC command
+ * @ipc_dev     : Reference to ipc device.
+ * @cmd_list    : IPC command list.
+ * @cmdlen      : Number of cmd/sub-cmds.
+ *
+ * Send a simple IPC command to ipc device.
+ * Use this when don't need to specify input/output data
+ * and source/dest pointers.
+ *
+ * Return:	an IPC error code or 0 on success.
+ */
+
+int ipc_dev_simple_cmd(struct intel_ipc_dev *ipc_dev, u32 *cmd_list,
+		u32 cmdlen)
+{
+	int ret;
+
+	if (!cmd_list)
+		return -EINVAL;
+
+	ret = ipc_dev_lock(ipc_dev);
+	if (ret)
+		return ret;
+
+	/* Call custom pre-processing handler */
+	if (ipc_dev->ops->pre_simple_cmd_fn) {
+		ret = ipc_dev->ops->pre_simple_cmd_fn(cmd_list, cmdlen);
+		if (ret)
+			goto unlock_device;
+	}
+
+	ipc_dev_send_cmd(ipc_dev, cmd_list[0]);
+
+	ret = ipc_dev_check_status(ipc_dev);
+
+unlock_device:
+	ipc_dev_unlock(ipc_dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ipc_dev_simple_cmd);
+
+/**
+ * ipc_dev_cmd() - Send IPC command with data.
+ * @ipc_dev     : Reference to ipc_dev.
+ * @ipc_cmd     : Intel IPC command argument structure.
+ *
+ * Send an IPC command to device with input/output data.
+ *
+ * Return:	an IPC error code or 0 on success.
+ */
+int ipc_dev_cmd(struct intel_ipc_dev *ipc_dev, struct intel_ipc_cmd *ipc_cmd)
+{
+	int ret;
+
+	if (!ipc_cmd || !ipc_cmd->cmd_list || !ipc_cmd->in)
+		return -EINVAL;
+
+	ret = ipc_dev_lock(ipc_dev);
+	if (ret)
+		return ret;
+
+	/* Call custom pre-processing handler. */
+	if (ipc_dev->ops->pre_cmd_fn) {
+		ret = ipc_dev->ops->pre_cmd_fn(ipc_cmd);
+		if (ret)
+			goto unlock_device;
+	}
+
+	/* Write inlen dwords of data to wrbuf_reg. */
+	if (ipc_cmd->inlen > 0)
+		regmap_bulk_write(ipc_dev->cfg->data_regs,
+				ipc_dev->cfg->wrbuf_reg, ipc_cmd->in,
+				ipc_cmd->inlen);
+
+	ipc_dev_send_cmd(ipc_dev, ipc_cmd->cmd_list[0]);
+
+	ret = ipc_dev_check_status(ipc_dev);
+
+	/* Read outlen dwords of data from rbug_reg. */
+	if (!ret && ipc_cmd->outlen > 0)
+		regmap_bulk_read(ipc_dev->cfg->data_regs,
+				ipc_dev->cfg->rbuf_reg, ipc_cmd->out,
+				ipc_cmd->outlen);
+unlock_device:
+	ipc_dev_unlock(ipc_dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ipc_dev_cmd);
+
+/**
+ * ipc_dev_raw_cmd() - Send IPC command with data and pointers.
+ * @ipc_dev        : Reference to ipc_dev.
+ * @ipc_raw_cmd    : Intel IPC raw command argument structure.
+ *
+ * Send an IPC command to device with input/output data and
+ * source/dest pointers.
+ *
+ * Return:	an IPC error code or 0 on success.
+ */
+
+int ipc_dev_raw_cmd(struct intel_ipc_dev *ipc_dev,
+		struct intel_ipc_raw_cmd *ipc_raw_cmd)
+{
+	int ret, inbuflen;
+	u32 *inbuf;
+
+	if (!ipc_raw_cmd || !ipc_raw_cmd->cmd_list || !ipc_raw_cmd->in)
+		return -EINVAL;
+
+	inbuflen = DIV_ROUND_UP(ipc_raw_cmd->inlen, 4);
+
+	inbuf = kzalloc(inbuflen, GFP_KERNEL);
+	if (!inbuf)
+		return -ENOMEM;
+
+	ret = ipc_dev_lock(ipc_dev);
+	if (ret)
+		return ret;
+
+	/* Call custom pre-processing handler. */
+	if (ipc_dev->ops->pre_raw_cmd_fn) {
+		ret = ipc_dev->ops->pre_raw_cmd_fn(ipc_raw_cmd);
+		if (ret)
+			goto unlock_device;
+	}
+
+	/* If supported, write DPTR register.*/
+	if (ipc_dev->cfg->support_dptr)
+		regmap_write(ipc_dev->cfg->cmd_regs, ipc_dev->cfg->dptr_reg,
+				ipc_raw_cmd->dptr);
+
+	/* If supported, write SPTR register. */
+	if (ipc_dev->cfg->support_sptr)
+		regmap_write(ipc_dev->cfg->cmd_regs, ipc_dev->cfg->sptr_reg,
+				ipc_raw_cmd->sptr);
+
+	memcpy(inbuf, ipc_raw_cmd->in, ipc_raw_cmd->inlen);
+
+	/* Write inlen dwords of data to wrbuf_reg. */
+	if (ipc_raw_cmd->inlen > 0)
+		regmap_bulk_write(ipc_dev->cfg->data_regs,
+				ipc_dev->cfg->wrbuf_reg, inbuf, inbuflen);
+
+	ipc_dev_send_cmd(ipc_dev, ipc_raw_cmd->cmd_list[0]);
+
+	ret = ipc_dev_check_status(ipc_dev);
+
+	/* Read outlen dwords of data from rbug_reg. */
+	if (!ret && ipc_raw_cmd->outlen > 0)
+		regmap_bulk_read(ipc_dev->cfg->data_regs,
+				ipc_dev->cfg->rbuf_reg, ipc_raw_cmd->out,
+				ipc_raw_cmd->outlen);
+unlock_device:
+	ipc_dev_unlock(ipc_dev);
+	kfree(inbuf);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ipc_dev_raw_cmd);
+
+/* sysfs option to send simple IPC commands from userspace */
+static ssize_t ipc_dev_cmd_reg_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct intel_ipc_dev *ipc_dev = dev_get_drvdata(dev);
+	u32 cmd;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &cmd);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = ipc_dev_simple_cmd(ipc_dev, &cmd, 1);
+	if (ret) {
+		dev_err(dev, "command 0x%x error with %d\n", cmd, ret);
+		return ret;
+	}
+	return (ssize_t)count;
+}
+
+static DEVICE_ATTR(send_cmd, 00200, NULL, ipc_dev_cmd_reg_store);
+
+static struct attribute *ipc_dev_attrs[] = {
+	&dev_attr_send_cmd.attr,
+	NULL
+};
+
+static const struct attribute_group ipc_dev_group = {
+	.attrs = ipc_dev_attrs,
+};
+
+static const struct attribute_group *ipc_dev_groups[] = {
+	&ipc_dev_group,
+	NULL,
+};
+
+/* IPC device IRQ handler */
+static irqreturn_t ipc_dev_irq_handler(int irq, void *dev_id)
+{
+	struct intel_ipc_dev *ipc_dev = (struct intel_ipc_dev *)dev_id;
+
+	if (ipc_dev->ops->pre_irq_handler_fn)
+		ipc_dev->ops->pre_irq_handler_fn(ipc_dev, irq);
+
+	complete(&ipc_dev->cmd_complete);
+
+	return IRQ_HANDLED;
+}
+
+static void devm_intel_ipc_dev_release(struct device *dev, void *res)
+{
+	struct intel_ipc_dev *ipc_dev = *(struct intel_ipc_dev **)res;
+
+	if (!ipc_dev)
+		return;
+
+	device_del(&ipc_dev->dev);
+
+	kfree(ipc_dev);
+}
+
+static int match_name(struct device *dev, const void *data)
+{
+	if (!dev_name(dev))
+		return 0;
+
+	return !strcmp(dev_name(dev), (char *)data);
+}
+
+/**
+ * intel_ipc_dev_get() - Get Intel IPC device from name.
+ * @dev_name    : Name of the IPC device.
+ *
+ * Return       : ERR_PTR/NULL or intel_ipc_dev pointer on success.
+ */
+struct intel_ipc_dev *intel_ipc_dev_get(const char *dev_name)
+{
+	struct device *dev;
+
+	if (!dev_name)
+		return ERR_PTR(-EINVAL);
+
+	dev = class_find_device(&intel_ipc_class, NULL, dev_name, match_name);
+
+	return dev ? dev_get_drvdata(dev) : NULL;
+}
+EXPORT_SYMBOL_GPL(intel_ipc_dev_get);
+
+static void devm_intel_ipc_dev_put(struct device *dev, void *res)
+{
+	intel_ipc_dev_put(*(struct intel_ipc_dev **)res);
+}
+
+/**
+ * devm_intel_ipc_dev_get() - Resource managed version of intel_ipc_dev_get().
+ * @dev         : Device pointer.
+ * @dev_name    : Name of the IPC device.
+ *
+ * Return       : ERR_PTR/NULL or intel_ipc_dev pointer on success.
+ */
+struct intel_ipc_dev *devm_intel_ipc_dev_get(struct device *dev,
+					const char *dev_name)
+{
+	struct intel_ipc_dev **ptr, *ipc_dev;
+
+	ptr = devres_alloc(devm_intel_ipc_dev_put, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	ipc_dev = intel_ipc_dev_get(dev_name);
+	if (!IS_ERR_OR_NULL(ipc_dev)) {
+		*ptr = ipc_dev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ipc_dev;
+}
+EXPORT_SYMBOL_GPL(devm_intel_ipc_dev_get);
+
+/**
+ * devm_intel_ipc_dev_create() - Create IPC device
+ * @dev		: IPC parent device.
+ * @devname	: Name of the IPC device.
+ * @cfg		: IPC device configuration.
+ * @ops		: IPC device ops.
+ *
+ * Resource managed API to create IPC device with
+ * given configuration.
+ *
+ * Return	: IPC device pointer or ERR_PTR(error code).
+ */
+struct intel_ipc_dev *devm_intel_ipc_dev_create(struct device *dev,
+		const char *devname,
+		struct intel_ipc_dev_cfg *cfg,
+		struct intel_ipc_dev_ops *ops)
+{
+	struct intel_ipc_dev **ptr, *ipc_dev;
+	int ret;
+
+	if (!dev && !devname && !cfg)
+		return ERR_PTR(-EINVAL);
+
+	if (intel_ipc_dev_get(devname)) {
+		dev_err(dev, "IPC device %s already exist\n", devname);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ptr = devres_alloc(devm_intel_ipc_dev_release, sizeof(*ptr),
+			GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	ipc_dev = kzalloc(sizeof(*ipc_dev), GFP_KERNEL);
+	if (!ipc_dev) {
+		ret = -ENOMEM;
+		goto err_dev_create;
+	}
+
+	ipc_dev->dev.class = &intel_ipc_class;
+	ipc_dev->dev.parent = dev;
+	ipc_dev->dev.groups = ipc_dev_groups;
+	ipc_dev->cfg = cfg;
+	ipc_dev->ops = ops;
+
+	mutex_init(&ipc_dev->lock);
+	init_completion(&ipc_dev->cmd_complete);
+	dev_set_drvdata(&ipc_dev->dev, ipc_dev);
+	dev_set_name(&ipc_dev->dev, devname);
+	device_initialize(&ipc_dev->dev);
+
+	ret = device_add(&ipc_dev->dev);
+	if (ret < 0) {
+		dev_err(&ipc_dev->dev, "%s device create failed\n",
+				__func__);
+		ret = -ENODEV;
+		goto err_dev_add;
+	}
+
+	if (ipc_dev->cfg->mode == IPC_DEV_MODE_IRQ) {
+		if (devm_request_irq(&ipc_dev->dev,
+				ipc_dev->cfg->irq,
+				ipc_dev_irq_handler,
+				ipc_dev->cfg->irqflags,
+				dev_name(&ipc_dev->dev),
+				ipc_dev)) {
+			dev_err(&ipc_dev->dev,
+					"Failed to request irq\n");
+			goto err_irq_request;
+		}
+	}
+
+	*ptr = ipc_dev;
+
+	devres_add(dev, ptr);
+
+	return ipc_dev;
+
+err_irq_request:
+	device_del(&ipc_dev->dev);
+err_dev_add:
+	kfree(ipc_dev);
+err_dev_create:
+	devres_free(ptr);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(devm_intel_ipc_dev_create);
+
+static int __init intel_ipc_init(void)
+{
+	ipc_channel_lock_init();
+	return class_register(&intel_ipc_class);
+}
+
+static void __exit intel_ipc_exit(void)
+{
+	class_unregister(&intel_ipc_class);
+}
+subsys_initcall(intel_ipc_init);
+module_exit(intel_ipc_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>");
+MODULE_DESCRIPTION("Intel IPC device class driver");
diff --git a/include/linux/platform_data/x86/intel_ipc_dev.h b/include/linux/platform_data/x86/intel_ipc_dev.h
new file mode 100644
index 0000000..9e6ce6d
--- /dev/null
+++ b/include/linux/platform_data/x86/intel_ipc_dev.h
@@ -0,0 +1,246 @@
+/*
+ * Intel IPC class device header file.
+ *
+ * (C) Copyright 2017 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ */
+
+#ifndef INTEL_IPC_DEV_H
+#define INTEL_IPC_DEV_H
+
+#include <linux/module.h>
+#include <linux/device.h>
+
+/* IPC channel type */
+#define IPC_CHANNEL_IA_PMC                      0
+#define IPC_CHANNEL_IA_PUNIT                    1
+#define IPC_CHANNEL_PMC_PUNIT                   2
+#define IPC_CHANNEL_IA_SCU                      3
+#define IPC_CHANNEL_MAX                         4
+
+/* IPC return code */
+#define IPC_DEV_ERR_NONE			0
+#define IPC_DEV_ERR_CMD_NOT_SUPPORTED		1
+#define IPC_DEV_ERR_CMD_NOT_SERVICED		2
+#define IPC_DEV_ERR_UNABLE_TO_SERVICE		3
+#define IPC_DEV_ERR_CMD_INVALID			4
+#define IPC_DEV_ERR_CMD_FAILED			5
+#define IPC_DEV_ERR_EMSECURITY			6
+#define IPC_DEV_ERR_UNSIGNEDKERNEL		7
+#define IPC_DEV_ERR_MAX				8
+
+/* IPC mode */
+#define IPC_DEV_MODE_IRQ			0
+#define IPC_DEV_MODE_POLLING			1
+
+/* IPC dev constants */
+#define IPC_DEV_CMD_LOOP_CNT			3000000
+#define IPC_DEV_CMD_TIMEOUT			(3 * HZ)
+#define IPC_DEV_DATA_BUFFER_SIZE		16
+
+struct intel_ipc_dev;
+struct intel_ipc_raw_cmd;
+
+/**
+ * struct intel_ipc_dev_cfg - IPC device config structure.
+ *
+ * IPC device drivers uses the following config options to
+ * register new IPC device.
+ *
+ * @cmd_regs            : IPC device command base regmap.
+ * @data_regs           : IPC device data base regmap.
+ * @wrbuf_reg           : IPC device data write register address.
+ * @rbuf_reg            : IPC device data read register address.
+ * @sptr_reg            : IPC device source data pointer register address.
+ * @dptr_reg            : IPC device destination data pointer register
+ *                        address.
+ * @status_reg          : IPC command status register address.
+ * @cmd_reg             : IPC command register address.
+ * @mode                : IRQ/POLLING mode.
+ * @irq                 : IPC device IRQ number.
+ * @irqflags            : IPC device IRQ flags.
+ * @chan_type           : IPC device channel type(PMC/PUNIT).
+ * @msi                 : Enable/Disable MSI for IPC commands.
+ * @support_dptr        : Support DPTR update.
+ * @support_sptr        : Support SPTR update.
+ *
+ */
+struct intel_ipc_dev_cfg {
+	struct regmap *cmd_regs;
+	struct regmap *data_regs;
+	unsigned int wrbuf_reg;
+	unsigned int rbuf_reg;
+	unsigned int sptr_reg;
+	unsigned int dptr_reg;
+	unsigned int status_reg;
+	unsigned int cmd_reg;
+	int mode;
+	int irq;
+	int irqflags;
+	int chan_type;
+	bool use_msi;
+	bool support_dptr;
+	bool support_sptr;
+};
+
+/**
+ * struct intel_ipc_raw_cmd - Intel IPC raw command args.
+ *
+ * @cmd_list    : Array of commands/sub-commands.
+ * @cmdlen      : Number of commands.
+ * @in          : Input data of this IPC command.
+ * @inlen       : Input data length in bytes.
+ * @out         : Output data of this IPC command.
+ * @outlen      : Length of output data in dwords.
+ * @dptr        : IPC destination data address.
+ * @sptr        : IPC source data address.
+ *
+ */
+struct intel_ipc_raw_cmd {
+	u32 *cmd_list;
+	u32 cmdlen;
+	u8 *in;
+	u32 inlen;
+	u32 *out;
+	u32 outlen;
+	u32 dptr;
+	u32 sptr;
+};
+
+/**
+ * struct intel_ipc_raw_cmd - Intel IPC command args.
+ *
+ * @cmd_list    : Array of commands/sub-commands.
+ * @cmdlen      : Number of commands.
+ * @in          : Input data of this IPC command.
+ * @inlen       : Input data length in bytes.
+ * @out         : Output data of this IPC command.
+ * @outlen      : Length of output data in dwords.
+ *
+ */
+struct intel_ipc_cmd {
+	u32 *cmd_list;
+	u32 cmdlen;
+	u32 *in;
+	u32 inlen;
+	u32 *out;
+	u32 outlen;
+};
+
+/**
+ * struct intel_ipc_dev_ops - IPC device ops structure.
+ *
+ * Call backs for IPC device specific operations.
+ *
+ * @to_err_code         : Status to error code conversion function.
+ * @busy_check          : Check for IPC busy status.
+ * @enable_msi          : Enable MSI for IPC commands.
+ * @pre_simple_cmd_fn   : Custom pre-processing function for
+ *                        ipc_dev_simple_cmd()
+ * @pre_cmd_fn          : Custom pre-processing function for
+ *                        ipc_dev_cmd()
+ * @pre_raw_cmd_fn      : Custom pre-processing function for
+ *                        ipc_dev_raw_cmd()
+ *
+ */
+struct intel_ipc_dev_ops {
+	int (*to_err_code)(int status);
+	int (*busy_check)(int status);
+	u32 (*enable_msi)(u32 cmd);
+	int (*pre_simple_cmd_fn)(u32 *cmd_list, u32 cmdlen);
+	int (*pre_cmd_fn)(struct intel_ipc_cmd *ipc_cmd);
+	int (*pre_raw_cmd_fn)(struct intel_ipc_raw_cmd *ipc_raw_cmd);
+	int (*pre_irq_handler_fn)(struct intel_ipc_dev *ipc_dev, int irq);
+};
+
+/**
+ * struct intel_ipc_dev - Intel IPC device structure.
+ *
+ * Used with devm_intel_ipc_dev_create() to create new IPC device.
+ *
+ * @dev                 : IPC device object.
+ * @cmd                 : Current IPC device command.
+ * @cmd_complete        : Command completion object.
+ * @lock                : Lock to protect IPC device structure.
+ * @ops                 : IPC device ops pointer.
+ * @cfg                 : IPC device cfg pointer.
+ *
+ */
+struct intel_ipc_dev {
+	struct device dev;
+	int cmd;
+	struct completion cmd_complete;
+	struct mutex lock;
+	struct intel_ipc_dev_ops *ops;
+	struct intel_ipc_dev_cfg *cfg;
+};
+
+#if IS_ENABLED(CONFIG_INTEL_IPC_DEV)
+
+/* API to create new IPC device */
+struct intel_ipc_dev *devm_intel_ipc_dev_create(struct device *dev,
+		const char *devname, struct intel_ipc_dev_cfg *cfg,
+		struct intel_ipc_dev_ops *ops);
+
+int ipc_dev_simple_cmd(struct intel_ipc_dev *ipc_dev, u32 *cmd_list,
+		u32 cmdlen);
+int ipc_dev_cmd(struct intel_ipc_dev *ipc_dev, struct intel_ipc_cmd *ipc_cmd);
+int ipc_dev_raw_cmd(struct intel_ipc_dev *ipc_dev,
+		struct intel_ipc_raw_cmd *ipc_raw_cmd);
+struct intel_ipc_dev *intel_ipc_dev_get(const char *dev_name);
+struct intel_ipc_dev *devm_intel_ipc_dev_get(struct device *dev,
+					const char *dev_name);
+static inline void intel_ipc_dev_put(struct intel_ipc_dev *ipc_dev)
+{
+	put_device(&ipc_dev->dev);
+}
+#else
+
+static inline struct intel_ipc_dev *devm_intel_ipc_dev_create(
+		struct device *dev,
+		const char *devname, struct intel_ipc_dev_cfg *cfg,
+		struct intel_ipc_dev_ops *ops)
+{
+	return -EINVAL;
+}
+
+static inline int ipc_dev_simple_cmd(struct intel_ipc_dev *ipc_dev,
+		u32 *cmd_list, u32 cmdlen)
+{
+	return -EINVAL;
+}
+
+static int ipc_dev_cmd(struct intel_ipc_dev *ipc_dev,
+		struct intel_ipc_cmd *ipc_cmd)
+{
+	return -EINVAL;
+}
+
+static inline int ipc_dev_raw_cmd(struct intel_ipc_dev *ipc_dev,
+		struct intel_ipc_raw_cmd *ipc_raw_cmd);
+{
+	return -EINVAL;
+}
+
+static inline struct intel_ipc_dev *intel_ipc_dev_get(const char *dev_name)
+{
+	return NULL;
+}
+
+static inline struct intel_ipc_dev *devm_intel_ipc_dev_get(struct device *dev,
+					const char *dev_name);
+{
+	return NULL;
+}
+
+static inline void intel_ipc_dev_put(struct intel_ipc_dev *ipc_dev)
+{
+	return NULL;
+}
+#endif /* CONFIG_INTEL_IPC_DEV */
+#endif /* INTEL_IPC_DEV_H */
-- 
2.7.4

