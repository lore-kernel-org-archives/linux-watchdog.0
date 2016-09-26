Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33012 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034469AbcIZNCk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Sep 2016 09:02:40 -0400
Subject: Re: [RFC PATCH 1/2] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
To: Vladimir Zapolskiy <vz@mleia.com>, Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>
References: <1474850361-20884-1-git-send-email-vz@mleia.com>
 <1474850361-20884-2-git-send-email-vz@mleia.com>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ebece25b-7a3b-3fdf-d117-dd0a3a2975b7@roeck-us.net>
Date: Mon, 26 Sep 2016 06:02:29 -0700
MIME-Version: 1.0
In-Reply-To: <1474850361-20884-2-git-send-email-vz@mleia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/25/2016 05:39 PM, Vladimir Zapolskiy wrote:
> Power down counter enable/disable bit switch is located in WMCR
> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
> i.MX31 SoCs don't have this register. As a result of writing data to
> the non-existing register on driver probe the SoC hangs up, to fix the
> problem add more OF compatible strings and on this basis get
> information about availability of the WMCR register.
>
> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/watchdog/imx2_wdt.c | 47 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 62f346b..b6763e0 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -29,6 +29,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/watchdog.h>
> @@ -57,6 +58,10 @@
>
>  #define WDOG_SEC_TO_COUNT(s)	((s * 2 - 1) << 8)
>
> +struct imx2_wdt_data {
> +	bool has_pdc;
> +};
> +
>  struct imx2_wdt_device {
>  	struct clk *clk;
>  	struct regmap *regmap;
> @@ -64,6 +69,8 @@ struct imx2_wdt_device {
>  	bool ext_reset;
>  };
>
> +static const struct of_device_id imx2_wdt_dt_ids[];
> +
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> @@ -200,10 +207,13 @@ static const struct regmap_config imx2_wdt_regmap_config = {
>
>  static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id;
> +	const struct imx2_wdt_data *data;
>  	struct imx2_wdt_device *wdev;
>  	struct watchdog_device *wdog;
>  	struct resource *res;
>  	void __iomem *base;
> +	bool has_pdc;
>  	int ret;
>  	u32 val;
>
> @@ -261,12 +271,24 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  		set_bit(WDOG_HW_RUNNING, &wdog->status);
>  	}
>
> +	if (pdev->dev.of_node) {
> +		of_id = of_match_device(imx2_wdt_dt_ids, &pdev->dev);
> +		if (!of_id)
> +			return -ENODEV;
> +
> +		data = of_id->data;
> +		has_pdc = data->has_pdc;
> +	} else {
> +		has_pdc = false;
> +	}
> +
>  	/*
>  	 * Disable the watchdog power down counter at boot. Otherwise the power
>  	 * down counter will pull down the #WDOG interrupt line for one clock
>  	 * cycle.
>  	 */
> -	regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
> +	if (has_pdc)
> +		regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
>
>  	ret = watchdog_register_device(wdog);
>  	if (ret) {
> @@ -363,8 +385,29 @@ static int imx2_wdt_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
>  			 imx2_wdt_resume);
>
> +static const struct imx2_wdt_data imx21_wdt_data = {
> +	.has_pdc = false,
> +};
> +
> +static const struct imx2_wdt_data imx25_wdt_data = {
> +	.has_pdc = true,
> +};
> +
>  static const struct of_device_id imx2_wdt_dt_ids[] = {
> -	{ .compatible = "fsl,imx21-wdt", },
> +	{ .compatible = "fsl,imx21-wdt",  .data = &imx21_wdt_data },

Please just specify the flag directly, as in
					.data = (void *) true
or, if you prefer, use defines.
					.data = (void *) IMX_SUPPORTS_PDC

Then, in above code:
		has_pdc = (bool) of_id->data;

Guenter

> +	{ .compatible = "fsl,imx25-wdt",  .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx27-wdt",  .data = &imx21_wdt_data },
> +	{ .compatible = "fsl,imx31-wdt",  .data = &imx21_wdt_data },
> +	{ .compatible = "fsl,imx35-wdt",  .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx50-wdt",  .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx51-wdt",  .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx53-wdt",  .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx6q-wdt",  .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx6sl-wdt", .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx6sx-wdt", .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx6ul-wdt", .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,imx7d-wdt",  .data = &imx25_wdt_data },
> +	{ .compatible = "fsl,vf610-wdt",  .data = &imx25_wdt_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
>

