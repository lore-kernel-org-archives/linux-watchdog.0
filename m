Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43772 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751181AbcGQUKl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:10:41 -0400
Date: Sun, 17 Jul 2016 22:10:32 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: weiyj_lk@163.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pic32-wdt: Fix return value check in pic32_wdt_drv_probe()
Message-ID: <20160717201032.GJ32751@spo001.leaseweb.nl>
References: <1466183495-23885-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466183495-23885-1-git-send-email-weiyj_lk@163.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wei,

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_kzalloc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
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

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

