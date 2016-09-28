Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46337 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932691AbcI1PwS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Sep 2016 11:52:18 -0400
Date: Wed, 28 Sep 2016 08:52:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH -next] watchdog: wdat_wdt: fix return value check in
 wdat_wdt_probe()
Message-ID: <20160928155216.GC29624@roeck-us.net>
References: <1475074286-13834-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475074286-13834-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 28, 2016 at 02:51:26PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wdat_wdt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 6b64645..4594723 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -351,16 +351,17 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  		res = &pdev->resource[i];
>  		if (resource_type(res) == IORESOURCE_MEM) {
>  			reg = devm_ioremap_resource(&pdev->dev, res);
> +			if (IS_ERR(reg))
> +				return PTR_ERR(reg);
>  		} else if (resource_type(res) == IORESOURCE_IO) {
>  			reg = devm_ioport_map(&pdev->dev, res->start, 1);
> +			if (!reg)
> +				return -ENOMEM;
>  		} else {
>  			dev_err(&pdev->dev, "Unsupported resource\n");
>  			return -EINVAL;
>  		}
>  
> -		if (!reg)
> -			return -ENOMEM;
> -
>  		regs[i] = reg;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
