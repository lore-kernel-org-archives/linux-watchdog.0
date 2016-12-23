Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59797 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936494AbcLWB5K (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Dec 2016 20:57:10 -0500
Subject: Re: [PATCH] watchdog: sa11x0/pxa: fix error path of driver
 initialization
To: Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <20161221011816.3809-1-vz@mleia.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
        linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4d13d1d7-3e95-69a8-09ff-ff4836568698@roeck-us.net>
Date: Thu, 22 Dec 2016 17:57:08 -0800
MIME-Version: 1.0
In-Reply-To: <20161221011816.3809-1-vz@mleia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/20/2016 05:18 PM, Vladimir Zapolskiy wrote:
> The change corrects release of captured resources on error path, namely
> the clock is disabled and put if misc device registration fails and not
> enabled clock is not disabled now.
>
> Fixes: 6924089c488e ("watchdog: sa11x0/pxa: get rid of get_clock_tick_rate")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sa1100_wdt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
> index 8965e3f..d3be4f8 100644
> --- a/drivers/watchdog/sa1100_wdt.c
> +++ b/drivers/watchdog/sa1100_wdt.c
> @@ -188,12 +188,14 @@ static int __init sa1100dog_init(void)
>  	pre_margin = oscr_freq * margin;
>
>  	ret = misc_register(&sa1100dog_miscdev);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		pr_info("SA1100/PXA2xx Watchdog Timer: timer margin %d sec\n",
>  			margin);
> -	return ret;
> -err:
> +		return 0;
> +	}
> +
>  	clk_disable_unprepare(clk);
> +err:
>  	clk_put(clk);
>  	return ret;
>  }
>

