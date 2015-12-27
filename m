Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43680 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751872AbbL0USA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 15:18:00 -0500
Date: Sun, 27 Dec 2015 21:17:53 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Geliang Tang <geliangtang@163.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] watchdog: cadence_wdt: use to_platform_device()
Message-ID: <20151227201753.GC25197@spo001.leaseweb.nl>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com> <bfab2ac46e1ff47b86258cc38ff1d698edc6017b.1451221174.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfab2ac46e1ff47b86258cc38ff1d698edc6017b.1451221174.git.geliangtang@163.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Geliang,

> Use to_platform_device() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/watchdog/cadence_wdt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index abf64eb..4dda902 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -421,8 +421,7 @@ static void cdns_wdt_shutdown(struct platform_device *pdev)
>   */
>  static int __maybe_unused cdns_wdt_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = container_of(dev,
> -			struct platform_device, dev);
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
>  
>  	cdns_wdt_stop(&wdt->cdns_wdt_device);
> @@ -440,8 +439,7 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
>  static int __maybe_unused cdns_wdt_resume(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = container_of(dev,
> -			struct platform_device, dev);
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
>  
>  	ret = clk_prepare_enable(wdt->clk);
> -- 
> 2.5.0
> 
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.

