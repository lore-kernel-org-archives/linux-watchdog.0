Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33487 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdL3QIc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 30 Dec 2017 11:08:32 -0500
Subject: Re: [PATCH v2 4/8] watchdog: JZ4740: Drop module remove function
To: Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-4-paul@crapouillou.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8454df76-df77-c57f-2f87-be03c4cda63b@roeck-us.net>
Date: Sat, 30 Dec 2017 08:08:30 -0800
MIME-Version: 1.0
In-Reply-To: <20171230135108.6834-4-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/30/2017 05:51 AM, Paul Cercueil wrote:
> When the watchdog was configured for nowayout, and after the
> userspace watchdog daemon closed the dev node without sending the
> magic character, unloading this module stopped the watchdog
> hardware, which was clearly a problem.
> 
> Besides, unloading the module is not possible when the userspace
> watchdog daemon is running, so it's safe to assume that we don't
> need to stop the watchdog hardware in the jz4740_wdt_remove()
> function.
> 
> For this reason, the jz4740_wdt_remove() function can then be
> dropped alltogether.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
>   v2: New patch in this series
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index fa7f49a3212c..02b9b8e946a2 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -205,16 +205,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int jz4740_wdt_remove(struct platform_device *pdev)
> -{
> -	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
> -
> -	return jz4740_wdt_stop(&drvdata->wdt);
> -}
> -
>   static struct platform_driver jz4740_wdt_driver = {
>   	.probe = jz4740_wdt_probe,
> -	.remove = jz4740_wdt_remove,
>   	.driver = {
>   		.name = "jz4740-wdt",
>   		.of_match_table = of_match_ptr(jz4740_wdt_of_matches),
> 

