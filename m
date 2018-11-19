Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43166 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKTHtc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Nov 2018 02:49:32 -0500
Date: Mon, 19 Nov 2018 13:23:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: wim@linux-watchdog.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org
Subject: Re: [PATCH 1/3] watchdog: Add pm8916 watchdog driver
Message-ID: <20181119212358.GB5795@roeck-us.net>
References: <1542443319-23369-1-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542443319-23369-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Nov 17, 2018 at 09:28:37AM +0100, Loic Poulain wrote:
> The PM816 module is a versatile PMIC with many diverse functions
> integrated, including, a watchdog.
> This watchdog is subcomponent of the PON (Power On) peripheral,
> in the same way as pwrkey/resin buttons.
> It works with two timers (2-stages), the first one generates an
> IRQ to the main SoC (APQ8016/MSM8916), the second one performs
> the reset.
> 
> This driver expects the following device hierachy:
> [pm8916]->[pm8916-pon]->[pm8916-wdt]
> 
> It uses the pm8916 regmap to access PM8916 registers.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  drivers/watchdog/Kconfig      |   8 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/pm8916_wdt.c | 177 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 drivers/watchdog/pm8916_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 2d64333..66bab61 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -847,6 +847,14 @@ config SPRD_WATCHDOG
>  	  Say Y here to include watchdog timer supported
>  	  by Spreadtrum system.
>  
> +config PM8916_WATCHDOG
> +	tristate "QCOM pm8916 pmic watchdog"
> +	depends on OF && MFD_SPMI_PMIC
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support watchdog timer embedded into the
> +	  pm8916 module.
> +
>  # X86 (i386 + ia64 + x86_64) Architecture
>  
>  config ACQUIRE_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f69cdff..cc90e72 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>  obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
>  obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
>  obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
> +obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>  
>  # X86 (i386 + ia64 + x86_64) Architecture
>  obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
> diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
> new file mode 100644
> index 0000000..36f9763
> --- /dev/null
> +++ b/drivers/watchdog/pm8916_wdt.c
> @@ -0,0 +1,177 @@
> +/*
> + * Watchdog driver for QCOM PM8916
> + *
> + * Copyright (C) 2018 Loic Poulain, Linaro <loic.poulain@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Please use the SPDX license identifier.

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/regmap.h>
> +
Aplhabetic order, please.

> +#define PM8916_WDT_DEFAULT_TIMEOUT 32
> +
> +#define PON_PMIC_WD_RESET_S1_TIMER	0x54
> +#define PON_PMIC_WD_RESET_S2_TIMER	0x55
> +#define PON_PMIC_WD_RESET_S2_CTL	0x56
> +#define PON_PMIC_WD_RESET_S2_CTL2	0x57
> +#define PON_PMIC_WD_RESET_PET		0x58
> +
> +#define S2_RESET_EN_MASK BIT(7)
> +#define S2_RESET_EN (1 << 7)

Please use tabs. Also, why (1 << 7) instead of BIT(7) ?

Overall, since this is a single bit, having both EN_MASK and EN
seems unnecessary, but if you do,

> +
> +#define WATCHDOG_PET_MASK BIT(0)
> +

please do the same here.

> +struct pm8916_wdt {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct watchdog_device wdev;
> +	u32 baseaddr;
> +};
> +
> +static int pm8916_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct pm8916_wdt *wdt = watchdog_get_drvdata(wdev);
> +
> +	return regmap_update_bits(wdt->regmap,
> +				  wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL2,
> +				  S2_RESET_EN_MASK, S2_RESET_EN);
> +}
> +
> +static int pm8916_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct pm8916_wdt *wdt = watchdog_get_drvdata(wdev);
> +
> +	return regmap_update_bits(wdt->regmap,
> +				  wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL2,
> +				  S2_RESET_EN_MASK, 0);
> +}
> +
> +static int pm8916_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct pm8916_wdt *wdt = watchdog_get_drvdata(wdev);
> +
> +	return regmap_update_bits(wdt->regmap,
> +				  wdt->baseaddr + PON_PMIC_WD_RESET_PET,
> +				  WATCHDOG_PET_MASK, 1);

The "1" is really supposed to be BIT(0).

> +}
> +
> +static int pm8916_wdt_set_timeout(struct watchdog_device *wdev,
> +				  unsigned int timeout)
> +{
> +	struct pm8916_wdt *wdt = watchdog_get_drvdata(wdev);
> +	int err;
> +
> +	wdev->timeout = timeout;
> +
> +	/* This is a two stages watchdog, set stage-1 timer generate an irq and

Please use standard multi-line comments.

> +	 * stage-2 trigger the reset. In order to respect expected timeout, set
> +	 * stage-1 timer to timeout and stage-2 to 0.
> +	 */
> +	err = regmap_write(wdt->regmap,
> +			   wdt->baseaddr + PON_PMIC_WD_RESET_S1_TIMER,
> +			   timeout);
> +	if (err)
> +		return err;
> +
> +	return regmap_write(wdt->regmap,
> +			    wdt->baseaddr + PON_PMIC_WD_RESET_S2_TIMER,
> +			    0);

The watchdog subsystem does support pretimeout, which seems to match the
description here. Not mandatory to support it, but it might make sense.

> +}
> +
> +static const struct watchdog_info pm8916_wdt_ident = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,

No WDIOF_MAGICCLOSE ?

> +	.identity = "QCOM PM8916 PON WDT",
> +};
> +
> +static const struct watchdog_ops pm8916_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = pm8916_wdt_start,
> +	.stop = pm8916_wdt_stop,
> +	.ping = pm8916_wdt_ping,
> +	.set_timeout = pm8916_wdt_set_timeout,
> +};
> +
> +static int pm8916_wdt_probe(struct platform_device *pdev)
> +{
> +	struct pm8916_wdt *wdt;
> +	struct device *parent;
> +	int err;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->dev = &pdev->dev;
> +	parent = pdev->dev.parent;
> +
> +	/*
> +	 * The pm8916-pon-wdt is a child of the pon device, which is a child
> +	 * of the pm8916 mfd device. We want access to the pm8916 registers.
> +	 * Retrieve regmap from pm8916 (parent->parent) and base address
> +	 * from pm8916-pon (pon).
> +	 */
> +	wdt->regmap = dev_get_regmap(parent->parent, NULL);
> +	if (!wdt->regmap) {
> +		dev_err(&pdev->dev, "failed to locate regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	err = device_property_read_u32(parent, "reg", &wdt->baseaddr);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to get address\n");

... and the user will wonder "what address" 

> +		return err;
> +	}
> +
> +	/* Configure watchdog to hard-reset mode */
> +	err = regmap_write(wdt->regmap,
> +			   wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL, 0x07);

This is where symbolic defines come in handy, even if used only once.

> +	if (err) {
> +		dev_err(&pdev->dev, "failed configure watchdog\n");
> +		return err;
> +	}
> +
> +	wdt->wdev.info = &pm8916_wdt_ident,
> +	wdt->wdev.ops = &pm8916_wdt_ops,
> +	wdt->wdev.parent = &pdev->dev;
> +	wdt->wdev.min_timeout = 1;
> +	wdt->wdev.max_timeout = 127;

Is this the real range supported by the hardware ?

> +	wdt->wdev.timeout = PM8916_WDT_DEFAULT_TIMEOUT;
> +	watchdog_set_drvdata(&wdt->wdev, wdt);
> +
> +	pm8916_wdt_set_timeout(&wdt->wdev, wdt->wdev.timeout);
> +
Is timeout initialization via fdt not supported on purpose ?

> +	return watchdog_register_device(&wdt->wdev);

devm_watchdog_register_device(), or driver removal may result in an
unpleasant surprise.

> +}
> +
> +static const struct of_device_id pm8916_wdt_id_table[] = {
> +	{ .compatible = "qcom,pm8916-wdt" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pm8916_wdt_id_table);
> +
> +static struct platform_driver pm8916_wdt_driver = {
> +	.probe = pm8916_wdt_probe,
> +	.driver = {
> +		.name = "pm8916-wdt",
> +		.of_match_table = of_match_ptr(pm8916_wdt_id_table),
> +	},
> +};
> +module_platform_driver(pm8916_wdt_driver);
> +
> +MODULE_AUTHOR("Loic Poulain <loic.poulain@linaro.org>");
> +MODULE_DESCRIPTION("Qualcomm pm8916 watchdog driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
