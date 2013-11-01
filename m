Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 1 Nov 2013 14:10:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, patches@linaro.org,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 4/5] watchdog: ralink: Use devm_ioremap_resource
Message-ID: <20131101211047.GB18305@roeck-us.net>
References: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
 <1383217687-12037-5-git-send-email-tushar.behera@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1383217687-12037-5-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Oct 31, 2013 at 04:38:06PM +0530, Tushar Behera wrote:
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> CC: linux-watchdog@vger.kernel.org
> CC: Wim Van Sebroeck <wim@iguana.be>
> ---
>  drivers/watchdog/rt2880_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index a9f8491..53d37fe 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -144,7 +144,7 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	rt288x_wdt_base = devm_request_and_ioremap(&pdev->dev, res);
> +	rt288x_wdt_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rt288x_wdt_base))
>  		return PTR_ERR(rt288x_wdt_base);
>  
Wim already applied a similar patch from Wei Yongjun to his -next tree

Guenter
