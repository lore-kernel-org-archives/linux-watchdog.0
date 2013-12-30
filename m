Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:49223 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751382Ab3L3Ih7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Dec 2013 03:37:59 -0500
Date: Mon, 30 Dec 2013 09:37:55 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Baruch Siach <baruch@tkos.co.il>
Cc: linux-watchdog@vger.kernel.org, Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] watchdog: dw_wdt: remove build dependencies
Message-ID: <20131230083755.GM10136@spo001.leaseweb.com>
References: <230543f28a66b7bf4c4ebb63e4ac2a3000299ce4.1388387430.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230543f28a66b7bf4c4ebb63e4ac2a3000299ce4.1388387430.git.baruch@tkos.co.il>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Baruch,

If this is ARM hardware, then this should have the dependency "depends on ARM".
Only if other architectures start using this watchdog device, then the "depends on ARM" can go.

Kind regards,
Wim.

> There is nothing ARM specific in this driver. Also, clk.h now includes stubs
> for !CONFIG_HAVE_CLK, so the driver should build anyway.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/watchdog/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5be6e91..5ffac39 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -214,7 +214,6 @@ config SA1100_WATCHDOG
>  
>  config DW_WATCHDOG
>  	tristate "Synopsys DesignWare watchdog"
> -	depends on ARM && HAVE_CLK
>  	help
>  	  Say Y here if to include support for the Synopsys DesignWare
>  	  watchdog timer found in many ARM chips.
> -- 
> 1.8.5.2
> 
