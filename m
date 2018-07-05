Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44400 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEP2M (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 5 Jul 2018 11:28:12 -0400
Subject: Re: [RFC PATCH] watchdog: sp805: Add clock-frequency property
To: Srinath Mannam <srinath.mannam@broadcom.com>,
        wim@linux-watchdog.org
Cc: ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f29c486a-2ac8-55e7-86ed-90e3cf71bcea@roeck-us.net>
Date: Thu, 5 Jul 2018 08:28:08 -0700
MIME-Version: 1.0
In-Reply-To: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/04/2018 08:22 PM, Srinath Mannam wrote:
> When using ACPI node, binding clock devices are
> not available as device tree, So clock-frequency
> property given in _DSD object of ACPI device is
> used to calculate Watchdog rate.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>   drivers/watchdog/sp805_wdt.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 9849db0..d830dbc 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -22,6 +22,7 @@
>   #include <linux/math64.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> +#include <linux/of.h>
>   #include <linux/pm.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> @@ -65,6 +66,7 @@ struct sp805_wdt {
>   	spinlock_t			lock;
>   	void __iomem			*base;
>   	struct clk			*clk;
> +	u64				rate;
>   	struct amba_device		*adev;
>   	unsigned int			load_val;
>   };
> @@ -80,7 +82,10 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>   	u64 load, rate;
>   
> -	rate = clk_get_rate(wdt->clk);
> +	if (wdt->rate)
> +		rate = wdt->rate;
> +	else
> +		rate = clk_get_rate(wdt->clk);

No. Get the rate once during probe and store it in wdt->rate.

>   
>   	/*
>   	 * sp805 runs counter with given value twice, after the end of first
> @@ -108,7 +113,10 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>   	u64 load, rate;
>   
> -	rate = clk_get_rate(wdt->clk);
> +	if (wdt->rate)
> +		rate = wdt->rate;
> +	else
> +		rate = clk_get_rate(wdt->clk);

Same here.

>   
>   	spin_lock(&wdt->lock);
>   	load = readl_relaxed(wdt->base + WDTVALUE);
> @@ -230,11 +238,22 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   
>   	wdt->clk = devm_clk_get(&adev->dev, NULL);
>   	if (IS_ERR(wdt->clk)) {
> -		dev_warn(&adev->dev, "Clock not found\n");
> -		ret = PTR_ERR(wdt->clk);
> -		goto err;
> +		dev_warn(&adev->dev, "Clock device not found\n");

"Clock _device_" ? Why this change ? And why retain that warning unconditionally ?

> +		wdt->clk = NULL;
> +		/*
> +		 * When Driver probe with ACPI device, clock devices
> +		 * are not available, so watchdog rate get from
> +		 * clock-frequency property given in _DSD object.
> +		 */
> +		device_property_read_u64(&adev->dev, "clock-frequency",
> +					 &wdt->rate);
> +		if (!wdt->rate) {
> +			ret = -ENODEV;

This unconditionally overrides the original error.

> +			goto err;
> +		}
>   	}
>   
> +

No whitespace changes, please.

Does that mean that ACPI doesn't support the clock subsystem and that each driver
supporting ACPI must do this ? That would be messy. Also, the above does not check
if the device was probed through ACPI. It just tries to find an undocumented
"clock-frequency" property which is quite different and would apply to
(probably mis-configured) devicetree files as well.

Either case, I would rather have this addressed through the clock subsystem.
Otherwise, someone with subject knowledge will have to confirm that this is the
appropriate solution. If so, the new property will have to be documented as an
alternative to clock specifiers and accepted by devicetree maintainers.

Guenter

>   	wdt->adev = adev;
>   	wdt->wdd.info = &wdt_info;
>   	wdt->wdd.ops = &wdt_ops;
> 

