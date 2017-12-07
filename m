Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36673 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdLGEge (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 6 Dec 2017 23:36:34 -0500
Subject: Re: [PATCH] watchdog: hpwdt: fix unused variable warning
To: Arnd Bergmann <arnd@arndb.de>, Jimmy Vance <jimmy.vance@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Jerry Hoemann <jerry.hoemann@hpe.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171206210250.1222757-1-arnd@arndb.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <864db18f-5039-c15f-6414-223bdb21e0be@roeck-us.net>
Date: Wed, 6 Dec 2017 20:36:31 -0800
MIME-Version: 1.0
In-Reply-To: <20171206210250.1222757-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/06/2017 01:02 PM, Arnd Bergmann wrote:
> The new hpwdt_my_nmi() function is used conditionally, which produces
> a harmless warning in some configurations:
> 
> drivers/watchdog/hpwdt.c:478:12: error: 'hpwdt_my_nmi' defined but not used [-Werror=unused-function]
> 
> This moves it inside of the #ifdef that protects its caller, to silence
> the warning.
> 
> Fixes: 621174a92851 ("watchdog: hpwdt: Check source of NMI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index e61658310381..f1f00dfc0e68 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -475,12 +475,12 @@ static int hpwdt_time_left(void)
>   	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
>   }
>   
> +#ifdef CONFIG_HPWDT_NMI_DECODING
>   static int hpwdt_my_nmi(void)
>   {
>   	return ioread8(hpwdt_nmistat) & 0x6;
>   }
>   
> -#ifdef CONFIG_HPWDT_NMI_DECODING
>   /*
>    *	NMI Handler
>    */
> 

