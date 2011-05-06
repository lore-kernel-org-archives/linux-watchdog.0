Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mhqmail.moxa.com ([218.210.60.130]:54424 "EHLO
	mhqmail01.moxa.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751783Ab1EFFwz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 May 2011 01:52:55 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Subject: RE: [PATCH 2/2] watchdog: add support for MOXA V2100 watchdog driver
Date: Fri, 6 May 2011 13:52:53 +0800
Message-ID: <ECB3782BB8F03341905DD92327029611622363@mhqms01.moxa.com>
In-Reply-To: <ECB3782BB8F03341905DD923270296115F73D8@mhqms01.moxa.com>
From: =?big5?B?SmltbXkgQ2hlbiAos6+lw7lGKQ==?= <jimmy.chen@moxa.com>
To: =?big5?B?SmltbXkgQ2hlbiAos6+lw7lGKQ==?= <jimmy.chen@moxa.com>,
	"Alan Cox" <alan@lxorguk.ukuu.org.uk>,
	"Arnd Bergmann" <arnd@arndb.de>
Cc: "Wolfram Sang" <w.sang@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<wim@iguana.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

From: Jimmy Chen <jimmy.chen@moxa.com>

Does anyone have comment on this driver?

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
diff --git a/drivers/watchdog/moxa_wdt.c b/drivers/watchdog/moxa_wdt.c
new file mode 100644
index 0000000..fdecc9e
--- /dev/null
+++ b/drivers/watchdog/moxa_wdt.c
@@ -0,0 +1,409 @@
+/*
+ * serial driver for the MOXA V2100 platform.
+ *
+ * Copyright (c) MOXA Inc.  All rights reserved.
+ *	Jimmy Chen <jimmy.chen@moxa.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME":"fmt
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/fs.h>
+#include <linux/ioport.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+
+#include <asm/system.h>
+
+#define HW_VENDOR_ID_H				((u8)0x87)
+#define HW_VENDOR_ID_L					((u8)0x83)
+
+#define	SUPERIO_PORT					((u8)0x2e)
+#define CHIP_ID_BYTE1					((u8)0x20)
+#define CHIP_ID_BYTE2					((u8)0x21)
+#define LOGIC_DEVICE_NUMBER			((u8)0x07)
+#define GPIO_CONFIG_REG				((u8)0x07)
+#define WATCHDOG_TIMER1_CTRL			((u8)0x71)
+#define WATCHDOG_TIMER1_CONFIG_REG	((u8)0x72)
+#define WATCHDOG_TIMER1_TIMEOUT_VAL	((u8)0x73)
+#define WATCHDOG_TIMER2_CTRL			((u8)0x81)
+#define WATCHDOG_TIMER2_CONFIG_REG	((u8)0x82)
+#define WATCHDOG_TIMER2_TIMEOUT_VAL	((u8)0x83)
+
+#define DEFAULT_WATCHDOG_TIMEOUT	(30UL*1000UL)	/* 30 seconds */
+#define WATCHDOG_MIN_TIMEOUT	(1UL*1000UL)	/*  2 seconds */
+#define WATCHDOG_MAX_TIMEOUT	(255UL*1000UL)	/* 255 seconds */
+
+
+static unsigned long wdt_is_open;
+static char expect_close;
+
+static int timeout =3D DEFAULT_WATCHDOG_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in seconds. 1<=3D timeout <=3D63, default=3D"
+		__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static int nowayout =3D WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be "
+		"stopped once started (default=3DCONFIG_WATCHDOG_NOWAYOUT)");
+
+static spinlock_t wdt_lock =3D SPIN_LOCK_UNLOCKED;
+
+static inline unsigned char superio_get_reg(u8 val)
+{
+	outb_p(val, SUPERIO_PORT);
+	val =3D inb_p(SUPERIO_PORT+1);
+	return val;
+}
+
+static inline void superio_set_reg(u8 val, u8 index)
+{
+	outb_p(index, SUPERIO_PORT);
+	outb_p(val, (SUPERIO_PORT+1));
+}
+
+static inline void superio_select_dev(u8 val)
+{
+	superio_set_reg(val, LOGIC_DEVICE_NUMBER);
+}
+
+static inline void superio_init(void)
+{
+	outb(0x87, SUPERIO_PORT);
+	outb(0x01, SUPERIO_PORT);
+	outb(0x55, SUPERIO_PORT);
+	outb(0x55, SUPERIO_PORT);
+}
+
+static inline void superio_release(void)
+{
+	outb_p(0x02, SUPERIO_PORT);
+	outb_p(0x02, SUPERIO_PORT+1);
+}
+
+/**
+ *	wdt_start:
+ *
+ *	Start the watchdog driver.
+ */
+
+static int moxawdt_start(void)
+{
+	unsigned long flags;
+	unsigned char val;
+
+	pr_debug("wdt_start: timeout=3D%d\n", timeout);
+
+	spin_lock_irqsave(&wdt_lock, flags);
+	superio_init();
+	superio_select_dev(GPIO_CONFIG_REG);
+	val =3D superio_get_reg(WATCHDOG_TIMER1_CONFIG_REG) | 0x10;
+	superio_set_reg(val, WATCHDOG_TIMER1_CONFIG_REG);
+	superio_set_reg((timeout / 1000), WATCHDOG_TIMER1_TIMEOUT_VAL);
+	spin_unlock_irqrestore(&wdt_lock, flags);
+	return 0;
+}
+
+/**
+ *	wdt_stop:
+ *
+ *	Stop the watchdog driver.
+ */
+
+static int wdt_stop(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdt_lock, flags);
+
+	pr_debug("wdt_disable\n");
+	superio_init();
+	superio_select_dev(GPIO_CONFIG_REG);
+	superio_set_reg(0, WATCHDOG_TIMER1_TIMEOUT_VAL);
+	spin_unlock_irqrestore(&wdt_lock, flags);
+	return 0;
+}
+
+/**
+ *	wdt_ping:
+ *
+ *	Reload counter one with the watchdog heartbeat. We don't bother
+ *	reloading the cascade counter.
+ */
+
+static void wdt_ping(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdt_lock, flags);
+
+	pr_debug("wdt_ping: timeout=3D%d\n", timeout);
+	superio_init();
+	superio_select_dev(GPIO_CONFIG_REG);
+	superio_set_reg((timeout / 1000), WATCHDOG_TIMER1_TIMEOUT_VAL);
+	spin_unlock_irqrestore(&wdt_lock, flags);
+}
+
+/**
+ *	wdt_verify_vendor:
+ *	return true if vendor ID match
+ */
+
+static int wdt_verify_vendor(void)
+{
+	unsigned char chip_id_h;
+	unsigned char chip_id_l;
+
+	superio_init();
+	superio_select_dev(GPIO_CONFIG_REG);
+	chip_id_h =3D superio_get_reg(CHIP_ID_BYTE1);
+	chip_id_l =3D superio_get_reg(CHIP_ID_BYTE2);
+	if ((chip_id_h =3D=3D HW_VENDOR_ID_H) && (chip_id_l =3D=3D HW_VENDOR_ID=
_L))
+		return 0;
+
+	return 1;
+}
+
+/**
+ *	wdt_set_timeout:
+ *	@t:		the new heartbeat value that needs to be set.
+ *
+ *	Set a new heartbeat value for the watchdog device. If the heartbeat
+ *	value is incorrect we keep the old value and return -EINVAL. If
+ *	successful we return 0.
+ */
+
+static int wdt_set_timeout(int *t)
+{
+	if (*t < WATCHDOG_MIN_TIMEOUT || *t > WATCHDOG_MAX_TIMEOUT) {
+		*t =3D DEFAULT_WATCHDOG_TIMEOUT;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int moxawdt_open(struct inode *inode, struct file *file)
+{
+
+	if (test_and_set_bit(0, &wdt_is_open))
+		return -EBUSY;
+
+	pr_debug("moxawdt_open entry\n");
+	moxawdt_start();
+	return nonseekable_open(inode, file);
+
+	return 0;
+}
+
+static int moxawdt_release(struct inode *inode, struct file *file)
+{
+	pr_debug("moxawdt_release entry\n");
+
+	if (expect_close =3D=3D 42) {
+		wdt_stop();
+		clear_bit(0, &wdt_is_open);
+	} else {
+		pr_crit("wdt: WDT device closed unexpectedly.  WDT will not stop!\n");
+		wdt_ping();
+	}
+	expect_close =3D 0;
+
+	return 0;
+}
+
+static long moxawdt_ioctl(struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	void __user *argp =3D (void __user *)arg;
+	int __user *p =3D argp;
+	int new_timeout;
+	int status;
+
+	static struct watchdog_info ident =3D {
+		.options =3D		WDIOF_SETTIMEOUT|
+					WDIOF_MAGICCLOSE|
+					WDIOF_KEEPALIVEPING,
+		.firmware_version =3D	1,
+		.identity =3D		"MOXA2100WDT ",
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
+	case WDIOC_GETSTATUS:
+		status =3D 1;
+		return put_user(status, p);
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, p);
+	case WDIOC_KEEPALIVE:
+		wdt_ping();
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_timeout, p))
+			return -EFAULT;
+		if (wdt_set_timeout(&new_timeout))
+			return -EINVAL;
+		wdt_ping();
+		/* Fall */
+	case WDIOC_GETTIMEOUT:
+		return put_user(timeout, p);
+	default:
+		return -ENOTTY;
+	}
+	return 0;
+}
+
+/*
+ *      moxawdt_write:
+ *      @file: file handle to the watchdog
+ *      @buf: buffer to write (unused as data does not matter here
+ *      @count: count of bytes
+ *      @ppos: pointer to the position to write. No seeks allowed
+ *
+ *      A write to a watchdog device is defined as a keepalive signal. A=
ny
+ *      write of data will do, as we we don't define content meaning.
+ */
+
+static ssize_t moxawdt_write(struct file *file, const char *buf, \
+			    size_t count, loff_t *ppos)
+{
+	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			for (i =3D 0; i !=3D count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c =3D=3D 'V')
+					expect_close =3D 42;
+			}
+		}
+
+	}
+	return count;
+}
+
+/**
+ *	notify_sys:
+ *	@this: our notifier block
+ *	@code: the event being reported
+ *	@unused: unused
+ *
+ *	Our notifier is called on system shutdowns. We want to turn the card
+ *	off at reboot otherwise the machine will reboot again during memory
+ *	test or worse yet during the following fsck. This would suck, in fact
+ *	trust me - if it happens it does suck.
+ */
+
+static int wdt_notify_sys(struct notifier_block *this, unsigned long cod=
e,
+	void *unused)
+{
+	if (code =3D=3D SYS_DOWN || code =3D=3D SYS_HALT)
+		wdt_stop();
+	return NOTIFY_DONE;
+}
+
+/*
+ *	The WDT card needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off.
+ */
+
+static struct notifier_block wdt_notifier =3D {
+	.notifier_call =3D wdt_notify_sys,
+};
+
+static const struct file_operations moxawdt_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.llseek		=3D no_llseek,
+	.open		=3D moxawdt_open,
+	.write		=3D moxawdt_write,
+	.unlocked_ioctl	=3D moxawdt_ioctl,
+	.release	=3D moxawdt_release,
+};
+
+static struct miscdevice wdt_miscdev =3D {
+	.minor =3D WATCHDOG_MINOR,
+	.name =3D "watchdog",
+	.fops =3D &moxawdt_fops,
+};
+
+static void __exit moxawdt_exit(void)
+{
+	misc_deregister(&wdt_miscdev);
+	unregister_reboot_notifier(&wdt_notifier);
+	release_region(SUPERIO_PORT, 2);
+	superio_release();
+}
+
+static int __init moxawdt_init(void)
+{
+	int ret;
+
+	if (wdt_set_timeout(&timeout)) {
+		pr_err("timeout value must be %lu < timeout < %lu, using %d\n",
+				WATCHDOG_MIN_TIMEOUT, WATCHDOG_MAX_TIMEOUT,
+				timeout);
+	}
+
+	if (!request_region(SUPERIO_PORT, 2, "moxawdt")) {
+		pr_err("moxawdt_init: can't get I/O address 0x%x\n", SUPERIO_PORT);
+		ret =3D -EBUSY;
+		goto reqreg_err;
+	}
+
+	if (wdt_verify_vendor()) {
+		pr_err("hw device id not match!!\n");
+		ret =3D -ENODEV;
+		goto reqreg_err;
+	}
+
+	ret =3D register_reboot_notifier(&wdt_notifier);
+	if (ret) {
+		pr_err("can't register reboot notifier\n");
+		goto regreb_err;
+	}
+
+	ret =3D misc_register(&wdt_miscdev);
+	if (ret) {
+		pr_err("Moxa V2100-LX WatchDog: Register misc fail !\n");
+		goto regmisc_err;
+	}
+
+	pr_info("Moxa V2100 Watchdog Driver. nowayout=3D%d, timeout=3D%d\n", no=
wayout, timeout);
+
+	return 0;
+
+regmisc_err:
+	unregister_reboot_notifier(&wdt_notifier);
+regreb_err:
+	release_region(SUPERIO_PORT, 2);
+reqreg_err:
+	return ret;
+}
+
+module_init(moxawdt_init);
+module_exit(moxawdt_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Jimmy.Chen@moxa.com");
+MODULE_DESCRIPTION("Moxa V2100-LX WDT driver");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo info =
at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
