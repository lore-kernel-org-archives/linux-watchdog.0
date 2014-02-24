Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59328 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752970AbaBXTy3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 14:54:29 -0500
Date: Mon, 24 Feb 2014 20:54:28 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Mika Westerberg' <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] watchdog: ts72xx_wdt: make 'ts72xx_wdt_pdev' static
Message-ID: <20140224195428.GD20712@spo001.leaseweb.com>
References: <001a01cf26f6$d4636dd0$7d2a4970$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a01cf26f6$d4636dd0$7d2a4970$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> Make 'ts72xx_wdt_pdev' static, because it is used only in this
> file. It also fixes the following sparse warning.
> 
>   warning: symbol 'ts72xx_wdt_pdev' was not declared. Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/ts72xx_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> index 6959fa0..afa9d6e 100644
> --- a/drivers/watchdog/ts72xx_wdt.c
> +++ b/drivers/watchdog/ts72xx_wdt.c
> @@ -61,7 +61,7 @@ struct ts72xx_wdt {
>  	struct platform_device *pdev;
>  };
>  
> -struct platform_device *ts72xx_wdt_pdev;
> +static struct platform_device *ts72xx_wdt_pdev;
>  
>  /*
>   * TS-72xx Watchdog supports following timeouts (value written
> -- 
> 1.7.10.4
> 
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

