Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48263 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdAaO4c (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 31 Jan 2017 09:56:32 -0500
Subject: Re: [PATCH v2 1/2] watchdog: ep93xx_wdt: cleanup and let the core
 handle the heartbeat
To: H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-watchdog@vger.kernel.org
References: <20170130210109.71699-1-hsweeten@visionengravers.com>
 <20170130210109.71699-2-hsweeten@visionengravers.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <da61b501-331f-e335-d1ea-db1e8f35b5e8@roeck-us.net>
Date: Tue, 31 Jan 2017 04:16:05 -0800
MIME-Version: 1.0
In-Reply-To: <20170130210109.71699-2-hsweeten@visionengravers.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/30/2017 01:01 PM, H Hartley Sweeten wrote:
> Cleanup this driver and remove the 200ms heartbeat timer. The core now
> has the ability to handle the heartbeat.
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/ep93xx_wdt.c | 111 ++++++++++++++++--------------------------
>  1 file changed, 43 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
> index 0a4d7cc..04be2de 100644
> --- a/drivers/watchdog/ep93xx_wdt.c
> +++ b/drivers/watchdog/ep93xx_wdt.c
> @@ -19,21 +19,13 @@
>   * for us to rely on the user space daemon alone. So we ping the
>   * wdt each ~200msec and eventually stop doing it if the user space
>   * daemon dies.
> - *
> - * TODO:
> - *
> - *	- Test last reset from watchdog status
> - *	- Add a few missing ioctls
>   */
>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/watchdog.h>
> -#include <linux/timer.h>
>  #include <linux/io.h>
>
> -#define WDT_VERSION	"0.4"
> -
>  /* default timeout (secs) */
>  #define WDT_TIMEOUT 30
>
> @@ -43,57 +35,47 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
>
>  static unsigned int timeout = WDT_TIMEOUT;

Better would be to initialize this with 0 and initialize wdd->timeout with WDT_TIMEOUT.
This way the core actually looks for a devicetree parameter, has a chance to validate
the provided timeout, and to retain the default if it is bad.

>  module_param(timeout, uint, 0);
> -MODULE_PARM_DESC(timeout,
> -	"Watchdog timeout in seconds. (1<=timeout<=3600, default="
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (default="w
>  				__MODULE_STRING(WDT_TIMEOUT) ")");
>
> -static void __iomem *mmio_base;
> -static struct timer_list timer;
> -static unsigned long next_heartbeat;
> -
>  #define EP93XX_WATCHDOG		0x00
>  #define EP93XX_WDSTATUS		0x04
>
> -/* reset the wdt every ~200ms - the heartbeat of the device is 0.250 seconds*/
> -#define WDT_INTERVAL (HZ/5)
> -
> -static void ep93xx_wdt_timer_ping(unsigned long data)
> -{
> -	if (time_before(jiffies, next_heartbeat))
> -		writel(0x5555, mmio_base + EP93XX_WATCHDOG);
> -
> -	/* Re-set the timer interval */
> -	mod_timer(&timer, jiffies + WDT_INTERVAL);
> -}
> +struct ep93xx_wdt_priv {
> +	void __iomem *mmio;
> +	struct watchdog_device wdd;
> +};
>
>  static int ep93xx_wdt_start(struct watchdog_device *wdd)
>  {
> -	next_heartbeat = jiffies + (timeout * HZ);
> +	struct ep93xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
>
> -	writel(0xaaaa, mmio_base + EP93XX_WATCHDOG);
> -	mod_timer(&timer, jiffies + WDT_INTERVAL);
> +	writel(0xaaaa, priv->mmio + EP93XX_WATCHDOG);
>
>  	return 0;
>  }
>
>  static int ep93xx_wdt_stop(struct watchdog_device *wdd)
>  {
> -	del_timer_sync(&timer);
> -	writel(0xaa55, mmio_base + EP93XX_WATCHDOG);
> +	struct ep93xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
> +
> +	writel(0xaa55, priv->mmio + EP93XX_WATCHDOG);
>
>  	return 0;
>  }
>
> -static int ep93xx_wdt_keepalive(struct watchdog_device *wdd)
> +static int ep93xx_wdt_ping(struct watchdog_device *wdd)
>  {
> -	/* user land ping */
> -	next_heartbeat = jiffies + (timeout * HZ);
> +	struct ep93xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
> +
> +	writel(0x5555, priv->mmio + EP93XX_WATCHDOG);
>
>  	return 0;
>  }
>
>  static const struct watchdog_info ep93xx_wdt_ident = {
>  	.options	= WDIOF_CARDRESET |
> +			  WDIOF_SETTIMEOUT |
>  			  WDIOF_MAGICCLOSE |
>  			  WDIOF_KEEPALIVEPING,
>  	.identity	= "EP93xx Watchdog",
> @@ -103,55 +85,50 @@ static struct watchdog_ops ep93xx_wdt_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= ep93xx_wdt_start,
>  	.stop		= ep93xx_wdt_stop,
> -	.ping		= ep93xx_wdt_keepalive,
> -};
> -
> -static struct watchdog_device ep93xx_wdt_wdd = {
> -	.info		= &ep93xx_wdt_ident,
> -	.ops		= &ep93xx_wdt_ops,
> +	.ping		= ep93xx_wdt_ping,
>  };
>
>  static int ep93xx_wdt_probe(struct platform_device *pdev)
>  {
> +	struct ep93xx_wdt_priv *priv;
> +	struct watchdog_device *wdd;
>  	struct resource *res;
>  	unsigned long val;
> -	int err;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mmio_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(mmio_base))
> -		return PTR_ERR(mmio_base);
> +	priv->mmio = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->mmio))
> +		return PTR_ERR(priv->mmio);
>
> -	if (timeout < 1 || timeout > 3600) {
> -		timeout = WDT_TIMEOUT;
> -		dev_warn(&pdev->dev,
> -			"timeout value must be 1<=x<=3600, using %d\n",
> -			timeout);
> -	}
> +	val = readl(priv->mmio + EP93XX_WATCHDOG);
>
> -	val = readl(mmio_base + EP93XX_WATCHDOG);
> -	ep93xx_wdt_wdd.bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
> -	ep93xx_wdt_wdd.timeout = timeout;
> -	ep93xx_wdt_wdd.parent = &pdev->dev;
> +	wdd = &priv->wdd;
> +	wdd->bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
> +	wdd->info = &ep93xx_wdt_ident;
> +	wdd->ops = &ep93xx_wdt_ops;
> +	wdd->min_timeout = 1;
> +	wdd->max_hw_heartbeat_ms = 200;
> +	wdd->parent = &pdev->dev;
>
> -	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);
> +	watchdog_set_nowayout(wdd, nowayout);
> +	watchdog_init_timeout(wdd, timeout, &pdev->dev);
>
> -	setup_timer(&timer, ep93xx_wdt_timer_ping, 1);
> +	watchdog_set_drvdata(wdd, priv);
>
> -	err = watchdog_register_device(&ep93xx_wdt_wdd);
> -	if (err)
> -		return err;
> +	ret = devm_watchdog_register_device(&pdev->dev, wdd);
> +	if (ret)
> +		return ret;
>
> -	dev_info(&pdev->dev,
> -		"EP93XX watchdog, driver version " WDT_VERSION "%s\n",
> -		(val & 0x08) ? " (nCS1 disable detected)" : "");
> +	platform_set_drvdata(pdev, priv);

Now unnecessary.

Thanks,
Guenter

>
> -	return 0;
> -}
> +	dev_info(&pdev->dev, "EP93XX watchdog driver %s\n",
> +		(val & 0x08) ? " (nCS1 disable detected)" : "");
>
> -static int ep93xx_wdt_remove(struct platform_device *pdev)
> -{
> -	watchdog_unregister_device(&ep93xx_wdt_wdd);
>  	return 0;
>  }
>
> @@ -160,7 +137,6 @@ static struct platform_driver ep93xx_wdt_driver = {
>  		.name	= "ep93xx-wdt",
>  	},
>  	.probe		= ep93xx_wdt_probe,
> -	.remove		= ep93xx_wdt_remove,
>  };
>
>  module_platform_driver(ep93xx_wdt_driver);
> @@ -170,4 +146,3 @@ MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
>  MODULE_AUTHOR("H Hartley Sweeten <hsweeten@visionengravers.com>");
>  MODULE_DESCRIPTION("EP93xx Watchdog");
>  MODULE_LICENSE("GPL");
> -MODULE_VERSION(WDT_VERSION);
>

