Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37066 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbcHLGfX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Aug 2016 02:35:23 -0400
Subject: Re: [PATCHv4] watchdog: xilinx: Add clock support
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
References: <1470982664-13228-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Cc: soren.brinkmann@xilinx.com, shubhrajyoti.datta@gmail.com,
	michal.simek@xilinx.com, wim@iguana.be
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1a86f6d6-fc92-81ec-eb07-669c2bda8b38@roeck-us.net>
Date: Thu, 11 Aug 2016 23:34:32 -0700
MIME-Version: 1.0
In-Reply-To: <1470982664-13228-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/11/2016 11:17 PM, Shubhrajyoti Datta wrote:
> Add support for the clock. Currently we enable
> at probe and relinquish at remove.
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> fix spaces and error path.
> v3
> do not fail existing dts
> v4:
> fix the error prints as the clock is optional
>
>  .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
>  drivers/watchdog/of_xilinx_wdt.c                   | 27 ++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> index 6d63782..c6ae9c9 100644
> --- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> @@ -7,6 +7,8 @@ Required properties:
>  - reg			: Physical base address and size
>
>  Optional properties:
> +- clocks		: Input clock specifier. Refer to common clock
> +			  bindings.
>  - clock-frequency	: Frequency of clock in Hz
>  - xlnx,wdt-enable-once	: 0 - Watchdog can be restarted
>  			  1 - Watchdog can be enabled just once
> @@ -17,6 +19,7 @@ Example:
>  axi-timebase-wdt@40100000 {
>  	clock-frequency = <50000000>;
>  	compatible = "xlnx,xps-timebase-wdt-1.00.a";
> +	clocks = <&clkc 15>;
>  	reg = <0x40100000 0x10000>;
>  	xlnx,wdt-enable-once = <0x0>;
>  	xlnx,wdt-interval = <0x1b>;
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index b2e1b4c..f757e6d 100644
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
> @@ -195,16 +197,32 @@ static int xwdt_probe(struct platform_device *pdev)
>  	spin_lock_init(&xdev->spinlock);
>  	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
>
> +	xdev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(xdev->clk)) {
> +		if (PTR_ERR(xdev->clk) == -ENOENT) {
> +			dev_info(&pdev->dev, "input clock not provided\n");

The clock is optional. Why print anything ?

I am not a friend of logging noise, and I think this is just noise.
Would you want such a message printed for each optional property ?

Guenter

> +			xdev->clk = NULL;
> +		} else {
> +			return PTR_ERR(xdev->clk);
> +		}
> +	}
> +
> +	rc = clk_prepare_enable(xdev->clk);
> +	if (rc) {
> +		dev_err(&pdev->dev, "unable to enable clock\n");
> +		return rc;
> +	}
> +
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
> @@ -213,6 +231,10 @@ static int xwdt_probe(struct platform_device *pdev)
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
> @@ -220,6 +242,7 @@ static int xwdt_remove(struct platform_device *pdev)
>  	struct xwdt_device *xdev = platform_get_drvdata(pdev);
>
>  	watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
> +	clk_disable_unprepare(xdev->clk);
>
>  	return 0;
>  }
>

