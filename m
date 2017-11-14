Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v3 1/2] watchdog: xen_wdt: use the watchdog subsystem
Date: Tue, 14 Nov 2017 16:23:49 +0000
Message-Id: <20171114162350.24283-2-rrendec@arista.com>
In-Reply-To: <20171114162350.24283-1-rrendec@arista.com>
References: <20171114162350.24283-1-rrendec@arista.com>
List-ID: <linux-watchdog@vger.kernel.org>

Change the xen_wdt driver to use the watchdog subsystem instead of
registering and manipulating the char device directly through the misc
API. This is mainly getting rid of the "write" and "ioctl" methods and
part of the watchdog control logic (which are all implemented by the
watchdog subsystem).

Even though the watchdog subsystem supports registering and handling
multiple watchdog devices at the same time, the xen_wdt driver has an
inherent limitation of only one device due to the way the Xen hypervisor
exposes watchdog functionality. However, the driver can now coexist with
other watchdog devices (supported by different drivers).

Signed-off-by: Radu Rendec <rrendec@arista.com>
---
 drivers/watchdog/xen_wdt.c | 254 +++++++++++----------------------------------
 1 file changed, 59 insertions(+), 195 deletions(-)

diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index 5dd5c3494d55..4e00419bd47d 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -9,9 +9,8 @@
  *	2 of the License, or (at your option) any later version.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#define DRV_NAME	"wdt"
+#define DRV_NAME	"xen_wdt"
+#define DEV_NAME	"watchdog"
 #define DRV_VERSION	"0.01"
 
 #include <linux/bug.h>
@@ -21,25 +20,20 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/init.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <xen/xen.h>
 #include <asm/xen/hypercall.h>
 #include <xen/interface/sched.h>
 
 static struct platform_device *platform_device;
-static DEFINE_SPINLOCK(wdt_lock);
 static struct sched_watchdog wdt;
 static time64_t wdt_expires;
-static bool is_active, expect_release;
 
 #define WATCHDOG_TIMEOUT 60 /* in seconds */
-static unsigned int timeout = WATCHDOG_TIMEOUT;
+static unsigned int timeout;
 module_param(timeout, uint, S_IRUGO);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
 	"(default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
@@ -49,20 +43,18 @@ module_param(nowayout, bool, S_IRUGO);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static inline time64_t set_timeout(void)
+static inline time64_t set_timeout(struct watchdog_device *wdd)
 {
-	wdt.timeout = timeout;
-	return ktime_get_seconds() + timeout;
+	wdt.timeout = wdd->timeout;
+	return ktime_get_seconds() + wdd->timeout;
 }
 
-static int xen_wdt_start(void)
+static int xen_wdt_start(struct watchdog_device *wdd)
 {
 	time64_t expires;
 	int err;
 
-	spin_lock(&wdt_lock);
-
-	expires = set_timeout();
+	expires = set_timeout(wdd);
 	if (!wdt.id)
 		err = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wdt);
 	else
@@ -74,36 +66,28 @@ static int xen_wdt_start(void)
 	} else
 		BUG_ON(!err);
 
-	spin_unlock(&wdt_lock);
-
 	return err;
 }
 
-static int xen_wdt_stop(void)
+static int xen_wdt_stop(struct watchdog_device *wdd)
 {
 	int err = 0;
 
-	spin_lock(&wdt_lock);
-
 	wdt.timeout = 0;
 	if (wdt.id)
 		err = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wdt);
 	if (!err)
 		wdt.id = 0;
 
-	spin_unlock(&wdt_lock);
-
 	return err;
 }
 
-static int xen_wdt_kick(void)
+static int xen_wdt_kick(struct watchdog_device *wdd)
 {
 	time64_t expires;
 	int err;
 
-	spin_lock(&wdt_lock);
-
-	expires = set_timeout();
+	expires = set_timeout(wdd);
 	if (wdt.id)
 		err = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wdt);
 	else
@@ -111,195 +95,72 @@ static int xen_wdt_kick(void)
 	if (!err)
 		wdt_expires = expires;
 
-	spin_unlock(&wdt_lock);
-
 	return err;
 }
 
-static int xen_wdt_open(struct inode *inode, struct file *file)
-{
-	int err;
-
-	/* /dev/watchdog can only be opened once */
-	if (xchg(&is_active, true))
-		return -EBUSY;
-
-	err = xen_wdt_start();
-	if (err == -EBUSY)
-		err = xen_wdt_kick();
-	return err ?: nonseekable_open(inode, file);
-}
-
-static int xen_wdt_release(struct inode *inode, struct file *file)
+static unsigned int xen_wdt_get_timeleft(struct watchdog_device *wdd)
 {
-	int err = 0;
-
-	if (expect_release)
-		err = xen_wdt_stop();
-	else {
-		pr_crit("unexpected close, not stopping watchdog!\n");
-		xen_wdt_kick();
-	}
-	is_active = err;
-	expect_release = false;
-	return err;
+	return wdt_expires - ktime_get_seconds();
 }
 
-static ssize_t xen_wdt_write(struct file *file, const char __user *data,
-			     size_t len, loff_t *ppos)
-{
-	/* See if we got the magic character 'V' and reload the timer */
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			/* in case it was set long ago */
-			expect_release = false;
-
-			/* scan to see whether or not we got the magic
-			   character */
-			for (i = 0; i != len; i++) {
-				char c;
-				if (get_user(c, data + i))
-					return -EFAULT;
-				if (c == 'V')
-					expect_release = true;
-			}
-		}
-
-		/* someone wrote to us, we should reload the timer */
-		xen_wdt_kick();
-	}
-	return len;
-}
-
-static long xen_wdt_ioctl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
-{
-	int new_options, retval = -EINVAL;
-	int new_timeout;
-	int __user *argp = (void __user *)arg;
-	static const struct watchdog_info ident = {
-		.options =		WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
-		.firmware_version =	0,
-		.identity =		DRV_NAME,
-	};
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, argp);
-
-	case WDIOC_SETOPTIONS:
-		if (get_user(new_options, argp))
-			return -EFAULT;
-
-		if (new_options & WDIOS_DISABLECARD)
-			retval = xen_wdt_stop();
-		if (new_options & WDIOS_ENABLECARD) {
-			retval = xen_wdt_start();
-			if (retval == -EBUSY)
-				retval = xen_wdt_kick();
-		}
-		return retval;
-
-	case WDIOC_KEEPALIVE:
-		xen_wdt_kick();
-		return 0;
-
-	case WDIOC_SETTIMEOUT:
-		if (get_user(new_timeout, argp))
-			return -EFAULT;
-		if (!new_timeout)
-			return -EINVAL;
-		timeout = new_timeout;
-		xen_wdt_kick();
-		/* fall through */
-	case WDIOC_GETTIMEOUT:
-		return put_user(timeout, argp);
-
-	case WDIOC_GETTIMELEFT:
-		retval = wdt_expires - ktime_get_seconds();
-		return put_user(retval, argp);
-	}
-
-	return -ENOTTY;
-}
+static struct watchdog_info xen_wdt_info = {
+	.identity = DRV_NAME,
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
 
-static const struct file_operations xen_wdt_fops = {
-	.owner =		THIS_MODULE,
-	.llseek =		no_llseek,
-	.write =		xen_wdt_write,
-	.unlocked_ioctl =	xen_wdt_ioctl,
-	.open =			xen_wdt_open,
-	.release =		xen_wdt_release,
+static const struct watchdog_ops xen_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = xen_wdt_start,
+	.stop = xen_wdt_stop,
+	.ping = xen_wdt_kick,
+	.get_timeleft = xen_wdt_get_timeleft,
 };
 
-static struct miscdevice xen_wdt_miscdev = {
-	.minor =	WATCHDOG_MINOR,
-	.name =		"watchdog",
-	.fops =		&xen_wdt_fops,
+static struct watchdog_device xen_wdt_dev = {
+	.info = &xen_wdt_info,
+	.ops = &xen_wdt_ops,
+	.timeout = WATCHDOG_TIMEOUT,
 };
 
-static int xen_wdt_probe(struct platform_device *dev)
+static int xen_wdt_probe(struct platform_device *pdev)
 {
 	struct sched_watchdog wd = { .id = ~0 };
 	int ret = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wd);
 
-	switch (ret) {
-	case -EINVAL:
-		if (!timeout) {
-			timeout = WATCHDOG_TIMEOUT;
-			pr_info("timeout value invalid, using %d\n", timeout);
-		}
-
-		ret = misc_register(&xen_wdt_miscdev);
-		if (ret) {
-			pr_err("cannot register miscdev on minor=%d (%d)\n",
-			       WATCHDOG_MINOR, ret);
-			break;
-		}
-
-		pr_info("initialized (timeout=%ds, nowayout=%d)\n",
-			timeout, nowayout);
-		break;
-
-	case -ENOSYS:
-		pr_info("not supported\n");
-		ret = -ENODEV;
-		break;
-
-	default:
-		pr_info("bogus return value %d\n", ret);
-		break;
+	if (ret == -ENOSYS) {
+		dev_err(&pdev->dev, "watchdog not supported by hypervisor\n");
+		return -ENODEV;
 	}
 
-	return ret;
-}
+	if (ret != -EINVAL) {
+		dev_err(&pdev->dev, "unexpected hypervisor error (%d)\n", ret);
+		return -ENODEV;
+	}
 
-static int xen_wdt_remove(struct platform_device *dev)
-{
-	/* Stop the timer before we leave */
-	if (!nowayout)
-		xen_wdt_stop();
+	if (watchdog_init_timeout(&xen_wdt_dev, timeout, NULL))
+		dev_info(&pdev->dev, "timeout value invalid, using %d\n",
+			xen_wdt_dev.timeout);
+	watchdog_set_nowayout(&xen_wdt_dev, nowayout);
+	watchdog_stop_on_reboot(&xen_wdt_dev);
+	watchdog_stop_on_unregister(&xen_wdt_dev);
+
+	ret = devm_watchdog_register_device(&pdev->dev, &xen_wdt_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot register watchdog device (%d)\n",
+			ret);
+		return ret;
+	}
 
-	misc_deregister(&xen_wdt_miscdev);
+	dev_info(&pdev->dev, "initialized (timeout=%ds, nowayout=%d)\n",
+		xen_wdt_dev.timeout, nowayout);
 
 	return 0;
 }
 
-static void xen_wdt_shutdown(struct platform_device *dev)
-{
-	xen_wdt_stop();
-}
-
 static int xen_wdt_suspend(struct platform_device *dev, pm_message_t state)
 {
 	typeof(wdt.id) id = wdt.id;
-	int rc = xen_wdt_stop();
+	int rc = xen_wdt_stop(&xen_wdt_dev);
 
 	wdt.id = id;
 	return rc;
@@ -310,18 +171,22 @@ static int xen_wdt_resume(struct platform_device *dev)
 	if (!wdt.id)
 		return 0;
 	wdt.id = 0;
-	return xen_wdt_start();
+	return xen_wdt_start(&xen_wdt_dev);
 }
 
+static const struct platform_device_id xen_wdt_id_table[] = {
+	{ .name	= DEV_NAME },
+	{}
+};
+
 static struct platform_driver xen_wdt_driver = {
 	.probe          = xen_wdt_probe,
-	.remove         = xen_wdt_remove,
-	.shutdown       = xen_wdt_shutdown,
 	.suspend        = xen_wdt_suspend,
 	.resume         = xen_wdt_resume,
 	.driver         = {
 		.name   = DRV_NAME,
 	},
+	.id_table       = xen_wdt_id_table,
 };
 
 static int __init xen_wdt_init_module(void)
@@ -337,7 +202,7 @@ static int __init xen_wdt_init_module(void)
 	if (err)
 		return err;
 
-	platform_device = platform_device_register_simple(DRV_NAME,
+	platform_device = platform_device_register_simple(DEV_NAME,
 								  -1, NULL, 0);
 	if (IS_ERR(platform_device)) {
 		err = PTR_ERR(platform_device);
@@ -351,7 +216,6 @@ static void __exit xen_wdt_cleanup_module(void)
 {
 	platform_device_unregister(platform_device);
 	platform_driver_unregister(&xen_wdt_driver);
-	pr_info("module unloaded\n");
 }
 
 module_init(xen_wdt_init_module);
-- 
2.13.6
