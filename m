Return-path: <vz@mleia.com>
From: Vladimir Zapolskiy <vz@mleia.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Magnus Lilja <lilja.magnus@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27 and i.MX31 SoCs
Date: Sun, 11 Dec 2016 03:06:48 +0200
Message-Id: <20161211010648.6591-1-vz@mleia.com>
List-ID: <linux-watchdog@vger.kernel.org>

Power down counter enable/disable bit switch is located in WMCR
register, but watchdog controllers found on legacy i.MX21, i.MX27 and
i.MX31 SoCs don't have this register. As a result of writing data to
the non-existing register on driver probe the SoC hangs up, to fix the
problem add more OF compatible strings and on this basis get
information about availability of the WMCR register.

Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from RFC to v1:
* replaced private data struct with a macro as suggested by Guenter,
* updated the comment in the source code to reflect the change,
* rearranged and simplified the logic of detecting WMCR presence,
* pulled the fix out from the series with optional proposed DTS changes.

 drivers/watchdog/imx2_wdt.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 4874b0f..66bd454 100644
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
@@ -57,6 +58,7 @@
 #define IMX2_WDT_WICR_WICT	0xFF		/* -> Interrupt Count Timeout */
 
 #define IMX2_WDT_WMCR		0x08		/* Misc Register */
+#define IMX2_WDT_NO_WMCR	((void *)true)	/* Indicates unavailable WMCR */
 
 #define IMX2_WDT_MAX_TIME	128
 #define IMX2_WDT_DEFAULT_TIME	60		/* in seconds */
@@ -70,6 +72,8 @@ struct imx2_wdt_device {
 	bool ext_reset;
 };
 
+static const struct of_device_id imx2_wdt_dt_ids[];
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
@@ -242,6 +246,7 @@ static const struct regmap_config imx2_wdt_regmap_config = {
 
 static int __init imx2_wdt_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
 	struct imx2_wdt_device *wdev;
 	struct watchdog_device *wdog;
 	struct resource *res;
@@ -310,11 +315,13 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Disable the watchdog power down counter at boot. Otherwise the power
-	 * down counter will pull down the #WDOG interrupt line for one clock
-	 * cycle.
+	 * If watchdog controller has WMCR, disable the watchdog power
+	 * down counter at boot. Otherwise the power down counter will
+	 * pull down the #WDOG interrupt line for one clock cycle.
 	 */
-	regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
+	of_id = of_match_device(imx2_wdt_dt_ids, &pdev->dev);
+	if (of_id && !of_id->data)
+		regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
 
 	ret = watchdog_register_device(wdog);
 	if (ret) {
@@ -412,7 +419,20 @@ static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
 			 imx2_wdt_resume);
 
 static const struct of_device_id imx2_wdt_dt_ids[] = {
-	{ .compatible = "fsl,imx21-wdt", },
+	{ .compatible = "fsl,imx21-wdt", .data = IMX2_WDT_NO_WMCR },
+	{ .compatible = "fsl,imx25-wdt",  },
+	{ .compatible = "fsl,imx27-wdt", .data = IMX2_WDT_NO_WMCR },
+	{ .compatible = "fsl,imx31-wdt", .data = IMX2_WDT_NO_WMCR },
+	{ .compatible = "fsl,imx35-wdt",  },
+	{ .compatible = "fsl,imx50-wdt",  },
+	{ .compatible = "fsl,imx51-wdt",  },
+	{ .compatible = "fsl,imx53-wdt",  },
+	{ .compatible = "fsl,imx6q-wdt",  },
+	{ .compatible = "fsl,imx6sl-wdt", },
+	{ .compatible = "fsl,imx6sx-wdt", },
+	{ .compatible = "fsl,imx6ul-wdt", },
+	{ .compatible = "fsl,imx7d-wdt",  },
+	{ .compatible = "fsl,vf610-wdt",  },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
-- 
2.10.2
