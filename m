Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v4 2/9] watchdog: orion: Introduce a SoC-specific RSTOUT mapping
Date: Mon, 14 Apr 2014 10:23:26 -0300
Message-Id: <1397481813-4962-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Separate the RSTOUT register mapping for the different compatible strings
supported by the driver. This allows to use devm_ioremap on SoC variants that
share the RSTOUT register, and devm_ioremap_resource (which requests the MMIO
region) on SoCs that have a dedicated RSTOUT register.

Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index afa3831..75f623f 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -262,10 +262,6 @@ static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
 		return devm_ioremap(&pdev->dev, res->start,
 				    resource_size(res));
 
-	/* This workaround works only for "orion-wdt", DT-enabled */
-	if (!of_device_is_compatible(pdev->dev.of_node, "marvell,orion-wdt"))
-		return NULL;
-
 	rstout = internal_regs + ORION_RSTOUT_MASK_OFFSET;
 
 	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rstout);
@@ -316,6 +312,7 @@ MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
 static int orion_wdt_get_regs(struct platform_device *pdev,
 			      struct orion_watchdog *dev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -326,10 +323,26 @@ static int orion_wdt_get_regs(struct platform_device *pdev,
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
1.9.1
