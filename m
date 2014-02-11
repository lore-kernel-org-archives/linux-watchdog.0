Return-Path: <jdelvare@suse.de>
Subject: Re: [PATCH 1/8] watchdog: at32ap700x: Remove unnecessary OOM
 messages
From: Jean Delvare <jdelvare@suse.de>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
 'Guenter Roeck' <linux@roeck-us.net>, 'Hans-Christian Egtvedt'
 <egtvedt@samfundet.no>
In-Reply-To: <000201cf26f5$3df1bf10$b9d53d30$%han@samsung.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
	 <000201cf26f5$3df1bf10$b9d53d30$%han@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Feb 2014 09:15:21 +0100
Message-ID: <1392106521.4700.0.camel@chaos.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Le Tuesday 11 February 2014 à 15:48 +0900, Jingoo Han a écrit :
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/at32ap700x_wdt.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/at32ap700x_wdt.c b/drivers/watchdog/at32ap700x_wdt.c
> index afe7d17..25b5c67 100644
> --- a/drivers/watchdog/at32ap700x_wdt.c
> +++ b/drivers/watchdog/at32ap700x_wdt.c
> @@ -323,10 +323,8 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
>  
>  	wdt = devm_kzalloc(&pdev->dev, sizeof(struct wdt_at32ap700x),
>  			GFP_KERNEL);
> -	if (!wdt) {
> -		dev_dbg(&pdev->dev, "no memory for wdt structure\n");
> +	if (!wdt)
>  		return -ENOMEM;
> -	}
>  
>  	wdt->regs = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
>  	if (!wdt->regs) {

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support
