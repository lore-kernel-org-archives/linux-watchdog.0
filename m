Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34669 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754965AbcKBIiO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Nov 2016 04:38:14 -0400
From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, wsa@the-dreams.de, lee.jones@linaro.org,
        jingoohan1@gmail.com, tomi.valkeinen@ti.com, wim@iguana.be,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        k.kozlowski@samsung.com
Cc: Richard Vidal-Dorsch <richard.dorsch@gmail.com>,
        jo.sunga@advantech.com, weilun.huang@advantech.com,
        andrew.chou@advantech.com
Subject: [PATCH v4 6/6] Add Advantech iManager Watchdog driver
Date: Wed,  2 Nov 2016 01:37:51 -0700
Message-Id: <20161102083751.6335-7-richard.dorsch@gmail.com>
In-Reply-To: <20161102083751.6335-1-richard.dorsch@gmail.com>
References: <20161102083751.6335-1-richard.dorsch@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 drivers/watchdog/Kconfig        |  11 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/imanager_wdt.c | 303 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+)
 create mode 100644 drivers/watchdog/imanager_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fdd3228..d6859da 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -912,6 +912,17 @@ config WAFER_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called wafer5823wdt.
 
+config IMANAGER_WDT
+	tristate "Advantech iManager Watchdog"
+	depends on MFD_IMANAGER
+	select WATCHDOG_CORE
+	help
+	  Support for Advantech iManager watchdog on some Advantech
+	  SOM, MIO, AIMB, and PCM modules/boards.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called imanager_wdt.
+
 config I6300ESB_WDT
 	tristate "Intel 6300ESB Timer/Watchdog"
 	depends on PCI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index caa9f4a..eb7fccf 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -117,6 +117,7 @@ endif
 obj-$(CONFIG_IT8712F_WDT) += it8712f_wdt.o
 obj-$(CONFIG_IT87_WDT) += it87_wdt.o
 obj-$(CONFIG_HP_WATCHDOG) += hpwdt.o
+obj-$(CONFIG_IMANAGER_WDT) += imanager_wdt.o
 obj-$(CONFIG_KEMPLD_WDT) += kempld_wdt.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
diff --git a/drivers/watchdog/imanager_wdt.c b/drivers/watchdog/imanager_wdt.c
new file mode 100644
index 0000000..53b409e
--- /dev/null
+++ b/drivers/watchdog/imanager_wdt.c
@@ -0,0 +1,303 @@
+/*
+ * Advantech iManager Watchdog driver
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd.
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitops.h>
+#include <linux/byteorder/generic.h>
+#include <linux/device.h>
+#include <linux/mfd/imanager.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+#define WDT_DEFAULT_TIMEOUT	30 /* seconds */
+#define WDT_FREQ		10 /* Hz */
+
+struct imanager_wdt_data {
+	struct imanager_device_data *imgr;
+	struct watchdog_device wdt;
+	ulong last_updated;
+	uint timeout;
+};
+
+static uint timeout = WDT_DEFAULT_TIMEOUT;
+module_param(timeout, uint, 0444);
+MODULE_PARM_DESC(timeout,
+		 "Watchdog timeout in seconds. 1 <= timeout <= 65534, default="
+		 __MODULE_STRING(WDT_DEFAULT_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0444);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+enum wdt_ctrl {
+	START = 1, STOP, RESET, GET_TIMEOUT, SET_TIMEOUT, STOPBOOT = 8
+};
+
+enum imanager_wdt_event {
+	WDT_EVT_NONE,
+	WDT_EVT_DELAY,
+	WDT_EVT_PWRBTN,
+	WDT_EVT_NMI,
+	WDT_EVT_RESET,
+	WDT_EVT_WDPIN,
+	WDT_EVT_SCI,
+};
+
+struct event_delay {
+	u16	delay,
+		pwrbtn,
+		nmi,
+		reset,
+		wdpin,
+		sci,
+		dummy;
+} __attribute__((__packed__));
+
+static int imanager_wdt_ctrl(struct imanager_ec_data *ec, int ctrl,
+			     int event_type, uint timeout)
+{
+	struct imanager_ec_message msg = {
+		IMANAGER_MSG_SIMPLE(0, 0, ctrl, NULL)
+	};
+	u8 *fevent = &msg.u.data[0];
+	struct event_delay *event = (struct event_delay *)&msg.u.data[1];
+	int val;
+
+	if (ctrl == SET_TIMEOUT) {
+		memset(event, 0xff, sizeof(*event));
+		msg.wlen = sizeof(*event);
+		*fevent = 0;
+		val = (!timeout) ? 0xffff : cpu_to_be16(timeout * WDT_FREQ);
+
+		switch (event_type) {
+		case WDT_EVT_DELAY:
+			event->delay = val;
+			break;
+		case WDT_EVT_PWRBTN:
+			event->pwrbtn = val;
+			break;
+		case WDT_EVT_NMI:
+			event->nmi = val;
+			break;
+		case WDT_EVT_RESET:
+			event->reset = val;
+			break;
+		case WDT_EVT_WDPIN:
+			event->wdpin = val;
+			break;
+		case WDT_EVT_SCI:
+			event->sci = val;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return imanager_write(ec, EC_CMD_WDT_CTRL, &msg);
+}
+
+static inline int imanager_wdt_disable_all(struct imanager_wdt_data *data)
+{
+	struct imanager_ec_data *ec = &data->imgr->ec;
+
+	return (imanager_wdt_ctrl(ec, STOP, WDT_EVT_NONE, 0) ||
+		imanager_wdt_ctrl(ec, STOPBOOT, WDT_EVT_NONE, 0));
+}
+
+static int imanager_wdt_set(struct imanager_wdt_data *data, uint timeout)
+{
+	struct imanager_ec_data *ec = &data->imgr->ec;
+	int ret;
+
+	if (time_before(jiffies, data->last_updated + HZ + HZ / 2))
+		return 0;
+
+	if (data->timeout == timeout)
+		return 0;
+
+	ret = imanager_wdt_ctrl(ec, SET_TIMEOUT, WDT_EVT_PWRBTN, timeout);
+	if (ret < 0)
+		return ret;
+
+	data->timeout = timeout;
+	data->last_updated = jiffies;
+
+	return 0;
+}
+
+static int imanager_wdt_set_timeout(struct watchdog_device *wdt, uint timeout)
+{
+	struct imanager_wdt_data *data = watchdog_get_drvdata(wdt);
+	struct imanager_device_data *imgr = data->imgr;
+	int ret;
+
+	mutex_lock(&imgr->lock);
+	ret = imanager_wdt_set(data, timeout);
+	mutex_unlock(&imgr->lock);
+
+	return ret;
+}
+
+static uint imanager_wdt_get_timeleft(struct watchdog_device *wdt)
+{
+	struct imanager_wdt_data *data = watchdog_get_drvdata(wdt);
+	uint timeleft = 0;
+	ulong time_diff = ((jiffies - data->last_updated) / HZ);
+
+	if (data->last_updated && (data->timeout > time_diff))
+		timeleft = data->timeout - time_diff;
+
+	return timeleft;
+}
+
+static int imanager_wdt_start(struct watchdog_device *wdt)
+{
+	struct imanager_wdt_data *data = watchdog_get_drvdata(wdt);
+	struct imanager_device_data *imgr = data->imgr;
+	int ret;
+
+	mutex_lock(&imgr->lock);
+	ret = imanager_wdt_ctrl(&imgr->ec, START, WDT_EVT_NONE, 0);
+	data->last_updated = jiffies;
+	mutex_unlock(&imgr->lock);
+
+	return ret;
+}
+
+static int imanager_wdt_stop(struct watchdog_device *wdt)
+{
+	struct imanager_wdt_data *data = watchdog_get_drvdata(wdt);
+	struct imanager_device_data *imgr = data->imgr;
+	int ret;
+
+	mutex_lock(&imgr->lock);
+	ret = imanager_wdt_ctrl(&imgr->ec, STOP, WDT_EVT_NONE, 0);
+	data->last_updated = 0;
+	mutex_unlock(&imgr->lock);
+
+	return ret;
+}
+
+static int imanager_wdt_ping(struct watchdog_device *wdt)
+{
+	struct imanager_wdt_data *data = watchdog_get_drvdata(wdt);
+	struct imanager_device_data *imgr = data->imgr;
+	int ret;
+
+	mutex_lock(&imgr->lock);
+	ret = imanager_wdt_ctrl(&imgr->ec, RESET, WDT_EVT_NONE, 0);
+	data->last_updated = jiffies;
+	mutex_unlock(&imgr->lock);
+
+	return ret;
+}
+
+static const struct watchdog_info imanager_wdt_info = {
+	.options		= WDIOF_SETTIMEOUT |
+				  WDIOF_KEEPALIVEPING |
+				  WDIOF_MAGICCLOSE,
+	.firmware_version	= 0,
+	.identity		= "imanager-wdt",
+};
+
+static const struct watchdog_ops imanager_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= imanager_wdt_start,
+	.stop		= imanager_wdt_stop,
+	.ping		= imanager_wdt_ping,
+	.set_timeout	= imanager_wdt_set_timeout,
+	.get_timeleft	= imanager_wdt_get_timeleft,
+};
+
+static int imanager_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_device_data *imgr = dev_get_drvdata(dev->parent);
+	struct imanager_wdt_data *data;
+	struct watchdog_device *wdt_dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->imgr = imgr;
+
+	wdt_dev = &data->wdt;
+	wdt_dev->info		= &imanager_wdt_info;
+	wdt_dev->ops		= &imanager_wdt_ops;
+	wdt_dev->timeout	= WDT_DEFAULT_TIMEOUT;
+	wdt_dev->min_timeout	= 1;
+	wdt_dev->max_timeout	= 0xfffe;
+
+	watchdog_set_nowayout(wdt_dev, nowayout);
+	watchdog_set_drvdata(wdt_dev, data);
+
+	ret = watchdog_register_device(wdt_dev);
+	if (ret) {
+		dev_err(dev, "Could not register watchdog device\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	imanager_wdt_disable_all(data);
+	imanager_wdt_set_timeout(wdt_dev, timeout);
+
+	dev_info(dev, "Driver loaded (timeout=%d seconds)\n", timeout);
+
+	return 0;
+}
+
+static int imanager_wdt_remove(struct platform_device *pdev)
+{
+	struct imanager_wdt_data *data = platform_get_drvdata(pdev);
+
+	if (!nowayout)
+		imanager_wdt_disable_all(data);
+
+	watchdog_unregister_device(&data->wdt);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static void imanager_wdt_shutdown(struct platform_device *pdev)
+{
+	struct imanager_device_data *imgr = dev_get_drvdata(pdev->dev.parent);
+
+	mutex_lock(&imgr->lock);
+	imanager_wdt_ctrl(&imgr->ec, STOP, WDT_EVT_NONE, 0);
+	mutex_unlock(&imgr->lock);
+}
+
+static struct platform_driver imanager_wdt_driver = {
+	.driver = {
+		.name	= "imanager-wdt",
+	},
+	.probe		= imanager_wdt_probe,
+	.remove		= imanager_wdt_remove,
+	.shutdown	= imanager_wdt_shutdown,
+};
+
+module_platform_driver(imanager_wdt_driver);
+
+MODULE_DESCRIPTION("Advantech iManager Watchdog Driver");
+MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imanager-wdt");
-- 
2.10.1

