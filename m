Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36610 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753848AbdA3TEE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 30 Jan 2017 14:04:04 -0500
Date: Mon, 30 Jan 2017 11:01:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@iki.fi>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 2/2] watchdog: ts72xx_wdt: convert driver to watchdog core
Message-ID: <20170130190138.GB11199@roeck-us.net>
References: <20170130165548.40965-1-hsweeten@visionengravers.com>
 <20170130165548.40965-3-hsweeten@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170130165548.40965-3-hsweeten@visionengravers.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 30, 2017 at 09:55:48AM -0700, H Hartley Sweeten wrote:
> Cleanup this driver and convert it to use the watchdog framework API.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/ts72xx_wdt.c | 447 +++++++++---------------------------------
>  1 file changed, 93 insertions(+), 354 deletions(-)
> 
> diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> index 4b54193..857ab71 100644
> --- a/drivers/watchdog/ts72xx_wdt.c
> +++ b/drivers/watchdog/ts72xx_wdt.c
> @@ -13,413 +13,149 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> -#include <linux/fs.h>
> -#include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/miscdevice.h>
> -#include <linux/mutex.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
> +#include <linux/module.h>
>  #include <linux/watchdog.h>
> -#include <linux/uaccess.h>
> -
> -#define TS72XX_WDT_FEED_VAL		0x05
> -#define TS72XX_WDT_DEFAULT_TIMEOUT	8
> -
> -static int timeout = TS72XX_WDT_DEFAULT_TIMEOUT;
> -module_param(timeout, int, 0);
> -MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. "
> -			  "(1 <= timeout <= 8, default="
> -			  __MODULE_STRING(TS72XX_WDT_DEFAULT_TIMEOUT)
> -			  ")");

Same question as with patch #1 - are you sure you want to take this away ?
You might just drop the limits instead (also see below).

> +#include <linux/io.h>
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
>  
> -/**
> - * struct ts72xx_wdt - watchdog control structure
> - * @lock: lock that protects this structure
> - * @regval: watchdog timeout value suitable for control register
> - * @flags: flags controlling watchdog device state
> - * @control_reg: watchdog control register
> - * @feed_reg: watchdog feed register
> - * @pdev: back pointer to platform dev
> - */
> -struct ts72xx_wdt {
> -	struct mutex	lock;
> -	int		regval;
> -
> -#define TS72XX_WDT_BUSY_FLAG		1
> -#define TS72XX_WDT_EXPECT_CLOSE_FLAG	2
> -	int		flags;
> +/* priv->control_reg */
> +#define TS72XX_WDT_CTRL_DISABLE		0x00
> +#define TS72XX_WDT_CTRL_250MS		0x01
> +#define TS72XX_WDT_CTRL_500MS		0x02
> +#define TS72XX_WDT_CTRL_1SEC		0x03
> +#define TS72XX_WDT_CTRL_RESERVED	0x04
> +#define TS72XX_WDT_CTRL_2SEC		0x05
> +#define TS72XX_WDT_CTRL_4SEC		0x06
> +#define TS72XX_WDT_CTRL_8SEC		0x07
> +
> +/* priv->feed_reg */
> +#define TS72XX_WDT_FEED_VAL		0x05
>  
> +struct ts72xx_wdt_priv {
>  	void __iomem	*control_reg;
>  	void __iomem	*feed_reg;
> -
> -	struct platform_device *pdev;
> +	struct watchdog_device wdd;
> +	unsigned char regval;
>  };
>  
> -static struct platform_device *ts72xx_wdt_pdev;
> -
> -/*
> - * TS-72xx Watchdog supports following timeouts (value written
> - * to control register):
> - *	value	description
> - *	-------------------------
> - *	0x00	watchdog disabled
> - *	0x01	250ms
> - *	0x02	500ms
> - *	0x03	1s
> - *	0x04	reserved
> - *	0x05	2s
> - *	0x06	4s
> - *	0x07	8s
> - *
> - * Timeouts below 1s are not very usable so we don't
> - * allow them at all.
> - *
> - * We provide two functions that convert between these:
> - * timeout_to_regval() and regval_to_timeout().
> - */
> -static const struct {
> -	int	timeout;
> -	int	regval;
> -} ts72xx_wdt_map[] = {
> -	{ 1, 3 },
> -	{ 2, 5 },
> -	{ 4, 6 },
> -	{ 8, 7 },
> -};
> -
> -/**
> - * timeout_to_regval() - converts given timeout to control register value
> - * @new_timeout: timeout in seconds to be converted
> - *
> - * Function converts given @new_timeout into valid value that can
> - * be programmed into watchdog control register. When conversion is
> - * not possible, function returns %-EINVAL.
> - */
> -static int timeout_to_regval(int new_timeout)
> +static int ts72xx_wdt_start(struct watchdog_device *wdd)
>  {
> -	int i;
> +	struct ts72xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
>  
> -	/* first limit it to 1 - 8 seconds */
> -	new_timeout = clamp_val(new_timeout, 1, 8);
> +	writeb(TS72XX_WDT_FEED_VAL, priv->feed_reg);
> +	writeb(priv->regval, priv->control_reg);
>  
> -	for (i = 0; i < ARRAY_SIZE(ts72xx_wdt_map); i++) {
> -		if (ts72xx_wdt_map[i].timeout >= new_timeout)
> -			return ts72xx_wdt_map[i].regval;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/**
> - * regval_to_timeout() - converts control register value to timeout
> - * @regval: control register value to be converted
> - *
> - * Function converts given @regval to timeout in seconds (1, 2, 4 or 8).
> - * If @regval cannot be converted, function returns %-EINVAL.
> - */
> -static int regval_to_timeout(int regval)
> -{
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(ts72xx_wdt_map); i++) {
> -		if (ts72xx_wdt_map[i].regval == regval)
> -			return ts72xx_wdt_map[i].timeout;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/**
> - * ts72xx_wdt_kick() - kick the watchdog
> - * @wdt: watchdog to be kicked
> - *
> - * Called with @wdt->lock held.
> - */
> -static inline void ts72xx_wdt_kick(struct ts72xx_wdt *wdt)
> -{
> -	__raw_writeb(TS72XX_WDT_FEED_VAL, wdt->feed_reg);
> -}
> -
> -/**
> - * ts72xx_wdt_start() - starts the watchdog timer
> - * @wdt: watchdog to be started
> - *
> - * This function programs timeout to watchdog timer
> - * and starts it.
> - *
> - * Called with @wdt->lock held.
> - */
> -static void ts72xx_wdt_start(struct ts72xx_wdt *wdt)
> -{
> -	/*
> -	 * To program the wdt, it first must be "fed" and
> -	 * only after that (within 30 usecs) the configuration
> -	 * can be changed.
> -	 */
> -	ts72xx_wdt_kick(wdt);
> -	__raw_writeb((u8)wdt->regval, wdt->control_reg);
> -}
> -
> -/**
> - * ts72xx_wdt_stop() - stops the watchdog timer
> - * @wdt: watchdog to be stopped
> - *
> - * Called with @wdt->lock held.
> - */
> -static void ts72xx_wdt_stop(struct ts72xx_wdt *wdt)
> -{
> -	ts72xx_wdt_kick(wdt);
> -	__raw_writeb(0, wdt->control_reg);
> +	return 0;
>  }
>  
> -static int ts72xx_wdt_open(struct inode *inode, struct file *file)
> +static int ts72xx_wdt_stop(struct watchdog_device *wdd)
>  {
> -	struct ts72xx_wdt *wdt = platform_get_drvdata(ts72xx_wdt_pdev);
> -	int regval;
> -
> -	/*
> -	 * Try to convert default timeout to valid register
> -	 * value first.
> -	 */
> -	regval = timeout_to_regval(timeout);
> -	if (regval < 0) {
> -		dev_err(&wdt->pdev->dev,
> -			"failed to convert timeout (%d) to register value\n",
> -			timeout);
> -		return regval;
> -	}
> -
> -	if (mutex_lock_interruptible(&wdt->lock))
> -		return -ERESTARTSYS;
> -
> -	if ((wdt->flags & TS72XX_WDT_BUSY_FLAG) != 0) {
> -		mutex_unlock(&wdt->lock);
> -		return -EBUSY;
> -	}
> +	struct ts72xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
>  
> -	wdt->flags = TS72XX_WDT_BUSY_FLAG;
> -	wdt->regval = regval;
> -	file->private_data = wdt;
> +	writeb(TS72XX_WDT_FEED_VAL, priv->feed_reg);
> +	writeb(TS72XX_WDT_CTRL_DISABLE, priv->control_reg);
>  
> -	ts72xx_wdt_start(wdt);
> -
> -	mutex_unlock(&wdt->lock);
> -	return nonseekable_open(inode, file);
> +	return 0;
>  }
>  
> -static int ts72xx_wdt_release(struct inode *inode, struct file *file)
> +static int ts72xx_wdt_ping(struct watchdog_device *wdd)
>  {
> -	struct ts72xx_wdt *wdt = file->private_data;
> -
> -	if (mutex_lock_interruptible(&wdt->lock))
> -		return -ERESTARTSYS;
> -
> -	if ((wdt->flags & TS72XX_WDT_EXPECT_CLOSE_FLAG) != 0) {
> -		ts72xx_wdt_stop(wdt);
> -	} else {
> -		dev_warn(&wdt->pdev->dev,
> -			 "TS-72XX WDT device closed unexpectly. "
> -			 "Watchdog timer will not stop!\n");
> -		/*
> -		 * Kick it one more time, to give userland some time
> -		 * to recover (for example, respawning the kicker
> -		 * daemon).
> -		 */
> -		ts72xx_wdt_kick(wdt);
> -	}
> +	struct ts72xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
>  
> -	wdt->flags = 0;
> +	writeb(TS72XX_WDT_FEED_VAL, priv->feed_reg);
>  
> -	mutex_unlock(&wdt->lock);
>  	return 0;
>  }
>  
> -static ssize_t ts72xx_wdt_write(struct file *file,
> -				const char __user *data,
> -				size_t len,
> -				loff_t *ppos)
> +static int ts72xx_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
>  {
> -	struct ts72xx_wdt *wdt = file->private_data;
> -
> -	if (!len)
> -		return 0;
> -
> -	if (mutex_lock_interruptible(&wdt->lock))
> -		return -ERESTARTSYS;
> -
> -	ts72xx_wdt_kick(wdt);
> -
> -	/*
> -	 * Support for magic character closing. User process
> -	 * writes 'V' into the device, just before it is closed.
> -	 * This means that we know that the wdt timer can be
> -	 * stopped after user closes the device.
> -	 */
> -	if (!nowayout) {
> -		int i;
> -
> -		for (i = 0; i < len; i++) {
> -			char c;
> -
> -			/* In case it was set long ago */
> -			wdt->flags &= ~TS72XX_WDT_EXPECT_CLOSE_FLAG;
> -
> -			if (get_user(c, data + i)) {
> -				mutex_unlock(&wdt->lock);
> -				return -EFAULT;
> -			}
> -			if (c == 'V') {
> -				wdt->flags |= TS72XX_WDT_EXPECT_CLOSE_FLAG;
> -				break;
> -			}
> -		}
> -	}
> -
> -	mutex_unlock(&wdt->lock);
> -	return len;
> -}
> +	struct ts72xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
>  
> -static const struct watchdog_info winfo = {
> -	.options		= WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
> -				  WDIOF_MAGICCLOSE,
> -	.firmware_version	= 1,
> -	.identity		= "TS-72XX WDT",
> -};
> -
> -static long ts72xx_wdt_ioctl(struct file *file, unsigned int cmd,
> -			     unsigned long arg)
> -{
> -	struct ts72xx_wdt *wdt = file->private_data;
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = (int __user *)argp;
> -	int error = 0;
> -
> -	if (mutex_lock_interruptible(&wdt->lock))
> -		return -ERESTARTSYS;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		if (copy_to_user(argp, &winfo, sizeof(winfo)))
> -			error = -EFAULT;
> +	switch (to) {
> +	case 1:
> +		priv->regval = TS72XX_WDT_CTRL_1SEC;
>  		break;
> -
> -	case WDIOC_GETSTATUS:
> -	case WDIOC_GETBOOTSTATUS:
> -		error = put_user(0, p);
> +	case 2:
> +		priv->regval = TS72XX_WDT_CTRL_2SEC;
>  		break;
> -
> -	case WDIOC_KEEPALIVE:
> -		ts72xx_wdt_kick(wdt);
> +	case 4:
> +		priv->regval = TS72XX_WDT_CTRL_4SEC;
>  		break;
> -
> -	case WDIOC_SETOPTIONS: {
> -		int options;
> -
> -		error = get_user(options, p);
> -		if (error)
> -			break;
> -
> -		error = -EINVAL;
> -
> -		if ((options & WDIOS_DISABLECARD) != 0) {
> -			ts72xx_wdt_stop(wdt);
> -			error = 0;
> -		}
> -		if ((options & WDIOS_ENABLECARD) != 0) {
> -			ts72xx_wdt_start(wdt);
> -			error = 0;
> -		}
> -
> +	case 8:
> +		priv->regval = TS72XX_WDT_CTRL_8SEC;
>  		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> -	case WDIOC_SETTIMEOUT: {
> -		int new_timeout;
> -		int regval;
> -
> -		error = get_user(new_timeout, p);
> -		if (error)
> -			break;
> -
> -		regval = timeout_to_regval(new_timeout);
> -		if (regval < 0) {
> -			error = regval;
> -			break;
> -		}
> -		ts72xx_wdt_stop(wdt);
> -		wdt->regval = regval;
> -		ts72xx_wdt_start(wdt);
> -
> -		/*FALLTHROUGH*/
> -	}
> -
> -	case WDIOC_GETTIMEOUT:
> -		error = put_user(regval_to_timeout(wdt->regval), p);
> -		break;
> +	wdd->timeout = to;
>  
> -	default:
> -		error = -ENOTTY;
> -		break;
> +	if (watchdog_active(wdd)) {
> +		ts72xx_wdt_stop(wdd);
> +		ts72xx_wdt_start(wdd);
>  	}
>  
> -	mutex_unlock(&wdt->lock);
> -	return error;
> +	return 0;
>  }
>  
> -static const struct file_operations ts72xx_wdt_fops = {
> -	.owner		= THIS_MODULE,
> -	.llseek		= no_llseek,
> -	.open		= ts72xx_wdt_open,
> -	.release	= ts72xx_wdt_release,
> -	.write		= ts72xx_wdt_write,
> -	.unlocked_ioctl	= ts72xx_wdt_ioctl,
> +static const struct watchdog_info ts72xx_wdt_ident = {
> +	.options		= WDIOF_KEEPALIVEPING |
> +				  WDIOF_SETTIMEOUT |
> +				  WDIOF_MAGICCLOSE,
> +	.firmware_version	= 1,
> +	.identity		= "TS-72XX WDT",
>  };
>  
> -static struct miscdevice ts72xx_wdt_miscdev = {
> -	.minor		= WATCHDOG_MINOR,
> -	.name		= "watchdog",
> -	.fops		= &ts72xx_wdt_fops,
> +static struct watchdog_ops ts72xx_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= ts72xx_wdt_start,
> +	.stop		= ts72xx_wdt_stop,
> +	.ping		= ts72xx_wdt_ping,
> +	.set_timeout	= ts72xx_wdt_settimeout,
>  };
>  
>  static int ts72xx_wdt_probe(struct platform_device *pdev)
>  {
> -	struct ts72xx_wdt *wdt;
> -	struct resource *r1, *r2;
> -	int error = 0;
> +	struct ts72xx_wdt_priv *priv;
> +	struct watchdog_device *wdd;
> +	struct resource *res;
> +	int ret;
>  
> -	wdt = devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_wdt), GFP_KERNEL);
> -	if (!wdt)
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
>  		return -ENOMEM;
>  
> -	r1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	wdt->control_reg = devm_ioremap_resource(&pdev->dev, r1);
> -	if (IS_ERR(wdt->control_reg))
> -		return PTR_ERR(wdt->control_reg);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->control_reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->control_reg))
> +		return PTR_ERR(priv->control_reg);
>  
> -	r2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	wdt->feed_reg = devm_ioremap_resource(&pdev->dev, r2);
> -	if (IS_ERR(wdt->feed_reg))
> -		return PTR_ERR(wdt->feed_reg);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	priv->feed_reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->feed_reg))
> +		return PTR_ERR(priv->feed_reg);
>  
> -	platform_set_drvdata(pdev, wdt);
> -	ts72xx_wdt_pdev = pdev;
> -	wdt->pdev = pdev;
> -	mutex_init(&wdt->lock);
> +	wdd = &priv->wdd;
> +	wdd->info = &ts72xx_wdt_ident;
> +	wdd->ops = &ts72xx_wdt_ops;
> +	wdd->min_timeout = 1;
> +	wdd->max_timeout = 8;

With such a low maximum timeout, it might make sense to use the core
to be able to support larger timeouts.

> +	wdd->timeout = 8;
> +	wdd->parent = &pdev->dev;
>  
> -	/* make sure that the watchdog is disabled */
> -	ts72xx_wdt_stop(wdt);

Are you sure this is no longer needed ? If there is a means to detect if the
watchdog is running, it might make sense to set the WDOG_HW_RUNNING flag instead
if it is running and let the core handle the ping until the watchdog device
is opened.

> +	watchdog_set_nowayout(wdd, nowayout);
>  
> -	error = misc_register(&ts72xx_wdt_miscdev);
> -	if (error) {
> -		dev_err(&pdev->dev, "failed to register miscdev\n");
> -		return error;
> -	}
> +	watchdog_set_drvdata(wdd, priv);
> +
> +	ret = watchdog_register_device(wdd);

devm_watchdog_register_device() ?

> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, priv);
>  
>  	dev_info(&pdev->dev, "TS-72xx Watchdog driver\n");
>  
> @@ -428,7 +164,10 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
>  
>  static int ts72xx_wdt_remove(struct platform_device *pdev)
>  {
> -	misc_deregister(&ts72xx_wdt_miscdev);
> +	struct ts72xx_wdt_priv *priv = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&priv->wdd);
> +
>  	return 0;
>  }
>  
> -- 
> 2.10.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
