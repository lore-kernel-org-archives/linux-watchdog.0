Return-path: <ukl@pengutronix.de>
Date: Thu, 26 Nov 2015 08:10:11 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCHv3 1/2] watchdog: stmp3xxx: Stop the watchdog on system
 halt
Message-ID: <20151126071011.GL19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1444220352-20548-1-git-send-email-harald@ccbib.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

On Wed, Oct 07, 2015 at 12:19:11PM +0000, Harald Geyer wrote:
> This allows the system to actually halt even if userspace forgot to
> disable the watchdog first. Old behaviour was that the watchdog forced
> the system to boot again.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> Changes since v2:
> * split this out as a separate patch
> 
>  drivers/watchdog/stmp3xxx_rtc_wdt.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> index 3ee6128..e09a01f 100644
> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> @@ -14,6 +14,8 @@
>  #include <linux/watchdog.h>
>  #include <linux/platform_device.h>
>  #include <linux/stmp3xxx_rtc_wdt.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
>  
>  #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
>  #define STMP3XXX_DEFAULT_TIMEOUT 19
> @@ -69,6 +71,28 @@ static struct watchdog_device stmp3xxx_wdd = {
>  	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
>  };
>  
> +static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
> +			  void *unused)
> +{
> +	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
> +	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
> +
> +	switch (code) {
> +	case SYS_DOWN:	/* keep enabled, system might crash while going down */
> +		break;
> +	case SYS_HALT:  /* allow the system to actually halt */

<nitpick>
You used a tab before the comment "keep enabled ...", but spaces for
"allow the system ...".
</nitpick>

> +	case SYS_POWER_OFF:
> +		wdt_stop(&stmp3xxx_wdd);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block wdt_notifier = {
> +	.notifier_call  = wdt_notify_sys,

s/  / /

> +};
> +
>  static int stmp3xxx_wdt_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -84,6 +108,9 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	if (register_reboot_notifier(&wdt_notifier))
> +		dev_warn(&pdev->dev, "cannot register reboot notifier\n");

OK, you don't fail when registering the notifier fails, but ...

>  	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
>  			stmp3xxx_wdd.timeout);
>  	return 0;
> @@ -91,6 +118,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
>  
>  static int stmp3xxx_wdt_remove(struct platform_device *pdev)
>  {
> +	unregister_reboot_notifier(&wdt_notifier);

... I think it's not ok to unconditionally unregister it then, is it?
(Looking at how unregister_reboot_notifier is implemented it might work
as intended, but if that's only by chance I wouldn't rely on it.)

Best regards
Uwe

>  	watchdog_unregister_device(&stmp3xxx_wdd);
>  	return 0;
>  }
> -- 
> 1.7.10.4
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
