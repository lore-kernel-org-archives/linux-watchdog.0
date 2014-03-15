Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v4 2/9] watchdog: orion: Introduce a SoC-specific RSTOUT mapping
Date: Sat, 15 Mar 2014 15:17:57 -0300
Message-Id: <1394907484-26002-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Separate the RSTOUT register mapping for the different compatible strings
supported by the driver. This allows to use devm_ioremap on SoC variants that
share the RSTOUT register, and devm_ioremap_resource (which requests the MMIO
region) on SoCs that have a dedicated RSTOUT register.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index b7d57bb..9b513e8 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -263,10 +263,6 @@ static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
 		return devm_ioremap(&pdev->dev, res->start,
 				    resource_size(res));
 
-	/* This workaround works only for "orion-wdt", DT-enabled */
-	if (!of_device_is_compatible(pdev->dev.of_node, "marvell,orion-wdt"))
-		return NULL;
-
 	rstout = internal_regs + ORION_RSTOUT_MASK_OFFSET;
 
 	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rstout);
@@ -317,6 +313,7 @@ MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
 static int orion_wdt_get_regs(struct platform_device *pdev,
 			      struct orion_watchdog *dev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -327,10 +324,26 @@ static int orion_wdt_get_regs(struct platform_device *pdev,
 	if (!dev->reg)
 		return -ENOMEM;
 
-	dev->rstout = orion_wdt_ioremap_rstout(pdev, res->start &
-						     INTERNAL_REGS_MASK);
-	if (!dev->rstout)
+	/* Each supported compatible has some RSTOUT register quirk */
+	if (of_device_is_compatible(node, "marvell,orion-wdt")) {
+
+		dev->rstout = orion_wdt_ioremap_rstout(pdev, res->start &
+						       INTERNAL_REGS_MASK);
+		if (!dev->rstout)
+			return -ENODEV;
+
+	} else if (of_device_is_compatible(node, "marvell,armada-370-wdt") ||
+		   of_device_is_compatible(node, "marvell,armada-xp-wdt")) {
+
+		/* Dedicated RSTOUT register, can be requested. */
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		dev->rstout = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(dev->rstout))
+			return PTR_ERR(dev->rstout);
+
+	} else {
 		return -ENODEV;
+	}
 
 	return 0;
 }
-- 
1.9.0
