Return-Path: <SRS0=mrOV=Q6=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C77C43381
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Feb 2019 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC9E20657
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Feb 2019 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qthJSJVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfBWRMg (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:12:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42981 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBWRMf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Feb 2019 12:12:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so2537532pgl.9;
        Sat, 23 Feb 2019 09:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3akfTY0MEZwT+ISb6YS4iCZ6paQsLMOTTpZM5AXgRp0=;
        b=qthJSJVRFnBdUu1skrxMZo5fivBg5OJrlkJibxhqPrEUe94b+rPmrm1Fw1OeODqY3A
         RsNlm33RpgQGseQiLMtWFjzjCs0RegjZ/xaw/1YjGJkW0I7gbWQXaTncwYt3PWuiReFr
         EnN5h7aS3g6nZ3aVkNvNcHtilVxm0bhv8p019Gn2pDsWJeawBSuzUMdlNbqnuKeEDU8b
         TuzEoaTzmzOIgvaooulyaqipPltVWDRdQHFnCigZ10aYM6IYbJeH/GXfYqlrUTOXzgSU
         ARymnIFxGZOeQiGD9u/3UHJncVq6qKNwJekpGtyq8lPFGP8C3vNHeHrngFAxQiTtwSy9
         sGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3akfTY0MEZwT+ISb6YS4iCZ6paQsLMOTTpZM5AXgRp0=;
        b=ajVP0f0o8JUVoeRiE9YhPGKGZH9609/koOFL+mf/2EPh6w1G4nvIA28WJ5wV1B9FYB
         Yp83Rqb5mtNxbtggJ7l2w7z6o7ztApHYmoY4rS/Pb6p4ZLswREAPLLjTizD37OBPq369
         b5fOvPy5KtLwRC8gPPkkqQT30xU4k8AxmECvDniULiM4Y9VTri20poB9vQXhW4TizLNw
         WLC5okVY9STXf2/1we4CX24vQpNWrtQFm9WcU/4x/xcOKAd928N8KGHiu/MSumDs8kjS
         2oSLouc3p3YNoMvlfZ4daW+utxM09AwC0Mp07sQWbW3S/3+1qRghpfa228kJT1/iqAcZ
         6dUQ==
X-Gm-Message-State: AHQUAua6gx84vXRLGjRFOv1BrEzLlEqeTjGlyeO7wTX6WG0oEQ9dDxZh
        oUJLw16RXbH2zAibECMZyI8uCHDB
X-Google-Smtp-Source: AHgI3IbSUQcbe8tBI1umT6BVpX4/Kij7b3TTmqYbMv6zn0yS+oFXYVkYJ6Xoi+tTYy9bumO5F+ZqkQ==
X-Received: by 2002:a63:8341:: with SMTP id h62mr9724139pge.254.1550941954739;
        Sat, 23 Feb 2019 09:12:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w128sm7872039pfw.79.2019.02.23.09.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 09:12:33 -0800 (PST)
Subject: Re: [PATCH v4 2/3] watchdog: mlx-wdt: introduce a watchdog driver for
 Mellanox systems.
To:     michaelsh@mellanox.com, wim@linux-watchdog.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com
References: <20190220093424.5374-1-michaelsh@mellanox.com>
 <20190220093424.5374-3-michaelsh@mellanox.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a93993bf-cf72-83c0-0d44-d8f46230482c@roeck-us.net>
Date:   Sat, 23 Feb 2019 09:12:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220093424.5374-3-michaelsh@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/20/19 1:34 AM, michaelsh@mellanox.com wrote:
> From: Michael Shych <michaelsh@mellanox.com>
> 
> Introduce watchdog driver for a various range of Mellanox Ethernet and
> Infiniband switch systems.
> 
> Watchdog driver for Mellanox watchdog devices, implemented in
> programmable logic device.
> 
> Main and auxiliary watchdog devices can exist on the same system.
> There are several actions that can be defined in the watchdog:
> system reset, start fans on full speed and increase a counter.
> The last 2 actions are performed without a system reset.
> Actions without reset are provided for auxiliary watchdog devices,
> which is optional.
> Access to HW registers is performed through generic
> regmap interface.
> 
> There are 2 types of HW watchdog implementations.
> Type 1: actual HW timeout can be defined as power of 2 msec.
> e.g. timeout 20 sec will be rounded up to 32768 msec.;
> maximum timeout period is 32 sec (32768 msec.);
> get time-left isn't supported
> Type 2: actual HW timeout is defined in sec. and it's the same as
> user-defined timeout;
> maximum timeout is 255 sec;
> get time-left is supported;
> 
> Watchdog driver is probed from the common mlx_platform driver.
> 
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> v1->v2
> Comments pointed out by Guenter:
> 1. Remove unneeded lock in access functions.
> 2. Change return  int to void in functions with constant 0 return value
>     or with unchecked returned code.
> 3. Use regmap_update_bits() or regmap_update_bits_base() functions.
> 4. Remove unneeded dev_info messages.
> 5. Change set_timeout function.
> 6. Changes in probe
> 7. Delete unneeded remove function.
> ---
> v2->v3
> Comments pointed out by Guenter:
> 1. Remove unneedeed define.
> 2. Remove structure field hw_timeout. Use local var instead it.
> 3. Remove unnecesarry label.
> 4. Move enum mlxreg_wdt_type to common mlxreh.h file.
> 5. Watchdog HW type will be provided by parent platform driver,
>     no need to find this in mlx-wdt driver.
> ---
> v3->v4
> Comment pointed out by Guenter:
> Add cooment about return value of get_timeleft function.
> ---
>   drivers/watchdog/Kconfig   |  16 +++
>   drivers/watchdog/Makefile  |   1 +
>   drivers/watchdog/mlx_wdt.c | 290 +++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 307 insertions(+)
>   create mode 100644 drivers/watchdog/mlx_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 57f017d74a97..f1766eb081bb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -241,6 +241,22 @@ config RAVE_SP_WATCHDOG
>   	help
>   	  Support for the watchdog on RAVE SP device.
>   
> +config MLX_WDT
> +	tristate "Mellanox Watchdog"
> +	depends on MELLANOX_PLATFORM
> +	select WATCHDOG_CORE
> +	select REGMAP
> +	help
> +	  This is the driver for the hardware watchdog on Mellanox systems.
> +	  If you are going to use it, say Y here, otherwise N.
> +	  This driver can be used together with the watchdog daemon.
> +	  It can also watch your kernel to make sure it doesn't freeze,
> +	  and if it does, it reboots your system after a certain amount of
> +	  time.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mlx-wdt.
> +
>   # ALPHA Architecture
>   
>   # ARM Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a0917ef28e07..941b74185c9c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -142,6 +142,7 @@ obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>   obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>   obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>   obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
> +obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
>   
>   # M68K Architecture
>   obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
> diff --git a/drivers/watchdog/mlx_wdt.c b/drivers/watchdog/mlx_wdt.c
> new file mode 100644
> index 000000000000..70c2cbf9c993
> --- /dev/null
> +++ b/drivers/watchdog/mlx_wdt.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Mellanox watchdog driver
> + *
> + * Copyright (C) 2019 Mellanox Technologies
> + * Copyright (C) 2019 Michael Shych <mshych@mellanox.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/mlxreg.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define MLXREG_WDT_CLOCK_SCALE		1000
> +#define MLXREG_WDT_MAX_TIMEOUT_TYPE1	32
> +#define MLXREG_WDT_MAX_TIMEOUT_TYPE2	255
> +#define MLXREG_WDT_MIN_TIMEOUT		1
> +#define MLXREG_WDT_OPTIONS_BASE (WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | \
> +				 WDIOF_SETTIMEOUT)
> +
> +/**
> + * struct mlxreg_wdt - wd private data:
> + *
> + * @wdd:	watchdog device;
> + * @device:	basic device;
> + * @pdata:	data received from platform driver;
> + * @regmap:	register map of parent device;
> + * @timeout:	defined timeout in sec.;
> + * @action_idx:	index for direct access to action register;
> + * @timeout_idx:index for direct access to TO register;
> + * @tleft_idx:	index for direct access to time left register;
> + * @ping_idx:	index for direct access to ping register;
> + * @reset_idx:	index for direct access to reset cause register;
> + * @wd_type:	watchdog HW type;
> + */
> +struct mlxreg_wdt {
> +	struct watchdog_device wdd;
> +	struct mlxreg_core_platform_data *pdata;
> +	void *regmap;
> +	int action_idx;
> +	int timeout_idx;
> +	int tleft_idx;
> +	int ping_idx;
> +	int reset_idx;
> +	enum mlxreg_wdt_type wdt_type;
> +};
> +
> +static void mlxreg_wdt_check_card_reset(struct mlxreg_wdt *wdt)
> +{
> +	struct mlxreg_core_data *reg_data;
> +	u32 regval;
> +	int rc;
> +
> +	if (wdt->reset_idx == -EINVAL)
> +		return;
> +
> +	if (!(wdt->wdd.info->options & WDIOF_CARDRESET))
> +		return;
> +
> +	reg_data = &wdt->pdata->data[wdt->reset_idx];
> +	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +	if (!rc) {
> +		if (regval & ~reg_data->mask) {
> +			wdt->wdd.bootstatus = WDIOF_CARDRESET;
> +			dev_info(wdt->wdd.parent,
> +				 "watchdog previously reset the CPU\n");
> +		}
> +	}
> +}
> +
> +static int mlxreg_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->action_idx];
> +
> +	return regmap_update_bits(wdt->regmap, reg_data->reg, ~reg_data->mask,
> +				  BIT(reg_data->bit));
> +}
> +
> +static int mlxreg_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->action_idx];
> +
> +	return regmap_update_bits(wdt->regmap, reg_data->reg, ~reg_data->mask,
> +				  ~BIT(reg_data->bit));
> +}
> +
> +static int mlxreg_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->ping_idx];
> +
> +	return regmap_update_bits_base(wdt->regmap, reg_data->reg,
> +				       ~reg_data->mask, BIT(reg_data->bit),
> +				       NULL, false, true);
> +}
> +
> +static int mlxreg_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->timeout_idx];
> +	u32 regval, set_time, hw_timeout;
> +	int rc;
> +
> +	if (wdt->wdt_type == MLX_WDT_TYPE1) {
> +		rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +		if (rc)
> +			return rc;
> +
> +		hw_timeout = order_base_2(timeout * MLXREG_WDT_CLOCK_SCALE);
> +		regval = (regval & reg_data->mask) | hw_timeout;
> +		/* Rowndown to actual closest number of sec. */
> +		set_time = BIT(hw_timeout) / MLXREG_WDT_CLOCK_SCALE;
> +	} else {
> +		set_time = timeout;
> +		regval = timeout;
> +	}
> +
> +	wdd->timeout = set_time;
> +	rc = regmap_write(wdt->regmap, reg_data->reg, regval);
> +
> +	if (!rc) {
> +		/*
> +		 * Restart watchdog with new timeout period
> +		 * if watchdog is already started.
> +		 */
> +		if (watchdog_active(wdd)) {
> +			rc = mlxreg_wdt_stop(wdd);
> +			if (!rc)
> +				rc = mlxreg_wdt_start(wdd);
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +static unsigned int mlxreg_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->tleft_idx];
> +	u32 regval;
> +	int rc;
> +
> +	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +	/* Return 0 timeleft in case of failure register read. */
> +	return rc == 0 ? regval : 0;
> +}
> +
> +static const struct watchdog_ops mlxreg_wdt_ops_type1 = {
> +	.start		= mlxreg_wdt_start,
> +	.stop		= mlxreg_wdt_stop,
> +	.ping		= mlxreg_wdt_ping,
> +	.set_timeout	= mlxreg_wdt_set_timeout,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct watchdog_ops mlxreg_wdt_ops_type2 = {
> +	.start		= mlxreg_wdt_start,
> +	.stop		= mlxreg_wdt_stop,
> +	.ping		= mlxreg_wdt_ping,
> +	.set_timeout	= mlxreg_wdt_set_timeout,
> +	.get_timeleft	= mlxreg_wdt_get_timeleft,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct watchdog_info mlxreg_wdt_main_info = {
> +	.options	= MLXREG_WDT_OPTIONS_BASE
> +			| WDIOF_CARDRESET,
> +	.identity	= "mlx-wdt-main",
> +};
> +
> +static const struct watchdog_info mlxreg_wdt_aux_info = {
> +	.options	= MLXREG_WDT_OPTIONS_BASE
> +			| WDIOF_ALARMONLY,
> +	.identity	= "mlx-wdt-aux",
> +};
> +
> +static void mlxreg_wdt_config(struct mlxreg_wdt *wdt,
> +			      struct mlxreg_core_platform_data *pdata)
> +{
> +	struct mlxreg_core_data *data = pdata->data;
> +	int i;
> +
> +	wdt->reset_idx = -EINVAL;
> +	for (i = 0; i < pdata->counter; i++, data++) {
> +		if (strnstr(data->label, "action", sizeof(data->label)))
> +			wdt->action_idx = i;
> +		else if (strnstr(data->label, "timeout", sizeof(data->label)))
> +			wdt->timeout_idx = i;
> +		else if (strnstr(data->label, "timeleft", sizeof(data->label)))
> +			wdt->tleft_idx = i;
> +		else if (strnstr(data->label, "ping", sizeof(data->label)))
> +			wdt->ping_idx = i;
> +		else if (strnstr(data->label, "reset", sizeof(data->label)))
> +			wdt->reset_idx = i;
> +	}
> +
> +	wdt->pdata = pdata;
> +	if (strnstr(pdata->identity, mlxreg_wdt_main_info.identity,
> +		    sizeof(mlxreg_wdt_main_info.identity)))
> +		wdt->wdd.info = &mlxreg_wdt_main_info;
> +	else
> +		wdt->wdd.info = &mlxreg_wdt_aux_info;
> +
> +	wdt->wdt_type = pdata->version;
> +	if (wdt->wdt_type == MLX_WDT_TYPE2) {
> +		wdt->wdd.ops = &mlxreg_wdt_ops_type2;
> +		wdt->wdd.max_timeout = MLXREG_WDT_MAX_TIMEOUT_TYPE2;
> +	} else {
> +		wdt->wdd.ops = &mlxreg_wdt_ops_type1;
> +		wdt->wdd.max_timeout = MLXREG_WDT_MAX_TIMEOUT_TYPE1;
> +	}
> +	wdt->wdd.min_timeout = MLXREG_WDT_MIN_TIMEOUT;
> +}
> +
> +static int mlxreg_wdt_init_timeout(struct mlxreg_wdt *wdt,
> +				   struct mlxreg_core_platform_data *pdata)
> +{
> +	u32 timeout;
> +
> +	timeout = pdata->data[wdt->timeout_idx].health_cntr;
> +	return mlxreg_wdt_set_timeout(&wdt->wdd, timeout);
> +}
> +
> +static int mlxreg_wdt_probe(struct platform_device *pdev)
> +{
> +	struct mlxreg_core_platform_data *pdata;
> +	struct mlxreg_wdt *wdt;
> +	int rc;
> +
> +	pdata = dev_get_platdata(&pdev->dev);
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Failed to get platform data.\n");
> +		return -EINVAL;
> +	}
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->wdd.parent = &pdev->dev;
> +	wdt->regmap = pdata->regmap;
> +	mlxreg_wdt_config(wdt, pdata);
> +
> +	if ((pdata->features & MLXREG_CORE_WD_FEATURE_NOWAYOUT))
> +		watchdog_set_nowayout(&wdt->wdd, WATCHDOG_NOWAYOUT);
> +	watchdog_stop_on_reboot(&wdt->wdd);
> +	watchdog_stop_on_unregister(&wdt->wdd);
> +	watchdog_set_drvdata(&wdt->wdd, wdt);
> +	rc = mlxreg_wdt_init_timeout(wdt, pdata);
> +	if (rc)
> +		goto register_error;
> +
> +	if ((pdata->features & MLXREG_CORE_WD_FEATURE_START_AT_BOOT)) {
> +		rc = mlxreg_wdt_start(&wdt->wdd);
> +		if (rc)
> +			goto register_error;
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +	}
> +	mlxreg_wdt_check_card_reset(wdt);
> +	rc = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
> +
> +register_error:
> +	if (rc)
> +		dev_err(&pdev->dev,
> +			"Cannot register watchdog device (err=%d)\n", rc);
> +	return rc;
> +}
> +
> +static struct platform_driver mlxreg_wdt_driver = {
> +	.probe	= mlxreg_wdt_probe,
> +	.driver	= {
> +			.name = "mlx-wdt",
> +	},
> +};
> +
> +module_platform_driver(mlxreg_wdt_driver);
> +
> +MODULE_AUTHOR("Michael Shych <michaelsh@mellanox.com>");
> +MODULE_DESCRIPTION("Mellanox watchdog driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mlx-wdt");
> 

