Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36972 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbbKCC3g (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Nov 2015 21:29:36 -0500
Subject: Re: [RFC PATCH 06/13] watchdog: imx2_wdt: use core restart handler
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446514586-31455-7-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56381C0E.1020903@roeck-us.net>
Date: Mon, 2 Nov 2015 18:29:34 -0800
MIME-Version: 1.0
In-Reply-To: <1446514586-31455-7-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/02/2015 05:36 PM, Damien Riegel wrote:
> Get rid of the custom restart handler by using the one provided by the
> watchdog core.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/imx2_wdt.c | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 29ef719..dda44f6 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -32,7 +32,6 @@
>   #include <linux/notifier.h>
>   #include <linux/of_address.h>
>   #include <linux/platform_device.h>
> -#include <linux/reboot.h>
>   #include <linux/regmap.h>
>   #include <linux/timer.h>
>   #include <linux/watchdog.h>
> @@ -64,7 +63,6 @@ struct imx2_wdt_device {
>   	struct regmap *regmap;
>   	struct timer_list timer;	/* Pings the watchdog when closed */
>   	struct watchdog_device wdog;
> -	struct notifier_block restart_handler;
>   };
>
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -83,13 +81,11 @@ static const struct watchdog_info imx2_wdt_info = {
>   	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
>   };
>
> -static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
> -				void *cmd)
> +static int imx2_wdt_restart(struct watchdog_device *wdog)
>   {
> +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>   	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
> -	struct imx2_wdt_device *wdev = container_of(this,
> -						    struct imx2_wdt_device,
> -						    restart_handler);
> +
>   	/* Assert SRS signal */
>   	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
>   	/*
> @@ -105,7 +101,7 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
>   	/* wait for reset to assert... */
>   	mdelay(500);
>
> -	return NOTIFY_DONE;
> +	return 0;
>   }
>
>   static inline void imx2_wdt_setup(struct watchdog_device *wdog)
> @@ -213,6 +209,7 @@ static const struct watchdog_ops imx2_wdt_ops = {
>   	.stop = imx2_wdt_stop,
>   	.ping = imx2_wdt_ping,
>   	.set_timeout = imx2_wdt_set_timeout,
> +	.restart = imx2_wdt_restart,
>   };
>
>   static const struct regmap_config imx2_wdt_regmap_config = {
> @@ -275,6 +272,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, wdog);
>   	watchdog_set_drvdata(wdog, wdev);
>   	watchdog_set_nowayout(wdog, nowayout);
> +	watchdog_set_restart_priority(wdog, 128);
>   	watchdog_init_timeout(wdog, timeout, &pdev->dev);
>
>   	setup_timer(&wdev->timer, imx2_wdt_timer_ping, (unsigned long)wdog);
> @@ -294,12 +292,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   		goto disable_clk;
>   	}
>
> -	wdev->restart_handler.notifier_call = imx2_restart_handler;
> -	wdev->restart_handler.priority = 128;
> -	ret = register_restart_handler(&wdev->restart_handler);
> -	if (ret)
> -		dev_err(&pdev->dev, "cannot register restart handler\n");
> -
>   	dev_info(&pdev->dev, "timeout %d sec (nowayout=%d)\n",
>   		 wdog->timeout, nowayout);
>
> @@ -315,8 +307,6 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
>   	struct watchdog_device *wdog = platform_get_drvdata(pdev);
>   	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>
> -	unregister_restart_handler(&wdev->restart_handler);
> -
>   	watchdog_unregister_device(wdog);
>
>   	if (imx2_wdt_is_running(wdev)) {
>

