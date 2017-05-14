Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39542 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbdENOdm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 May 2017 10:33:42 -0400
Subject: Re: [PATCH v2 2/3] watchdog: dw_wdt: get reset lines from dt
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org
References: <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
 <4aa9252b45f2334eb429bb195d5d2963b4e61db1.1494595189.git-series.s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <db63fee1-6938-48b1-9912-ced318341782@roeck-us.net>
Date: Sun, 14 May 2017 07:33:37 -0700
MIME-Version: 1.0
In-Reply-To: <4aa9252b45f2334eb429bb195d5d2963b4e61db1.1494595189.git-series.s.trumtrar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/12/2017 06:34 AM, Steffen Trumtrar wrote:
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
>  drivers/watchdog/dw_wdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 914da3a4d334..3accddf1f381 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/watchdog.h>
>
>  #define WDOG_CONTROL_REG_OFFSET		    0x00
> @@ -54,6 +55,7 @@ struct dw_wdt {
>  	struct clk		*clk;
>  	unsigned long		rate;
>  	struct watchdog_device	wdd;
> +	struct reset_control	*rst;
>  };
>
>  #define to_dw_wdt(wdd)	container_of(wdd, struct dw_wdt, wdd)
> @@ -234,6 +236,8 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  		goto out_disable_clk;
>  	}
>
> +	dw_wdt->rst = devm_reset_control_get(&pdev->dev, NULL);
> +

devm_reset_control_get() does not return NULL, it returns ERR_PTR on error.

>  	wdd = &dw_wdt->wdd;
>  	wdd->info = &dw_wdt_ident;
>  	wdd->ops = &dw_wdt_ops;
> @@ -267,6 +271,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_disable_clk;
>
> +	if (dw_wdt->rst)
> +		reset_control_deassert(dw_wdt->rst);

Granted, this doesn't cause a crash here, but a warning with traceback.
Either case, the if() statement misses the point.

> +
>  	return 0;
>
>  out_disable_clk:
>

