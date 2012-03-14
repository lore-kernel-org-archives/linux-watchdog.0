Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail131.messagelabs.com ([216.82.242.99]:8912 "EHLO
	mail131.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761254Ab2CNRc0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Mar 2012 13:32:26 -0400
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: <linux-watchdog@vger.kernel.org>
Subject: watchdog: Convert ep93xx driver to watchdog core
Date: Wed, 14 Mar 2012 10:31:50 -0700
CC: <wim@iguana.be>, <rmallon@gmail.com>, <mika.westerberg@iki.fi>,
	<hsweeten@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <201203141031.50746.hartleys@visionengravers.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Convert the ep93xx_wdt driver to the watchdog framework API.

Also, use the dev_<fmt> functions instead of pr_<fmt> for logging.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>

---


diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ee27f57..5ea4685 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -217,6 +217,7 @@ config MPCORE_WATCHDOG
 config EP93XX_WATCHDOG
 	tristate "EP93xx Watchdog"
 	depends on ARCH_EP93XX
+	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
 	  embedded in the Cirrus Logic EP93xx family of devices.
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index bd01bde..414ce8f 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -8,6 +8,9 @@
  * Authors: Ray Lehtiniemi <rayl@mail.com>,
  *	Alessandro Zummo <a.zummo@towertech.it>
  *
+ * Copyright (c) 2012 H Hartley Sweeten <hsweeten@visionengravers.com>
+ *	Convert to a platform device and use the watchdog framework API
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -23,33 +26,31 @@
  *	- Add a few missing ioctls
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/platform_device.h>
 #include <linux/module.h>
-#include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/timer.h>
-#include <linux/uaccess.h>
 #include <linux/io.h>
 
-#define WDT_VERSION	"0.3"
+#define WDT_VERSION	"0.4"
 
 /* default timeout (secs) */
 #define WDT_TIMEOUT 30
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
+
 static int timeout = WDT_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in seconds. (1<=timeout<=3600, default="
+				__MODULE_STRING(WDT_TIMEOUT) ")");
 
 static void __iomem *mmio_base;
 static struct timer_list timer;
 static unsigned long next_heartbeat;
-static unsigned long wdt_status;
-static unsigned long boot_status;
-
-#define WDT_IN_USE		0
-#define WDT_OK_TO_CLOSE		1
 
 #define EP93XX_WATCHDOG		0x00
 #define EP93XX_WDSTATUS		0x04
@@ -57,155 +58,60 @@ static unsigned long boot_status;
 /* reset the wdt every ~200ms */
 #define WDT_INTERVAL (HZ/5)
 
-static void wdt_enable(void)
+static void ep93xx_wdt_timer_ping(unsigned long data)
 {
-	writel(0xaaaa, mmio_base + EP93XX_WATCHDOG);
-}
-
-static void wdt_disable(void)
-{
-	writel(0xaa55, mmio_base + EP93XX_WATCHDOG);
-}
+	if (time_before(jiffies, next_heartbeat))
+		writel(0x5555, mmio_base + EP93XX_WATCHDOG);
 
-static inline void wdt_ping(void)
-{
-	writel(0x5555, mmio_base + EP93XX_WATCHDOG);
+	/* Re-set the timer interval */
+	mod_timer(&timer, jiffies + WDT_INTERVAL);
 }
 
-static void wdt_startup(void)
+static int ep93xx_wdt_start(struct watchdog_device *wdd)
 {
 	next_heartbeat = jiffies + (timeout * HZ);
 
-	wdt_enable();
+	writel(0xaaaa, mmio_base + EP93XX_WATCHDOG);
 	mod_timer(&timer, jiffies + WDT_INTERVAL);
+
+	return 0;
 }
 
-static void wdt_shutdown(void)
+static int ep93xx_wdt_stop(struct watchdog_device *wdd)
 {
 	del_timer_sync(&timer);
-	wdt_disable();
+	writel(0xaa55, mmio_base + EP93XX_WATCHDOG);
+
+	return 0;
 }
 
-static void wdt_keepalive(void)
+static int ep93xx_wdt_keepalive(struct watchdog_device *wdd)
 {
 	/* user land ping */
 	next_heartbeat = jiffies + (timeout * HZ);
-}
-
-static int ep93xx_wdt_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
-		return -EBUSY;
-
-	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
-
-	wdt_startup();
-
-	return nonseekable_open(inode, file);
-}
-
-static ssize_t
-ep93xx_wdt_write(struct file *file, const char __user *data, size_t len,
-		 loff_t *ppos)
-{
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
-
-			for (i = 0; i != len; i++) {
-				char c;
 
-				if (get_user(c, data + i))
-					return -EFAULT;
-
-				if (c == 'V')
-					set_bit(WDT_OK_TO_CLOSE, &wdt_status);
-				else
-					clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
-			}
-		}
-		wdt_keepalive();
-	}
-
-	return len;
+	return 0;
 }
 
-static const struct watchdog_info ident = {
-	.options = WDIOF_CARDRESET | WDIOF_MAGICCLOSE,
-	.identity = "EP93xx Watchdog",
+static const struct watchdog_info ep93xx_wdt_ident = {
+	.options	= WDIOF_CARDRESET |
+			  WDIOF_MAGICCLOSE |
+			  WDIOF_KEEPALIVEPING,
+	.identity	= "EP93xx Watchdog",
 };
 
-static long ep93xx_wdt_ioctl(struct file *file,
-					unsigned int cmd, unsigned long arg)
-{
-	int ret = -ENOTTY;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
-				sizeof(ident)) ? -EFAULT : 0;
-		break;
-
-	case WDIOC_GETSTATUS:
-		ret = put_user(0, (int __user *)arg);
-		break;
-
-	case WDIOC_GETBOOTSTATUS:
-		ret = put_user(boot_status, (int __user *)arg);
-		break;
-
-	case WDIOC_KEEPALIVE:
-		wdt_keepalive();
-		ret = 0;
-		break;
-
-	case WDIOC_GETTIMEOUT:
-		/* actually, it is 0.250 seconds.... */
-		ret = put_user(1, (int __user *)arg);
-		break;
-	}
-	return ret;
-}
-
-static int ep93xx_wdt_release(struct inode *inode, struct file *file)
-{
-	if (test_bit(WDT_OK_TO_CLOSE, &wdt_status))
-		wdt_shutdown();
-	else
-		pr_crit("Device closed unexpectedly - timer will not stop\n");
-
-	clear_bit(WDT_IN_USE, &wdt_status);
-	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
-
-	return 0;
-}
-
-static const struct file_operations ep93xx_wdt_fops = {
+static struct watchdog_ops ep93xx_wdt_ops = {
 	.owner		= THIS_MODULE,
-	.write		= ep93xx_wdt_write,
-	.unlocked_ioctl	= ep93xx_wdt_ioctl,
-	.open		= ep93xx_wdt_open,
-	.release	= ep93xx_wdt_release,
-	.llseek		= no_llseek,
+	.start		= ep93xx_wdt_start,
+	.stop		= ep93xx_wdt_stop,
+	.ping		= ep93xx_wdt_keepalive,
 };
 
-static struct miscdevice ep93xx_wdt_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &ep93xx_wdt_fops,
+static struct watchdog_device ep93xx_wdt_wdd = {
+	.info		= &ep93xx_wdt_ident,
+	.ops		= &ep93xx_wdt_ops,
 };
 
-static void ep93xx_timer_ping(unsigned long data)
-{
-	if (time_before(jiffies, next_heartbeat))
-		wdt_ping();
-
-	/* Re-set the timer interval */
-	mod_timer(&timer, jiffies + WDT_INTERVAL);
-}
-
 static int __devinit ep93xx_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -226,26 +132,32 @@ static int __devinit ep93xx_wdt_probe(struct platform_device *pdev)
 
 	if (timeout < 1 || timeout > 3600) {
 		timeout = WDT_TIMEOUT;
-		pr_info("timeout value must be 1<=x<=3600, using %d\n",
+		dev_warn(&pdev->dev,
+			"timeout value must be 1<=x<=3600, using %d\n",
 			timeout);
 	}
 
 	val = readl(mmio_base + EP93XX_WATCHDOG);
-	boot_status = val & 0x01 ? 1 : 0;
+	ep93xx_wdt_wdd.bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
 
-	setup_timer(&timer, ep93xx_timer_ping, 1);
+	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);
 
-	err = misc_register(&ep93xx_wdt_miscdev);
+	setup_timer(&timer, ep93xx_wdt_timer_ping, 1);
 
-	pr_info("EP93XX watchdog, driver version " WDT_VERSION "%s\n",
+	err = watchdog_register_device(&ep93xx_wdt_wdd);
+	if (err)
+		return err;
+
+	dev_info(&pdev->dev,
+		"EP93XX watchdog, driver version " WDT_VERSION "%s\n",
 		(val & 0x08) ? " (nCS1 disable detected)" : "");
-	return err;
+
+	return 0;
 }
 
 static int __devexit ep93xx_wdt_remove(struct platform_device *pdev)
 {
-	wdt_shutdown();
-	misc_deregister(&ep93xx_wdt_miscdev);
+	watchdog_unregister_device(&ep93xx_wdt_wdd);
 	return 0;
 }
 
@@ -260,16 +172,9 @@ static struct platform_driver ep93xx_wdt_driver = {
 
 module_platform_driver(ep93xx_wdt_driver);
 
-module_param(nowayout, bool, 0);
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
-
-module_param(timeout, int, 0);
-MODULE_PARM_DESC(timeout,
-	"Watchdog timeout in seconds. (1<=timeout<=3600, default="
-				__MODULE_STRING(WDT_TIMEOUT) ")");
-
 MODULE_AUTHOR("Ray Lehtiniemi <rayl@mail.com>,"
-		"Alessandro Zummo <a.zummo@towertech.it>");
+		"Alessandro Zummo <a.zummo@towertech.it>,"
+		"H Hartley Sweeten <hsweeten@visionengravers.com>");
 MODULE_DESCRIPTION("EP93xx Watchdog");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(WDT_VERSION);
