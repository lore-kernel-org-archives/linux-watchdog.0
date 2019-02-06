Return-Path: <SRS0=QDKL=QN=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0885C282CC
	for <linux-watchdog@archiver.kernel.org>; Wed,  6 Feb 2019 19:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD0720818
	for <linux-watchdog@archiver.kernel.org>; Wed,  6 Feb 2019 19:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjjyzOmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfBFTOL (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:14:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34413 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBFTOK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 6 Feb 2019 14:14:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so3529274pfg.1;
        Wed, 06 Feb 2019 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MYZjCpNmG4alT2aegRXfiZJ9oQ3zUw5jCNmM8r4Tu4E=;
        b=JjjyzOmTSx97Z14ZG5YPy6Avb6zbmvRWAokGpNszLzEN+hrpodgdl7mb9GlWAZTHmt
         PNN8nFiazG4nEqmGs66g2BcFkYUxCHPk8DWT5oTXpnt86Xg8FvBwcRyuHKj1NsYXaNG6
         VvkWhrSQsRzE8SdWBnT1QACWY7c5FLX5g2PYavxeRY/JlMeFu/6RZ3rEvCsxF3pK7j1z
         o5ysAq0bccnvmWB4GXF1tQNCBwEMuqemE9fLxcnpX5THgrvEi9ulDIyhr32IEvxBNdwU
         GBsXCHw+JeYzzHaUNZOTfERCh4e7ZzjrpX4CNwCQa9WT+AYzN2wdL2rWBMtjFro/HKZD
         FBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MYZjCpNmG4alT2aegRXfiZJ9oQ3zUw5jCNmM8r4Tu4E=;
        b=hnYewlxSF9FepYphACmyE5v3nnd79NVKUY1dOiyIjRljVHo10EFR623PJ8RjVaqXTX
         gnE1iyITwbSjEpVAMfeEgnyTu1RXflT0+iHgZL79GhTTQ1fuBsA+f7EaAp5LyUoFG/xh
         fVHsnu+oGMtO0PXTPCS9LkIF0GGKzQHjkPZeT12k06T7BQNtvpHijHiwIRSj9VERE+8r
         Duk4UdZb+O08azcywIaoFYeaUw70BqI/WsnNAccHadftWP/dk/yO2TTaxNO5zYit6dUZ
         N1hoXy7iFg/vtk0NYZ+Q5hefH7Isre53au2ed1aIkh9t6wZf50ybBmm87NbheWkow/1t
         aYNw==
X-Gm-Message-State: AHQUAuYbOPVb5nCPa3ZHkt0YilVosiewjkeogIcx/N0wT5aKfF+WwWcx
        HYkp8FHNLSzpS2Gh+DhGIPE=
X-Google-Smtp-Source: AHgI3IZdTFTCG/dskvpgBFXNqQkA0FU9DcbNnuZHXTE0DPCk04Bb8Bsyqre28xdTTY2grRlONYbSnw==
X-Received: by 2002:a63:d20f:: with SMTP id a15mr10951981pgg.171.1549480449557;
        Wed, 06 Feb 2019 11:14:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h185sm18525344pfg.143.2019.02.06.11.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 11:14:08 -0800 (PST)
Date:   Wed, 6 Feb 2019 11:14:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     michaelsh@mellanox.com
Cc:     wim@linux-watchdog.org, andy@infradead.org, dvhart@infradead.org,
        linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com
Subject: Re: [PATCH v1 2/3] watchdog: mlx-wdt: introduce watchdog driver for
 Mellanox systems.
Message-ID: <20190206191407.GA12477@roeck-us.net>
References: <20190206165037.4346-1-michaelsh@mellanox.com>
 <20190206165037.4346-3-michaelsh@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206165037.4346-3-michaelsh@mellanox.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, Feb 06, 2019 at 04:50:36PM +0000, michaelsh@mellanox.com wrote:
> From: Michael Shych <michaelsh@mellanox.com>
> 
> Introduce watchdog driver for variious rang of Mellanox Ethernet and

s/variious/various/

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
> ---
>  drivers/watchdog/Kconfig   |  16 ++
>  drivers/watchdog/Makefile  |   1 +
>  drivers/watchdog/mlx_wdt.c | 406 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 423 insertions(+)
>  create mode 100644 drivers/watchdog/mlx_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 57f017d74a97..f1766eb081bb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -241,6 +241,22 @@ config RAVE_SP_WATCHDOG
>  	help
>  	  Support for the watchdog on RAVE SP device.
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
>  # ALPHA Architecture
>  
>  # ARM Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a0917ef28e07..941b74185c9c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -142,6 +142,7 @@ obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>  obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>  obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>  obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
> +obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
>  
>  # M68K Architecture
>  obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
> diff --git a/drivers/watchdog/mlx_wdt.c b/drivers/watchdog/mlx_wdt.c
> new file mode 100644
> index 000000000000..be28aa165cf2
> --- /dev/null
> +++ b/drivers/watchdog/mlx_wdt.c
> @@ -0,0 +1,406 @@
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
> +#define MLXREG_WDT_HW_TIMEOUT_CONVERT(hw_timeout) ((1 << (hw_timeout)) \
> +						   / MLXREG_WDT_CLOCK_SCALE)
> +#define MLXREG_WDT_OPTIONS_BASE (WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | \
> +				 WDIOF_SETTIMEOUT)
> +
> +/**
> + * enum mlxreg_wdt_type - type of HW watchdog
> + *
> + * TYPE1 can be differentiated by different register/mask
> + *	 for WD action set and ping.
> + */
> +enum mlxreg_wdt_type {
> +	MLX_WDT_TYPE1,
> +	MLX_WDT_TYPE2,
> +};
> +
> +/**
> + * struct mlxreg_wdt - wd private data:
> + *
> + * @wdd:	watchdog device;
> + * @device:	basic device;
> + * @pdata:	data received from platform driver;
> + * @regmap:	register map of parent device;
> + * @timeout:	defined timeout in sec.;
> + * @hw_timeout:	real timeout set in hw;
> + *		It will be roundup base of 2 in WD type 1,
> + *		in WD type 2 it will be same number of sec as timeout;
> + * @action_idx:	index for direct access to action register;
> + * @timeout_idx:index for direct access to TO register;
> + * @tleft_idx:	index for direct access to time left register;
> + * @ping_idx:	index for direct access to ping register;
> + * @reset_idx:	index for direct access to reset cause register;
> + * @wd_type:	watchdog HW type;
> + * @hw_timeout:	actual HW timeout;
> + * @io_lock:	spinlock for io access;

watchdog device access is already synchromized in the watchdog core.
Why is this additional lock needed ?

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
> +	u8 hw_timeout;
> +	spinlock_t io_lock;	/* the lock for io operations */
> +};
> +
> +static int mlxreg_wdt_roundup_to_base_2(struct mlxreg_wdt *wdt, int timeout)
> +{
> +	timeout *= MLXREG_WDT_CLOCK_SCALE;
> +
> +	wdt->hw_timeout = order_base_2(timeout);
> +	dev_info(wdt->wdd.parent,
> +		 "watchdog %s timeout %d was rounded up to %lu (msec)\n",
> +		 wdt->wdd.info->identity, timeout, roundup_pow_of_two(timeout));

Please no noise here. It is quite common for watchdog drivers to 
set a timeout value not exactly matching the real timeout.
That is why the selected value is reported to userspace.

> +
> +	return 0;

What exactly is the point of this return value ?

> +}
> +
> +static enum mlxreg_wdt_type
> +mlxreg_wdt_check_watchdog_type(struct mlxreg_wdt *wdt,
> +			       struct mlxreg_core_platform_data *pdata)
> +{
> +	if (pdata->data[wdt->action_idx].reg ==
> +	    pdata->data[wdt->ping_idx].reg &&
> +	    pdata->data[wdt->action_idx].mask ==
> +	    pdata->data[wdt->ping_idx].mask)
> +		return MLX_WDT_TYPE2;
> +
> +	return MLX_WDT_TYPE1;
> +}
> +
> +static int mlxreg_wdt_check_card_reset(struct mlxreg_wdt *wdt)
> +{
> +	struct mlxreg_core_data *reg_data;
> +	u32 regval;
> +	int rc;
> +
> +	if (wdt->reset_idx == -EINVAL)
> +		return -EINVAL;
> +
Return values from this function are not checked and are
thus pointless.

> +	if (!(wdt->wdd.info->options & WDIOF_CARDRESET))
> +		return 0;
> +
> +	spin_lock(&wdt->io_lock);
> +	reg_data = &wdt->pdata->data[wdt->reset_idx];
> +	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +	spin_unlock(&wdt->io_lock);
> +	if (rc)
> +		goto read_error;
> +
> +	if (regval & ~reg_data->mask) {
> +		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> +		dev_info(wdt->wdd.parent,
> +			 "watchdog previously reset the CPU\n");
> +	}
> +
> +read_error:
> +	return rc;
> +}
> +
> +static int mlxreg_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->action_idx];
> +	u32 regval;
> +	int rc;
> +
> +	spin_lock(&wdt->io_lock);
> +	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +	if (rc) {
> +		spin_unlock(&wdt->io_lock);
> +		goto read_error;
> +	}
> +
> +	regval = (regval & reg_data->mask) | BIT(reg_data->bit);
> +	rc = regmap_write(wdt->regmap, reg_data->reg, regval);

I don't immediately see why regmap_update_bits() would not work here.

> +	spin_unlock(&wdt->io_lock);
> +	if (!rc) {
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);

Setting WDOG_HW_RUNNING is only necessary if set during probe,
or in the stop function if the watchdog can not be stopped.
It should not be necessary here. 

[ I see you are calling this function from probe.
  Set the bit there. ]

> +		dev_info(wdd->parent, "watchdog %s started\n",
> +			 wdd->info->identity);

Is all this noise really necessary ?

> +	}
> +
> +read_error:
> +	return rc;
> +}
> +
> +static int mlxreg_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->action_idx];
> +	u32 regval;
> +	int rc;
> +
> +	spin_lock(&wdt->io_lock);
> +	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +	if (rc) {
> +		spin_unlock(&wdt->io_lock);
> +		goto read_error;
> +	}
> +
> +	regval = (regval & reg_data->mask) & ~BIT(reg_data->bit);
> +	rc = regmap_write(wdt->regmap, reg_data->reg, regval);

I don't immediately see why regmap_update_bits() would not work here.

> +	spin_unlock(&wdt->io_lock);
> +	if (!rc)
> +		dev_info(wdd->parent, "watchdog %s stopped\n",
> +			 wdd->info->identity);
> +
> +read_error:
> +	return rc;
> +}
> +
> +static int mlxreg_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->ping_idx];
> +	u32 regval;
> +	int rc;
> +
> +	spin_lock(&wdt->io_lock);
> +	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +	if (rc)
> +		goto read_error;
> +
> +	regval = (regval & reg_data->mask) | BIT(reg_data->bit);
> +	rc = regmap_write(wdt->regmap, reg_data->reg, regval);

Same as above. Besides, the only difference to the start function is the
logging noise there. I would suggest to drop the noise as well as this
function.

> +
> +read_error:
> +	spin_unlock(&wdt->io_lock);
> +
> +	return rc;
> +}
> +
> +static int mlxreg_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	struct mlxreg_wdt *wdt = watchdog_get_drvdata(wdd);
> +	struct mlxreg_core_data *reg_data = &wdt->pdata->data[wdt->timeout_idx];
> +	u32 regval, set_time;
> +	int rc;
> +
> +	spin_lock(&wdt->io_lock);
> +
> +	if (wdt->wdt_type == MLX_WDT_TYPE1) {
> +		rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +		if (rc)
> +			goto read_error;
> +		mlxreg_wdt_roundup_to_base_2(wdt, timeout);
> +		regval = (regval & reg_data->mask) | wdt->hw_timeout;
> +		/* Rowndown to actual closest number of sec. */
> +		set_time = MLXREG_WDT_HW_TIMEOUT_CONVERT(wdt->hw_timeout);

The code is expected to set the value of "wdd->timeout" to the actual
timeout. This is why it is set here, and not in the calling code.

> +	} else {
> +		wdt->hw_timeout = timeout;
> +		set_time = timeout;
> +		regval = timeout;
> +	}
> +
> +	watchdog_init_timeout(&wdt->wdd, set_time, wdd->parent);

This is wrong here. Just set wdd->timeout. watchdog_init_timeout()
should only be called in the probe function.

> +	rc = regmap_write(wdt->regmap, reg_data->reg, regval);
> +
> +read_error:
> +	spin_unlock(&wdt->io_lock);
> +	if (!rc) {
> +		if (watchdog_active(wdd)) {

This warrants an explanation: Presumably updating the timeout
requires it to be stopped and restarted. Overall, however,
it would probably be simpler to call regmap_update_bits()
twice directly here.

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
> +	if (wdt->wdt_type == MLX_WDT_TYPE1)
> +		return 0;
> +
Should never get here, thus this check is unnecessary.

> +	spin_lock(&wdt->io_lock);
> +	rc = regmap_read(wdt->regmap, reg_data->reg, &regval);
> +	spin_unlock(&wdt->io_lock);
> +
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
> +static int mlxreg_wdt_config(struct mlxreg_wdt *wdt,
> +			     struct mlxreg_core_platform_data *pdata)
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
> +	wdt->wdt_type = mlxreg_wdt_check_watchdog_type(wdt, pdata);
> +	if (wdt->wdt_type == MLX_WDT_TYPE2) {
> +		wdt->wdd.ops = &mlxreg_wdt_ops_type2;
> +		wdt->wdd.max_timeout = MLXREG_WDT_MAX_TIMEOUT_TYPE2;
> +	} else {
> +		wdt->wdd.ops = &mlxreg_wdt_ops_type1;
> +		wdt->wdd.max_timeout = MLXREG_WDT_MAX_TIMEOUT_TYPE1;
> +	}
> +	wdt->wdd.min_timeout = MLXREG_WDT_MIN_TIMEOUT;
> +
> +	return 0;
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
> +	spin_lock_init(&wdt->io_lock);
> +
> +	wdt->wdd.parent = &pdev->dev;
> +	wdt->regmap = pdata->regmap;
> +	mlxreg_wdt_config(wdt, pdata);
> +
> +	if ((pdata->features & MLXREG_CORE_WD_FEATURE_NOSTOP_AFTER_START))
> +		watchdog_set_nowayout(&wdt->wdd, WATCHDOG_NOWAYOUT);

That is a bit different than the requested functionality, isn't it ?

> +	watchdog_stop_on_reboot(&wdt->wdd);
> +	watchdog_set_drvdata(&wdt->wdd, wdt);
> +	mlxreg_wdt_check_card_reset(wdt);
> +	rc = mlxreg_wdt_init_timeout(wdt, pdata);
> +	if (rc) {
> +		dev_err(&pdev->dev,
> +			"Cannot init watchdog timeout (err=%d)\n", rc);
> +		return rc;
> +	}
> +
> +	rc = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
> +	if (rc) {
> +		dev_err(&pdev->dev,
> +			"Cannot register watchdog device (err=%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if ((pdata->features & MLXREG_CORE_WD_FEATURE_START_AT_BOOT))
> +		mlxreg_wdt_start(&wdt->wdd);

This should be called before registering the watchdog, and WDOG_HW_RUNNING
should be set here to let the core know that the watchdog is running.

> +
> +	return rc;

rc is always 0 here.

> +}
> +
> +static int mlxreg_wdt_remove(struct platform_device *pdev)
> +{
> +	struct mlxreg_wdt *wdt = dev_get_platdata(&pdev->dev);
> +
> +	mlxreg_wdt_stop(&wdt->wdd);

Call watchdog_stop_on_unregister() before registering the watchdog.

> +	watchdog_unregister_device(&wdt->wdd);

This is wrong. The watchdog is registered with a devm_ function
and is thus automatically unregistered. 

> +
> +	return 0;
> +}
> +
> +static struct platform_driver mlxreg_wdt_driver = {
> +	.probe	= mlxreg_wdt_probe,
> +	.remove	= mlxreg_wdt_remove,
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
> -- 
> 2.11.0
> 
