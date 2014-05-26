Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56522 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751392AbaEZUK4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 16:10:56 -0400
Date: Mon, 26 May 2014 22:10:52 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Michal Simek' <michal.simek@xilinx.com>
Subject: Re: [PATCH] watchdog: xilinx: Make of_device_id array const
Message-ID: <20140526201052.GA22471@spo001.leaseweb.com>
References: <021701cf69d0$43674870$ca35d950$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021701cf69d0$43674870$ca35d950$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> Make of_device_id array const, because all OF functions
> handle it as const.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/of_xilinx_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 57ccae8..1e6e28d 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -225,7 +225,7 @@ static int xwdt_remove(struct platform_device *pdev)
>  }
>  
>  /* Match table for of_platform binding */
> -static struct of_device_id xwdt_of_match[] = {
> +static const struct of_device_id xwdt_of_match[] = {
>  	{ .compatible = "xlnx,xps-timebase-wdt-1.00.a", },
>  	{ .compatible = "xlnx,xps-timebase-wdt-1.01.a", },
>  	{},

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

