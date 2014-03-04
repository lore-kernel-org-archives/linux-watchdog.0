Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41796 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751464AbaCDQHa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Mar 2014 11:07:30 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 1/7] watchdog: orion: Introduce a SoC-specific RSTOUT mapping
Date: Tue,  4 Mar 2014 13:07:18 -0300
Message-Id: <1393949244-5011-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit separates the RSTOUT register mapping for the different
compatible strings supported by the driver. This is needed as
preparation work to support other SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 6f9b4c6..383da34 100644
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
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct orion_watchdog *dev;
+	struct device_node *node = pdev->dev.of_node;
 	const struct of_device_id *match;
 	unsigned int wdt_max_duration;	/* (seconds) */
 	struct resource *res;
@@ -346,10 +343,27 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!dev->reg)
 		return -ENOMEM;
 
-	dev->rstout = orion_wdt_ioremap_rstout(pdev, res->start &
-						     INTERNAL_REGS_MASK);
-	if (!dev->rstout)
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
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res)
+			return -ENODEV;
+		dev->rstout = devm_ioremap(&pdev->dev, res->start,
+					   resource_size(res));
+		if (!dev->rstout)
+			return -ENOMEM;
+
+	} else {
 		return -ENODEV;
+	}
 
 	ret = dev->data->clock_init(pdev, dev);
 	if (ret) {
-- 
1.8.1.5

