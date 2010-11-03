Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:52693 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752954Ab0KCOHg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Nov 2010 10:07:36 -0400
Date: Wed, 3 Nov 2010 15:07:28 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linux-watchdog@vger.kernel.org
Cc: uclinux-dev@uclinux.org
Subject: [PATCH] m68knommu,watchdog: Add MCF548x watchdog driver.
Message-ID: <20101103140728.GA25556@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Signed-off-by: Philippe De Muyter <phdm@macqel.be>
---
 arch/m68k/include/asm/m548xgpt.h |    2 +
 drivers/watchdog/Kconfig         |    7 +-
 drivers/watchdog/Makefile        |    3 +-
 drivers/watchdog/m548x_wdt.c     |  227 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 236 insertions(+), 3 deletions(-)
 create mode 100644 drivers/watchdog/m548x_wdt.c

diff --git a/arch/m68k/include/asm/m548xgpt.h b/arch/m68k/include/asm/m548xgpt.h
index c8ef158..33b2eef 100644
--- a/arch/m68k/include/asm/m548xgpt.h
+++ b/arch/m68k/include/asm/m548xgpt.h
@@ -59,11 +59,13 @@
 #define MCF_GPT_GMS_GPIO_INPUT     (0x00000000)
 #define MCF_GPT_GMS_GPIO_OUTLO     (0x00000020)
 #define MCF_GPT_GMS_GPIO_OUTHI     (0x00000030)
+#define MCF_GPT_GMS_GPIO_MASK      (0x00000030)
 #define MCF_GPT_GMS_TMS_DISABLE    (0x00000000)
 #define MCF_GPT_GMS_TMS_INCAPT     (0x00000001)
 #define MCF_GPT_GMS_TMS_OUTCAPT    (0x00000002)
 #define MCF_GPT_GMS_TMS_PWM        (0x00000003)
 #define MCF_GPT_GMS_TMS_GPIO       (0x00000004)
+#define MCF_GPT_GMS_TMS_MASK       (0x00000007)
 
 /* Bit definitions and macros for MCF_GPT_GCIR */
 #define MCF_GPT_GCIR_CNT(x)        (((x)&0x0000FFFF)<<0)
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c356146..1a58eb3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -828,7 +828,12 @@ config SBC_EPX_C3_WATCHDOG
 
 # M68K Architecture
 
-# M68KNOMMU Architecture
+config M548x_WATCHDOG 
+ 	tristate "MCF548x watchdog support" 
+ 	depends on WATCHDOG 
+ 	help 
+ 	  To compile this driver as a module, choose M here: the 
+ 	  module will be called m548x_wdt.
 
 # MIPS Architecture
 
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 8374503..3d7b596 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -104,8 +104,7 @@ obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 # M32R Architecture
 
 # M68K Architecture
-
-# M68KNOMMU Architecture
+obj-$(CONFIG_M548x_WATCHDOG) += m548x_wdt.o
 
 # MIPS Architecture
 obj-$(CONFIG_BCM47XX_WDT) += bcm47xx_wdt.o
diff --git a/drivers/watchdog/m548x_wdt.c b/drivers/watchdog/m548x_wdt.c
new file mode 100644
index 0000000..8983596
--- /dev/null
+++ b/drivers/watchdog/m548x_wdt.c
@@ -0,0 +1,227 @@
+/*
+ * drivers/watchdog/m548x_wdt.c
+ *
+ * Watchdog driver for ColdFire MCF548x processors
+ * Copyright 2010 (c) Philippe De Muyter <phdm@macqel.be>
+ *
+ * Adapted from the IXP4xx watchdog driver, which carries these notices:
+ *
+ *  Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ *  Copyright 2004 (c) MontaVista, Software, Inc.
+ *  Based on sa1100 driver, Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <linux/ioport.h>
+
+#include <asm/uaccess.h>
+#include <asm/coldfire.h>
+#include <asm/m548xsim.h>
+#include <asm/m548xgpt.h>
+
+static int nowayout;
+static unsigned int heartbeat = 30;	/* (secs) Default is 0.5 minute */
+static unsigned long wdt_status;
+
+#define	WDT_IN_USE		0
+#define	WDT_OK_TO_CLOSE		1
+
+static void wdt_enable(void)
+{
+	unsigned int gms0;
+
+	/* preserve GPIO usage, if any */
+	gms0 = __raw_readl(MCF_MBAR + MCF_GPT_GMS0);
+	if (gms0 & MCF_GPT_GMS_TMS_GPIO)
+		gms0 &= (MCF_GPT_GMS_TMS_GPIO | MCF_GPT_GMS_GPIO_MASK | MCF_GPT_GMS_OD);
+	else
+		gms0 = MCF_GPT_GMS_TMS_GPIO | MCF_GPT_GMS_OD;
+	__raw_writel(gms0, MCF_MBAR + MCF_GPT_GMS0);
+	__raw_writel(MCF_GPT_GCIR_PRE(heartbeat*(MCF_BUSCLK/0xffff)) |
+				MCF_GPT_GCIR_CNT(0xffff), MCF_MBAR + MCF_GPT_GCIR0);
+	gms0 |= MCF_GPT_GMS_OCPW(0xA5) | MCF_GPT_GMS_WDEN | MCF_GPT_GMS_CE;
+	__raw_writel(gms0, MCF_MBAR + MCF_GPT_GMS0);
+}
+
+static void wdt_disable(void)
+{
+	unsigned int gms0;
+
+	/* disable watchdog */
+	gms0 = __raw_readl(MCF_MBAR + MCF_GPT_GMS0);
+	gms0 &= ~(MCF_GPT_GMS_WDEN | MCF_GPT_GMS_CE);
+	__raw_writel(gms0, MCF_MBAR + MCF_GPT_GMS0);
+}
+
+static void wdt_keepalive(void)
+{
+	unsigned int gms0;
+
+	gms0 = __raw_readl(MCF_MBAR + MCF_GPT_GMS0);
+	gms0 |= MCF_GPT_GMS_OCPW(0xA5);
+	__raw_writel(gms0, MCF_MBAR + MCF_GPT_GMS0);
+}
+
+static int m548x_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
+		return -EBUSY;
+
+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+	wdt_enable();
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t m548x_wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					set_bit(WDT_OK_TO_CLOSE, &wdt_status);
+			}
+		}
+		wdt_keepalive();
+	}
+	return len;
+}
+
+static const struct watchdog_info ident = {
+	.options	= WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT |
+				WDIOF_KEEPALIVEPING,
+	.identity	= "Coldfire M548x Watchdog",
+};
+
+static long m548x_wdt_ioctl(struct file *file, unsigned int cmd,
+							 unsigned long arg)
+{
+	int ret = -ENOTTY;
+	int time;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ret = copy_to_user((struct watchdog_info *)arg, &ident,
+				   sizeof(ident)) ? -EFAULT : 0;
+		break;
+
+	case WDIOC_GETSTATUS:
+		ret = put_user(0, (int *)arg);
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		ret = put_user(0, (int *)arg);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		wdt_keepalive();
+		ret = 0;
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(time, (int *)arg);
+		if (ret)
+			break;
+
+		if (time <= 0 || time > 30) {
+			ret = -EINVAL;
+			break;
+		}
+
+		heartbeat = time;
+		wdt_enable();
+		/* Fall through */
+
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(heartbeat, (int *)arg);
+		break;
+	}
+	return ret;
+}
+
+static int m548x_wdt_release(struct inode *inode, struct file *file)
+{
+	if (test_bit(WDT_OK_TO_CLOSE, &wdt_status))
+		wdt_disable();
+	else
+		printk(KERN_CRIT "WATCHDOG: Device closed unexpectedly - "
+					"timer will not stop\n");
+	clear_bit(WDT_IN_USE, &wdt_status);
+	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
+
+	return 0;
+}
+
+
+static const struct file_operations m548x_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= m548x_wdt_write,
+	.unlocked_ioctl	= m548x_wdt_ioctl,
+	.open		= m548x_wdt_open,
+	.release	= m548x_wdt_release,
+};
+
+static struct miscdevice m548x_wdt_miscdev = {
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &m548x_wdt_fops,
+};
+
+static int __init m548x_wdt_init(void)
+{
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+	nowayout = 1;
+#else
+	nowayout = 0;
+#endif
+	if (!request_mem_region(MCF_MBAR + MCF_GPT_GCIR0, 4, "Coldfire M548x Watchdog")) {
+		printk(KERN_WARNING "Coldfire M548x Watchdog : I/O region busy\n");
+		return -EBUSY;
+	}
+	printk("ColdFire watchdog driver is loaded.\n");
+
+	return misc_register(&m548x_wdt_miscdev);
+}
+
+static void __exit m548x_wdt_exit(void)
+{
+	misc_deregister(&m548x_wdt_miscdev);
+	release_mem_region(MCF_MBAR + MCF_GPT_GCIR0, 4);
+}
+
+module_init(m548x_wdt_init);
+module_exit(m548x_wdt_exit);
+
+MODULE_AUTHOR("Philippe De Muyter <phdm@macqel.be>");
+MODULE_DESCRIPTION("Coldfire M548x Watchdog");
+
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds (default 30s)");
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+
-- 
1.7.1

