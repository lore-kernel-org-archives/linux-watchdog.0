Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46046 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbdL1SiQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 13:38:16 -0500
Subject: Re: [PATCH 1/7] watchdog: JZ4740: Disable clock after stopping
 counter
To: Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-1-paul@crapouillou.net>
 <20171228162939.3928-2-paul@crapouillou.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1d54ed58-8e30-6fdc-60b8-541d3775280b@roeck-us.net>
Date: Thu, 28 Dec 2017 10:38:14 -0800
MIME-Version: 1.0
In-Reply-To: <20171228162939.3928-2-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/28/2017 08:29 AM, Paul Cercueil wrote:
> Previously, the clock was disabled first, which makes the watchdog
> component insensitive to register writes.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 20627f22baf6..6955deb100ef 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -124,8 +124,8 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>   {
>   	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>   
> -	jz4740_timer_disable_watchdog();
>   	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	jz4740_timer_disable_watchdog();
>   
>   	return 0;
>   }
> 

