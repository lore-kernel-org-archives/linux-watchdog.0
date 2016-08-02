Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48081 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbcHBTXW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Aug 2016 15:23:22 -0400
Date: Tue, 2 Aug 2016 12:23:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	soren.brinkmann@xilinx.com, michal.simek@xilinx.com, wim@iguana.be
Subject: Re: [PATCH] watchdog: xilinx: Add clock support
Message-ID: <20160802192313.GA647@roeck-us.net>
References: <1470134220-12927-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470134220-12927-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 02, 2016 at 04:07:00PM +0530, Shubhrajyoti Datta wrote:
> Add support for the clock. Currently we enable
> at probe and relinquish at remove.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
>  drivers/watchdog/of_xilinx_wdt.c                   | 24 ++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> index 6d63782..b0a9fa3 100644
> --- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> @@ -5,6 +5,8 @@ Required properties:
>  - compatible		: Should be "xlnx,xps-timebase-wdt-1.00.a" or
>  			  "xlnx,xps-timebase-wdt-1.01.a".
>  - reg			: Physical base address and size
> +- clocks		: Input clock specifier. Refer to common clock
> +			  bindings.
>  
>  Optional properties:
>  - clock-frequency	: Frequency of clock in Hz
> @@ -17,6 +19,7 @@ Example:
>  axi-timebase-wdt@40100000 {
>  	clock-frequency = <50000000>;
>  	compatible = "xlnx,xps-timebase-wdt-1.00.a";
> +	clocks = <&clkc 15>;
>  	reg = <0x40100000 0x10000>;
>  	xlnx,wdt-enable-once = <0x0>;
>  	xlnx,wdt-interval = <0x1b>;
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index b2e1b4c..23cbb33 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -10,6 +10,7 @@
>   * 2 of the License, or (at your option) any later version.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
> @@ -45,6 +46,7 @@ struct xwdt_device {
>  	u32 wdt_interval;
>  	spinlock_t spinlock;
>  	struct watchdog_device xilinx_wdt_wdd;
> +	struct clk		*clk;
>  };
>  
>  static int xilinx_wdt_start(struct watchdog_device *wdd)
> @@ -194,17 +196,30 @@ static int xwdt_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&xdev->spinlock);
>  	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
> +	xdev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(xdev->clk)) {
> +		dev_err(&pdev->dev, "input clock not found\n");
> +		rc = PTR_ERR(xdev->clk);
> +		return rc;
> +	}
> +
> +	rc = clk_prepare_enable(xdev->clk);
> +	if (rc) {
> +		dev_err(&pdev->dev, "unable to enable clock\n");
> +		goto err_clk_disable;

Enable failed. Why try to disable ?

> +	}
> +
>  

Please no double empty lines.

>  	rc = xwdt_selftest(xdev);
>  	if (rc == XWT_TIMER_FAILED) {
>  		dev_err(&pdev->dev, "SelfTest routine error\n");
> -		return rc;
> +		goto err_clk_disable;
>  	}
>  
>  	rc = watchdog_register_device(xilinx_wdt_wdd);
>  	if (rc) {
>  		dev_err(&pdev->dev, "Cannot register watchdog (err=%d)\n", rc);
> -		return rc;
> +		goto err_clk_disable;
>  	}
>  
>  	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
> @@ -213,6 +228,10 @@ static int xwdt_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, xdev);
>  
>  	return 0;
> +err_clk_disable:
> +	clk_disable_unprepare(xdev->clk);
> +
> +	return rc;
>  }
>  
>  static int xwdt_remove(struct platform_device *pdev)
> @@ -220,6 +239,7 @@ static int xwdt_remove(struct platform_device *pdev)
>  	struct xwdt_device *xdev = platform_get_drvdata(pdev);
>  
>  	watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
> +	clk_disable_unprepare(xdev->clk);
>  
>  	return 0;
>  }
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
