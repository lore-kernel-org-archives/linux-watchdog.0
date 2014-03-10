Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54525 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbaCJCMq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 9 Mar 2014 22:12:46 -0400
Message-ID: <531D1F9B.8090804@roeck-us.net>
Date: Sun, 09 Mar 2014 19:12:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 4/7] watchdog: orion: Add Armada 375/380 SoC support
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com> <1393949244-5011-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1393949244-5011-5-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/04/2014 08:07 AM, Ezequiel Garcia wrote:
> This commit adds support for the Armada 375 and Armada 380 SoCs.
>
> This SoC variant has a second RSTOUT register, in addition to the already
> existent, which is shared with the system-controller. To handle this RSTOUT,
> we introduce a new MMIO register 'rstout_mask' to be required on
> 'armada-{375,380}-watchdog' new compatible string.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   drivers/watchdog/orion_wdt.c | 98 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 98 insertions(+)
>
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 8fb8e65..e567655 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -56,6 +56,7 @@ struct orion_watchdog_data {
>   	int wdt_counter_offset;
>   	int wdt_enable_bit;
>   	int rstout_enable_bit;
> +	int rstout_mask_bit;
>   	int (*clock_init)(struct platform_device *,
>   			  struct orion_watchdog *);
>   	int (*enabled)(struct orion_watchdog *);
> @@ -67,6 +68,7 @@ struct orion_watchdog {
>   	struct watchdog_device wdt;
>   	void __iomem *reg;
>   	void __iomem *rstout;
> +	void __iomem *rstout_mask;
>   	unsigned long clk_rate;
>   	struct clk *clk;
>   	const struct orion_watchdog_data *data;
> @@ -145,6 +147,27 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
>   	return 0;
>   }
>
> +static int armada375_start(struct watchdog_device *wdt_dev)
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
> +	atomic_io_modify(dev->rstout_mask, dev->data->rstout_mask_bit, 0);
> +	return 0;
> +}
> +
>   static int armada370_start(struct watchdog_device *wdt_dev)
>   {
>   	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> @@ -205,6 +228,21 @@ static int orion_stop(struct watchdog_device *wdt_dev)
>   	return 0;
>   }
>
> +static int armada375_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> +
> +	/* Disable reset on watchdog */
> +	atomic_io_modify(dev->rstout_mask, dev->data->rstout_mask_bit,
> +					   dev->data->rstout_mask_bit);
> +	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit, 0);
> +
> +	/* Disable watchdog timer */
> +	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
> +
> +	return 0;
> +}
> +
>   static int armada370_stop(struct watchdog_device *wdt_dev)
>   {
>   	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> @@ -235,6 +273,17 @@ static int orion_enabled(struct orion_watchdog *dev)
>   	return enabled && running;
>   }
>
> +static int armada375_enabled(struct orion_watchdog *dev)
> +{
> +	bool masked, enabled, running;
> +
> +	masked = readl(dev->rstout_mask) & dev->data->rstout_mask_bit;
> +	enabled = readl(dev->rstout) & dev->data->rstout_enable_bit;
> +	running = readl(dev->reg + TIMER_CTRL) & dev->data->wdt_enable_bit;
> +
> +	return !masked && enabled && running;
> +}
> +
>   static int orion_wdt_enabled(struct watchdog_device *wdt_dev)
>   {
>   	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> @@ -328,6 +377,28 @@ static const struct orion_watchdog_data armadaxp_data = {
>   	.stop = armada370_stop,
>   };
>
> +static const struct orion_watchdog_data armada375_data = {
> +	.rstout_enable_bit = BIT(8),
> +	.rstout_mask_bit = BIT(10),
> +	.wdt_enable_bit = BIT(8),
> +	.wdt_counter_offset = 0x34,
> +	.clock_init = armada370_wdt_clock_init,
> +	.enabled = armada375_enabled,
> +	.start = armada375_start,
> +	.stop = armada375_stop,
> +};
> +
> +static const struct orion_watchdog_data armada380_data = {
> +	.rstout_enable_bit = BIT(8),
> +	.rstout_mask_bit = BIT(10),
> +	.wdt_enable_bit = BIT(8),
> +	.wdt_counter_offset = 0x34,
> +	.clock_init = armadaxp_wdt_clock_init,
> +	.enabled = armada375_enabled,
> +	.start = armada375_start,
> +	.stop = armada375_stop,
> +};
> +
>   static const struct of_device_id orion_wdt_of_match_table[] = {
>   	{
>   		.compatible = "marvell,orion-wdt",
> @@ -341,6 +412,14 @@ static const struct of_device_id orion_wdt_of_match_table[] = {
>   		.compatible = "marvell,armada-xp-wdt",
>   		.data = &armadaxp_data,
>   	},
> +	{
> +		.compatible = "marvell,armada-375-wdt",
> +		.data = &armada375_data,
> +	},
> +	{
> +		.compatible = "marvell,armada-380-wdt",
> +		.data = &armada380_data,
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
> @@ -396,6 +475,25 @@ static int orion_wdt_probe(struct platform_device *pdev)
>   		if (!dev->rstout)
>   			return -ENOMEM;
>
> +	} else if (of_device_is_compatible(node, "marvell,armada-375-wdt") ||
> +		   of_device_is_compatible(node, "marvell,armada-380-wdt")) {
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);

Looks like each supported watchdog needs this call. Might as well do it earlier
and just once, unless you have a good reason for doing it this way.
To me this just looks like a lot of code replication.

It might also possibly make sense to move all the memory initializations
into a separate function; the probe function gets a bit large.

> +		if (!res)
> +			return -ENODEV;
> +		dev->rstout = devm_ioremap(&pdev->dev, res->start,
> +					   resource_size(res));
> +		if (!dev->rstout)
> +			return -ENOMEM;
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +		if (!res)
> +			return -ENODEV;
> +		dev->rstout_mask = devm_ioremap(&pdev->dev, res->start,
> +						resource_size(res));

devm_ioremap_resource() is better here.

Guenter

> +		if (!dev->rstout_mask)
> +			return -ENOMEM;
> +
>   	} else {
>   		return -ENODEV;
>   	}
>

