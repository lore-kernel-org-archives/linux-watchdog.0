Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58048 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbcJHRnX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Oct 2016 13:43:23 -0400
Subject: Re: [PATCH] watchdog: it87_wdt: add IT8782_ID
To: Liu Qishuai <lqs@lqs.me>, wim@iguana.be
References: <d9c1af52-1817-d356-0aeb-a5d7a1093fd9@lqs.me>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bb6ad10b-85f4-7d3c-8c22-ba3731480ac5@roeck-us.net>
Date: Sat, 8 Oct 2016 10:43:20 -0700
MIME-Version: 1.0
In-Reply-To: <d9c1af52-1817-d356-0aeb-a5d7a1093fd9@lqs.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/08/2016 06:07 AM, Liu Qishuai wrote:
> Add watchdog support for IT8782 chip.
>
> Tested on SV3-26026 mainboard.
>
> Signed-off-by: Liu Qishuai <lqs@lqs.me>
>

Almost the same, but not quite. This ends up programming LDN=0x0a, register 0x70,
which is Consumer Infrared on other chips but serial port 5 configuration on IT8782.
This ends up reprogramming and thus affecting interrupt support for this serial port.
It also force-enables this serial port, and reprograms its IO base address.

Guenter

>
> diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
> index e54839b..c9b2b80 100644
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
> @@ -634,6 +635,7 @@ static int __init it87_wdt_init(void)
>  	case IT8720_ID:
>  	case IT8721_ID:
>  	case IT8728_ID:
> +	case IT8782_ID:
>  	case IT8783_ID:
>  		max_units = 65535;
>  		try_gameport = 0;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

