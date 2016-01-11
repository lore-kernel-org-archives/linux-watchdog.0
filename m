Return-path: <wimvs@spo001.leaseweb.nl>
Date: Mon, 11 Jan 2016 22:53:17 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-watchdog@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: asm9260: remove __init and __exit annotations
Message-ID: <20160111215317.GA6957@spo001.leaseweb.nl>
References: <24150770.U3pBDPnky8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24150770.U3pBDPnky8@wuerfel>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Arnd,

> The probe and release functions in this driver are marked
> as __init and __exit, but this is wrong as indicated by this
> Kbuild error message:
> 
> WARNING: vmlinux.o(.data+0x1d2308): Section mismatch in reference from the variable asm9260_wdt_driver to the function .init.text:asm9260_wdt_probe()
> 
> This removes the annotations, to make the sysfs unbind attribute
> and deferred probing work.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: aae03dc98177 ("watchdog: add Alphascale asm9260-wdt driver")
> 
> diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
> index 1c22ff4c523a..c9686b2fdafd 100644
> --- a/drivers/watchdog/asm9260_wdt.c
> +++ b/drivers/watchdog/asm9260_wdt.c
> @@ -198,7 +198,7 @@ static struct watchdog_ops asm9260_wdt_ops = {
>  	.set_timeout	= asm9260_wdt_settimeout,
>  };
>  
> -static int __init asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
> +static int asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
>  {
>  	int err;
>  	unsigned long clk;
> @@ -250,7 +250,7 @@ static int __init asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
>  	return 0;
>  }
>  
> -static void __init asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
> +static void asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
>  {
>  	const char *tmp;
>  	int ret;
> @@ -274,7 +274,7 @@ static void __init asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
>  			 tmp);
>  }
>  
> -static int __init asm9260_wdt_probe(struct platform_device *pdev)
> +static int asm9260_wdt_probe(struct platform_device *pdev)
>  {
>  	struct asm9260_wdt_priv *priv;
>  	struct watchdog_device *wdd;
> @@ -364,7 +364,7 @@ static void asm9260_wdt_shutdown(struct platform_device *pdev)
>  	asm9260_wdt_disable(&priv->wdd);
>  }
>  
> -static int __exit asm9260_wdt_remove(struct platform_device *pdev)
> +static int asm9260_wdt_remove(struct platform_device *pdev)
>  {
>  	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
>  
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
