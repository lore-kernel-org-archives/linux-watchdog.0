Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54953 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbcHWMpJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 Aug 2016 08:45:09 -0400
Subject: Re: [PATCHv2] watchdog: cadence_wdt: Fix the suspend resume
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-watchdog@vger.kernel.org
References: <1471945741-5021-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Cc: shubhrajyoti.datta@gmail.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9764548b-3586-0e28-b535-ec5d983ad8c5@roeck-us.net>
Date: Tue, 23 Aug 2016 05:45:02 -0700
MIME-Version: 1.0
In-Reply-To: <1471945741-5021-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/23/2016 02:49 AM, Shubhrajyoti Datta wrote:
> Currently even if no users are there the suspend tries to
> stop the watchdog and resume starts it.
>
> so after resume the watchdog starts and resets the board.
> Fix the same by adding a check for users.
>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: use watchdog_active
>
>  drivers/watchdog/cadence_wdt.c |   18 +++++++++++-------
>  1 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 4dda902..0fd267e 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -424,8 +424,10 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
>
> -	cdns_wdt_stop(&wdt->cdns_wdt_device);
> -	clk_disable_unprepare(wdt->clk);
> +	if (watchdog_active(&wdt->cdns_wdt_device)) {
> +		cdns_wdt_stop(&wdt->cdns_wdt_device);
> +		clk_disable_unprepare(wdt->clk);
> +	}
>
>  	return 0;
>  }
> @@ -442,12 +444,14 @@ static int __maybe_unused cdns_wdt_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
>
> -	ret = clk_prepare_enable(wdt->clk);
> -	if (ret) {
> -		dev_err(dev, "unable to enable clock\n");
> -		return ret;
> +	if (watchdog_active(&wdt->cdns_wdt_device)) {
> +		ret = clk_prepare_enable(wdt->clk);
> +		if (ret) {
> +			dev_err(dev, "unable to enable clock\n");
> +			return ret;
> +		}
> +		cdns_wdt_start(&wdt->cdns_wdt_device);
>  	}
> -	cdns_wdt_start(&wdt->cdns_wdt_device);
>
>  	return 0;
>  }
>

