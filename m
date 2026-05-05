Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD435F5EF
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957170; cv=none; b=CgjoDnjflga9WoEoTEOhwRhPmETn1faivcTbGQpoA/quvK/5Xyq3xLbTgTJQUpbH9Fn88dKoGJ2aBem6Em/dmUBu1YVZ4rETJrDj+baY28TxZlXHyxKe8mW5Q7sNYoxc9gIKXYbC+j06DUkkK/vW0ChgDBH1Fu/nTy9BiUu9LnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957170; c=relaxed/simple;
	bh=H6TTW0PYpHUfAWaID8WKQrDl4icMk1jD/F0dfAF1Mjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvCUFS10ZFTPDVSc0hs38YZ45rXUqbtTL/+1nh+6S0GEYCPPL8IsuysG8QecX0RK28YGPx26APlQKiU8aGMPJ0KU7/f0BGil0vDqtF8ijqH6nPf9mHhAJJ/J9b1oSJIZVzxHy8watyLeYH/oO7bceXX9aoMRquI6Q0FI18AoLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxM8Kif4; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxM8Kif4"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-130a4aae5ccso2318932c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 21:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957166; x=1778561966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=obf0HhRIUBEo2FZRGWHRgz3nRCAgwU1wO98uhqJeUO8=;
        b=NxM8Kif41pORtWScfYUnrJt7i2CvmXb0YkefQ15HnlnrWwi3MwJdQErqmJlKYGAseZ
         ehsl/UYF2JfMdR6nlnqC7Zkn9TkQCgT+E6bvghzxgjjA4o6ApFj+FcWZKhr4axAhSy1T
         hxjE/DLoxJTntWPC6PHUjidQ0xPD0S148zjicavd5WnexioHDwGzM74N6XOEsntsiyba
         9u6K+tlrIZLBLv2gZDjeXI3ETZVcny7yJ4QzS2X4ZHGds6X0YdBVSJ/iQCYL/2TSet+c
         +Iz5JQZFH4EzmW92mYQLBKr6LReO+ApfFcfp3/ucViCJ9ES7odikJjchQmAunEkfYaND
         Vd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957166; x=1778561966;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obf0HhRIUBEo2FZRGWHRgz3nRCAgwU1wO98uhqJeUO8=;
        b=qtgAraGh56xvkwlqT2HuHpr/8XUy8mt3Yoz9i4VSQ43eRejHp0y5l8Aa3C5Qj53dzr
         c7Ktsy36nSdrNT9gtO5madPKYLI7+453iQ/SG2LRWIWehsU3YfNmwWZ6zDd/zhMVRLCl
         i+UEqNEmsX7yUQH+6nM4nd5DcW0BUuHIOoRrOj1Ywtmw60JewtacA8zS2C1MFZZykj4I
         zmz5sYvmtzcPmOmlbHIBQp/1t6dHidcAuhgsz1/06cPKyKiWO3iw4Ckjp2S65Z8E9sjn
         MqfCbBe5NqWPTWxR4juM6vfHJrdOVc5rr+PwIFYOrHZBJQZeTyDv7YKvItPjJW+h87yM
         Qsng==
X-Forwarded-Encrypted: i=1; AFNElJ96oSVHebz7ENyQM4aVjtcoyaoeOVeLOZ6MXj+14lnP26EithZu17wmjyo3wjGtLdhVXWqrIwviFEt28GIykw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQxgaaBUD7J8RH5thgVXjy9svc3SmwDxpzSZv4FC8h7J4LPcP
	a4tnNXVOBfS+ECqtqYZxKJ2hKocT8hYBn6Jb127CUCAOWlCbdKviU9qf5OX/pw==
X-Gm-Gg: AeBDietkfVKm9DjRbW61+lPgpihFdg4hh0ROMiL++ZS6Cb2z3dgBc502vM1qXx1Ue26
	/9s0fSGFnXE6en04LXi36RO8qlqvyzMqQ+nwmbEhtSRKurlT+0ID+zaW1YOG3Mt98ktbrBjY1VO
	sQk4Sby7jBgDmKKm98mrU5q8zvZhTvnM2qd2nHZ0EWpO/9cfyTrs8F4l+Ip/ufjO59p7FO03mmd
	E/QMMpPBCjs9Zke/ZfPrpWXzhJXg8S7i+QLxKGGxoQ+6hn9O2q0KvSMtMAbDqmh6QR6isWRO0kf
	SXKPCY61MzKPRFtXH8gvLwD1z64vSIZj/a1kBlTmaAfzIn8AimQa9g4gZUeDYMOLhfKQEmWaLit
	ZCNvT0V2HqMEQo7n6pKPRXxw8AOEzkmxyNm+u84ODm6U7dlqDgnHuQnjth78aoC+LvLPqgfpxAU
	LckMAJ3tUhk5wkPKIKBUDWhAUFzLFmNsZbDrea3kDAkbYLi4Quurx6GrLOEb7mgztV83GqHu+X6
	JXz98jGxkc9sBsAqjRr0g==
X-Received: by 2002:a05:7022:6b91:b0:128:d4be:7438 with SMTP id a92af1059eb24-12dfd839a02mr5452386c88.30.1777957165235;
        Mon, 04 May 2026 21:59:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84250f1sm18983131c88.11.2026.05.04.21.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 21:59:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9d134dfa-76be-4242-bae4-c4a02036f53e@roeck-us.net>
Date: Mon, 4 May 2026 21:59:23 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: remove drivers for discrete ISA WDT cards
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20260505023007.58175-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260505023007.58175-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/26 19:30, Ethan Nelson-Moore wrote:
> The mixcomwd, pcwd, and wdt (how generic!) drivers support discrete ISA
> watchdog cards. The wdt driver in particular does not support
> autoprobing and requires manual specification of the I/O port and IRQ
> the card uses. A WDT is integrated into many modern chipsets and Super
> I/O chips. Embedded boards using a WDT, even ones with ISA slots, are
> unlikely to do so via a discrete ISA card due to the amount of space
> required. Given these factors, it is highly unlikely anyone is using
> these drivers. Remove them.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Umm ... no. Declare them deprecated and announce that they will be removed
in a later kernel version unless someone speaks up. Do a Google search for
"How to deprecate Linux kernel code" and follow the guidance.

Also, remember the "one logical change per patch" rule.

Guenter

> ---
>   drivers/watchdog/Kconfig    |  49 --
>   drivers/watchdog/Makefile   |   9 +-
>   drivers/watchdog/mixcomwd.c | 312 -----------
>   drivers/watchdog/pcwd.c     | 996 ------------------------------------
>   drivers/watchdog/wdt.c      | 662 ------------------------
>   5 files changed, 2 insertions(+), 2026 deletions(-)
>   delete mode 100644 drivers/watchdog/mixcomwd.c
>   delete mode 100644 drivers/watchdog/pcwd.c
>   delete mode 100644 drivers/watchdog/wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5..d826c76c1c68 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2232,55 +2232,6 @@ config UML_WATCHDOG
>   	tristate "UML watchdog"
>   	depends on UML || COMPILE_TEST
>   
> -#
> -# ISA-based Watchdog Cards
> -#
> -
> -comment "ISA-based Watchdog Cards"
> -	depends on ISA
> -
> -config PCWATCHDOG
> -	tristate "Berkshire Products ISA-PC Watchdog"
> -	depends on ISA
> -	help
> -	  This is the driver for the Berkshire Products ISA-PC Watchdog card.
> -	  This card simply watches your kernel to make sure it doesn't freeze,
> -	  and if it does, it reboots your computer after a certain amount of
> -	  time. This driver is like the WDT501 driver but for different
> -	  hardware. Please read <file:Documentation/watchdog/pcwd-watchdog.rst>.
> -	  The PC watchdog cards can be ordered from <http://www.berkprod.com/>.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called pcwd.
> -
> -	  Most people will say N.
> -
> -config MIXCOMWD
> -	tristate "Mixcom Watchdog"
> -	depends on ISA
> -	help
> -	  This is a driver for the Mixcom hardware watchdog cards.  This
> -	  watchdog simply watches your kernel to make sure it doesn't freeze,
> -	  and if it does, it reboots your computer after a certain amount of
> -	  time.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called mixcomwd.
> -
> -	  Most people will say N.
> -
> -config WDT
> -	tristate "WDT Watchdog timer"
> -	depends on ISA
> -	help
> -	  If you have a WDT500P or WDT501P watchdog board, say Y here,
> -	  otherwise N. It is not possible to probe for this board, which means
> -	  that you have to inform the kernel about the IO port and IRQ that
> -	  is needed (you can do this via the io and irq parameters)
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called wdt.
> -
>   #
>   # PCI-based Watchdog Cards
>   #
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index d2fb16b9f9ce..f10fd646b19c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -14,19 +14,14 @@ watchdog-$(CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT)	+= watchdog_hrtimer_pretimeout.o
>   obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
>   obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
>   
> -# Only one watchdog can succeed. We probe the ISA/PCI/USB based
> +# Only one watchdog can succeed. We probe the PCI/USB based
>   # watchdog-cards first, then the architecture specific watchdog
>   # drivers and then the architecture independent "softdog" driver.
> -# This means that if your ISA/PCI/USB card isn't detected that
> +# This means that if your PCI/USB card isn't detected that
>   # you can fall back to an architecture specific driver and if
>   # that also fails then you can fall back to the software watchdog
>   # to give you some cover.
>   
> -# ISA-based Watchdog Cards
> -obj-$(CONFIG_PCWATCHDOG) += pcwd.o
> -obj-$(CONFIG_MIXCOMWD) += mixcomwd.o
> -obj-$(CONFIG_WDT) += wdt.o
> -
>   # PCI-based Watchdog Cards
>   obj-$(CONFIG_PCIPCWATCHDOG) += pcwd_pci.o
>   obj-$(CONFIG_WDTPCI) += wdt_pci.o
> diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
> deleted file mode 100644
> index 1ecd5c48a005..000000000000
> --- a/drivers/watchdog/mixcomwd.c
> +++ /dev/null
> @@ -1,312 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * MixCom Watchdog: A Simple Hardware Watchdog Device
> - * Based on Softdog driver by Alan Cox and PC Watchdog driver by Ken Hollis
> - *
> - * Author: Gergely Madarasz <gorgo@itc.hu>
> - *
> - * Copyright (c) 1999 ITConsult-Pro Co. <info@itc.hu>
> - *
> - * Version 0.1 (99/04/15):
> - *		- first version
> - *
> - * Version 0.2 (99/06/16):
> - *		- added kernel timer watchdog ping after close
> - *		  since the hardware does not support watchdog shutdown
> - *
> - * Version 0.3 (99/06/21):
> - *		- added WDIOC_GETSTATUS and WDIOC_GETSUPPORT ioctl calls
> - *
> - * Version 0.3.1 (99/06/22):
> - *		- allow module removal while internal timer is active,
> - *		  print warning about probable reset
> - *
> - * Version 0.4 (99/11/15):
> - *		- support for one more type board
> - *
> - * Version 0.5 (2001/12/14) Matt Domsch <Matt_Domsch@dell.com>
> - *		- added nowayout module option to override
> - *		  CONFIG_WATCHDOG_NOWAYOUT
> - *
> - * Version 0.6 (2002/04/12): Rob Radez <rob@osinvestor.com>
> - *		- make mixcomwd_opened unsigned,
> - *		  removed lock_kernel/unlock_kernel from mixcomwd_release,
> - *		  modified ioctl a bit to conform to API
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#define VERSION "0.6"
> -#define WATCHDOG_NAME "mixcomwd"
> -
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/types.h>
> -#include <linux/miscdevice.h>
> -#include <linux/ioport.h>
> -#include <linux/watchdog.h>
> -#include <linux/fs.h>
> -#include <linux/reboot.h>
> -#include <linux/init.h>
> -#include <linux/jiffies.h>
> -#include <linux/timer.h>
> -#include <linux/uaccess.h>
> -#include <linux/io.h>
> -
> -/*
> - * We have two types of cards that can be probed:
> - * 1) The Mixcom cards: these cards can be found at addresses
> - *    0x180, 0x280, 0x380 with an additional offset of 0xc10.
> - *    (Or 0xd90, 0xe90, 0xf90).
> - * 2) The FlashCOM cards: these cards can be set up at
> - *    0x300 -> 0x378, in 0x8 jumps with an offset of 0x04.
> - *    (Or 0x304 -> 0x37c in 0x8 jumps).
> - *    Each card has it's own ID.
> - */
> -#define MIXCOM_ID 0x11
> -#define FLASHCOM_ID 0x18
> -static struct {
> -	int ioport;
> -	int id;
> -} mixcomwd_io_info[] = {
> -	/* The Mixcom cards */
> -	{0x0d90, MIXCOM_ID},
> -	{0x0e90, MIXCOM_ID},
> -	{0x0f90, MIXCOM_ID},
> -	/* The FlashCOM cards */
> -	{0x0304, FLASHCOM_ID},
> -	{0x030c, FLASHCOM_ID},
> -	{0x0314, FLASHCOM_ID},
> -	{0x031c, FLASHCOM_ID},
> -	{0x0324, FLASHCOM_ID},
> -	{0x032c, FLASHCOM_ID},
> -	{0x0334, FLASHCOM_ID},
> -	{0x033c, FLASHCOM_ID},
> -	{0x0344, FLASHCOM_ID},
> -	{0x034c, FLASHCOM_ID},
> -	{0x0354, FLASHCOM_ID},
> -	{0x035c, FLASHCOM_ID},
> -	{0x0364, FLASHCOM_ID},
> -	{0x036c, FLASHCOM_ID},
> -	{0x0374, FLASHCOM_ID},
> -	{0x037c, FLASHCOM_ID},
> -	/* The end of the list */
> -	{0x0000, 0},
> -};
> -
> -static void mixcomwd_timerfun(struct timer_list *unused);
> -
> -static unsigned long mixcomwd_opened; /* long req'd for setbit --RR */
> -
> -static int watchdog_port;
> -static int mixcomwd_timer_alive;
> -static DEFINE_TIMER(mixcomwd_timer, mixcomwd_timerfun);
> -static char expect_close;
> -
> -static bool nowayout = WATCHDOG_NOWAYOUT;
> -module_param(nowayout, bool, 0);
> -MODULE_PARM_DESC(nowayout,
> -		"Watchdog cannot be stopped once started (default="
> -				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> -
> -static void mixcomwd_ping(void)
> -{
> -	outb_p(55, watchdog_port);
> -	return;
> -}
> -
> -static void mixcomwd_timerfun(struct timer_list *unused)
> -{
> -	mixcomwd_ping();
> -	mod_timer(&mixcomwd_timer, jiffies + 5 * HZ);
> -}
> -
> -/*
> - *	Allow only one person to hold it open
> - */
> -
> -static int mixcomwd_open(struct inode *inode, struct file *file)
> -{
> -	if (test_and_set_bit(0, &mixcomwd_opened))
> -		return -EBUSY;
> -
> -	mixcomwd_ping();
> -
> -	if (nowayout)
> -		/*
> -		 * fops_get() code via open() has already done
> -		 * a try_module_get() so it is safe to do the
> -		 * __module_get().
> -		 */
> -		__module_get(THIS_MODULE);
> -	else {
> -		if (mixcomwd_timer_alive) {
> -			timer_delete(&mixcomwd_timer);
> -			mixcomwd_timer_alive = 0;
> -		}
> -	}
> -	return stream_open(inode, file);
> -}
> -
> -static int mixcomwd_release(struct inode *inode, struct file *file)
> -{
> -	if (expect_close == 42) {
> -		if (mixcomwd_timer_alive) {
> -			pr_err("release called while internal timer alive\n");
> -			return -EBUSY;
> -		}
> -		mixcomwd_timer_alive = 1;
> -		mod_timer(&mixcomwd_timer, jiffies + 5 * HZ);
> -	} else
> -		pr_crit("WDT device closed unexpectedly.  WDT will not stop!\n");
> -
> -	clear_bit(0, &mixcomwd_opened);
> -	expect_close = 0;
> -	return 0;
> -}
> -
> -
> -static ssize_t mixcomwd_write(struct file *file, const char __user *data,
> -						size_t len, loff_t *ppos)
> -{
> -	if (len) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			/* In case it was set long ago */
> -			expect_close = 0;
> -
> -			for (i = 0; i != len; i++) {
> -				char c;
> -				if (get_user(c, data + i))
> -					return -EFAULT;
> -				if (c == 'V')
> -					expect_close = 42;
> -			}
> -		}
> -		mixcomwd_ping();
> -	}
> -	return len;
> -}
> -
> -static long mixcomwd_ioctl(struct file *file,
> -				unsigned int cmd, unsigned long arg)
> -{
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = argp;
> -	int status;
> -	static const struct watchdog_info ident = {
> -		.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> -		.firmware_version = 1,
> -		.identity = "MixCOM watchdog",
> -	};
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		if (copy_to_user(argp, &ident, sizeof(ident)))
> -			return -EFAULT;
> -		break;
> -	case WDIOC_GETSTATUS:
> -		status = mixcomwd_opened;
> -		if (!nowayout)
> -			status |= mixcomwd_timer_alive;
> -		return put_user(status, p);
> -	case WDIOC_GETBOOTSTATUS:
> -		return put_user(0, p);
> -	case WDIOC_KEEPALIVE:
> -		mixcomwd_ping();
> -		break;
> -	default:
> -		return -ENOTTY;
> -	}
> -	return 0;
> -}
> -
> -static const struct file_operations mixcomwd_fops = {
> -	.owner		= THIS_MODULE,
> -	.write		= mixcomwd_write,
> -	.unlocked_ioctl	= mixcomwd_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> -	.open		= mixcomwd_open,
> -	.release	= mixcomwd_release,
> -};
> -
> -static struct miscdevice mixcomwd_miscdev = {
> -	.minor	= WATCHDOG_MINOR,
> -	.name	= "watchdog",
> -	.fops	= &mixcomwd_fops,
> -};
> -
> -static int __init checkcard(int port, int card_id)
> -{
> -	int id;
> -
> -	if (!request_region(port, 1, "MixCOM watchdog"))
> -		return 0;
> -
> -	id = inb_p(port);
> -	if (card_id == MIXCOM_ID)
> -		id &= 0x3f;
> -
> -	if (id != card_id) {
> -		release_region(port, 1);
> -		return 0;
> -	}
> -	return 1;
> -}
> -
> -static int __init mixcomwd_init(void)
> -{
> -	int i, ret, found = 0;
> -
> -	for (i = 0; !found && mixcomwd_io_info[i].ioport != 0; i++) {
> -		if (checkcard(mixcomwd_io_info[i].ioport,
> -			      mixcomwd_io_info[i].id)) {
> -			found = 1;
> -			watchdog_port = mixcomwd_io_info[i].ioport;
> -		}
> -	}
> -
> -	if (!found) {
> -		pr_err("No card detected, or port not available\n");
> -		return -ENODEV;
> -	}
> -
> -	ret = misc_register(&mixcomwd_miscdev);
> -	if (ret) {
> -		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -		       WATCHDOG_MINOR, ret);
> -		goto error_misc_register_watchdog;
> -	}
> -
> -	pr_info("MixCOM watchdog driver v%s, watchdog port at 0x%3x\n",
> -		VERSION, watchdog_port);
> -
> -	return 0;
> -
> -error_misc_register_watchdog:
> -	release_region(watchdog_port, 1);
> -	watchdog_port = 0x0000;
> -	return ret;
> -}
> -
> -static void __exit mixcomwd_exit(void)
> -{
> -	if (!nowayout) {
> -		if (mixcomwd_timer_alive) {
> -			pr_warn("I quit now, hardware will probably reboot!\n");
> -			timer_delete_sync(&mixcomwd_timer);
> -			mixcomwd_timer_alive = 0;
> -		}
> -	}
> -	misc_deregister(&mixcomwd_miscdev);
> -	release_region(watchdog_port, 1);
> -}
> -
> -module_init(mixcomwd_init);
> -module_exit(mixcomwd_exit);
> -
> -MODULE_AUTHOR("Gergely Madarasz <gorgo@itc.hu>");
> -MODULE_DESCRIPTION("MixCom Watchdog driver");
> -MODULE_VERSION(VERSION);
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
> deleted file mode 100644
> index d4ea7d6ccd6a..000000000000
> --- a/drivers/watchdog/pcwd.c
> +++ /dev/null
> @@ -1,996 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * PC Watchdog Driver
> - * by Ken Hollis (khollis@bitgate.com)
> - *
> - * Permission granted from Simon Machell (smachell@berkprod.com)
> - * Written for the Linux Kernel, and GPLed by Ken Hollis
> - *
> - * 960107	Added request_region routines, modulized the whole thing.
> - * 960108	Fixed end-of-file pointer (Thanks to Dan Hollis), added
> - *		WD_TIMEOUT define.
> - * 960216	Added eof marker on the file, and changed verbose messages.
> - * 960716	Made functional and cosmetic changes to the source for
> - *		inclusion in Linux 2.0.x kernels, thanks to Alan Cox.
> - * 960717	Removed read/seek routines, replaced with ioctl.  Also, added
> - *		check_region command due to Alan's suggestion.
> - * 960821	Made changes to compile in newer 2.0.x kernels.  Added
> - *		"cold reboot sense" entry.
> - * 960825	Made a few changes to code, deleted some defines and made
> - *		typedefs to replace them.  Made heartbeat reset only available
> - *		via ioctl, and removed the write routine.
> - * 960828	Added new items for PC Watchdog Rev.C card.
> - * 960829	Changed around all of the IOCTLs, added new features,
> - *		added watchdog disable/re-enable routines.  Added firmware
> - *		version reporting.  Added read routine for temperature.
> - *		Removed some extra defines, added an autodetect Revision
> - *		routine.
> - * 961006	Revised some documentation, fixed some cosmetic bugs.  Made
> - *		drivers to panic the system if it's overheating at bootup.
> - * 961118	Changed some verbiage on some of the output, tidied up
> - *		code bits, and added compatibility to 2.1.x.
> - * 970912	Enabled board on open and disable on close.
> - * 971107	Took account of recent VFS changes (broke read).
> - * 971210	Disable board on initialisation in case board already ticking.
> - * 971222	Changed open/close for temperature handling
> - *		Michael Meskes <meskes@debian.org>.
> - * 980112	Used minor numbers from include/linux/miscdevice.h
> - * 990403	Clear reset status after reading control status register in
> - *		pcwd_showprevstate(). [Marc Boucher <marc@mbsi.ca>]
> - * 990605	Made changes to code to support Firmware 1.22a, added
> - *		fairly useless proc entry.
> - * 990610	removed said useless proc code for the merge <alan>
> - * 000403	Removed last traces of proc code. <davej>
> - * 011214	Added nowayout module option to override
> - *		CONFIG_WATCHDOG_NOWAYOUT <Matt_Domsch@dell.com>
> - *		Added timeout module option to override default
> - */
> -
> -/*
> - *	A bells and whistles driver is available from http://www.pcwd.de/
> - *	More info available at http://www.berkprod.com/ or
> - *	http://www.pcwatchdog.com/
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/module.h>	/* For module specific items */
> -#include <linux/moduleparam.h>	/* For new moduleparam's */
> -#include <linux/types.h>	/* For standard types (like size_t) */
> -#include <linux/errno.h>	/* For the -ENODEV/... values */
> -#include <linux/kernel.h>	/* For printk/panic/... */
> -#include <linux/delay.h>	/* For mdelay function */
> -#include <linux/timer.h>	/* For timer related operations */
> -#include <linux/jiffies.h>	/* For jiffies stuff */
> -#include <linux/miscdevice.h>	/* For struct miscdevice */
> -#include <linux/watchdog.h>	/* For the watchdog specific items */
> -#include <linux/reboot.h>	/* For kernel_power_off() */
> -#include <linux/init.h>		/* For __init/__exit/... */
> -#include <linux/fs.h>		/* For file operations */
> -#include <linux/isa.h>		/* For isa devices */
> -#include <linux/ioport.h>	/* For io-port access */
> -#include <linux/spinlock.h>	/* For spin_lock/spin_unlock/... */
> -#include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
> -#include <linux/io.h>		/* For inb/outb/... */
> -
> -/* Module and version information */
> -#define WATCHDOG_VERSION "1.20"
> -#define WATCHDOG_DATE "18 Feb 2007"
> -#define WATCHDOG_DRIVER_NAME "ISA-PC Watchdog"
> -#define WATCHDOG_NAME "pcwd"
> -#define DRIVER_VERSION WATCHDOG_DRIVER_NAME " driver, v" WATCHDOG_VERSION "\n"
> -
> -/*
> - * It should be noted that PCWD_REVISION_B was removed because A and B
> - * are essentially the same types of card, with the exception that B
> - * has temperature reporting.  Since I didn't receive a Rev.B card,
> - * the Rev.B card is not supported.  (It's a good thing too, as they
> - * are no longer in production.)
> - */
> -#define	PCWD_REVISION_A		1
> -#define	PCWD_REVISION_C		2
> -
> -/*
> - * These are the auto-probe addresses available.
> - *
> - * Revision A only uses ports 0x270 and 0x370.  Revision C introduced 0x350.
> - * Revision A has an address range of 2 addresses, while Revision C has 4.
> - */
> -#define PCWD_ISA_NR_CARDS	3
> -static int pcwd_ioports[] = { 0x270, 0x350, 0x370, 0x000 };
> -
> -/*
> - * These are the defines that describe the control status bits for the
> - * PCI-PC Watchdog card.
> -*/
> -/* Port 1 : Control Status #1 for the PC Watchdog card, revision A. */
> -#define WD_WDRST		0x01	/* Previously reset state */
> -#define WD_T110			0x02	/* Temperature overheat sense */
> -#define WD_HRTBT		0x04	/* Heartbeat sense */
> -#define WD_RLY2			0x08	/* External relay triggered */
> -#define WD_SRLY2		0x80	/* Software external relay triggered */
> -/* Port 1 : Control Status #1 for the PC Watchdog card, revision C. */
> -#define WD_REVC_WTRP		0x01	/* Watchdog Trip status */
> -#define WD_REVC_HRBT		0x02	/* Watchdog Heartbeat */
> -#define WD_REVC_TTRP		0x04	/* Temperature Trip status */
> -#define WD_REVC_RL2A		0x08	/* Relay 2 activated by
> -							on-board processor */
> -#define WD_REVC_RL1A		0x10	/* Relay 1 active */
> -#define WD_REVC_R2DS		0x40	/* Relay 2 disable */
> -#define WD_REVC_RLY2		0x80	/* Relay 2 activated? */
> -/* Port 2 : Control Status #2 */
> -#define WD_WDIS			0x10	/* Watchdog Disabled */
> -#define WD_ENTP			0x20	/* Watchdog Enable Temperature Trip */
> -#define WD_SSEL			0x40	/* Watchdog Switch Select
> -							(1:SW1 <-> 0:SW2) */
> -#define WD_WCMD			0x80	/* Watchdog Command Mode */
> -
> -/* max. time we give an ISA watchdog card to process a command */
> -/* 500ms for each 4 bit response (according to spec.) */
> -#define ISA_COMMAND_TIMEOUT     1000
> -
> -/* Watchdog's internal commands */
> -#define CMD_ISA_IDLE			0x00
> -#define CMD_ISA_VERSION_INTEGER		0x01
> -#define CMD_ISA_VERSION_TENTH		0x02
> -#define CMD_ISA_VERSION_HUNDRETH	0x03
> -#define CMD_ISA_VERSION_MINOR		0x04
> -#define CMD_ISA_SWITCH_SETTINGS		0x05
> -#define CMD_ISA_RESET_PC		0x06
> -#define CMD_ISA_ARM_0			0x07
> -#define CMD_ISA_ARM_30			0x08
> -#define CMD_ISA_ARM_60			0x09
> -#define CMD_ISA_DELAY_TIME_2SECS	0x0A
> -#define CMD_ISA_DELAY_TIME_4SECS	0x0B
> -#define CMD_ISA_DELAY_TIME_8SECS	0x0C
> -#define CMD_ISA_RESET_RELAYS		0x0D
> -
> -/* Watchdog's Dip Switch heartbeat values */
> -static const int heartbeat_tbl[] = {
> -	20,	/* OFF-OFF-OFF	= 20 Sec  */
> -	40,	/* OFF-OFF-ON	= 40 Sec  */
> -	60,	/* OFF-ON-OFF	=  1 Min  */
> -	300,	/* OFF-ON-ON	=  5 Min  */
> -	600,	/* ON-OFF-OFF	= 10 Min  */
> -	1800,	/* ON-OFF-ON	= 30 Min  */
> -	3600,	/* ON-ON-OFF	=  1 Hour */
> -	7200,	/* ON-ON-ON	=  2 hour */
> -};
> -
> -/*
> - * We are using an kernel timer to do the pinging of the watchdog
> - * every ~500ms. We try to set the internal heartbeat of the
> - * watchdog to 2 ms.
> - */
> -
> -#define WDT_INTERVAL (HZ/2+1)
> -
> -/* We can only use 1 card due to the /dev/watchdog restriction */
> -static int cards_found;
> -
> -/* internal variables */
> -static unsigned long open_allowed;
> -static char expect_close;
> -static int temp_panic;
> -
> -/* this is private data for each ISA-PC watchdog card */
> -static struct {
> -	char fw_ver_str[6];		/* The cards firmware version */
> -	int revision;			/* The card's revision */
> -	int supports_temp;		/* Whether or not the card has
> -						a temperature device */
> -	int command_mode;		/* Whether or not the card is in
> -						command mode */
> -	int boot_status;		/* The card's boot status */
> -	int io_addr;			/* The cards I/O address */
> -	spinlock_t io_lock;		/* the lock for io operations */
> -	struct timer_list timer;	/* The timer that pings the watchdog */
> -	unsigned long next_heartbeat;	/* the next_heartbeat for the timer */
> -} pcwd_private;
> -
> -/* module parameters */
> -#define QUIET	0	/* Default */
> -#define VERBOSE	1	/* Verbose */
> -#define DEBUG	2	/* print fancy stuff too */
> -static int debug = QUIET;
> -module_param(debug, int, 0);
> -MODULE_PARM_DESC(debug,
> -		"Debug level: 0=Quiet, 1=Verbose, 2=Debug (default=0)");
> -
> -/* default heartbeat = delay-time from dip-switches */
> -#define WATCHDOG_HEARTBEAT 0
> -static int heartbeat = WATCHDOG_HEARTBEAT;
> -module_param(heartbeat, int, 0);
> -MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. "
> -	"(2 <= heartbeat <= 7200 or 0=delay-time from dip-switches, default="
> -				__MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
> -
> -static bool nowayout = WATCHDOG_NOWAYOUT;
> -module_param(nowayout, bool, 0);
> -MODULE_PARM_DESC(nowayout,
> -		"Watchdog cannot be stopped once started (default="
> -				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> -
> -/*
> - *	Internal functions
> - */
> -
> -static int send_isa_command(int cmd)
> -{
> -	int i;
> -	int control_status;
> -	int port0, last_port0;	/* Double read for stabilising */
> -
> -	if (debug >= DEBUG)
> -		pr_debug("sending following data cmd=0x%02x\n", cmd);
> -
> -	/* The WCMD bit must be 1 and the command is only 4 bits in size */
> -	control_status = (cmd & 0x0F) | WD_WCMD;
> -	outb_p(control_status, pcwd_private.io_addr + 2);
> -	udelay(ISA_COMMAND_TIMEOUT);
> -
> -	port0 = inb_p(pcwd_private.io_addr);
> -	for (i = 0; i < 25; ++i) {
> -		last_port0 = port0;
> -		port0 = inb_p(pcwd_private.io_addr);
> -
> -		if (port0 == last_port0)
> -			break;	/* Data is stable */
> -
> -		udelay(250);
> -	}
> -
> -	if (debug >= DEBUG)
> -		pr_debug("received following data for cmd=0x%02x: port0=0x%02x last_port0=0x%02x\n",
> -			 cmd, port0, last_port0);
> -
> -	return port0;
> -}
> -
> -static int set_command_mode(void)
> -{
> -	int i, found = 0, count = 0;
> -
> -	/* Set the card into command mode */
> -	spin_lock(&pcwd_private.io_lock);
> -	while ((!found) && (count < 3)) {
> -		i = send_isa_command(CMD_ISA_IDLE);
> -
> -		if (i == 0x00)
> -			found = 1;
> -		else if (i == 0xF3) {
> -			/* Card does not like what we've done to it */
> -			outb_p(0x00, pcwd_private.io_addr + 2);
> -			udelay(1200);	/* Spec says wait 1ms */
> -			outb_p(0x00, pcwd_private.io_addr + 2);
> -			udelay(ISA_COMMAND_TIMEOUT);
> -		}
> -		count++;
> -	}
> -	spin_unlock(&pcwd_private.io_lock);
> -	pcwd_private.command_mode = found;
> -
> -	if (debug >= DEBUG)
> -		pr_debug("command_mode=%d\n", pcwd_private.command_mode);
> -
> -	return found;
> -}
> -
> -static void unset_command_mode(void)
> -{
> -	/* Set the card into normal mode */
> -	spin_lock(&pcwd_private.io_lock);
> -	outb_p(0x00, pcwd_private.io_addr + 2);
> -	udelay(ISA_COMMAND_TIMEOUT);
> -	spin_unlock(&pcwd_private.io_lock);
> -
> -	pcwd_private.command_mode = 0;
> -
> -	if (debug >= DEBUG)
> -		pr_debug("command_mode=%d\n", pcwd_private.command_mode);
> -}
> -
> -static inline void pcwd_check_temperature_support(void)
> -{
> -	if (inb(pcwd_private.io_addr) != 0xF0)
> -		pcwd_private.supports_temp = 1;
> -}
> -
> -static inline void pcwd_get_firmware(void)
> -{
> -	int one, ten, hund, minor;
> -
> -	strcpy(pcwd_private.fw_ver_str, "ERROR");
> -
> -	if (set_command_mode()) {
> -		one = send_isa_command(CMD_ISA_VERSION_INTEGER);
> -		ten = send_isa_command(CMD_ISA_VERSION_TENTH);
> -		hund = send_isa_command(CMD_ISA_VERSION_HUNDRETH);
> -		minor = send_isa_command(CMD_ISA_VERSION_MINOR);
> -		sprintf(pcwd_private.fw_ver_str, "%c.%c%c%c",
> -					one, ten, hund, minor);
> -	}
> -	unset_command_mode();
> -
> -	return;
> -}
> -
> -static inline int pcwd_get_option_switches(void)
> -{
> -	int option_switches = 0;
> -
> -	if (set_command_mode()) {
> -		/* Get switch settings */
> -		option_switches = send_isa_command(CMD_ISA_SWITCH_SETTINGS);
> -	}
> -
> -	unset_command_mode();
> -	return option_switches;
> -}
> -
> -static void pcwd_show_card_info(void)
> -{
> -	int option_switches;
> -
> -	/* Get some extra info from the hardware (in command/debug/diag mode) */
> -	if (pcwd_private.revision == PCWD_REVISION_A)
> -		pr_info("ISA-PC Watchdog (REV.A) detected at port 0x%04x\n",
> -			pcwd_private.io_addr);
> -	else if (pcwd_private.revision == PCWD_REVISION_C) {
> -		pcwd_get_firmware();
> -		pr_info("ISA-PC Watchdog (REV.C) detected at port 0x%04x (Firmware version: %s)\n",
> -			pcwd_private.io_addr, pcwd_private.fw_ver_str);
> -		option_switches = pcwd_get_option_switches();
> -		pr_info("Option switches (0x%02x): Temperature Reset Enable=%s, Power On Delay=%s\n",
> -			option_switches,
> -			((option_switches & 0x10) ? "ON" : "OFF"),
> -			((option_switches & 0x08) ? "ON" : "OFF"));
> -
> -		/* Reprogram internal heartbeat to 2 seconds */
> -		if (set_command_mode()) {
> -			send_isa_command(CMD_ISA_DELAY_TIME_2SECS);
> -			unset_command_mode();
> -		}
> -	}
> -
> -	if (pcwd_private.supports_temp)
> -		pr_info("Temperature Option Detected\n");
> -
> -	if (pcwd_private.boot_status & WDIOF_CARDRESET)
> -		pr_info("Previous reboot was caused by the card\n");
> -
> -	if (pcwd_private.boot_status & WDIOF_OVERHEAT) {
> -		pr_emerg("Card senses a CPU Overheat. Panicking!\n");
> -		pr_emerg("CPU Overheat\n");
> -	}
> -
> -	if (pcwd_private.boot_status == 0)
> -		pr_info("No previous trip detected - Cold boot or reset\n");
> -}
> -
> -static void pcwd_timer_ping(struct timer_list *unused)
> -{
> -	int wdrst_stat;
> -
> -	/* If we got a heartbeat pulse within the WDT_INTERVAL
> -	 * we agree to ping the WDT */
> -	if (time_before(jiffies, pcwd_private.next_heartbeat)) {
> -		/* Ping the watchdog */
> -		spin_lock(&pcwd_private.io_lock);
> -		if (pcwd_private.revision == PCWD_REVISION_A) {
> -			/*  Rev A cards are reset by setting the
> -			    WD_WDRST bit in register 1 */
> -			wdrst_stat = inb_p(pcwd_private.io_addr);
> -			wdrst_stat &= 0x0F;
> -			wdrst_stat |= WD_WDRST;
> -
> -			outb_p(wdrst_stat, pcwd_private.io_addr + 1);
> -		} else {
> -			/* Re-trigger watchdog by writing to port 0 */
> -			outb_p(0x00, pcwd_private.io_addr);
> -		}
> -
> -		/* Re-set the timer interval */
> -		mod_timer(&pcwd_private.timer, jiffies + WDT_INTERVAL);
> -
> -		spin_unlock(&pcwd_private.io_lock);
> -	} else {
> -		pr_warn("Heartbeat lost! Will not ping the watchdog\n");
> -	}
> -}
> -
> -static int pcwd_start(void)
> -{
> -	int stat_reg;
> -
> -	pcwd_private.next_heartbeat = jiffies + (heartbeat * HZ);
> -
> -	/* Start the timer */
> -	mod_timer(&pcwd_private.timer, jiffies + WDT_INTERVAL);
> -
> -	/* Enable the port */
> -	if (pcwd_private.revision == PCWD_REVISION_C) {
> -		spin_lock(&pcwd_private.io_lock);
> -		outb_p(0x00, pcwd_private.io_addr + 3);
> -		udelay(ISA_COMMAND_TIMEOUT);
> -		stat_reg = inb_p(pcwd_private.io_addr + 2);
> -		spin_unlock(&pcwd_private.io_lock);
> -		if (stat_reg & WD_WDIS) {
> -			pr_info("Could not start watchdog\n");
> -			return -EIO;
> -		}
> -	}
> -
> -	if (debug >= VERBOSE)
> -		pr_debug("Watchdog started\n");
> -
> -	return 0;
> -}
> -
> -static int pcwd_stop(void)
> -{
> -	int stat_reg;
> -
> -	/* Stop the timer */
> -	timer_delete(&pcwd_private.timer);
> -
> -	/*  Disable the board  */
> -	if (pcwd_private.revision == PCWD_REVISION_C) {
> -		spin_lock(&pcwd_private.io_lock);
> -		outb_p(0xA5, pcwd_private.io_addr + 3);
> -		udelay(ISA_COMMAND_TIMEOUT);
> -		outb_p(0xA5, pcwd_private.io_addr + 3);
> -		udelay(ISA_COMMAND_TIMEOUT);
> -		stat_reg = inb_p(pcwd_private.io_addr + 2);
> -		spin_unlock(&pcwd_private.io_lock);
> -		if ((stat_reg & WD_WDIS) == 0) {
> -			pr_info("Could not stop watchdog\n");
> -			return -EIO;
> -		}
> -	}
> -
> -	if (debug >= VERBOSE)
> -		pr_debug("Watchdog stopped\n");
> -
> -	return 0;
> -}
> -
> -static int pcwd_keepalive(void)
> -{
> -	/* user land ping */
> -	pcwd_private.next_heartbeat = jiffies + (heartbeat * HZ);
> -
> -	if (debug >= DEBUG)
> -		pr_debug("Watchdog keepalive signal send\n");
> -
> -	return 0;
> -}
> -
> -static int pcwd_set_heartbeat(int t)
> -{
> -	if (t < 2 || t > 7200) /* arbitrary upper limit */
> -		return -EINVAL;
> -
> -	heartbeat = t;
> -
> -	if (debug >= VERBOSE)
> -		pr_debug("New heartbeat: %d\n", heartbeat);
> -
> -	return 0;
> -}
> -
> -static int pcwd_get_status(int *status)
> -{
> -	int control_status;
> -
> -	*status = 0;
> -	spin_lock(&pcwd_private.io_lock);
> -	if (pcwd_private.revision == PCWD_REVISION_A)
> -		/* Rev A cards return status information from
> -		 * the base register, which is used for the
> -		 * temperature in other cards. */
> -		control_status = inb(pcwd_private.io_addr);
> -	else {
> -		/* Rev C cards return card status in the base
> -		 * address + 1 register. And use different bits
> -		 * to indicate a card initiated reset, and an
> -		 * over-temperature condition. And the reboot
> -		 * status can be reset. */
> -		control_status = inb(pcwd_private.io_addr + 1);
> -	}
> -	spin_unlock(&pcwd_private.io_lock);
> -
> -	if (pcwd_private.revision == PCWD_REVISION_A) {
> -		if (control_status & WD_WDRST)
> -			*status |= WDIOF_CARDRESET;
> -
> -		if (control_status & WD_T110) {
> -			*status |= WDIOF_OVERHEAT;
> -			if (temp_panic) {
> -				pr_info("Temperature overheat trip!\n");
> -				kernel_power_off();
> -			}
> -		}
> -	} else {
> -		if (control_status & WD_REVC_WTRP)
> -			*status |= WDIOF_CARDRESET;
> -
> -		if (control_status & WD_REVC_TTRP) {
> -			*status |= WDIOF_OVERHEAT;
> -			if (temp_panic) {
> -				pr_info("Temperature overheat trip!\n");
> -				kernel_power_off();
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int pcwd_clear_status(void)
> -{
> -	int control_status;
> -
> -	if (pcwd_private.revision == PCWD_REVISION_C) {
> -		spin_lock(&pcwd_private.io_lock);
> -
> -		if (debug >= VERBOSE)
> -			pr_info("clearing watchdog trip status\n");
> -
> -		control_status = inb_p(pcwd_private.io_addr + 1);
> -
> -		if (debug >= DEBUG) {
> -			pr_debug("status was: 0x%02x\n", control_status);
> -			pr_debug("sending: 0x%02x\n",
> -				 (control_status & WD_REVC_R2DS));
> -		}
> -
> -		/* clear reset status & Keep Relay 2 disable state as it is */
> -		outb_p((control_status & WD_REVC_R2DS),
> -						pcwd_private.io_addr + 1);
> -
> -		spin_unlock(&pcwd_private.io_lock);
> -	}
> -	return 0;
> -}
> -
> -static int pcwd_get_temperature(int *temperature)
> -{
> -	/* check that port 0 gives temperature info and no command results */
> -	if (pcwd_private.command_mode)
> -		return -1;
> -
> -	*temperature = 0;
> -	if (!pcwd_private.supports_temp)
> -		return -ENODEV;
> -
> -	/*
> -	 * Convert celsius to fahrenheit, since this was
> -	 * the decided 'standard' for this return value.
> -	 */
> -	spin_lock(&pcwd_private.io_lock);
> -	*temperature = ((inb(pcwd_private.io_addr)) * 9 / 5) + 32;
> -	spin_unlock(&pcwd_private.io_lock);
> -
> -	if (debug >= DEBUG) {
> -		pr_debug("temperature is: %d F\n", *temperature);
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - *	/dev/watchdog handling
> - */
> -
> -static long pcwd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	int rv;
> -	int status;
> -	int temperature;
> -	int new_heartbeat;
> -	int __user *argp = (int __user *)arg;
> -	static const struct watchdog_info ident = {
> -		.options =		WDIOF_OVERHEAT |
> -					WDIOF_CARDRESET |
> -					WDIOF_KEEPALIVEPING |
> -					WDIOF_SETTIMEOUT |
> -					WDIOF_MAGICCLOSE,
> -		.firmware_version =	1,
> -		.identity =		"PCWD",
> -	};
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		if (copy_to_user(argp, &ident, sizeof(ident)))
> -			return -EFAULT;
> -		return 0;
> -
> -	case WDIOC_GETSTATUS:
> -		pcwd_get_status(&status);
> -		return put_user(status, argp);
> -
> -	case WDIOC_GETBOOTSTATUS:
> -		return put_user(pcwd_private.boot_status, argp);
> -
> -	case WDIOC_GETTEMP:
> -		if (pcwd_get_temperature(&temperature))
> -			return -EFAULT;
> -
> -		return put_user(temperature, argp);
> -
> -	case WDIOC_SETOPTIONS:
> -		if (pcwd_private.revision == PCWD_REVISION_C) {
> -			if (get_user(rv, argp))
> -				return -EFAULT;
> -
> -			if (rv & WDIOS_DISABLECARD) {
> -				status = pcwd_stop();
> -				if (status < 0)
> -					return status;
> -			}
> -			if (rv & WDIOS_ENABLECARD) {
> -				status = pcwd_start();
> -				if (status < 0)
> -					return status;
> -			}
> -			if (rv & WDIOS_TEMPPANIC)
> -				temp_panic = 1;
> -		}
> -		return -EINVAL;
> -
> -	case WDIOC_KEEPALIVE:
> -		pcwd_keepalive();
> -		return 0;
> -
> -	case WDIOC_SETTIMEOUT:
> -		if (get_user(new_heartbeat, argp))
> -			return -EFAULT;
> -
> -		if (pcwd_set_heartbeat(new_heartbeat))
> -			return -EINVAL;
> -
> -		pcwd_keepalive();
> -		fallthrough;
> -
> -	case WDIOC_GETTIMEOUT:
> -		return put_user(heartbeat, argp);
> -
> -	default:
> -		return -ENOTTY;
> -	}
> -
> -	return 0;
> -}
> -
> -static ssize_t pcwd_write(struct file *file, const char __user *buf, size_t len,
> -			  loff_t *ppos)
> -{
> -	if (len) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			/* In case it was set long ago */
> -			expect_close = 0;
> -
> -			for (i = 0; i != len; i++) {
> -				char c;
> -
> -				if (get_user(c, buf + i))
> -					return -EFAULT;
> -				if (c == 'V')
> -					expect_close = 42;
> -			}
> -		}
> -		pcwd_keepalive();
> -	}
> -	return len;
> -}
> -
> -static int pcwd_open(struct inode *inode, struct file *file)
> -{
> -	if (test_and_set_bit(0, &open_allowed))
> -		return -EBUSY;
> -	if (nowayout)
> -		__module_get(THIS_MODULE);
> -	/* Activate */
> -	pcwd_start();
> -	pcwd_keepalive();
> -	return stream_open(inode, file);
> -}
> -
> -static int pcwd_close(struct inode *inode, struct file *file)
> -{
> -	if (expect_close == 42)
> -		pcwd_stop();
> -	else {
> -		pr_crit("Unexpected close, not stopping watchdog!\n");
> -		pcwd_keepalive();
> -	}
> -	expect_close = 0;
> -	clear_bit(0, &open_allowed);
> -	return 0;
> -}
> -
> -/*
> - *	/dev/temperature handling
> - */
> -
> -static ssize_t pcwd_temp_read(struct file *file, char __user *buf, size_t count,
> -			 loff_t *ppos)
> -{
> -	int temperature;
> -
> -	if (pcwd_get_temperature(&temperature))
> -		return -EFAULT;
> -
> -	if (copy_to_user(buf, &temperature, 1))
> -		return -EFAULT;
> -
> -	return 1;
> -}
> -
> -static int pcwd_temp_open(struct inode *inode, struct file *file)
> -{
> -	if (!pcwd_private.supports_temp)
> -		return -ENODEV;
> -
> -	return stream_open(inode, file);
> -}
> -
> -static int pcwd_temp_close(struct inode *inode, struct file *file)
> -{
> -	return 0;
> -}
> -
> -/*
> - *	Kernel Interfaces
> - */
> -
> -static const struct file_operations pcwd_fops = {
> -	.owner		= THIS_MODULE,
> -	.write		= pcwd_write,
> -	.unlocked_ioctl	= pcwd_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> -	.open		= pcwd_open,
> -	.release	= pcwd_close,
> -};
> -
> -static struct miscdevice pcwd_miscdev = {
> -	.minor =	WATCHDOG_MINOR,
> -	.name =		"watchdog",
> -	.fops =		&pcwd_fops,
> -};
> -
> -static const struct file_operations pcwd_temp_fops = {
> -	.owner		= THIS_MODULE,
> -	.read		= pcwd_temp_read,
> -	.open		= pcwd_temp_open,
> -	.release	= pcwd_temp_close,
> -};
> -
> -static struct miscdevice temp_miscdev = {
> -	.minor =	TEMP_MINOR,
> -	.name =		"temperature",
> -	.fops =		&pcwd_temp_fops,
> -};
> -
> -/*
> - *	Init & exit routines
> - */
> -
> -static inline int get_revision(void)
> -{
> -	int r = PCWD_REVISION_C;
> -
> -	spin_lock(&pcwd_private.io_lock);
> -	/* REV A cards use only 2 io ports; test
> -	 * presumes a floating bus reads as 0xff. */
> -	if ((inb(pcwd_private.io_addr + 2) == 0xFF) ||
> -	    (inb(pcwd_private.io_addr + 3) == 0xFF))
> -		r = PCWD_REVISION_A;
> -	spin_unlock(&pcwd_private.io_lock);
> -
> -	return r;
> -}
> -
> -/*
> - *  The ISA cards have a heartbeat bit in one of the registers, which
> - *  register is card dependent.  The heartbeat bit is monitored, and if
> - *  found, is considered proof that a Berkshire card has been found.
> - *  The initial rate is once per second at board start up, then twice
> - *  per second for normal operation.
> - */
> -static int pcwd_isa_match(struct device *dev, unsigned int id)
> -{
> -	int base_addr = pcwd_ioports[id];
> -	int port0, last_port0;	/* Reg 0, in case it's REV A */
> -	int port1, last_port1;	/* Register 1 for REV C cards */
> -	int i;
> -	int retval;
> -
> -	if (debug >= DEBUG)
> -		pr_debug("pcwd_isa_match id=%d\n", id);
> -
> -	if (!request_region(base_addr, 4, "PCWD")) {
> -		pr_info("Port 0x%04x unavailable\n", base_addr);
> -		return 0;
> -	}
> -
> -	retval = 0;
> -
> -	port0 = inb_p(base_addr);	/* For REV A boards */
> -	port1 = inb_p(base_addr + 1);	/* For REV C boards */
> -	if (port0 != 0xff || port1 != 0xff) {
> -		/* Not an 'ff' from a floating bus, so must be a card! */
> -		for (i = 0; i < 4; ++i) {
> -
> -			msleep(500);
> -
> -			last_port0 = port0;
> -			last_port1 = port1;
> -
> -			port0 = inb_p(base_addr);
> -			port1 = inb_p(base_addr + 1);
> -
> -			/* Has either heartbeat bit changed?  */
> -			if ((port0 ^ last_port0) & WD_HRTBT ||
> -			    (port1 ^ last_port1) & WD_REVC_HRBT) {
> -				retval = 1;
> -				break;
> -			}
> -		}
> -	}
> -	release_region(base_addr, 4);
> -
> -	return retval;
> -}
> -
> -static int pcwd_isa_probe(struct device *dev, unsigned int id)
> -{
> -	int ret;
> -
> -	if (debug >= DEBUG)
> -		pr_debug("pcwd_isa_probe id=%d\n", id);
> -
> -	cards_found++;
> -	if (cards_found == 1)
> -		pr_info("v%s Ken Hollis (kenji@bitgate.com)\n",
> -							WATCHDOG_VERSION);
> -
> -	if (cards_found > 1) {
> -		pr_err("This driver only supports 1 device\n");
> -		return -ENODEV;
> -	}
> -
> -	if (pcwd_ioports[id] == 0x0000) {
> -		pr_err("No I/O-Address for card detected\n");
> -		return -ENODEV;
> -	}
> -	pcwd_private.io_addr = pcwd_ioports[id];
> -
> -	spin_lock_init(&pcwd_private.io_lock);
> -
> -	/* Check card's revision */
> -	pcwd_private.revision = get_revision();
> -
> -	if (!request_region(pcwd_private.io_addr,
> -		(pcwd_private.revision == PCWD_REVISION_A) ? 2 : 4, "PCWD")) {
> -		pr_err("I/O address 0x%04x already in use\n",
> -		       pcwd_private.io_addr);
> -		ret = -EIO;
> -		goto error_request_region;
> -	}
> -
> -	/* Initial variables */
> -	pcwd_private.supports_temp = 0;
> -	temp_panic = 0;
> -	pcwd_private.boot_status = 0x0000;
> -
> -	/* get the boot_status */
> -	pcwd_get_status(&pcwd_private.boot_status);
> -
> -	/* clear the "card caused reboot" flag */
> -	pcwd_clear_status();
> -
> -	timer_setup(&pcwd_private.timer, pcwd_timer_ping, 0);
> -
> -	/*  Disable the board  */
> -	pcwd_stop();
> -
> -	/*  Check whether or not the card supports the temperature device */
> -	pcwd_check_temperature_support();
> -
> -	/* Show info about the card itself */
> -	pcwd_show_card_info();
> -
> -	/* If heartbeat = 0 then we use the heartbeat from the dip-switches */
> -	if (heartbeat == 0)
> -		heartbeat = heartbeat_tbl[(pcwd_get_option_switches() & 0x07)];
> -
> -	/* Check that the heartbeat value is within it's range;
> -	   if not reset to the default */
> -	if (pcwd_set_heartbeat(heartbeat)) {
> -		pcwd_set_heartbeat(WATCHDOG_HEARTBEAT);
> -		pr_info("heartbeat value must be 2 <= heartbeat <= 7200, using %d\n",
> -			WATCHDOG_HEARTBEAT);
> -	}
> -
> -	if (pcwd_private.supports_temp) {
> -		ret = misc_register(&temp_miscdev);
> -		if (ret) {
> -			pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -			       TEMP_MINOR, ret);
> -			goto error_misc_register_temp;
> -		}
> -	}
> -
> -	ret = misc_register(&pcwd_miscdev);
> -	if (ret) {
> -		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -		       WATCHDOG_MINOR, ret);
> -		goto error_misc_register_watchdog;
> -	}
> -
> -	pr_info("initialized. heartbeat=%d sec (nowayout=%d)\n",
> -		heartbeat, nowayout);
> -
> -	return 0;
> -
> -error_misc_register_watchdog:
> -	if (pcwd_private.supports_temp)
> -		misc_deregister(&temp_miscdev);
> -error_misc_register_temp:
> -	release_region(pcwd_private.io_addr,
> -			(pcwd_private.revision == PCWD_REVISION_A) ? 2 : 4);
> -error_request_region:
> -	pcwd_private.io_addr = 0x0000;
> -	cards_found--;
> -	return ret;
> -}
> -
> -static void pcwd_isa_remove(struct device *dev, unsigned int id)
> -{
> -	if (debug >= DEBUG)
> -		pr_debug("pcwd_isa_remove id=%d\n", id);
> -
> -	/*  Disable the board  */
> -	if (!nowayout)
> -		pcwd_stop();
> -
> -	/* Deregister */
> -	misc_deregister(&pcwd_miscdev);
> -	if (pcwd_private.supports_temp)
> -		misc_deregister(&temp_miscdev);
> -	release_region(pcwd_private.io_addr,
> -			(pcwd_private.revision == PCWD_REVISION_A) ? 2 : 4);
> -	pcwd_private.io_addr = 0x0000;
> -	cards_found--;
> -}
> -
> -static void pcwd_isa_shutdown(struct device *dev, unsigned int id)
> -{
> -	if (debug >= DEBUG)
> -		pr_debug("pcwd_isa_shutdown id=%d\n", id);
> -
> -	pcwd_stop();
> -}
> -
> -static struct isa_driver pcwd_isa_driver = {
> -	.match		= pcwd_isa_match,
> -	.probe		= pcwd_isa_probe,
> -	.remove		= pcwd_isa_remove,
> -	.shutdown	= pcwd_isa_shutdown,
> -	.driver		= {
> -		.owner	= THIS_MODULE,
> -		.name	= WATCHDOG_NAME,
> -	},
> -};
> -
> -module_isa_driver(pcwd_isa_driver, PCWD_ISA_NR_CARDS);
> -
> -MODULE_AUTHOR("Ken Hollis <kenji@bitgate.com>, "
> -		"Wim Van Sebroeck <wim@iguana.be>");
> -MODULE_DESCRIPTION("Berkshire ISA-PC Watchdog driver");
> -MODULE_VERSION(WATCHDOG_VERSION);
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/watchdog/wdt.c b/drivers/watchdog/wdt.c
> deleted file mode 100644
> index 3980d60bacd8..000000000000
> --- a/drivers/watchdog/wdt.c
> +++ /dev/null
> @@ -1,662 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - *	Industrial Computer Source WDT501 driver
> - *
> - *	(c) Copyright 1996-1997 Alan Cox <alan@lxorguk.ukuu.org.uk>,
> - *						All Rights Reserved.
> - *
> - *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
> - *	warranty for any of this software. This material is provided
> - *	"AS-IS" and at no charge.
> - *
> - *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
> - *
> - *	Release 0.10.
> - *
> - *	Fixes
> - *		Dave Gregorich	:	Modularisation and minor bugs
> - *		Alan Cox	:	Added the watchdog ioctl() stuff
> - *		Alan Cox	:	Fixed the reboot problem (as noted by
> - *					Matt Crocker).
> - *		Alan Cox	:	Added wdt= boot option
> - *		Alan Cox	:	Cleaned up copy/user stuff
> - *		Tim Hockin	:	Added insmod parameters, comment
> - *					cleanup, parameterized timeout
> - *		Tigran Aivazian	:	Restructured wdt_init() to handle
> - *					failures
> - *		Joel Becker	:	Added WDIOC_GET/SETTIMEOUT
> - *		Matt Domsch	:	Added nowayout module option
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/interrupt.h>
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/types.h>
> -#include <linux/miscdevice.h>
> -#include <linux/watchdog.h>
> -#include <linux/fs.h>
> -#include <linux/ioport.h>
> -#include <linux/notifier.h>
> -#include <linux/reboot.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/uaccess.h>
> -
> -#include "wd501p.h"
> -
> -static unsigned long wdt_is_open;
> -static char expect_close;
> -
> -/*
> - *	Module parameters
> - */
> -
> -#define WD_TIMO 60			/* Default heartbeat = 60 seconds */
> -
> -static int heartbeat = WD_TIMO;
> -static int wd_heartbeat;
> -module_param(heartbeat, int, 0);
> -MODULE_PARM_DESC(heartbeat,
> -	"Watchdog heartbeat in seconds. (0 < heartbeat < 65536, default="
> -				__MODULE_STRING(WD_TIMO) ")");
> -
> -static bool nowayout = WATCHDOG_NOWAYOUT;
> -module_param(nowayout, bool, 0);
> -MODULE_PARM_DESC(nowayout,
> -	"Watchdog cannot be stopped once started (default="
> -				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> -
> -/* You must set these - there is no sane way to probe for this board. */
> -static int io = 0x240;
> -static int irq = 11;
> -
> -static DEFINE_SPINLOCK(wdt_lock);
> -
> -module_param_hw(io, int, ioport, 0);
> -MODULE_PARM_DESC(io, "WDT io port (default=0x240)");
> -module_param_hw(irq, int, irq, 0);
> -MODULE_PARM_DESC(irq, "WDT irq (default=11)");
> -
> -/* Support for the Fan Tachometer on the WDT501-P */
> -static int tachometer;
> -module_param(tachometer, int, 0);
> -MODULE_PARM_DESC(tachometer,
> -		"WDT501-P Fan Tachometer support (0=disable, default=0)");
> -
> -static int type = 500;
> -module_param(type, int, 0);
> -MODULE_PARM_DESC(type,
> -		"WDT501-P Card type (500 or 501, default=500)");
> -
> -/*
> - *	Programming support
> - */
> -
> -static void wdt_ctr_mode(int ctr, int mode)
> -{
> -	ctr <<= 6;
> -	ctr |= 0x30;
> -	ctr |= (mode << 1);
> -	outb_p(ctr, WDT_CR);
> -}
> -
> -static void wdt_ctr_load(int ctr, int val)
> -{
> -	outb_p(val&0xFF, WDT_COUNT0+ctr);
> -	outb_p(val>>8, WDT_COUNT0+ctr);
> -}
> -
> -/**
> - *	wdt_start:
> - *
> - *	Start the watchdog driver.
> - */
> -
> -static int wdt_start(void)
> -{
> -	unsigned long flags;
> -	spin_lock_irqsave(&wdt_lock, flags);
> -	inb_p(WDT_DC);			/* Disable watchdog */
> -	wdt_ctr_mode(0, 3);		/* Program CTR0 for Mode 3:
> -						Square Wave Generator */
> -	wdt_ctr_mode(1, 2);		/* Program CTR1 for Mode 2:
> -						Rate Generator */
> -	wdt_ctr_mode(2, 0);		/* Program CTR2 for Mode 0:
> -						Pulse on Terminal Count */
> -	wdt_ctr_load(0, 8948);		/* Count at 100Hz */
> -	wdt_ctr_load(1, wd_heartbeat);	/* Heartbeat */
> -	wdt_ctr_load(2, 65535);		/* Length of reset pulse */
> -	outb_p(0, WDT_DC);		/* Enable watchdog */
> -	spin_unlock_irqrestore(&wdt_lock, flags);
> -	return 0;
> -}
> -
> -/**
> - *	wdt_stop:
> - *
> - *	Stop the watchdog driver.
> - */
> -
> -static int wdt_stop(void)
> -{
> -	unsigned long flags;
> -	spin_lock_irqsave(&wdt_lock, flags);
> -	/* Turn the card off */
> -	inb_p(WDT_DC);			/* Disable watchdog */
> -	wdt_ctr_load(2, 0);		/* 0 length reset pulses now */
> -	spin_unlock_irqrestore(&wdt_lock, flags);
> -	return 0;
> -}
> -
> -/**
> - *	wdt_ping:
> - *
> - *	Reload counter one with the watchdog heartbeat. We don't bother
> - *	reloading the cascade counter.
> - */
> -
> -static void wdt_ping(void)
> -{
> -	unsigned long flags;
> -	spin_lock_irqsave(&wdt_lock, flags);
> -	/* Write a watchdog value */
> -	inb_p(WDT_DC);			/* Disable watchdog */
> -	wdt_ctr_mode(1, 2);		/* Re-Program CTR1 for Mode 2:
> -							Rate Generator */
> -	wdt_ctr_load(1, wd_heartbeat);	/* Heartbeat */
> -	outb_p(0, WDT_DC);		/* Enable watchdog */
> -	spin_unlock_irqrestore(&wdt_lock, flags);
> -}
> -
> -/**
> - *	wdt_set_heartbeat:
> - *	@t:		the new heartbeat value that needs to be set.
> - *
> - *	Set a new heartbeat value for the watchdog device. If the heartbeat
> - *	value is incorrect we keep the old value and return -EINVAL. If
> - *	successful we return 0.
> - */
> -
> -static int wdt_set_heartbeat(int t)
> -{
> -	if (t < 1 || t > 65535)
> -		return -EINVAL;
> -
> -	heartbeat = t;
> -	wd_heartbeat = t * 100;
> -	return 0;
> -}
> -
> -/**
> - *	wdt_get_status:
> - *
> - *	Extract the status information from a WDT watchdog device. There are
> - *	several board variants so we have to know which bits are valid. Some
> - *	bits default to one and some to zero in order to be maximally painful.
> - *
> - *	we then map the bits onto the status ioctl flags.
> - */
> -
> -static int wdt_get_status(void)
> -{
> -	unsigned char new_status;
> -	int status = 0;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&wdt_lock, flags);
> -	new_status = inb_p(WDT_SR);
> -	spin_unlock_irqrestore(&wdt_lock, flags);
> -
> -	if (new_status & WDC_SR_ISOI0)
> -		status |= WDIOF_EXTERN1;
> -	if (new_status & WDC_SR_ISII1)
> -		status |= WDIOF_EXTERN2;
> -	if (type == 501) {
> -		if (!(new_status & WDC_SR_TGOOD))
> -			status |= WDIOF_OVERHEAT;
> -		if (!(new_status & WDC_SR_PSUOVER))
> -			status |= WDIOF_POWEROVER;
> -		if (!(new_status & WDC_SR_PSUUNDR))
> -			status |= WDIOF_POWERUNDER;
> -		if (tachometer) {
> -			if (!(new_status & WDC_SR_FANGOOD))
> -				status |= WDIOF_FANFAULT;
> -		}
> -	}
> -	return status;
> -}
> -
> -/**
> - *	wdt_get_temperature:
> - *
> - *	Reports the temperature in degrees Fahrenheit. The API is in
> - *	farenheit. It was designed by an imperial measurement luddite.
> - */
> -
> -static int wdt_get_temperature(void)
> -{
> -	unsigned short c;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&wdt_lock, flags);
> -	c = inb_p(WDT_RT);
> -	spin_unlock_irqrestore(&wdt_lock, flags);
> -	return (c * 11 / 15) + 7;
> -}
> -
> -static void wdt_decode_501(int status)
> -{
> -	if (!(status & WDC_SR_TGOOD))
> -		pr_crit("Overheat alarm (%d)\n", inb_p(WDT_RT));
> -	if (!(status & WDC_SR_PSUOVER))
> -		pr_crit("PSU over voltage\n");
> -	if (!(status & WDC_SR_PSUUNDR))
> -		pr_crit("PSU under voltage\n");
> -}
> -
> -/**
> - *	wdt_interrupt:
> - *	@irq:		Interrupt number
> - *	@dev_id:	Unused as we don't allow multiple devices.
> - *
> - *	Handle an interrupt from the board. These are raised when the status
> - *	map changes in what the board considers an interesting way. That means
> - *	a failure condition occurring.
> - */
> -
> -static irqreturn_t wdt_interrupt(int irq, void *dev_id)
> -{
> -	/*
> -	 *	Read the status register see what is up and
> -	 *	then printk it.
> -	 */
> -	unsigned char status;
> -
> -	spin_lock(&wdt_lock);
> -	status = inb_p(WDT_SR);
> -
> -	pr_crit("WDT status %d\n", status);
> -
> -	if (type == 501) {
> -		wdt_decode_501(status);
> -		if (tachometer) {
> -			if (!(status & WDC_SR_FANGOOD))
> -				pr_crit("Possible fan fault\n");
> -		}
> -	}
> -	if (!(status & WDC_SR_WCCR)) {
> -#ifdef SOFTWARE_REBOOT
> -#ifdef ONLY_TESTING
> -		pr_crit("Would Reboot\n");
> -#else
> -		pr_crit("Initiating system reboot\n");
> -		emergency_restart();
> -#endif
> -#else
> -		pr_crit("Reset in 5ms\n");
> -#endif
> -	}
> -	spin_unlock(&wdt_lock);
> -	return IRQ_HANDLED;
> -}
> -
> -
> -/**
> - *	wdt_write:
> - *	@file: file handle to the watchdog
> - *	@buf: buffer to write (unused as data does not matter here
> - *	@count: count of bytes
> - *	@ppos: pointer to the position to write. No seeks allowed
> - *
> - *	A write to a watchdog device is defined as a keepalive signal. Any
> - *	write of data will do, as we we don't define content meaning.
> - */
> -
> -static ssize_t wdt_write(struct file *file, const char __user *buf,
> -						size_t count, loff_t *ppos)
> -{
> -	if (count) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			/* In case it was set long ago */
> -			expect_close = 0;
> -
> -			for (i = 0; i != count; i++) {
> -				char c;
> -				if (get_user(c, buf + i))
> -					return -EFAULT;
> -				if (c == 'V')
> -					expect_close = 42;
> -			}
> -		}
> -		wdt_ping();
> -	}
> -	return count;
> -}
> -
> -/**
> - *	wdt_ioctl:
> - *	@file: file handle to the device
> - *	@cmd: watchdog command
> - *	@arg: argument pointer
> - *
> - *	The watchdog API defines a common set of functions for all watchdogs
> - *	according to their available features. We only actually usefully support
> - *	querying capabilities and current status.
> - */
> -
> -static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = argp;
> -	int new_heartbeat;
> -	int status;
> -
> -	struct watchdog_info ident = {
> -		.options =		WDIOF_SETTIMEOUT|
> -					WDIOF_MAGICCLOSE|
> -					WDIOF_KEEPALIVEPING,
> -		.firmware_version =	1,
> -		.identity =		"WDT500/501",
> -	};
> -
> -	/* Add options according to the card we have */
> -	ident.options |= (WDIOF_EXTERN1|WDIOF_EXTERN2);
> -	if (type == 501) {
> -		ident.options |= (WDIOF_OVERHEAT|WDIOF_POWERUNDER|
> -							WDIOF_POWEROVER);
> -		if (tachometer)
> -			ident.options |= WDIOF_FANFAULT;
> -	}
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
> -	case WDIOC_GETSTATUS:
> -		status = wdt_get_status();
> -		return put_user(status, p);
> -	case WDIOC_GETBOOTSTATUS:
> -		return put_user(0, p);
> -	case WDIOC_KEEPALIVE:
> -		wdt_ping();
> -		return 0;
> -	case WDIOC_SETTIMEOUT:
> -		if (get_user(new_heartbeat, p))
> -			return -EFAULT;
> -		if (wdt_set_heartbeat(new_heartbeat))
> -			return -EINVAL;
> -		wdt_ping();
> -		fallthrough;
> -	case WDIOC_GETTIMEOUT:
> -		return put_user(heartbeat, p);
> -	default:
> -		return -ENOTTY;
> -	}
> -}
> -
> -/**
> - *	wdt_open:
> - *	@inode: inode of device
> - *	@file: file handle to device
> - *
> - *	The watchdog device has been opened. The watchdog device is single
> - *	open and on opening we load the counters. Counter zero is a 100Hz
> - *	cascade, into counter 1 which downcounts to reboot. When the counter
> - *	triggers counter 2 downcounts the length of the reset pulse which
> - *	set set to be as long as possible.
> - */
> -
> -static int wdt_open(struct inode *inode, struct file *file)
> -{
> -	if (test_and_set_bit(0, &wdt_is_open))
> -		return -EBUSY;
> -	/*
> -	 *	Activate
> -	 */
> -	wdt_start();
> -	return stream_open(inode, file);
> -}
> -
> -/**
> - *	wdt_release:
> - *	@inode: inode to board
> - *	@file: file handle to board
> - *
> - *	The watchdog has a configurable API. There is a religious dispute
> - *	between people who want their watchdog to be able to shut down and
> - *	those who want to be sure if the watchdog manager dies the machine
> - *	reboots. In the former case we disable the counters, in the latter
> - *	case you have to open it again very soon.
> - */
> -
> -static int wdt_release(struct inode *inode, struct file *file)
> -{
> -	if (expect_close == 42) {
> -		wdt_stop();
> -		clear_bit(0, &wdt_is_open);
> -	} else {
> -		pr_crit("WDT device closed unexpectedly.  WDT will not stop!\n");
> -		wdt_ping();
> -	}
> -	expect_close = 0;
> -	return 0;
> -}
> -
> -/**
> - *	wdt_temp_read:
> - *	@file: file handle to the watchdog board
> - *	@buf: buffer to write 1 byte into
> - *	@count: length of buffer
> - *	@ptr: offset (no seek allowed)
> - *
> - *	Temp_read reports the temperature in degrees Fahrenheit. The API is in
> - *	farenheit. It was designed by an imperial measurement luddite.
> - */
> -
> -static ssize_t wdt_temp_read(struct file *file, char __user *buf,
> -						size_t count, loff_t *ptr)
> -{
> -	int temperature = wdt_get_temperature();
> -
> -	if (copy_to_user(buf, &temperature, 1))
> -		return -EFAULT;
> -
> -	return 1;
> -}
> -
> -/**
> - *	wdt_temp_open:
> - *	@inode: inode of device
> - *	@file: file handle to device
> - *
> - *	The temperature device has been opened.
> - */
> -
> -static int wdt_temp_open(struct inode *inode, struct file *file)
> -{
> -	return stream_open(inode, file);
> -}
> -
> -/**
> - *	wdt_temp_release:
> - *	@inode: inode to board
> - *	@file: file handle to board
> - *
> - *	The temperature device has been closed.
> - */
> -
> -static int wdt_temp_release(struct inode *inode, struct file *file)
> -{
> -	return 0;
> -}
> -
> -/**
> - *	wdt_notify_sys:
> - *	@this: our notifier block
> - *	@code: the event being reported
> - *	@unused: unused
> - *
> - *	Our notifier is called on system shutdowns. We want to turn the card
> - *	off at reboot otherwise the machine will reboot again during memory
> - *	test or worse yet during the following fsck. This would suck, in fact
> - *	trust me - if it happens it does suck.
> - */
> -
> -static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
> -	void *unused)
> -{
> -	if (code == SYS_DOWN || code == SYS_HALT)
> -		wdt_stop();
> -	return NOTIFY_DONE;
> -}
> -
> -/*
> - *	Kernel Interfaces
> - */
> -
> -
> -static const struct file_operations wdt_fops = {
> -	.owner		= THIS_MODULE,
> -	.write		= wdt_write,
> -	.unlocked_ioctl	= wdt_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> -	.open		= wdt_open,
> -	.release	= wdt_release,
> -};
> -
> -static struct miscdevice wdt_miscdev = {
> -	.minor	= WATCHDOG_MINOR,
> -	.name	= "watchdog",
> -	.fops	= &wdt_fops,
> -};
> -
> -static const struct file_operations wdt_temp_fops = {
> -	.owner		= THIS_MODULE,
> -	.read		= wdt_temp_read,
> -	.open		= wdt_temp_open,
> -	.release	= wdt_temp_release,
> -};
> -
> -static struct miscdevice temp_miscdev = {
> -	.minor	= TEMP_MINOR,
> -	.name	= "temperature",
> -	.fops	= &wdt_temp_fops,
> -};
> -
> -/*
> - *	The WDT card needs to learn about soft shutdowns in order to
> - *	turn the timebomb registers off.
> - */
> -
> -static struct notifier_block wdt_notifier = {
> -	.notifier_call = wdt_notify_sys,
> -};
> -
> -/**
> - *	wdt_exit:
> - *
> - *	Unload the watchdog. You cannot do this with any file handles open.
> - *	If your watchdog is set to continue ticking on close and you unload
> - *	it, well it keeps ticking. We won't get the interrupt but the board
> - *	will not touch PC memory so all is fine. You just have to load a new
> - *	module in 60 seconds or reboot.
> - */
> -
> -static void __exit wdt_exit(void)
> -{
> -	misc_deregister(&wdt_miscdev);
> -	if (type == 501)
> -		misc_deregister(&temp_miscdev);
> -	unregister_reboot_notifier(&wdt_notifier);
> -	free_irq(irq, NULL);
> -	release_region(io, 8);
> -}
> -
> -/**
> - *	wdt_init:
> - *
> - *	Set up the WDT watchdog board. All we have to do is grab the
> - *	resources we require and bitch if anyone beat us to them.
> - *	The open() function will actually kick the board off.
> - */
> -
> -static int __init wdt_init(void)
> -{
> -	int ret;
> -
> -	if (type != 500 && type != 501) {
> -		pr_err("unknown card type '%d'\n", type);
> -		return -ENODEV;
> -	}
> -
> -	/* Check that the heartbeat value is within it's range;
> -	   if not reset to the default */
> -	if (wdt_set_heartbeat(heartbeat)) {
> -		wdt_set_heartbeat(WD_TIMO);
> -		pr_info("heartbeat value must be 0 < heartbeat < 65536, using %d\n",
> -			WD_TIMO);
> -	}
> -
> -	if (!request_region(io, 8, "wdt501p")) {
> -		pr_err("I/O address 0x%04x already in use\n", io);
> -		ret = -EBUSY;
> -		goto out;
> -	}
> -
> -	ret = request_irq(irq, wdt_interrupt, 0, "wdt501p", NULL);
> -	if (ret) {
> -		pr_err("IRQ %d is not free\n", irq);
> -		goto outreg;
> -	}
> -
> -	ret = register_reboot_notifier(&wdt_notifier);
> -	if (ret) {
> -		pr_err("cannot register reboot notifier (err=%d)\n", ret);
> -		goto outirq;
> -	}
> -
> -	if (type == 501) {
> -		ret = misc_register(&temp_miscdev);
> -		if (ret) {
> -			pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -			       TEMP_MINOR, ret);
> -			goto outrbt;
> -		}
> -	}
> -
> -	ret = misc_register(&wdt_miscdev);
> -	if (ret) {
> -		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -		       WATCHDOG_MINOR, ret);
> -		goto outmisc;
> -	}
> -
> -	pr_info("WDT500/501-P driver 0.10 at 0x%04x (Interrupt %d). heartbeat=%d sec (nowayout=%d)\n",
> -		io, irq, heartbeat, nowayout);
> -	if (type == 501)
> -		pr_info("Fan Tachometer is %s\n",
> -			tachometer ? "Enabled" : "Disabled");
> -	return 0;
> -
> -outmisc:
> -	if (type == 501)
> -		misc_deregister(&temp_miscdev);
> -outrbt:
> -	unregister_reboot_notifier(&wdt_notifier);
> -outirq:
> -	free_irq(irq, NULL);
> -outreg:
> -	release_region(io, 8);
> -out:
> -	return ret;
> -}
> -
> -module_init(wdt_init);
> -module_exit(wdt_exit);
> -
> -MODULE_AUTHOR("Alan Cox");
> -MODULE_DESCRIPTION("Driver for ISA ICS watchdog cards (WDT500/501)");
> -MODULE_LICENSE("GPL");

