Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E52853E9
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Apr 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340917; cv=none; b=ZetBVODl80eEO0JgGMUu3mFf5O89Z07FGyNlEZxIYxMrRvhIwKHHqZqdeOcDO0k2OkTxS/3WuxfsaKxVZzRP25Bv/OOGbjPi5FZslAHJrixNLZHyfL4ebTFi6IXSKU16S1BGiOAZBd+uKf2yxH4M1sxxeVjcpa4tmSwAzNAlClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340917; c=relaxed/simple;
	bh=ly1d2nvsX3CoIAHRkA+RxUJvjLOAFadfRQrDav+67dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGvNrSIG/yF7Gop2ITYwstkpA6SmQWaBu3bpzwdjIIJUyyqHUT4ZKMu7+0Wdc8GJeFHqJE7UEKinMgzjydPz7woTBjfwwdp20qQW4CMzyC40o0kslKSYREOFJ5t8zAd/ROCAS/zZeENp548Tmk3TWXKiG+hwMgw/jZf55LrB/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNTs3imc; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNTs3imc"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12ddbe104ccso1064262c88.0
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Apr 2026 18:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777340915; x=1777945715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5aVkqHkIrSOIGpIo34ssdCB9R955c6olFefI0jSPeQ=;
        b=kNTs3imcKRBK2vgIYuUdU0WpuQj5VRpMA9IEq9TCANbFarMDmbskI4y3npHTnj+l8c
         l/UF5N1apXjoGkaiEyDCZRA8/E21kz/SV3Z9WntWbZeE00uGHrkaEH46IYjCKRKUs96z
         lq35jU/Iww604nU34B1uDrrqJZHLddvL/6u/n0rMCc+KpmVlc0YgXbjIJJP++xwhz1WS
         ge31Ky5+eHEpIOz+EKtPLN8ub0tldvSCm+4ldTHE66rbs8NBNu2Ytbq+kOX1zw4+cWBE
         yyfZ0MuiHNmK8n+GPrS6oVHeU0a7paqwSUze0oO0KcEqOCvO1XC0n3Q6RYWvGOPjHOgw
         R+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777340915; x=1777945715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5aVkqHkIrSOIGpIo34ssdCB9R955c6olFefI0jSPeQ=;
        b=S1YTC3ni8f0VAaJEg6ONWPV9BxhAGjn8G2De3ytgAetlqA4MV8t6Si9TB7ErIxKxiW
         BWzCcT0g5yw0C1CsZ6gHchmxR1VFfTg4xD6X6RLgIawOrAyr7ybksnbqN37F9vDOPrJz
         IomBHWwD9URDlwy2tST5qufnK1ME/2T3yvNAEgEC7eTCxY2w1TQWNFsz0fTGQi11RUab
         j3meDPuI+lH3z64WKFdQ4iCi9TeQ/QDz4QgC1tq0GWdHK7btsa7QuqqSNlJ3rYh0yHKQ
         IvJP8oPvtmiJgRH8k0XuEywLhgVqkp0sVUj0ncn/worjPq/8UiqwxGFRytqZAciED2cj
         nzTA==
X-Gm-Message-State: AOJu0YwsQMfE5bgFS9+UjCf2+XnvEUVg7aYxC8uByJmSqazklnM9l6uQ
	mi3GfafBrqoBzTV4dHtTP7cHeGAQSiY3N4FHKgalaYVeVGd4gsZ82k8l3v27krhQ
X-Gm-Gg: AeBDieuDlQKQ0wGiza/Jfx2vMkr1DzINd9l648zhnzv8pg8nVHTIey3D3SuYOCThCQ2
	iREQ5gUsDLHYCdQ2djuf1nNRvYN8ajLPHoyyB9EKBwAEPbvatxmjWQeZAF8nPkMagCjinG5I3+e
	JXP6d16sh/HBcsUZgU+cmHI05DIeAVPF0dln4kesiMYrJFFsxVQ1fqAqaDOhPayaEE8iI8/M5UO
	/MPYeX7t3MR5fis2CDe94ryeKzMI8SZkUIaQNtku47GKvJCwWAlLW1n7hHKrE5dktAnSyMUIwb7
	iiXelpPg20C/WsKXmhPy7Vy+H9OPO60FI8zYbzsfgh7KCCxG7J2IUKzzoDUAyB6taa7LietCajX
	nS+ORsLA8CIUPI6EYOCq8fEJJt743Eg2Jz2KFR7hFZcFKYyhRKqFtO9HRhxXT1W58MyNWH6giQP
	SQs5GzL+2FXkLAr+q+dmfkg1wDUMDSe4D3WsxmyOOAafUqu1v/Zh+FxJaXYsi2vOqbHMAlGwZ9z
	iEpxfJdENMKG5IeILpb9jBLYlY9cN5plUw/6NRaqC6STmARZeUeh0x+VHSHsAiMtd65h4TujUNh
	UQnGXd6roQXY4bQlVb0fXoaHdr2N7Z0g3WELd68=
X-Received: by 2002:a05:7022:6884:b0:128:d752:e074 with SMTP id a92af1059eb24-12ddd93f1dbmr592667c88.1.1777340914482;
        Mon, 27 Apr 2026 18:48:34 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9a64desm1531967c88.9.2026.04.27.18.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:48:34 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] watchdog: remove driver for integrated WDT of ZFx86 486-based SoC
Date: Mon, 27 Apr 2026 18:48:02 -0700
Message-ID: <20260428014806.35400-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The machzwd driver supports the integrated watchdog of the ZF Micro
ZFx86 SoC, which contains a 486-compatible core [1]. Since 486
support was removed in commit 8b793a92d862 ("x86/cpu: Remove
M486/M486SX/ELAN support"), the driver is no longer useful, Remove it.

[1] https://www.zfmicro.com/zfx86.html

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 .../watchdog/watchdog-parameters.rst          |  10 -
 drivers/watchdog/Kconfig                      |  13 -
 drivers/watchdog/Makefile                     |   1 -
 drivers/watchdog/machzwd.c                    | 452 ------------------
 4 files changed, 476 deletions(-)
 delete mode 100644 drivers/watchdog/machzwd.c

diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
index 773241ed9986..173adee71901 100644
--- a/Documentation/watchdog/watchdog-parameters.rst
+++ b/Documentation/watchdog/watchdog-parameters.rst
@@ -284,16 +284,6 @@ ixp4xx_wdt:
 
 -------------------------------------------------
 
-machzwd:
-    nowayout:
-	Watchdog cannot be stopped once started
-	(default=kernel config parameter)
-    action:
-	after watchdog resets, generate:
-	0 = RESET(*)  1 = SMI  2 = NMI  3 = SCI
-
--------------------------------------------------
-
 max63xx_wdt:
     heartbeat:
 	Watchdog heartbeat period in seconds from 1 to 60, default 60
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5..97e320721cff 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1712,19 +1712,6 @@ config W83977F_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called w83977f_wdt.
 
-config MACHZ_WDT
-	tristate "ZF MachZ Watchdog"
-	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
-	help
-	  If you are using a ZF Micro MachZ processor, say Y here, otherwise
-	  N.  This is the driver for the watchdog timer built-in on that
-	  processor using ZF-Logic interface.  This watchdog simply watches
-	  your kernel to make sure it doesn't freeze, and if it does, it
-	  reboots your computer after a certain amount of time.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called machzwd.
-
 config SBC_EPX_C3_WATCHDOG
 	tristate "Winsystems SBC EPX-C3 watchdog"
 	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index d2fb16b9f9ce..2961ca141c61 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -146,7 +146,6 @@ obj-$(CONFIG_VIA_WDT) += via_wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
-obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
 obj-$(CONFIG_INTEL_OC_WATCHDOG) += intel_oc_wdt.o
diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
deleted file mode 100644
index 0ae8e5bc10ae..000000000000
--- a/drivers/watchdog/machzwd.c
+++ /dev/null
@@ -1,452 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  MachZ ZF-Logic Watchdog Timer driver for Linux
- *
- *  The author does NOT admit liability nor provide warranty for
- *  any of this software. This material is provided "AS-IS" in
- *  the hope that it may be useful for others.
- *
- *  Author: Fernando Fuganti <fuganti@conectiva.com.br>
- *
- *  Based on sbc60xxwdt.c by Jakob Oestergaard
- *
- *  We have two timers (wd#1, wd#2) driven by a 32 KHz clock with the
- *  following periods:
- *      wd#1 - 2 seconds;
- *      wd#2 - 7.2 ms;
- *  After the expiration of wd#1, it can generate a NMI, SCI, SMI, or
- *  a system RESET and it starts wd#2 that unconditionally will RESET
- *  the system when the counter reaches zero.
- *
- *  14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
- *      Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/timer.h>
-#include <linux/jiffies.h>
-#include <linux/miscdevice.h>
-#include <linux/watchdog.h>
-#include <linux/fs.h>
-#include <linux/ioport.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/uaccess.h>
-
-
-/* ports */
-#define ZF_IOBASE	0x218
-#define INDEX		0x218
-#define DATA_B		0x219
-#define DATA_W		0x21A
-#define DATA_D		0x21A
-
-/* indexes */			/* size */
-#define ZFL_VERSION	0x02	/* 16   */
-#define CONTROL		0x10	/* 16   */
-#define STATUS		0x12	/* 8    */
-#define COUNTER_1	0x0C	/* 16   */
-#define COUNTER_2	0x0E	/* 8    */
-#define PULSE_LEN	0x0F	/* 8    */
-
-/* controls */
-#define ENABLE_WD1	0x0001
-#define ENABLE_WD2	0x0002
-#define RESET_WD1	0x0010
-#define RESET_WD2	0x0020
-#define GEN_SCI		0x0100
-#define GEN_NMI		0x0200
-#define GEN_SMI		0x0400
-#define GEN_RESET	0x0800
-
-
-/* utilities */
-
-#define WD1	0
-#define WD2	1
-
-#define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
-#define zf_writeb(port, data)  { outb(port, INDEX); outb(data, DATA_B); }
-#define zf_get_ZFL_version()   zf_readw(ZFL_VERSION)
-
-
-static unsigned short zf_readw(unsigned char port)
-{
-	outb(port, INDEX);
-	return inw(DATA_W);
-}
-
-
-MODULE_AUTHOR("Fernando Fuganti <fuganti@conectiva.com.br>");
-MODULE_DESCRIPTION("MachZ ZF-Logic Watchdog driver");
-MODULE_LICENSE("GPL");
-
-static bool nowayout = WATCHDOG_NOWAYOUT;
-module_param(nowayout, bool, 0);
-MODULE_PARM_DESC(nowayout,
-		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-
-#define PFX "machzwd"
-
-static const struct watchdog_info zf_info = {
-	.options		= WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-	.firmware_version	= 1,
-	.identity		= "ZF-Logic watchdog",
-};
-
-
-/*
- * action refers to action taken when watchdog resets
- * 0 = GEN_RESET
- * 1 = GEN_SMI
- * 2 = GEN_NMI
- * 3 = GEN_SCI
- * defaults to GEN_RESET (0)
- */
-static int action;
-module_param(action, int, 0);
-MODULE_PARM_DESC(action, "after watchdog resets, generate: "
-				"0 = RESET(*)  1 = SMI  2 = NMI  3 = SCI");
-
-static void zf_ping(struct timer_list *unused);
-
-static int zf_action = GEN_RESET;
-static unsigned long zf_is_open;
-static char zf_expect_close;
-static DEFINE_SPINLOCK(zf_port_lock);
-static DEFINE_TIMER(zf_timer, zf_ping);
-static unsigned long next_heartbeat;
-
-
-/* timeout for user land heart beat (10 seconds) */
-#define ZF_USER_TIMEO (HZ*10)
-
-/* timeout for hardware watchdog (~500ms) */
-#define ZF_HW_TIMEO (HZ/2)
-
-/* number of ticks on WD#1 (driven by a 32KHz clock, 2s) */
-#define ZF_CTIMEOUT 0xffff
-
-#ifndef ZF_DEBUG
-#define dprintk(format, args...)
-#else
-#define dprintk(format, args...)					\
-	pr_debug(":%s:%d: " format, __func__, __LINE__ , ## args)
-#endif
-
-
-static inline void zf_set_status(unsigned char new)
-{
-	zf_writeb(STATUS, new);
-}
-
-
-/* CONTROL register functions */
-
-static inline unsigned short zf_get_control(void)
-{
-	return zf_readw(CONTROL);
-}
-
-static inline void zf_set_control(unsigned short new)
-{
-	zf_writew(CONTROL, new);
-}
-
-
-/* WD#? counter functions */
-/*
- *	Just set counter value
- */
-
-static inline void zf_set_timer(unsigned short new, unsigned char n)
-{
-	switch (n) {
-	case WD1:
-		zf_writew(COUNTER_1, new);
-		fallthrough;
-	case WD2:
-		zf_writeb(COUNTER_2, new > 0xff ? 0xff : new);
-		fallthrough;
-	default:
-		return;
-	}
-}
-
-/*
- * stop hardware timer
- */
-static void zf_timer_off(void)
-{
-	unsigned int ctrl_reg = 0;
-	unsigned long flags;
-
-	/* stop internal ping */
-	timer_delete_sync(&zf_timer);
-
-	spin_lock_irqsave(&zf_port_lock, flags);
-	/* stop watchdog timer */
-	ctrl_reg = zf_get_control();
-	ctrl_reg |= (ENABLE_WD1|ENABLE_WD2);	/* disable wd1 and wd2 */
-	ctrl_reg &= ~(ENABLE_WD1|ENABLE_WD2);
-	zf_set_control(ctrl_reg);
-	spin_unlock_irqrestore(&zf_port_lock, flags);
-
-	pr_info("Watchdog timer is now disabled\n");
-}
-
-
-/*
- * start hardware timer
- */
-static void zf_timer_on(void)
-{
-	unsigned int ctrl_reg = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&zf_port_lock, flags);
-
-	zf_writeb(PULSE_LEN, 0xff);
-
-	zf_set_timer(ZF_CTIMEOUT, WD1);
-
-	/* user land ping */
-	next_heartbeat = jiffies + ZF_USER_TIMEO;
-
-	/* start the timer for internal ping */
-	mod_timer(&zf_timer, jiffies + ZF_HW_TIMEO);
-
-	/* start watchdog timer */
-	ctrl_reg = zf_get_control();
-	ctrl_reg |= (ENABLE_WD1|zf_action);
-	zf_set_control(ctrl_reg);
-	spin_unlock_irqrestore(&zf_port_lock, flags);
-
-	pr_info("Watchdog timer is now enabled\n");
-}
-
-
-static void zf_ping(struct timer_list *unused)
-{
-	unsigned int ctrl_reg = 0;
-	unsigned long flags;
-
-	zf_writeb(COUNTER_2, 0xff);
-
-	if (time_before(jiffies, next_heartbeat)) {
-		dprintk("time_before: %ld\n", next_heartbeat - jiffies);
-		/*
-		 * reset event is activated by transition from 0 to 1 on
-		 * RESET_WD1 bit and we assume that it is already zero...
-		 */
-
-		spin_lock_irqsave(&zf_port_lock, flags);
-		ctrl_reg = zf_get_control();
-		ctrl_reg |= RESET_WD1;
-		zf_set_control(ctrl_reg);
-
-		/* ...and nothing changes until here */
-		ctrl_reg &= ~(RESET_WD1);
-		zf_set_control(ctrl_reg);
-		spin_unlock_irqrestore(&zf_port_lock, flags);
-
-		mod_timer(&zf_timer, jiffies + ZF_HW_TIMEO);
-	} else
-		pr_crit("I will reset your machine\n");
-}
-
-static ssize_t zf_write(struct file *file, const char __user *buf, size_t count,
-								loff_t *ppos)
-{
-	/* See if we got the magic character */
-	if (count) {
-		/*
-		 * no need to check for close confirmation
-		 * no way to disable watchdog ;)
-		 */
-		if (!nowayout) {
-			size_t ofs;
-			/*
-			 * note: just in case someone wrote the magic character
-			 * five months ago...
-			 */
-			zf_expect_close = 0;
-
-			/* now scan */
-			for (ofs = 0; ofs != count; ofs++) {
-				char c;
-				if (get_user(c, buf + ofs))
-					return -EFAULT;
-				if (c == 'V') {
-					zf_expect_close = 42;
-					dprintk("zf_expect_close = 42\n");
-				}
-			}
-		}
-
-		/*
-		 * Well, anyhow someone wrote to us,
-		 * we should return that favour
-		 */
-		next_heartbeat = jiffies + ZF_USER_TIMEO;
-		dprintk("user ping at %ld\n", jiffies);
-	}
-	return count;
-}
-
-static long zf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		if (copy_to_user(argp, &zf_info, sizeof(zf_info)))
-			return -EFAULT;
-		break;
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-	case WDIOC_KEEPALIVE:
-		zf_ping(NULL);
-		break;
-	default:
-		return -ENOTTY;
-	}
-	return 0;
-}
-
-static int zf_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(0, &zf_is_open))
-		return -EBUSY;
-	if (nowayout)
-		__module_get(THIS_MODULE);
-	zf_timer_on();
-	return stream_open(inode, file);
-}
-
-static int zf_close(struct inode *inode, struct file *file)
-{
-	if (zf_expect_close == 42)
-		zf_timer_off();
-	else {
-		timer_delete(&zf_timer);
-		pr_err("device file closed unexpectedly. Will not stop the WDT!\n");
-	}
-	clear_bit(0, &zf_is_open);
-	zf_expect_close = 0;
-	return 0;
-}
-
-/*
- * Notifier for system down
- */
-
-static int zf_notify_sys(struct notifier_block *this, unsigned long code,
-								void *unused)
-{
-	if (code == SYS_DOWN || code == SYS_HALT)
-		zf_timer_off();
-	return NOTIFY_DONE;
-}
-
-static const struct file_operations zf_fops = {
-	.owner		= THIS_MODULE,
-	.write		= zf_write,
-	.unlocked_ioctl = zf_ioctl,
-	.compat_ioctl	= compat_ptr_ioctl,
-	.open		= zf_open,
-	.release	= zf_close,
-};
-
-static struct miscdevice zf_miscdev = {
-	.minor = WATCHDOG_MINOR,
-	.name = "watchdog",
-	.fops = &zf_fops,
-};
-
-
-/*
- * The device needs to learn about soft shutdowns in order to
- * turn the timebomb registers off.
- */
-static struct notifier_block zf_notifier = {
-	.notifier_call = zf_notify_sys,
-};
-
-static void __init zf_show_action(int act)
-{
-	static const char * const str[] = { "RESET", "SMI", "NMI", "SCI" };
-
-	pr_info("Watchdog using action = %s\n", str[act]);
-}
-
-static int __init zf_init(void)
-{
-	int ret;
-
-	pr_info("MachZ ZF-Logic Watchdog driver initializing\n");
-
-	ret = zf_get_ZFL_version();
-	if (!ret || ret == 0xffff) {
-		pr_warn("no ZF-Logic found\n");
-		return -ENODEV;
-	}
-
-	if (action <= 3 && action >= 0)
-		zf_action = zf_action >> action;
-	else
-		action = 0;
-
-	zf_show_action(action);
-
-	if (!request_region(ZF_IOBASE, 3, "MachZ ZFL WDT")) {
-		pr_err("cannot reserve I/O ports at %d\n", ZF_IOBASE);
-		ret = -EBUSY;
-		goto no_region;
-	}
-
-	ret = register_reboot_notifier(&zf_notifier);
-	if (ret) {
-		pr_err("can't register reboot notifier (err=%d)\n", ret);
-		goto no_reboot;
-	}
-
-	ret = misc_register(&zf_miscdev);
-	if (ret) {
-		pr_err("can't misc_register on minor=%d\n", WATCHDOG_MINOR);
-		goto no_misc;
-	}
-
-	zf_set_status(0);
-	zf_set_control(0);
-
-	return 0;
-
-no_misc:
-	unregister_reboot_notifier(&zf_notifier);
-no_reboot:
-	release_region(ZF_IOBASE, 3);
-no_region:
-	return ret;
-}
-
-
-static void __exit zf_exit(void)
-{
-	zf_timer_off();
-
-	misc_deregister(&zf_miscdev);
-	unregister_reboot_notifier(&zf_notifier);
-	release_region(ZF_IOBASE, 3);
-}
-
-module_init(zf_init);
-module_exit(zf_exit);
-- 
2.43.0

