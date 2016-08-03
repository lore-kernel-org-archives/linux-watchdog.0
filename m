Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44372 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbcHCQYY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Aug 2016 12:24:24 -0400
Subject: Re: [PATCHv2] watchdog: xilinx: Add clock support
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
References: <1470198518-22286-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Cc: soren.brinkmann@xilinx.com, shubhrajyoti.datta@gmail.com,
	michal.simek@xilinx.com, wim@iguana.be
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57A21A64.4090509@roeck-us.net>
Date: Wed, 3 Aug 2016 09:23:00 -0700
MIME-Version: 1.0
In-Reply-To: <1470198518-22286-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/02/2016 09:28 PM, Shubhrajyoti Datta wrote:
> Add support for the clock. Currently we enable
> at probe and relinquish at remove.
>
> Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Patch itself looks good.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Do you have a separate patch to add the clock to virtex440-ml507.dts ?

Not that it matters much, I guess - virtex440-ml507.dts says
		compatible = "xlnx,xps-timebase-wdt-1.00.b";
which isn't supported by of_xilinx_wdt.c, and not documented in
of-xilinx-wdt.txt. Is that an oversight or on purpose ?

Thanks,
Guenter

> ---
> v2:
> fix spaces and error path.
>
>   .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
>   drivers/watchdog/of_xilinx_wdt.c                   | 23 ++++++++++++++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> index 6d63782..b0a9fa3 100644
> --- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> @@ -5,6 +5,8 @@ Required properties:
>   - compatible		: Should be "xlnx,xps-timebase-wdt-1.00.a" or
>   			  "xlnx,xps-timebase-wdt-1.01.a".
>   - reg			: Physical base address and size
> +- clocks		: Input clock specifier. Refer to common clock
> +			  bindings.
>
>   Optional properties:
>   - clock-frequency	: Frequency of clock in Hz
> @@ -17,6 +19,7 @@ Example:
>   axi-timebase-wdt@40100000 {
>   	clock-frequency = <50000000>;
>   	compatible = "xlnx,xps-timebase-wdt-1.00.a";
> +	clocks = <&clkc 15>;
>   	reg = <0x40100000 0x10000>;
>   	xlnx,wdt-enable-once = <0x0>;
>   	xlnx,wdt-interval = <0x1b>;
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index b2e1b4c..a225e43 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -10,6 +10,7 @@
>    * 2 of the License, or (at your option) any later version.
>    */
>
> +#include <linux/clk.h>
>   #include <linux/err.h>
>   #include <linux/module.h>
>   #include <linux/types.h>
> @@ -45,6 +46,7 @@ struct xwdt_device {
>   	u32 wdt_interval;
>   	spinlock_t spinlock;
>   	struct watchdog_device xilinx_wdt_wdd;
> +	struct clk		*clk;
>   };
>
>   static int xilinx_wdt_start(struct watchdog_device *wdd)
> @@ -194,17 +196,29 @@ static int xwdt_probe(struct platform_device *pdev)
>
>   	spin_lock_init(&xdev->spinlock);
>   	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
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
> +		return rc;
> +	}
>
>   	rc = xwdt_selftest(xdev);
>   	if (rc == XWT_TIMER_FAILED) {
>   		dev_err(&pdev->dev, "SelfTest routine error\n");
> -		return rc;
> +		goto err_clk_disable;
>   	}
>
>   	rc = watchdog_register_device(xilinx_wdt_wdd);
>   	if (rc) {
>   		dev_err(&pdev->dev, "Cannot register watchdog (err=%d)\n", rc);
> -		return rc;
> +		goto err_clk_disable;
>   	}
>
>   	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
> @@ -213,6 +227,10 @@ static int xwdt_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, xdev);
>
>   	return 0;
> +err_clk_disable:
> +	clk_disable_unprepare(xdev->clk);
> +
> +	return rc;
>   }
>
>   static int xwdt_remove(struct platform_device *pdev)
> @@ -220,6 +238,7 @@ static int xwdt_remove(struct platform_device *pdev)
>   	struct xwdt_device *xdev = platform_get_drvdata(pdev);
>
>   	watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
> +	clk_disable_unprepare(xdev->clk);
>
>   	return 0;
>   }
>

