Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43776 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751181AbcGQULP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:11:15 -0400
Date: Sun, 17 Jul 2016 22:11:08 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: weiyj_lk@163.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pic32-dmt: Fix return value check in pic32_dmt_probe()
Message-ID: <20160717201108.GK32751@spo001.leaseweb.nl>
References: <1466183525-24685-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466183525-24685-1-git-send-email-weiyj_lk@163.com>
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
>  drivers/watchdog/pic32-dmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
> index 962f58c..5e8890e 100644
> --- a/drivers/watchdog/pic32-dmt.c
> +++ b/drivers/watchdog/pic32-dmt.c
> @@ -176,8 +176,8 @@ static int pic32_dmt_probe(struct platform_device *pdev)
>  	struct watchdog_device *wdd = &pic32_dmt_wdd;
>  
>  	dmt = devm_kzalloc(&pdev->dev, sizeof(*dmt), GFP_KERNEL);
> -	if (IS_ERR(dmt))
> -		return PTR_ERR(dmt);
> +	if (!dmt)
> +		return -ENOMEM;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dmt->regs = devm_ioremap_resource(&pdev->dev, mem);
> 
> 
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

