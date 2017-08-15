Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38856 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753262AbdHOBv6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 21:51:58 -0400
Date: Mon, 14 Aug 2017 18:51:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [2/2] watchdog: of_xilinx_wdt: Add suspend/resume support
Message-ID: <20170815015155.GA32016@roeck-us.net>
References: <1e1307808bd32591ea4f03ec3d70d0eadb38b91e.1502105061.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1307808bd32591ea4f03ec3d70d0eadb38b91e.1502105061.git.michal.simek@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 07, 2017 at 01:24:23PM +0200, Michal Simek wrote:
> Add suspend/resume support to driver.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  drivers/watchdog/of_xilinx_wdt.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 41edeb93a327..1cf286945b7a 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -264,6 +264,43 @@ static int xwdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/**
> + * xwdt_suspend - Suspend the device.
> + *
> + * @dev: handle to the device structure.
> + * Return: 0 always.
> + */
> +static int __maybe_unused xwdt_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct xwdt_device *xdev = platform_get_drvdata(pdev);
> +
> +	if (watchdog_active(&xdev->xilinx_wdt_wdd))
> +		xilinx_wdt_stop(&xdev->xilinx_wdt_wdd);
> +
> +	return 0;
> +}
> +
> +/**
> + * xwdt_resume - Resume the device.
> + *
> + * @dev: handle to the device structure.
> + * Return: 0 on success, errno otherwise.
> + */
> +static int __maybe_unused xwdt_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct xwdt_device *xdev = platform_get_drvdata(pdev);
> +	int ret = 0;
> +
> +	if (watchdog_active(&xdev->xilinx_wdt_wdd))
> +		ret = xilinx_wdt_start(&xdev->xilinx_wdt_wdd);
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
> +
>  /* Match table for of_platform binding */
>  static const struct of_device_id xwdt_of_match[] = {
>  	{ .compatible = "xlnx,xps-timebase-wdt-1.00.a", },
> @@ -278,6 +315,7 @@ static int xwdt_remove(struct platform_device *pdev)
>  	.driver = {
>  		.name  = WATCHDOG_NAME,
>  		.of_match_table = xwdt_of_match,
> +		.pm = &xwdt_pm_ops,
>  	},
>  };
>  
