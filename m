Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61582 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbaAUQlQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 11:41:16 -0500
Date: Tue, 21 Jan 2014 08:41:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 11/15] watchdog: orion: Add support for Armada 370 and
 Armada XP SoC
Message-ID: <20140121164115.GC3311@roeck-us.net>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-12-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390310774-20781-12-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 10:26:10AM -0300, Ezequiel Garcia wrote:
> Using the added infrastructure for handling SoC differences,
> this commit adds support for the watchdog controller available
> in Armada 370 and Armada XP SoCs.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/watchdog/orion_wdt.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index c2beb9f..a5e157c 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -30,6 +30,7 @@
>   * Watchdog timer block registers.
>   */
>  #define TIMER_CTRL		0x0000
> +#define TIMER_A370_STATUS	0x04
>  
>  #define WDT_MAX_CYCLE_COUNT	0xffffffff
>  #define WDT_IN_USE		0
> @@ -41,6 +42,12 @@
>  
>  #define WDT_AXP_FIXED_ENABLE_BIT BIT(10)
>  
> +#define WDT_A370_RATIO_MASK(v)	((v) << 16)
> +#define WDT_A370_RATIO_SHIFT	5
> +#define WDT_A370_RATIO		(1 << WDT_A370_RATIO_SHIFT)
> +

Are those introduced twice ? I seem to recall seeing those defines in patch 8.

> +#define WDT_A370_EXPIRED	BIT(31)
> +
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  static int heartbeat = -1;		/* module parameter (seconds) */
>  
> @@ -80,6 +87,48 @@ static int orion_wdt_clock_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int armada370_wdt_clock_init(struct platform_device *pdev,
> +				    struct orion_watchdog *dev)
> +{
> +	int ret;
> +
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +	ret = clk_prepare_enable(dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup watchdog input clock */
> +	atomic_io_modify(dev->reg + TIMER_CTRL,
> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
> +
> +	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
> +	return 0;
> +}
> +
> +static int armadaxp_wdt_clock_init(struct platform_device *pdev,
> +				   struct orion_watchdog *dev)
> +{
> +	int ret;
> +
> +	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +	ret = clk_prepare_enable(dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the fixed watchdog clock input */
> +	atomic_io_modify(dev->reg + TIMER_CTRL,
> +		WDT_AXP_FIXED_ENABLE_BIT,
> +		WDT_AXP_FIXED_ENABLE_BIT);

Who am I to complain, but your continuation line indentation isn't really
consistent ;-).

> +
> +	dev->clk_rate = clk_get_rate(dev->clk);
> +	return 0;
> +}
> +
>  static int orion_wdt_ping(struct watchdog_device *wdt_dev)
>  {
>  	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> @@ -89,6 +138,26 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
>  	return 0;
>  }
>  
> +static int armada370_start(struct watchdog_device *wdt_dev)
> +{
> +	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> +
> +	/* Set watchdog duration */
> +	writel(dev->clk_rate * wdt_dev->timeout,
> +	       dev->reg + dev->data->wdt_counter_offset);
> +
> +	/* Clear the watchdog expiration bit */
> +	atomic_io_modify(dev->reg + TIMER_A370_STATUS, WDT_A370_EXPIRED, 0);
> +
> +	/* Enable watchdog timer */
> +	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
> +						dev->data->wdt_enable_bit);
> +
> +	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
> +				      dev->data->rstout_enable_bit);
> +	return 0;
> +}
> +
>  static int orion_start(struct watchdog_device *wdt_dev)
>  {
>  	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> @@ -170,11 +239,35 @@ static const struct orion_watchdog_data orion_data = {
>  	.start = orion_start,
>  };
>  
> +static const struct orion_watchdog_data armada370_data = {
> +	.rstout_enable_bit = BIT(8),
> +	.wdt_enable_bit = BIT(8),
> +	.wdt_counter_offset = 0x34,
> +	.clock_init = armada370_wdt_clock_init,
> +	.start = armada370_start,
> +};
> +
> +static const struct orion_watchdog_data armadaxp_data = {
> +	.rstout_enable_bit = BIT(8),
> +	.wdt_enable_bit = BIT(8),
> +	.wdt_counter_offset = 0x34,
> +	.clock_init = armadaxp_wdt_clock_init,
> +	.start = armada370_start,
> +};
> +
>  static const struct of_device_id orion_wdt_of_match_table[] = {
>  	{
>  		.compatible = "marvell,orion-wdt",
>  		.data = &orion_data,
>  	},
> +	{
> +		.compatible = "marvell,armada-370-wdt",
> +		.data = &armada370_data,
> +	},
> +	{
> +		.compatible = "marvell,armada-xp-wdt",
> +		.data = &armadaxp_data,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
