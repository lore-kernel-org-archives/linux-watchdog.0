Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:47435 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751346Ab2CLEXR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:17 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 03/22] watchdog/mpcore_wdt: Rename dev to pdev for pointing to struct platform_device
Date: Mon, 12 Mar 2012 09:51:58 +0530
Message-ID: <d9bc91707225b317a0700b50e70227aae91e9d78.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
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
index 82ccd36..fd9f91b 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -44,7 +44,7 @@ struct mpcore_wdt {
 	char		expect_close;
 };
 
-static struct platform_device *mpcore_wdt_dev;
+static struct platform_device *mpcore_wdt_pdev;
 static DEFINE_SPINLOCK(wdt_lock);
 
 #define TIMER_MARGIN	60
@@ -148,7 +148,7 @@ static int mpcore_wdt_set_heartbeat(int t)
  */
 static int mpcore_wdt_open(struct inode *inode, struct file *file)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_pdev);
 
 	if (test_and_set_bit(0, &wdt->timer_alive))
 		return -EBUSY;
@@ -298,9 +298,9 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
  *	System shutdown handler.  Turn off the watchdog if we're
  *	restarting or halting the system.
  */
-static void mpcore_wdt_shutdown(struct platform_device *dev)
+static void mpcore_wdt_shutdown(struct platform_device *pdev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
 	if (system_state == SYSTEM_RESTART || system_state == SYSTEM_HALT)
 		mpcore_wdt_stop(wdt);
@@ -324,17 +324,17 @@ static struct miscdevice mpcore_wdt_miscdev = {
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
@@ -346,8 +346,8 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 		goto err_out;
 	}
 
-	wdt->dev = &dev->dev;
-	wdt->irq = platform_get_irq(dev, 0);
+	wdt->dev = &pdev->dev;
+	wdt->irq = platform_get_irq(pdev, 0);
 	if (wdt->irq < 0) {
 		ret = -ENXIO;
 		goto err_free;
@@ -358,7 +358,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 		goto err_free;
 	}
 
-	mpcore_wdt_miscdev.parent = &dev->dev;
+	mpcore_wdt_miscdev.parent = &pdev->dev;
 	ret = misc_register(&mpcore_wdt_miscdev);
 	if (ret) {
 		dev_printk(KERN_ERR, wdt->dev,
@@ -375,8 +375,8 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 	}
 
 	mpcore_wdt_stop(wdt);
-	platform_set_drvdata(dev, wdt);
-	mpcore_wdt_dev = dev;
+	platform_set_drvdata(pdev, wdt);
+	mpcore_wdt_pdev = pdev;
 
 	return 0;
 
@@ -390,15 +390,15 @@ err_out:
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
@@ -407,16 +407,16 @@ static int __devexit mpcore_wdt_remove(struct platform_device *dev)
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
 		mpcore_wdt_start(wdt);
-- 
1.7.8.110.g4cb5d

