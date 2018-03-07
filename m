Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40130 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCGIAS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Mar 2018 03:00:18 -0500
Received: by mail-pg0-f65.google.com with SMTP id g8so605849pgv.7
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2018 00:00:18 -0800 (PST)
Subject: Re: [PATCH] watchdog: f71808e_wdt: Fix WD_EN register read
To: Igor Pylypiv <igor.pylypiv@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org
References: <1520408845-16987-1-git-send-email-igor.pylypiv@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d1a2c985-6256-f59b-477f-97aa240318d7@roeck-us.net>
Date: Wed, 7 Mar 2018 00:00:15 -0800
MIME-Version: 1.0
In-Reply-To: <1520408845-16987-1-git-send-email-igor.pylypiv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/06/2018 11:47 PM, Igor Pylypiv wrote:
> F71808FG_FLAG_WD_EN defines bit position, not a bitmask
> 
> Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>

Good catch. Wim - candidate for v4.16-rc and stable.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/f71808e_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 3a33c53..9a1c761 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -496,7 +496,7 @@ static bool watchdog_is_running(void)
>   
>   	is_running = (superio_inb(watchdog.sioaddr, SIO_REG_ENABLE) & BIT(0))
>   		&& (superio_inb(watchdog.sioaddr, F71808FG_REG_WDT_CONF)
> -			& F71808FG_FLAG_WD_EN);
> +			& BIT(F71808FG_FLAG_WD_EN));
>   
>   	superio_exit(watchdog.sioaddr);
>   
> 

