Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:49933 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933239Ab3CEEyd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 23:54:33 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: =?UTF-8?q?=5BPATCH=201/8=5D=20watchdog=3A=20w83627hf=3A=20Convert=20to=20watchdog=20infrastructure?=
Date: Mon,  4 Mar 2013 20:54:12 -0800
Message-Id: <1362459259-9733-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1362459259-9733-1-git-send-email-linux@roeck-us.net>
References: <1362459259-9733-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig        |    1 +
 drivers/watchdog/w83627hf_wdt.c |  234 ++++++++-------------------------=
------
 2 files changed, 47 insertions(+), 188 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9fcc70c..dd462af 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -856,6 +856,7 @@ config VIA_WDT
 config W83627HF_WDT
 	tristate "W83627HF/W83627DHG Watchdog Timer"
 	depends on X86
+	select WATCHDOG_CORE
 	---help---
 	  This is the driver for the hardware watchdog on the W83627HF chipset
 	  as used in Advantech PC-9578 and Tyan S2721-533 motherboards
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
index 92f1326..cd82a47 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -1,6 +1,9 @@
 /*
  *	w83627hf/thf WDT driver
  *
+ *	(c) Copyright 2013 Guenter Roeck
+ *		converted to watchdog infrastructure
+ *
  *	(c) Copyright 2007 Vlad Drukker <vlad@storewiz.com>
  *		added support for W83627THF.
  *
@@ -31,42 +34,21 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
-#include <linux/fs.h>
 #include <linux/ioport.h>
-#include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
-#include <linux/uaccess.h>
-
=20
 #define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
 #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
=20
-static unsigned long wdt_is_open;
-static char expect_close;
-static DEFINE_SPINLOCK(io_lock);
-
 /* You must set this - there is no sane way to probe for this board. */
 static int wdt_io =3D 0x2E;
 module_param(wdt_io, int, 0);
 MODULE_PARM_DESC(wdt_io, "w83627hf/thf WDT io port (default 0x2E)");
=20
-static int timeout =3D WATCHDOG_TIMEOUT;	/* in seconds */
-module_param(timeout, int, 0);
-MODULE_PARM_DESC(timeout,
-		"Watchdog timeout in seconds. 1 <=3D timeout <=3D 255, default=3D"
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
-
-static bool nowayout =3D WATCHDOG_NOWAYOUT;
-module_param(nowayout, bool, 0);
-MODULE_PARM_DESC(nowayout,
-		"Watchdog cannot be stopped once started (default=3D"
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-
 /*
  *	Kernel methods.
  */
@@ -120,8 +102,8 @@ static void w83627hf_init(void)
 	t =3D inb_p(WDT_EFDR);      /* read CRF6 */
 	if (t !=3D 0) {
 		pr_info("Watchdog already running. Resetting timeout to %d sec\n",
-			timeout);
-		outb_p(timeout, WDT_EFDR);    /* Write back to CRF6 */
+			WATCHDOG_TIMEOUT);
+		outb_p(WATCHDOG_TIMEOUT, WDT_EFDR);    /* Write back to CRF6 */
 	}
=20
 	outb_p(0xF5, WDT_EFER); /* Select CRF5 */
@@ -141,171 +123,53 @@ static void w83627hf_init(void)
 	w83627hf_unselect_wd_register();
 }
=20
-static void wdt_set_time(int timeout)
+static int wdt_set_time(unsigned int timeout)
 {
-	spin_lock(&io_lock);
-
 	w83627hf_select_wd_register();
-
 	outb_p(0xF6, WDT_EFER);    /* Select CRF6 */
 	outb_p(timeout, WDT_EFDR); /* Write Timeout counter to CRF6 */
-
 	w83627hf_unselect_wd_register();
-
-	spin_unlock(&io_lock);
+	return 0;
 }
=20
-static int wdt_ping(void)
+static int wdt_start(struct watchdog_device *wdog)
 {
-	wdt_set_time(timeout);
-	return 0;
+	return wdt_set_time(wdog->timeout);
 }
=20
-static int wdt_disable(void)
+static int wdt_stop(struct watchdog_device *wdog)
 {
-	wdt_set_time(0);
-	return 0;
+	return wdt_set_time(0);
 }
=20
-static int wdt_set_heartbeat(int t)
+static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int ti=
meout)
 {
-	if (t < 1 || t > 255)
-		return -EINVAL;
-	timeout =3D t;
+	wdt_set_time(timeout);
+	wdog->timeout =3D timeout;
+
 	return 0;
 }
=20
-static int wdt_get_time(void)
+static unsigned int wdt_get_time(struct watchdog_device *wdog)
 {
-	int timeleft;
-
-	spin_lock(&io_lock);
+	unsigned int timeleft;
=20
 	w83627hf_select_wd_register();
-
-	outb_p(0xF6, WDT_EFER);    /* Select CRF6 */
-	timeleft =3D inb_p(WDT_EFDR); /* Read Timeout counter to CRF6 */
-
+	outb_p(0xF6, WDT_EFER);
+	timeleft =3D inb(WDT_EFDR);
 	w83627hf_unselect_wd_register();
=20
-	spin_unlock(&io_lock);
-
 	return timeleft;
 }
=20
-static ssize_t wdt_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
-{
-	if (count) {
-		if (!nowayout) {
-			size_t i;
-
-			expect_close =3D 0;
-
-			for (i =3D 0; i !=3D count; i++) {
-				char c;
-				if (get_user(c, buf + i))
-					return -EFAULT;
-				if (c =3D=3D 'V')
-					expect_close =3D 42;
-			}
-		}
-		wdt_ping();
-	}
-	return count;
-}
-
-static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long=
 arg)
-{
-	void __user *argp =3D (void __user *)arg;
-	int __user *p =3D argp;
-	int timeval;
-	static const struct watchdog_info ident =3D {
-		.options =3D WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
-							WDIOF_MAGICCLOSE,
-		.firmware_version =3D 1,
-		.identity =3D "W83627HF WDT",
-	};
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		if (copy_to_user(argp, &ident, sizeof(ident)))
-			return -EFAULT;
-		break;
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-	case WDIOC_SETOPTIONS:
-	{
-		int options, retval =3D -EINVAL;
-
-		if (get_user(options, p))
-			return -EFAULT;
-		if (options & WDIOS_DISABLECARD) {
-			wdt_disable();
-			retval =3D 0;
-		}
-		if (options & WDIOS_ENABLECARD) {
-			wdt_ping();
-			retval =3D 0;
-		}
-		return retval;
-	}
-	case WDIOC_KEEPALIVE:
-		wdt_ping();
-		break;
-	case WDIOC_SETTIMEOUT:
-		if (get_user(timeval, p))
-			return -EFAULT;
-		if (wdt_set_heartbeat(timeval))
-			return -EINVAL;
-		wdt_ping();
-		/* Fall */
-	case WDIOC_GETTIMEOUT:
-		return put_user(timeout, p);
-	case WDIOC_GETTIMELEFT:
-		timeval =3D wdt_get_time();
-		return put_user(timeval, p);
-	default:
-		return -ENOTTY;
-	}
-	return 0;
-}
-
-static int wdt_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(0, &wdt_is_open))
-		return -EBUSY;
-	/*
-	 *	Activate
-	 */
-
-	wdt_ping();
-	return nonseekable_open(inode, file);
-}
-
-static int wdt_close(struct inode *inode, struct file *file)
-{
-	if (expect_close =3D=3D 42)
-		wdt_disable();
-	else {
-		pr_crit("Unexpected close, not stopping watchdog!\n");
-		wdt_ping();
-	}
-	expect_close =3D 0;
-	clear_bit(0, &wdt_is_open);
-	return 0;
-}
-
 /*
  *	Notifier for system down
  */
-
 static int wdt_notify_sys(struct notifier_block *this, unsigned long cod=
e,
 	void *unused)
 {
 	if (code =3D=3D SYS_DOWN || code =3D=3D SYS_HALT)
-		wdt_disable();	/* Turn the WDT off */
+		wdt_set_time(0);	/* Turn the WDT off */
=20
 	return NOTIFY_DONE;
 }
@@ -314,19 +178,26 @@ static int wdt_notify_sys(struct notifier_block *th=
is, unsigned long code,
  *	Kernel Interfaces
  */
=20
-static const struct file_operations wdt_fops =3D {
-	.owner		=3D THIS_MODULE,
-	.llseek		=3D no_llseek,
-	.write		=3D wdt_write,
-	.unlocked_ioctl	=3D wdt_ioctl,
-	.open		=3D wdt_open,
-	.release	=3D wdt_close,
+static struct watchdog_info wdt_info =3D {
+	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity =3D "W83627HF Watchdog",
+};
+
+static struct watchdog_ops wdt_ops =3D {
+	.owner =3D THIS_MODULE,
+	.start =3D wdt_start,
+	.stop =3D wdt_stop,
+	.ping =3D wdt_start,
+	.set_timeout =3D wdt_set_timeout,
+	.get_timeleft =3D wdt_get_time,
 };
=20
-static struct miscdevice wdt_miscdev =3D {
-	.minor =3D WATCHDOG_MINOR,
-	.name =3D "watchdog",
-	.fops =3D &wdt_fops,
+static struct watchdog_device wdt_dev =3D {
+	.info =3D &wdt_info,
+	.ops =3D &wdt_ops,
+	.timeout =3D WATCHDOG_TIMEOUT,
+	.min_timeout =3D 1,
+	.max_timeout =3D 255,
 };
=20
 /*
@@ -341,19 +212,13 @@ static struct notifier_block wdt_notifier =3D {
 static int __init wdt_init(void)
 {
 	int ret;
+	bool nowayout =3D WATCHDOG_NOWAYOUT;
=20
 	pr_info("WDT driver for the Winbond(TM) W83627HF/THF/HG/DHG Super I/O c=
hip initialising\n");
=20
-	if (wdt_set_heartbeat(timeout)) {
-		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
-		pr_info("timeout value must be 1 <=3D timeout <=3D 255, using %d\n",
-			WATCHDOG_TIMEOUT);
-	}
-
 	if (!request_region(wdt_io, 1, WATCHDOG_NAME)) {
 		pr_err("I/O address 0x%04x already in use\n", wdt_io);
-		ret =3D -EIO;
-		goto out;
+		return -EIO;
 	}
=20
 	w83627hf_init();
@@ -364,28 +229,22 @@ static int __init wdt_init(void)
 		goto unreg_regions;
 	}
=20
-	ret =3D misc_register(&wdt_miscdev);
-	if (ret !=3D 0) {
-		pr_err("cannot register miscdev on minor=3D%d (err=3D%d)\n",
-		       WATCHDOG_MINOR, ret);
+	watchdog_set_nowayout(&wdt_dev, nowayout);
+	ret =3D watchdog_register_device(&wdt_dev);
+	if (ret)
 		goto unreg_reboot;
-	}
-
-	pr_info("initialized. timeout=3D%d sec (nowayout=3D%d)\n",
-		timeout, nowayout);
-
-out:
 	return ret;
+
 unreg_reboot:
 	unregister_reboot_notifier(&wdt_notifier);
 unreg_regions:
 	release_region(wdt_io, 1);
-	goto out;
+	return ret;
 }
=20
 static void __exit wdt_exit(void)
 {
-	misc_deregister(&wdt_miscdev);
+	watchdog_unregister_device(&wdt_dev);
 	unregister_reboot_notifier(&wdt_notifier);
 	release_region(wdt_io, 1);
 }
@@ -396,4 +255,3 @@ module_exit(wdt_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("P=C3=A1draig  Brady <P@draigBrady.com>");
 MODULE_DESCRIPTION("w83627hf/thf WDT driver");
-MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
--=20
1.7.9.7

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
