Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail132.messagelabs.com ([216.82.242.115]:31288 "EHLO
	mail132.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab1HDVhs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Aug 2011 17:37:48 -0400
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3] watchdog: ep93xx: Use the WatchDog Timer Driver Core.
Date: Thu, 4 Aug 2011 14:37:02 -0700
CC: <linux-watchdog@vger.kernel.org>, <wim@iguana.be>,
	<mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-ID: <201108041437.03091.hartleys@visionengravers.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Convert the ep93xx watchdog driver to using the WatchDog Timer Driver Cor=
e.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

---

v3: reorder the code so that the #defines follow the #includes
    fix the namespace for some of the #defines
    remove WDIOF_CARDRESET from the watchdog_info options
      (this is a status flag not an options flag)
    hookup the nowayout module parameter to the status bit
      WDOG_NO_WAY_OUT
    reorder the code so that the relationship between the internal
      timer ping and the watchdog ping is more obvious

v2: use the pr_* functions instead of printk(KERN_* PFX
=C2=A0 =C2=A0 document the register magic numbers and bits
=C2=A0 =C2=A0 fold the register access functions into the callers
=C2=A0 =C2=A0 add WDIOF_KEEPALIVEPING to the options
=C2=A0 =C2=A0 fix the bootstatus use, any detected reset is reported as W=
DIOF_CARDRESET
=C2=A0 =C2=A0 add a boot message so the user can see what actually caused=
 the reset
=C2=A0 =C2=A0 validate that the user's requested timeout is actually vali=
d
=C2=A0 =C2=A0 fix a typo in the v1 patch (extra void in ep93xx_wdt_start)
=C2=A0 =C2=A0 fix ep93xx_wdt_exit, ep93xx_wdt_stop should be called not w=
dt_shutdown

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 86b0735..55fa024 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -215,6 +215,7 @@ config MPCORE_WATCHDOG
 config EP93XX_WATCHDOG
 	tristate "EP93xx Watchdog"
 	depends on ARCH_EP93XX
+	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
 	  embedded in the Cirrus Logic EP93xx family of devices.
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.=
c
index 726b7df..8de71da 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -23,233 +23,158 @@
  *	- Add a few missing ioctls
  */
=20
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
-#include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/timer.h>
-#include <linux/uaccess.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
=20
-#define WDT_VERSION	"0.3"
-#define PFX		"ep93xx_wdt: "
-
-/* default timeout (secs) */
-#define WDT_TIMEOUT 30
-
-static int nowayout =3D WATCHDOG_NOWAYOUT;
-static int timeout =3D WDT_TIMEOUT;
-
-static struct timer_list timer;
-static unsigned long next_heartbeat;
-static unsigned long wdt_status;
-static unsigned long boot_status;
-
-#define WDT_IN_USE		0
-#define WDT_OK_TO_CLOSE		1
-
 #define EP93XX_WDT_REG(x)	(EP93XX_WATCHDOG_BASE + (x))
 #define EP93XX_WDT_WATCHDOG	EP93XX_WDT_REG(0x00)
 #define EP93XX_WDT_WDSTATUS	EP93XX_WDT_REG(0x04)
=20
+/* Watchdog register write only values */
+#define EP93XX_WATCHDOG_RESTART		0x5555
+#define EP93XX_WATCHDOG_DISABLE		0xaa55
+#define EP93XX_WATCHDOG_ENABLE		0xaaaa
+
+/* Watchdog register read only bits */
+#define EP93XX_WATCHDOG_PLSDSN		(1 << 6)
+#define EP93XX_WATCHDOG_OVRID		(1 << 5)
+#define EP93XX_WATCHDOG_SWDIS		(1 << 4)
+#define EP93XX_WATCHDOG_HWDIS		(1 << 3)
+#define EP93XX_WATCHDOG_URST		(1 << 2)
+#define EP93XX_WATCHDOG_3KRST		(1 << 1)
+#define EP93XX_WATCHDOG_WD		(1 << 0)
+#define EP93XX_WATCHDOG_RESET_MASK	(0x07)
+
 /* reset the wdt every ~200ms */
-#define WDT_INTERVAL (HZ/5)
+#define EP93XX_WATCHDOG_INTERVAL	(HZ/5)
=20
-static void wdt_enable(void)
-{
-	__raw_writew(0xaaaa, EP93XX_WDT_WATCHDOG);
-}
+/* default timeout (secs) */
+#define EP93XX_WATCHDOG_TIMEOUT		30
=20
-static void wdt_disable(void)
-{
-	__raw_writew(0xaa55, EP93XX_WDT_WATCHDOG);
-}
+#define EP93XX_WATCHDOG_VERSION		"0.3"
=20
-static inline void wdt_ping(void)
-{
-	__raw_writew(0x5555, EP93XX_WDT_WATCHDOG);
-}
+static int nowayout =3D WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
=20
-static void wdt_startup(void)
-{
-	next_heartbeat =3D jiffies + (timeout * HZ);
+static int timeout =3D EP93XX_WATCHDOG_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in seconds. (1<=3Dtimeout<=3D3600, default=3D"
+			__MODULE_STRING(EP93XX_WATCHDOG_TIMEOUT) ")");
=20
-	wdt_enable();
-	mod_timer(&timer, jiffies + WDT_INTERVAL);
-}
+static struct timer_list timer;
+static unsigned long next_heartbeat;
=20
-static void wdt_shutdown(void)
+static void ep93xx_timer_ping(unsigned long data)
 {
-	del_timer_sync(&timer);
-	wdt_disable();
+	if (time_before(jiffies, next_heartbeat))
+		__raw_writew(EP93XX_WATCHDOG_RESTART, EP93XX_WDT_WATCHDOG);
+
+	/* Re-set the timer interval */
+	mod_timer(&timer, jiffies + EP93XX_WATCHDOG_INTERVAL);
 }
=20
-static void wdt_keepalive(void)
+static int ep93xx_wdt_keepalive(struct watchdog_device *wdd)
 {
 	/* user land ping */
-	next_heartbeat =3D jiffies + (timeout * HZ);
+	next_heartbeat =3D jiffies + (wdd->timeout * HZ);
+	return 0;
 }
=20
-static int ep93xx_wdt_open(struct inode *inode, struct file *file)
+static int ep93xx_wdt_start(struct watchdog_device *wdd)
 {
-	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
-		return -EBUSY;
-
-	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
-
-	wdt_startup();
-
-	return nonseekable_open(inode, file);
+	ep93xx_wdt_keepalive(wdd);
+	__raw_writew(EP93XX_WATCHDOG_ENABLE, EP93XX_WDT_WATCHDOG);
+	mod_timer(&timer, jiffies + EP93XX_WATCHDOG_INTERVAL);
+	return 0;
 }
=20
-static ssize_t
-ep93xx_wdt_write(struct file *file, const char __user *data, size_t len,
-		 loff_t *ppos)
+static int ep93xx_wdt_stop(struct watchdog_device *wdd)
 {
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
-
-			for (i =3D 0; i !=3D len; i++) {
-				char c;
-
-				if (get_user(c, data + i))
-					return -EFAULT;
-
-				if (c =3D=3D 'V')
-					set_bit(WDT_OK_TO_CLOSE, &wdt_status);
-				else
-					clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
-			}
-		}
-		wdt_keepalive();
-	}
-
-	return len;
+	del_timer_sync(&timer);
+	__raw_writew(EP93XX_WATCHDOG_DISABLE, EP93XX_WDT_WATCHDOG);
+	return 0;
 }
=20
-static const struct watchdog_info ident =3D {
-	.options =3D WDIOF_CARDRESET | WDIOF_MAGICCLOSE,
-	.identity =3D "EP93xx Watchdog",
+static const struct watchdog_info ep93xx_wdt_ident =3D {
+	.options	=3D WDIOF_MAGICCLOSE |
+			  WDIOF_KEEPALIVEPING,
+	.identity	=3D "EP93xx Watchdog",
 };
=20
-static long ep93xx_wdt_ioctl(struct file *file,
-					unsigned int cmd, unsigned long arg)
-{
-	int ret =3D -ENOTTY;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		ret =3D copy_to_user((struct watchdog_info __user *)arg, &ident,
-				sizeof(ident)) ? -EFAULT : 0;
-		break;
-
-	case WDIOC_GETSTATUS:
-		ret =3D put_user(0, (int __user *)arg);
-		break;
-
-	case WDIOC_GETBOOTSTATUS:
-		ret =3D put_user(boot_status, (int __user *)arg);
-		break;
-
-	case WDIOC_KEEPALIVE:
-		wdt_keepalive();
-		ret =3D 0;
-		break;
-
-	case WDIOC_GETTIMEOUT:
-		/* actually, it is 0.250 seconds.... */
-		ret =3D put_user(1, (int __user *)arg);
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
-		printk(KERN_CRIT PFX
-			"Device closed unexpectedly - timer will not stop\n");
-
-	clear_bit(WDT_IN_USE, &wdt_status);
-	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
-
-	return 0;
-}
-
-static const struct file_operations ep93xx_wdt_fops =3D {
+static const struct watchdog_ops ep93xx_wdt_ops =3D {
 	.owner		=3D THIS_MODULE,
-	.write		=3D ep93xx_wdt_write,
-	.unlocked_ioctl	=3D ep93xx_wdt_ioctl,
-	.open		=3D ep93xx_wdt_open,
-	.release	=3D ep93xx_wdt_release,
-	.llseek		=3D no_llseek,
+	.start		=3D ep93xx_wdt_start,
+	.stop		=3D ep93xx_wdt_stop,
+	.ping		=3D ep93xx_wdt_keepalive,
 };
=20
-static struct miscdevice ep93xx_wdt_miscdev =3D {
-	.minor		=3D WATCHDOG_MINOR,
-	.name		=3D "watchdog",
-	.fops		=3D &ep93xx_wdt_fops,
+static struct watchdog_device ep93xx_wdd =3D {
+	.info		=3D &ep93xx_wdt_ident,
+	.ops		=3D &ep93xx_wdt_ops,
+	.min_timeout	=3D 1,
+	.max_timeout	=3D 3600,
 };
=20
-static void ep93xx_timer_ping(unsigned long data)
-{
-	if (time_before(jiffies, next_heartbeat))
-		wdt_ping();
-
-	/* Re-set the timer interval */
-	mod_timer(&timer, jiffies + WDT_INTERVAL);
-}
-
 static int __init ep93xx_wdt_init(void)
 {
+	int v;
 	int err;
=20
-	err =3D misc_register(&ep93xx_wdt_miscdev);
+	v =3D readl(EP93XX_WDT_WATCHDOG);
+	ep93xx_wdd.bootstatus =3D (v & EP93XX_WATCHDOG_RESET_MASK)
+				? WDIOF_CARDRESET : 0;
+	if (ep93xx_wdd.bootstatus) {
+		/* Only a power-on-reset will clear these bits */
+		pr_info("Last reset was due to %s%s%s\n",
+			(v & EP93XX_WATCHDOG_WD) ? "- watchdog timeout " : "",
+			(v & EP93XX_WATCHDOG_3KRST) ? "- 3-key reset " : "",
+			(v & EP93XX_WATCHDOG_URST) ? "- user reset" : "");
+	}
=20
-	boot_status =3D __raw_readl(EP93XX_WDT_WATCHDOG) & 0x01 ? 1 : 0;
+	if (timeout < ep93xx_wdd.min_timeout ||
+	    timeout > ep93xx_wdd.max_timeout) {
+		ep93xx_wdd.timeout =3D EP93XX_WATCHDOG_TIMEOUT;
+		pr_info("timeout value must be %d<=3Dx<=3D%d, using %d\n",
+			ep93xx_wdd.min_timeout, ep93xx_wdd.max_timeout,
+			ep93xx_wdd.timeout);
+	} else {
+		ep93xx_wdd.timeout =3D timeout;
+	}
=20
-	printk(KERN_INFO PFX "EP93XX watchdog, driver version "
-		WDT_VERSION "%s\n",
-		(__raw_readl(EP93XX_WDT_WATCHDOG) & 0x08)
-		? " (nCS1 disable detected)" : "");
+	if (nowayout)
+		set_bit(WDOG_NO_WAY_OUT, &ep93xx_wdd.status);
=20
-	if (timeout < 1 || timeout > 3600) {
-		timeout =3D WDT_TIMEOUT;
-		printk(KERN_INFO PFX
-			"timeout value must be 1<=3Dx<=3D3600, using %d\n",
-			timeout);
-	}
+	err =3D watchdog_register_device(&ep93xx_wdd);
+	if (err)
+		return err;
=20
 	setup_timer(&timer, ep93xx_timer_ping, 1);
-	return err;
+
+	pr_info("EP93XX watchdog, driver v" EP93XX_WATCHDOG_VERSION "%s\n",
+		(v & EP93XX_WATCHDOG_HWDIS) ? " (nCS1 disable detected)" : "");
+
+	return 0;
 }
+module_init(ep93xx_wdt_init);
=20
 static void __exit ep93xx_wdt_exit(void)
 {
-	wdt_shutdown();
-	misc_deregister(&ep93xx_wdt_miscdev);
+	ep93xx_wdt_stop(&ep93xx_wdd);
+	watchdog_unregister_device(&ep93xx_wdd);
 }
-
-module_init(ep93xx_wdt_init);
 module_exit(ep93xx_wdt_exit);
=20
-module_param(nowayout, int, 0);
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
-
-module_param(timeout, int, 0);
-MODULE_PARM_DESC(timeout,
-	"Watchdog timeout in seconds. (1<=3Dtimeout<=3D3600, default=3D"
-				__MODULE_STRING(WDT_TIMEOUT) ")");
-
 MODULE_AUTHOR("Ray Lehtiniemi <rayl@mail.com>,"
 		"Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("EP93xx Watchdog");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(WDT_VERSION);
+MODULE_VERSION(EP93XX_WATCHDOG_VERSION);
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
