Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:34001 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752769AbaCOT5K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 15:57:10 -0400
Date: Sat, 15 Mar 2014 20:57:08 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: Fix Elan SC520 dependencies
Message-ID: <20140315195708.GA14815@spo001.leaseweb.com>
References: <20140314202529.573208f5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314202529.573208f5@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean,

> Anyone using a system based on an AMD Elan SC520 processor would be
> building a dedicated kernel for it, so we can make the sc520_wdt
> driver depend on MELAN. SC520_CPUFREQ already depends on MELAN so it
> makes things more consistent. It also makes kernel configuration for
> every other x86 user easier.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>  drivers/watchdog/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-3.14-rc6.orig/drivers/watchdog/Kconfig	2014-03-14 15:52:03.391930463 +0100
> +++ linux-3.14-rc6/drivers/watchdog/Kconfig	2014-03-14 19:15:16.797860536 +0100
> @@ -533,7 +533,7 @@ config GEODE_WDT
>  
>  config SC520_WDT
>  	tristate "AMD Elan SC520 processor Watchdog"
> -	depends on X86
> +	depends on MELAN
>  	help
>  	  This is the driver for the hardware watchdog built in to the
>  	  AMD "Elan" SC520 microcomputer commonly used in embedded systems.
> 
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

