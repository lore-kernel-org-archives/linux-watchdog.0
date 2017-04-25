Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40437 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1951488AbdDYQTa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Apr 2017 12:19:30 -0400
Date: Tue, 25 Apr 2017 09:19:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: zx2967: remove redundant dev_err call in
 zx2967_wdt_probe()
Message-ID: <20170425161928.GB8443@roeck-us.net>
References: <20170425161733.14931-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425161733.14931-1-weiyj.lk@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 25, 2017 at 04:17:33PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/zx2967_wdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
> index e290d5a..c982527 100644
> --- a/drivers/watchdog/zx2967_wdt.c
> +++ b/drivers/watchdog/zx2967_wdt.c
> @@ -211,10 +211,8 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
>  
>  	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	wdt->reg_base = devm_ioremap_resource(dev, base);
> -	if (IS_ERR(wdt->reg_base)) {
> -		dev_err(dev, "ioremap failed\n");
> +	if (IS_ERR(wdt->reg_base))
>  		return PTR_ERR(wdt->reg_base);
> -	}
>  
>  	zx2967_wdt_reset_sysctrl(dev);
>  
> 
> 
> 
