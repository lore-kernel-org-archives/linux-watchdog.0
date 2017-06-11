Return-Path: <linux@roeck-us.net>
Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/5] watchdog: it87: Convert to use watchdog core infrastructure
Date: Sat, 10 Jun 2017 21:04:33 -0700
Message-Id: <1497153876-22921-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1497153876-22921-1-git-send-email-linux@roeck-us.net>
References: <1497153876-22921-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig    |   1 +
 drivers/watchdog/it87_wdt.c | 375 +++++++++-----------------------------------
 2 files changed, 72 insertions(+), 304 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8b9049dac094..20020a4bb71e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1037,6 +1037,7 @@ config IT8712F_WDT
 config IT87_WDT
 	tristate "IT87 Watchdog Timer"
 	depends on X86
+	select WATCHDOG_CORE
 	---help---
 	  This is the driver for the hardware watchdog on the ITE IT8620,
 	  IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726 and IT8728
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 8c847f8c2470..9a6523e70ffc 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -32,26 +32,18 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/miscdevice.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/watchdog.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
-#include <linux/uaccess.h>
 #include <linux/io.h>
 
-
-#define WATCHDOG_VERSION	"1.14"
 #define WATCHDOG_NAME		"IT87 WDT"
-#define DRIVER_VERSION		WATCHDOG_NAME " driver, v" WATCHDOG_VERSION "\n"
-#define WD_MAGIC		'V'
 
 /* Defaults for Module Parameter */
 #define DEFAULT_NOGAMEPORT	0
 #define DEFAULT_NOCIR		0
-#define DEFAULT_EXCLUSIVE	1
 #define DEFAULT_TIMEOUT		60
 #define DEFAULT_TESTMODE	0
 #define DEFAULT_NOWAYOUT	WATCHDOG_NOWAYOUT
@@ -129,23 +121,17 @@
 #define GP_BASE_DEFAULT	0x0201
 
 /* wdt_status */
-#define WDTS_TIMER_RUN	0
-#define WDTS_DEV_OPEN	1
-#define WDTS_KEEPALIVE	2
-#define WDTS_LOCKED	3
-#define WDTS_USE_GP	4
-#define WDTS_EXPECTED	5
-#define WDTS_USE_CIR	6
-
-static	unsigned int base, gpact, ciract, max_units, chip_type;
-static	unsigned long wdt_status;
-
-static	int nogameport = DEFAULT_NOGAMEPORT;
-static int nocir      = DEFAULT_NOCIR;
-static	int exclusive  = DEFAULT_EXCLUSIVE;
-static	int timeout    = DEFAULT_TIMEOUT;
-static	int testmode   = DEFAULT_TESTMODE;
-static	bool nowayout   = DEFAULT_NOWAYOUT;
+#define WDTS_USE_GP	0
+#define WDTS_USE_CIR	1
+
+static unsigned int base, gpact, ciract, max_units, chip_type;
+static unsigned long wdt_status;
+
+static int nogameport  = DEFAULT_NOGAMEPORT;
+static int nocir       = DEFAULT_NOCIR;
+static unsigned int timeout = DEFAULT_TIMEOUT;
+static int testmode    = DEFAULT_TESTMODE;
+static bool nowayout    = DEFAULT_NOWAYOUT;
 
 module_param(nogameport, int, 0);
 MODULE_PARM_DESC(nogameport, "Forbid the activation of game port, default="
@@ -153,9 +139,6 @@ MODULE_PARM_DESC(nogameport, "Forbid the activation of game port, default="
 module_param(nocir, int, 0);
 MODULE_PARM_DESC(nocir, "Forbid the use of Consumer IR interrupts to reset timer, default="
 		__MODULE_STRING(DEFAULT_NOCIR));
-module_param(exclusive, int, 0);
-MODULE_PARM_DESC(exclusive, "Watchdog exclusive device open, default="
-		__MODULE_STRING(DEFAULT_EXCLUSIVE));
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, default="
 		__MODULE_STRING(DEFAULT_TIMEOUT));
@@ -227,7 +210,7 @@ static inline void superio_outw(int val, int reg)
 }
 
 /* Internal function, should be called after superio_select(GPIO) */
-static void wdt_update_timeout(void)
+static void _wdt_update_timeout(void)
 {
 	unsigned char cfg = WDT_KRST;
 	int tm = timeout;
@@ -249,6 +232,21 @@ static void wdt_update_timeout(void)
 		superio_outb(tm>>8, WDTVALMSB);
 }
 
+static int wdt_update_timeout(void)
+{
+	int ret;
+
+	ret = superio_enter();
+	if (ret)
+		return ret;
+
+	superio_select(GPIO);
+	_wdt_update_timeout();
+	superio_exit();
+
+	return 0;
+}
+
 static int wdt_round_time(int t)
 {
 	t += 59;
@@ -258,25 +256,22 @@ static int wdt_round_time(int t)
 
 /* watchdog timer handling */
 
-static void wdt_keepalive(void)
+static int wdt_keepalive(struct watchdog_device *wdd)
 {
+	int ret = 0;
+
 	if (test_bit(WDTS_USE_GP, &wdt_status))
 		inb(base);
 	else if (test_bit(WDTS_USE_CIR, &wdt_status))
 		/* The timer reloads with around 5 msec delay */
 		outb(0x55, CIR_DR(base));
-	else {
-		if (superio_enter())
-			return;
+	else
+		ret = wdt_update_timeout();
 
-		superio_select(GPIO);
-		wdt_update_timeout();
-		superio_exit();
-	}
-	set_bit(WDTS_KEEPALIVE, &wdt_status);
+	return ret;
 }
 
-static int wdt_start(void)
+static int wdt_start(struct watchdog_device *wdd)
 {
 	int ret = superio_enter();
 	if (ret)
@@ -287,14 +282,15 @@ static int wdt_start(void)
 		superio_outb(WDT_GAMEPORT, WDTCTRL);
 	else if (test_bit(WDTS_USE_CIR, &wdt_status))
 		superio_outb(WDT_CIRINT, WDTCTRL);
-	wdt_update_timeout();
+
+	_wdt_update_timeout();
 
 	superio_exit();
 
 	return 0;
 }
 
-static int wdt_stop(void)
+static int wdt_stop(struct watchdog_device *wdd)
 {
 	int ret = superio_enter();
 	if (ret)
@@ -321,280 +317,49 @@ static int wdt_stop(void)
  *	Used within WDIOC_SETTIMEOUT watchdog device ioctl.
  */
 
-static int wdt_set_timeout(int t)
+static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
 {
-	if (t < 1 || t > max_units * 60)
-		return -EINVAL;
+	int ret = 0;
 
 	if (t > max_units)
-		timeout = wdt_round_time(t);
-	else
-		timeout = t;
-
-	if (test_bit(WDTS_TIMER_RUN, &wdt_status)) {
-		int ret = superio_enter();
-		if (ret)
-			return ret;
-
-		superio_select(GPIO);
-		wdt_update_timeout();
-		superio_exit();
-	}
-	return 0;
-}
-
-/**
- *	wdt_get_status - determines the status supported by watchdog ioctl
- *	@status: status returned to user space
- *
- *	The status bit of the device does not allow to distinguish
- *	between a regular system reset and a watchdog forced reset.
- *	But, in test mode it is useful, so it is supported through
- *	WDIOC_GETSTATUS watchdog ioctl. Additionally the driver
- *	reports the keepalive signal and the acception of the magic.
- *
- *	Used within WDIOC_GETSTATUS watchdog device ioctl.
- */
-
-static int wdt_get_status(int *status)
-{
-	*status = 0;
-	if (testmode) {
-		int ret = superio_enter();
-		if (ret)
-			return ret;
-
-		superio_select(GPIO);
-		if (superio_inb(WDTCTRL) & WDT_ZERO) {
-			superio_outb(0x00, WDTCTRL);
-			clear_bit(WDTS_TIMER_RUN, &wdt_status);
-			*status |= WDIOF_CARDRESET;
-		}
-
-		superio_exit();
-	}
-	if (test_and_clear_bit(WDTS_KEEPALIVE, &wdt_status))
-		*status |= WDIOF_KEEPALIVEPING;
-	if (test_bit(WDTS_EXPECTED, &wdt_status))
-		*status |= WDIOF_MAGICCLOSE;
-	return 0;
-}
-
-/* /dev/watchdog handling */
-
-/**
- *	wdt_open - watchdog file_operations .open
- *	@inode: inode of the device
- *	@file: file handle to the device
- *
- *	The watchdog timer starts by opening the device.
- *
- *	Used within the file operation of the watchdog device.
- */
-
-static int wdt_open(struct inode *inode, struct file *file)
-{
-	if (exclusive && test_and_set_bit(WDTS_DEV_OPEN, &wdt_status))
-		return -EBUSY;
-	if (!test_and_set_bit(WDTS_TIMER_RUN, &wdt_status)) {
-		int ret;
-		if (nowayout && !test_and_set_bit(WDTS_LOCKED, &wdt_status))
-			__module_get(THIS_MODULE);
-
-		ret = wdt_start();
-		if (ret) {
-			clear_bit(WDTS_LOCKED, &wdt_status);
-			clear_bit(WDTS_TIMER_RUN, &wdt_status);
-			clear_bit(WDTS_DEV_OPEN, &wdt_status);
-			return ret;
-		}
-	}
-	return nonseekable_open(inode, file);
-}
+		t = wdt_round_time(t);
 
-/**
- *	wdt_release - watchdog file_operations .release
- *	@inode: inode of the device
- *	@file: file handle to the device
- *
- *	Closing the watchdog device either stops the watchdog timer
- *	or in the case, that nowayout is set or the magic character
- *	wasn't written, a critical warning about an running watchdog
- *	timer is given.
- *
- *	Used within the file operation of the watchdog device.
- */
+	wdd->timeout = t;
 
-static int wdt_release(struct inode *inode, struct file *file)
-{
-	if (test_bit(WDTS_TIMER_RUN, &wdt_status)) {
-		if (test_and_clear_bit(WDTS_EXPECTED, &wdt_status)) {
-			int ret = wdt_stop();
-			if (ret) {
-				/*
-				 * Stop failed. Just keep the watchdog alive
-				 * and hope nothing bad happens.
-				 */
-				set_bit(WDTS_EXPECTED, &wdt_status);
-				wdt_keepalive();
-				return ret;
-			}
-			clear_bit(WDTS_TIMER_RUN, &wdt_status);
-		} else {
-			wdt_keepalive();
-			pr_crit("unexpected close, not stopping watchdog!\n");
-		}
-	}
-	clear_bit(WDTS_DEV_OPEN, &wdt_status);
-	return 0;
-}
-
-/**
- *	wdt_write - watchdog file_operations .write
- *	@file: file handle to the watchdog
- *	@buf: buffer to write
- *	@count: count of bytes
- *	@ppos: pointer to the position to write. No seeks allowed
- *
- *	A write to a watchdog device is defined as a keepalive signal. Any
- *	write of data will do, as we don't define content meaning.
- *
- *	Used within the file operation of the watchdog device.
- */
+	if (watchdog_hw_running(wdd))
+		ret = wdt_update_timeout();
 
-static ssize_t wdt_write(struct file *file, const char __user *buf,
-			    size_t count, loff_t *ppos)
-{
-	if (count) {
-		clear_bit(WDTS_EXPECTED, &wdt_status);
-		wdt_keepalive();
-	}
-	if (!nowayout) {
-		size_t ofs;
-
-	/* note: just in case someone wrote the magic character long ago */
-		for (ofs = 0; ofs != count; ofs++) {
-			char c;
-			if (get_user(c, buf + ofs))
-				return -EFAULT;
-			if (c == WD_MAGIC)
-				set_bit(WDTS_EXPECTED, &wdt_status);
-		}
-	}
-	return count;
+	return ret;
 }
 
 static const struct watchdog_info ident = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
-	.firmware_version =	1,
+	.firmware_version = 1,
 	.identity = WATCHDOG_NAME,
 };
 
-/**
- *	wdt_ioctl - watchdog file_operations .unlocked_ioctl
- *	@file: file handle to the device
- *	@cmd: watchdog command
- *	@arg: argument pointer
- *
- *	The watchdog API defines a common set of functions for all watchdogs
- *	according to their available features.
- *
- *	Used within the file operation of the watchdog device.
- */
-
-static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	int rc = 0, status, new_options, new_timeout;
-	union {
-		struct watchdog_info __user *ident;
-		int __user *i;
-	} uarg;
-
-	uarg.i = (int __user *)arg;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(uarg.ident,
-				    &ident, sizeof(ident)) ? -EFAULT : 0;
-
-	case WDIOC_GETSTATUS:
-		rc = wdt_get_status(&status);
-		if (rc)
-			return rc;
-		return put_user(status, uarg.i);
-
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, uarg.i);
-
-	case WDIOC_KEEPALIVE:
-		wdt_keepalive();
-		return 0;
-
-	case WDIOC_SETOPTIONS:
-		if (get_user(new_options, uarg.i))
-			return -EFAULT;
-
-		switch (new_options) {
-		case WDIOS_DISABLECARD:
-			if (test_bit(WDTS_TIMER_RUN, &wdt_status)) {
-				rc = wdt_stop();
-				if (rc)
-					return rc;
-			}
-			clear_bit(WDTS_TIMER_RUN, &wdt_status);
-			return 0;
-
-		case WDIOS_ENABLECARD:
-			if (!test_and_set_bit(WDTS_TIMER_RUN, &wdt_status)) {
-				rc = wdt_start();
-				if (rc) {
-					clear_bit(WDTS_TIMER_RUN, &wdt_status);
-					return rc;
-				}
-			}
-			return 0;
-
-		default:
-			return -EFAULT;
-		}
-
-	case WDIOC_SETTIMEOUT:
-		if (get_user(new_timeout, uarg.i))
-			return -EFAULT;
-		rc = wdt_set_timeout(new_timeout);
-	case WDIOC_GETTIMEOUT:
-		if (put_user(timeout, uarg.i))
-			return -EFAULT;
-		return rc;
+static struct watchdog_ops wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = wdt_start,
+	.stop = wdt_stop,
+	.ping = wdt_keepalive,
+	.set_timeout = wdt_set_timeout,
+};
 
-	default:
-		return -ENOTTY;
-	}
-}
+static struct watchdog_device wdt_dev = {
+	.info = &ident,
+	.ops = &wdt_ops,
+	.min_timeout = 1,
+};
 
 static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
-	void *unused)
+			  void *unused)
 {
 	if (code == SYS_DOWN || code == SYS_HALT)
-		wdt_stop();
+		wdt_stop(&wdt_dev);
 	return NOTIFY_DONE;
 }
 
-static const struct file_operations wdt_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.write		= wdt_write,
-	.unlocked_ioctl	= wdt_ioctl,
-	.open		= wdt_open,
-	.release	= wdt_release,
-};
-
-static struct miscdevice wdt_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &wdt_fops,
-};
-
 static struct notifier_block wdt_notifier = {
 	.notifier_call = wdt_notify_sys,
 };
@@ -708,19 +473,15 @@ static int __init it87_wdt_init(void)
 	if (timeout > max_units)
 		timeout = wdt_round_time(timeout);
 
+	wdt_dev.timeout = timeout;
+	wdt_dev.max_timeout = max_units * 60;
+
 	rc = register_reboot_notifier(&wdt_notifier);
 	if (rc) {
 		pr_err("Cannot register reboot notifier (err=%d)\n", rc);
 		goto err_out_region;
 	}
 
-	rc = misc_register(&wdt_miscdev);
-	if (rc) {
-		pr_err("Cannot register miscdev on minor=%d (err=%d)\n",
-		       wdt_miscdev.minor, rc);
-		goto err_out_reboot;
-	}
-
 	/* Initialize CIR to use it as keepalive source */
 	if (test_bit(WDTS_USE_CIR, &wdt_status)) {
 		outb(0x00, CIR_RCR(base));
@@ -732,9 +493,15 @@ static int __init it87_wdt_init(void)
 		outb(0x09, CIR_IER(base));
 	}
 
-	pr_info("Chip IT%04x revision %d initialized. timeout=%d sec (nowayout=%d testmode=%d exclusive=%d nogameport=%d nocir=%d)\n",
+	rc = watchdog_register_device(&wdt_dev);
+	if (rc) {
+		pr_err("Cannot register watchdog device (err=%d)\n", rc);
+		goto err_out_reboot;
+	}
+
+	pr_info("Chip IT%04x revision %d initialized. timeout=%d sec (nowayout=%d testmode=%d nogameport=%d nocir=%d)\n",
 		chip_type, chip_rev, timeout,
-		nowayout, testmode, exclusive, nogameport, nocir);
+		nowayout, testmode, nogameport, nocir);
 
 	superio_exit();
 	return 0;
@@ -778,7 +545,7 @@ static void __exit it87_wdt_exit(void)
 		superio_exit();
 	}
 
-	misc_deregister(&wdt_miscdev);
+	watchdog_unregister_device(&wdt_dev);
 	unregister_reboot_notifier(&wdt_notifier);
 
 	if (test_bit(WDTS_USE_GP, &wdt_status))
-- 
2.7.4
