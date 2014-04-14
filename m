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
Subject: [RESEND/PATCH v4 1/9] watchdog: orion: Move the register ioremap'ing to its own function
Date: Mon, 14 Apr 2014 10:23:25 -0300
Message-Id: <1397481813-4962-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Follow-up patches will extend the registers ioremap and request
to handle SoC-specific quirks on the RSTOUT register. Therefore,
in order to keep the code readable, this commit introduces a special
function for this.

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 9b3c41d..afa3831 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -313,12 +313,32 @@ static const struct of_device_id orion_wdt_of_match_table[] = {
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
@@ -336,19 +356,9 @@ static int orion_wdt_probe(struct platform_device *pdev)
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
1.9.1
