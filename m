Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49109 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdCAONG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 09:13:06 -0500
Subject: Re: [PATCH 1/3] watchdog: kempld: fix gcc-4.3 build
To: Arnd Bergmann <arnd@arndb.de>
References: <20170301091531.522161-1-arnd@arndb.de>
 <20170301091531.522161-2-arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <dcc202db-a9d1-4a9a-f272-4edfbfb99af3@roeck-us.net>
Date: Wed, 1 Mar 2017 06:13:03 -0800
MIME-Version: 1.0
In-Reply-To: <20170301091531.522161-2-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/01/2017 01:15 AM, Arnd Bergmann wrote:
> gcc-4.3 can't decide whether the constant value in
> kempld_prescaler[PRESCALER_21] is built-time constant or
> not, and gets confused by the logic in do_div():
>
> drivers/watchdog/kempld_wdt.o: In function `kempld_wdt_set_stage_timeout':
> kempld_wdt.c:(.text.kempld_wdt_set_stage_timeout+0x130): undefined reference to `__aeabi_uldivmod'
>
> This adds a call to ACCESS_ONCE() to force it to not consider
> it to be constant, and leaves the more efficient normal case
> in place for modern compilers, using an #ifdef to annotate
> why we do this hack.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/kempld_wdt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
> index 73c46b3a09ab..2f3b049ea301 100644
> --- a/drivers/watchdog/kempld_wdt.c
> +++ b/drivers/watchdog/kempld_wdt.c
> @@ -140,12 +140,19 @@ static int kempld_wdt_set_stage_timeout(struct kempld_wdt_data *wdt_data,
>  					unsigned int timeout)
>  {
>  	struct kempld_device_data *pld = wdt_data->pld;
> -	u32 prescaler = kempld_prescaler[PRESCALER_21];
> +	u32 prescaler;
>  	u64 stage_timeout64;
>  	u32 stage_timeout;
>  	u32 remainder;
>  	u8 stage_cfg;
>
> +#if GCC_VERSION < 40400
> +	/* work around a bug compiling do_div() */
> +	prescaler = READ_ONCE(kempld_prescaler[PRESCALER_21]);
> +#else
> +	prescaler = kempld_prescaler[PRESCALER_21];
> +#endif
> +
>  	if (!stage)
>  		return -EINVAL;
>
>

