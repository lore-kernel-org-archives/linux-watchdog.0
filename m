Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58092 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbcFQV34 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2016 17:29:56 -0400
Date: Fri, 17 Jun 2016 14:29:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: weiyj_lk@163.com
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pic32-wdt: Fix return value check in
 pic32_wdt_drv_probe()
Message-ID: <20160617212942.GB19848@roeck-us.net>
References: <1466183495-23885-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466183495-23885-1-git-send-email-weiyj_lk@163.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jun 17, 2016 at 05:11:35PM +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_kzalloc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Good catch.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/pic32-wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
> index 6047aa8..2b7a2b2 100644
> --- a/drivers/watchdog/pic32-wdt.c
> +++ b/drivers/watchdog/pic32-wdt.c
> @@ -174,8 +174,8 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
>  	struct resource *mem;
>  
>  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> -	if (IS_ERR(wdt))
> -		return PTR_ERR(wdt);
> +	if (!wdt)
> +		return -ENOMEM;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	wdt->regs = devm_ioremap_resource(&pdev->dev, mem);
> 
> 
> 
