Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57854 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab1AJKz0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Jan 2011 05:55:26 -0500
Received: by wwa36 with SMTP id 36so520531wwa.1
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Jan 2011 02:55:25 -0800 (PST)
From: Jamie Iles <jamie@jamieiles.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Jamie Iles <jamie@jamieiles.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
Date: Mon, 10 Jan 2011 10:55:06 +0000
Message-Id: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Synopsys DesignWare watchdog is found in several ARM based systems
and provides a choice of 16 timeout periods depending on the clock
input.  The watchdog cannot be disabled once started.

If the platform does not provide a clk for the watchdog then the user
can specify the input frequency with the struct dw_wdt_platform_data in
<linux/platform_data/dw_wdt.h>

v4:
	- cleanups as suggested by Viresh Kumar and Wim
	- provide a mechanism to handle NULL clks and allow
	  platform_data to specify the clk_rate
	- provide open-once protection

v3:
	- convert pm to dev_pm_ops
	- use devres for resource allocation

v2:
	- constify fops
	- request_mem_region() before ioremap()
	- disable clk if misc_register() fails

Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

Viresh, Russell, Wim - thanks for your feedback.

include/linux/platform_data is used for the platform data as suggested
by Greg K-H in [1].

1. https://lkml.org/lkml/2011/1/7/323

 drivers/watchdog/Kconfig             |    9 +
 drivers/watchdog/Makefile            |    1 +
 drivers/watchdog/dw_wdt.c            |  329 ++++++++++++++++++++++++++++++++++
 include/linux/platform_data/dw_wdt.h |   27 +++
 4 files changed, 366 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/dw_wdt.c
 create mode 100644 include/linux/platform_data/dw_wdt.h

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8a3aa2f..0981aae 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -331,6 +331,15 @@ config IMX2_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx2_wdt.
 
+config DW_WATCHDOG
+	tristate "Synopsys DesignWare watchdog"
+        select WATCHDOG_NOWAYOUT
+	help
+	  Say Y here if to include support for the Synopsys DesignWare
+	  watchdog timer found in many ARM chips.
+	  To compile this driver as a module, choose M here: the
+	  module will be called dw_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 4b0ef38..3b3da4a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
 obj-$(CONFIG_ADX_WATCHDOG) += adx_wdt.o
 obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
+obj-$(CONFIG_DW_WATCHDOG) += dw_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
new file mode 100644
index 0000000..b6d9b6e
--- /dev/null
+++ b/drivers/watchdog/dw_wdt.c
@@ -0,0 +1,329 @@
+/*
+ * Copyright 2010-2011 Picochip Ltd., Jamie Iles
+ * http://www.picochip.com
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This file implements a driver for the Synopsys DesignWare watchdog device
+ * in the many ARM subsystems. The watchdog has 16 different timeout periods
+ * and these are a function of the input clock frequency.
+ */
+#define pr_fmt(fmt) "dw_wdt: " fmt
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/watchdog.h>
+
+#include <linux/platform_data/dw_wdt.h>
+
+#define WDOG_CONTROL_REG_OFFSET             0x00
+#define WDOG_CONTROL_REG_WDT_EN_MASK	    0x01
+#define WDOG_TIMEOUT_RANGE_REG_OFFSET       0x04
+#define WDOG_CURRENT_COUNT_REG_OFFSET       0x08
+#define WDOG_COUNTER_RESTART_REG_OFFSET     0x0c
+#define WDOG_COUNTER_RESTART_KICK_VALUE	    0x76
+
+/* The maximum TOP (timeout period) value that can be set in the watchdog. */
+#define DW_WDT_MAX_TOP		15
+
+static struct {
+	spinlock_t		lock;
+	void __iomem		*regs;
+	struct clk		*clk;
+	unsigned long		clk_rate;
+	unsigned long		in_use;
+} dw_wdt;
+
+static inline int dw_wdt_is_enabled(void)
+{
+	return readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET) &
+		WDOG_CONTROL_REG_WDT_EN_MASK;
+}
+
+static inline int dw_wdt_top_in_seconds(unsigned top)
+{
+	/*
+	 * There are 16 possible timeout values in 0..15 where the number of
+	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
+	 */
+	return (1 << (16 + top)) / dw_wdt.clk_rate;
+}
+
+static int dw_wdt_set_top(unsigned top_s)
+{
+	int i, top_val = -1;
+
+	/*
+	 * Iterate over the timeout values until we find the closest match. We
+	 * always look for >=.
+	 */
+	for (i = 0; i <= DW_WDT_MAX_TOP; ++i)
+		if (dw_wdt_top_in_seconds(i) >= top_s) {
+			top_val = i;
+			break;
+		}
+
+	/*
+	 * If we didn't find a suitable value, it must have been too large. Go
+	 * with the biggest that we can.
+	 */
+	if (top_val < 0)
+		top_val = DW_WDT_MAX_TOP;
+
+	/* Set the new value in the watchdog. */
+	writel(top_val, dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
+
+	return dw_wdt_top_in_seconds(top_val);
+}
+
+static int dw_wdt_get_top(void)
+{
+	int top = readl(dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET) & 0xF;
+
+	return dw_wdt_top_in_seconds(top);
+}
+
+static void dw_wdt_keepalive(void)
+{
+	writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
+	       WDOG_COUNTER_RESTART_REG_OFFSET);
+}
+
+static int dw_wdt_open(struct inode *inode, struct file *filp)
+{
+	if (test_and_set_bit(0, &dw_wdt.in_use))
+		return -EBUSY;
+
+	/* Make sure we don't get unloaded. */
+	__module_get(THIS_MODULE);
+
+	spin_lock(&dw_wdt.lock);
+	if (!dw_wdt_is_enabled()) {
+		/*
+		 * The watchdog is not currently enabled. Set the timeout to
+		 * the maximum and then start it.
+		 */
+		dw_wdt_set_top(DW_WDT_MAX_TOP);
+		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
+		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
+	}
+	spin_unlock(&dw_wdt.lock);
+
+	return nonseekable_open(inode, filp);
+}
+
+ssize_t dw_wdt_write(struct file *filp, const char __user *buf, size_t len,
+		     loff_t *offset)
+{
+	dw_wdt_keepalive();
+
+	return len;
+}
+
+static u32 dw_wdt_time_left(void)
+{
+	return readl(dw_wdt.regs + WDOG_CURRENT_COUNT_REG_OFFSET) /
+		dw_wdt.clk_rate;
+}
+
+static const struct watchdog_info dw_wdt_ident = {
+	.options	= WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.identity	= "Synopsys DesignWare Watchdog",
+};
+
+static long dw_wdt_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	unsigned long val;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		return copy_to_user((struct watchdog_info *)arg, &dw_wdt_ident,
+				    sizeof(dw_wdt_ident)) ? -EFAULT : 0;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, (int *)arg);
+
+	case WDIOC_KEEPALIVE:
+		dw_wdt_keepalive();
+		return 0;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(val, (int __user *)arg))
+			return -EFAULT;
+		return put_user(dw_wdt_set_top(val), (int __user *)arg);
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(dw_wdt_get_top(), (int __user *)arg);
+
+	case WDIOC_GETTIMELEFT:
+		/* Get the time left until expiry. */
+		if (get_user(val, (int __user *)arg))
+			return -EFAULT;
+		return put_user(dw_wdt_time_left(), (int __user *)arg);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int dw_wdt_release(struct inode *inode, struct file *filp)
+{
+	pr_crit("WATCHDOG: device closed - timer will not stop\n");
+
+	clear_bit(0, &dw_wdt.in_use);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int dw_wdt_suspend(struct device *dev)
+{
+	clk_disable(dw_wdt.clk);
+
+	return 0;
+}
+
+static int dw_wdt_resume(struct device *dev)
+{
+	int err = clk_enable(dw_wdt.clk);
+
+	if (err)
+		return err;
+
+	dw_wdt_keepalive();
+
+	return 0;
+}
+
+static const struct dev_pm_ops dw_wdt_pm_ops = {
+	.suspend	= dw_wdt_suspend,
+	.resume		= dw_wdt_resume,
+};
+#endif /* CONFIG_PM */
+
+static const struct file_operations wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.open		= dw_wdt_open,
+	.write		= dw_wdt_write,
+	.unlocked_ioctl	= dw_wdt_ioctl,
+	.release	= dw_wdt_release
+};
+
+static struct miscdevice dw_wdt_miscdev = {
+	.fops		= &wdt_fops,
+	.name		= "watchdog",
+	.minor		= WATCHDOG_MINOR,
+};
+
+static int __devinit dw_wdt_drv_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct dw_wdt_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!mem)
+		return -EINVAL;
+
+	if (!devm_request_mem_region(&pdev->dev, mem->start, resource_size(mem),
+				     "dw_wdt"))
+		return -ENOMEM;
+
+	dw_wdt.regs = devm_ioremap(&pdev->dev, mem->start,
+					     resource_size(mem));
+	if (!dw_wdt.regs)
+		return -ENOMEM;
+
+	dw_wdt.clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dw_wdt.clk))
+		return -ENODEV;
+
+	ret = clk_enable(dw_wdt.clk);
+	if (ret)
+		goto out_put_clk;
+
+	/*
+	 * The timeout period of the watchdog is derived from the input clock
+	 * frequency.  For platforms that don't have a clk for the watchdog,
+	 * they can specify the WDT clock rate through the clk_rate field of
+	 * the struct dw_wdt_platform_data platform data.
+	 */
+	if (pdata && pdata->clk_rate > 0)
+		dw_wdt.clk_rate = pdata->clk_rate;
+	else
+		dw_wdt.clk_rate = clk_get_rate(dw_wdt.clk);
+
+	if (!dw_wdt.clk_rate) {
+		dev_err(&pdev->dev, "no clk rate defined for watchdog, cannot enable\n");
+		ret = -EINVAL;
+		goto out_disable_clk;
+	}
+
+	spin_lock_init(&dw_wdt.lock);
+
+	ret = misc_register(&dw_wdt_miscdev);
+	if (ret)
+		goto out_put_clk;
+
+	return 0;
+
+out_disable_clk:
+	clk_disable(dw_wdt.clk);
+out_put_clk:
+	clk_put(dw_wdt.clk);
+
+	return ret;
+}
+
+static int __devexit dw_wdt_drv_remove(struct platform_device *pdev)
+{
+	misc_deregister(&dw_wdt_miscdev);
+
+	clk_disable(dw_wdt.clk);
+	clk_put(dw_wdt.clk);
+
+	return 0;
+}
+
+static struct platform_driver dw_wdt_driver = {
+	.probe		= dw_wdt_drv_probe,
+	.remove		= __devexit_p(dw_wdt_drv_remove),
+	.driver		= {
+		.name	= "dw_wdt",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &dw_wdt_pm_ops,
+#endif /* CONFIG_PM */
+	},
+};
+
+static int __init dw_wdt_watchdog_init(void)
+{
+	return platform_driver_register(&dw_wdt_driver);
+}
+module_init(dw_wdt_watchdog_init);
+
+static void __exit dw_wdt_watchdog_exit(void)
+{
+	platform_driver_unregister(&dw_wdt_driver);
+}
+module_exit(dw_wdt_watchdog_exit);
+
+MODULE_AUTHOR("Jamie Iles");
+MODULE_DESCRIPTION("Synopsys DesignWare Watchdog Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/dw_wdt.h b/include/linux/platform_data/dw_wdt.h
new file mode 100644
index 0000000..0af10ef
--- /dev/null
+++ b/include/linux/platform_data/dw_wdt.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2010 Picochip Ltd., Jamie Iles
+ * http://www.picochip.com
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This file implements a driver for the Synopsys DesignWare watchdog device
+ * in the many ARM subsystems. The watchdog has 16 different timeout periods
+ * and these are a function of the input clock frequency.
+ */
+#ifndef __DW_WDT_H__
+#define __DW_WDT_H__
+
+/**
+ * struct dw_wdt_platform_data - DesignWare WDT platform data
+ *
+ * @clk_rate: The frequency (HZ) at which the watchdog is driven.  The timeout
+ *	periods are derived from this frequency.
+ */
+struct dw_wdt_platform_data {
+	unsigned long		clk_rate;
+};
+
+#endif /* __DW_WDT_H__ */
-- 
1.7.3.4

