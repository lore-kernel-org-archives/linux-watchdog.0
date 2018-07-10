Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33710 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbeGJVg7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 17:36:59 -0400
Date: Tue, 10 Jul 2018 14:35:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: wim@linux-watchdog.org, ray.jui@broadcom.com,
        vladimir.olovyannikov@broadcom.com, vikram.prakash@broadcom.com,
        scott.branden@broadcom.com, sudeep.holla@arm.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
Message-ID: <20180710213557.GC27827@roeck-us.net>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 10, 2018 at 02:14:39PM +0530, Srinath Mannam wrote:
> When using ACPI node, binding clock devices are
> not available as device tree, So clock-frequency
> property given in _DSD object of ACPI device is
> used to calculate Watchdog rate.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>

I am ok with the patch itself. All that is missing now is a
reference to the _DSD property documentation. Is that published
somewhere or is it all wild-wild-west ?

Thanks,
Guenter

> ---
>  drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 9849db0..a896b1c 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -11,6 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/resource.h>
>  #include <linux/amba/bus.h>
> @@ -22,6 +23,7 @@
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -65,6 +67,7 @@ struct sp805_wdt {
>  	spinlock_t			lock;
>  	void __iomem			*base;
>  	struct clk			*clk;
> +	u64				rate;
>  	struct amba_device		*adev;
>  	unsigned int			load_val;
>  };
> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>  	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>  	u64 load, rate;
>  
> -	rate = clk_get_rate(wdt->clk);
> +	rate = wdt->rate;
>  
>  	/*
>  	 * sp805 runs counter with given value twice, after the end of first
> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>  static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>  {
>  	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> -	u64 load, rate;
> -
> -	rate = clk_get_rate(wdt->clk);
> +	u64 load;
>  
>  	spin_lock(&wdt->lock);
>  	load = readl_relaxed(wdt->base + WDTVALUE);
> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>  		load += wdt->load_val + 1;
>  	spin_unlock(&wdt->lock);
>  
> -	return div_u64(load, rate);
> +	return div_u64(load, wdt->rate);
>  }
>  
>  static int
> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
>  
> -	wdt->clk = devm_clk_get(&adev->dev, NULL);
> -	if (IS_ERR(wdt->clk)) {
> -		dev_warn(&adev->dev, "Clock not found\n");
> -		ret = PTR_ERR(wdt->clk);
> -		goto err;
> +	if (adev->dev.of_node) {
> +		wdt->clk = devm_clk_get(&adev->dev, NULL);
> +		if (IS_ERR(wdt->clk)) {
> +			dev_err(&adev->dev, "Clock not found\n");
> +			return PTR_ERR(wdt->clk);
> +		}
> +		wdt->rate = clk_get_rate(wdt->clk);
> +	} else if (has_acpi_companion(&adev->dev)) {
> +		/*
> +		 * When Driver probe with ACPI device, clock devices
> +		 * are not available, so watchdog rate get from
> +		 * clock-frequency property given in _DSD object.
> +		 */
> +		device_property_read_u64(&adev->dev, "clock-frequency",
> +					 &wdt->rate);
> +		if (!wdt->rate) {
> +			dev_err(&adev->dev, "no clock-frequency property\n");
> +			return -ENODEV;
> +		}
>  	}
>  
>  	wdt->adev = adev;
> -- 
> 2.7.4
> 
