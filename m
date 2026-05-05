Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61601318B9D
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777951323; cv=none; b=Cqw149go2GUujW3Mr1rpkzxXj5UEo+aSXdpqaYkLKAEwmm6FGg/v/JE3QY7VhTXi/X6377H8vfUPn3awcQboUlDIbxgObWGCC3q/cnCkrNvipAJhbCqsH923KtL5Bc+vIs+XOPFjH+CIyMSofgPz+qUjkOKiR+idQdry+FKYNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777951323; c=relaxed/simple;
	bh=HDnckhhPqYX3ZXMaNLMBORzmaFOnQykuuE+tYTMDAW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJ6stZ6YiQ1OTA4649MaunvwKlBICOcsnN5Ky5zShIYOv+vZL/awgUgJwhnkpzzIaLEbvDnDzjAs4Bt15BqzE9doBpLGaR0+YRRd8ctomZTnS/RX1nmrlcSi0Cq7B/1XaBwgJIadfgk3C7L4XqpO/3ua1B/TglPCRryGDdA5tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQhp/qkC; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQhp/qkC"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2c156c4a9efso8404948eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 20:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777951320; x=1778556120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANcdNJH3SHc9uCDKllKAPdmq69A8aeIDEqp/u2WkCbE=;
        b=WQhp/qkC6Jb70qR2Ew6bMzk+XcUiMc+IM47tXDM5zAfOg8HYelmbQCvc8xDnS0go+b
         tEP7jlP+UggXSOddraAGKx9XJsZGX4FQMRm7DiRJ42zeUX2+OQZkApkmkCUL628o0sWF
         CkYvTprWt1qugcjAmWNOQ49E3Ml/jM9K+0cDmw6ae/Qyqmq9XTGjIron3tax8h7ymk8c
         Foh5P8naap94MOclBrqVlT304YjaGi4kfJ2M6J0+y5KydzvIlj/2ibdaTmeIKdA6ynQn
         Jcoa8O17uKmE6SmM+SMNYYww1eygTDblwCxNmZO82D3xpDmanw+MKHYkM9moNyIyLnvZ
         cM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777951320; x=1778556120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANcdNJH3SHc9uCDKllKAPdmq69A8aeIDEqp/u2WkCbE=;
        b=ktdUFhlspwfeA1NcsXcOs8UNwVp/b/iWVnFM+vkXIE7bEvvOxUjmMJmwMZrYhOjvHm
         Ca1VtXu85mYiKUH63aR2flfoxTmtnDsvN7BaV3NgGX5wPiBhx0Y/EmrFDvx+dFy7CWjR
         GePoghhILn3YP2wCm1PG82WqgV56xVQS59ekKt0rBslZJAPv7BdYpqxx5SKP1+zIJSi/
         QxC0ipchnGk5+8Y3yXGuwtzmjOjya8WiaeeOxMfoSlojBUBv/tvX1QxOe4GAZ/56Q+Lc
         DBF5oBQgtLfyfq/zXSgdQCusd0Pt+fETDpOq2LD7VA6SF96a54yuaRw1cxX2Qy5BAlNs
         KYHA==
X-Gm-Message-State: AOJu0YyYNLIVIVj6jzZ/9sy9sqJ1p1my5s51HqBEGJw7UUbD8RF3i3Hp
	t+asLV3oGl4f9SPI1vwYFZl823LFsWjtQPt1G1hiAVbKI9Oo06CuUvufdPunBt8V
X-Gm-Gg: AeBDiesJqUN/A9wHKJpmpNAXQHAVtYfXwIGIO5c/Fq9Szjl47eDUgTxSqI22I95u0Z7
	C4+CrI/29MMPQ7Z6Kh/gTSXJD/zXfjgt634CRzammNcN62hVXsDKR0vjCDWyjY5uraJDZpCWxcv
	d20MfjI3uc+1MoFlnw6GpHMIdwZ68biPUbU2PyvwGpN2KZNzW5uH5Z+96MZPZjzcsNUTuo5lY4o
	3ru7/HRey+UX9PReVy/wEOJ4+/4G2T+QZKEWshrC3wOI7/te38RHBZ4LpIQrR9L5EsyatSjh4Ov
	diGtIDoY2zzIj1qdECYDGtReiv2rkOcgA0+MblH6hwJ4mihtbGGTXFq4PGmmuNfc78ZMvyv+Gb3
	bxnau+ga9r5+NlJgvBdKv1x/PeuDQdbz8Ana9C7PHDxnROqbEcXL8upSwhK1vY/DOxW9F1tBv0x
	YOMMFKhwUpgiY4M82y5ct+GF+YJpbiteNu7+2akHJkxjJEygWYwpFnSR4ZU9rkMsCEwzHaIhonp
	kMLYJ2rp5d7qU3HpoyKIEbEwFKrbvciIKDRDTOZTOxQi68cpetQorTNCtznblRe6yTBSUi+GmAH
	EBIDnSEhDKDGed4W9tcqYPR9wWiu
X-Received: by 2002:a05:7300:570c:b0:2de:aafb:fef3 with SMTP id 5a478bee46e88-2efb7bdc7f2mr5326134eec.1.1777951320382;
        Mon, 04 May 2026 20:22:00 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bb63c5fsm18127336eec.25.2026.05.04.20.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 20:22:00 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] watchdog: it8712f_wdt: remove redundant driver
Date: Mon,  4 May 2026 20:21:40 -0700
Message-ID: <20260505032145.66065-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The it87_wdt driver also supports the IT8712 (regardless of revision),
and therefore the it8712f_wdt driver is redundant. Remove it and
add an alias to it87_wdt so it loads when it8712f_wdt is requested.

A notable difference between the drivers is that it8712f_wdt kicks the
watchdog using game port reads which it generates, or optionally,
keyboard, mouse, or CIR activity. None of these methods are
particularly useful or reliable; the documentation indicates:
    If the driver does not work, then make sure that the game port in the
    BIOS is enabled.
and:
    You can also use KBD, MOUSE or CIR if you have some external way to
    generate those interrupts.
it87_wdt kicks the watchdog by directly writing to the timer register,
which should work in all circumstances.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 .../watchdog/watchdog-parameters.rst          |   9 -
 drivers/watchdog/Kconfig                      |  13 -
 drivers/watchdog/Makefile                     |   1 -
 drivers/watchdog/it8712f_wdt.c                | 449 ------------------
 drivers/watchdog/it87_wdt.c                   |   5 +
 5 files changed, 5 insertions(+), 472 deletions(-)
 delete mode 100644 drivers/watchdog/it8712f_wdt.c

diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
index 773241ed9986..39b20250b416 100644
--- a/Documentation/watchdog/watchdog-parameters.rst
+++ b/Documentation/watchdog/watchdog-parameters.rst
@@ -248,15 +248,6 @@ iop_wdt:
 
 -------------------------------------------------
 
-it8712f_wdt:
-    margin:
-	Watchdog margin in seconds (default 60)
-    nowayout:
-	Disable watchdog shutdown on close
-	(default=kernel config parameter)
-
--------------------------------------------------
-
 it87_wdt:
     nogameport:
 	Forbid the activation of game port, default=0
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5..a84fbf9d52b8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1429,19 +1429,6 @@ config ITCO_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called iTCO_wdt.
 
-config IT8712F_WDT
-	tristate "IT8712F (Smart Guardian) Watchdog Timer"
-	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
-	help
-	  This is the driver for the built-in watchdog timer on the IT8712F
-	  Super I/0 chipset used on many motherboards.
-
-	  If the driver does not work, then make sure that the game port in
-	  the BIOS is enabled.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called it8712f_wdt.
-
 config IT87_WDT
 	tristate "IT87 Watchdog Timer"
 	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index d2fb16b9f9ce..30b35d9887cd 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -127,7 +127,6 @@ obj-$(CONFIG_IE6XX_WDT) += ie6xx_wdt.o
 obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
 obj-$(CONFIG_LENOVO_SE10_WDT) += lenovo_se10_wdt.o
 obj-$(CONFIG_LENOVO_SE30_WDT) += lenovo_se30_wdt.o
-obj-$(CONFIG_IT8712F_WDT) += it8712f_wdt.o
 obj-$(CONFIG_IT87_WDT) += it87_wdt.o
 obj-$(CONFIG_HP_WATCHDOG) += hpwdt.o
 obj-$(CONFIG_KEMPLD_WDT) += kempld_wdt.o
diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
deleted file mode 100644
index b776e6766c9d..000000000000
--- a/drivers/watchdog/it8712f_wdt.c
+++ /dev/null
@@ -1,449 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *	IT8712F "Smart Guardian" Watchdog support
- *
- *	Copyright (c) 2006-2007 Jorge Boncompte - DTI2 <jorge@dti2.net>
- *
- *	Based on info and code taken from:
- *
- *	drivers/char/watchdog/scx200_wdt.c
- *	drivers/hwmon/it87.c
- *	IT8712F EC-LPC I/O Preliminary Specification 0.8.2
- *	IT8712F EC-LPC I/O Preliminary Specification 0.9.3
- *
- *	The author(s) of this software shall not be held liable for damages
- *	of any nature resulting due to the use of this software. This
- *	software is provided AS-IS with no warranties.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/miscdevice.h>
-#include <linux/watchdog.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-#include <linux/fs.h>
-#include <linux/spinlock.h>
-#include <linux/uaccess.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-
-#define NAME "it8712f_wdt"
-
-MODULE_AUTHOR("Jorge Boncompte - DTI2 <jorge@dti2.net>");
-MODULE_DESCRIPTION("IT8712F Watchdog Driver");
-MODULE_LICENSE("GPL");
-
-static int max_units = 255;
-static int margin = 60;		/* in seconds */
-module_param(margin, int, 0);
-MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
-
-static bool nowayout = WATCHDOG_NOWAYOUT;
-module_param(nowayout, bool, 0);
-MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
-
-static unsigned long wdt_open;
-static unsigned expect_close;
-static unsigned char revision;
-
-/* Dog Food address - We use the game port address */
-static unsigned short address;
-
-#define	REG		0x2e	/* The register to read/write */
-#define	VAL		0x2f	/* The value to read/write */
-
-#define	LDN		0x07	/* Register: Logical device select */
-#define	DEVID		0x20	/* Register: Device ID */
-#define	DEVREV		0x22	/* Register: Device Revision */
-#define ACT_REG		0x30	/* LDN Register: Activation */
-#define BASE_REG	0x60	/* LDN Register: Base address */
-
-#define IT8712F_DEVID	0x8712
-
-#define LDN_GPIO	0x07	/* GPIO and Watch Dog Timer */
-#define LDN_GAME	0x09	/* Game Port */
-
-#define WDT_CONTROL	0x71	/* WDT Register: Control */
-#define WDT_CONFIG	0x72	/* WDT Register: Configuration */
-#define WDT_TIMEOUT	0x73	/* WDT Register: Timeout Value */
-
-#define WDT_RESET_GAME	0x10	/* Reset timer on read or write to game port */
-#define WDT_RESET_KBD	0x20	/* Reset timer on keyboard interrupt */
-#define WDT_RESET_MOUSE	0x40	/* Reset timer on mouse interrupt */
-#define WDT_RESET_CIR	0x80	/* Reset timer on consumer IR interrupt */
-
-#define WDT_UNIT_SEC	0x80	/* If 0 in MINUTES */
-
-#define WDT_OUT_PWROK	0x10	/* Pulse PWROK on timeout */
-#define WDT_OUT_KRST	0x40	/* Pulse reset on timeout */
-
-static int wdt_control_reg = WDT_RESET_GAME;
-module_param(wdt_control_reg, int, 0);
-MODULE_PARM_DESC(wdt_control_reg, "Value to write to watchdog control "
-		"register. The default WDT_RESET_GAME resets the timer on "
-		"game port reads that this driver generates. You can also "
-		"use KBD, MOUSE or CIR if you have some external way to "
-		"generate those interrupts.");
-
-static int superio_inb(int reg)
-{
-	outb(reg, REG);
-	return inb(VAL);
-}
-
-static void superio_outb(int val, int reg)
-{
-	outb(reg, REG);
-	outb(val, VAL);
-}
-
-static int superio_inw(int reg)
-{
-	int val;
-	outb(reg++, REG);
-	val = inb(VAL) << 8;
-	outb(reg, REG);
-	val |= inb(VAL);
-	return val;
-}
-
-static inline void superio_select(int ldn)
-{
-	outb(LDN, REG);
-	outb(ldn, VAL);
-}
-
-static inline int superio_enter(void)
-{
-	/*
-	 * Try to reserve REG and REG + 1 for exclusive access.
-	 */
-	if (!request_muxed_region(REG, 2, NAME))
-		return -EBUSY;
-
-	outb(0x87, REG);
-	outb(0x01, REG);
-	outb(0x55, REG);
-	outb(0x55, REG);
-	return 0;
-}
-
-static inline void superio_exit(void)
-{
-	outb(0x02, REG);
-	outb(0x02, VAL);
-	release_region(REG, 2);
-}
-
-static inline void it8712f_wdt_ping(void)
-{
-	if (wdt_control_reg & WDT_RESET_GAME)
-		inb(address);
-}
-
-static void it8712f_wdt_update_margin(void)
-{
-	int config = WDT_OUT_KRST | WDT_OUT_PWROK;
-	int units = margin;
-
-	/* Switch to minutes precision if the configured margin
-	 * value does not fit within the register width.
-	 */
-	if (units <= max_units) {
-		config |= WDT_UNIT_SEC; /* else UNIT is MINUTES */
-		pr_info("timer margin %d seconds\n", units);
-	} else {
-		units /= 60;
-		pr_info("timer margin %d minutes\n", units);
-	}
-	superio_outb(config, WDT_CONFIG);
-
-	if (revision >= 0x08)
-		superio_outb(units >> 8, WDT_TIMEOUT + 1);
-	superio_outb(units, WDT_TIMEOUT);
-}
-
-static int it8712f_wdt_get_status(void)
-{
-	if (superio_inb(WDT_CONTROL) & 0x01)
-		return WDIOF_CARDRESET;
-	else
-		return 0;
-}
-
-static int it8712f_wdt_enable(void)
-{
-	int ret = superio_enter();
-	if (ret)
-		return ret;
-
-	pr_debug("enabling watchdog timer\n");
-	superio_select(LDN_GPIO);
-
-	superio_outb(wdt_control_reg, WDT_CONTROL);
-
-	it8712f_wdt_update_margin();
-
-	superio_exit();
-
-	it8712f_wdt_ping();
-
-	return 0;
-}
-
-static int it8712f_wdt_disable(void)
-{
-	int ret = superio_enter();
-	if (ret)
-		return ret;
-
-	pr_debug("disabling watchdog timer\n");
-	superio_select(LDN_GPIO);
-
-	superio_outb(0, WDT_CONFIG);
-	superio_outb(0, WDT_CONTROL);
-	if (revision >= 0x08)
-		superio_outb(0, WDT_TIMEOUT + 1);
-	superio_outb(0, WDT_TIMEOUT);
-
-	superio_exit();
-	return 0;
-}
-
-static int it8712f_wdt_notify(struct notifier_block *this,
-		    unsigned long code, void *unused)
-{
-	if (code == SYS_HALT || code == SYS_POWER_OFF)
-		if (!nowayout)
-			it8712f_wdt_disable();
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block it8712f_wdt_notifier = {
-	.notifier_call = it8712f_wdt_notify,
-};
-
-static ssize_t it8712f_wdt_write(struct file *file, const char __user *data,
-					size_t len, loff_t *ppos)
-{
-	/* check for a magic close character */
-	if (len) {
-		size_t i;
-
-		it8712f_wdt_ping();
-
-		expect_close = 0;
-		for (i = 0; i < len; ++i) {
-			char c;
-			if (get_user(c, data + i))
-				return -EFAULT;
-			if (c == 'V')
-				expect_close = 42;
-		}
-	}
-
-	return len;
-}
-
-static long it8712f_wdt_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	static const struct watchdog_info ident = {
-		.identity = "IT8712F Watchdog",
-		.firmware_version = 1,
-		.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
-						WDIOF_MAGICCLOSE,
-	};
-	int value;
-	int ret;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		if (copy_to_user(argp, &ident, sizeof(ident)))
-			return -EFAULT;
-		return 0;
-	case WDIOC_GETSTATUS:
-		ret = superio_enter();
-		if (ret)
-			return ret;
-		superio_select(LDN_GPIO);
-
-		value = it8712f_wdt_get_status();
-
-		superio_exit();
-
-		return put_user(value, p);
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-	case WDIOC_KEEPALIVE:
-		it8712f_wdt_ping();
-		return 0;
-	case WDIOC_SETTIMEOUT:
-		if (get_user(value, p))
-			return -EFAULT;
-		if (value < 1)
-			return -EINVAL;
-		if (value > (max_units * 60))
-			return -EINVAL;
-		margin = value;
-		ret = superio_enter();
-		if (ret)
-			return ret;
-		superio_select(LDN_GPIO);
-
-		it8712f_wdt_update_margin();
-
-		superio_exit();
-		it8712f_wdt_ping();
-		fallthrough;
-	case WDIOC_GETTIMEOUT:
-		if (put_user(margin, p))
-			return -EFAULT;
-		return 0;
-	default:
-		return -ENOTTY;
-	}
-}
-
-static int it8712f_wdt_open(struct inode *inode, struct file *file)
-{
-	int ret;
-	/* only allow one at a time */
-	if (test_and_set_bit(0, &wdt_open))
-		return -EBUSY;
-
-	ret = it8712f_wdt_enable();
-	if (ret)
-		return ret;
-	return stream_open(inode, file);
-}
-
-static int it8712f_wdt_release(struct inode *inode, struct file *file)
-{
-	if (expect_close != 42) {
-		pr_warn("watchdog device closed unexpectedly, will not disable the watchdog timer\n");
-	} else if (!nowayout) {
-		if (it8712f_wdt_disable())
-			pr_warn("Watchdog disable failed\n");
-	}
-	expect_close = 0;
-	clear_bit(0, &wdt_open);
-
-	return 0;
-}
-
-static const struct file_operations it8712f_wdt_fops = {
-	.owner = THIS_MODULE,
-	.write = it8712f_wdt_write,
-	.unlocked_ioctl = it8712f_wdt_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-	.open = it8712f_wdt_open,
-	.release = it8712f_wdt_release,
-};
-
-static struct miscdevice it8712f_wdt_miscdev = {
-	.minor = WATCHDOG_MINOR,
-	.name = "watchdog",
-	.fops = &it8712f_wdt_fops,
-};
-
-static int __init it8712f_wdt_find(unsigned short *address)
-{
-	int err = -ENODEV;
-	int chip_type;
-	int ret = superio_enter();
-	if (ret)
-		return ret;
-
-	chip_type = superio_inw(DEVID);
-	if (chip_type != IT8712F_DEVID)
-		goto exit;
-
-	superio_select(LDN_GAME);
-	superio_outb(1, ACT_REG);
-	if (!(superio_inb(ACT_REG) & 0x01)) {
-		pr_err("Device not activated, skipping\n");
-		goto exit;
-	}
-
-	*address = superio_inw(BASE_REG);
-	if (*address == 0) {
-		pr_err("Base address not set, skipping\n");
-		goto exit;
-	}
-
-	err = 0;
-	revision = superio_inb(DEVREV) & 0x0f;
-
-	/* Later revisions have 16-bit values per datasheet 0.9.1 */
-	if (revision >= 0x08)
-		max_units = 65535;
-
-	if (margin > (max_units * 60))
-		margin = (max_units * 60);
-
-	pr_info("Found IT%04xF chip revision %d - using DogFood address 0x%x\n",
-		chip_type, revision, *address);
-
-exit:
-	superio_exit();
-	return err;
-}
-
-static int __init it8712f_wdt_init(void)
-{
-	int err = 0;
-
-	if (it8712f_wdt_find(&address))
-		return -ENODEV;
-
-	if (!request_region(address, 1, "IT8712F Watchdog")) {
-		pr_warn("watchdog I/O region busy\n");
-		return -EBUSY;
-	}
-
-	err = it8712f_wdt_disable();
-	if (err) {
-		pr_err("unable to disable watchdog timer\n");
-		goto out;
-	}
-
-	err = register_reboot_notifier(&it8712f_wdt_notifier);
-	if (err) {
-		pr_err("unable to register reboot notifier\n");
-		goto out;
-	}
-
-	err = misc_register(&it8712f_wdt_miscdev);
-	if (err) {
-		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
-		       WATCHDOG_MINOR, err);
-		goto reboot_out;
-	}
-
-	return 0;
-
-
-reboot_out:
-	unregister_reboot_notifier(&it8712f_wdt_notifier);
-out:
-	release_region(address, 1);
-	return err;
-}
-
-static void __exit it8712f_wdt_exit(void)
-{
-	misc_deregister(&it8712f_wdt_miscdev);
-	unregister_reboot_notifier(&it8712f_wdt_notifier);
-	release_region(address, 1);
-}
-
-module_init(it8712f_wdt_init);
-module_exit(it8712f_wdt_exit);
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 1d9f8591f38d..9da5ec544c8a 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -419,6 +419,11 @@ static void __exit it87_wdt_exit(void)
 module_init(it87_wdt_init);
 module_exit(it87_wdt_exit);
 
+/*
+ * Load this driver when the separate IT8712F driver, which was removed, is
+ * requested
+ */
+MODULE_ALIAS("it8712f_wdt");
 MODULE_AUTHOR("Oliver Schuster");
 MODULE_DESCRIPTION("Hardware Watchdog Device Driver for IT87xx EC-LPC I/O");
 MODULE_LICENSE("GPL");
-- 
2.43.0

