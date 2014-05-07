Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-by2lp0235.outbound.protection.outlook.com ([207.46.163.235]:41872
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754889AbaEGBcU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 6 May 2014 21:32:20 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Anatolij Gustschin <agust@denx.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Wolfram Sang <wsa@the-dreams.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: RE: [PATCH v2] watchdog: imx2_wdt: convert to watchdog core api
Date: Wed, 7 May 2014 01:32:16 +0000
Message-ID: <68a00ade5d044b23a4b2f9439740967e@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1397199434-6551-1-git-send-email-agust@denx.de>
 <20140507013302.2f0ef27c@crub>
In-Reply-To: <20140507013302.2f0ef27c@crub>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

> Subject: Re: [PATCH v2] watchdog: imx2_wdt: convert to watchdog core ap=
i
>=20
> On Fri, 11 Apr 2014 08:57:14 +0200
> Anatolij Gustschin <agust@denx.de> wrote:
>=20
> > Convert the imx2_wdt driver to the new watchdog core api.
> >
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
>=20
> Ping. Will this patch be queued for next?
>=20

@Anatolij,

Not yet...

And the newest version is v5.

@Wim,

Ping :)

Thanks,

BRs
Xiubo








> Thanks,
>=20
> Anatolij
>=20
> > ---
> > NOTE: This patch applies on top of the imx2_wdt regmap-mmio support
> > patch series http://comments.gmane.org/gmane.linux.kernel/1677735
> >
> > Changes since first version:
> >  - simplify return in imx2_wdt_is_running()
> >  - fix "WARNING: quoted string split across lines"
> >
> >  drivers/watchdog/Kconfig    |    1 +
> >  drivers/watchdog/imx2_wdt.c |  292 ++++++++++++++++++---------------=
-------
> ---
> >  2 files changed, 123 insertions(+), 170 deletions(-)
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index f2a15f4..5e78c77c 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -379,6 +379,7 @@ config IMX2_WDT
> >  	tristate "IMX2+ Watchdog"
> >  	depends on ARCH_MXC
> >  	select REGMAP_MMIO
> > +	select WATCHDOG_CORE
> >  	help
> >  	  This is the driver for the hardware watchdog
> >  	  on the Freescale IMX2 and later processors.
> > diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.=
c
> > index 76fa724..9d4874f 100644
> > --- a/drivers/watchdog/imx2_wdt.c
> > +++ b/drivers/watchdog/imx2_wdt.c
> > @@ -22,18 +22,15 @@
> >   */
> >
> >  #include <linux/clk.h>
> > -#include <linux/fs.h>
> >  #include <linux/init.h>
> >  #include <linux/io.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> > -#include <linux/miscdevice.h>
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/timer.h>
> > -#include <linux/uaccess.h>
> >  #include <linux/watchdog.h>
> >
> >  #define DRIVER_NAME "imx2-wdt"
> > @@ -56,19 +53,12 @@
> >
> >  #define WDOG_SEC_TO_COUNT(s)	((s * 2 - 1) << 8)
> >
> > -#define IMX2_WDT_STATUS_OPEN	0
> > -#define IMX2_WDT_STATUS_STARTED	1
> > -#define IMX2_WDT_EXPECT_CLOSE	2
> > -
> > -static struct {
> > +struct imx2_wdt_device {
> >  	struct clk *clk;
> >  	struct regmap *regmap;
> > -	unsigned timeout;
> > -	unsigned long status;
> >  	struct timer_list timer;	/* Pings the watchdog when closed */
> > -} imx2_wdt;
> > -
> > -static struct miscdevice imx2_wdt_miscdev;
> > +	struct watchdog_device wdog;
> > +};
> >
> >  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> >  module_param(nowayout, bool, 0);
> > @@ -86,11 +76,12 @@ static const struct watchdog_info imx2_wdt_info =3D=
 {
> >  	.options =3D WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCL=
OSE,
> >  };
> >
> > -static inline void imx2_wdt_setup(void)
> > +static inline void imx2_wdt_setup(struct watchdog_device *wdog)
> >  {
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> >  	u32 val;
> >
> > -	regmap_read(imx2_wdt.regmap, IMX2_WDT_WCR, &val);
> > +	regmap_read(wdev->regmap, IMX2_WDT_WCR, &val);
> >
> >  	/* Suspend timer in low power mode, write once-only */
> >  	val |=3D IMX2_WDT_WCR_WDZST;
> > @@ -101,157 +92,93 @@ static inline void imx2_wdt_setup(void)
> >  	/* Keep Watchdog Disabled */
> >  	val &=3D ~IMX2_WDT_WCR_WDE;
> >  	/* Set the watchdog's Time-Out value */
> > -	val |=3D WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
> > +	val |=3D WDOG_SEC_TO_COUNT(wdog->timeout);
> >
> > -	regmap_write(imx2_wdt.regmap, IMX2_WDT_WCR, val);
> > +	regmap_write(wdev->regmap, IMX2_WDT_WCR, val);
> >
> >  	/* enable the watchdog */
> >  	val |=3D IMX2_WDT_WCR_WDE;
> > -	regmap_write(imx2_wdt.regmap, IMX2_WDT_WCR, val);
> > +	regmap_write(wdev->regmap, IMX2_WDT_WCR, val);
> >  }
> >
> > -static inline void imx2_wdt_ping(void)
> > +static inline bool imx2_wdt_is_running(struct imx2_wdt_device *wdev)
> >  {
> > -	regmap_write(imx2_wdt.regmap, IMX2_WDT_WSR, IMX2_WDT_SEQ1);
> > -	regmap_write(imx2_wdt.regmap, IMX2_WDT_WSR, IMX2_WDT_SEQ2);
> > -}
> > +	u32 val;
> >
> > -static void imx2_wdt_timer_ping(unsigned long arg)
> > -{
> > -	/* ping it every imx2_wdt.timeout / 2 seconds to prevent reboot */
> > -	imx2_wdt_ping();
> > -	mod_timer(&imx2_wdt.timer, jiffies + imx2_wdt.timeout * HZ / 2);
> > +	regmap_read(wdev->regmap, IMX2_WDT_WCR, &val);
> > +
> > +	return val & IMX2_WDT_WCR_WDE;
> >  }
> >
> > -static void imx2_wdt_start(void)
> > +static int imx2_wdt_ping(struct watchdog_device *wdog)
> >  {
> > -	if (!test_and_set_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status)) {
> > -		/* at our first start we enable clock and do initialisations */
> > -		clk_prepare_enable(imx2_wdt.clk);
> > -
> > -		imx2_wdt_setup();
> > -	} else	/* delete the timer that pings the watchdog after close */
> > -		del_timer_sync(&imx2_wdt.timer);
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> >
> > -	/* Watchdog is enabled - time to reload the timeout value */
> > -	imx2_wdt_ping();
> > +	regmap_write(wdev->regmap, IMX2_WDT_WSR, IMX2_WDT_SEQ1);
> > +	regmap_write(wdev->regmap, IMX2_WDT_WSR, IMX2_WDT_SEQ2);
> > +	return 0;
> >  }
> >
> > -static void imx2_wdt_stop(void)
> > +static void imx2_wdt_timer_ping(unsigned long arg)
> >  {
> > -	/* we don't need a clk_disable, it cannot be disabled once started.
> > -	 * We use a timer to ping the watchdog while /dev/watchdog is close=
d */
> > -	imx2_wdt_timer_ping(0);
> > +	struct watchdog_device *wdog =3D (struct watchdog_device *)arg;
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> > +
> > +	/* ping it every wdog->timeout / 2 seconds to prevent reboot */
> > +	imx2_wdt_ping(wdog);
> > +	mod_timer(&wdev->timer, jiffies + wdog->timeout * HZ / 2);
> >  }
> >
> > -static void imx2_wdt_set_timeout(int new_timeout)
> > +static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
> > +				unsigned int new_timeout)
> >  {
> > -	regmap_update_bits(imx2_wdt.regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> > +
> > +	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
> >  			   WDOG_SEC_TO_COUNT(new_timeout));
> > +	return 0;
> >  }
> >
> > -static int imx2_wdt_open(struct inode *inode, struct file *file)
> > +static int imx2_wdt_start(struct watchdog_device *wdog)
> >  {
> > -	if (test_and_set_bit(IMX2_WDT_STATUS_OPEN, &imx2_wdt.status))
> > -		return -EBUSY;
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> >
> > -	imx2_wdt_start();
> > -	return nonseekable_open(inode, file);
> > +	if (imx2_wdt_is_running(wdev)) {
> > +		/* delete the timer that pings the watchdog after close */
> > +		del_timer_sync(&wdev->timer);
> > +		imx2_wdt_set_timeout(wdog, wdog->timeout);
> > +	} else
> > +		imx2_wdt_setup(wdog);
> > +
> > +	return imx2_wdt_ping(wdog);
> >  }
> >
> > -static int imx2_wdt_close(struct inode *inode, struct file *file)
> > +static int imx2_wdt_stop(struct watchdog_device *wdog)
> >  {
> > -	if (test_bit(IMX2_WDT_EXPECT_CLOSE, &imx2_wdt.status) && !nowayout)
> > -		imx2_wdt_stop();
> > -	else {
> > -		dev_crit(imx2_wdt_miscdev.parent,
> > -			"Unexpected close: Expect reboot!\n");
> > -		imx2_wdt_ping();
> > -	}
> > -
> > -	clear_bit(IMX2_WDT_EXPECT_CLOSE, &imx2_wdt.status);
> > -	clear_bit(IMX2_WDT_STATUS_OPEN, &imx2_wdt.status);
> > +	/*
> > +	 * We don't need a clk_disable, it cannot be disabled once started.
> > +	 * We use a timer to ping the watchdog while /dev/watchdog is close=
d
> > +	 */
> > +	imx2_wdt_timer_ping((unsigned long)wdog);
> >  	return 0;
> >  }
> >
> > -static long imx2_wdt_ioctl(struct file *file, unsigned int cmd,
> > -							unsigned long arg)
> > +static inline void imx2_wdt_ping_if_active(struct watchdog_device *w=
dog)
> >  {
> > -	void __user *argp =3D (void __user *)arg;
> > -	int __user *p =3D argp;
> > -	int new_value;
> > -	u32 val;
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> >
> > -	switch (cmd) {
> > -	case WDIOC_GETSUPPORT:
> > -		return copy_to_user(argp, &imx2_wdt_info,
> > -			sizeof(struct watchdog_info)) ? -EFAULT : 0;
> > -
> > -	case WDIOC_GETSTATUS:
> > -		return put_user(0, p);
> > -
> > -	case WDIOC_GETBOOTSTATUS:
> > -		regmap_read(imx2_wdt.regmap, IMX2_WDT_WRSR, &val);
> > -		new_value =3D val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
> > -		return put_user(new_value, p);
> > -
> > -	case WDIOC_KEEPALIVE:
> > -		imx2_wdt_ping();
> > -		return 0;
> > -
> > -	case WDIOC_SETTIMEOUT:
> > -		if (get_user(new_value, p))
> > -			return -EFAULT;
> > -		if ((new_value < 1) || (new_value > IMX2_WDT_MAX_TIME))
> > -			return -EINVAL;
> > -		imx2_wdt_set_timeout(new_value);
> > -		imx2_wdt.timeout =3D new_value;
> > -		imx2_wdt_ping();
> > -
> > -		/* Fallthrough to return current value */
> > -	case WDIOC_GETTIMEOUT:
> > -		return put_user(imx2_wdt.timeout, p);
> > -
> > -	default:
> > -		return -ENOTTY;
> > +	if (imx2_wdt_is_running(wdev)) {
> > +		imx2_wdt_set_timeout(wdog, wdog->timeout);
> > +		imx2_wdt_timer_ping((unsigned long)wdog);
> >  	}
> >  }
> >
> > -static ssize_t imx2_wdt_write(struct file *file, const char __user *=
data,
> > -						size_t len, loff_t *ppos)
> > -{
> > -	size_t i;
> > -	char c;
> > -
> > -	if (len =3D=3D 0)	/* Can we see this even ? */
> > -		return 0;
> > -
> > -	clear_bit(IMX2_WDT_EXPECT_CLOSE, &imx2_wdt.status);
> > -	/* scan to see whether or not we got the magic character */
> > -	for (i =3D 0; i !=3D len; i++) {
> > -		if (get_user(c, data + i))
> > -			return -EFAULT;
> > -		if (c =3D=3D 'V')
> > -			set_bit(IMX2_WDT_EXPECT_CLOSE, &imx2_wdt.status);
> > -	}
> > -
> > -	imx2_wdt_ping();
> > -	return len;
> > -}
> > -
> > -static const struct file_operations imx2_wdt_fops =3D {
> > +static struct watchdog_ops imx2_wdt_ops =3D {
> >  	.owner =3D THIS_MODULE,
> > -	.llseek =3D no_llseek,
> > -	.unlocked_ioctl =3D imx2_wdt_ioctl,
> > -	.open =3D imx2_wdt_open,
> > -	.release =3D imx2_wdt_close,
> > -	.write =3D imx2_wdt_write,
> > -};
> > -
> > -static struct miscdevice imx2_wdt_miscdev =3D {
> > -	.minor =3D WATCHDOG_MINOR,
> > -	.name =3D "watchdog",
> > -	.fops =3D &imx2_wdt_fops,
> > +	.start =3D imx2_wdt_start,
> > +	.stop =3D imx2_wdt_stop,
> > +	.ping =3D imx2_wdt_ping,
> > +	.set_timeout =3D imx2_wdt_set_timeout,
> >  };
> >
> >  static struct regmap_config imx2_wdt_regmap_config =3D {
> > @@ -263,76 +190,101 @@ static struct regmap_config imx2_wdt_regmap_co=
nfig =3D
> {
> >
> >  static int __init imx2_wdt_probe(struct platform_device *pdev)
> >  {
> > +	struct imx2_wdt_device *wdev;
> > +	struct watchdog_device *wdog;
> >  	struct resource *res;
> >  	void __iomem *base;
> >  	int ret;
> > +	u32 val;
> > +
> > +	wdev =3D devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
> > +	if (!wdev)
> > +		return -ENOMEM;
> >
> >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	base =3D devm_ioremap_resource(&pdev->dev, res);
> >  	if (IS_ERR(base))
> >  		return PTR_ERR(base);
> >
> > -	imx2_wdt.regmap =3D devm_regmap_init_mmio_clk(&pdev->dev, NULL, bas=
e,
> > -						    &imx2_wdt_regmap_config);
> > -	if (IS_ERR(imx2_wdt.regmap)) {
> > +	wdev->regmap =3D devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
> > +						 &imx2_wdt_regmap_config);
> > +	if (IS_ERR(wdev->regmap)) {
> >  		dev_err(&pdev->dev, "regmap init failed\n");
> > -		return PTR_ERR(imx2_wdt.regmap);
> > +		return PTR_ERR(wdev->regmap);
> >  	}
> >
> > -	imx2_wdt.clk =3D devm_clk_get(&pdev->dev, NULL);
> > -	if (IS_ERR(imx2_wdt.clk)) {
> > +	wdev->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(wdev->clk)) {
> >  		dev_err(&pdev->dev, "can't get Watchdog clock\n");
> > -		return PTR_ERR(imx2_wdt.clk);
> > +		return PTR_ERR(wdev->clk);
> >  	}
> >
> > -	imx2_wdt.timeout =3D clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIM=
E);
> > -	if (imx2_wdt.timeout !=3D timeout)
> > -		dev_warn(&pdev->dev, "Initial timeout out of range! "
> > -			"Clamped from %u to %u\n", timeout, imx2_wdt.timeout);
> > +	wdog			=3D &wdev->wdog;
> > +	wdog->info		=3D &imx2_wdt_info;
> > +	wdog->ops		=3D &imx2_wdt_ops;
> > +	wdog->min_timeout	=3D 1;
> > +	wdog->max_timeout	=3D IMX2_WDT_MAX_TIME;
> >
> > -	setup_timer(&imx2_wdt.timer, imx2_wdt_timer_ping, 0);
> > +	clk_prepare_enable(wdev->clk);
> >
> > -	imx2_wdt_miscdev.parent =3D &pdev->dev;
> > -	ret =3D misc_register(&imx2_wdt_miscdev);
> > -	if (ret)
> > -		goto fail;
> > +	regmap_read(wdev->regmap, IMX2_WDT_WRSR, &val);
> > +	wdog->bootstatus =3D val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0=
;
> >
> > -	dev_info(&pdev->dev,
> > -		"IMX2+ Watchdog Timer enabled. timeout=3D%ds (nowayout=3D%d)\n",
> > -						imx2_wdt.timeout, nowayout);
> > -	return 0;
> > +	wdog->timeout =3D clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
> > +	if (wdog->timeout !=3D timeout)
> > +		dev_warn(&pdev->dev, "Initial timeout out of range! Clamped
> from %u to %u\n",
> > +			 timeout, wdog->timeout);
> > +
> > +	platform_set_drvdata(pdev, wdog);
> > +	watchdog_set_drvdata(wdog, wdev);
> > +	watchdog_set_nowayout(wdog, nowayout);
> > +	watchdog_init_timeout(wdog, timeout, &pdev->dev);
> > +
> > +	setup_timer(&wdev->timer, imx2_wdt_timer_ping, (unsigned long)wdog)=
;
> >
> > -fail:
> > -	imx2_wdt_miscdev.parent =3D NULL;
> > -	return ret;
> > +	imx2_wdt_ping_if_active(wdog);
> > +
> > +	ret =3D watchdog_register_device(wdog);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "cannot register watchdog device\n");
> > +		return ret;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "timeout %d sec (nowayout=3D%d)\n",
> > +		 wdog->timeout, nowayout);
> > +
> > +	return 0;
> >  }
> >
> >  static int __exit imx2_wdt_remove(struct platform_device *pdev)
> >  {
> > -	misc_deregister(&imx2_wdt_miscdev);
> > +	struct watchdog_device *wdog =3D platform_get_drvdata(pdev);
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> >
> > -	if (test_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status)) {
> > -		del_timer_sync(&imx2_wdt.timer);
> > +	watchdog_unregister_device(wdog);
> >
> > -		dev_crit(imx2_wdt_miscdev.parent,
> > -			"Device removed: Expect reboot!\n");
> > +	if (imx2_wdt_is_running(wdev)) {
> > +		del_timer_sync(&wdev->timer);
> > +		imx2_wdt_ping(wdog);
> > +		dev_crit(&pdev->dev, "Device removed: Expect reboot!\n");
> >  	}
> > -
> > -	imx2_wdt_miscdev.parent =3D NULL;
> >  	return 0;
> >  }
> >
> >  static void imx2_wdt_shutdown(struct platform_device *pdev)
> >  {
> > -	if (test_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status)) {
> > -		/* we are running, we need to delete the timer but will give
> > -		 * max timeout before reboot will take place */
> > -		del_timer_sync(&imx2_wdt.timer);
> > -		imx2_wdt_set_timeout(IMX2_WDT_MAX_TIME);
> > -		imx2_wdt_ping();
> > -
> > -		dev_crit(imx2_wdt_miscdev.parent,
> > -			"Device shutdown: Expect reboot!\n");
> > +	struct watchdog_device *wdog =3D platform_get_drvdata(pdev);
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> > +
> > +	if (imx2_wdt_is_running(wdev)) {
> > +		/*
> > +		 * We are running, we need to delete the timer but will
> > +		 * give max timeout before reboot will take place
> > +		 */
> > +		del_timer_sync(&wdev->timer);
> > +		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
> > +		imx2_wdt_ping(wdog);
> > +		dev_crit(&pdev->dev, "Device shutdown: Expect reboot!\n");
> >  	}
> >  }
> >

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
