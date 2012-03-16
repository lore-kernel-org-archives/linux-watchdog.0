Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:53737 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965461Ab2CPIOd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 Mar 2012 04:14:33 -0400
From: Linus Walleij <linus.walleij@stericsson.com>
To: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/2 v2] watchdog/coh901327: convert to use watchdog core
Date: Fri, 16 Mar 2012 09:14:12 +0100
Message-ID: <1331885652-21750-1-git-send-email-linus.walleij@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

This converts the COH901327 watchdog to use the watchdog core.
I followed Wolframs document, looked at some other drivers and
tested it on the U300.

Cc: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on top of Viresh's GETTIMELEFT patch and consequently
  dropped the ioctl() call.
---
 drivers/watchdog/Kconfig         |    1 +
 drivers/watchdog/coh901327_wdt.c |  192 +++++++++++---------------------------
 2 files changed, 56 insertions(+), 137 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index df9e8f0..2a4c640 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -283,6 +283,7 @@ config COH901327_WATCHDOG
 	bool "ST-Ericsson COH 901 327 watchdog"
 	depends on ARCH_U300
 	default y if MACH_U300
+	select WATCHDOG_CORE
 	help
 	  Say Y here to include Watchdog timer support for the
 	  watchdog embedded into the ST-Ericsson U300 series platforms.
diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 5b89f7d..7f0cbeb 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -8,17 +8,15 @@
  */
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
-#include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 
 #define DRV_NAME "WDOG COH 901 327"
 
@@ -74,8 +72,6 @@ static resource_size_t phybase;
 static resource_size_t physize;
 static int irq;
 static void __iomem *virtbase;
-static unsigned long coh901327_users;
-static unsigned long boot_status;
 static struct device *parent;
 
 /*
@@ -155,30 +151,31 @@ static void coh901327_disable(void)
 			__func__, val);
 }
 
-static void coh901327_start(void)
+static int coh901327_start(struct watchdog_device *wdt_dev)
 {
 	coh901327_enable(margin * 100);
+	return 0;
+}
+
+static int coh901327_stop(struct watchdog_device *wdt_dev)
+{
+	coh901327_disable();
+	return 0;
 }
 
-static void coh901327_keepalive(void)
+static int coh901327_ping(struct watchdog_device *wdd)
 {
 	clk_enable(clk);
 	/* Feed the watchdog */
 	writew(U300_WDOG_FR_FEED_RESTART_TIMER,
 	       virtbase + U300_WDOG_FR);
 	clk_disable(clk);
+	return 0;
 }
 
-static int coh901327_settimeout(int time)
+static int coh901327_settimeout(struct watchdog_device *wdt_dev,
+				unsigned int time)
 {
-	/*
-	 * Max margin is 327 since the 10ms
-	 * timeout register is max
-	 * 0x7FFF = 327670ms ~= 327s.
-	 */
-	if (time <= 0 || time > 327)
-		return -EINVAL;
-
 	margin = time;
 	clk_enable(clk);
 	/* Set new timeout value */
@@ -190,6 +187,23 @@ static int coh901327_settimeout(int time)
 	return 0;
 }
 
+static unsigned int coh901327_gettimeleft(struct watchdog_device *wdt_dev)
+{
+	u16 val;
+
+	clk_enable(clk);
+	/* Read repeatedly until the value is stable! */
+	val = readw(virtbase + U300_WDOG_CR);
+	while (val & U300_WDOG_CR_VALID_IND)
+		val = readw(virtbase + U300_WDOG_CR);
+	val &= U300_WDOG_CR_COUNT_VALUE_MASK;
+	clk_disable(clk);
+	if (val != 0)
+		val /= 100;
+
+	return val;
+}
+
 /*
  * This interrupt occurs 10 ms before the watchdog WILL bark.
  */
@@ -218,130 +232,35 @@ static irqreturn_t coh901327_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/*
- * Allow only one user (daemon) to open the watchdog
- */
-static int coh901327_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(1, &coh901327_users))
-		return -EBUSY;
-	coh901327_start();
-	return nonseekable_open(inode, file);
-}
-
-static int coh901327_release(struct inode *inode, struct file *file)
-{
-	clear_bit(1, &coh901327_users);
-	coh901327_disable();
-	return 0;
-}
-
-static ssize_t coh901327_write(struct file *file, const char __user *data,
-			       size_t len, loff_t *ppos)
-{
-	if (len)
-		coh901327_keepalive();
-	return len;
-}
-
-static long coh901327_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
-{
-	int ret = -ENOTTY;
-	u16 val;
-	int time;
-	int new_options;
-	union {
-		struct watchdog_info __user *ident;
-		int __user *i;
-	} uarg;
-	static const struct watchdog_info ident = {
-		.options		= WDIOF_CARDRESET |
-					  WDIOF_SETTIMEOUT |
-					  WDIOF_KEEPALIVEPING,
-		.identity		= "COH 901 327 Watchdog",
-		.firmware_version	= 1,
-	};
-	uarg.i = (int __user *)arg;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		ret = copy_to_user(uarg.ident, &ident,
-				   sizeof(ident)) ? -EFAULT : 0;
-		break;
-
-	case WDIOC_GETSTATUS:
-		ret = put_user(0, uarg.i);
-		break;
-
-	case WDIOC_GETBOOTSTATUS:
-		ret = put_user(boot_status, uarg.i);
-		break;
-
-	case WDIOC_SETOPTIONS:
-		ret = get_user(new_options, uarg.i);
-		if (ret)
-			break;
-		if (new_options & WDIOS_DISABLECARD)
-			coh901327_disable();
-		if (new_options & WDIOS_ENABLECARD)
-			coh901327_start();
-		ret = 0;
-		break;
-
-	case WDIOC_KEEPALIVE:
-		coh901327_keepalive();
-		ret = 0;
-		break;
-
-	case WDIOC_SETTIMEOUT:
-		ret = get_user(time, uarg.i);
-		if (ret)
-			break;
-
-		ret = coh901327_settimeout(time);
-		if (ret)
-			break;
-		/* Then fall through to return set value */
-
-	case WDIOC_GETTIMEOUT:
-		ret = put_user(margin, uarg.i);
-		break;
-
-	case WDIOC_GETTIMELEFT:
-		clk_enable(clk);
-		/* Read repeatedly until the value is stable! */
-		val = readw(virtbase + U300_WDOG_CR);
-		while (val & U300_WDOG_CR_VALID_IND)
-			val = readw(virtbase + U300_WDOG_CR);
-		val &= U300_WDOG_CR_COUNT_VALUE_MASK;
-		clk_disable(clk);
-		if (val != 0)
-			val /= 100;
-		ret = put_user(val, uarg.i);
-		break;
-	}
-	return ret;
-}
+static const struct watchdog_info coh901327_ident = {
+	.options = WDIOF_CARDRESET | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = DRV_NAME,
+};
 
-static const struct file_operations coh901327_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.write		= coh901327_write,
-	.unlocked_ioctl	= coh901327_ioctl,
-	.open		= coh901327_open,
-	.release	= coh901327_release,
+static struct watchdog_ops coh901327_ops = {
+	.owner = THIS_MODULE,
+	.start = coh901327_start,
+	.stop = coh901327_stop,
+	.ping = coh901327_ping,
+	.set_timeout = coh901327_settimeout,
+	.get_timeleft = coh901327_gettimeleft,
 };
 
-static struct miscdevice coh901327_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &coh901327_fops,
+static struct watchdog_device coh901327_wdt = {
+	.info = &coh901327_ident,
+	.ops = &coh901327_ops,
+	/*
+	 * Max margin is 327 since the 10ms
+	 * timeout register is max
+	 * 0x7FFF = 327670ms ~= 327s.
+	 */
+	.min_timeout = 0,
+	.max_timeout = 327,
 };
 
 static int __exit coh901327_remove(struct platform_device *pdev)
 {
-	misc_deregister(&coh901327_miscdev);
+	watchdog_unregister_device(&coh901327_wdt);
 	coh901327_disable();
 	free_irq(irq, pdev);
 	clk_put(clk);
@@ -350,7 +269,6 @@ static int __exit coh901327_remove(struct platform_device *pdev)
 	return 0;
 }
 
-
 static int __init coh901327_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -393,7 +311,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	case U300_WDOG_SR_STATUS_TIMED_OUT:
 		dev_info(&pdev->dev,
 			"watchdog timed out since last chip reset!\n");
-		boot_status = WDIOF_CARDRESET;
+		coh901327_wdt.bootstatus |= WDIOF_CARDRESET;
 		/* Status will be cleared below */
 		break;
 	case U300_WDOG_SR_STATUS_NORMAL:
@@ -435,7 +353,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
 
 	clk_disable(clk);
 
-	ret = misc_register(&coh901327_miscdev);
+	ret = watchdog_register_device(&coh901327_wdt);
 	if (ret == 0)
 		dev_info(&pdev->dev,
 			 "initialized. timer margin=%d sec\n", margin);
@@ -547,4 +465,4 @@ module_param(margin, int, 0);
 MODULE_PARM_DESC(margin, "Watchdog margin in seconds (default 60s)");
 
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+MODULE_ALIAS("platform:coh901327-watchdog");
-- 
1.7.9.2

