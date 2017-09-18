Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37774 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbdIROpy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 18 Sep 2017 10:45:54 -0400
Date: Mon, 18 Sep 2017 07:45:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, joel@jms.id.au,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: Re: [PATCH 3/4] watchdog: aspeed: Remove specific reference to
 AST2400 in Kconfig
Message-ID: <20170918144553.GC11868@roeck-us.net>
References: <20170918054905.16470-1-andrew@aj.id.au>
 <20170918054905.16470-4-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918054905.16470-4-andrew@aj.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 18, 2017 at 03:19:04PM +0930, Andrew Jeffery wrote:
> The driver also supports the watchdog in the AST25xx series, and
> may work on earlier SoCs as well.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b562d2e03eb9..a1b92ebe74b6 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -741,7 +741,7 @@ config RENESAS_RZAWDT
>  	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
>  
>  config ASPEED_WATCHDOG
> -	tristate "Aspeed 2400 watchdog support"
> +	tristate "Aspeed BMC watchdog support"
>  	depends on ARCH_ASPEED || COMPILE_TEST
>  	select WATCHDOG_CORE
>  	help
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
