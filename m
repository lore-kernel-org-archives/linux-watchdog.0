Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59639 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755878AbcKWQL1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 Nov 2016 11:11:27 -0500
Date: Wed, 23 Nov 2016 08:11:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v1 1/1] intel-mid_wdt: Error code is just an integer
Message-ID: <20161123161124.GA15572@roeck-us.net>
References: <20161118152441.135932-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161118152441.135932-1-andriy.shevchenko@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 18, 2016 at 05:24:41PM +0200, Andy Shevchenko wrote:
> Error code when printed is more readable if it's represented as plain decimal
> integer. Otherwise user will see something like
> 	intel_mid_wdt: Error stopping watchdog: 0xffffffed
> which is not quite understandable ("Should I interpret it as a bitfield?").
> 
> Make it clear to use plaint integer specifier.
> 
> While here, move struct device *dev local variable definition to the top of
> functions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/intel-mid_wdt.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index ff099a3..a4b7292 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -43,6 +43,7 @@ static inline int wdt_command(int sub, u32 *in, int inlen)
>  
>  static int wdt_start(struct watchdog_device *wd)
>  {
> +	struct device *dev = watchdog_get_drvdata(wd);
>  	int ret, in_size;
>  	int timeout = wd->timeout;
>  	struct ipc_wd_start {
> @@ -57,36 +58,32 @@ static int wdt_start(struct watchdog_device *wd)
>  	in_size = DIV_ROUND_UP(sizeof(ipc_wd_start), 4);
>  
>  	ret = wdt_command(SCU_WATCHDOG_START, (u32 *)&ipc_wd_start, in_size);
> -	if (ret) {
> -		struct device *dev = watchdog_get_drvdata(wd);
> +	if (ret)
>  		dev_crit(dev, "error starting watchdog: %d\n", ret);
> -	}
>  
>  	return ret;
>  }
>  
>  static int wdt_ping(struct watchdog_device *wd)
>  {
> +	struct device *dev = watchdog_get_drvdata(wd);
>  	int ret;
>  
>  	ret = wdt_command(SCU_WATCHDOG_KEEPALIVE, NULL, 0);
> -	if (ret) {
> -		struct device *dev = watchdog_get_drvdata(wd);
> -		dev_crit(dev, "Error executing keepalive: 0x%x\n", ret);
> -	}
> +	if (ret)
> +		dev_crit(dev, "Error executing keepalive: %d\n", ret);
>  
>  	return ret;
>  }
>  
>  static int wdt_stop(struct watchdog_device *wd)
>  {
> +	struct device *dev = watchdog_get_drvdata(wd);
>  	int ret;
>  
>  	ret = wdt_command(SCU_WATCHDOG_STOP, NULL, 0);
> -	if (ret) {
> -		struct device *dev = watchdog_get_drvdata(wd);
> -		dev_crit(dev, "Error stopping watchdog: 0x%x\n", ret);
> -	}
> +	if (ret)
> +		dev_crit(dev, "Error stopping watchdog: %d\n", ret);
>  
>  	return ret;
>  }
> -- 
> 2.10.2
> 
