Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:22434
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751878AbaHRIRI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Aug 2014 04:17:08 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] watchdog: imx2_wdt: Convert to use regmap framework's endianness method.
Date: Mon, 18 Aug 2014 16:12:50 +0800
Message-ID: <1408349570-13979-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

This is depended on the following regmap framework patches, which have
just been merged into linux-next tree:

https://lkml.org/lkml/2014/7/15/6
https://lkml.org/lkml/2014/7/15/5
https://lkml.org/lkml/2014/7/15/7






 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 3 ++-
 drivers/watchdog/imx2_wdt.c                                | 6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
index e52ba2d..8dab6fd 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -7,7 +7,8 @@ Required properties:
 
 Optional property:
 - big-endian: If present the watchdog device's registers are implemented
-  in big endian mode, otherwise in little mode.
+  in big endian mode, otherwise in native mode(same with CPU), for more
+  detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
 
 Examples:
 
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 68c3d37..f37bb05 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -191,12 +191,10 @@ static struct regmap_config imx2_wdt_regmap_config = {
 
 static int __init imx2_wdt_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct imx2_wdt_device *wdev;
 	struct watchdog_device *wdog;
 	struct resource *res;
 	void __iomem *base;
-	bool big_endian;
 	int ret;
 	u32 val;
 
@@ -204,10 +202,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	if (!wdev)
 		return -ENOMEM;
 
-	big_endian = of_property_read_bool(np, "big-endian");
-	if (big_endian)
-		imx2_wdt_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
-- 
1.8.5

