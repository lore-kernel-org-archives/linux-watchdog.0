Return-path: <ukl@pengutronix.de>
Date: Tue, 17 Jan 2017 09:38:47 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Magnus Lilja <lilja.magnus@gmail.com>,
	Stefan Agner <stefan@agner.ch>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20170117083847.ijrvafqjdwduele6@pengutronix.de>
References: <20170117012353.6948-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170117012353.6948-1-vz@mleia.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Vladimir,

On Tue, Jan 17, 2017 at 03:23:53AM +0200, Vladimir Zapolskiy wrote:
> Power down counter enable/disable bit switch is located in WMCR register,
> but watchdog controllers found on legacy i.MX21, i.MX27 and i.MX31 SoCs
> don't have this register. As a result of writing data to the non-existing
> register on driver probe the SoC hangs up, to fix the problem add more OF
> compatible strings and on this basis get information about availability of
> the WMCR register.
> 
> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Magnus Lilja <lilja.magnus@gmail.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> Changes from v1 to v2:
> * removed i.MX27 and i.MX31 compatibles from the list, since it is expected
>   that their DTB files has a reference to the listed i.MX21 compatible,
>   many thanks to Uwe Kleine-König for the hint,
> * start the list of compatibles from an i.MX35 specific one, since it is
>   agreed that i.MX35 precedes i.MX25, thanks to Uwe Kleine-König for review,
> * added a comment describing any potential changes in future over the list
>   of watchdog compatible values,
> * added all collected tags to the commit message.
> 
> Changes from RFC to v1:
> * replaced private data struct with a macro as suggested by Guenter,

I didn't see the RFC, but I like a data struct better. It has some
overhead, but allows for easier expansion later, needs less casting and
is easier to understand for a reader (see below).

> * updated the comment in the source code to reflect the change,
> * rearranged and simplified the logic of detecting WMCR presence,
> * pulled the fix out from the series with optional proposed DTS changes.
> 
>  drivers/watchdog/imx2_wdt.c | 41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 4874b0f..e08c367 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/watchdog.h>
> @@ -57,6 +58,7 @@
>  #define IMX2_WDT_WICR_WICT	0xFF		/* -> Interrupt Count Timeout */
>  
>  #define IMX2_WDT_WMCR		0x08		/* Misc Register */
> +#define IMX2_WDT_NO_WMCR	((void *)true)	/* Indicates unavailable WMCR */

I wouldn't group this to the register definition because it serves a
different purpose. Also the negation isn't that nice, making it hard to
understand

	if (of_id && !of_id->data)

below. If a struct would be used, the code would be much easier to
understand. Compare to 

	if (type->has_WMCR)

in my patch which is understandable on first sight.

>  #define IMX2_WDT_MAX_TIME	128
>  #define IMX2_WDT_DEFAULT_TIME	60		/* in seconds */
> @@ -70,6 +72,8 @@ struct imx2_wdt_device {
>  	bool ext_reset;
>  };
>  
> +static const struct of_device_id imx2_wdt_dt_ids[];

You don't need this if you use dev->driver->of_match_table (or still
better of_device_get_match_data (see my patch)).

> +
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> @@ -242,6 +246,7 @@ static const struct regmap_config imx2_wdt_regmap_config = {
>  
>  static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id;
>  	struct imx2_wdt_device *wdev;
>  	struct watchdog_device *wdog;
>  	struct resource *res;
> @@ -310,11 +315,13 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	/*
> -	 * Disable the watchdog power down counter at boot. Otherwise the power
> -	 * down counter will pull down the #WDOG interrupt line for one clock
> -	 * cycle.
> +	 * If watchdog controller has WMCR, disable the watchdog power
> +	 * down counter at boot. Otherwise the power down counter will
> +	 * pull down the #WDOG interrupt line for one clock cycle.
>  	 */
> -	regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
> +	of_id = of_match_device(imx2_wdt_dt_ids, &pdev->dev);
> +	if (of_id && !of_id->data)
> +		regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);

The fix is not complete as this test doesn't work correctly when the wdt
device isn't instanciated by dt but by a platform file (see my patch).

>  	ret = watchdog_register_device(wdog);
>  	if (ret) {
> @@ -411,8 +418,32 @@ static int imx2_wdt_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
>  			 imx2_wdt_resume);
>  
> +/*
> + * The list of compatibles is added to achieve compatibility between
> + * old DTS and new kernel while fixing the incompatibility between
> + * i.MX21/i.MX27/i.MX31 and i.MX35/i.MX25/etc. watchdog controllers.

This comment should be after fsl,imx21-wdt and fsl,imx35-wdt. After all
these are not there for backward compatibility.

> + * Please do *NOT* extend the list by adding a compatible value for
> + * a controller, which is compatible with one of the already listed,
> + * almost certainly "fsl,imx35-wdt" compatible serves newer i.MX SoCs.
> + *
> + * You may consider to shrink the list at your own risk, but this may
> + * break the backward compatibility and users may have to update their
> + * DTB, which is good eventually.

I'd skip the last paragraph.

> + */
>  static const struct of_device_id imx2_wdt_dt_ids[] = {
> -	{ .compatible = "fsl,imx21-wdt", },
> +	{ .compatible = "fsl,imx21-wdt", .data = IMX2_WDT_NO_WMCR },
> +	{ .compatible = "fsl,imx35-wdt",  },
> +	{ .compatible = "fsl,imx25-wdt",  },
> +	{ .compatible = "fsl,imx50-wdt",  },
> +	{ .compatible = "fsl,imx51-wdt",  },
> +	{ .compatible = "fsl,imx53-wdt",  },
> +	{ .compatible = "fsl,imx6q-wdt",  },
> +	{ .compatible = "fsl,imx6sl-wdt", },
> +	{ .compatible = "fsl,imx6sx-wdt", },
> +	{ .compatible = "fsl,imx6ul-wdt", },
> +	{ .compatible = "fsl,imx7d-wdt",  },
> +	{ .compatible = "fsl,vf610-wdt",  },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
