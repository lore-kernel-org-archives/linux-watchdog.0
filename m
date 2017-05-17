Return-path: <p.zabel@pengutronix.de>
Message-ID: <1495006379.3030.9.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] watchdog: dw_wdt: get reset lines from dt
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Rob Herring
 <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, Dinh Nguyen <dinguyen@opensource.altera.com>,
 Guenter Roeck <linux@roeck-us.net>
Date: Wed, 17 May 2017 09:32:59 +0200
In-Reply-To: <4aa9252b45f2334eb429bb195d5d2963b4e61db1.1494595189.git-series.s.trumtrar@pengutronix.de>
References: 
	<44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
	 <4aa9252b45f2334eb429bb195d5d2963b4e61db1.1494595189.git-series.s.trumtrar@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Steffen,

On Fri, 2017-05-12 at 15:34 +0200, Steffen Trumtrar wrote:
> The dw_wdt has an external reset line, that can keep the device in reset
> and therefore rendering it useless and also is the only way of stopping
> the watchdog once it was started.
> 
> Get the reset lines for this core from the devicetree.
> If resets are not specified just warn but don't fail probing to be compatible
> with all users.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> ---
>  drivers/watchdog/dw_wdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 914da3a4d334..3accddf1f381 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/watchdog.h>
>  
>  #define WDOG_CONTROL_REG_OFFSET		    0x00
> @@ -54,6 +55,7 @@ struct dw_wdt {
>  	struct clk		*clk;
>  	unsigned long		rate;
>  	struct watchdog_device	wdd;
> +	struct reset_control	*rst;
>  };
>  
>  #define to_dw_wdt(wdd)	container_of(wdd, struct dw_wdt, wdd)
> @@ -234,6 +236,8 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  		goto out_disable_clk;
>  	}
>  
> +	dw_wdt->rst = devm_reset_control_get(&pdev->dev, NULL);
> +

This should be
	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
	if (IS_ERR(dw_wdt->rst))
		return PTR_ERR(dw_wdt->rst);
The optional variants return NULL if the reset is not specified in the
DT.

>  	wdd = &dw_wdt->wdd;
>  	wdd->info = &dw_wdt_ident;
>  	wdd->ops = &dw_wdt_ops;
> @@ -267,6 +271,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_disable_clk;
>  
> +	if (dw_wdt->rst)
> +		reset_control_deassert(dw_wdt->rst);
> +

This can be changed to
	reset_control_deassert(dw_wdt->rst);

>  	return 0;
>  
>  out_disable_clk:

Consider adding a call to reset_control_assert() in dw_wdt_drv_remove.

regards
Philipp
