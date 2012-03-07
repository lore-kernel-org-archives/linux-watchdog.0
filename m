Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:45616 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459Ab2CGK3V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:21 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 07/15] watchdog/mpcore_wdt: Use devm routines
Date: Wed, 7 Mar 2012 15:57:48 +0530
Message-ID: <8d5d4f4d36452bdf1005700c4376798e25f59adf.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

mpcore_wdt driver currently uses normal kzalloc, request_irq, ioremap, etc
routines. This patch replaces these routines with devm_kzalloc and
devm_request_mem_region etc, so that we don't need to handle freeing of
resources for error cases and module removal routine.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   50 ++++++++++++----------------------------
 1 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index db379f7..209c81d 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -317,34 +317,28 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		goto err_out;
-	}
+	if (!res)
+		return -ENODEV;
 
-	wdt = kzalloc(sizeof(struct mpcore_wdt), GFP_KERNEL);
-	if (!wdt) {
-		ret = -ENOMEM;
-		goto err_out;
-	}
+	wdt = devm_kzalloc(&pdev->dev, sizeof(struct mpcore_wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
 
 	wdt->dev = &pdev->dev;
 	wdt->irq = platform_get_irq(pdev, 0);
-	if (wdt->irq < 0) {
-		ret = -ENXIO;
-		goto err_free;
-	}
-	wdt->base = ioremap(res->start, resource_size(res));
-	if (!wdt->base) {
-		ret = -ENOMEM;
-		goto err_free;
-	}
+	if (wdt->irq < 0)
+		return -ENXIO;
 
-	ret = request_irq(wdt->irq, mpcore_wdt_fire, 0, "mpcore_wdt", wdt);
+	wdt->base = devm_ioremap(wdt->dev, res->start, resource_size(res));
+	if (!wdt->base)
+		return -ENOMEM;
+
+	ret = devm_request_irq(wdt->dev, wdt->irq, mpcore_wdt_fire, 0,
+			"mpcore_wdt", wdt);
 	if (ret) {
 		dev_printk(KERN_ERR, wdt->dev,
 			"cannot register IRQ%d for watchdog\n", wdt->irq);
-		goto err_irq;
+		return ret;
 	}
 
 	mpcore_wdt_miscdev.parent = &pdev->dev;
@@ -353,7 +347,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		dev_printk(KERN_ERR, wdt->dev,
 			"cannot register miscdev on minor=%d (err=%d)\n",
 							WATCHDOG_MINOR, ret);
-		goto err_misc;
+		return ret;
 	}
 
 	mpcore_wdt_stop(wdt);
@@ -361,30 +355,16 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 	mpcore_wdt_pdev = pdev;
 
 	return 0;
-
-err_misc:
-	free_irq(wdt->irq, wdt);
-err_irq:
-	iounmap(wdt->base);
-err_free:
-	kfree(wdt);
-err_out:
-	return ret;
 }
 
 static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
-
 	platform_set_drvdata(pdev, NULL);
 
 	misc_deregister(&mpcore_wdt_miscdev);
 
 	mpcore_wdt_pdev = NULL;
 
-	free_irq(wdt->irq, wdt);
-	iounmap(wdt->base);
-	kfree(wdt);
 	return 0;
 }
 
-- 
1.7.8.110.g4cb5d

