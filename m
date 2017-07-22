Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36023 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdGVVbz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Jul 2017 17:31:55 -0400
Date: Sat, 22 Jul 2017 14:31:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: wim@iguana.be, joshc@codeaurora.org,
        linux-watchdog@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] watchdog: qcom: Check for platform_get_resource() failure
Message-ID: <20170722213153.GE2969@roeck-us.net>
References: <1500739473-9982-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500739473-9982-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Jul 22, 2017 at 01:04:33PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> platform_get_resource() may fail, so we should better check its
> return value and propagate an error in case it fails.
> 
> This avoids a NULL pointer dereference a bit later in the code.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/qcom-wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 4f47b5e..7809713 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -162,6 +162,8 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOMEM;
>  
>  	/* We use CPU0's DGT for the watchdog */
>  	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
> -- 
> 2.7.4
> 
