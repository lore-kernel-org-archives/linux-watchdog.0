Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:40644 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751711Ab2CGK3l (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:41 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
Date: Wed, 7 Mar 2012 15:57:55 +0530
Message-ID: <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds in clk framework support for wdt driver. If clk_get fails for
some platform, then we continue without clk_* API's.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   71 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index ebd964a..9747193 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -17,6 +17,7 @@
  *
  * (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  */
+#include <linux/clk.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -39,6 +40,7 @@ struct mpcore_wdt {
 	unsigned long	boot_status;
 	struct device	*dev;
 	void __iomem	*base;
+	struct clk	*clk;
 	int		irq;
 	unsigned int	perturb;
 	char		expect_close;
@@ -147,6 +149,7 @@ static int mpcore_wdt_set_heartbeat(int t)
 static int mpcore_wdt_open(struct inode *inode, struct file *file)
 {
 	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_pdev);
+	int ret;
 
 	if (test_and_set_bit(0, &wdt->timer_alive))
 		return -EBUSY;
@@ -156,10 +159,22 @@ static int mpcore_wdt_open(struct inode *inode, struct file *file)
 
 	file->private_data = wdt;
 
+	if (wdt->clk) {
+		ret = clk_enable(wdt->clk);
+		if (ret) {
+			dev_err(wdt->dev, "clock enable fail");
+			goto err;
+		}
+	}
+
 	/* Activate timer */
 	mpcore_wdt_start(wdt);
 
 	return nonseekable_open(inode, file);
+
+err:
+	clear_bit(0, &wdt->timer_alive);
+	return ret;
 }
 
 static int mpcore_wdt_release(struct inode *inode, struct file *file)
@@ -169,9 +184,12 @@ static int mpcore_wdt_release(struct inode *inode, struct file *file)
 	/*
 	 * Shut off the timer. Lock it in if it's a module and we set nowayout
 	 */
-	if (wdt->expect_close == 42)
+	if (wdt->expect_close == 42) {
 		mpcore_wdt_stop(wdt);
-	else {
+
+		if (wdt->clk)
+			clk_disable(wdt->clk);
+	} else {
 		dev_printk(KERN_CRIT, wdt->dev,
 				"unexpected close, not stopping watchdog!\n");
 		mpcore_wdt_keepalive(wdt);
@@ -350,6 +368,28 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
+	wdt->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(wdt->clk)) {
+		dev_warn(&pdev->dev, "Clock not found\n");
+		wdt->clk = NULL;
+	}
+
+	if (wdt->clk) {
+		ret = clk_enable(wdt->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Clock enable failed\n");
+			goto err_put_clk;
+		}
+	}
+
+	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
+			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
+
+	mpcore_wdt_stop(wdt);
+
+	if (wdt->clk)
+		clk_disable(wdt->clk);
+
 	/*
 	 * Check that the margin value is within it's range;
 	 * if not reset to the default
@@ -368,25 +408,32 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		dev_printk(KERN_ERR, wdt->dev,
 			"cannot register miscdev on minor=%d (err=%d)\n",
 							WATCHDOG_MINOR, ret);
-		return ret;
+		goto err_put_clk;
 	}
 
-	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
-			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
-
-	mpcore_wdt_stop(wdt);
 	platform_set_drvdata(pdev, wdt);
 	mpcore_wdt_pdev = pdev;
 
 	return 0;
+
+err_put_clk:
+	if (wdt->clk)
+		clk_put(wdt->clk);
+
+	return ret;
 }
 
 static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
 {
+	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
+
 	platform_set_drvdata(pdev, NULL);
 
 	misc_deregister(&mpcore_wdt_miscdev);
 
+	if (wdt->clk)
+		clk_put(wdt->clk);
+
 	mpcore_wdt_pdev = NULL;
 
 	return 0;
@@ -399,6 +446,9 @@ static int mpcore_wdt_suspend(struct device *dev)
 
 	if (test_bit(0, &wdt->timer_alive))
 		mpcore_wdt_stop(wdt);		/* Turn the WDT off */
+
+	if (wdt->clk)
+		clk_disable(wdt->clk);
 	return 0;
 }
 
@@ -407,8 +457,13 @@ static int mpcore_wdt_resume(struct device *dev)
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	/* re-activate timer */
-	if (test_bit(0, &wdt->timer_alive))
+	if (test_bit(0, &wdt->timer_alive)) {
+		if (wdt->clk)
+			clk_enable(wdt->clk);
+
 		mpcore_wdt_start(wdt);
+	}
+
 	return 0;
 }
 #endif
-- 
1.7.8.110.g4cb5d

