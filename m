Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB6481672;
	Wed,  6 May 2026 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078611; cv=none; b=TFXDPHlwbIs/0iAkD+Ali1nsylNai2S5BcaSpjl9bqE4zhgbqKCd1EDEky4UMOwX/Od2q+xAF/L9m6ljVejtg9pLpp8cnzS1TtCHaMOvXvtebw/OIvAPkdtSqDFWUJplt+faZ0AZov+yFQbNJaWo5NuHkWz2aHlzrifEAwFF3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078611; c=relaxed/simple;
	bh=6d9F+pJci21rx/PgvsDV0n4eVOiHg0n3rX/welKGutg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRGt3Lo0CB6kZfl0yZ7TkLw1XQjONSkdsXoBEyMajkWQ78seziRaFlAz+Ipur9mnSibfeS/EF8bYW/BAnFkJM8pfOKkMBEaTCKyPrSBNSJMDU5/4suTb+NU1mU18M71vvcX1zk/uUYszps45BqnNlkmPDEHA0nT+XKkVYGqniJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=c+WEFXxj; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=HQrfukeb; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="c+WEFXxj";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="HQrfukeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1778078607; bh=6d9F+pJci21rx/PgvsDV0n4eVOiHg0n3rX/welKGutg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+WEFXxjFy1t52H+xSgoZKl8Ry4UzrjgXnVtXD0z+8VAmPi+QSchclZzuJWPvt74h
	 2tGG8KI9/I2o4NzhB607MV9B3RNpxz/nggMVT2wqoupOAPBUaN3eLRcr0Qz+3Hdjqr
	 RLpC7TKakItV34DgST8gWZKW/zAyJ6Q0RzkC8qCEM8hi829vQbUegpJ9O1vUP1jMIO
	 IIp0TULsxUZEvPeP9jRv98aapmqB0vS2roI5qL1bziRMKSZeRqF/uFGYTi7U8C1I9g
	 6Ox+YVCYg3uHyW4qRW/aVIrZArVENBqdZ2s0Z4iANT7K10i5z7vhSJmBh72Xo7Uyql
	 Ka1xOEYnmOYvQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id EAD6A41CDE; Wed, 06 May 2026 15:43:27 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1778078591; bh=6d9F+pJci21rx/PgvsDV0n4eVOiHg0n3rX/welKGutg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQrfukeb0e+hloXa9AS8KjoT8CbZANeOZzDvoTBnBObeKuOznToRgR9mnHdam2dzi
	 IoRIsKLuVIHwwQdQbJj5MbZGE/9YMGHpJnYP4MRVhxT5Ka+1Cgv21r4WpJ2gXpJRU9
	 VXXgufKSE+rLGpcYVaqzpMFVLVyLvIUb2wnQtRQeyOOIjU+8bY5vKXZOPCI5NZqpVx
	 Q0RYouIirhqwAy2jUiuagL//AviXvFnF3UZpB+8Jr8QHNpjRz2ag1O3Kw9W4aRITqW
	 FtswzzQiCy0zmXTHioUmbhZkUT46uQYPQ2tdvCgNMgkcIlzSpmPvpPa2t0ZGwid4dk
	 NoS4018ioNyOw==
Received: from maru.local (unknown [140.228.74.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id A1BE040154;
	Wed, 06 May 2026 15:43:11 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 6/8] watchdog: sc520: Drop AMD Elan SC520 support
Date: Wed,  6 May 2026 15:42:51 +0100
Message-ID: <59c97749c14a4ad1039bb9cc920cf32babb9d6f7.1778071745.git.sean@mess.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778071745.git.sean@mess.org>
References: <cover.1778071745.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
this board is no longer supported. Remove the watchdog too.

Signed-off-by: Sean Young <sean@mess.org>
---
 .../watchdog/watchdog-parameters.rst          |   9 -
 drivers/watchdog/Kconfig                      |  13 -
 drivers/watchdog/Makefile                     |   1 -
 drivers/watchdog/sc520_wdt.c                  | 430 ------------------
 4 files changed, 453 deletions(-)
 delete mode 100644 drivers/watchdog/sc520_wdt.c

diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
index 773241ed9986..638b972e0b16 100644
--- a/Documentation/watchdog/watchdog-parameters.rst
+++ b/Documentation/watchdog/watchdog-parameters.rst
@@ -532,15 +532,6 @@ sc1200wdt:
 
 -------------------------------------------------
 
-sc520_wdt:
-    timeout:
-	Watchdog timeout in seconds. (1 <= timeout <= 3600, default=30)
-    nowayout:
-	Watchdog cannot be stopped once started
-	(default=kernel config parameter)
-
--------------------------------------------------
-
 sch311x_wdt:
     force_id:
 	Override the detected device ID
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5..4e36e4b5bf39 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1270,19 +1270,6 @@ config GEODE_WDT
 	  You can compile this driver directly into the kernel, or use
 	  it as a module.  The module will be called geodewdt.
 
-config SC520_WDT
-	tristate "AMD Elan SC520 processor Watchdog"
-	depends on MELAN || COMPILE_TEST
-	help
-	  This is the driver for the hardware watchdog built in to the
-	  AMD "Elan" SC520 microcomputer commonly used in embedded systems.
-	  This watchdog simply watches your kernel to make sure it doesn't
-	  freeze, and if it does, it reboots your computer after a certain
-	  amount of time.
-
-	  You can compile this driver directly into the kernel, or use
-	  it as a module.  The module will be called sc520_wdt.
-
 config SBC_FITPC2_WATCHDOG
 	tristate "Compulab SBC-FITPC2 watchdog"
 	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index d2fb16b9f9ce..1daeab5b2473 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -116,7 +116,6 @@ obj-$(CONFIG_EXAR_WDT) += exar_wdt.o
 obj-$(CONFIG_F71808E_WDT) += f71808e_wdt.o
 obj-$(CONFIG_SP5100_TCO) += sp5100_tco.o
 obj-$(CONFIG_GEODE_WDT) += geodewdt.o
-obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
 obj-$(CONFIG_SBC_FITPC2_WATCHDOG) += sbc_fitpc2_wdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_IB700_WDT) += ib700wdt.o
diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
deleted file mode 100644
index 005f62e4a4fb..000000000000
--- a/drivers/watchdog/sc520_wdt.c
+++ /dev/null
@@ -1,430 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *	AMD Elan SC520 processor Watchdog Timer driver
- *
- *	Based on acquirewdt.c by Alan Cox,
- *	     and sbc60xxwdt.c by Jakob Oestergaard <jakob@unthought.net>
- *
- *	The authors do NOT admit liability nor provide warranty for
- *	any of this software. This material is provided "AS-IS" in
- *	the hope that it may be useful for others.
- *
- *	(c) Copyright 2001    Scott Jennings <linuxdrivers@oro.net>
- *           9/27 - 2001      [Initial release]
- *
- *	Additional fixes Alan Cox
- *	-	Fixed formatting
- *	-	Removed debug printks
- *	-	Fixed SMP built kernel deadlock
- *	-	Switched to private locks not lock_kernel
- *	-	Used ioremap/writew/readw
- *	-	Added NOWAYOUT support
- *	4/12 - 2002 Changes by Rob Radez <rob@osinvestor.com>
- *	-	Change comments
- *	-	Eliminate fop_llseek
- *	-	Change CONFIG_WATCHDOG_NOWAYOUT semantics
- *	-	Add KERN_* tags to printks
- *	-	fix possible wdt_is_open race
- *	-	Report proper capabilities in watchdog_info
- *	-	Add WDIOC_{GETSTATUS, GETBOOTSTATUS, SETTIMEOUT,
- *		GETTIMEOUT, SETOPTIONS} ioctls
- *	09/8 - 2003 Changes by Wim Van Sebroeck <wim@iguana.be>
- *	-	cleanup of trailing spaces
- *	-	added extra printk's for startup problems
- *	-	use module_param
- *	-	made timeout (the emulated heartbeat) a module_param
- *	-	made the keepalive ping an internal subroutine
- *	3/27 - 2004 Changes by Sean Young <sean@mess.org>
- *	-	set MMCR_BASE to 0xfffef000
- *	-	CBAR does not need to be read
- *	-	removed debugging printks
- *
- *  This WDT driver is different from most other Linux WDT
- *  drivers in that the driver will ping the watchdog by itself,
- *  because this particular WDT has a very short timeout (1.6
- *  seconds) and it would be insane to count on any userspace
- *  daemon always getting scheduled within that time frame.
- *
- *  This driver uses memory mapped IO, and spinlock.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/timer.h>
-#include <linux/miscdevice.h>
-#include <linux/watchdog.h>
-#include <linux/fs.h>
-#include <linux/ioport.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/jiffies.h>
-#include <linux/io.h>
-#include <linux/uaccess.h>
-
-
-/*
- * The AMD Elan SC520 timeout value is 492us times a power of 2 (0-7)
- *
- *   0: 492us    2: 1.01s    4: 4.03s   6: 16.22s
- *   1: 503ms    3: 2.01s    5: 8.05s   7: 32.21s
- *
- * We will program the SC520 watchdog for a timeout of 2.01s.
- * If we reset the watchdog every ~250ms we should be safe.
- */
-
-#define WDT_INTERVAL (HZ/4+1)
-
-/*
- * We must not require too good response from the userspace daemon.
- * Here we require the userspace daemon to send us a heartbeat
- * char to /dev/watchdog every 30 seconds.
- */
-
-#define WATCHDOG_TIMEOUT 30		/* 30 sec default timeout */
-/* in seconds, will be multiplied by HZ to get seconds to wait for a ping */
-static int timeout = WATCHDOG_TIMEOUT;
-module_param(timeout, int, 0);
-MODULE_PARM_DESC(timeout,
-	"Watchdog timeout in seconds. (1 <= timeout <= 3600, default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
-
-static bool nowayout = WATCHDOG_NOWAYOUT;
-module_param(nowayout, bool, 0);
-MODULE_PARM_DESC(nowayout,
-		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-
-/*
- * AMD Elan SC520 - Watchdog Timer Registers
- */
-#define MMCR_BASE	0xfffef000	/* The default base address */
-#define OFFS_WDTMRCTL	0xCB0	/* Watchdog Timer Control Register */
-
-/* WDT Control Register bit definitions */
-#define WDT_EXP_SEL_01	0x0001	/* [01] Time-out = 496 us (with 33 Mhz clk). */
-#define WDT_EXP_SEL_02	0x0002	/* [02] Time-out = 508 ms (with 33 Mhz clk). */
-#define WDT_EXP_SEL_03	0x0004	/* [03] Time-out = 1.02 s (with 33 Mhz clk). */
-#define WDT_EXP_SEL_04	0x0008	/* [04] Time-out = 2.03 s (with 33 Mhz clk). */
-#define WDT_EXP_SEL_05	0x0010	/* [05] Time-out = 4.07 s (with 33 Mhz clk). */
-#define WDT_EXP_SEL_06	0x0020	/* [06] Time-out = 8.13 s (with 33 Mhz clk). */
-#define WDT_EXP_SEL_07	0x0040	/* [07] Time-out = 16.27s (with 33 Mhz clk). */
-#define WDT_EXP_SEL_08	0x0080	/* [08] Time-out = 32.54s (with 33 Mhz clk). */
-#define WDT_IRQ_FLG	0x1000	/* [12] Interrupt Request Flag */
-#define WDT_WRST_ENB	0x4000	/* [14] Watchdog Timer Reset Enable */
-#define WDT_ENB		0x8000	/* [15] Watchdog Timer Enable */
-
-static __u16 __iomem *wdtmrctl;
-
-static void wdt_timer_ping(struct timer_list *);
-static DEFINE_TIMER(timer, wdt_timer_ping);
-static unsigned long next_heartbeat;
-static unsigned long wdt_is_open;
-static char wdt_expect_close;
-static DEFINE_SPINLOCK(wdt_spinlock);
-
-/*
- *	Whack the dog
- */
-
-static void wdt_timer_ping(struct timer_list *unused)
-{
-	/* If we got a heartbeat pulse within the WDT_US_INTERVAL
-	 * we agree to ping the WDT
-	 */
-	if (time_before(jiffies, next_heartbeat)) {
-		/* Ping the WDT */
-		spin_lock(&wdt_spinlock);
-		writew(0xAAAA, wdtmrctl);
-		writew(0x5555, wdtmrctl);
-		spin_unlock(&wdt_spinlock);
-
-		/* Re-set the timer interval */
-		mod_timer(&timer, jiffies + WDT_INTERVAL);
-	} else
-		pr_warn("Heartbeat lost! Will not ping the watchdog\n");
-}
-
-/*
- *	Utility routines
- */
-
-static void wdt_config(int writeval)
-{
-	unsigned long flags;
-
-	/* buy some time (ping) */
-	spin_lock_irqsave(&wdt_spinlock, flags);
-	readw(wdtmrctl);	/* ensure write synchronization */
-	writew(0xAAAA, wdtmrctl);
-	writew(0x5555, wdtmrctl);
-	/* unlock WDT = make WDT configuration register writable one time */
-	writew(0x3333, wdtmrctl);
-	writew(0xCCCC, wdtmrctl);
-	/* write WDT configuration register */
-	writew(writeval, wdtmrctl);
-	spin_unlock_irqrestore(&wdt_spinlock, flags);
-}
-
-static int wdt_startup(void)
-{
-	next_heartbeat = jiffies + (timeout * HZ);
-
-	/* Start the timer */
-	mod_timer(&timer, jiffies + WDT_INTERVAL);
-
-	/* Start the watchdog */
-	wdt_config(WDT_ENB | WDT_WRST_ENB | WDT_EXP_SEL_04);
-
-	pr_info("Watchdog timer is now enabled\n");
-	return 0;
-}
-
-static int wdt_turnoff(void)
-{
-	/* Stop the timer */
-	timer_delete_sync(&timer);
-
-	/* Stop the watchdog */
-	wdt_config(0);
-
-	pr_info("Watchdog timer is now disabled...\n");
-	return 0;
-}
-
-static int wdt_keepalive(void)
-{
-	/* user land ping */
-	next_heartbeat = jiffies + (timeout * HZ);
-	return 0;
-}
-
-static int wdt_set_heartbeat(int t)
-{
-	if ((t < 1) || (t > 3600))	/* arbitrary upper limit */
-		return -EINVAL;
-
-	timeout = t;
-	return 0;
-}
-
-/*
- *	/dev/watchdog handling
- */
-
-static ssize_t fop_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
-{
-	/* See if we got the magic character 'V' and reload the timer */
-	if (count) {
-		if (!nowayout) {
-			size_t ofs;
-
-			/* note: just in case someone wrote the magic character
-			 * five months ago... */
-			wdt_expect_close = 0;
-
-			/* now scan */
-			for (ofs = 0; ofs != count; ofs++) {
-				char c;
-				if (get_user(c, buf + ofs))
-					return -EFAULT;
-				if (c == 'V')
-					wdt_expect_close = 42;
-			}
-		}
-
-		/* Well, anyhow someone wrote to us, we should
-		   return that favour */
-		wdt_keepalive();
-	}
-	return count;
-}
-
-static int fop_open(struct inode *inode, struct file *file)
-{
-	/* Just in case we're already talking to someone... */
-	if (test_and_set_bit(0, &wdt_is_open))
-		return -EBUSY;
-	if (nowayout)
-		__module_get(THIS_MODULE);
-
-	/* Good, fire up the show */
-	wdt_startup();
-	return stream_open(inode, file);
-}
-
-static int fop_close(struct inode *inode, struct file *file)
-{
-	if (wdt_expect_close == 42)
-		wdt_turnoff();
-	else {
-		pr_crit("Unexpected close, not stopping watchdog!\n");
-		wdt_keepalive();
-	}
-	clear_bit(0, &wdt_is_open);
-	wdt_expect_close = 0;
-	return 0;
-}
-
-static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	static const struct watchdog_info ident = {
-		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT
-							| WDIOF_MAGICCLOSE,
-		.firmware_version = 1,
-		.identity = "SC520",
-	};
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-	case WDIOC_SETOPTIONS:
-	{
-		int new_options, retval = -EINVAL;
-
-		if (get_user(new_options, p))
-			return -EFAULT;
-
-		if (new_options & WDIOS_DISABLECARD) {
-			wdt_turnoff();
-			retval = 0;
-		}
-
-		if (new_options & WDIOS_ENABLECARD) {
-			wdt_startup();
-			retval = 0;
-		}
-
-		return retval;
-	}
-	case WDIOC_KEEPALIVE:
-		wdt_keepalive();
-		return 0;
-	case WDIOC_SETTIMEOUT:
-	{
-		int new_timeout;
-
-		if (get_user(new_timeout, p))
-			return -EFAULT;
-
-		if (wdt_set_heartbeat(new_timeout))
-			return -EINVAL;
-
-		wdt_keepalive();
-	}
-		fallthrough;
-	case WDIOC_GETTIMEOUT:
-		return put_user(timeout, p);
-	default:
-		return -ENOTTY;
-	}
-}
-
-static const struct file_operations wdt_fops = {
-	.owner		= THIS_MODULE,
-	.write		= fop_write,
-	.open		= fop_open,
-	.release	= fop_close,
-	.unlocked_ioctl	= fop_ioctl,
-	.compat_ioctl	= compat_ptr_ioctl,
-};
-
-static struct miscdevice wdt_miscdev = {
-	.minor	= WATCHDOG_MINOR,
-	.name	= "watchdog",
-	.fops	= &wdt_fops,
-};
-
-/*
- *	Notifier for system down
- */
-
-static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
-	void *unused)
-{
-	if (code == SYS_DOWN || code == SYS_HALT)
-		wdt_turnoff();
-	return NOTIFY_DONE;
-}
-
-/*
- *	The WDT needs to learn about soft shutdowns in order to
- *	turn the timebomb registers off.
- */
-
-static struct notifier_block wdt_notifier = {
-	.notifier_call = wdt_notify_sys,
-};
-
-static void __exit sc520_wdt_unload(void)
-{
-	if (!nowayout)
-		wdt_turnoff();
-
-	/* Deregister */
-	misc_deregister(&wdt_miscdev);
-	unregister_reboot_notifier(&wdt_notifier);
-	iounmap(wdtmrctl);
-}
-
-static int __init sc520_wdt_init(void)
-{
-	int rc = -EBUSY;
-
-	/* Check that the timeout value is within it's range ;
-	   if not reset to the default */
-	if (wdt_set_heartbeat(timeout)) {
-		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
-		pr_info("timeout value must be 1 <= timeout <= 3600, using %d\n",
-			WATCHDOG_TIMEOUT);
-	}
-
-	wdtmrctl = ioremap(MMCR_BASE + OFFS_WDTMRCTL, 2);
-	if (!wdtmrctl) {
-		pr_err("Unable to remap memory\n");
-		rc = -ENOMEM;
-		goto err_out_region2;
-	}
-
-	rc = register_reboot_notifier(&wdt_notifier);
-	if (rc) {
-		pr_err("cannot register reboot notifier (err=%d)\n", rc);
-		goto err_out_ioremap;
-	}
-
-	rc = misc_register(&wdt_miscdev);
-	if (rc) {
-		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
-		       WATCHDOG_MINOR, rc);
-		goto err_out_notifier;
-	}
-
-	pr_info("WDT driver for SC520 initialised. timeout=%d sec (nowayout=%d)\n",
-		timeout, nowayout);
-
-	return 0;
-
-err_out_notifier:
-	unregister_reboot_notifier(&wdt_notifier);
-err_out_ioremap:
-	iounmap(wdtmrctl);
-err_out_region2:
-	return rc;
-}
-
-module_init(sc520_wdt_init);
-module_exit(sc520_wdt_unload);
-
-MODULE_AUTHOR("Scott and Bill Jennings");
-MODULE_DESCRIPTION(
-	"Driver for watchdog timer in AMD \"Elan\" SC520 uProcessor");
-MODULE_LICENSE("GPL");
-- 
2.54.0

