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
Subject: [PATCH v4 1/9] watchdog: orion: Move the register ioremap'ing to its own function
Date: Sat, 15 Mar 2014 15:17:56 -0300
Message-Id: <1394907484-26002-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Follow-up patches will extend the registers ioremap and request
to handle SoC-specific quirks on the RSTOUT register. Therefore,
in order to keep the code readable, this commit introduces a special
function for this.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 6f9b4c6..b7d57bb 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -314,12 +314,32 @@ static const struct of_device_id orion_wdt_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
 
+static int orion_wdt_get_regs(struct platform_device *pdev,
+			      struct orion_watchdog *dev)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+	dev->reg = devm_ioremap(&pdev->dev, res->start,
+				resource_size(res));
+	if (!dev->reg)
+		return -ENOMEM;
+
+	dev->rstout = orion_wdt_ioremap_rstout(pdev, res->start &
+						     INTERNAL_REGS_MASK);
+	if (!dev->rstout)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct orion_watchdog *dev;
 	const struct of_device_id *match;
 	unsigned int wdt_max_duration;	/* (seconds) */
-	struct resource *res;
 	int ret, irq;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct orion_watchdog),
@@ -337,19 +357,9 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	dev->wdt.min_timeout = 1;
 	dev->data = match->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	dev->reg = devm_ioremap(&pdev->dev, res->start,
-			       resource_size(res));
-	if (!dev->reg)
-		return -ENOMEM;
-
-	dev->rstout = orion_wdt_ioremap_rstout(pdev, res->start &
-						     INTERNAL_REGS_MASK);
-	if (!dev->rstout)
-		return -ENODEV;
+	ret = orion_wdt_get_regs(pdev, dev);
+	if (ret)
+		return ret;
 
 	ret = dev->data->clock_init(pdev, dev);
 	if (ret) {
-- 
1.9.0
