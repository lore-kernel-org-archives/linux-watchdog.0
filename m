Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:52236 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab3JVN0Z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Oct 2013 09:26:25 -0400
Message-ID: <52667CF4.6060302@roeck-us.net>
Date: Tue, 22 Oct 2013 06:26:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: dinguyen@altera.com, dinh.linux@gmail.com
CC: Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCHv3] watchdog: dw: Enable OF support for DW watchdog timer
References: <1382434181-16936-1-git-send-email-dinguyen@altera.com>
In-Reply-To: <1382434181-16936-1-git-send-email-dinguyen@altera.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/22/2013 02:29 AM, dinguyen@altera.com wrote:
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
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> ---
> v3:
> - Clean up documentation
> v2:
> - Use of_match_ptr() for of_match_table
> ---
>   .../devicetree/bindings/watchdog/dw_wdt.txt        |   14 ++++++++++++++
>   drivers/watchdog/dw_wdt.c                          |    8 ++++++++
>   2 files changed, 22 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> new file mode 100644
> index 0000000..c5e9b65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> @@ -0,0 +1,14 @@
> +Synopsys Designware Watchdog Timer
> +
> +Required Properties:
> +
> +- compatible	: Should be "snps,dw-wdt"
> +- reg		: Base address and size of the watchdog timer register.
> +

'clocks' is still missing.

Thanks,
Guenter

> +Example:
> +
> +	watchdog0: wd@ffd02000 {
> +		compatible = "snps,dw-wdt";
> +		reg = <0xffd02000 0x1000>;
> +		clocks = <&per_base_clk>;
> +	};
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index e621098..261fa42 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -29,6 +29,7 @@
>   #include <linux/miscdevice.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> +#include <linux/of.h>
>   #include <linux/pm.h>
>   #include <linux/platform_device.h>
>   #include <linux/spinlock.h>
> @@ -340,12 +341,19 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +static const struct of_device_id dw_wdt_of_match[] = {
> +	{ .compatible = "snps,dw-wdt", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, dw_wdt_of_match);
> +
>   static struct platform_driver dw_wdt_driver = {
>   	.probe		= dw_wdt_drv_probe,
>   	.remove		= dw_wdt_drv_remove,
>   	.driver		= {
>   		.name	= "dw_wdt",
>   		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(dw_wdt_of_match),
>   #ifdef CONFIG_PM
>   		.pm	= &dw_wdt_pm_ops,
>   #endif /* CONFIG_PM */
>

