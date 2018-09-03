Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42158 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeIDDbi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Sep 2018 23:31:38 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so3290251oib.9
        for <linux-watchdog@vger.kernel.org>; Mon, 03 Sep 2018 16:09:18 -0700 (PDT)
Date: Mon, 3 Sep 2018 16:09:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        john@phrozen.org, dev@kresin.me
Subject: Re: [v2,1/3] wdt: lantiq: update register names to better match spec
Message-ID: <20180903230915.GA30065@roeck-us.net>
References: <20180902113233.29113-2-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902113233.29113-2-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Sep 02, 2018 at 01:32:31PM +0200, Hauke Mehrtens wrote:
> Some of the names of the bits were confusing to me.
> Now the bits share the same prefix as the register they are set on.
> 

Plus you changed the description. Overall I find the new defines
more confusing than the old ones, especially the changed meaning.
Can you point me to a reference manual ?

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/watchdog/lantiq_wdt.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index 7f43cefa0eae..e5937be09bd4 100644
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
> @@ -40,18 +41,17 @@
>   * essentially the following two magic passwords need to be written to allow
>   * IO access to the WDT core
>   */
> -#define LTQ_WDT_PW1		0x00BE0000
> -#define LTQ_WDT_PW2		0x00DC0000
> +#define LTQ_WDT_CR_PW1		0x00BE0000
> +#define LTQ_WDT_CR_PW2		0x00DC0000
>  
> -#define LTQ_WDT_CR		0x0	/* watchdog control register */
> -#define LTQ_WDT_SR		0x8	/* watchdog status register */
> +#define LTQ_WDT_CR		0x0		/* watchdog control register */
> +#define  LTQ_WDT_CR_GEN		BIT(31)		/* enable bit */
> +#define  LTQ_WDT_CR_PWL		(0x3 << 26)	/* Pre-warning limit set to 1/16 of max WDT period */

Old was "turn on power"

> +#define  LTQ_WDT_CR_CLKDIV	(0x3 << 24)	/* set clock divider to 0x40000 */

Old was: "turn on clock and set divider to 0x40000". Note that the comment
itself does not really add much value, except that it suggests that one
of the bits may _not_ really set a clock mask.

So this doesn't just rename the defines, it also changes the meaning.

Also, while some may feel differently, I do think we should stick with the
80-column limit as long as it exists and generates checkpatch warnings.

> +#define  LTQ_WDT_CR_PW_MASK	GENMASK(23, 16)	/* Password field */
> +#define  LTQ_WDT_CR_RELOAD_MASK	GENMASK(15, 0)	/* Reload value */
>  

The mixed use of GENMASK() for some defines and shift for others is
confusing. 

> -#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
> -#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
> -#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
> -						/* divider to 0x40000 */
>  #define LTQ_WDT_DIVIDER		0x40000
> -#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */
>  
I question if the change from LTQ_MAX_TIMEOUT to LTQ_WDT_CR_RELOAD_MASK
really adds value. Sure, the maximum value must fit into a mask, but it
is still a maximum value.

>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
> @@ -68,26 +68,26 @@ ltq_wdt_enable(void)
>  {
>  	unsigned long int timeout = ltq_wdt_timeout *
>  			(ltq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
> -	if (timeout > LTQ_MAX_TIMEOUT)
> -		timeout = LTQ_MAX_TIMEOUT;
> +	if (timeout > LTQ_WDT_CR_RELOAD_MASK)
> +		timeout = LTQ_WDT_CR_RELOAD_MASK;

And this is less confusing than before ? Not to me. I find the new code
more confusing.

>  
>  	/* write the first password magic */
> -	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
>  	/* write the second magic plus the configuration and new timeout */
> -	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV | -
> LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR); +
> ltq_w32(LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV | +
> LTQ_WDT_CR_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR); }
>  
>  static void ltq_wdt_disable(void) { /* write the first password magic */ -
>  ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR); +
>  ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR); /* * write the second
>  password magic with no config * this turns the watchdog off */ -
>  ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR); +
>  ltq_w32(LTQ_WDT_CR_PW2, ltq_wdt_membase + LTQ_WDT_CR); }
>  
>  static ssize_t
