Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from marvin.crapouillou.net ([109.190.12.102]:55754 "EHLO
	marvin.crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab2AVRG5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Jan 2012 12:06:57 -0500
Message-ID: <4F1C3CF4.1000408@crapouillou.net>
Date: Sun, 22 Jan 2012 17:44:36 +0100
From: Paul Cercueil <paul@crapouillou.net>
MIME-Version: 1.0
To: Axel Lin <axel.lin@gmail.com>
CC: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [RFC][PATCH] watchdog: Convert jz4740_wdt driver to watchdog
 core
References: <1327067054.15205.6.camel@phoenix>
In-Reply-To: <1327067054.15205.6.camel@phoenix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Le 20/01/2012 14:44, Axel Lin a =E9crit :
> This patch converts jz4740_wdt driver to use watchdog core APIs.
> Also use devm_* APIs to save a few error handling code.
>
> Signed-off-by: Axel Lin<axel.lin@gmail.com>
> ---
> Hi Paul and Lars,
> I don't have this hardware handy.
> I'd appreciate if you can review and test this patch.
>
> Thanks,
> Axel

Acked-by: Paul Cercueil <paul@crapouillou.net>

I just tested on hardware, it works fine.
Thanks for the patch.


>
>   drivers/watchdog/Kconfig      |    1 +
>   drivers/watchdog/jz4740_wdt.c |  250 ++++++++++++++------------------=
---------
>   2 files changed, 86 insertions(+), 165 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 877b107..32d48b8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -955,6 +955,7 @@ config INDYDOG
>   config JZ4740_WDT
>   	tristate "Ingenic jz4740 SoC hardware watchdog"
>   	depends on MACH_JZ4740
> +	select WATCHDOG_CORE
>   	help
>   	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 =
SoCs.
>
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wd=
t.c
> index 17ef300..2cdb67f 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -17,11 +17,9 @@
>   #include<linux/moduleparam.h>
>   #include<linux/types.h>
>   #include<linux/kernel.h>
> -#include<linux/fs.h>
>   #include<linux/miscdevice.h>
>   #include<linux/watchdog.h>
>   #include<linux/init.h>
> -#include<linux/bitops.h>
>   #include<linux/platform_device.h>
>   #include<linux/spinlock.h>
>   #include<linux/uaccess.h>
> @@ -29,6 +27,7 @@
>   #include<linux/device.h>
>   #include<linux/clk.h>
>   #include<linux/slab.h>
> +#include<linux/err.h>
>
>   #include<asm/mach-jz4740/timer.h>
>
> @@ -56,30 +55,45 @@
>   #define DEFAULT_HEARTBEAT 5
>   #define MAX_HEARTBEAT     2048
>
> -static struct {
> -	void __iomem *base;
> -	struct resource	*mem;
> -	struct clk *rtc_clk;
> -	unsigned long status;
> -} jz4740_wdt;
> +static int nowayout =3D WATCHDOG_NOWAYOUT;
> +module_param(nowayout, int, 0);
> +MODULE_PARM_DESC(nowayout,
> +		 "Watchdog cannot be stopped once started (default=3D"
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>
>   static int heartbeat =3D DEFAULT_HEARTBEAT;
> +module_param(heartbeat, int, 0);
> +MODULE_PARM_DESC(heartbeat,
> +		"Watchdog heartbeat period in seconds from 1 to "
> +		__MODULE_STRING(MAX_HEARTBEAT) ", default "
> +		__MODULE_STRING(DEFAULT_HEARTBEAT));
>
> +struct jz4740_wdt_drvdata {
> +	struct watchdog_device wdt;
> +	void __iomem *base;
> +	struct resource	*mem;
> +	struct clk *rtc_clk;
> +};
>
> -static void jz4740_wdt_service(void)
> +static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
>   {
> -	writew(0x0, jz4740_wdt.base + JZ_REG_WDT_TIMER_COUNTER);
> +	struct jz4740_wdt_drvdata *drvdata =3D watchdog_get_drvdata(wdt_dev);
> +
> +	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
> +	return 0;
>   }
>
> -static void jz4740_wdt_set_heartbeat(int new_heartbeat)
> +static int jz4740_wdt_set_heartbeat(struct watchdog_device *wdt_dev,
> +				    unsigned int new_heartbeat)
>   {
> +	struct jz4740_wdt_drvdata *drvdata =3D watchdog_get_drvdata(wdt_dev);
>   	unsigned int rtc_clk_rate;
>   	unsigned int timeout_value;
>   	unsigned short clock_div =3D JZ_WDT_CLOCK_DIV_1;
>
>   	heartbeat =3D new_heartbeat;
>
> -	rtc_clk_rate =3D clk_get_rate(jz4740_wdt.rtc_clk);
> +	rtc_clk_rate =3D clk_get_rate(drvdata->rtc_clk);
>
>   	timeout_value =3D rtc_clk_rate * heartbeat;
>   	while (timeout_value>  0xffff) {
> @@ -93,199 +107,112 @@ static void jz4740_wdt_set_heartbeat(int new_hea=
rtbeat)
>   		clock_div +=3D (1<<  JZ_WDT_CLOCK_DIV_SHIFT);
>   	}
>
> -	writeb(0x0, jz4740_wdt.base + JZ_REG_WDT_COUNTER_ENABLE);
> -	writew(clock_div, jz4740_wdt.base + JZ_REG_WDT_TIMER_CONTROL);
> +	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	writew(clock_div, drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
>
> -	writew((u16)timeout_value, jz4740_wdt.base + JZ_REG_WDT_TIMER_DATA);
> -	writew(0x0, jz4740_wdt.base + JZ_REG_WDT_TIMER_COUNTER);
> +	writew((u16)timeout_value, drvdata->base + JZ_REG_WDT_TIMER_DATA);
> +	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
>   	writew(clock_div | JZ_WDT_CLOCK_RTC,
> -		jz4740_wdt.base + JZ_REG_WDT_TIMER_CONTROL);
> -
> -	writeb(0x1, jz4740_wdt.base + JZ_REG_WDT_COUNTER_ENABLE);
> -}
> +		drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
>
> -static void jz4740_wdt_enable(void)
> -{
> -	jz4740_timer_enable_watchdog();
> -	jz4740_wdt_set_heartbeat(heartbeat);
> -}
> +	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
>
> -static void jz4740_wdt_disable(void)
> -{
> -	jz4740_timer_disable_watchdog();
> -	writeb(0x0, jz4740_wdt.base + JZ_REG_WDT_COUNTER_ENABLE);
> +	return 0;
>   }
>
> -static int jz4740_wdt_open(struct inode *inode, struct file *file)
> +static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
>   {
> -	if (test_and_set_bit(WDT_IN_USE,&jz4740_wdt.status))
> -		return -EBUSY;
> -
> -	jz4740_wdt_enable();
> +	jz4740_timer_enable_watchdog();
> +	jz4740_wdt_set_heartbeat(wdt_dev, heartbeat);
>
> -	return nonseekable_open(inode, file);
> +	return 0;
>   }
>
> -static ssize_t jz4740_wdt_write(struct file *file, const char *data,
> -		size_t len, loff_t *ppos)
> +static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>   {
> -	if (len) {
> -		size_t i;
> -
> -		clear_bit(WDT_OK_TO_CLOSE,&jz4740_wdt.status);
> -		for (i =3D 0; i !=3D len; i++) {
> -			char c;
> +	struct jz4740_wdt_drvdata *drvdata =3D watchdog_get_drvdata(wdt_dev);
>
> -			if (get_user(c, data + i))
> -				return -EFAULT;
> -
> -			if (c =3D=3D 'V')
> -				set_bit(WDT_OK_TO_CLOSE,&jz4740_wdt.status);
> -		}
> -		jz4740_wdt_service();
> -	}
> +	jz4740_timer_disable_watchdog();
> +	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
>
> -	return len;
> +	return 0;
>   }
>
> -static const struct watchdog_info ident =3D {
> -	.options =3D WDIOF_KEEPALIVEPING,
> +static const struct watchdog_info jz4740_wdt_info =3D {
> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOS=
E,
>   	.identity =3D "jz4740 Watchdog",
>   };
>
> -static long jz4740_wdt_ioctl(struct file *file,
> -					unsigned int cmd, unsigned long arg)
> -{
> -	int ret =3D -ENOTTY;
> -	int heartbeat_seconds;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		ret =3D copy_to_user((struct watchdog_info *)arg,&ident,
> -				sizeof(ident)) ? -EFAULT : 0;
> -		break;
> -
> -	case WDIOC_GETSTATUS:
> -	case WDIOC_GETBOOTSTATUS:
> -		ret =3D put_user(0, (int *)arg);
> -		break;
> -
> -	case WDIOC_KEEPALIVE:
> -		jz4740_wdt_service();
> -		return 0;
> -
> -	case WDIOC_SETTIMEOUT:
> -		if (get_user(heartbeat_seconds, (int __user *)arg))
> -			return -EFAULT;
> -
> -		jz4740_wdt_set_heartbeat(heartbeat_seconds);
> -		return 0;
> -
> -	case WDIOC_GETTIMEOUT:
> -		return put_user(heartbeat, (int *)arg);
> -
> -	default:
> -		break;
> -	}
> -
> -	return ret;
> -}
> -
> -static int jz4740_wdt_release(struct inode *inode, struct file *file)
> -{
> -	jz4740_wdt_service();
> -
> -	if (test_and_clear_bit(WDT_OK_TO_CLOSE,&jz4740_wdt.status))
> -		jz4740_wdt_disable();
> -
> -	clear_bit(WDT_IN_USE,&jz4740_wdt.status);
> -	return 0;
> -}
> -
> -static const struct file_operations jz4740_wdt_fops =3D {
> +static const struct watchdog_ops jz4740_wdt_ops =3D {
>   	.owner =3D THIS_MODULE,
> -	.llseek =3D no_llseek,
> -	.write =3D jz4740_wdt_write,
> -	.unlocked_ioctl =3D jz4740_wdt_ioctl,
> -	.open =3D jz4740_wdt_open,
> -	.release =3D jz4740_wdt_release,
> -};
> -
> -static struct miscdevice jz4740_wdt_miscdev =3D {
> -	.minor =3D WATCHDOG_MINOR,
> -	.name =3D "watchdog",
> -	.fops =3D&jz4740_wdt_fops,
> +	.start =3D jz4740_wdt_start,
> +	.stop =3D jz4740_wdt_stop,
> +	.ping =3D jz4740_wdt_ping,
> +	.set_timeout =3D jz4740_wdt_set_heartbeat,
>   };
>
>   static int __devinit jz4740_wdt_probe(struct platform_device *pdev)
>   {
> -	int ret =3D 0, size;
> -	struct resource *res;
> -	struct device *dev =3D&pdev->dev;
> -
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res =3D=3D NULL) {
> -		dev_err(dev, "failed to get memory region resource\n");
> -		return -ENXIO;
> +	struct jz4740_wdt_drvdata *drvdata;
> +	struct watchdog_device *jz4740_wdt;
> +	int ret;
> +
> +	drvdata =3D devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata=
),
> +			       GFP_KERNEL);
> +	if (!drvdata) {
> +		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
> +		return -ENOMEM;
>   	}
>
> -	size =3D resource_size(res);
> -	jz4740_wdt.mem =3D request_mem_region(res->start, size, pdev->name);
> -	if (jz4740_wdt.mem =3D=3D NULL) {
> -		dev_err(dev, "failed to get memory region\n");
> -		return -EBUSY;
> +	jz4740_wdt =3D&drvdata->wdt;
> +	jz4740_wdt->info =3D&jz4740_wdt_info;
> +	jz4740_wdt->ops =3D&jz4740_wdt_ops;
> +	watchdog_set_nowayout(jz4740_wdt, nowayout);
> +	watchdog_set_drvdata(jz4740_wdt, drvdata);
> +
> +	drvdata->mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (drvdata->mem =3D=3D NULL) {
> +		dev_err(&pdev->dev, "failed to get memory region resource\n");
> +		return -ENXIO;
>   	}
>
> -	jz4740_wdt.base =3D ioremap_nocache(res->start, size);
> -	if (jz4740_wdt.base =3D=3D NULL) {
> -		dev_err(dev, "failed to map memory region\n");
> +	drvdata->base =3D devm_request_and_ioremap(&pdev->dev, drvdata->mem);
> +	if (drvdata->base =3D=3D NULL) {
>   		ret =3D -EBUSY;
> -		goto err_release_region;
> +		goto err_out;
>   	}
>
> -	jz4740_wdt.rtc_clk =3D clk_get(NULL, "rtc");
> -	if (IS_ERR(jz4740_wdt.rtc_clk)) {
> -		dev_err(dev, "cannot find RTC clock\n");
> -		ret =3D PTR_ERR(jz4740_wdt.rtc_clk);
> -		goto err_iounmap;
> +	drvdata->rtc_clk =3D clk_get(NULL, "rtc");
> +	if (IS_ERR(drvdata->rtc_clk)) {
> +		dev_err(&pdev->dev, "cannot find RTC clock\n");
> +		ret =3D PTR_ERR(drvdata->rtc_clk);
> +		goto err_out;
>   	}
>
> -	ret =3D misc_register(&jz4740_wdt_miscdev);
> -	if (ret<  0) {
> -		dev_err(dev, "cannot register misc device\n");
> +	ret =3D watchdog_register_device(&drvdata->wdt);
> +	if (ret<  0)
>   		goto err_disable_clk;
> -	}
>
> +	platform_set_drvdata(pdev, drvdata);
>   	return 0;
>
>   err_disable_clk:
> -	clk_put(jz4740_wdt.rtc_clk);
> -err_iounmap:
> -	iounmap(jz4740_wdt.base);
> -err_release_region:
> -	release_mem_region(jz4740_wdt.mem->start,
> -			resource_size(jz4740_wdt.mem));
> +	clk_put(drvdata->rtc_clk);
> +err_out:
>   	return ret;
>   }
>
> -
>   static int __devexit jz4740_wdt_remove(struct platform_device *pdev)
>   {
> -	jz4740_wdt_disable();
> -	misc_deregister(&jz4740_wdt_miscdev);
> -	clk_put(jz4740_wdt.rtc_clk);
> -
> -	iounmap(jz4740_wdt.base);
> -	jz4740_wdt.base =3D NULL;
> +	struct jz4740_wdt_drvdata *drvdata =3D platform_get_drvdata(pdev);
>
> -	release_mem_region(jz4740_wdt.mem->start,
> -				resource_size(jz4740_wdt.mem));
> -	jz4740_wdt.mem =3D NULL;
> +	jz4740_wdt_stop(&drvdata->wdt);
> +	watchdog_unregister_device(&drvdata->wdt);
> +	clk_put(drvdata->rtc_clk);
>
>   	return 0;
>   }
>
> -
>   static struct platform_driver jz4740_wdt_driver =3D {
>   	.probe =3D jz4740_wdt_probe,
>   	.remove =3D __devexit_p(jz4740_wdt_remove),
> @@ -299,13 +226,6 @@ module_platform_driver(jz4740_wdt_driver);
>
>   MODULE_AUTHOR("Paul Cercueil<paul@crapouillou.net>");
>   MODULE_DESCRIPTION("jz4740 Watchdog Driver");
> -
> -module_param(heartbeat, int, 0);
> -MODULE_PARM_DESC(heartbeat,
> -		"Watchdog heartbeat period in seconds from 1 to "
> -		__MODULE_STRING(MAX_HEARTBEAT) ", default "
> -		__MODULE_STRING(DEFAULT_HEARTBEAT));
> -
>   MODULE_LICENSE("GPL");
>   MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
>   MODULE_ALIAS("platform:jz4740-wdt");

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
