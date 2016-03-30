Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46728 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcC3XeL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2016 19:34:11 -0400
Date: Wed, 30 Mar 2016 16:34:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: renesas-wdt: add driver
Message-ID: <20160330233411.GA24844@roeck-us.net>
References: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
 <1459351725-14144-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459351725-14144-2-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On Wed, Mar 30, 2016 at 05:28:42PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Add support for watchdogs (RWDT and SWDT) found on RCar Gen3 based SoCs
> from Renesas.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  
[ ... ]

> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */

Please also include linux/bitops.h.

> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/watchdog.h>
> +
[ ... ]

> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, S_IRUGO);

Sure you want this parameter readable ? No problem with me, but it is unusual,
so I figure it is worth asking.

> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct rwdt_priv {
> +	void __iomem *base;
> +	struct watchdog_device wdev;
> +	struct clk *clk;
> +	unsigned clks_per_sec;
> +	u8 cks;
> +};
> +
> +static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned reg)

Please use 'unsigned int' throughout.

> +{
> +	if (reg == RWTCNT)
> +		val |= 0x5a5a0000;
> +	else
> +		val |= 0xa5a5a500;
> +
> +	writel_relaxed(val, priv->base + reg);
> +}
> +
> +static int rwdt_init_timeout(struct watchdog_device *wdev)
> +{
> +	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
> +

Just wondering, does reading RWTCNT return the remaining timeout ?
If so, you could easily implement WDIOC_GETTIMEOUT.

> +	return 0;
> +}
> +
> +static int rwdt_set_timeout(struct watchdog_device *wdev, unsigned new_timeout)
> +{
> +	wdev->timeout = new_timeout;
> +	rwdt_init_timeout(wdev);
> +
The watchdog core calls the ping function after updating the timeout,
so the call here is unnecessary. On top of that, the watchdog core now also
updates wdev->timeout if WDIOF_SETTIMEOUT is set and there is no set_timeout
function. In other words, you can just drop rwdt_set_timeout() entirely.

Thanks,
Guenter
