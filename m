Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57737 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934126AbdAIJvJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jan 2017 04:51:09 -0500
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>, Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: kernel@pengutronix.de, Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] watchdog: imx2: Only i.MX35 and later have a WMCR register
Date: Mon,  9 Jan 2017 10:50:37 +0100
Message-Id: <20170109095039.11979-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on
boot") introduced a write to the WMCR register that doesn't exist on
i.MX21, i.MX27 and i.MX31 and so makes the SoC hang during probe.

So teach the driver to differentiate between these two types. Note that
this effectively undoes commit 5fe65ce7ccbb for machines using dt until
their dtb is updated accordingly. This is critical iff the bootloader
doesn't disable the power down counter and the #WDOG signal actually
does something to the machine.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices/devices-common.h    |  1 +
 arch/arm/mach-imx/devices/platform-imx2-wdt.c | 13 +++---
 drivers/watchdog/imx2_wdt.c                   | 59 +++++++++++++++++++++++----
 3 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 6920e356f4e5..946cca627018 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -92,6 +92,7 @@ struct platform_device *__init imx_add_imx27_coda(
 
 struct imx_imx2_wdt_data {
 	int id;
+	const char *devname;
 	resource_size_t iobase;
 	resource_size_t iosize;
 };
diff --git a/arch/arm/mach-imx/devices/platform-imx2-wdt.c b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
index 8c134c8d7500..d8d3dd58fcfe 100644
--- a/arch/arm/mach-imx/devices/platform-imx2-wdt.c
+++ b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
@@ -11,9 +11,10 @@
 #include "../hardware.h"
 #include "devices-common.h"
 
-#define imx_imx2_wdt_data_entry_single(soc, _id, _hwid, _size)		\
+#define imx_imx2_wdt_data_entry_single(soc, _id, _devname, _hwid, _size)\
 	{								\
 		.id = _id,						\
+		.devname = _devname,					\
 		.iobase = soc ## _WDOG ## _hwid ## _BASE_ADDR,		\
 		.iosize = _size,					\
 	}
@@ -22,22 +23,22 @@
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX21, 0, , SZ_4K);
+	imx_imx2_wdt_data_entry_single(MX21, 0, "imx21-wdt", , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX27, 0, , SZ_4K);
+	imx_imx2_wdt_data_entry_single(MX27, 0, "imx21-wdt", , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 #ifdef CONFIG_SOC_IMX31
 const struct imx_imx2_wdt_data imx31_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX31, 0, , SZ_16K);
+	imx_imx2_wdt_data_entry_single(MX31, 0, "imx21-wdt", , SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
 #ifdef CONFIG_SOC_IMX35
 const struct imx_imx2_wdt_data imx35_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX35, 0, , SZ_16K);
+	imx_imx2_wdt_data_entry_single(MX35, 0, "imx35-wdt", , SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 struct platform_device *__init imx_add_imx2_wdt(
@@ -50,6 +51,6 @@ struct platform_device *__init imx_add_imx2_wdt(
 			.flags = IORESOURCE_MEM,
 		},
 	};
-	return imx_add_platform_device("imx2-wdt", data->id,
+	return imx_add_platform_device(data->devname, data->id,
 			res, ARRAY_SIZE(res), NULL, 0);
 }
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 4874b0f18650..509b2fedb112 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
@@ -63,6 +64,18 @@
 
 #define WDOG_SEC_TO_COUNT(s)	((s * 2 - 1) << 8)
 
+struct imx2_wdt_type {
+	bool has_WMCR;
+};
+
+static const struct imx2_wdt_type imx2_wdt_type_imx21 = {
+	.has_WMCR = false,
+};
+
+static const struct imx2_wdt_type imx2_wdt_type_imx35 = {
+	.has_WMCR = true,
+};
+
 struct imx2_wdt_device {
 	struct clk *clk;
 	struct regmap *regmap;
@@ -248,6 +261,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 	u32 val;
+	const struct imx2_wdt_type *type;
 
 	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
 	if (!wdev)
@@ -309,12 +323,21 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdog->status);
 	}
 
-	/*
-	 * Disable the watchdog power down counter at boot. Otherwise the power
-	 * down counter will pull down the #WDOG interrupt line for one clock
-	 * cycle.
-	 */
-	regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
+	type = of_device_get_match_data(&pdev->dev);
+	if (!type)
+		type = (void *)pdev->id_entry->driver_data;
+
+	if (type) {
+		if (type->has_WMCR)
+			/*
+			 * Disable the watchdog power down counter at boot.
+			 * Otherwise the power down counter will pull down the
+			 * #WDOG interrupt line for one clock cycle.
+			 */
+			regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
+	} else {
+		dev_warn(&pdev->dev, "Cannot determine if WMCR is present\n");
+	}
 
 	ret = watchdog_register_device(wdog);
 	if (ret) {
@@ -411,9 +434,29 @@ static int imx2_wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
 			 imx2_wdt_resume);
 
+static const struct platform_device_id imx2_wdt_devtype[] = {
+	{
+		.name = "imx21-wdt",
+		.driver_data = (kernel_ulong_t) &imx2_wdt_type_imx21,
+	}, {
+		.name = "imx35-wdt",
+		.driver_data = (kernel_ulong_t) &imx2_wdt_type_imx35,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, imx2_wdt_devtype);
+
 static const struct of_device_id imx2_wdt_dt_ids[] = {
-	{ .compatible = "fsl,imx21-wdt", },
-	{ /* sentinel */ }
+	{
+		.compatible = "fsl,imx21-wdt",
+		.data = &imx2_wdt_type_imx21,
+	}, {
+		.compatible = "fsl,imx35-wdt",
+		.data = &imx2_wdt_type_imx35,
+	}, {
+		/* sentinel */
+	}
 };
 MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
 
-- 
2.11.0

