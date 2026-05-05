Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60743BF662
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999883; cv=none; b=uD5h5o/liC5fWS1axhWK+m7ONvCsFLQ9wQdjggGuISqJdzjXqqZwKq4UZk5GMiWCl0ONBWShRsoF3n41kjuQ6oQWX83mV2jxO7j1x/HsdcnmBWCjFs64HSgIP4yVQahyC4ostsC9buqNy0i8orqBr42hlB4LSjqepz4IeIhJ0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999883; c=relaxed/simple;
	bh=SC0oSyN7/W9cN2PC9Jfhykrizppf4NQPMMbkN/klXeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i92QB1s1uwPb3DxPlaKiMdZhrp4PZUeIr62keI/7bBK/Mi4q7n2NwxL9wfqPwr9K/6huR0G3iF/pFQCfoKgosB2JZywmY7VrxxIz91GypLfhIfRRD5sFzcHNlpFX90kSRXTbpEYybURJPylrFwTjFwU1/W+oC0W1sPqIiczIOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oroxLUzA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oroxLUzA"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba4a1a0325so11393215ad.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777999877; x=1778604677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj7zIc9XrbUOU+o/XYGMKwcZFccOBsFu65kMsYsexyE=;
        b=oroxLUzA+fnt27hjPZaskIPHSyzy7cOfm6btxWrxt5ruIxZoo88GXoOV3R8eX/26r9
         cz6afQKG9Gm2SgQfBUcuybhJbgMsmoV1unjV9v8r9R+T3U93NJlx0YxcpWkLF0qu2rW9
         P1ep1dPD6EdyFqIbPh0G9TQ1jWxZO9SMOwesdmTCBjpr0Ic8uOSN57rmA0hZr66/YmOe
         Df2VodrJIUqzWNcdMv6UAh8YZOYj70VY7fpvx09+nOF76vxNNa9OwvMz214hWPkmEBW2
         oIFuHsjgu42yqSmNfi7R6MabNp/AF2EcMFlsE6hVfG/cJUQSivlA4+sm5aX1Xj+K8Bf1
         xXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999877; x=1778604677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj7zIc9XrbUOU+o/XYGMKwcZFccOBsFu65kMsYsexyE=;
        b=LNeT9YVk8qivQuRccC90Lzyo+glR/maVdYn4kLjZgCOg3l8IW0gvCOUCN6Vsy9FPDM
         yzSUcGQqE8f38Q+jb4WJLFEhqtMw/yu57PHY9KBEh0K1EMbcCOEnQ7RS2kaeNocrQK8R
         vbvrCcVm+RpclZJPATY6sTjy1+rvPwxIJ5P+FfrIdGYL4VO7topU0RCh0tVOT6KExW9A
         MYAnKbw/0ywfojfueNIRaQKDuuRD/RE/57UtiNXzRUxi0wQHiIp/pKRyG7tMVZxKFfd6
         jb/scdQmKnNNphnoyQoGf3Mg67KWADAw/CcteaY3vPOswjvm1GiepBquEWNFZY27HevI
         KvTg==
X-Gm-Message-State: AOJu0YyNkC5x8JPZ1Rfol1OY/c/vsvHRcwVIpMeQ7fL50MvDKH6HjkuE
	W2VRFVnqFxabmL7O5kyb0CqemZmI4TkFKJ9bcCCnSVP6u0NCzMzTlDxE4Ifqag==
X-Gm-Gg: AeBDieuAPQ+mj15lH9or0a/meVdzKngbyeksrXXLbf9ROum4sR60tf6+0mHicmFX2dM
	0pvvBqF1Zwhdylw1G7hfwt1ozgsUyAjq7n1N7rwMHnrNkWlJoqlkMhVEHHtNcueJRzpl+3VVI7v
	ti6QKwPDt0S2gEEX78VpjtVXbgSUqW8HdyuYb4PLcTNMn/gobOt8Vz6Fg/unSATKL88sMXqxlwZ
	kd6umdx8QbCQ576LSdvmQeNj6vfr+iRl6Glw3QS19mGmEr1VR9QOLopodwv47F+qklfCiL3GuUp
	3sD68ew7DtaUw/36q7LNh3VgIcHzmy0UBSHvNbm2dQQacOmx7SRw8Vr3qs49XQKVGSzAPwusDL/
	9u2v6PjQ6LvgPxr7fdSwsVixykYmE4e8yn/+tU5SgC8ETPUL7Ek/HBNB2QnfH0yVnfd1koulAeS
	nIsjttALq04PHZc7bUTMMchSx3OmtMBzTy6nkecotxCB+ieFw=
X-Received: by 2002:a17:903:1b46:b0:2ba:919:bbf3 with SMTP id d9443c01a7336-2ba0919be66mr115377615ad.14.1777999876612;
        Tue, 05 May 2026 09:51:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16a9esm135178355ad.50.2026.05.05.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:51:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: Remove AMD Elan SC520 processor watchdog driver
Date: Tue,  5 May 2026 09:51:11 -0700
Message-ID: <20260505165111.2318890-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD Elan support was removed from the upstream kernel with commit
8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"). Its
watchdog driver can no longer be enabled except for test builds.
Remove it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../watchdog/watchdog-parameters.rst          |   9 -
 drivers/watchdog/Kconfig                      |  13 -
 drivers/watchdog/Makefile                     |   1 -
 drivers/watchdog/sc520_wdt.c                  | 430 ------------------
 4 files changed, 453 deletions(-)
 delete mode 100644 drivers/watchdog/sc520_wdt.c

diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
index 173adee71901..8482cc976ce0 100644
--- a/Documentation/watchdog/watchdog-parameters.rst
+++ b/Documentation/watchdog/watchdog-parameters.rst
@@ -522,15 +522,6 @@ sc1200wdt:
 
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
index 4c204951bc95..d1d2cdbd1995 100644
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
index a4341b251bdf..bc1d52220f22 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -117,7 +117,6 @@ obj-$(CONFIG_EXAR_WDT) += exar_wdt.o
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
2.45.2

