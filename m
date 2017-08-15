Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36768 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbdHOBuD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 21:50:03 -0400
Date: Mon, 14 Aug 2017 18:49:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Maulik Jodhani <maulik.jodhani@xilinx.com>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [1/2] watchdog: of_xilinx_wdt: Add support for reading freq via
 CCF
Message-ID: <20170815014959.GA31850@roeck-us.net>
References: <d081ea43fc2b3b75cae2e19716920e1bb6c81328.1502105061.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d081ea43fc2b3b75cae2e19716920e1bb6c81328.1502105061.git.michal.simek@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 07, 2017 at 01:24:22PM +0200, Michal Simek wrote:
> From: Maulik Jodhani <maulik.jodhani@xilinx.com>
> 
> Improve CLK handling in the code to read freq via CCF.
> Also disable CLK asap and add clk handling code to start and stop.
> 
> Signed-off-by: Maulik Jodhani <maulik.jodhani@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  drivers/watchdog/of_xilinx_wdt.c | 45 ++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index fae7fe929ea3..41edeb93a327 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -51,9 +51,16 @@ struct xwdt_device {
>  
>  static int xilinx_wdt_start(struct watchdog_device *wdd)
>  {
> +	int ret;
>  	u32 control_status_reg;
>  	struct xwdt_device *xdev = watchdog_get_drvdata(wdd);
>  
> +	ret = clk_enable(xdev->clk);
> +	if (ret) {
> +		dev_err(wdd->parent, "Failed to enable clock\n");
> +		return ret;
> +	}
> +
>  	spin_lock(&xdev->spinlock);
>  
>  	/* Clean previous status and enable the watchdog timer */
> @@ -85,6 +92,9 @@ static int xilinx_wdt_stop(struct watchdog_device *wdd)
>  	iowrite32(0, xdev->base + XWT_TWCSR1_OFFSET);
>  
>  	spin_unlock(&xdev->spinlock);
> +
> +	clk_disable(xdev->clk);
> +
>  	pr_info("Stopped!\n");
>  
>  	return 0;
> @@ -167,11 +177,6 @@ static int xwdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(xdev->base))
>  		return PTR_ERR(xdev->base);
>  
> -	rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &pfreq);
> -	if (rc)
> -		dev_warn(&pdev->dev,
> -			 "The watchdog clock frequency cannot be obtained\n");
> -
>  	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
>  				  &xdev->wdt_interval);
>  	if (rc)
> @@ -186,6 +191,26 @@ static int xwdt_probe(struct platform_device *pdev)
>  
>  	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
>  
> +	xdev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(xdev->clk)) {
> +		if (PTR_ERR(xdev->clk) != -ENOENT)
> +			return PTR_ERR(xdev->clk);
> +
> +		/*
> +		 * Clock framework support is optional, continue on
> +		 * anyways if we don't find a matching clock.
> +		 */
> +		xdev->clk = NULL;
> +
> +		rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> +					  &pfreq);
> +		if (rc)
> +			dev_warn(&pdev->dev,
> +				 "The watchdog clock freq cannot be obtained\n");
> +	} else {
> +		pfreq = clk_get_rate(xdev->clk);
> +	}
> +
>  	/*
>  	 * Twice of the 2^wdt_interval / freq  because the first wdt overflow is
>  	 * ignored (interrupt), reset is only generated at second wdt overflow
> @@ -197,14 +222,6 @@ static int xwdt_probe(struct platform_device *pdev)
>  	spin_lock_init(&xdev->spinlock);
>  	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
>  
> -	xdev->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(xdev->clk)) {
> -		if (PTR_ERR(xdev->clk) == -ENOENT)
> -			xdev->clk = NULL;
> -		else
> -			return PTR_ERR(xdev->clk);
> -	}
> -
>  	rc = clk_prepare_enable(xdev->clk);
>  	if (rc) {
>  		dev_err(&pdev->dev, "unable to enable clock\n");
> @@ -223,6 +240,8 @@ static int xwdt_probe(struct platform_device *pdev)
>  		goto err_clk_disable;
>  	}
>  
> +	clk_disable(xdev->clk);
> +
>  	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
>  		 xdev->base, xilinx_wdt_wdd->timeout);
>  
