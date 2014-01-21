Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52729 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbaAUQfs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 11:35:48 -0500
Date: Tue, 21 Jan 2014 08:35:47 -0800
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
Subject: Re: [PATCH v3 08/15] watchdog: orion: Introduce per-compatible
 of_device_id data
Message-ID: <20140121163547.GB3311@roeck-us.net>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-9-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390310774-20781-9-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 10:26:07AM -0300, Ezequiel Garcia wrote:
> This commit adds an orion_watchdog_data structure to holda compatible-data

	s/holda/hold/

> information. This allows to remove the driver-wide definition and to
> future add support for multiple compatible-strings.

Maybe "and to be able to add support for multiple compatible-strings in the
future" ?

> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/watchdog/orion_wdt.c | 62 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 9a904be..5108496 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -24,36 +24,47 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  /*
>   * Watchdog timer block registers.
>   */
>  #define TIMER_CTRL		0x0000
> -#define WDT_EN			0x0010
> -#define WDT_VAL			0x0024
>  
>  #define WDT_MAX_CYCLE_COUNT	0xffffffff
>  #define WDT_IN_USE		0
>  #define WDT_OK_TO_CLOSE		1
>  
While looking at the new defines below, I noticed that WDT_IN_USE and
WDT_OK_TO_CLOSE are not used (anymore ?) and thus should be removed
(separate patch, though).

> -#define WDT_RESET_OUT_EN	BIT(1)
> +#define WDT_A370_RATIO_MASK(v)	((v) << 16)
> +#define WDT_A370_RATIO_SHIFT	5
> +#define WDT_A370_RATIO		(1 << WDT_A370_RATIO_SHIFT)
> +
> +#define WDT_AXP_FIXED_ENABLE_BIT BIT(10)
>  
Those new defines are not used. They should be introduced if and when used.

>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  static int heartbeat = -1;		/* module parameter (seconds) */
>  
> +struct orion_watchdog_data {
> +	int wdt_counter_offset;
> +	int wdt_enable_bit;
> +	int rstout_enable_bit;
> +};
> +
>  struct orion_watchdog {
>  	struct watchdog_device wdt;
>  	void __iomem *reg;
>  	void __iomem *rstout;
>  	unsigned long clk_rate;
>  	struct clk *clk;
> +	struct orion_watchdog_data *data;
>  };
>  
>  static int orion_wdt_ping(struct watchdog_device *wdt_dev)
>  {
>  	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
>  	/* Reload watchdog duration */
> -	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
> +	writel(dev->clk_rate * wdt_dev->timeout,
> +	       dev->reg + dev->data->wdt_counter_offset);
>  	return 0;
>  }
>  
> @@ -62,13 +73,16 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
>  	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
>  
>  	/* Set watchdog duration */
> -	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
> +	writel(dev->clk_rate * wdt_dev->timeout,
> +	       dev->reg + dev->data->wdt_counter_offset);
>  
>  	/* Enable watchdog timer */
> -	atomic_io_modify(dev->reg + TIMER_CTRL, WDT_EN, WDT_EN);
> +	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
> +						dev->data->wdt_enable_bit);
>  
>  	/* Enable reset on watchdog */
> -	atomic_io_modify(dev->rstout, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
> +	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
> +				      dev->data->rstout_enable_bit);
>  
>  	return 0;
>  }
> @@ -78,10 +92,10 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
>  	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
>  
>  	/* Disable reset on watchdog */
> -	atomic_io_modify(dev->rstout, WDT_RESET_OUT_EN, 0);
> +	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit, 0);
>  
>  	/* Disable watchdog timer */
> -	atomic_io_modify(dev->reg + TIMER_CTRL, WDT_EN, 0);
> +	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
>  
>  	return 0;
>  }
> @@ -89,7 +103,7 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
>  static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
>  {
>  	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> -	return readl(dev->reg + WDT_VAL) / dev->clk_rate;
> +	return readl(dev->reg + dev->data->wdt_counter_offset) / dev->clk_rate;
>  }
>  
>  static int orion_wdt_set_timeout(struct watchdog_device *wdt_dev,
> @@ -119,9 +133,25 @@ static irqreturn_t orion_wdt_irq(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>  
> +static const struct orion_watchdog_data orion_data = {
> +	.rstout_enable_bit = BIT(1),
> +	.wdt_enable_bit = BIT(4),
> +	.wdt_counter_offset = 0x24,
> +};
> +
> +static const struct of_device_id orion_wdt_of_match_table[] = {
> +	{
> +		.compatible = "marvell,orion-wdt",
> +		.data = &orion_data,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
> +
>  static int orion_wdt_probe(struct platform_device *pdev)
>  {
>  	struct orion_watchdog *dev;
> +	const struct of_device_id *match;
>  	unsigned int wdt_max_duration;	/* (seconds) */
>  	struct resource *res;
>  	int ret, irq;
> @@ -131,9 +161,15 @@ static int orion_wdt_probe(struct platform_device *pdev)
>  	if (!dev)
>  		return -ENOMEM;
>  
> +	match = of_match_device(orion_wdt_of_match_table, &pdev->dev);
> +	if (!match)
> +		/* Default legacy match */
> +		match = &orion_wdt_of_match_table[0];
> +
>  	dev->wdt.info = &orion_wdt_info;
>  	dev->wdt.ops = &orion_wdt_ops;
>  	dev->wdt.min_timeout = 1;
> +	dev->data = (struct orion_watchdog_data *)match->data;

match->data is a void *, so the typecast should not be needed here.
You might want to declare 'data' to be of type
'const struct orion_watchdog_data *' because otherwise you loose the
'const' attribute of match->data (which may be the reason for the typecast ?).

Guenter
