Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:16350
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752013AbaFCD2j (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Jun 2014 23:28:39 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2] watchdog: imx2_wdt: adds big endianness support.
Date: Tue, 3 Jun 2014 10:45:14 +0800
Message-ID: <1401763514-32589-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This watchdog driver will be working on IMX2+, Vybrid, LS1, LS2+
platforms, and will be in different endianness mode in those SoCs:

    SoCs       WDT endian mode
------------------------------------
    IMX2+           LE
    Vybird          LE
    LS1             BE
    LS2             LE

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---


Changes in V2:
- Document the use of the 'big-endian' property.




 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 5 +++++
 drivers/watchdog/imx2_wdt.c                                | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
index 2144af1..e52ba2d 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -5,10 +5,15 @@ Required properties:
 - reg : Should contain WDT registers location and length
 - interrupts : Should contain WDT interrupt
 
+Optional property:
+- big-endian: If present the watchdog device's registers are implemented
+  in big endian mode, otherwise in little mode.
+
 Examples:
 
 wdt@73f98000 {
 	compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
 	reg = <0x73f98000 0x4000>;
 	interrupts = <58>;
+	big-endian;
 };
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

