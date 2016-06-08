Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44426 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933013AbcFHNle (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 09:41:34 -0400
Subject: Re: [PATCH V2] watchdog: max77620: Add support for watchdog timer
To: Laxman Dewangan <ldewangan@nvidia.com>, wim@iguana.be
References: <1465381068-13071-1-git-send-email-ldewangan@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57582087.1050900@roeck-us.net>
Date: Wed, 8 Jun 2016 06:41:27 -0700
MIME-Version: 1.0
In-Reply-To: <1465381068-13071-1-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 06/08/2016 03:17 AM, Laxman Dewangan wrote:
> Maxim PMIC MAX77620 is Power management IC which have multiple
> sub blocks like regulators (DCDC/LDOs), GPIO, RTC, Clock, Watchdog
> timer etc.
>
> Add the driver for watchdog timer under watchdog framework.
> The driver implements the watchdog callbacks to start, stop,
> ping and set timeout for watchodg framework.
>
Almost good. One more comment below.

> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>
> ---
> Changes from V1:
> - Remove the error prints from start/stop/ping to simplify the function.
> - Instead of stopping running WDT, inform HW RUNNING and update the required
>    param accordingly.
> - Resequence the param sets for wdt device to avoid race condition, move all
>    wdt device setting before registration.
>

[ ... ]

> +static int max77620_wdt_probe(struct platform_device *pdev)
> +{
> +	struct max77620_wdt *wdt;
> +	struct watchdog_device *wdt_dev;
> +	unsigned int regval;
> +	int ret;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->dev = &pdev->dev;
> +	wdt->rmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!wdt->rmap) {
> +		dev_err(wdt->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	wdt_dev = &wdt->wdt_dev;
> +	wdt_dev->info = &max77620_wdt_info;
> +	wdt_dev->ops = &max77620_wdt_ops;
> +	wdt_dev->min_timeout = 2;
> +	wdt_dev->max_timeout = 128;
> +	wdt_dev->max_hw_heartbeat_ms = 128 * 1000;
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	/* Enable WD_RST_WK - WDT expire results in a restart */
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_ONOFFCNFG2,
> +				 MAX77620_ONOFFCNFG2_WD_RST_WK,
> +				 MAX77620_ONOFFCNFG2_WD_RST_WK);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to set WD_RST_WK: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set WDT clear in OFF and sleep mode */
> +	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +				 MAX77620_WDTOFFC | MAX77620_WDTSLPC,
> +				 MAX77620_WDTOFFC | MAX77620_WDTSLPC);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to set WDT OFF mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Check if WDT running and ig yes then set flags properly */
> +	ret = regmap_read(wdt->rmap, MAX77620_REG_CNFGGLBL2, &regval);
> +	if (ret < 0) {
> +		dev_err(wdt->dev, "Failed to read WDT CFG register: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (regval & MAX77620_WDTEN) {
> +		regval = regval & MAX77620_TWD_MASK;
> +		if (regval == MAX77620_TWD_2s)
> +			wdt_dev->timeout = 2;
> +		else if (regval == MAX77620_TWD_16s)
> +			wdt_dev->timeout = 16;
> +		else if (regval == MAX77620_TWD_64s)
> +			wdt_dev->timeout = 64;
> +		else
> +			wdt_dev->timeout = 128;
> +		set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
> +	}

Please also set a default timeout if the watchdog is not running
(and remember to write it to the chip). Otherwise the core won't know
the timeout and can not report it to user space when the watchdog
device is opened.

Thanks,
Guenter

