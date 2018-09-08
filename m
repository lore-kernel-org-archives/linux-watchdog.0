Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38841 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeIHU4j (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Sep 2018 16:56:39 -0400
Subject: Re: [PATCH v3 1/2] watchdog: rza_wdt: Support longer timeouts
To: Chris Brandt <chris.brandt@renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
References: <20180907012243.86603-1-chris.brandt@renesas.com>
 <20180907012243.86603-2-chris.brandt@renesas.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <314e2981-8fbd-43ed-2f2d-c080a2961055@roeck-us.net>
Date: Sat, 8 Sep 2018 09:10:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180907012243.86603-2-chris.brandt@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/06/2018 06:22 PM, Chris Brandt wrote:
> The RZ/A2 watchdog timer extends the clock source options in order to
> allow for longer timeouts.
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v3:
>   * Removed + 1 from DIV_ROUND_UP line
>   * resetting to 0 if time to big did not make as much sense are resetting
>     to 256
> v2:
> * use DIV_ROUND_UP
> * use %u for pr_debug
> * use of_match data to determine the size of CKS register
> ---
>   drivers/watchdog/rza_wdt.c | 81 +++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
> index e618218d2374..64a733492b96 100644
> --- a/drivers/watchdog/rza_wdt.c
> +++ b/drivers/watchdog/rza_wdt.c
> @@ -14,6 +14,7 @@
>   #include <linux/delay.h>
>   #include <linux/module.h>
>   #include <linux/of_address.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   
> @@ -34,12 +35,40 @@
>   #define WRCSR_RSTE		BIT(6)
>   #define WRCSR_CLEAR_WOVF	0xA500	/* special value */
>   
> +#define CKS_3BIT		0x7
> +#define CKS_4BIT		0xF
> +

Any special reason for the value of those defines ? They are just used as flags,
or am I missing something ? Why not just use 0 / 1 or an enum ?

>   struct rza_wdt {
>   	struct watchdog_device wdev;
>   	void __iomem *base;
>   	struct clk *clk;
> +	u8 count;
> +	u8 cks;
> +	u8 timeout;

Hmm ... this limits the effective timeout to 255 seconds. That seems odd.
Maybe it is true in practice, if the clock is always guaranteed to be
above 4194304 Hz, but it is an odd assumption that isn't really reflected
in the code.

>   };
>   
> +static void rza_wdt_calc_timeout(struct rza_wdt *priv, int timeout)
> +{
> +	unsigned long rate = clk_get_rate(priv->clk);
> +	unsigned int ticks;
> +
> +	if (priv->cks == CKS_4BIT) {
> +		ticks = DIV_ROUND_UP((timeout * rate), 4194304);

The ( ) around timeout * rate is unnecessary. Also, it would be nice
to have a define and explanation for 4194304 (and 0x400000 would probably
be a better value to use).

> +		if (ticks > 256)
> +			ticks = 256;

If you keep this, you should as well recalculate timeout since it won't
match the expected value.

		if (ticks > 256) {
			ticks = 256;
			timeout = ticks * 4194304 / rate;
		}

Not that it can ever happen, since max_timeout limits the value.
Personally I would rather see this dropped with a comment stating that
ticks <= 256 is guaranteed by max_timeout; I am not a friend of dead code
in the kernel.

> +
> +		priv->count = 256 - ticks;
> +	} else {
> +		/* Start timer with longest timeout */
> +		priv->count = 0;
> +	}
> +
> +	priv->timeout = timeout;
> +
> +	pr_debug("%s: timeout set to %u (WTCNT=%d)\n", __func__,
> +		 timeout, priv->count);
> +}
> +
>   static int rza_wdt_start(struct watchdog_device *wdev)
>   {
>   	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
> @@ -51,13 +80,12 @@ static int rza_wdt_start(struct watchdog_device *wdev)
>   	readb(priv->base + WRCSR);
>   	writew(WRCSR_CLEAR_WOVF, priv->base + WRCSR);
>   
> -	/*
> -	 * Start timer with slowest clock source and reset option enabled.
> -	 */
> +	rza_wdt_calc_timeout(priv, wdev->timeout);
> +
>   	writew(WRCSR_MAGIC | WRCSR_RSTE, priv->base + WRCSR);
> -	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
> -	writew(WTCSR_MAGIC | WTSCR_WT | WTSCR_TME | WTSCR_CKS(7),
> -	       priv->base + WTCSR);
> +	writew(WTCNT_MAGIC | priv->count, priv->base + WTCNT);
> +	writew(WTCSR_MAGIC | WTSCR_WT | WTSCR_TME |
> +	       WTSCR_CKS(priv->cks), priv->base + WTCSR);
>   
>   	return 0;
>   }
> @@ -75,7 +103,12 @@ static int rza_wdt_ping(struct watchdog_device *wdev)
>   {
>   	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
>   
> -	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
> +	if (priv->timeout != wdev->timeout)
> +		rza_wdt_calc_timeout(priv, wdev->timeout);
> +
FWIW, odd way of updating the timeout. Why not do it in the set_timeout()
function where it belongs. Which makes me wonder why priv->timeout is needed
in the first place (and why it is u8 - as mentioned above).

> +	writew(WTCNT_MAGIC | priv->count, priv->base + WTCNT);
> +
> +	pr_debug("%s: timeout = %u\n", __func__, wdev->timeout);
>   

Do you really want this displayed with each ping, even as debug message ?
Just wondering.

>   	return 0;
>   }
> @@ -150,20 +183,31 @@ static int rza_wdt_probe(struct platform_device *pdev)
>   		return -ENOENT;
>   	}
>   
> -	/* Assume slowest clock rate possible (CKS=7) */
> -	rate /= 16384;
> -
>   	priv->wdev.info = &rza_wdt_ident,
>   	priv->wdev.ops = &rza_wdt_ops,
>   	priv->wdev.parent = &pdev->dev;
>   
> -	/*
> -	 * Since the max possible timeout of our 8-bit count register is less
> -	 * than a second, we must use max_hw_heartbeat_ms.
> -	 */
> -	priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX) / rate;
> -	dev_dbg(&pdev->dev, "max hw timeout of %dms\n",
> -		 priv->wdev.max_hw_heartbeat_ms);
> +	priv->cks = (unsigned int)of_device_get_match_data(&pdev->dev);
> +	if (priv->cks == CKS_4BIT) {
> +		/* Assume slowest clock rate possible (CKS=0xF) */
> +		priv->wdev.max_timeout = (4194304 * U8_MAX) / rate;
> +
> +	} else if (priv->cks == CKS_3BIT) {
> +		/* Assume slowest clock rate possible (CKS=7) */
> +		rate /= 16384;
> +
> +		/*
> +		 * Since the max possible timeout of our 8-bit count
> +		 * register is less than a second, we must use
> +		 * max_hw_heartbeat_ms.
> +		 */
> +		priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX) / rate;
> +		dev_dbg(&pdev->dev, "max hw timeout of %dms\n",
> +			 priv->wdev.max_hw_heartbeat_ms);
> +	} else {
> +		dev_err(&pdev->dev, "invalid CKS value (%u)\n", priv->cks);
> +		return -EINVAL;
> +	}

I don't really see the point of this else statement. It is pretty much dead code,
and the message is quite useless for the user.

>   
>   	priv->wdev.min_timeout = 1;
>   	priv->wdev.timeout = DEFAULT_TIMEOUT;
> @@ -179,7 +223,8 @@ static int rza_wdt_probe(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id rza_wdt_of_match[] = {
> -	{ .compatible = "renesas,rza-wdt", },
> +	{ .compatible = "renesas,r7s9210-wdt",	.data = (void *)CKS_4BIT, },
> +	{ .compatible = "renesas,rza-wdt",	.data = (void *)CKS_3BIT, },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, rza_wdt_of_match);
> 
