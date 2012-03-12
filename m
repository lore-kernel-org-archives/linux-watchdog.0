Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:52644 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785Ab2CLEX1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:27 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 06/22] watchdog/mpcore_wdt: convert to watchdog core
Date: Mon, 12 Mar 2012 09:52:01 +0530
Message-ID: <45602d964bcc47908f5c02cf09511847a4663e12.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch converts existing mpcore watchdog driver to use already in place
common infrastructure present in watchdog core. With this lot of code goes away.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/Kconfig      |    1 +
 drivers/watchdog/mpcore_wdt.c |  281 ++++++++++-------------------------------
 2 files changed, 71 insertions(+), 211 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ee27f57..f66617a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -208,6 +208,7 @@ config DW_WATCHDOG
 config MPCORE_WATCHDOG
 	tristate "MPcore watchdog"
 	depends on HAVE_ARM_TWD
+	select WATCHDOG_CORE
 	help
 	  Watchdog timer embedded into the MPcore system.
 
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 1d2f1a1..953044a 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -22,31 +22,27 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
-#include <linux/fs.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 
 #include <asm/smp_twd.h>
 
 struct mpcore_wdt {
-	unsigned long	timer_alive;
+	struct watchdog_device wdd;
 	struct device	*dev;
 	void __iomem	*base;
+	spinlock_t	lock;
 	int		irq;
 	unsigned int	perturb;
-	char		expect_close;
 };
 
-static struct platform_device *mpcore_wdt_pdev;
-static DEFINE_SPINLOCK(wdt_lock);
-
+#define MIN_TIME	0x0001
+#define MAX_TIME	0xFFFF
 #define TIMER_MARGIN	60
 static int mpcore_margin = TIMER_MARGIN;
 module_param(mpcore_margin, int, 0);
@@ -87,17 +83,18 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 }
 
 /*
- *	mpcore_wdt_keepalive - reload the timer
+ *	mpcore_wdt_ping - reload the timer
  *
  *	Note that the spec says a DIFFERENT value must be written to the reload
  *	register each time.  The "perturb" variable deals with this by adding 1
  *	to the count every other time the function is called.
  */
-static void mpcore_wdt_keepalive(struct mpcore_wdt *wdt)
+static int mpcore_wdt_ping(struct watchdog_device *wdd)
 {
+	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
 	unsigned long count;
 
-	spin_lock(&wdt_lock);
+	spin_lock(&wdt->lock);
 	/* Assume prescale is set to 256 */
 	count =  __raw_readl(wdt->base + TWD_WDOG_COUNTER);
 	count = (0xFFFFFFFFU - count) * (HZ / 5);
@@ -106,24 +103,32 @@ static void mpcore_wdt_keepalive(struct mpcore_wdt *wdt)
 	/* Reload the counter */
 	writel(count + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
 	wdt->perturb = wdt->perturb ? 0 : 1;
-	spin_unlock(&wdt_lock);
+	spin_unlock(&wdt->lock);
+
+	return 0;
 }
 
-static void mpcore_wdt_stop(struct mpcore_wdt *wdt)
+static int mpcore_wdt_stop(struct watchdog_device *wdd)
 {
-	spin_lock(&wdt_lock);
+	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	spin_lock(&wdt->lock);
 	writel(0x12345678, wdt->base + TWD_WDOG_DISABLE);
 	writel(0x87654321, wdt->base + TWD_WDOG_DISABLE);
 	writel(0x0, wdt->base + TWD_WDOG_CONTROL);
-	spin_unlock(&wdt_lock);
+	spin_unlock(&wdt->lock);
+
+	return 0;
 }
 
-static void mpcore_wdt_start(struct mpcore_wdt *wdt)
+static int mpcore_wdt_start(struct watchdog_device *wdd)
 {
+	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
+
 	dev_printk(KERN_INFO, wdt->dev, "enabling watchdog.\n");
 
 	/* This loads the count register but does NOT start the count yet */
-	mpcore_wdt_keepalive(wdt);
+	mpcore_wdt_ping(wdd);
 
 	if (mpcore_noboot) {
 		/* Enable watchdog - prescale=256, watchdog mode=0, enable=1 */
@@ -132,167 +137,30 @@ static void mpcore_wdt_start(struct mpcore_wdt *wdt)
 		/* Enable watchdog - prescale=256, watchdog mode=1, enable=1 */
 		writel(0x0000FF09, wdt->base + TWD_WDOG_CONTROL);
 	}
-}
-
-static int mpcore_wdt_set_heartbeat(int t)
-{
-	if (t < 0x0001 || t > 0xFFFF)
-		return -EINVAL;
 
-	mpcore_margin = t;
 	return 0;
 }
 
-/*
- *	/dev/watchdog handling
- */
-static int mpcore_wdt_open(struct inode *inode, struct file *file)
-{
-	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_pdev);
-
-	if (test_and_set_bit(0, &wdt->timer_alive))
-		return -EBUSY;
-
-	if (nowayout)
-		__module_get(THIS_MODULE);
-
-	file->private_data = wdt;
-
-	/*
-	 *	Activate timer
-	 */
-	mpcore_wdt_start(wdt);
-
-	return nonseekable_open(inode, file);
-}
-
-static int mpcore_wdt_release(struct inode *inode, struct file *file)
+static int mpcore_wdt_set_heartbeat(struct watchdog_device *wdd, unsigned int t)
 {
-	struct mpcore_wdt *wdt = file->private_data;
-
-	/*
-	 *	Shut off the timer.
-	 *	Lock it in if it's a module and we set nowayout
-	 */
-	if (wdt->expect_close == 42)
-		mpcore_wdt_stop(wdt);
-	else {
-		dev_printk(KERN_CRIT, wdt->dev,
-				"unexpected close, not stopping watchdog!\n");
-		mpcore_wdt_keepalive(wdt);
-	}
-	clear_bit(0, &wdt->timer_alive);
-	wdt->expect_close = 0;
+	mpcore_margin = t;
 	return 0;
 }
 
-static ssize_t mpcore_wdt_write(struct file *file, const char *data,
-						size_t len, loff_t *ppos)
-{
-	struct mpcore_wdt *wdt = file->private_data;
-
-	/*
-	 *	Refresh the timer.
-	 */
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			/* In case it was set long ago */
-			wdt->expect_close = 0;
-
-			for (i = 0; i != len; i++) {
-				char c;
-
-				if (get_user(c, data + i))
-					return -EFAULT;
-				if (c == 'V')
-					wdt->expect_close = 42;
-			}
-		}
-		mpcore_wdt_keepalive(wdt);
-	}
-	return len;
-}
-
-static const struct watchdog_info ident = {
+static const struct watchdog_info mpcore_wdt_info = {
 	.options		= WDIOF_SETTIMEOUT |
 				  WDIOF_KEEPALIVEPING |
 				  WDIOF_MAGICCLOSE,
 	.identity		= "MPcore Watchdog",
 };
 
-static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
-{
-	struct mpcore_wdt *wdt = file->private_data;
-	int ret;
-	union {
-		struct watchdog_info ident;
-		int i;
-	} uarg;
-
-	if (_IOC_DIR(cmd) && _IOC_SIZE(cmd) > sizeof(uarg))
-		return -ENOTTY;
-
-	if (_IOC_DIR(cmd) & _IOC_WRITE) {
-		ret = copy_from_user(&uarg, (void __user *)arg, _IOC_SIZE(cmd));
-		if (ret)
-			return -EFAULT;
-	}
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		uarg.ident = ident;
-		ret = 0;
-		break;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		uarg.i = 0;
-		ret = 0;
-		break;
-
-	case WDIOC_SETOPTIONS:
-		ret = -EINVAL;
-		if (uarg.i & WDIOS_DISABLECARD) {
-			mpcore_wdt_stop(wdt);
-			ret = 0;
-		}
-		if (uarg.i & WDIOS_ENABLECARD) {
-			mpcore_wdt_start(wdt);
-			ret = 0;
-		}
-		break;
-
-	case WDIOC_KEEPALIVE:
-		mpcore_wdt_keepalive(wdt);
-		ret = 0;
-		break;
-
-	case WDIOC_SETTIMEOUT:
-		ret = mpcore_wdt_set_heartbeat(uarg.i);
-		if (ret)
-			break;
-
-		mpcore_wdt_keepalive(wdt);
-		/* Fall */
-	case WDIOC_GETTIMEOUT:
-		uarg.i = mpcore_margin;
-		ret = 0;
-		break;
-
-	default:
-		return -ENOTTY;
-	}
-
-	if (ret == 0 && _IOC_DIR(cmd) & _IOC_READ) {
-		ret = copy_to_user((void __user *)arg, &uarg, _IOC_SIZE(cmd));
-		if (ret)
-			ret = -EFAULT;
-	}
-	return ret;
-}
+static const struct watchdog_ops mpcore_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= mpcore_wdt_start,
+	.stop		= mpcore_wdt_stop,
+	.ping		= mpcore_wdt_ping,
+	.set_timeout	= mpcore_wdt_set_heartbeat,
+};
 
 /*
  *	System shutdown handler.  Turn off the watchdog if we're
@@ -303,37 +171,15 @@ static void mpcore_wdt_shutdown(struct platform_device *pdev)
 	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
 	if (system_state == SYSTEM_RESTART || system_state == SYSTEM_HALT)
-		mpcore_wdt_stop(wdt);
+		mpcore_wdt_stop(&wdt->wdd);
 }
 
-/*
- *	Kernel Interfaces
- */
-static const struct file_operations mpcore_wdt_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.write		= mpcore_wdt_write,
-	.unlocked_ioctl	= mpcore_wdt_ioctl,
-	.open		= mpcore_wdt_open,
-	.release	= mpcore_wdt_release,
-};
-
-static struct miscdevice mpcore_wdt_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &mpcore_wdt_fops,
-};
-
 static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 {
 	struct mpcore_wdt *wdt;
 	struct resource *res;
 	int ret;
 
-	/* We only accept one device, and it must have an id of -1 */
-	if (pdev->id != -1)
-		return -ENODEV;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
@@ -359,30 +205,41 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 	if (!wdt->base)
 		return -ENOMEM;
 
-	mpcore_wdt_miscdev.parent = &pdev->dev;
-	ret = misc_register(&mpcore_wdt_miscdev);
-	if (ret) {
-		dev_printk(KERN_ERR, wdt->dev,
-			"cannot register miscdev on minor=%d (err=%d)\n",
-							WATCHDOG_MINOR, ret);
-		return ret;
-	}
+	wdt->wdd.info = &mpcore_wdt_info;
+	wdt->wdd.ops = &mpcore_wdt_ops;
+	wdt->wdd.min_timeout = MIN_TIME;
+	wdt->wdd.max_timeout = MAX_TIME;
+	spin_lock_init(&wdt->lock);
 
-	mpcore_wdt_stop(wdt);
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	platform_set_drvdata(pdev, wdt);
-	mpcore_wdt_pdev = pdev;
+	watchdog_set_drvdata(&wdt->wdd, wdt);
+
+	mpcore_wdt_stop(&wdt->wdd);
+
+	ret = watchdog_register_device(&wdt->wdd);
+	if (ret) {
+		dev_err(wdt->dev, "watchdog_register_device() failed: %d\n",
+				ret);
+		goto err_register;
+	}
 
 	return 0;
-}
 
-static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
-{
+err_register:
 	platform_set_drvdata(pdev, NULL);
+	watchdog_set_drvdata(&wdt->wdd, NULL);
 
-	misc_deregister(&mpcore_wdt_miscdev);
+	return ret;
+}
 
-	mpcore_wdt_pdev = NULL;
+static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
+{
+	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
+	watchdog_unregister_device(&wdt->wdd);
+	platform_set_drvdata(pdev, NULL);
+	watchdog_set_drvdata(&wdt->wdd, NULL);
 	return 0;
 }
 
@@ -390,16 +247,18 @@ static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
 static int mpcore_wdt_suspend(struct platform_device *pdev, pm_message_t msg)
 {
 	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
-	mpcore_wdt_stop(wdt);		/* Turn the WDT off */
+	mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
+
 	return 0;
 }
 
 static int mpcore_wdt_resume(struct platform_device *pdev)
 {
 	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
-	/* re-activate timer */
-	if (test_bit(0, &wdt->timer_alive))
-		mpcore_wdt_start(wdt);
+
+	if (is_wdd_active(&wdt->wdd))
+		mpcore_wdt_start(&wdt->wdd);
+
 	return 0;
 }
 #else
@@ -428,15 +287,16 @@ static char banner[] __initdata = KERN_INFO "MPcore Watchdog Timer: 0.1. "
 static int __init mpcore_wdt_init(void)
 {
 	/*
-	 * Check that the margin value is within it's range;
+	 * Check that the mpcore_margin value is within it's range;
 	 * if not reset to the default
 	 */
-	if (mpcore_wdt_set_heartbeat(mpcore_margin)) {
-		mpcore_wdt_set_heartbeat(TIMER_MARGIN);
+	if (mpcore_margin < MIN_TIME || mpcore_margin > MAX_TIME) {
+		mpcore_margin = TIMER_MARGIN;
 		printk(KERN_INFO "mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
-			TIMER_MARGIN);
+				TIMER_MARGIN);
 	}
 
+	mpcore_wdt_set_heartbeat(NULL, mpcore_margin);
 	printk(banner, mpcore_noboot, mpcore_margin, nowayout);
 
 	return platform_driver_register(&mpcore_wdt_driver);
@@ -453,4 +313,3 @@ module_exit(mpcore_wdt_exit);
 MODULE_AUTHOR("ARM Limited");
 MODULE_DESCRIPTION("MPcore Watchdog Device Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.8.110.g4cb5d

