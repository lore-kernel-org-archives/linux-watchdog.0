Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43642 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbG1HOO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 03:14:14 -0400
Message-ID: <55B72BC0.8070206@roeck-us.net>
Date: Tue, 28 Jul 2015 00:14:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wenyou Yang <wenyou.yang@atmel.com>, wim@iguana.be,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: sylvain.rochet@finsecur.com, nicolas.ferre@atmel.com,
	boris.brezillon@free-electrons.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drivers: watchdog: at91sam9_wdt: add new feature
 support
References: <1438066825-21923-1-git-send-email-wenyou.yang@atmel.com> <1438066825-21923-2-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1438066825-21923-2-git-send-email-wenyou.yang@atmel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/28/2015 12:00 AM, Wenyou Yang wrote:
> In the datasheet, the new feature is describled as
> "WDT_MR can be written until a LOCKMR command is issued in WDT_CR".
> That is to say, as long as the bootstrap and u-boot don't issue a LOCKMR
> command, WDT_MR can be written in kernel.
>
> So the driver can enable/disable the watchdog timer hardware,
> set WDV(Watchdog Counter Value) and WDD(Watchdog Delta Value) fields
> of WDT_MR register to set the watchdog timer timeout.
>
> The timer is not necessary that regularly sends a keepalive ping to
> the watchdog timer hardware.
>
> It is introduced from sama5d4 SoCs.
>
Since there are so many changes, I wonder is a separate driver would make more sense.

Thoughts ?

Guenter

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>   drivers/watchdog/at91sam9_wdt.c |  255 ++++++++++++++++++++++++++++-----------
>   drivers/watchdog/at91sam9_wdt.h |    4 +
>   2 files changed, 190 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 1443b3c..6b61084 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -10,9 +10,12 @@
>    */
>
>   /*
> + * For AT91SAM9x SoCs, the Watchdog Timer has the following constraint.
>    * The Watchdog Timer Mode Register can be only written to once. If the
>    * timeout need to be set from Linux, be sure that the bootstrap or the
>    * bootloader doesn't write to this register.
> + * From SAMA5D4, the Watchdog Timer Mode Register can be written
> + * until a LOCKMR command is issued in WDT_CR.
>    */
>
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -80,6 +83,11 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>   	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>
>   #define to_wdt(wdd) container_of(wdd, struct at91wdt, wdd)
> +
> +struct at91wdt_variant {
> +	bool mr_writable;
> +};
> +
>   struct at91wdt {
>   	struct watchdog_device wdd;
>   	void __iomem *base;
> @@ -90,6 +98,9 @@ struct at91wdt {
>   	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
>   	bool nowayout;
>   	unsigned int irq;
> +	bool use_timer;
> +	bool enabled;
> +	struct at91wdt_variant *drv_data;
>   };
>
>   /* ......................................................................... */
> @@ -133,21 +144,67 @@ static void at91_ping(unsigned long data)
>   static int at91_wdt_start(struct watchdog_device *wdd)
>   {
>   	struct at91wdt *wdt = to_wdt(wdd);
> -	/* calculate when the next userspace timeout will be */
> -	wdt->next_heartbeat = jiffies + wdd->timeout * HZ;
> +	u32 reg;
> +
> +	if (wdt->drv_data->mr_writable) {
> +		reg = wdt_read(wdt, AT91_WDT_MR);
> +		reg &= ~AT91_WDT_WDDIS;
> +		wdt_write(wdt, AT91_WDT_MR, reg);
> +	} else {
> +		/* calculate when the next userspace timeout will be */
> +		wdt->next_heartbeat = jiffies + wdd->timeout * HZ;
> +	}
> +
>   	return 0;
>   }
>
>   static int at91_wdt_stop(struct watchdog_device *wdd)
>   {
> -	/* The watchdog timer hardware can not be stopped... */
> +	struct at91wdt *wdt = to_wdt(wdd);
> +	u32 reg;
> +
> +	if (wdt->drv_data->mr_writable) {
> +		reg = wdt_read(wdt, AT91_WDT_MR);
> +		reg |= AT91_WDT_WDDIS;
> +		wdt_write(wdt, AT91_WDT_MR, reg);
> +	}
> +
> +	return 0;
> +}
> +
> +static int at91_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct at91wdt *wdt = to_wdt(wdd);
> +
> +	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
> +
>   	return 0;
>   }
>
>   static int at91_wdt_set_timeout(struct watchdog_device *wdd, unsigned int new_timeout)
>   {
> -	wdd->timeout = new_timeout;
> -	return at91_wdt_start(wdd);
> +	struct at91wdt *wdt = to_wdt(wdd);
> +	u32 reg, timeout;
> +
> +	if (wdt->drv_data->mr_writable) {
> +		timeout = secs_to_ticks(new_timeout);
> +		if (timeout > WDT_COUNTER_MAX_TICKS)
> +			return -EINVAL;
> +
> +		reg = wdt_read(wdt, AT91_WDT_MR);
> +		reg &= ~AT91_WDT_WDV;
> +		reg |= AT91_WDT_WDV_(timeout);
> +		reg &= ~AT91_WDT_WDD;
> +		reg |= AT91_WDT_WDD_(timeout);
> +		wdt_write(wdt, AT91_WDT_MR, reg);
> +
> +		wdd->timeout = new_timeout;
> +
> +		return 0;
> +	} else {
> +		wdd->timeout = new_timeout;
> +		return at91_wdt_start(wdd);
> +	}
>   }
>
>   static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
> @@ -161,50 +218,65 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
>   	unsigned long max_heartbeat;
>   	struct device *dev = &pdev->dev;
>
> -	tmp = wdt_read(wdt, AT91_WDT_MR);
> -	if ((tmp & mask) != (wdt->mr & mask)) {
> -		if (tmp == WDT_MR_RESET) {
> -			wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> -			tmp = wdt_read(wdt, AT91_WDT_MR);
> +	if (wdt->drv_data->mr_writable) {
> +		wdt->use_timer = false;
> +
> +		wdt_write(wdt, AT91_WDT_MR, wdt->mr | AT91_WDT_WDDIS);
> +	} else {
> +		wdt->use_timer = true;
> +
> +		tmp = wdt_read(wdt, AT91_WDT_MR);
> +		if ((tmp & mask) != (wdt->mr & mask)) {
> +			if (tmp == WDT_MR_RESET) {
> +				wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> +				tmp = wdt_read(wdt, AT91_WDT_MR);
> +			}
>   		}
> -	}
>
> -	if (tmp & AT91_WDT_WDDIS) {
> -		if (wdt->mr & AT91_WDT_WDDIS)
> -			return 0;
> -		dev_err(dev, "watchdog is disabled\n");
> -		return -EINVAL;
> +		if (tmp & AT91_WDT_WDDIS) {
> +			if (wdt->mr & AT91_WDT_WDDIS)
> +				return 0;
> +
> +			dev_err(dev, "watchdog is disabled\n");
> +			return -EINVAL;
> +		}
>   	}
>
> -	value = tmp & AT91_WDT_WDV;
> -	delta = (tmp & AT91_WDT_WDD) >> 16;
> +	tmp = wdt_read(wdt, AT91_WDT_MR);
> +	wdt->enabled = (tmp & AT91_WDT_WDDIS) ? false : true;
>
> -	if (delta < value)
> -		min_heartbeat = ticks_to_hz_roundup(value - delta);
> +	if (wdt->use_timer) {
> +		value = tmp & AT91_WDT_WDV;
> +		delta = (tmp & AT91_WDT_WDD) >> 16;
>
> -	max_heartbeat = ticks_to_hz_rounddown(value);
> -	if (!max_heartbeat) {
> -		dev_err(dev,
> -			"heartbeat is too small for the system to handle it correctly\n");
> -		return -EINVAL;
> -	}
> +		if (delta < value)
> +			min_heartbeat = ticks_to_hz_roundup(value - delta);
>
> -	/*
> -	 * Try to reset the watchdog counter 4 or 2 times more often than
> -	 * actually requested, to avoid spurious watchdog reset.
> -	 * If this is not possible because of the min_heartbeat value, reset
> -	 * it at the min_heartbeat period.
> -	 */
> -	if ((max_heartbeat / 4) >= min_heartbeat)
> -		wdt->heartbeat = max_heartbeat / 4;
> -	else if ((max_heartbeat / 2) >= min_heartbeat)
> -		wdt->heartbeat = max_heartbeat / 2;
> -	else
> -		wdt->heartbeat = min_heartbeat;
> -
> -	if (max_heartbeat < min_heartbeat + 4)
> -		dev_warn(dev,
> -			 "min heartbeat and max heartbeat might be too close for the system to handle it correctly\n");
> +		max_heartbeat = ticks_to_hz_rounddown(value);
> +		if (!max_heartbeat) {
> +			dev_err(dev,
> +				"heartbeat is too small for the system to handle it correctly\n");
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Try to reset the watchdog counter 4 or 2 times more often than
> +		 * actually requested, to avoid spurious watchdog reset.
> +		 * If this is not possible because of the min_heartbeat value, reset
> +		 * it at the min_heartbeat period.
> +		 */
> +		if ((max_heartbeat / 4) >= min_heartbeat)
> +			wdt->heartbeat = max_heartbeat / 4;
> +		else if ((max_heartbeat / 2) >= min_heartbeat)
> +			wdt->heartbeat = max_heartbeat / 2;
> +		else
> +			wdt->heartbeat = min_heartbeat;
> +
> +		if (max_heartbeat < min_heartbeat + 4) {
> +			dev_warn(dev,
> +				 "min heartbeat and max heartbeat might be too close for the system to handle it correctly\n");
> +		}
> +	}
>
>   	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
>   		err = request_irq(wdt->irq, wdt_interrupt,
> @@ -215,21 +287,24 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
>   			return err;
>   	}
>
> -	if ((tmp & wdt->mr_mask) != (wdt->mr & wdt->mr_mask))
> -		dev_warn(dev,
> -			 "watchdog already configured differently (mr = %x expecting %x)\n",
> -			 tmp & wdt->mr_mask, wdt->mr & wdt->mr_mask);
> +	if (wdt->use_timer) {
> +		if ((tmp & wdt->mr_mask) != (wdt->mr & wdt->mr_mask)) {
> +			dev_warn(dev,
> +				 "watchdog already configured differently (mr = %x expecting %x)\n",
> +				 tmp & wdt->mr_mask, wdt->mr & wdt->mr_mask);
> +		}
>
> -	setup_timer(&wdt->timer, at91_ping, (unsigned long)wdt);
> +		setup_timer(&wdt->timer, at91_ping, (unsigned long)wdt);
>
> -	/*
> -	 * Use min_heartbeat the first time to avoid spurious watchdog reset:
> -	 * we don't know for how long the watchdog counter is running, and
> -	 *  - resetting it right now might trigger a watchdog fault reset
> -	 *  - waiting for heartbeat time might lead to a watchdog timeout
> -	 *    reset
> -	 */
> -	mod_timer(&wdt->timer, jiffies + min_heartbeat);
> +		/*
> +		 * Use min_heartbeat the first time to avoid spurious watchdog reset:
> +		 * we don't know for how long the watchdog counter is running, and
> +		 *  - resetting it right now might trigger a watchdog fault reset
> +		 *  - waiting for heartbeat time might lead to a watchdog timeout
> +		 *    reset
> +		 */
> +		mod_timer(&wdt->timer, jiffies + min_heartbeat);
> +	}
>
>   	/* Try to set timeout from device tree first */
>   	if (watchdog_init_timeout(&wdt->wdd, 0, dev))
> @@ -239,12 +314,14 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
>   	if (err)
>   		goto out_stop_timer;
>
> -	wdt->next_heartbeat = jiffies + wdt->wdd.timeout * HZ;
> +	if (wdt->use_timer)
> +		wdt->next_heartbeat = jiffies + wdt->wdd.timeout * HZ;
>
>   	return 0;
>
>   out_stop_timer:
> -	del_timer(&wdt->timer);
> +	if (wdt->use_timer)
> +		del_timer(&wdt->timer);
>   	return err;
>   }
>
> @@ -256,13 +333,54 @@ static const struct watchdog_info at91_wdt_info = {
>   						WDIOF_MAGICCLOSE,
>   };
>
> -static const struct watchdog_ops at91_wdt_ops = {
> +static struct watchdog_ops at91_wdt_ops = {
>   	.owner =	THIS_MODULE,
>   	.start =	at91_wdt_start,
>   	.stop =		at91_wdt_stop,
>   	.set_timeout =	at91_wdt_set_timeout,
>   };
>
> +static const struct at91wdt_variant drv_data_at91sam9260 = {
> +	.mr_writable = false,
> +};
> +
> +#if defined(CONFIG_OF)
> +static const struct at91wdt_variant drv_data_sama5d4 = {
> +	.mr_writable = true,
> +};
> +
> +static const struct of_device_id at91_wdt_dt_ids[] = {
> +	{ .compatible = "atmel,at91sam9260-wdt",
> +	  .data = &drv_data_at91sam9260 },
> +	{ .compatible = "atmel,sama5d4-wdt",
> +	  .data = &drv_data_sama5d4 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
> +#endif
> +
> +static const struct platform_device_id at91wdt_ids[] = {
> +	{
> +		.name = "at91_wdt",
> +		.driver_data = (unsigned long)&drv_data_at91sam9260,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, at91wdt_ids);
> +
> +static struct at91wdt_variant *at91wdt_get_drv_data(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +
> +	if (pdev->dev.of_node) {
> +		match = of_match_node(at91_wdt_dt_ids, pdev->dev.of_node);
> +		return (struct at91wdt_variant *)match->data;
> +	} else {
> +		return (struct at91wdt_variant *)
> +			platform_get_device_id(pdev)->driver_data;
> +	}
> +}
> +
>   #if defined(CONFIG_OF)
>   static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
>   {
> @@ -336,6 +454,10 @@ static int __init at91wdt_probe(struct platform_device *pdev)
>   	if (!wdt)
>   		return -ENOMEM;
>
> +	wdt->drv_data = at91wdt_get_drv_data(pdev);
> +	if (wdt->drv_data->mr_writable)
> +		at91_wdt_ops.ping = at91_wdt_ping;
> +
>   	wdt->mr = (WDT_HW_TIMEOUT * 256) | AT91_WDT_WDRSTEN | AT91_WDT_WDD |
>   		  AT91_WDT_WDDBGHLT | AT91_WDT_WDIDLEHLT;
>   	wdt->mr_mask = 0x3FFFFFFF;
> @@ -364,8 +486,12 @@ static int __init at91wdt_probe(struct platform_device *pdev)
>
>   	platform_set_drvdata(pdev, wdt);
>
> -	pr_info("enabled (heartbeat=%d sec, nowayout=%d)\n",
> -		wdt->wdd.timeout, wdt->nowayout);
> +	if (wdt->enabled) {
> +		dev_info(&pdev->dev, "enabled (heartbeat=%d sec, nowayout=%d)\n",
> +			wdt->wdd.timeout, wdt->nowayout);
> +	} else {
> +		dev_info(&pdev->dev, "not enabled\n");
> +	}
>
>   	return 0;
>   }
> @@ -381,15 +507,6 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> -#if defined(CONFIG_OF)
> -static const struct of_device_id at91_wdt_dt_ids[] = {
> -	{ .compatible = "atmel,at91sam9260-wdt" },
> -	{ /* sentinel */ }
> -};
> -
> -MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
> -#endif
> -
>   static struct platform_driver at91wdt_driver = {
>   	.remove		= __exit_p(at91wdt_remove),
>   	.driver		= {
> diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
> index c6fbb2e6..79add4f 100644
> --- a/drivers/watchdog/at91sam9_wdt.h
> +++ b/drivers/watchdog/at91sam9_wdt.h
> @@ -22,11 +22,15 @@
>
>   #define AT91_WDT_MR		0x04			/* Watchdog Mode Register */
>   #define		AT91_WDT_WDV		(0xfff << 0)		/* Counter Value */
> +#define			AT91_WDT_WDV_MSK	(0xfff)
> +#define			AT91_WDT_WDV_(x)	(((x) & AT91_WDT_WDV_MSK) << 0)
>   #define		AT91_WDT_WDFIEN		(1     << 12)		/* Fault Interrupt Enable */
>   #define		AT91_WDT_WDRSTEN	(1     << 13)		/* Reset Processor */
>   #define		AT91_WDT_WDRPROC	(1     << 14)		/* Timer Restart */
>   #define		AT91_WDT_WDDIS		(1     << 15)		/* Watchdog Disable */
>   #define		AT91_WDT_WDD		(0xfff << 16)		/* Delta Value */
> +#define			AT91_WDT_WDD_MSK	(0xfff)
> +#define			AT91_WDT_WDD_(x)	(((x) & AT91_WDT_WDD_MSK) << 16)
>   #define		AT91_WDT_WDDBGHLT	(1     << 28)		/* Debug Halt */
>   #define		AT91_WDT_WDIDLEHLT	(1     << 29)		/* Idle Halt */
>
>

