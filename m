Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312835F5EF
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957289; cv=none; b=QQvW8U2caJFOZCwed1Wuj772ALc+RIFiUGLqs3eLUGWCmlTULH+liOhjnTA6/vVvnNkQbn6QCHf01G6OSYHTyY0c5O9i5uGij09PZPjJY96+wCyKHYNB5jgZisb+0dCUyfI9w7JYylS8OQ8wpAAw2td3eYoZLdzuqEXVlZnIwCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957289; c=relaxed/simple;
	bh=8HNfepoA+qw0X3ktT+1HOdPq69ZM09V57if1dma3Nhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lt6oqoe6Oshku/T1VSAcxQOL5sVF5rNRoeD+mrRPhtAtZNvMAWwIMzwdN5vgR6Qw52bxZjSOs1scWbKJsFsTq3fvE8FPT2bW6iYOkSyTuBP+q/Mhbbd7w8IzL2Hno49C2JX5a9M9BRymzqJueDaHGK7ZR9Fx4fMPgXBacVOa/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzZDz9P0; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzZDz9P0"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1309f4ee97fso1292741c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 22:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957285; x=1778562085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sfseOA+TcanTLnLbkO/lvqotvH/hotpvXOMFocBLiSg=;
        b=QzZDz9P04s66DzPvHTG2opHseNSQB3r7u9W1OJhIcxe557IaSfYbkSdwnbOrWdnA4l
         +lMQ7SkFk9cPyUSy71x7aXzqCdl5rrXvrPJD7bAwzNLem90W9rMg90KBkGoHjppDBlA4
         RT04Yg1kSq/yV83Eo5Wd561F14Kqqe/zY9I+IsCIDVg1MyXvtT4w2kI7oMD1gHknHer9
         UOSAwPT5ZRxcPFPbnofbeOyCFYXpoX658nxHRtUOe+jtr2nsilSCkEbLkGVz190zYiyI
         1PDOsegWXSF3gfDP12aDoeL9SPdjw+WKgWpm+132fuHarX3IyKDiSur32dbmafk27Xiu
         SJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957285; x=1778562085;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfseOA+TcanTLnLbkO/lvqotvH/hotpvXOMFocBLiSg=;
        b=SAJId+MmogQLLy+leBQ24UXbusezZADrtcMXapb4a7hOE4LslkcBlByeFGMzxc8hPb
         htd9HJAzvSf7eTbaznTe17BPud/7RAlhuHe4DPsk17JlDgQaJwqyWoe+hz/p6/S//b98
         RrJLcO/ws67CZsiNbZitNTuJd7Tp07ChtKJKB42otkS4A0Gmjx2g/ZID490IS9texbxt
         hbKiIBhWS6HfP+3irPfkOzB02HBay6s2IRix9BS+94uKxrgCll/BSwAI+gxFqmubsZL0
         PJxtC9oqomDBBS1TcC+n1Y0m3y64dDO8MvY6cw64Nu7Fz459Gy+xmkd0A51B5twNpkNl
         yZVg==
X-Forwarded-Encrypted: i=1; AFNElJ/kTl1/6LBFCrIyeULju1S4f5cWCm78tl5NDYX6RG9MyS7wCsyOletZSJ+jRZ3tuG9Ekx6YJ5Ue1bA8EqOD9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtH9jA1Ne+kyD5WlhyNY1GI/GZ8kjbLuX5Gov0DClwC0gT/Lf
	yj9eRmSlTmOZVrtbTVo6QlriyWCQnicXbKn1LfNp0lztp/t4qj6+qL45
X-Gm-Gg: AeBDies62meEAHoJ0T+101DI2Gba44x6RpPd6wU0C97m+nQxgwEHLWhfkQuzPZK8NUj
	fLGw+nX/xomxsYb22SdS6yN9pxgB4SncGFJcZOo40il9W9YGx7lBxkHapvaZD7E551pPOAEDZGp
	5lv3Gb/2VDv0177za70w3HwXxUdII39P5pPfAwbsZAVjKopjNCNWRXuMDKm88QlkfMZ7HWMul3h
	2fW3/PKOsF1qsh1JT105zYmsXbcmkcOEt+0d0iYPoKjBtrrArOBpCdWCccGydqp1MF9ndp7AmhJ
	6E8ZPe4QrPEHCRtd1bkqLJ7nzqOIa1PgJWsQ2nK8iJx9rF83MRj2vswFVxTZKZJLuwGT3yjsVa9
	j13w8wgA6ynio+HtL5CDU6zqadH8CT0mfG/fuSKPUQEiOB7mQzsL4TkhGG3DaaFh2BcZo+c0ETK
	QH8QKoH5T+iQoGw1EE3zznbb2wwiCMPW/tf62KT64jMuGybRCgPOwiwko5Xa3NZiA7ZuHC3uwyq
	dAch2iDhgE=
X-Received: by 2002:a05:7022:258f:b0:12d:de3e:be8b with SMTP id a92af1059eb24-12dfd84b17bmr5233108c88.39.1777957284541;
        Mon, 04 May 2026 22:01:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84250f1sm18988208c88.11.2026.05.04.22.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 22:01:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cfc767a5-e922-4381-82a8-98bd9484ef2b@roeck-us.net>
Date: Mon, 4 May 2026 22:01:22 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: it8712f_wdt: remove redundant driver
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
References: <20260505032145.66065-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260505032145.66065-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/26 20:21, Ethan Nelson-Moore wrote:
> The it87_wdt driver also supports the IT8712 (regardless of revision),
> and therefore the it8712f_wdt driver is redundant. Remove it and
> add an alias to it87_wdt so it loads when it8712f_wdt is requested.
> 
> A notable difference between the drivers is that it8712f_wdt kicks the
> watchdog using game port reads which it generates, or optionally,
> keyboard, mouse, or CIR activity. None of these methods are
> particularly useful or reliable; the documentation indicates:
>      If the driver does not work, then make sure that the game port in the
>      BIOS is enabled.
> and:
>      You can also use KBD, MOUSE or CIR if you have some external way to
>      generate those interrupts.
> it87_wdt kicks the watchdog by directly writing to the timer register,
> which should work in all circumstances.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Same as with the other drivers: Mark it deprecated in the documentation
and Kconfig file, add a kernel message saying that it is deprecated
and what to replace it with, and indicate clearly when it will be removed.

Guenter

> ---
>   .../watchdog/watchdog-parameters.rst          |   9 -
>   drivers/watchdog/Kconfig                      |  13 -
>   drivers/watchdog/Makefile                     |   1 -
>   drivers/watchdog/it8712f_wdt.c                | 449 ------------------
>   drivers/watchdog/it87_wdt.c                   |   5 +
>   5 files changed, 5 insertions(+), 472 deletions(-)
>   delete mode 100644 drivers/watchdog/it8712f_wdt.c
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
> index 773241ed9986..39b20250b416 100644
> --- a/Documentation/watchdog/watchdog-parameters.rst
> +++ b/Documentation/watchdog/watchdog-parameters.rst
> @@ -248,15 +248,6 @@ iop_wdt:
>   
>   -------------------------------------------------
>   
> -it8712f_wdt:
> -    margin:
> -	Watchdog margin in seconds (default 60)
> -    nowayout:
> -	Disable watchdog shutdown on close
> -	(default=kernel config parameter)
> -
> --------------------------------------------------
> -
>   it87_wdt:
>       nogameport:
>   	Forbid the activation of game port, default=0
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5..a84fbf9d52b8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1429,19 +1429,6 @@ config ITCO_WDT
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called iTCO_wdt.
>   
> -config IT8712F_WDT
> -	tristate "IT8712F (Smart Guardian) Watchdog Timer"
> -	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
> -	help
> -	  This is the driver for the built-in watchdog timer on the IT8712F
> -	  Super I/0 chipset used on many motherboards.
> -
> -	  If the driver does not work, then make sure that the game port in
> -	  the BIOS is enabled.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called it8712f_wdt.
> -
>   config IT87_WDT
>   	tristate "IT87 Watchdog Timer"
>   	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index d2fb16b9f9ce..30b35d9887cd 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -127,7 +127,6 @@ obj-$(CONFIG_IE6XX_WDT) += ie6xx_wdt.o
>   obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
>   obj-$(CONFIG_LENOVO_SE10_WDT) += lenovo_se10_wdt.o
>   obj-$(CONFIG_LENOVO_SE30_WDT) += lenovo_se30_wdt.o
> -obj-$(CONFIG_IT8712F_WDT) += it8712f_wdt.o
>   obj-$(CONFIG_IT87_WDT) += it87_wdt.o
>   obj-$(CONFIG_HP_WATCHDOG) += hpwdt.o
>   obj-$(CONFIG_KEMPLD_WDT) += kempld_wdt.o
> diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
> deleted file mode 100644
> index b776e6766c9d..000000000000
> --- a/drivers/watchdog/it8712f_wdt.c
> +++ /dev/null
> @@ -1,449 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - *	IT8712F "Smart Guardian" Watchdog support
> - *
> - *	Copyright (c) 2006-2007 Jorge Boncompte - DTI2 <jorge@dti2.net>
> - *
> - *	Based on info and code taken from:
> - *
> - *	drivers/char/watchdog/scx200_wdt.c
> - *	drivers/hwmon/it87.c
> - *	IT8712F EC-LPC I/O Preliminary Specification 0.8.2
> - *	IT8712F EC-LPC I/O Preliminary Specification 0.9.3
> - *
> - *	The author(s) of this software shall not be held liable for damages
> - *	of any nature resulting due to the use of this software. This
> - *	software is provided AS-IS with no warranties.
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/init.h>
> -#include <linux/miscdevice.h>
> -#include <linux/watchdog.h>
> -#include <linux/notifier.h>
> -#include <linux/reboot.h>
> -#include <linux/fs.h>
> -#include <linux/spinlock.h>
> -#include <linux/uaccess.h>
> -#include <linux/io.h>
> -#include <linux/ioport.h>
> -
> -#define NAME "it8712f_wdt"
> -
> -MODULE_AUTHOR("Jorge Boncompte - DTI2 <jorge@dti2.net>");
> -MODULE_DESCRIPTION("IT8712F Watchdog Driver");
> -MODULE_LICENSE("GPL");
> -
> -static int max_units = 255;
> -static int margin = 60;		/* in seconds */
> -module_param(margin, int, 0);
> -MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
> -
> -static bool nowayout = WATCHDOG_NOWAYOUT;
> -module_param(nowayout, bool, 0);
> -MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
> -
> -static unsigned long wdt_open;
> -static unsigned expect_close;
> -static unsigned char revision;
> -
> -/* Dog Food address - We use the game port address */
> -static unsigned short address;
> -
> -#define	REG		0x2e	/* The register to read/write */
> -#define	VAL		0x2f	/* The value to read/write */
> -
> -#define	LDN		0x07	/* Register: Logical device select */
> -#define	DEVID		0x20	/* Register: Device ID */
> -#define	DEVREV		0x22	/* Register: Device Revision */
> -#define ACT_REG		0x30	/* LDN Register: Activation */
> -#define BASE_REG	0x60	/* LDN Register: Base address */
> -
> -#define IT8712F_DEVID	0x8712
> -
> -#define LDN_GPIO	0x07	/* GPIO and Watch Dog Timer */
> -#define LDN_GAME	0x09	/* Game Port */
> -
> -#define WDT_CONTROL	0x71	/* WDT Register: Control */
> -#define WDT_CONFIG	0x72	/* WDT Register: Configuration */
> -#define WDT_TIMEOUT	0x73	/* WDT Register: Timeout Value */
> -
> -#define WDT_RESET_GAME	0x10	/* Reset timer on read or write to game port */
> -#define WDT_RESET_KBD	0x20	/* Reset timer on keyboard interrupt */
> -#define WDT_RESET_MOUSE	0x40	/* Reset timer on mouse interrupt */
> -#define WDT_RESET_CIR	0x80	/* Reset timer on consumer IR interrupt */
> -
> -#define WDT_UNIT_SEC	0x80	/* If 0 in MINUTES */
> -
> -#define WDT_OUT_PWROK	0x10	/* Pulse PWROK on timeout */
> -#define WDT_OUT_KRST	0x40	/* Pulse reset on timeout */
> -
> -static int wdt_control_reg = WDT_RESET_GAME;
> -module_param(wdt_control_reg, int, 0);
> -MODULE_PARM_DESC(wdt_control_reg, "Value to write to watchdog control "
> -		"register. The default WDT_RESET_GAME resets the timer on "
> -		"game port reads that this driver generates. You can also "
> -		"use KBD, MOUSE or CIR if you have some external way to "
> -		"generate those interrupts.");
> -
> -static int superio_inb(int reg)
> -{
> -	outb(reg, REG);
> -	return inb(VAL);
> -}
> -
> -static void superio_outb(int val, int reg)
> -{
> -	outb(reg, REG);
> -	outb(val, VAL);
> -}
> -
> -static int superio_inw(int reg)
> -{
> -	int val;
> -	outb(reg++, REG);
> -	val = inb(VAL) << 8;
> -	outb(reg, REG);
> -	val |= inb(VAL);
> -	return val;
> -}
> -
> -static inline void superio_select(int ldn)
> -{
> -	outb(LDN, REG);
> -	outb(ldn, VAL);
> -}
> -
> -static inline int superio_enter(void)
> -{
> -	/*
> -	 * Try to reserve REG and REG + 1 for exclusive access.
> -	 */
> -	if (!request_muxed_region(REG, 2, NAME))
> -		return -EBUSY;
> -
> -	outb(0x87, REG);
> -	outb(0x01, REG);
> -	outb(0x55, REG);
> -	outb(0x55, REG);
> -	return 0;
> -}
> -
> -static inline void superio_exit(void)
> -{
> -	outb(0x02, REG);
> -	outb(0x02, VAL);
> -	release_region(REG, 2);
> -}
> -
> -static inline void it8712f_wdt_ping(void)
> -{
> -	if (wdt_control_reg & WDT_RESET_GAME)
> -		inb(address);
> -}
> -
> -static void it8712f_wdt_update_margin(void)
> -{
> -	int config = WDT_OUT_KRST | WDT_OUT_PWROK;
> -	int units = margin;
> -
> -	/* Switch to minutes precision if the configured margin
> -	 * value does not fit within the register width.
> -	 */
> -	if (units <= max_units) {
> -		config |= WDT_UNIT_SEC; /* else UNIT is MINUTES */
> -		pr_info("timer margin %d seconds\n", units);
> -	} else {
> -		units /= 60;
> -		pr_info("timer margin %d minutes\n", units);
> -	}
> -	superio_outb(config, WDT_CONFIG);
> -
> -	if (revision >= 0x08)
> -		superio_outb(units >> 8, WDT_TIMEOUT + 1);
> -	superio_outb(units, WDT_TIMEOUT);
> -}
> -
> -static int it8712f_wdt_get_status(void)
> -{
> -	if (superio_inb(WDT_CONTROL) & 0x01)
> -		return WDIOF_CARDRESET;
> -	else
> -		return 0;
> -}
> -
> -static int it8712f_wdt_enable(void)
> -{
> -	int ret = superio_enter();
> -	if (ret)
> -		return ret;
> -
> -	pr_debug("enabling watchdog timer\n");
> -	superio_select(LDN_GPIO);
> -
> -	superio_outb(wdt_control_reg, WDT_CONTROL);
> -
> -	it8712f_wdt_update_margin();
> -
> -	superio_exit();
> -
> -	it8712f_wdt_ping();
> -
> -	return 0;
> -}
> -
> -static int it8712f_wdt_disable(void)
> -{
> -	int ret = superio_enter();
> -	if (ret)
> -		return ret;
> -
> -	pr_debug("disabling watchdog timer\n");
> -	superio_select(LDN_GPIO);
> -
> -	superio_outb(0, WDT_CONFIG);
> -	superio_outb(0, WDT_CONTROL);
> -	if (revision >= 0x08)
> -		superio_outb(0, WDT_TIMEOUT + 1);
> -	superio_outb(0, WDT_TIMEOUT);
> -
> -	superio_exit();
> -	return 0;
> -}
> -
> -static int it8712f_wdt_notify(struct notifier_block *this,
> -		    unsigned long code, void *unused)
> -{
> -	if (code == SYS_HALT || code == SYS_POWER_OFF)
> -		if (!nowayout)
> -			it8712f_wdt_disable();
> -
> -	return NOTIFY_DONE;
> -}
> -
> -static struct notifier_block it8712f_wdt_notifier = {
> -	.notifier_call = it8712f_wdt_notify,
> -};
> -
> -static ssize_t it8712f_wdt_write(struct file *file, const char __user *data,
> -					size_t len, loff_t *ppos)
> -{
> -	/* check for a magic close character */
> -	if (len) {
> -		size_t i;
> -
> -		it8712f_wdt_ping();
> -
> -		expect_close = 0;
> -		for (i = 0; i < len; ++i) {
> -			char c;
> -			if (get_user(c, data + i))
> -				return -EFAULT;
> -			if (c == 'V')
> -				expect_close = 42;
> -		}
> -	}
> -
> -	return len;
> -}
> -
> -static long it8712f_wdt_ioctl(struct file *file, unsigned int cmd,
> -							unsigned long arg)
> -{
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = argp;
> -	static const struct watchdog_info ident = {
> -		.identity = "IT8712F Watchdog",
> -		.firmware_version = 1,
> -		.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> -						WDIOF_MAGICCLOSE,
> -	};
> -	int value;
> -	int ret;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		if (copy_to_user(argp, &ident, sizeof(ident)))
> -			return -EFAULT;
> -		return 0;
> -	case WDIOC_GETSTATUS:
> -		ret = superio_enter();
> -		if (ret)
> -			return ret;
> -		superio_select(LDN_GPIO);
> -
> -		value = it8712f_wdt_get_status();
> -
> -		superio_exit();
> -
> -		return put_user(value, p);
> -	case WDIOC_GETBOOTSTATUS:
> -		return put_user(0, p);
> -	case WDIOC_KEEPALIVE:
> -		it8712f_wdt_ping();
> -		return 0;
> -	case WDIOC_SETTIMEOUT:
> -		if (get_user(value, p))
> -			return -EFAULT;
> -		if (value < 1)
> -			return -EINVAL;
> -		if (value > (max_units * 60))
> -			return -EINVAL;
> -		margin = value;
> -		ret = superio_enter();
> -		if (ret)
> -			return ret;
> -		superio_select(LDN_GPIO);
> -
> -		it8712f_wdt_update_margin();
> -
> -		superio_exit();
> -		it8712f_wdt_ping();
> -		fallthrough;
> -	case WDIOC_GETTIMEOUT:
> -		if (put_user(margin, p))
> -			return -EFAULT;
> -		return 0;
> -	default:
> -		return -ENOTTY;
> -	}
> -}
> -
> -static int it8712f_wdt_open(struct inode *inode, struct file *file)
> -{
> -	int ret;
> -	/* only allow one at a time */
> -	if (test_and_set_bit(0, &wdt_open))
> -		return -EBUSY;
> -
> -	ret = it8712f_wdt_enable();
> -	if (ret)
> -		return ret;
> -	return stream_open(inode, file);
> -}
> -
> -static int it8712f_wdt_release(struct inode *inode, struct file *file)
> -{
> -	if (expect_close != 42) {
> -		pr_warn("watchdog device closed unexpectedly, will not disable the watchdog timer\n");
> -	} else if (!nowayout) {
> -		if (it8712f_wdt_disable())
> -			pr_warn("Watchdog disable failed\n");
> -	}
> -	expect_close = 0;
> -	clear_bit(0, &wdt_open);
> -
> -	return 0;
> -}
> -
> -static const struct file_operations it8712f_wdt_fops = {
> -	.owner = THIS_MODULE,
> -	.write = it8712f_wdt_write,
> -	.unlocked_ioctl = it8712f_wdt_ioctl,
> -	.compat_ioctl = compat_ptr_ioctl,
> -	.open = it8712f_wdt_open,
> -	.release = it8712f_wdt_release,
> -};
> -
> -static struct miscdevice it8712f_wdt_miscdev = {
> -	.minor = WATCHDOG_MINOR,
> -	.name = "watchdog",
> -	.fops = &it8712f_wdt_fops,
> -};
> -
> -static int __init it8712f_wdt_find(unsigned short *address)
> -{
> -	int err = -ENODEV;
> -	int chip_type;
> -	int ret = superio_enter();
> -	if (ret)
> -		return ret;
> -
> -	chip_type = superio_inw(DEVID);
> -	if (chip_type != IT8712F_DEVID)
> -		goto exit;
> -
> -	superio_select(LDN_GAME);
> -	superio_outb(1, ACT_REG);
> -	if (!(superio_inb(ACT_REG) & 0x01)) {
> -		pr_err("Device not activated, skipping\n");
> -		goto exit;
> -	}
> -
> -	*address = superio_inw(BASE_REG);
> -	if (*address == 0) {
> -		pr_err("Base address not set, skipping\n");
> -		goto exit;
> -	}
> -
> -	err = 0;
> -	revision = superio_inb(DEVREV) & 0x0f;
> -
> -	/* Later revisions have 16-bit values per datasheet 0.9.1 */
> -	if (revision >= 0x08)
> -		max_units = 65535;
> -
> -	if (margin > (max_units * 60))
> -		margin = (max_units * 60);
> -
> -	pr_info("Found IT%04xF chip revision %d - using DogFood address 0x%x\n",
> -		chip_type, revision, *address);
> -
> -exit:
> -	superio_exit();
> -	return err;
> -}
> -
> -static int __init it8712f_wdt_init(void)
> -{
> -	int err = 0;
> -
> -	if (it8712f_wdt_find(&address))
> -		return -ENODEV;
> -
> -	if (!request_region(address, 1, "IT8712F Watchdog")) {
> -		pr_warn("watchdog I/O region busy\n");
> -		return -EBUSY;
> -	}
> -
> -	err = it8712f_wdt_disable();
> -	if (err) {
> -		pr_err("unable to disable watchdog timer\n");
> -		goto out;
> -	}
> -
> -	err = register_reboot_notifier(&it8712f_wdt_notifier);
> -	if (err) {
> -		pr_err("unable to register reboot notifier\n");
> -		goto out;
> -	}
> -
> -	err = misc_register(&it8712f_wdt_miscdev);
> -	if (err) {
> -		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -		       WATCHDOG_MINOR, err);
> -		goto reboot_out;
> -	}
> -
> -	return 0;
> -
> -
> -reboot_out:
> -	unregister_reboot_notifier(&it8712f_wdt_notifier);
> -out:
> -	release_region(address, 1);
> -	return err;
> -}
> -
> -static void __exit it8712f_wdt_exit(void)
> -{
> -	misc_deregister(&it8712f_wdt_miscdev);
> -	unregister_reboot_notifier(&it8712f_wdt_notifier);
> -	release_region(address, 1);
> -}
> -
> -module_init(it8712f_wdt_init);
> -module_exit(it8712f_wdt_exit);
> diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
> index 1d9f8591f38d..9da5ec544c8a 100644
> --- a/drivers/watchdog/it87_wdt.c
> +++ b/drivers/watchdog/it87_wdt.c
> @@ -419,6 +419,11 @@ static void __exit it87_wdt_exit(void)
>   module_init(it87_wdt_init);
>   module_exit(it87_wdt_exit);
>   
> +/*
> + * Load this driver when the separate IT8712F driver, which was removed, is
> + * requested
> + */
> +MODULE_ALIAS("it8712f_wdt");
>   MODULE_AUTHOR("Oliver Schuster");
>   MODULE_DESCRIPTION("Hardware Watchdog Device Driver for IT87xx EC-LPC I/O");
>   MODULE_LICENSE("GPL");

