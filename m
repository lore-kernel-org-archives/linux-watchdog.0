Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40415 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbdBEBDI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Feb 2017 20:03:08 -0500
Subject: Re: [PATCH 1/2] watchdog: sama5d4: Cache MR instead of a partial
 config
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170130171848.31598-1-alexandre.belloni@free-electrons.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <21db54ab-13d5-7027-6c82-68676109ac1b@roeck-us.net>
Date: Sat, 4 Feb 2017 15:55:36 -0800
MIME-Version: 1.0
In-Reply-To: <20170130171848.31598-1-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/30/2017 09:18 AM, Alexandre Belloni wrote:
> .config is used to cache a part of WDT_MR at probe time and is not used
> afterwards. Instead of doing that, actually cache MR and avoid reading it
> every time it is modified.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

[ hoping that you'll remember to fix the problem in the set_timeout function ]

> ---
>  drivers/watchdog/sama5d4_wdt.c | 45 ++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index a49634cdc1cc..6dd07bef515a 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -28,7 +28,7 @@
>  struct sama5d4_wdt {
>  	struct watchdog_device	wdd;
>  	void __iomem		*reg_base;
> -	u32	config;
> +	u32			mr;
>  };
>
>  static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
> @@ -53,11 +53,9 @@ MODULE_PARM_DESC(nowayout,
>  static int sama5d4_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
> -	u32 reg;
>
> -	reg = wdt_read(wdt, AT91_WDT_MR);
> -	reg &= ~AT91_WDT_WDDIS;
> -	wdt_write(wdt, AT91_WDT_MR, reg);
> +	wdt->mr &= ~AT91_WDT_WDDIS;
> +	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
>
>  	return 0;
>  }
> @@ -65,11 +63,9 @@ static int sama5d4_wdt_start(struct watchdog_device *wdd)
>  static int sama5d4_wdt_stop(struct watchdog_device *wdd)
>  {
>  	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
> -	u32 reg;
>
> -	reg = wdt_read(wdt, AT91_WDT_MR);
> -	reg |= AT91_WDT_WDDIS;
> -	wdt_write(wdt, AT91_WDT_MR, reg);
> +	wdt->mr |= AT91_WDT_WDDIS;
> +	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
>
>  	return 0;
>  }
> @@ -88,14 +84,12 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
>  {
>  	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
>  	u32 value = WDT_SEC2TICKS(timeout);
> -	u32 reg;
>
> -	reg = wdt_read(wdt, AT91_WDT_MR);
> -	reg &= ~AT91_WDT_WDV;
> -	reg &= ~AT91_WDT_WDD;
> -	reg |= AT91_WDT_SET_WDV(value);
> -	reg |= AT91_WDT_SET_WDD(value);
> -	wdt_write(wdt, AT91_WDT_MR, reg);
> +	wdt->mr &= ~AT91_WDT_WDV;
> +	wdt->mr &= ~AT91_WDT_WDD;
> +	wdt->mr |= AT91_WDT_SET_WDV(value);
> +	wdt->mr |= AT91_WDT_SET_WDD(value);
> +	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
>
>  	wdd->timeout = timeout;
>
> @@ -132,19 +126,19 @@ static int of_sama5d4_wdt_init(struct device_node *np, struct sama5d4_wdt *wdt)
>  {
>  	const char *tmp;
>
> -	wdt->config = AT91_WDT_WDDIS;
> +	wdt->mr = AT91_WDT_WDDIS;
>
>  	if (!of_property_read_string(np, "atmel,watchdog-type", &tmp) &&
>  	    !strcmp(tmp, "software"))
> -		wdt->config |= AT91_WDT_WDFIEN;
> +		wdt->mr |= AT91_WDT_WDFIEN;
>  	else
> -		wdt->config |= AT91_WDT_WDRSTEN;
> +		wdt->mr |= AT91_WDT_WDRSTEN;
>
>  	if (of_property_read_bool(np, "atmel,idle-halt"))
> -		wdt->config |= AT91_WDT_WDIDLEHLT;
> +		wdt->mr |= AT91_WDT_WDIDLEHLT;
>
>  	if (of_property_read_bool(np, "atmel,dbg-halt"))
> -		wdt->config |= AT91_WDT_WDDBGHLT;
> +		wdt->mr |= AT91_WDT_WDDBGHLT;
>
>  	return 0;
>  }
> @@ -163,11 +157,10 @@ static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
>  	reg &= ~AT91_WDT_WDDIS;
>  	wdt_write(wdt, AT91_WDT_MR, reg);
>
> -	reg = wdt->config;
> -	reg |= AT91_WDT_SET_WDD(value);
> -	reg |= AT91_WDT_SET_WDV(value);
> +	wdt->mr |= AT91_WDT_SET_WDD(value);
> +	wdt->mr |= AT91_WDT_SET_WDV(value);
>
> -	wdt_write(wdt, AT91_WDT_MR, reg);
> +	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
>
>  	return 0;
>  }
> @@ -211,7 +204,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>
> -	if ((wdt->config & AT91_WDT_WDFIEN) && irq) {
> +	if ((wdt->mr & AT91_WDT_WDFIEN) && irq) {
>  		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
>  				       IRQF_SHARED | IRQF_IRQPOLL |
>  				       IRQF_NO_SUSPEND, pdev->name, pdev);
>

