Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40067 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeINWji (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Sep 2018 18:39:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so4604649pfi.7
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Sep 2018 10:24:12 -0700 (PDT)
Date: Fri, 14 Sep 2018 10:24:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        john@phrozen.org, dev@kresin.me
Subject: Re: [PATCH v3 1/3] wdt: lantiq: update register names to better
 match spec
Message-ID: <20180914172410.GB26861@roeck-us.net>
References: <20180913213211.16781-1-hauke@hauke-m.de>
 <20180913213211.16781-2-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913213211.16781-2-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Sep 13, 2018 at 11:32:09PM +0200, Hauke Mehrtens wrote:
> Some of the names of the bits were confusing to me.
> Now the bits share the same prefix as the register they are set on.
> 
> The LTQ_WDT_CR_PWL register (bits 26:25) is the pre warning limit and it
> does not turn anything on. It has 4 possible divers 1/2, 1/4, 1/8 and
> 1/16, this drivers only uses 1/16.
> The LTQ_WDT_CR_CLKDIV register bits(25:24) is only configuring a clock
> divers and do not turn any thing on too, all possible values are valid
> dividers.
> Using the LTQ_WDT_SR prefix is also wrong these bits are used in the
> LTQ_WDT_CR registers, SR is the status register which is read only.
> 
> This uses GENMASK where it is a mask and it uses shifts when a value is
> written to some bits.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/lantiq_wdt.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index 7f43cefa0eae..a086005fbaac 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/fs.h>
>  #include <linux/miscdevice.h>
> +#include <linux/bitops.h>
>  #include <linux/watchdog.h>
>  #include <linux/of_platform.h>
>  #include <linux/uaccess.h>
> @@ -40,18 +41,19 @@
>   * essentially the following two magic passwords need to be written to allow
>   * IO access to the WDT core
>   */
> -#define LTQ_WDT_PW1		0x00BE0000
> -#define LTQ_WDT_PW2		0x00DC0000
> +#define LTQ_WDT_CR_PW1		0x00BE0000
> +#define LTQ_WDT_CR_PW2		0x00DC0000
> +
> +#define LTQ_WDT_CR		0x0		/* watchdog control register */
> +#define  LTQ_WDT_CR_GEN		BIT(31)		/* enable bit */
> +/* Pre-warning limit set to 1/16 of max WDT period */
> +#define  LTQ_WDT_CR_PWL		(0x3 << 26)
> +/* set clock divider to 0x40000 */
> +#define  LTQ_WDT_CR_CLKDIV	(0x3 << 24)
> +#define  LTQ_WDT_CR_PW_MASK	GENMASK(23, 16)	/* Password field */
> +#define  LTQ_WDT_CR_MAX_TIMEOUT	((1 << 16) - 1)	/* The reload field is 16 bit */
>  
> -#define LTQ_WDT_CR		0x0	/* watchdog control register */
> -#define LTQ_WDT_SR		0x8	/* watchdog status register */
> -
> -#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
> -#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
> -#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
> -						/* divider to 0x40000 */
>  #define LTQ_WDT_DIVIDER		0x40000
> -#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
> @@ -68,26 +70,26 @@ ltq_wdt_enable(void)
>  {
>  	unsigned long int timeout = ltq_wdt_timeout *
>  			(ltq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
> -	if (timeout > LTQ_MAX_TIMEOUT)
> -		timeout = LTQ_MAX_TIMEOUT;
> +	if (timeout > LTQ_WDT_CR_MAX_TIMEOUT)
> +		timeout = LTQ_WDT_CR_MAX_TIMEOUT;
>  
>  	/* write the first password magic */
> -	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
>  	/* write the second magic plus the configuration and new timeout */
> -	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
> -		LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV |
> +		LTQ_WDT_CR_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
>  }
>  
>  static void
>  ltq_wdt_disable(void)
>  {
>  	/* write the first password magic */
> -	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
>  	/*
>  	 * write the second password magic with no config
>  	 * this turns the watchdog off
>  	 */
> -	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_PW2, ltq_wdt_membase + LTQ_WDT_CR);
>  }
>  
>  static ssize_t
> -- 
> 2.11.0
> 
