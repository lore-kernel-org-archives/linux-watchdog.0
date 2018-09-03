Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40461 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeIDEFv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Sep 2018 00:05:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so715092pga.7
        for <linux-watchdog@vger.kernel.org>; Mon, 03 Sep 2018 16:43:24 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] wdt: lantiq: Convert to watchdog_device
To: Hauke Mehrtens <hauke@hauke-m.de>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, john@phrozen.org, dev@kresin.me
References: <20180902113233.29113-1-hauke@hauke-m.de>
 <20180902113233.29113-3-hauke@hauke-m.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7c475c33-72c9-1217-7655-c8063683b3fc@roeck-us.net>
Date: Mon, 3 Sep 2018 16:43:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180902113233.29113-3-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/02/2018 04:32 AM, Hauke Mehrtens wrote:
> Instead of doing the ioctl handling manually just use register a
> watchdog_device and let the watchdog framework do the ioctl handling.
> 
> This also removes the ltq_wdt_bootstatus_set typedef and replaces it
> with a structure providing the chip specific functions pointer.
> The watchdog_init_timeout() function is now used and the initial timeout
> can be provided in device tree.
> If the watchdog was already activated it will not be stopped any more,
> but the settings from the driver will be used and the watchdog subsystem
> will take care.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   drivers/watchdog/Kconfig      |   1 +
>   drivers/watchdog/lantiq_wdt.c | 277 +++++++++++++++++++-----------------------
>   2 files changed, 126 insertions(+), 152 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5ea8909a41f9..5637d8be31e0 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1621,6 +1621,7 @@ config IMGPDC_WDT
>   config LANTIQ_WDT
>   	tristate "Lantiq SoC watchdog"
>   	depends on LANTIQ
> +	select WATCHDOG_CORE
>   	help
>   	  Hardware driver for the Lantiq SoC Watchdog Timer.
>   
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index e5937be09bd4..666db382b824 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -8,11 +8,7 @@
>    *  Based on EP93xx wdt driver
>    */
>   
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>   #include <linux/module.h>
> -#include <linux/fs.h>
> -#include <linux/miscdevice.h>
>   #include <linux/bitops.h>
>   #include <linux/watchdog.h>
>   #include <linux/of_platform.h>
> @@ -55,154 +51,99 @@
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   
> -static void __iomem *ltq_wdt_membase;
> -static unsigned long ltq_io_region_clk_rate;
> +struct ltq_wdt_hw {
> +	int (*bootstatus_get)(struct device *dev);
> +};
>   
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
> -	if (timeout > LTQ_WDT_CR_RELOAD_MASK)
> -		timeout = LTQ_WDT_CR_RELOAD_MASK;
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
>   
> -	return len;
> +	val &= ~(clear);
> +	val |= set;
> +	ltq_wdt_w32(priv, val, offset);
>   }
>   
> -static struct watchdog_info ident = {
> +static struct ltq_wdt_priv *ltq_wdt_get_priv(struct watchdog_device *wdt)
> +{
> +	return container_of(wdt, struct ltq_wdt_priv, wdt);
> +}
> +
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
> +	timeout = wdt->timeout * priv->clk_rate;
> +
> +	ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK, LTQ_WDT_CR_PW1, LTQ_WDT_CR);
> +	/* write the second magic plus the configuration and new timeout */
> +	ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK | LTQ_WDT_CR_RELOAD_MASK,
> +		     LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV |
> +		     LTQ_WDT_CR_PW2 | timeout,
> +		     LTQ_WDT_CR);
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
> +	timeout = wdt->timeout * priv->clk_rate;
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
> +	.start		= ltq_wdt_start,
> +	.stop		= ltq_wdt_stop,
> +	.ping		= ltq_wdt_ping,
>   };
>   
> -static struct miscdevice ltq_wdt_miscdev = {
> -	.minor	= WATCHDOG_MINOR,
> -	.name	= "watchdog",
> -	.fops	= &ltq_wdt_fops,
> -};
> -
> -typedef int (*ltq_wdt_bootstatus_set)(struct platform_device *pdev);
> -
> -static int ltq_wdt_bootstatus_xrx(struct platform_device *pdev)
> +static int ltq_wdt_bootstatus_xrx(struct device *dev)
>   {
> -	struct device *dev = &pdev->dev;
>   	struct regmap *rcu_regmap;
>   	u32 val;
>   	int err;
> @@ -216,14 +157,13 @@ static int ltq_wdt_bootstatus_xrx(struct platform_device *pdev)
>   		return err;
>   
>   	if (val & LTQ_XRX_RCU_RST_STAT_WDT)
> -		ltq_wdt_bootstatus = WDIOF_CARDRESET;
> +		return WDIOF_CARDRESET;
>   
>   	return 0;
>   }
>   
> -static int ltq_wdt_bootstatus_falcon(struct platform_device *pdev)
> +static int ltq_wdt_bootstatus_falcon(struct device *dev)
>   {
> -	struct device *dev = &pdev->dev;
>   	struct regmap *rcu_regmap;
>   	u32 val;
>   	int err;
> @@ -238,62 +178,95 @@ static int ltq_wdt_bootstatus_falcon(struct platform_device *pdev)
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
> +	struct device *dev = &pdev->dev;
> +	struct ltq_wdt_priv *priv;
> +	struct watchdog_device *wdt;
> +	struct resource *res;
>   	struct clk *clk;
> -	ltq_wdt_bootstatus_set ltq_wdt_bootstatus_set;
> +	const struct ltq_wdt_hw *ltq_wdt_hw;
>   	int ret;
> +	u32 status;
>   
> -	ltq_wdt_membase = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(ltq_wdt_membase))
> -		return PTR_ERR(ltq_wdt_membase);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
>   
> -	ltq_wdt_bootstatus_set = of_device_get_match_data(&pdev->dev);
> -	if (ltq_wdt_bootstatus_set) {
> -		ret = ltq_wdt_bootstatus_set(pdev);
> -		if (ret)
> -			return ret;
> -	}
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->membase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->membase))
> +		return PTR_ERR(priv->membase);
>   
>   	/* we do not need to enable the clock as it is always running */
>   	clk = clk_get_io();
>   	if (IS_ERR(clk)) {

Not new, nor that it really matters, but this error check is quite pointless:
The function never returns an error.

> -		dev_err(&pdev->dev, "Failed to get clock\n");
> -		return -ENOENT;
> +		dev_err(dev, "Failed to get clock");
> +		return PTR_ERR(clk);
>   	}
> -	ltq_io_region_clk_rate = clk_get_rate(clk);
> +	priv->clk_rate = clk_get_rate(clk) / LTQ_WDT_DIVIDER;
>   	clk_put(clk);

Calling clk_put() here actually odd and should be dropped. Unlike clk_get(),
clk_get_io() does not get a reference to the clock instance. It just returns
a pointer to a static clock.

> +	if (!priv->clk_rate) {
> +		dev_err(dev, "clock has wrong value of 0");

This is misleading: It is not known if the clock rate is indeed 0.
It is only known that the clock rate is below LTQ_WDT_DIVIDER.

> +		return -EIO;

I am not happy with EIO in this case. There is no indication
of an I/O error.

> +	}
>   
> -	dev_info(&pdev->dev, "Init done\n");
> -	return misc_register(&ltq_wdt_miscdev);
> -}
> +	wdt = &priv->wdt;
> +	wdt->info		= &ltq_wdt_info;
> +	wdt->ops		= &ltq_wdt_ops;
> +	wdt->min_timeout	= 1;
> +	wdt->max_timeout	= LTQ_WDT_CR_RELOAD_MASK / priv->clk_rate;
> +	wdt->timeout		= wdt->max_timeout;
> +	wdt->parent		= dev;
> +
> +	ltq_wdt_hw = of_device_get_match_data(dev);
> +	if (ltq_wdt_hw && ltq_wdt_hw->bootstatus_get) {
> +		ret = ltq_wdt_hw->bootstatus_get(dev);
> +		if (ret < 0)
> +			return ret;

This is also quite pointless: The functions never return an error.
Might as well just assign the returned value to bootstatus.

While it makes some sense to have the error checks above (after all,
the API could change), this one really does not make sense since it is
in full driver control.

> +		wdt->bootstatus = ret;
> +	}
>   
> -static int
> -ltq_wdt_remove(struct platform_device *pdev)
> -{
> -	misc_deregister(&ltq_wdt_miscdev);
> +	watchdog_set_nowayout(wdt, nowayout);
> +	watchdog_init_timeout(wdt, 0, dev);
> +
> +	status = ltq_wdt_r32(priv, LTQ_WDT_CR);
> +	if (status & LTQ_WDT_CR_GEN) {
> +		/*
> +		 * If the watchdog is already running overwrite it with our
> +		 * new settings. Stop is not needed as the start call will
> +		 * replace all settings anyway.
> +		 */
> +		ltq_wdt_start(wdt);
> +		set_bit(WDOG_HW_RUNNING, &wdt->status);
> +	}
>   
> -	return 0;
> +	return devm_watchdog_register_device(dev, wdt);
>   }
>   
> +static const struct ltq_wdt_hw ltq_wdt_xrx100 = {
> +	.bootstatus_get = ltq_wdt_bootstatus_xrx,
> +};
> +
> +static const struct ltq_wdt_hw ltq_wdt_falcon = {
> +	.bootstatus_get = ltq_wdt_bootstatus_falcon,
> +};
> +
>   static const struct of_device_id ltq_wdt_match[] = {
> -	{ .compatible = "lantiq,wdt", .data = NULL},
> -	{ .compatible = "lantiq,xrx100-wdt", .data = ltq_wdt_bootstatus_xrx },
> -	{ .compatible = "lantiq,falcon-wdt", .data = ltq_wdt_bootstatus_falcon },
> +	{ .compatible = "lantiq,wdt", .data = NULL },
> +	{ .compatible = "lantiq,xrx100-wdt", .data = &ltq_wdt_xrx100 },
> +	{ .compatible = "lantiq,falcon-wdt", .data = &ltq_wdt_falcon },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, ltq_wdt_match);
>   
>   static struct platform_driver ltq_wdt_driver = {
>   	.probe = ltq_wdt_probe,
> -	.remove = ltq_wdt_remove,
>   	.driver = {
>   		.name = "wdt",
>   		.of_match_table = ltq_wdt_match,
> 
