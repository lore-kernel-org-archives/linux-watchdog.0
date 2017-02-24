Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47514 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBXV6H (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 16:58:07 -0500
Subject: Re: [PATCH 1/7] watchdog: s3c2410: Use dev_dbg instead of pr_info
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170224210746.12459-1-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <de7b019e-3e0e-97ec-1620-27254336f637@roeck-us.net>
Date: Fri, 24 Feb 2017 13:56:52 -0800
MIME-Version: 1.0
In-Reply-To: <20170224210746.12459-1-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/24/2017 01:07 PM, Krzysztof Kozlowski wrote:
> Replace the 'debug' module parameter and pr_info() with proper device
> dynamic debug calls because this is the preferred and flexible way of
> enabling debugging printks.
>
> Also remove some obvious debug printks.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/s3c2410_wdt.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 7db7847a005c..f7aad19d20ff 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -23,8 +23,6 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>  */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/types.h>
> @@ -83,13 +81,11 @@ static bool nowayout	= WATCHDOG_NOWAYOUT;
>  static int tmr_margin;
>  static int tmr_atboot	= S3C2410_WATCHDOG_ATBOOT;
>  static int soft_noboot;
> -static int debug;
>
>  module_param(tmr_margin,  int, 0);
>  module_param(tmr_atboot,  int, 0);
>  module_param(nowayout,   bool, 0);
>  module_param(soft_noboot, int, 0);
> -module_param(debug,	  int, 0);
>
>  MODULE_PARM_DESC(tmr_margin, "Watchdog tmr_margin in seconds. (default="
>  		__MODULE_STRING(S3C2410_WATCHDOG_DEFAULT_TIME) ")");
> @@ -100,7 +96,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
>  			"0 to reboot (default 0)");
> -MODULE_PARM_DESC(debug, "Watchdog debug, set to >1 for debug (default 0)");
>
>  /**
>   * struct s3c2410_wdt_variant - Per-variant config data
> @@ -204,14 +199,6 @@ static const struct platform_device_id s3c2410_wdt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, s3c2410_wdt_ids);
>
> -/* watchdog control routines */
> -
> -#define DBG(fmt, ...)					\
> -do {							\
> -	if (debug)					\
> -		pr_info(fmt, ##__VA_ARGS__);		\
> -} while (0)
> -
>  /* functions */
>
>  static inline unsigned int s3c2410wdt_max_timeout(struct clk *clock)
> @@ -307,8 +294,8 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
>  		wtcon |= S3C2410_WTCON_RSTEN;
>  	}
>
> -	DBG("%s: count=0x%08x, wtcon=%08lx\n",
> -	    __func__, wdt->count, wtcon);
> +	dev_dbg(wdt->dev, "Starting watchdog: count=0x%08x, wtcon=%08lx\n",
> +		wdt->count, wtcon);
>
>  	writel(wdt->count, wdt->reg_base + S3C2410_WTDAT);
>  	writel(wdt->count, wdt->reg_base + S3C2410_WTCNT);
> @@ -337,8 +324,8 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd, unsigned timeou
>  	freq = DIV_ROUND_UP(freq, 128);
>  	count = timeout * freq;
>
> -	DBG("%s: count=%d, timeout=%d, freq=%lu\n",
> -	    __func__, count, timeout, freq);
> +	dev_dbg(wdt->dev, "Heartbeat: count=%d, timeout=%d, freq=%lu\n",
> +		count, timeout, freq);
>
>  	/* if the count is bigger than the watchdog register,
>  	   then work out what we need to do (and if) we can
> @@ -354,8 +341,8 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd, unsigned timeou
>  		}
>  	}
>
> -	DBG("%s: timeout=%d, divisor=%d, count=%d (%08x)\n",
> -	    __func__, timeout, divisor, count, DIV_ROUND_UP(count, divisor));
> +	dev_dbg(wdt->dev, "Heartbeat: timeout=%d, divisor=%d, count=%d (%08x)\n",
> +		timeout, divisor, count, DIV_ROUND_UP(count, divisor));
>
>  	count = DIV_ROUND_UP(count, divisor);
>  	wdt->count = count;
> @@ -544,8 +531,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  	int started = 0;
>  	int ret;
>
> -	DBG("%s: probe=%p\n", __func__, pdev);
> -
>  	dev = &pdev->dev;
>
>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> @@ -581,8 +566,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>
> -	DBG("probe: mapped reg_base=%p\n", wdt->reg_base);
> -
>  	wdt->clock = devm_clk_get(dev, "watchdog");
>  	if (IS_ERR(wdt->clock)) {
>  		dev_err(dev, "failed to find watchdog clock source\n");
>

