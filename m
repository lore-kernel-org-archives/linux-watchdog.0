Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54582 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbcGSOep (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 10:34:45 -0400
Subject: Re: [PATCH -next] watchdog: pic32-wdt: Fix return value check in
 pic32_wdt_drv_probe()
To: Wei Yongjun <weiyj_lk@163.com>, Wim Van Sebroeck <wim@iguana.be>
References: <1468927316-32052-1-git-send-email-weiyj_lk@163.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578E3A74.5020508@roeck-us.net>
Date: Tue, 19 Jul 2016 07:34:28 -0700
MIME-Version: 1.0
In-Reply-To: <1468927316-32052-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/19/2016 04:21 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function devm_ioremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/pic32-wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
> index 2b7a2b2..9456d05 100644
> --- a/drivers/watchdog/pic32-wdt.c
> +++ b/drivers/watchdog/pic32-wdt.c
> @@ -183,8 +183,8 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
>   		return PTR_ERR(wdt->regs);
>
>   	wdt->rst_base = devm_ioremap(&pdev->dev, PIC32_BASE_RESET, 0x10);
> -	if (IS_ERR(wdt->rst_base))
> -		return PTR_ERR(wdt->rst_base);
> +	if (!wdt->rst_base)
> +		return -ENOMEM;
>
>   	wdt->clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(wdt->clk)) {
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

