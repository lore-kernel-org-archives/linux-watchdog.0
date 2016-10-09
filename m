Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34827 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbcJIPMG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Oct 2016 11:12:06 -0400
Date: Sun, 9 Oct 2016 08:11:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Liu Qishuai <lqs@lqs.me>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: it87_wdt: add IT8782_ID
Message-ID: <20161009151132.GA12710@roeck-us.net>
References: <d9c1af52-1817-d356-0aeb-a5d7a1093fd9@lqs.me>
 <bb6ad10b-85f4-7d3c-8c22-ba3731480ac5@roeck-us.net>
 <22e78325-e0ca-f323-9150-7b180a12a328@lqs.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e78325-e0ca-f323-9150-7b180a12a328@lqs.me>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Oct 09, 2016 at 09:03:12PM +0800, Liu Qishuai wrote:
> Updated patch to disabled CIR probing on IT878x chips. (IT8783 has this issue too)
> 
> Signed-off-by: Liu Qishuai <lqs@lqs.me>
> 

Looks better. One question - on IT8782, bit 7 of the control register (LDN 7,
0x71) is defined as "WDT Timeout Enable(WTE)". Setting the bit to 1 disables
the timeout.

Does this bit have to be cleared to 0 for the watchdog to work ?

Thanks,
Guenter

> 
> diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
> index e54839b..a911cae 100644
> --- a/drivers/watchdog/it87_wdt.c
> +++ b/drivers/watchdog/it87_wdt.c
> @@ -13,7 +13,7 @@
>   *
>   *	Support of the watchdog timers, which are available on
>   *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
> - *	IT8728 and IT8783.
> + *	IT8728, IT8782 and IT8783.
>   *
>   *	This program is free software; you can redistribute it and/or
>   *	modify it under the terms of the GNU General Public License
> @@ -87,6 +87,7 @@
>  #define IT8721_ID	0x8721
>  #define IT8726_ID	0x8726	/* the data sheet suggest wrongly 0x8716 */
>  #define IT8728_ID	0x8728
> +#define IT8782_ID	0x8782
>  #define IT8783_ID	0x8783
> 
>  /* GPIO Configuration Registers LDN=0x07 */
> @@ -606,6 +607,7 @@ static int __init it87_wdt_init(void)
>  {
>  	int rc = 0;
>  	int try_gameport = !nogameport;
> +	int try_cir = !nocir;
>  	u8  chip_rev;
>  	int gp_rreq_fail = 0;
> 
> @@ -634,9 +636,14 @@ static int __init it87_wdt_init(void)
>  	case IT8720_ID:
>  	case IT8721_ID:
>  	case IT8728_ID:
> +		max_units = 65535;
> +		try_gameport = 0;
> +		break;
> +	case IT8782_ID:
>  	case IT8783_ID:
>  		max_units = 65535;
>  		try_gameport = 0;
> +		try_cir = 0;
>  		break;
>  	case IT8705_ID:
>  		pr_err("Unsupported Chip found, Chip %04x Revision %02x\n",
> @@ -676,7 +683,7 @@ static int __init it87_wdt_init(void)
>  	}
> 
>  	/* If we haven't Gameport support, try to get CIR support */
> -	if (!nocir && !test_bit(WDTS_USE_GP, &wdt_status)) {
> +	if (try_cir && !test_bit(WDTS_USE_GP, &wdt_status)) {
>  		if (!request_region(CIR_BASE, 8, WATCHDOG_NAME)) {
>  			if (gp_rreq_fail)
>  				pr_err("I/O Address 0x%04x and 0x%04x already in use\n",
