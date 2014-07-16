Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61316 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933169AbaGPN0V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 16 Jul 2014 09:26:21 -0400
Message-ID: <53C67D7A.4040705@roeck-us.net>
Date: Wed, 16 Jul 2014 06:26:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: George Cherian <george.cherian@ti.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
CC: wim@iguana.be
Subject: Re: [RESEND PATCH 1/3] watchdog: dw_wdt: Remove the un-necessary
 check after platform_get_resource()
References: <1405516744-29333-1-git-send-email-george.cherian@ti.com>
In-Reply-To: <1405516744-29333-1-git-send-email-george.cherian@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/16/2014 06:19 AM, George Cherian wrote:
> devm_ioremap_resource() checks for valid resource.
> Remove the un-necessary check after platform_get_resource().
>
> Signed-off-by: George Cherian <george.cherian@ti.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

All three patches have my Reviewed-by: tag and are in my watchdog-next branch.
Of course that does not guarantee that Wim will pick them up, but it is quite
likely.

Guenter

> ---
>   drivers/watchdog/dw_wdt.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index ee4f86b..9f21029 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -296,9 +296,6 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>   	int ret;
>   	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> -	if (!mem)
> -		return -EINVAL;
> -
>   	dw_wdt.regs = devm_ioremap_resource(&pdev->dev, mem);
>   	if (IS_ERR(dw_wdt.regs))
>   		return PTR_ERR(dw_wdt.regs);
>

