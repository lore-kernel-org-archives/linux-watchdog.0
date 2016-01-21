Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53841 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbcAUUm7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Jan 2016 15:42:59 -0500
Date: Thu, 21 Jan 2016 12:42:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mason <slash.tmp@free.fr>
Cc: Wim Van Sebroeck <wim@iguana.be>, Mans Rullgard <mans@mansr.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
Message-ID: <20160121204255.GA10214@roeck-us.net>
References: <56A0EABB.3090901@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A0EABB.3090901@free.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jan 21, 2016 at 03:27:07PM +0100, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> This change was requested by arm-soc maintainer Kevin Hilman
> because the X in TANGOX is a wildcard.
> 
Not what I was looking for, but not worth arguing about it, so

> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be0da34..e723e0169f88 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -145,7 +145,7 @@ config MENF21BMC_WATCHDOG
>  config TANGOX_WATCHDOG
>  	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
>  	select WATCHDOG_CORE
> -	depends on ARCH_TANGOX || COMPILE_TEST
> +	depends on ARCH_TANGO || COMPILE_TEST
>  	help
>  	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
>  	  and SMP87xx (tango4) family chips.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
