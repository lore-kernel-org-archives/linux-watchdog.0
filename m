Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48239 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab2GPNKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 Jul 2012 09:10:41 -0400
From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
To: Zumeng Chen <zumeng.chen@windriver.com>,
	"Hilman, Kevin" <khilman@ti.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti@ti.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "wim@iguana.be" <wim@iguana.be>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"tony@atomide.com" <tony@atomide.com>,
	"paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH RESEND v3 1/3] Watchdog: Omap: Changes for the new
 watchdog framework
Date: Mon, 16 Jul 2012 13:10:04 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA6DFA9@DBDE01.ent.ti.com>
References: <1342338246-29101-1-git-send-email-zumeng.chen@windriver.com>
 <1342338246-29101-2-git-send-email-zumeng.chen@windriver.com>
In-Reply-To: <1342338246-29101-2-git-send-email-zumeng.chen@windriver.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2012 at 13:14:04, Zumeng Chen wrote:
> This patch implements the current watchdog framework for OMAP WDTimer,
> which factored out the common components, so the driver can just focus
> on the hardware related parts.
>=20
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> ---
>  drivers/watchdog/omap_wdt.c |  342 ++++++++++++++++-------------------=
--------
>  drivers/watchdog/omap_wdt.h |    5 +
>  2 files changed, 128 insertions(+), 219 deletions(-)
>=20
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 8285d65..cc5bc3e 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -24,6 +24,9 @@
>   *
>   * Copyright (c) 2005 David Brownell
>   *	Use the driver model and standard identifiers; handle bigger timeou=
ts.
> + *
> + * Copyright (c) 2012 WindRiver
> + *	Changes cater for the current watchdog framework.
>   */
> =20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -33,7 +36,6 @@
>  #include <linux/kernel.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> -#include <linux/miscdevice.h>
>  #include <linux/watchdog.h>
>  #include <linux/reboot.h>
>  #include <linux/init.h>
> @@ -50,8 +52,6 @@
> =20
>  #include "omap_wdt.h"
> =20
> -static struct platform_device *omap_wdt_dev;
> -
>  static unsigned timer_margin;
>  module_param(timer_margin, uint, 0);
>  MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)"=
);
> @@ -59,32 +59,14 @@ MODULE_PARM_DESC(timer_margin, "initial watchdog ti=
meout (in seconds)");
>  static unsigned int wdt_trgr_pattern =3D 0x1234;
>  static DEFINE_SPINLOCK(wdt_lock);
> =20
> -struct omap_wdt_dev {
> +struct omap_wdt_drvdata {
> +	struct watchdog_device wdt;
>  	void __iomem    *base;          /* physical */
>  	struct device   *dev;
> -	int             omap_wdt_users;
>  	struct resource *mem;
> -	struct miscdevice omap_wdt_miscdev;
>  };
> =20
> -static void omap_wdt_ping(struct omap_wdt_dev *wdev)
> -{
> -	void __iomem    *base =3D wdev->base;
> -
> -	/* wait for posted write to complete */
> -	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
> -		cpu_relax();
> -
> -	wdt_trgr_pattern =3D ~wdt_trgr_pattern;
> -	__raw_writel(wdt_trgr_pattern, (base + OMAP_WATCHDOG_TGR));
> -
> -	/* wait for posted write to complete */
> -	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
> -		cpu_relax();
> -	/* reloaded WCRR from WLDR */
> -}
> -
> -static void omap_wdt_enable(struct omap_wdt_dev *wdev)
> +static void omap_wdt_enable(struct omap_wdt_drvdata *wdev)
>  {
>  	void __iomem *base =3D wdev->base;
> =20
> @@ -98,7 +80,7 @@ static void omap_wdt_enable(struct omap_wdt_dev *wdev=
)
>  		cpu_relax();
>  }
> =20
> -static void omap_wdt_disable(struct omap_wdt_dev *wdev)
> +static void omap_wdt_disable(struct omap_wdt_drvdata *wdev)
>  {
>  	void __iomem *base =3D wdev->base;
> =20
> @@ -121,12 +103,19 @@ static void omap_wdt_adjust_timeout(unsigned new_=
timeout)
>  	timer_margin =3D new_timeout;
>  }
> =20
> -static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
> +static int omap_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				    unsigned int new_timeout)
>  {
> -	u32 pre_margin =3D GET_WLDR_VAL(timer_margin);
> -	void __iomem *base =3D wdev->base;
> +	u32 pre_margin;
> +	struct omap_wdt_drvdata *omap_wdev =3D watchdog_get_drvdata(wdt_dev);
> +	void __iomem *base =3D omap_wdev->base;
> =20
> -	pm_runtime_get_sync(wdev->dev);
> +	pm_runtime_get_sync(omap_wdev->dev);
> +	omap_wdt_disable(omap_wdev);
> +
> +	/* adjust timeout based on the new timeout */
> +	omap_wdt_adjust_timeout(new_timeout);
> +	pre_margin =3D GET_WLDR_VAL(timer_margin);
> =20
>  	/* just count up at 32 KHz */
>  	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
> @@ -136,147 +125,88 @@ static void omap_wdt_set_timeout(struct omap_wdt=
_dev *wdev)
>  	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
>  		cpu_relax();
> =20
> -	pm_runtime_put_sync(wdev->dev);
> +	omap_wdt_enable(omap_wdev);
> +	wdt_dev->timeout =3D new_timeout;
> +	pm_runtime_put_sync(omap_wdev->dev);
> +	return 0;
>  }
> =20
> -/*
> - *	Allow only one task to hold it open
> - */
> -static int omap_wdt_open(struct inode *inode, struct file *file)
> +static int omap_wdt_ping(struct watchdog_device *wdt_dev)
>  {
> -	struct omap_wdt_dev *wdev =3D platform_get_drvdata(omap_wdt_dev);
> -	void __iomem *base =3D wdev->base;
> -
> -	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
> -		return -EBUSY;
> -
> -	pm_runtime_get_sync(wdev->dev);
> +	struct omap_wdt_drvdata *omap_wdev =3D watchdog_get_drvdata(wdt_dev);
> +	void __iomem    *base =3D omap_wdev->base;
> =20
> -	/* initialize prescaler */
> -	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
> -		cpu_relax();
> +	pm_runtime_get_sync(omap_wdev->dev);
> +	spin_lock(&wdt_lock);
> =20
> -	__raw_writel((1 << 5) | (PTV << 2), base + OMAP_WATCHDOG_CNTRL);
> -	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
> +	/* wait for posted write to complete */
> +	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
>  		cpu_relax();
> =20
> -	file->private_data =3D (void *) wdev;
> +	wdt_trgr_pattern =3D ~wdt_trgr_pattern;
> +	__raw_writel(wdt_trgr_pattern, (base + OMAP_WATCHDOG_TGR));
> =20
> -	omap_wdt_set_timeout(wdev);
> -	omap_wdt_ping(wdev); /* trigger loading of new timeout value */
> -	omap_wdt_enable(wdev);
> +	/* wait for posted write to complete */
> +	/* reloaded WCRR from WLDR */
> +	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
> +		cpu_relax();
> =20
> -	pm_runtime_put_sync(wdev->dev);
> +	spin_unlock(&wdt_lock);
> +	pm_runtime_put_sync(omap_wdev->dev);
> =20
> -	return nonseekable_open(inode, file);
> +	return 0;
>  }
> =20
> -static int omap_wdt_release(struct inode *inode, struct file *file)
> +static int omap_wdt_start(struct watchdog_device *wdt_dev)
>  {
> -	struct omap_wdt_dev *wdev =3D file->private_data;
> +	struct omap_wdt_drvdata *omap_wdev =3D watchdog_get_drvdata(wdt_dev);
> +	void __iomem *base =3D omap_wdev->base;
> =20
> -	/*
> -	 *      Shut off the timer unless NOWAYOUT is defined.
> -	 */
> -#ifndef CONFIG_WATCHDOG_NOWAYOUT
> -	pm_runtime_get_sync(wdev->dev);
> +	pm_runtime_get_sync(omap_wdev->dev);
> +	/* initialize prescaler */
> +	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
> +		cpu_relax();
> =20
> -	omap_wdt_disable(wdev);
> +	__raw_writel((1 << 5) | (PTV << 2), base + OMAP_WATCHDOG_CNTRL);
> +	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
> +		cpu_relax();
> =20
> -	pm_runtime_put_sync(wdev->dev);
> -#else
> -	pr_crit("Unexpected close, not stopping!\n");
> -#endif
> -	wdev->omap_wdt_users =3D 0;
> +	omap_wdt_set_timeout(&omap_wdev->wdt, timer_margin);
> +	pm_runtime_put_sync(omap_wdev->dev);
> =20
>  	return 0;
>  }
> =20
> -static ssize_t omap_wdt_write(struct file *file, const char __user *da=
ta,
> -		size_t len, loff_t *ppos)
> +static int omap_wdt_stop(struct watchdog_device *wdt_dev)
>  {
> -	struct omap_wdt_dev *wdev =3D file->private_data;
> -
> -	/* Refresh LOAD_TIME. */
> -	if (len) {
> -		pm_runtime_get_sync(wdev->dev);
> -		spin_lock(&wdt_lock);
> -		omap_wdt_ping(wdev);
> -		spin_unlock(&wdt_lock);
> -		pm_runtime_put_sync(wdev->dev);
> -	}
> -	return len;
> -}
> +	struct omap_wdt_drvdata *omap_wdev =3D watchdog_get_drvdata(wdt_dev);
> =20
> -static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
> -						unsigned long arg)
> -{
> -	struct omap_wdt_dev *wdev;
> -	int new_margin;
> -	static const struct watchdog_info ident =3D {
> -		.identity =3D "OMAP Watchdog",
> -		.options =3D WDIOF_SETTIMEOUT,
> -		.firmware_version =3D 0,
> -	};
> -
> -	wdev =3D file->private_data;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		return copy_to_user((struct watchdog_info __user *)arg, &ident,
> -				sizeof(ident));
> -	case WDIOC_GETSTATUS:
> -		return put_user(0, (int __user *)arg);
> -	case WDIOC_GETBOOTSTATUS:
> -		if (cpu_is_omap16xx())
> -			return put_user(__raw_readw(ARM_SYSST),
> -					(int __user *)arg);
> -		if (cpu_is_omap24xx())
> -			return put_user(omap_prcm_get_reset_sources(),
> -					(int __user *)arg);
> -		return put_user(0, (int __user *)arg);
> -	case WDIOC_KEEPALIVE:
> -		pm_runtime_get_sync(wdev->dev);
> -		spin_lock(&wdt_lock);
> -		omap_wdt_ping(wdev);
> -		spin_unlock(&wdt_lock);
> -		pm_runtime_put_sync(wdev->dev);
> -		return 0;
> -	case WDIOC_SETTIMEOUT:
> -		if (get_user(new_margin, (int __user *)arg))
> -			return -EFAULT;
> -		omap_wdt_adjust_timeout(new_margin);
> -
> -		pm_runtime_get_sync(wdev->dev);
> -		spin_lock(&wdt_lock);
> -		omap_wdt_disable(wdev);
> -		omap_wdt_set_timeout(wdev);
> -		omap_wdt_enable(wdev);
> -
> -		omap_wdt_ping(wdev);
> -		spin_unlock(&wdt_lock);
> -		pm_runtime_put_sync(wdev->dev);
> -		/* Fall */
> -	case WDIOC_GETTIMEOUT:
> -		return put_user(timer_margin, (int __user *)arg);
> -	default:
> -		return -ENOTTY;
> -	}
> +	pm_runtime_get_sync(omap_wdev->dev);
> +	omap_wdt_disable(omap_wdev);
> +	pm_runtime_put_sync(omap_wdev->dev);
> +
> +	return 0;
>  }
> =20
> -static const struct file_operations omap_wdt_fops =3D {
> +static const struct watchdog_ops omap_wdt_ops =3D {
>  	.owner =3D THIS_MODULE,
> -	.write =3D omap_wdt_write,
> -	.unlocked_ioctl =3D omap_wdt_ioctl,
> -	.open =3D omap_wdt_open,
> -	.release =3D omap_wdt_release,
> -	.llseek =3D no_llseek,
> +	.start =3D omap_wdt_start,
> +	.stop =3D omap_wdt_stop,
> +	.ping =3D omap_wdt_ping,
> +	.set_timeout =3D omap_wdt_set_timeout,
> +};
> +
> +static const struct watchdog_info omap_wdt_info =3D {
> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPIN=
G |
> +		   WDIOF_CARDRESET,
> +	.identity =3D "Omap Watchdog",
>  };
> =20
>  static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  {
> +	struct omap_wdt_drvdata *omap_drvdata;
> +	struct watchdog_device *omap_wdev;
>  	struct resource *res, *mem;
> -	struct omap_wdt_dev *wdev;
>  	int ret;
> =20
>  	/* reserve static register mappings */
> @@ -286,68 +216,62 @@ static int __devinit omap_wdt_probe(struct platfo=
rm_device *pdev)
>  		goto err_get_resource;
>  	}
> =20
> -	if (omap_wdt_dev) {
> -		ret =3D -EBUSY;
> -		goto err_busy;
> -	}
> -
>  	mem =3D request_mem_region(res->start, resource_size(res), pdev->name=
);
>  	if (!mem) {
>  		ret =3D -EBUSY;
>  		goto err_busy;
>  	}
> =20
> -	wdev =3D kzalloc(sizeof(struct omap_wdt_dev), GFP_KERNEL);
> -	if (!wdev) {
> +	omap_drvdata =3D devm_kzalloc(&pdev->dev, sizeof(struct omap_wdt_drvd=
ata),
> +			       GFP_KERNEL);
> +	if (!omap_drvdata) {
> +		dev_err(&pdev->dev, "Unable to allocate watchdog device\n");
>  		ret =3D -ENOMEM;
>  		goto err_kzalloc;
>  	}
> =20
> -	wdev->omap_wdt_users =3D 0;
> -	wdev->mem =3D mem;
> -	wdev->dev =3D &pdev->dev;
> +	omap_drvdata->dev =3D &pdev->dev;
> +	omap_wdev =3D &omap_drvdata->wdt;
> +	omap_wdev->info =3D &omap_wdt_info;
> +	omap_wdev->ops =3D &omap_wdt_ops;
> +	omap_wdev->timeout =3D TIMER_MARGIN_DEFAULT;
> +	omap_wdev->min_timeout =3D 1;
> +	omap_wdev->max_timeout =3D TIMER_MARGIN_MAX;
> +#ifdef CONFIG_WATCHDOG_NOWAYOUT
> +	watchdog_set_nowayout(omap_wdev, true);
> +#endif
> +	watchdog_set_drvdata(omap_wdev, omap_drvdata);
> =20
> -	wdev->base =3D ioremap(res->start, resource_size(res));
> -	if (!wdev->base) {
> +	omap_drvdata->base =3D ioremap(res->start, resource_size(res));
> +	if (!omap_drvdata->base) {
>  		ret =3D -ENOMEM;
> -		goto err_ioremap;
> +		goto err_kzalloc;
>  	}
> =20
> -	platform_set_drvdata(pdev, wdev);
> -
> -	pm_runtime_enable(wdev->dev);
> -	pm_runtime_get_sync(wdev->dev);
> -
> -	omap_wdt_disable(wdev);
> -	omap_wdt_adjust_timeout(timer_margin);
> -
> -	wdev->omap_wdt_miscdev.parent =3D &pdev->dev;
> -	wdev->omap_wdt_miscdev.minor =3D WATCHDOG_MINOR;
> -	wdev->omap_wdt_miscdev.name =3D "watchdog";
> -	wdev->omap_wdt_miscdev.fops =3D &omap_wdt_fops;
> -
> -	ret =3D misc_register(&(wdev->omap_wdt_miscdev));
> -	if (ret)
> -		goto err_misc;
> -
> -	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
> -		__raw_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
> -		timer_margin);
> -
> -	pm_runtime_put_sync(wdev->dev);
> -
> -	omap_wdt_dev =3D pdev;
> +	ret =3D watchdog_register_device(&omap_drvdata->wdt);
> +	if (ret < 0)
> +		goto err_register_wd;
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +	omap_wdt_disable(omap_drvdata);
> +	pm_runtime_put_sync(&pdev->dev);
> +	platform_set_drvdata(pdev, omap_drvdata);
> +
> +	/* For omap16xx we just keep it original as-is */
> +	if (cpu_is_omap16xx())
> +		omap_wdev->bootstatus =3D __raw_readw(ARM_SYSST);
> +	else
> +		omap_wdev->bootstatus =3D (omap_prcm_get_reset_sources() & 0x10)
> +					 >> OMAP3_PRM_RSTST_WD_BIT;

CPU check is really not receommended in driver, you should avoid this.
I understand that, driver was already doing this, but can this be handled=
 by=20
IP rev? if not, you may want to use pdata for this.

Also I understand that, this is tied to prcm code base as far as omap2 is=
 concerned. May be Tony or others can comment on this.

Thanks,
Vaibhav

> +	pr_info("OMAP WDTimer Rev 0x%02x: Initial timeout %dsec status=3D 0x%=
x\n",
> +		 __raw_readl(omap_drvdata->base + OMAP_WATCHDOG_REV)
> +		 & 0xFF, timer_margin, omap_wdev->bootstatus);
> =20
>  	return 0;
> =20
> -err_misc:
> -	pm_runtime_disable(wdev->dev);
> -	platform_set_drvdata(pdev, NULL);
> -	iounmap(wdev->base);
> -
> -err_ioremap:
> -	wdev->base =3D NULL;
> -	kfree(wdev);
> +err_register_wd:
> +	iounmap(omap_drvdata->base);
> =20
>  err_kzalloc:
>  	release_mem_region(res->start, resource_size(res));
> @@ -358,34 +282,17 @@ err_get_resource:
>  	return ret;
>  }
> =20
> -static void omap_wdt_shutdown(struct platform_device *pdev)
> -{
> -	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
> -
> -	if (wdev->omap_wdt_users) {
> -		pm_runtime_get_sync(wdev->dev);
> -		omap_wdt_disable(wdev);
> -		pm_runtime_put_sync(wdev->dev);
> -	}
> -}
> -
>  static int __devexit omap_wdt_remove(struct platform_device *pdev)
>  {
> -	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
> +	struct omap_wdt_drvdata *omap_wdev =3D platform_get_drvdata(pdev);
>  	struct resource *res =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
> =20
> -	pm_runtime_disable(wdev->dev);
> -	if (!res)
> -		return -ENOENT;
> +	pm_runtime_disable(&pdev->dev);
> =20
> -	misc_deregister(&(wdev->omap_wdt_miscdev));
>  	release_mem_region(res->start, resource_size(res));
>  	platform_set_drvdata(pdev, NULL);
> =20
> -	iounmap(wdev->base);
> -
> -	kfree(wdev);
> -	omap_wdt_dev =3D NULL;
> +	iounmap(omap_wdev->base);
> =20
>  	return 0;
>  }
> @@ -400,12 +307,12 @@ static int __devexit omap_wdt_remove(struct platf=
orm_device *pdev)
> =20
>  static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t=
 state)
>  {
> -	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
> +	struct omap_wdt_drvdata *omap_wdev =3D platform_get_drvdata(pdev);
> =20
> -	if (wdev->omap_wdt_users) {
> -		pm_runtime_get_sync(wdev->dev);
> -		omap_wdt_disable(wdev);
> -		pm_runtime_put_sync(wdev->dev);
> +	if (test_bit(WDOG_DEV_OPEN, &omap_wdev->wdt.status)) {
> +		pm_runtime_get_sync(&pdev->dev);
> +		omap_wdt_disable(omap_wdev);
> +		pm_runtime_put_sync(&pdev->dev);
>  	}
> =20
>  	return 0;
> @@ -413,13 +320,12 @@ static int omap_wdt_suspend(struct platform_devic=
e *pdev, pm_message_t state)
> =20
>  static int omap_wdt_resume(struct platform_device *pdev)
>  {
> -	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
> -
> -	if (wdev->omap_wdt_users) {
> -		pm_runtime_get_sync(wdev->dev);
> -		omap_wdt_enable(wdev);
> -		omap_wdt_ping(wdev);
> -		pm_runtime_put_sync(wdev->dev);
> +	struct omap_wdt_drvdata *omap_wdev =3D platform_get_drvdata(pdev);
> +	if (test_bit(WDOG_DEV_OPEN, &omap_wdev->wdt.status)) {
> +		pm_runtime_get_sync(&pdev->dev);
> +		omap_wdt_enable(omap_wdev);
> +		omap_wdt_ping(&omap_wdev->wdt);
> +		pm_runtime_put_sync(&pdev->dev);
>  	}
> =20
>  	return 0;
> @@ -433,7 +339,6 @@ static int omap_wdt_resume(struct platform_device *=
pdev)
>  static struct platform_driver omap_wdt_driver =3D {
>  	.probe		=3D omap_wdt_probe,
>  	.remove		=3D __devexit_p(omap_wdt_remove),
> -	.shutdown	=3D omap_wdt_shutdown,
>  	.suspend	=3D omap_wdt_suspend,
>  	.resume		=3D omap_wdt_resume,
>  	.driver		=3D {
> @@ -446,5 +351,4 @@ module_platform_driver(omap_wdt_driver);
> =20
>  MODULE_AUTHOR("George G. Davis");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
>  MODULE_ALIAS("platform:omap_wdt");
> diff --git a/drivers/watchdog/omap_wdt.h b/drivers/watchdog/omap_wdt.h
> index 09b774c..cf5f037 100644
> --- a/drivers/watchdog/omap_wdt.h
> +++ b/drivers/watchdog/omap_wdt.h
> @@ -51,4 +51,9 @@
>  #define PTV			0	/* prescale */
>  #define GET_WLDR_VAL(secs)	(0xffffffff - ((secs) * (32768/(1<<PTV))) +=
 1)
> =20
> +/* MPU_WD_RST bit in PRM_RSTST show Omap WDTimer reset event.
> + * 0x0 =3D 0x0 : No watchdog reset.
> + * 0x1 =3D 0x1 : watchdog reset has occurred. */
> +#define OMAP3_PRM_RSTST_WD_BIT		4
> +
>  #endif				/* _OMAP_WATCHDOG_H */
> --=20
> 1.7.5.4
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
