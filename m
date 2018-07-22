Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43947 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeGVOf2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Jul 2018 10:35:28 -0400
Received: by mail-pl0-f66.google.com with SMTP id o7-v6so7091456plk.10
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Jul 2018 06:38:45 -0700 (PDT)
Subject: Re: [PATCH 1/3] wdt: lantiq: update register names to better match
 spec
To: Hauke Mehrtens <hauke@hauke-m.de>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, john@phrozen.org, dev@kresin.me
References: <20180721232635.10523-1-hauke@hauke-m.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bb41b202-2234-a521-d270-d8e46b90c617@roeck-us.net>
Date: Sun, 22 Jul 2018 06:38:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180721232635.10523-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/21/2018 04:26 PM, Hauke Mehrtens wrote:
> Some of the names of the bits were confusing to me.
> Now the bits share the same prefix as the register they are set on.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   drivers/watchdog/lantiq_wdt.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index 7f43cefa0eae..8732a7bcc7ba 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -40,16 +40,18 @@
>    * essentially the following two magic passwords need to be written to allow
>    * IO access to the WDT core
>    */
> -#define LTQ_WDT_PW1		0x00BE0000
> -#define LTQ_WDT_PW2		0x00DC0000
> -
> -#define LTQ_WDT_CR		0x0	/* watchdog control register */
> +#define LTQ_WDT_CR_PW1		0x00BE0000
> +#define LTQ_WDT_CR_PW2		0x00DC0000
> +
> +#define LTQ_WDT_CR		0x0		/* watchdog control register */
> +#define  LTQ_WDT_CR_GEN		BIT(31)		/* enable bit */

Requires #include <linux/bitops.h>

> +#define  LTQ_WDT_CR_PWL		(0x3 << 26)	/* Pre-warning limit set to 1/16 of max WDT period */
> +#define  LTQ_WDT_CR_CLKDIV	(0x3 << 24)	/* set clock divider to 0x40000 */
> +#define  LTQ_WDT_CR_PW_MASK	GENMASK(23, 16)	/* Password field */
> +#define  LTQ_WDT_CR_RELOAD_MASK	GENMASK(15, 0)	/* Reload value */
>   #define LTQ_WDT_SR		0x8	/* watchdog status register */
> +#define  LTQ_WDT_SR_VALUE_MASK	GENMASK(15, 0)	/* Timer value */
>   
... but now you add a whole lot of unused defines, which is just as confusing.
Please don't; if those defines are used in a later patch, define them as they
are used.

> -#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
> -#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
> -#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
> -						/* divider to 0x40000 */
>   #define LTQ_WDT_DIVIDER		0x40000
>   #define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */

Please convert this one as well. It is either a constant 0xffff, or matches
LTQ_WDT_CR_RELOAD_MASK.

>   
> @@ -72,22 +74,22 @@ ltq_wdt_enable(void)
>   		timeout = LTQ_MAX_TIMEOUT;
>   
>   	/* write the first password magic */
> -	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
>   	/* write the second magic plus the configuration and new timeout */
> -	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
> -		LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV |
> +		LTQ_WDT_CR_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
>   }
>   
>   static void
>   ltq_wdt_disable(void)
>   {
>   	/* write the first password magic */
> -	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
>   	/*
>   	 * write the second password magic with no config
>   	 * this turns the watchdog off
>   	 */
> -	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_PW2, ltq_wdt_membase + LTQ_WDT_CR);
>   }
>   
>   static ssize_t
> 

