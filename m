Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:26584 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753489Ab2A3TBJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Jan 2012 14:01:09 -0500
Date: Mon, 30 Jan 2012 20:01:07 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: myungjoo.ham@gmail.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
	kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: fix error in probe() of s3c2410_wdt (reset
	at booting)
Message-ID: <20120130190106.GA29850@infomag.iguana.be>
References: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com> <20120113111117.GT1068@n2100.arm.linux.org.uk> <20120113214555.GA19495@infomag.iguana.be> <CAJ0PZbSpL0-LNHfU7TTM06tPi1B4VgCp=oyPA06qAjp8PoPT2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ0PZbSpL0-LNHfU7TTM06tPi1B4VgCp=oyPA06qAjp8PoPT2w@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

> Yes, if we set wdt_count value properly before request_irq, it's fine.
> 
> Anyway, as registering the device (watchdog_register_device()) may be
> done after request_irq without any problem, moving request_irq right
> before it, not after it should be fine.

So what that be attached patch then? Could you also test this patch?

Kind regards,
Wim.
---
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 4bc3744..404172f 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -312,18 +312,26 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 	dev = &pdev->dev;
 	wdt_dev = &pdev->dev;
 
-	/* get the memory region for the watchdog timer */
-
 	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (wdt_mem == NULL) {
 		dev_err(dev, "no memory resource specified\n");
 		return -ENOENT;
 	}
 
+	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (wdt_irq == NULL) {
+		dev_err(dev, "no irq resource specified\n");
+		ret = -ENOENT;
+		goto err;
+	}
+
+	/* get the memory region for the watchdog timer */
+
 	size = resource_size(wdt_mem);
 	if (!request_mem_region(wdt_mem->start, size, pdev->name)) {
 		dev_err(dev, "failed to get memory region\n");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	wdt_base = ioremap(wdt_mem->start, size);
@@ -335,29 +343,17 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 
 	DBG("probe: mapped wdt_base=%p\n", wdt_base);
 
-	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (wdt_irq == NULL) {
-		dev_err(dev, "no irq resource specified\n");
-		ret = -ENOENT;
-		goto err_map;
-	}
-
-	ret = request_irq(wdt_irq->start, s3c2410wdt_irq, 0, pdev->name, pdev);
-	if (ret != 0) {
-		dev_err(dev, "failed to install irq (%d)\n", ret);
-		goto err_map;
-	}
-
 	wdt_clock = clk_get(&pdev->dev, "watchdog");
 	if (IS_ERR(wdt_clock)) {
 		dev_err(dev, "failed to find watchdog clock source\n");
 		ret = PTR_ERR(wdt_clock);
-		goto err_irq;
+		goto err_map;
 	}
 
 	clk_enable(wdt_clock);
 
-	if (s3c2410wdt_cpufreq_register() < 0) {
+	ret = s3c2410wdt_cpufreq_register();
+	if (ret < 0) {
 		printk(KERN_ERR PFX "failed to register cpufreq\n");
 		goto err_clk;
 	}
@@ -378,12 +374,18 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 							"cannot start\n");
 	}
 
+	ret = request_irq(wdt_irq->start, s3c2410wdt_irq, 0, pdev->name, pdev);
+	if (ret != 0) {
+		dev_err(dev, "failed to install irq (%d)\n", ret);
+		goto err_cpufreq;
+	}
+
 	watchdog_set_nowayout(&s3c2410_wdd, nowayout);
 
 	ret = watchdog_register_device(&s3c2410_wdd);
 	if (ret) {
 		dev_err(dev, "cannot register watchdog (%d)\n", ret);
-		goto err_cpufreq;
+		goto err_irq;
 	}
 
 	if (tmr_atboot && started == 0) {
@@ -408,23 +410,26 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 
 	return 0;
 
+ err_irq:
+	free_irq(wdt_irq->start, pdev);
+
  err_cpufreq:
 	s3c2410wdt_cpufreq_deregister();
 
  err_clk:
 	clk_disable(wdt_clock);
 	clk_put(wdt_clock);
-
- err_irq:
-	free_irq(wdt_irq->start, pdev);
+	wdt_clock = NULL;
 
  err_map:
 	iounmap(wdt_base);
 
  err_req:
 	release_mem_region(wdt_mem->start, size);
-	wdt_mem = NULL;
 
+ err:
+	wdt_irq = NULL;
+	wdt_mem = NULL;
 	return ret;
 }
 
@@ -432,18 +437,18 @@ static int __devexit s3c2410wdt_remove(struct platform_device *dev)
 {
 	watchdog_unregister_device(&s3c2410_wdd);
 
+	free_irq(wdt_irq->start, dev);
+
 	s3c2410wdt_cpufreq_deregister();
 
 	clk_disable(wdt_clock);
 	clk_put(wdt_clock);
 	wdt_clock = NULL;
 
-	free_irq(wdt_irq->start, dev);
-	wdt_irq = NULL;
-
 	iounmap(wdt_base);
 
 	release_mem_region(wdt_mem->start, resource_size(wdt_mem));
+	wdt_irq = NULL;
 	wdt_mem = NULL;
 	return 0;
 }
