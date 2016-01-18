Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60795 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071AbcARU2A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jan 2016 15:28:00 -0500
Subject: Re: [PATCH] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
To: Mason <slash.tmp@free.fr>, Wim Van Sebroeck <wim@iguana.be>
References: <569D421C.30504@free.fr>
Cc: Mans Rullgard <mans@mansr.com>, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <569D4ACF.6020701@roeck-us.net>
Date: Mon, 18 Jan 2016 12:27:59 -0800
MIME-Version: 1.0
In-Reply-To: <569D421C.30504@free.fr>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/18/2016 11:50 AM, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>
> Requested by arm-soc maintainer Kevin Hilman in v9 review.
> http://article.gmane.org/gmane.linux.ports.arm.kernel/456331
>

The reference should be after the '---' (it doesn't explain
the changes, but provides a reference to the change request),
and the explanation should be what you have after '---' below,
ie that the architecture is tango, that the 'x' is a wildcard,
and that it therefore makes more sense to use ARCH_TANGO
instead of ARCH_TANGOX.

> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Can this fix be pushed into 4.5 ?
>

Depends. Is the definition of ARCH_TANGO going to make it in ?

Guenter

> (The 'x' in tangox is a wild-card; tango3 is legacy,
> tango4 is current, tango5 is next.)
> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be0da34..e723e0169f88 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -145,7 +145,7 @@ config MENF21BMC_WATCHDOG
>   config TANGOX_WATCHDOG
>   	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
>   	select WATCHDOG_CORE
> -	depends on ARCH_TANGOX || COMPILE_TEST
> +	depends on ARCH_TANGO || COMPILE_TEST
>   	help
>   	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
>   	  and SMP87xx (tango4) family chips.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

