Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58540 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcFQVad (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2016 17:30:33 -0400
Date: Fri, 17 Jun 2016 14:30:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: weiyj_lk@163.com
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pic32-dmt: Fix return value check in
 pic32_dmt_probe()
Message-ID: <20160617213013.GC19848@roeck-us.net>
References: <1466183525-24685-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466183525-24685-1-git-send-email-weiyj_lk@163.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jun 17, 2016 at 05:12:05PM +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_kzalloc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
