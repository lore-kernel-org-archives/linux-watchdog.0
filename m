Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:43332 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab3GJKlG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jul 2013 06:41:06 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so4778363eaj.19
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Jul 2013 03:41:03 -0700 (PDT)
Date: Wed, 10 Jul 2013 11:41:01 +0100
From: Jamie Iles <jamie@jamieiles.com>
To: dinguyen@altera.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, dinh.linux@gmail.com,
	Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH] watchdog: dw: Enable OF support for DW watchdog timer.
Message-ID: <20130710104101.GA3552@page>
References: <1373411377-5170-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1373411377-5170-1-git-send-email-dinguyen@altera.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dinh,

On Tue, Jul 09, 2013 at 06:09:37PM -0500, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add device tree support to the DW watchdog timer.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Pavel Machek <pavel@denx.de>
> ---
>  .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 ++++++++++++++++
>  drivers/watchdog/dw_wdt.c                          |    7 +++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 2037669..f7eec38 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -343,12 +343,19 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
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
> +		.of_match_table = dw_wdt_of_match,

I think we want:

		.of_match_table = of_match_ptr(dw_wdt_of_match),

as the module doesn't have an OF dependency.

Otherwise looks good to me.

Acked-by: Jamie Iles <jamie@jamieiles.com>

Thanks,

Jamie
