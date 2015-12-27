Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57039 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687AbbL0P1H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 10:27:07 -0500
Date: Sun, 27 Dec 2015 07:27:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Geliang Tang <geliangtang@163.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] watchdog: cadence_wdt: use to_platform_device()
Message-ID: <20151227152703.GA8944@roeck-us.net>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
 <bfab2ac46e1ff47b86258cc38ff1d698edc6017b.1451221174.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfab2ac46e1ff47b86258cc38ff1d698edc6017b.1451221174.git.geliangtang@163.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Dec 27, 2015 at 09:15:47PM +0800, Geliang Tang wrote:
> Use to_platform_device() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
