Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:35776 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753205Ab2CGK3N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:13 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 05/15] watchdog/mpcore_wdt: Rename dev to pdev for pointing to struct platform_device
Date: Wed, 7 Mar 2012 15:57:46 +0530
Message-ID: <fc64d42a383dc95cca64bddbac87c6e1fc578960.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Pointer to struct platform_device is named as dev, which makes it confusing when
we write statements like dev->dev to access struct device within it.

This patch renames such names to pdev.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 89e8fae..1e9c3d3 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -42,7 +42,7 @@ struct mpcore_wdt {
 	char		expect_close;
 };
 
-static struct platform_device *mpcore_wdt_dev;
+static struct platform_device *mpcore_wdt_pdev;
 static DEFINE_SPINLOCK(wdt_lock);
 
 #define TIMER_MARGIN	60
@@ -144,7 +144,7 @@ static int mpcore_wdt_set_heartbeat(int t)
 /* /dev/watchdog handling */
 static int mpcore_wdt_open(struct inode *inode, struct file *file)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_pdev);
 
 	if (test_and_set_bit(0, &wdt->timer_alive))
 		return -EBUSY;
@@ -282,9 +282,9 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
  * System shutdown handler.  Turn off the watchdog if we're restarting or
  * halting the system.
  */
-static void mpcore_wdt_shutdown(struct platform_device *dev)
+static void mpcore_wdt_shutdown(struct platform_device *pdev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
 	if (system_state == SYSTEM_RESTART || system_state == SYSTEM_HALT)
 		mpcore_wdt_stop(wdt);
@@ -306,17 +306,17 @@ static struct miscdevice mpcore_wdt_miscdev = {
 	.fops		= &mpcore_wdt_fops,
 };
 
-static int __devinit mpcore_wdt_probe(struct platform_device *dev)
+static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 {
 	struct mpcore_wdt *wdt;
 	struct resource *res;
 	int ret;
 
 	/* We only accept one device, and it must have an id of -1 */
-	if (dev->id != -1)
+	if (pdev->id != -1)
 		return -ENODEV;
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
 		goto err_out;
@@ -328,8 +328,8 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 		goto err_out;
 	}
 
-	wdt->dev = &dev->dev;
-	wdt->irq = platform_get_irq(dev, 0);
+	wdt->dev = &pdev->dev;
+	wdt->irq = platform_get_irq(pdev, 0);
 	if (wdt->irq < 0) {
 		ret = -ENXIO;
 		goto err_free;
@@ -340,7 +340,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 		goto err_free;
 	}
 
-	mpcore_wdt_miscdev.parent = &dev->dev;
+	mpcore_wdt_miscdev.parent = &pdev->dev;
 	ret = misc_register(&mpcore_wdt_miscdev);
 	if (ret) {
 		dev_printk(KERN_ERR, wdt->dev,
@@ -357,8 +357,8 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 	}
 
 	mpcore_wdt_stop(wdt);
-	platform_set_drvdata(dev, wdt);
-	mpcore_wdt_dev = dev;
+	platform_set_drvdata(pdev, wdt);
+	mpcore_wdt_pdev = pdev;
 
 	return 0;
 
@@ -372,15 +372,15 @@ err_out:
 	return ret;
 }
 
-static int __devexit mpcore_wdt_remove(struct platform_device *dev)
+static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	misc_deregister(&mpcore_wdt_miscdev);
 
-	mpcore_wdt_dev = NULL;
+	mpcore_wdt_pdev = NULL;
 
 	free_irq(wdt->irq, wdt);
 	iounmap(wdt->base);
@@ -389,17 +389,17 @@ static int __devexit mpcore_wdt_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM
-static int mpcore_wdt_suspend(struct platform_device *dev, pm_message_t msg)
+static int mpcore_wdt_suspend(struct platform_device *pdev, pm_message_t msg)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
 	mpcore_wdt_stop(wdt);		/* Turn the WDT off */
 	return 0;
 }
 
-static int mpcore_wdt_resume(struct platform_device *dev)
+static int mpcore_wdt_resume(struct platform_device *pdev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
 	/* re-activate timer */
 	if (test_bit(0, &wdt->timer_alive))
-- 
1.7.8.110.g4cb5d

