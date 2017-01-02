Return-path: <linux+linux=roeck-us.net@armlinux.org.uk>
Date: Mon, 2 Jan 2017 12:48:17 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: sa11x0/pxa: fix error path of driver
 initialization
Message-ID: <20170102124816.GC14217@n2100.armlinux.org.uk>
References: <20161221011816.3809-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161221011816.3809-1-vz@mleia.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Dec 21, 2016 at 03:18:16AM +0200, Vladimir Zapolskiy wrote:
> The change corrects release of captured resources on error path, namely
> the clock is disabled and put if misc device registration fails and not
> enabled clock is not disabled now.
> 
> Fixes: 6924089c488e ("watchdog: sa11x0/pxa: get rid of get_clock_tick_rate")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Looks correct to me, thanks.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

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
> -- 
> 2.10.2
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
