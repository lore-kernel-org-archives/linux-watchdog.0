Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:52450 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753205Ab2CGK3Q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:16 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 06/15] watchdog/mpcore_wdt: do request_irq before registering misc device
Date: Wed, 7 Mar 2012 15:57:47 +0530
Message-ID: <a3f18ec8fa44163c7b0ba886f9e99583e17ece37.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Ideally, device/driver must be completely ready while we register it with any
framework. This includes allocating resources, registering irqs, etc. Currently
for mpcore_wdt irq is requested after it is registered as a misc device.

So, this patch moves request_irq before registration of misc device.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 1e9c3d3..db379f7 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -340,6 +340,13 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	ret = request_irq(wdt->irq, mpcore_wdt_fire, 0, "mpcore_wdt", wdt);
+	if (ret) {
+		dev_printk(KERN_ERR, wdt->dev,
+			"cannot register IRQ%d for watchdog\n", wdt->irq);
+		goto err_irq;
+	}
+
 	mpcore_wdt_miscdev.parent = &pdev->dev;
 	ret = misc_register(&mpcore_wdt_miscdev);
 	if (ret) {
@@ -349,22 +356,15 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		goto err_misc;
 	}
 
-	ret = request_irq(wdt->irq, mpcore_wdt_fire, 0, "mpcore_wdt", wdt);
-	if (ret) {
-		dev_printk(KERN_ERR, wdt->dev,
-			"cannot register IRQ%d for watchdog\n", wdt->irq);
-		goto err_irq;
-	}
-
 	mpcore_wdt_stop(wdt);
 	platform_set_drvdata(pdev, wdt);
 	mpcore_wdt_pdev = pdev;
 
 	return 0;
 
-err_irq:
-	misc_deregister(&mpcore_wdt_miscdev);
 err_misc:
+	free_irq(wdt->irq, wdt);
+err_irq:
 	iounmap(wdt->base);
 err_free:
 	kfree(wdt);
-- 
1.7.8.110.g4cb5d

