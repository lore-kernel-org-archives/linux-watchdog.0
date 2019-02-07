Return-Path: <SRS0=sDHB=QO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1A3C282C2
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Feb 2019 21:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D373F21907
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Feb 2019 21:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBGVLE (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:11:04 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55046 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727445AbfBGVLE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 7 Feb 2019 16:11:04 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from michaelsh@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 Feb 2019 23:11:00 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x17LAuEP023763;
        Thu, 7 Feb 2019 23:11:00 +0200
From:   michaelsh@mellanox.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v2 2/3] watchdog: mlx-wdt: introduce watchdog driver for Mellanox systems.
Date:   Thu,  7 Feb 2019 21:10:52 +0000
Message-Id: <20190207211053.10766-3-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190207211053.10766-1-michaelsh@mellanox.com>
References: <20190207211053.10766-1-michaelsh@mellanox.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

Introduce watchdog driver for variious rang of Mellanox Ethernet and
Infiniband switch systems.

Watchdog driver for Mellanox watchdog devices, implemented in
programmable logic device.

Main and auxiliary watchdog devices can exist on the same system.
There are several actions that can be defined in the watchdog:
system reset, start fans on full speed and increase a counter.
The last 2 actions are performed without a system reset.
Actions without reset are provided for auxiliary watchdog devices,
which is optional.
Access to HW registers is performed through generic
regmap interface.

There are 2 types of HW watchdog implementations.
Type 1: actual HW timeout can be defined as power of 2 msec.
e.g. timeout 20 sec will be rounded up to 32768 msec.;
maximum timeout period is 32 sec (32768 msec.);
get time-left isn't supported
Type 2: actual HW timeout is defined in sec. and it's the same as
user-defined timeout;
maximum timeout is 255 sec;
get time-left is supported;

Watchdog driver is probed from the common mlx_platform driver.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>

---
v1->v2:
Comments pointed out by Guenter:
1. Remove unneeded lock in access functions.
2. Change return  int to void in functions with constant 0 return value
   or with unchecked returned code.
3. Use regmap_update_bits() or regmap_update_bits_base() functions.
4. Remove unneeded dev_info messages.
5. Change set_timeout function.
6. Changes in probe
7. Delete unneeded remove function.
---
 drivers/watchdog/Kconfig   |  16 +++
 drivers/watchdog/Makefile  |   1 +
 drivers/watchdog/mlx_wdt.c | 323 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 drivers/watchdog/mlx_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 57f017d74a97..f1766eb081bb 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -241,6 +241,22 @@ config RAVE_SP_WATCHDOG
 	help
 	  Support for the watchdog on RAVE SP device.
 
+config MLX_WDT
+	tristate "Mellanox Watchdog"
+	depends on MELLANOX_PLATFORM
+	select WATCHDOG_CORE
+	select REGMAP
+	help
+	  This is the driver for the hardware watchdog on Mellanox systems.
+	  If you are going to use it, say Y here, otherwise N.
+	  This driver can be used together with the watchdog daemon.
+	  It can also watch your kernel to make sure it doesn't freeze,
+	  and if it does, it reboots your system after a certain amount of
+	  time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mlx-wdt.
+
 # ALPHA Architecture
 
 # ARM Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index a0917ef28e07..941b74185c9c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
 obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
 obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
 obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
+obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
 
 # M68K Architecture
 obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
diff --git a/drivers/watchdog/mlx_wdt.c b/drivers/watchdog/mlx_wdt.c
new file mode 100644
index 000000000000..c8fad72c9137
--- /dev/null
+++ b/drivers/watchdog/mlx_wdt.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Mellanox watchdog driver
+ *
+ * Copyright (C) 2019 Mellanox Technologies
+ * Copyright (C) 2019 Michael Shych <mshych@mellanox.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/platform_data/mlxreg.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define MLXREG_WDT_CLOCK_SCALE		1000
+#define MLXREG_WDT_MAX_TIMEOUT_TYPE1	32
+#define MLXREG_WDT_MAX_TIMEOUT_TYPE2	255
+#define MLXREG_WDT_MIN_TIMEOUT		1
+#define MLXREG_WDT_HW_TIMEOUT_CONVERT(hw_timeout) ((1 << (hw_timeout)) \
+						   / MLXREG_WDT_CLOCK_SCALE)
+#define MLXREG_WDT_OPTIONS_BASE (WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | \
+				 WDIOF_SETTIMEOUT)
+
+/**
+ * enum mlxreg_wdt_type - type of HW watchdog
+ *
+ * TYPE1 can be differentiated by different register/mask
+ *	 for WD action set and ping.
+ */
+enum mlxreg_wdt_type {
+	MLX_WDT_TYPE1,
+	MLX_WDT_TYPE2,
+};
+
+/**
+ * struct mlxreg_wdt - wd private data:
+ *
+ * @wdd:	watchdog device;
+ * @device:	basic device;
+ * @pdata:	data received from platform driver;
+ * @regmap:	register map of parent device;
+ * @timeout:	defined timeout in sec.;
+ * @hw_timeout:	real timeout set in hw;
+ *		It will be roundup base of 2 in WD type 1,
+ *		in WD type 2 it will be same number of sec as timeout;
+ * @action_idx:	index for direct access to action register;
+ * @timeout_idx:index for direct access to TO register;
+ * @tleft_idx:	index for direct access to time left register;
+ * @ping_idx:	index for direct access to ping register;
+ * @reset_idx:	index for direct access to reset cause register;
+ * @wd_type:	watchdog HW type;
+ * @hw_timeout:	actual HW timeout;
+ */
+struct mlxreg_wdt {
+	struct watchdog_device wdd;
+	struct mlxreg_core_platform_data *pdata;
+	void *regmap;
+	int action_idx;
+	int timeout_idx;
+	int tleft_idx;
+	int ping_idx;
+	int reset_idx;
+	enum mlxreg_wdt_type wdt_type;
+	u8 hw_timeout;
+};
+
+static enum mlxreg_wdt_type
+mlxreg_wdt_check_watchdog_type(struct mlxreg_wdt *wdt,
+			       struct mlxreg_core_platform_data *pdata)
+{
+	if (pdata->data[wdt->action_idx].reg ==
+	    pdata->data[wdt->ping_idx].reg &&
+	    pdata->data[wdt->action_idx].mask ==
+	    pdata->data[wdt->ping_idx].mask)
+		return MLX_WDT_TYPE2;
+
+	return MLX_WDT_TYPE1;
+}
+
+static void mlxreg_wdt_check_card_reset(struct mlxreg_wdt *wdt)
+{
+	struct mlxreg_core_data *reg_data;
+	u32 regval;
+	int rc;
+
+	if (wdt->reset_idx == -EINVAL)
+		return;
+
+	if (!(wdt->wdd.info->options & WDIOF_CARDRESET))
+		return;
+
+	reg_data = &wdt->pdata->data[wdt->reset_idx];
+	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
+	if (!rc) {
+		if (regval & ~reg_data->mask) {
+			wdt->wdd.bootstatus = WDIOF_CARDRESET;
+			dev_info(wdt->wdd.parent,
+				 "watchdog previously reset the CPU\n");
+		}
+	}
+}
+
+static int mlxreg_wdt_start(struct watchdog_device *wdd)
+{
+	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
+	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->action_idx];
+
+	return regmap_update_bits(wdt->regmap, reg_data->reg, ~reg_data->mask,
+				  BIT(reg_data->bit));
+}
+
+static int mlxreg_wdt_stop(struct watchdog_device *wdd)
+{
+	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
+	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->action_idx];
+
+	return regmap_update_bits(wdt->regmap, reg_data->reg, ~reg_data->mask,
+				  ~BIT(reg_data->bit));
+}
+
+static int mlxreg_wdt_ping(struct watchdog_device *wdd)
+{
+	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
+	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->ping_idx];
+
+	return regmap_update_bits_base(wdt->regmap, reg_data->reg,
+				       ~reg_data->mask, BIT(reg_data->bit),
+				       NULL, false, true);
+}
+
+static int mlxreg_wdt_set_timeout(struct watchdog_device *wdd,
+				  unsigned int timeout)
+{
+	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
+	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->timeout_idx];
+	u32 regval, set_time;
+	int rc;
+
+	if (wdt->wdt_type == MLX_WDT_TYPE1) {
+		rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
+		if (rc)
+			goto read_error;
+
+		wdt->hw_timeout = order_base_2(timeout *
+					       MLXREG_WDT_CLOCK_SCALE);
+		regval = (regval & reg_data->mask) | wdt->hw_timeout;
+		/* Rowndown to actual closest number of sec. */
+		set_time = MLXREG_WDT_HW_TIMEOUT_CONVERT(wdt->hw_timeout);
+	} else {
+		wdt->hw_timeout = timeout;
+		set_time = timeout;
+		regval = timeout;
+	}
+
+	wdd->timeout = set_time;
+	rc = regmap_write(wdt->regmap, reg_data->reg, regval);
+
+read_error:
+	if (!rc) {
+		/*
+		 * Restart watchdog with new timeout period
+		 * if watchdog is already started.
+		 */
+		if (watchdog_active(wdd)) {
+			rc = mlxreg_wdt_stop(wdd);
+			if (!rc)
+				rc = mlxreg_wdt_start(wdd);
+		}
+	}
+
+	return rc;
+}
+
+static unsigned int mlxreg_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
+	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->tleft_idx];
+	u32 regval;
+	int rc;
+
+	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
+
+	return rc == 0 ? regval : 0;
+}
+
+static const struct watchdog_ops mlxreg_wdt_ops_type1 = {
+	.start		= mlxreg_wdt_start,
+	.stop		= mlxreg_wdt_stop,
+	.ping		= mlxreg_wdt_ping,
+	.set_timeout	= mlxreg_wdt_set_timeout,
+	.owner		= THIS_MODULE,
+};
+
+static const struct watchdog_ops mlxreg_wdt_ops_type2 = {
+	.start		= mlxreg_wdt_start,
+	.stop		= mlxreg_wdt_stop,
+	.ping		= mlxreg_wdt_ping,
+	.set_timeout	= mlxreg_wdt_set_timeout,
+	.get_timeleft	= mlxreg_wdt_get_timeleft,
+	.owner		= THIS_MODULE,
+};
+
+static const struct watchdog_info mlxreg_wdt_main_info = {
+	.options	= MLXREG_WDT_OPTIONS_BASE
+			| WDIOF_CARDRESET,
+	.identity	= "mlx-wdt-main",
+};
+
+static const struct watchdog_info mlxreg_wdt_aux_info = {
+	.options	= MLXREG_WDT_OPTIONS_BASE
+			| WDIOF_ALARMONLY,
+	.identity	= "mlx-wdt-aux",
+};
+
+static void mlxreg_wdt_config(struct mlxreg_wdt *wdt,
+			      struct mlxreg_core_platform_data *pdata)
+{
+	struct mlxreg_core_data *data = pdata->data;
+	int i;
+
+	wdt->reset_idx = -EINVAL;
+	for (i = 0; i < pdata->counter; i++, data++) {
+		if (strnstr(data->label, "action", sizeof(data->label)))
+			wdt->action_idx = i;
+		else if (strnstr(data->label, "timeout", sizeof(data->label)))
+			wdt->timeout_idx = i;
+		else if (strnstr(data->label, "timeleft", sizeof(data->label)))
+			wdt->tleft_idx = i;
+		else if (strnstr(data->label, "ping", sizeof(data->label)))
+			wdt->ping_idx = i;
+		else if (strnstr(data->label, "reset", sizeof(data->label)))
+			wdt->reset_idx = i;
+	}
+
+	wdt->pdata = pdata;
+	if (strnstr(pdata->identity, mlxreg_wdt_main_info.identity,
+		    sizeof(mlxreg_wdt_main_info.identity)))
+		wdt->wdd.info = &mlxreg_wdt_main_info;
+	else
+		wdt->wdd.info = &mlxreg_wdt_aux_info;
+
+	wdt->wdt_type = mlxreg_wdt_check_watchdog_type(wdt, pdata);
+	if (wdt->wdt_type == MLX_WDT_TYPE2) {
+		wdt->wdd.ops = &mlxreg_wdt_ops_type2;
+		wdt->wdd.max_timeout = MLXREG_WDT_MAX_TIMEOUT_TYPE2;
+	} else {
+		wdt->wdd.ops = &mlxreg_wdt_ops_type1;
+		wdt->wdd.max_timeout = MLXREG_WDT_MAX_TIMEOUT_TYPE1;
+	}
+	wdt->wdd.min_timeout = MLXREG_WDT_MIN_TIMEOUT;
+}
+
+static int mlxreg_wdt_init_timeout(struct mlxreg_wdt *wdt,
+				   struct mlxreg_core_platform_data *pdata)
+{
+	u32 timeout;
+
+	timeout = pdata->data[wdt->timeout_idx].health_cntr;
+	return mlxreg_wdt_set_timeout(&wdt->wdd, timeout);
+}
+
+static int mlxreg_wdt_probe(struct platform_device *pdev)
+{
+	struct mlxreg_core_platform_data *pdata;
+	struct mlxreg_wdt *wdt;
+	int rc;
+
+	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "Failed to get platform data.\n");
+		return -EINVAL;
+	}
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->wdd.parent = &pdev->dev;
+	wdt->regmap = pdata->regmap;
+	mlxreg_wdt_config(wdt, pdata);
+
+	if ((pdata->features & MLXREG_CORE_WD_FEATURE_NOWAYOUT))
+		watchdog_set_nowayout(&wdt->wdd, WATCHDOG_NOWAYOUT);
+	watchdog_stop_on_reboot(&wdt->wdd);
+	watchdog_stop_on_unregister(&wdt->wdd);
+	watchdog_set_drvdata(&wdt->wdd, wdt);
+	rc = mlxreg_wdt_init_timeout(wdt, pdata);
+	if (rc)
+		goto register_error;
+
+	if ((pdata->features & MLXREG_CORE_WD_FEATURE_START_AT_BOOT)) {
+		rc = mlxreg_wdt_start(&wdt->wdd);
+		if (rc)
+			goto register_error;
+	}
+	mlxreg_wdt_check_card_reset(wdt);
+	rc = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
+
+register_error:
+	if (rc)
+		dev_err(&pdev->dev,
+			"Cannot register watchdog device (err=%d)\n", rc);
+	return rc;
+}
+
+static struct platform_driver mlxreg_wdt_driver = {
+	.probe	= mlxreg_wdt_probe,
+	.driver	= {
+			.name = "mlx-wdt",
+	},
+};
+
+module_platform_driver(mlxreg_wdt_driver);
+
+MODULE_AUTHOR("Michael Shych <michaelsh@mellanox.com>");
+MODULE_DESCRIPTION("Mellanox watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mlx-wdt");
-- 
2.11.0

