Return-path: <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH -next] watchdog: wdat_wdt: fix return value check in
 wdat_wdt_probe()
To: Wei Yongjun <weiyj.lk@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1475074286-13834-1-git-send-email-weiyj.lk@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-watchdog@vger.kernel.org
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <9a6eeb96-86db-b8b1-828c-694a50c6d389@intel.com>
Date: Wed, 28 Sep 2016 18:27:05 +0200
MIME-Version: 1.0
In-Reply-To: <1475074286-13834-1-git-send-email-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 9/28/2016 4:51 PM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Can you please CC your fixes to a mailing list, 
linux-kernel@vger.kernel.org at least if you can't find a more specific one?

They are much easier to handle then, to me at least.

> ---
>   drivers/watchdog/wdat_wdt.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 6b64645..4594723 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -351,16 +351,17 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>   		res = &pdev->resource[i];
>   		if (resource_type(res) == IORESOURCE_MEM) {
>   			reg = devm_ioremap_resource(&pdev->dev, res);
> +			if (IS_ERR(reg))
> +				return PTR_ERR(reg);
>   		} else if (resource_type(res) == IORESOURCE_IO) {
>   			reg = devm_ioport_map(&pdev->dev, res->start, 1);
> +			if (!reg)
> +				return -ENOMEM;
>   		} else {
>   			dev_err(&pdev->dev, "Unsupported resource\n");
>   			return -EINVAL;
>   		}
>   
> -		if (!reg)
> -			return -ENOMEM;
> -
>   		regs[i] = reg;
>   	}


Thanks,

Rafael
