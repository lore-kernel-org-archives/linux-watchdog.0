Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47094 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeGVPIb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Jul 2018 11:08:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so10351696pgv.13
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Jul 2018 07:11:41 -0700 (PDT)
Subject: Re: [PATCH 2/3] wdt: lantiq: Convert to watchdog_device
To: Hauke Mehrtens <hauke@hauke-m.de>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, john@phrozen.org, dev@kresin.me
References: <20180721232635.10523-1-hauke@hauke-m.de>
 <20180721232635.10523-2-hauke@hauke-m.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1df1b7d3-0101-e20a-95bc-a7352b05b398@roeck-us.net>
Date: Sun, 22 Jul 2018 07:11:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180721232635.10523-2-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/21/2018 04:26 PM, Hauke Mehrtens wrote:
> Instead of doing the ioctl handling manually just use register a
> watchdog_device and let the watchdog framework do the ioctl handling.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   drivers/watchdog/Kconfig      |   1 +
>   drivers/watchdog/lantiq_wdt.c | 245 ++++++++++++++++++------------------------
>   2 files changed, 108 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd92763..2118a86bfe0e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1611,6 +1611,7 @@ config IMGPDC_WDT
>   config LANTIQ_WDT
>   	tristate "Lantiq SoC watchdog"
>   	depends on LANTIQ
> +	select WATCHDOG_CORE
>   	help
>   	  Hardware driver for the Lantiq SoC Watchdog Timer.
>   
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index 8732a7bcc7ba..5cc02849f599 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -8,8 +8,6 @@
>    *  Based on EP93xx wdt driver
>    */
>   
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>   #include <linux/module.h>
>   #include <linux/fs.h>
>   #include <linux/miscdevice.h>

The above two includes are no longer needed, as is uaccess.h.

> @@ -52,155 +50,99 @@
>   #define LTQ_WDT_SR		0x8	/* watchdog status register */
>   #define  LTQ_WDT_SR_VALUE_MASK	GENMASK(15, 0)	/* Timer value */
>   
> -#define LTQ_WDT_DIVIDER		0x40000
> +#define LTQ_WDT_DIVIDER		0x40000ll
>   #define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */
>   

Not or no longer used (which means don't bother updating patch #1,
but drop the define here).

>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   
> -static void __iomem *ltq_wdt_membase;
> -static unsigned long ltq_io_region_clk_rate;
> -
> -static unsigned long ltq_wdt_bootstatus;
> -static unsigned long ltq_wdt_in_use;
> -static int ltq_wdt_timeout = 30;
> -static int ltq_wdt_ok_to_close;
> +struct ltq_wdt_priv {
> +	struct watchdog_device wdt;
> +	void __iomem *membase;
> +	unsigned long clk_rate;
> +};
>   
> -static void
> -ltq_wdt_enable(void)
> +static u32 ltq_wdt_r32(struct ltq_wdt_priv *priv, u32 offset)
>   {
> -	unsigned long int timeout = ltq_wdt_timeout *
> -			(ltq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
> -	if (timeout > LTQ_MAX_TIMEOUT)
> -		timeout = LTQ_MAX_TIMEOUT;
> -
> -	/* write the first password magic */
> -	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> -	/* write the second magic plus the configuration and new timeout */
> -	ltq_w32(LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV |
> -		LTQ_WDT_CR_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
> +	return __raw_readl(priv->membase + offset);
>   }
>   
> -static void
> -ltq_wdt_disable(void)
> +static void ltq_wdt_w32(struct ltq_wdt_priv *priv, u32 val, u32 offset)
>   {
> -	/* write the first password magic */
> -	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> -	/*
> -	 * write the second password magic with no config
> -	 * this turns the watchdog off
> -	 */
> -	ltq_w32(LTQ_WDT_CR_PW2, ltq_wdt_membase + LTQ_WDT_CR);
> +	return __raw_writel(val, priv->membase + offset);
>   }
>   
> -static ssize_t
> -ltq_wdt_write(struct file *file, const char __user *data,
> -		size_t len, loff_t *ppos)
> +static void ltq_wdt_mask(struct ltq_wdt_priv *priv, u32 clear, u32 set,
> +			 u32 offset)
>   {
> -	if (len) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			ltq_wdt_ok_to_close = 0;
> -			for (i = 0; i != len; i++) {
> -				char c;
> -
> -				if (get_user(c, data + i))
> -					return -EFAULT;
> -				if (c == 'V')
> -					ltq_wdt_ok_to_close = 1;
> -				else
> -					ltq_wdt_ok_to_close = 0;
> -			}
> -		}
> -		ltq_wdt_enable();
> -	}
> +	u32 val = ltq_wdt_r32(priv, offset);
> +
> +	val &= ~(clear);
> +	val |= set;
> +	ltq_wdt_w32(priv, val, offset);
> +}
>   

Those operations are quite identical to existing regmap operations. How about using regmap ?

> -	return len;
> +static struct ltq_wdt_priv *ltq_wdt_get_priv(struct watchdog_device *wdt)
> +{
> +	return container_of(wdt, struct ltq_wdt_priv, wdt);
>   }
>   
> -static struct watchdog_info ident = {
> +static struct watchdog_info ltq_wdt_info = {
>   	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> -			WDIOF_CARDRESET,
> +		   WDIOF_CARDRESET,
>   	.identity = "ltq_wdt",
>   };
>   
> -static long
> -ltq_wdt_ioctl(struct file *file,
> -		unsigned int cmd, unsigned long arg)
> +static int ltq_wdt_start(struct watchdog_device *wdt)
>   {
> -	int ret = -ENOTTY;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
> -				sizeof(ident)) ? -EFAULT : 0;
> -		break;
> -
> -	case WDIOC_GETBOOTSTATUS:
> -		ret = put_user(ltq_wdt_bootstatus, (int __user *)arg);
> -		break;
> -
> -	case WDIOC_GETSTATUS:
> -		ret = put_user(0, (int __user *)arg);
> -		break;
> -
> -	case WDIOC_SETTIMEOUT:
> -		ret = get_user(ltq_wdt_timeout, (int __user *)arg);
> -		if (!ret)
> -			ltq_wdt_enable();
> -		/* intentional drop through */
> -	case WDIOC_GETTIMEOUT:
> -		ret = put_user(ltq_wdt_timeout, (int __user *)arg);
> -		break;
> -
> -	case WDIOC_KEEPALIVE:
> -		ltq_wdt_enable();
> -		ret = 0;
> -		break;
> -	}
> -	return ret;
> +	struct ltq_wdt_priv *priv = ltq_wdt_get_priv(wdt);
> +	u32 timeout;
> +
> +	timeout = wdt->timeout * (priv->clk_rate / LTQ_WDT_DIVIDER);
> +
Consider storing priv->clk_rate / LTQ_WDT_DIVIDER [or even
wdt->timeout * (priv->clk_rate / LTQ_WDT_DIVIDER)] in the local
data structure. That would save the divide operation each time
the value is needed/used.

> +	ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK, LTQ_WDT_CR_PW1, LTQ_WDT_CR);
> +	/* write the second magic plus the configuration and new timeout */
> +	ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK | LTQ_WDT_CR_RELOAD_MASK,
> +		     LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV |
> +		     LTQ_WDT_CR_PW2 | timeout,
> +		     LTQ_WDT_CR);

Since the added defines from patch #1 are used here, they should be defined
in this patch.

> +
> +	return 0;
>   }
>   
> -static int
> -ltq_wdt_open(struct inode *inode, struct file *file)
> +static int ltq_wdt_stop(struct watchdog_device *wdt)
>   {
> -	if (test_and_set_bit(0, &ltq_wdt_in_use))
> -		return -EBUSY;
> -	ltq_wdt_in_use = 1;
> -	ltq_wdt_enable();
> +	struct ltq_wdt_priv *priv = ltq_wdt_get_priv(wdt);
>   
> -	return nonseekable_open(inode, file);
> +	ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK, LTQ_WDT_CR_PW1, LTQ_WDT_CR);
> +	ltq_wdt_mask(priv, LTQ_WDT_CR_GEN | LTQ_WDT_CR_PW_MASK,
> +		     LTQ_WDT_CR_PW2, LTQ_WDT_CR);
> +
> +	return 0;
>   }
>   
> -static int
> -ltq_wdt_release(struct inode *inode, struct file *file)
> +static int ltq_wdt_ping(struct watchdog_device *wdt)
>   {
> -	if (ltq_wdt_ok_to_close)
> -		ltq_wdt_disable();
> -	else
> -		pr_err("watchdog closed without warning\n");
> -	ltq_wdt_ok_to_close = 0;
> -	clear_bit(0, &ltq_wdt_in_use);
> +	struct ltq_wdt_priv *priv = ltq_wdt_get_priv(wdt);
> +	u32 timeout;
> +
> +	timeout = wdt->timeout * (priv->clk_rate / LTQ_WDT_DIVIDER);
> +
> +	ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK, LTQ_WDT_CR_PW1, LTQ_WDT_CR);
> +	/* write the second magic plus the configuration and new timeout */
> +	ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK | LTQ_WDT_CR_RELOAD_MASK,
> +		     LTQ_WDT_CR_PW2 | timeout, LTQ_WDT_CR);
>   
>   	return 0;
>   }
>   
> -static const struct file_operations ltq_wdt_fops = {
> +static const struct watchdog_ops ltq_wdt_ops = {
>   	.owner		= THIS_MODULE,
> -	.write		= ltq_wdt_write,
> -	.unlocked_ioctl	= ltq_wdt_ioctl,
> -	.open		= ltq_wdt_open,
> -	.release	= ltq_wdt_release,
> -	.llseek		= no_llseek,
> -};
> -
> -static struct miscdevice ltq_wdt_miscdev = {
> -	.minor	= WATCHDOG_MINOR,
> -	.name	= "watchdog",
> -	.fops	= &ltq_wdt_fops,
> +	.start		= ltq_wdt_start,
> +	.stop		= ltq_wdt_stop,
> +	.ping		= ltq_wdt_ping,
>   };
>   
> -typedef int (*ltq_wdt_bootstatus_set)(struct platform_device *pdev);
> +typedef int (*ltq_wdt_bootstatus_get)(struct platform_device *pdev);
>   

Please drop that typedef. Doesn't that generate a checkpatch warning ?

>   static int ltq_wdt_bootstatus_xrx(struct platform_device *pdev)
>   {
> @@ -218,7 +160,7 @@ static int ltq_wdt_bootstatus_xrx(struct platform_device *pdev)
>   		return err;
>   
>   	if (val & LTQ_XRX_RCU_RST_STAT_WDT)
> -		ltq_wdt_bootstatus = WDIOF_CARDRESET;
> +		return WDIOF_CARDRESET;
>   
>   	return 0;
>   }
> @@ -240,29 +182,31 @@ static int ltq_wdt_bootstatus_falcon(struct platform_device *pdev)
>   		return err;
>   
>   	if ((val & LTQ_FALCON_SYS1_CPU0RS_MASK) == LTQ_FALCON_SYS1_CPU0RS_WDT)
> -		ltq_wdt_bootstatus = WDIOF_CARDRESET;
> +		return WDIOF_CARDRESET;
>   
>   	return 0;
>   }
>   
> -static int
> -ltq_wdt_probe(struct platform_device *pdev)
> +static int ltq_wdt_probe(struct platform_device *pdev)
>   {
> -	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	u64 max_clocks = LTQ_MAX_TIMEOUT * LTQ_WDT_DIVIDER;

That can be a define.

> +	struct ltq_wdt_priv *priv;
> +	struct watchdog_device *wdt;
> +	struct resource *res;
>   	struct clk *clk;
> -	ltq_wdt_bootstatus_set ltq_wdt_bootstatus_set;
> +	ltq_wdt_bootstatus_get ltq_wdt_bootstatus_get;
>   	int ret;
>   
> -	ltq_wdt_membase = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(ltq_wdt_membase))
> -		return PTR_ERR(ltq_wdt_membase);
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
>   
> -	ltq_wdt_bootstatus_set = of_device_get_match_data(&pdev->dev);
> -	if (ltq_wdt_bootstatus_set) {
> -		ret = ltq_wdt_bootstatus_set(pdev);
> -		if (ret)
> -			return ret;
> -	}
> +	wdt = &priv->wdt;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->membase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->membase))
> +		return PTR_ERR(priv->membase);
>   
>   	/* we do not need to enable the clock as it is always running */
>   	clk = clk_get_io();
> @@ -270,17 +214,42 @@ ltq_wdt_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "Failed to get clock\n");
>   		return -ENOENT;
>   	}
> -	ltq_io_region_clk_rate = clk_get_rate(clk);
> +	priv->clk_rate = clk_get_rate(clk);

Please check if this is 0 and bail out if it is.

>   	clk_put(clk);
>   
> -	dev_info(&pdev->dev, "Init done\n");
> -	return misc_register(&ltq_wdt_miscdev);
> +	wdt->info		= &ltq_wdt_info;
> +	wdt->ops		= &ltq_wdt_ops;
> +	wdt->status		= 0;

Unnecessary.

> +	wdt->min_timeout	= 1;
> +	wdt->max_timeout	= div_u64(max_clocks, priv->clk_rate);

At least theoretically this can overflow. It would be better to assign it
to a variable and clamp it to [1, INT_MAX].

> +	wdt->timeout		= wdt->max_timeout;
> +	wdt->parent		= &pdev->dev;
> +
> +	ltq_wdt_bootstatus_get = of_device_get_match_data(&pdev->dev);
> +	if (ltq_wdt_bootstatus_get) {
> +		ret = ltq_wdt_bootstatus_get(pdev);
> +		if (ret < 0)
> +			return ret;
> +		wdt->bootstatus = ret;
> +	}
> +
> +	watchdog_set_nowayout(wdt, nowayout);

Add watchdog_set_timeout(wdt, 0) ? This way the initial timeout is taken from
devicetree.

> +	platform_set_drvdata(pdev, priv);

Not needed if you use the devm_ registration function.

> +
> +	ltq_wdt_stop(wdt);

Is this necessary ? It might be better to tell the watchdog core
that the watchdog is running if it is.

> +
> +	ret = watchdog_register_device(wdt);

return devm_watchdog_register_device() ...

> +	if (ret)
> +		return ret;
> +
> +	return 0;
>   }
>   
> -static int
> -ltq_wdt_remove(struct platform_device *pdev)
> +static int ltq_wdt_remove(struct platform_device *pdev)
>   {
> -	misc_deregister(&ltq_wdt_miscdev);
> +	struct ltq_wdt_priv *priv = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&priv->wdt);
>   
... and drop the remove function.

>   	return 0;
>   }
> 

