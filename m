Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48847 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756112AbcIVNOv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Sep 2016 09:14:51 -0400
Subject: Re: [PATCH 2/3] watchdog: dw_wdt: get reset lines from dt
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org
References: <1474527753-22194-1-git-send-email-s.trumtrar@pengutronix.de>
 <1474527753-22194-3-git-send-email-s.trumtrar@pengutronix.de>
Cc: kernel@pengutronix.de, Wim Van Sebroeck <wim@iguana.be>,
        linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <89edac4c-a105-21df-de50-367da345806a@roeck-us.net>
Date: Thu, 22 Sep 2016 06:14:44 -0700
MIME-Version: 1.0
In-Reply-To: <1474527753-22194-3-git-send-email-s.trumtrar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/22/2016 12:02 AM, Steffen Trumtrar wrote:
> The dw_wdt has an external reset line, that can keep the device in reset
> and therefore rendering it useless and also is the only way of stopping
> the watchdog once it was started.
>
> Get the reset lines for this core from the devicetree.
> If resets are not specified just warn but don't fail probing to be compatible
> with all users.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> ---
>  drivers/watchdog/dw_wdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 2acb51cf5504..e024722e8b3b 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -31,6 +31,7 @@
>  #include <linux/pm.h>
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
> +#include <linux/reset.h>
>  #include <linux/watchdog.h>
>
>  #define WDOG_CONTROL_REG_OFFSET		    0x00
> @@ -56,6 +57,7 @@ struct dw_wdt {
>  	struct clk		*clk;
>  	struct notifier_block	restart_handler;
>  	struct watchdog_device	wdd;
> +	struct reset_control	*rst;
>  };
>
>  #define to_dw_wdt(wdd)	container_of(wdd, struct dw_wdt, wdd)
> @@ -231,6 +233,10 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	dw_wdt->rst = devm_reset_control_get(&pdev->dev, "dw-wdt");
> +	if (IS_ERR(dw_wdt->rst))
> +		dev_warn(dev, "No reset lines. Will not be able to stop once started.\n");

This situation is already handled by the driver. Actually, I don't even
know what will happen, since the watchdog core will continue to ping
the watchdog after close, and it won't be possible to unload the driver
if the watchdog is running.

I don't think a warning is warranted in this case. We did not need one before,
we should not need one now.

> +
>  	wdd = &dw_wdt->wdd;
>  	wdd->info = &dw_wdt_ident;
>  	wdd->ops = &dw_wdt_ops;
> @@ -268,6 +274,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	if (ret)
>  		pr_warn("cannot register restart handler\n");
>
> +	if (dw_wdt->rst)
> +		reset_control_deassert(dw_wdt->rst);
> +
>  	return 0;
>
>  out_disable_clk:
>

