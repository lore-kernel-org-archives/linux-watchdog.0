Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 59-124-160-117.HINET-IP.hinet.net ([59.124.160.117]:41912 "EHLO
	ATCPCS06.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab1ADHtv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Jan 2011 02:49:51 -0500
From: Macpaul Lin <macpaul@andestech.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Macpaul Lin <macpaul@andestech.com>
Subject: [PATCH] watchdog/ftwdt010: Release Faraday ftwdt010 watchdog
Date: Tue,  4 Jan 2011 15:34:54 +0800
Message-Id: <1294126494-8119-1-git-send-email-macpaul@andestech.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Support Faraday ftwdt010 watchdog driver.

Signed-off-by: Macpaul Lin <macpaul@andestech.com>
---
 drivers/watchdog/Kconfig        |    6 ++
 drivers/watchdog/Makefile       |    1 +
 drivers/watchdog/ftwdt010_wdt.c |  178 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/ftwdt010_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3711b88..86deb80 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -55,6 +55,12 @@ config SOFT_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called softdog.
 
+config FTWDT010_WATCHDOG
+	tristate "FTWDT010_WATCHDOG"
+	help
+	  Support for Faraday ftwdt010 watchdog. When the watchdog triigers the
+	  system will be reset.
+
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
 	depends on MFD_WM831X
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 699199b..a3b9bee 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_WATCHDOG_CP1XXX)		+= cpwd.o
 # XTENSA Architecture
 
 # Architecture Independant
+obj-$(CONFIG_FTWDT010_WATCHDOG) += ftwdt010_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
 obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
new file mode 100644
index 0000000..41447d1
--- /dev/null
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -0,0 +1,178 @@
+/*
+ *  Watchdog driver for the FTWDT010 Watch Dog Driver
+ *
+ *      (c) Copyright 2004 Faraday Technology Corp. (www.faraday-tech.com)
+ *      Based on sa1100_wdt.c by Oleg Drokin <green@crimea.edu>
+ *      Based on SoftDog driver by Alan Cox <alan@redhat.com>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ *      27/11/2004 Initial release
+ */
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/smp_lock.h>
+#include <linux/delay.h>
+#include <asm/uaccess.h>
+
+#define DEBUG( str, ...)			\
+	do{					\
+		if( debug)			\
+		printk( str, ##__VA_ARGS__);	\
+	} while(0)
+
+#define wdcounter	(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x00))
+#define wdload		(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x04))
+#define wdrestart	(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x08))
+#define wdcr		(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x0C))
+#define wdstatus	(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x10))
+#define wdclear		(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x14))
+#define wdintrcter	(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x18))
+
+#define TIMER_MARGIN	60	/* (secs) Default is 1 minute */
+#define RESTART_MAGIC	0x5AB9
+#define PCLK		(AHB_CLK_IN / 2)
+
+static int debug = 0;
+static int timeout = TIMER_MARGIN;  /* in seconds */
+
+module_param(debug, int, 0);
+module_param(timeout, int, 0);
+
+static int ftwdt010_dog_open(struct inode *inode, struct file *file){
+
+#if 0
+	/* Allow only one person to hold it open */
+	if( test_and_set_bit( 1, &ftwdt010_wdt_users))
+		return -EBUSY;
+
+	ftwdt010_wdt_users = 1;
+#endif
+	DEBUG("Activating WDT..\n");
+
+	wdcr = 0;
+	wdload = PCLK * timeout;
+	wdrestart = RESTART_MAGIC;	/* Magic number */
+	wdcr = 0x03;			/* Enable WDT */
+
+	return 0;
+}
+
+static int ftwdt010_dog_release(struct inode *inode, struct file *file){
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	/*
+	 *  Shut off the timer.
+	 *  Lock it in if it's a module and we defined ...NOWAYOUT
+	 */
+	wdcr = 0;
+	DEBUG( "Deactivating WDT..\n");
+#endif
+	return 0;
+}
+
+static ssize_t ftwdt010_dog_write(struct file *file, const char *data, size_t len, loff_t *ppos){
+
+	if(len){
+
+		wdrestart = RESTART_MAGIC;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int ftwdt010_dog_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg){
+
+	static struct watchdog_info ident = {
+		.identity = "FTWDT010 watchdog",
+	};
+
+	int time = 0;
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+
+	switch( cmd){
+
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &ident, sizeof( ident));
+
+		case WDIOC_GETSTATUS:
+			return put_user(0, p);
+
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(wdstatus ? WDIOF_CARDRESET : 0, p);
+
+		case WDIOC_SETTIMEOUT:
+
+			if( get_user( time, p))
+				return 0;
+
+			if( time <= 0 || time > 255)
+
+				return -EINVAL;
+
+			timeout = time;
+			wdload = PCLK * timeout;
+			wdrestart = RESTART_MAGIC;
+
+			return put_user(timeout, p);
+
+		case WDIOC_GETTIMEOUT:
+			return put_user(timeout, p);
+
+		case WDIOC_KEEPALIVE:
+			wdrestart = RESTART_MAGIC;
+			return 0;
+
+		default:
+			return -ENOIOCTLCMD;
+
+	}
+}
+
+static struct file_operations ftwdt010_dog_fops = {
+
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= ftwdt010_dog_write,
+	.ioctl		= ftwdt010_dog_ioctl,
+	.open		= ftwdt010_dog_open,
+	.release	= ftwdt010_dog_release,
+};
+
+static struct miscdevice ftwdt010_dog_miscdev = {
+
+	WATCHDOG_MINOR,
+	"FTWDT010 watchdog",
+	&ftwdt010_dog_fops
+};
+
+static int __init ftwdt010_dog_init( void){
+
+	int ret;
+
+	ret = misc_register(&ftwdt010_dog_miscdev);
+
+	if( ret)
+		return ret;
+
+	DEBUG("FTWDT010 watchdog timer: timer timeout %d sec\n", timeout);
+
+	return 0;
+}
+
+static void __exit ftwdt010_dog_exit( void){
+
+	misc_deregister(&ftwdt010_dog_miscdev);
+}
+
+module_init(ftwdt010_dog_init);
+module_exit(ftwdt010_dog_exit);
+MODULE_AUTHOR("Faraday Corp.");
+MODULE_LICENSE("GPL");
-- 
1.7.3.2

