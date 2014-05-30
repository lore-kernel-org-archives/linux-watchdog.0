Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from [207.46.163.140] ([207.46.163.140]:13666 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932378AbaE3Gxn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 May 2014 02:53:43 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] watchdog: imx2_wdt: adds big endianness support.
Date: Fri, 30 May 2014 14:10:17 +0800
Message-ID: <1401430217-29543-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This watchdog driver will be working on IMX2+, Vybrid, LS1, LS2+
platforms, and will be in different endianness mode in those SoCs:

SoCs         CPU endian mode      WDT endian mode
------------------------------------------------
IMX2+            LE                    LE
Vybird           LE                    LE
LS1              LE                    BE
LS2              LE                    LE

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/watchdog/imx2_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 9d4874f..68c3d37 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/timer.h>
@@ -190,10 +191,12 @@ static struct regmap_config imx2_wdt_regmap_config = {
 
 static int __init imx2_wdt_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct imx2_wdt_device *wdev;
 	struct watchdog_device *wdog;
 	struct resource *res;
 	void __iomem *base;
+	bool big_endian;
 	int ret;
 	u32 val;
 
@@ -201,6 +204,10 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	if (!wdev)
 		return -ENOMEM;
 
+	big_endian = of_property_read_bool(np, "big-endian");
+	if (big_endian)
+		imx2_wdt_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
-- 
1.8.4

