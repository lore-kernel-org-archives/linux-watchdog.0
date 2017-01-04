Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35373 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965870AbdADDZu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 22:25:50 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/4] watchdog: coh901327_wdt: Use dev variable instead of pdev->dev
Date: Tue,  3 Jan 2017 19:25:43 -0800
Message-Id: <1483500343-27113-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use a local dev variable instead of dereferencing pdev->dev several
times in the probe function to make the code easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/coh901327_wdt.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 986222efe174..38dd60f0cfcc 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -251,60 +251,56 @@ static int __exit coh901327_remove(struct platform_device *pdev)
 
 static int __init coh901327_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	u16 val;
 	struct resource *res;
 
-	parent = &pdev->dev;
+	parent = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	virtbase = devm_ioremap_resource(&pdev->dev, res);
+	virtbase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(virtbase))
 		return PTR_ERR(virtbase);
 
-	clk = clk_get(&pdev->dev, NULL);
+	clk = clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-		dev_err(&pdev->dev, "could not get clock\n");
+		dev_err(dev, "could not get clock\n");
 		return ret;
 	}
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "could not prepare and enable clock\n");
+		dev_err(dev, "could not prepare and enable clock\n");
 		goto out_no_clk_enable;
 	}
 
 	val = readw(virtbase + U300_WDOG_SR);
 	switch (val) {
 	case U300_WDOG_SR_STATUS_TIMED_OUT:
-		dev_info(&pdev->dev,
-			"watchdog timed out since last chip reset!\n");
+		dev_info(dev, "watchdog timed out since last chip reset!\n");
 		coh901327_wdt.bootstatus |= WDIOF_CARDRESET;
 		/* Status will be cleared below */
 		break;
 	case U300_WDOG_SR_STATUS_NORMAL:
-		dev_info(&pdev->dev,
-			"in normal status, no timeouts have occurred.\n");
+		dev_info(dev, "in normal status, no timeouts have occurred.\n");
 		break;
 	default:
-		dev_info(&pdev->dev,
-			"contains an illegal status code (%08x)\n", val);
+		dev_info(dev, "contains an illegal status code (%08x)\n", val);
 		break;
 	}
 
 	val = readw(virtbase + U300_WDOG_D2R);
 	switch (val) {
 	case U300_WDOG_D2R_DISABLE_STATUS_DISABLED:
-		dev_info(&pdev->dev, "currently disabled.\n");
+		dev_info(dev, "currently disabled.\n");
 		break;
 	case U300_WDOG_D2R_DISABLE_STATUS_ENABLED:
-		dev_info(&pdev->dev,
-			 "currently enabled! (disabling it now)\n");
+		dev_info(dev, "currently enabled! (disabling it now)\n");
 		coh901327_disable();
 		break;
 	default:
-		dev_err(&pdev->dev,
-			"contains an illegal enable/disable code (%08x)\n",
+		dev_err(dev, "contains an illegal enable/disable code (%08x)\n",
 			val);
 		break;
 	}
@@ -319,16 +315,16 @@ static int __init coh901327_probe(struct platform_device *pdev)
 		goto out_no_irq;
 	}
 
-	ret = watchdog_init_timeout(&coh901327_wdt, margin, &pdev->dev);
+	ret = watchdog_init_timeout(&coh901327_wdt, margin, dev);
 	if (ret < 0)
 		coh901327_wdt.timeout = 60;
 
-	coh901327_wdt.parent = &pdev->dev;
+	coh901327_wdt.parent = dev;
 	ret = watchdog_register_device(&coh901327_wdt);
 	if (ret)
 		goto out_no_wdog;
 
-	dev_info(&pdev->dev, "initialized. timer margin=%d sec\n", margin);
+	dev_info(dev, "initialized. timer margin=%d sec\n", margin);
 	return 0;
 
 out_no_wdog:
-- 
2.7.4

