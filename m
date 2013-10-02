Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57832 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab3JBTeN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Oct 2013 15:34:13 -0400
Date: Wed, 2 Oct 2013 12:27:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [RESEND PATCHv2] watchdog: dw: Enable OF support for DW watchdog
 timer.
Message-ID: <20131002192743.GA4695@roeck-us.net>
References: <1380739472-26172-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380739472-26172-1-git-send-email-dinguyen@altera.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 02, 2013 at 01:44:32PM -0500, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add device tree support to the DW watchdog timer.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> ---
> v2:
> - Use of_match_ptr() for of_match_table
> ---
>  .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 ++++++++++++++++
>  drivers/watchdog/dw_wdt.c                          |    8 ++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> new file mode 100644
> index 0000000..29e150b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> @@ -0,0 +1,16 @@
> +Synopsys Designware Watchdog Timer
> +
> +Required Properties:
> +
> +- Compatiblity	: "snps,dw-wdt"
> +- reg		: Base address of the watchdog timer register.
> +
> +Example:
> +
> +	watchdog0: wd@ffd02000 {
> +		compatible = "snps,dw-wdt";
> +		reg = <0xffd02000 0x1000>;
> +		interrupts = <0 171 4>;
> +		clocks = <&per_base_clk>;
> +		status = "okay";
> +	};
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 2037669..a720f9b 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -29,6 +29,7 @@
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> @@ -343,12 +344,19 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id dw_wdt_of_match[] = {
> +	{ .compatible = "snps,dw-wdt", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, dw_wdt_of_match);
> +
>  static struct platform_driver dw_wdt_driver = {
>  	.probe		= dw_wdt_drv_probe,
>  	.remove		= dw_wdt_drv_remove,
>  	.driver		= {
>  		.name	= "dw_wdt",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(dw_wdt_of_match),

There is a separate set of patches from Sachin, removing unnecessary
uses of of_match_ptr() from various watchdog drivers. Sachin's argument
is that it does not make sense to use of_match_ptr if the function
it points to (dw_wdt_of_match in this case) is always compiled
unconditionally anyway.

Your comments suggest that you actually _added_ of_match_ptr() in v2 of this
patch, even though dw_wdt_of_match always exists and of_match_ptr is thus
technically unnecessary.

Not that I really care one way or another, but can we get an authoritative
answer what subsystem maintainers are supposed to accept ?

Thanks,
Guenter

>  #ifdef CONFIG_PM
>  		.pm	= &dw_wdt_pm_ops,
>  #endif /* CONFIG_PM */
> -- 
> 1.7.9.5
> 
> 
> 
