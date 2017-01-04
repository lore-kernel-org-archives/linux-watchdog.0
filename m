Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/4] watchdog: coh901327_wdt: Use devm_ioremap_resource to map resources
Date: Tue,  3 Jan 2017 19:25:42 -0800
Message-Id: <1483500343-27113-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Map resources using devm_ioremap_resource() to simplify error handling.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/coh901327_wdt.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 1385a920df4f..986222efe174 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -68,8 +68,6 @@
 
 /* Default timeout in seconds = 1 minute */
 static unsigned int margin = 60;
-static resource_size_t phybase;
-static resource_size_t physize;
 static int irq;
 static void __iomem *virtbase;
 static struct device *parent;
@@ -248,8 +246,6 @@ static int __exit coh901327_remove(struct platform_device *pdev)
 	free_irq(irq, pdev);
 	clk_disable_unprepare(clk);
 	clk_put(clk);
-	iounmap(virtbase);
-	release_mem_region(phybase, physize);
 	return 0;
 }
 
@@ -259,30 +255,18 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	u16 val;
 	struct resource *res;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
-
 	parent = &pdev->dev;
-	physize = resource_size(res);
-	phybase = res->start;
-
-	if (request_mem_region(phybase, physize, DRV_NAME) == NULL) {
-		ret = -EBUSY;
-		goto out;
-	}
 
-	virtbase = ioremap(phybase, physize);
-	if (!virtbase) {
-		ret = -ENOMEM;
-		goto out_no_remap;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	virtbase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(virtbase))
+		return PTR_ERR(virtbase);
 
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		dev_err(&pdev->dev, "could not get clock\n");
-		goto out_no_clk;
+		return ret;
 	}
 	ret = clk_prepare_enable(clk);
 	if (ret) {
@@ -353,11 +337,6 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	clk_disable_unprepare(clk);
 out_no_clk_enable:
 	clk_put(clk);
-out_no_clk:
-	iounmap(virtbase);
-out_no_remap:
-	release_mem_region(phybase, SZ_4K);
-out:
 	return ret;
 }
 
-- 
2.7.4
