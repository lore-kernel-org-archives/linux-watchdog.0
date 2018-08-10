Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39258 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbeHJQHe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 10 Aug 2018 12:07:34 -0400
Date: Fri, 10 Aug 2018 06:37:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 10/24] watchdog: jz4740: Avoid starting watchdog in
 set_timeout
Message-ID: <20180810133735.GC29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-11-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-11-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 09, 2018 at 11:44:00PM +0200, Paul Cercueil wrote:
> Previously the jz4740_wdt_set_timeout() function was starting the timer
> unconditionally, even if it was stopped when that function was entered.
> 
> Now, the timer will be restarted only if it was already running before
> this function is called.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/jz4740_wdt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
>  v6: New patch
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 0f54306aee25..45d9495170e5 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -64,13 +64,15 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  {
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
> +	u32 tcer;
>  
> +	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
>  	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>  
>  	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
>  	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>  
> -	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & TCU_WDT_TCER_TCEN);
>  
>  	wdt_dev->timeout = new_timeout;
>  	return 0;
> @@ -86,6 +88,7 @@ static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
>  		return ret;
>  
>  	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
>  
>  	return 0;
>  }
> -- 
> 2.11.0
> 
