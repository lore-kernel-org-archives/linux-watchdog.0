Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50133 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbcA2Tky (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Jan 2016 14:40:54 -0500
Subject: Re: [RFT PATCH v7 6/9] watchdog: imx2: Convert to use infrastructure
 triggered keepalives
To: Guenter Roeck <patchwork@patchwork.roeck-us.net>,
	linux-watchdog@vger.kernel.org
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
 <1453776796-3885-7-git-send-email-patchwork@patchwork.roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56ABC043.70501@roeck-us.net>
Date: Fri, 29 Jan 2016 11:40:51 -0800
MIME-Version: 1.0
In-Reply-To: <1453776796-3885-7-git-send-email-patchwork@patchwork.roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/25/2016 06:53 PM, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
>
> The watchdog infrastructure now supports handling watchdog keepalive
> if the watchdog is running while the watchdog device is closed.
> Convert the driver to use this infrastructure.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I managed to test this patch with qemu (after implementing the imx2 watchdog
in qemu). It works as expected, so please consider it upgraded from RFT
to a "real" patch.

Guenter

> ---
> v7: Set max_hw_timeout_ms
>      Rebased to v4.5-rc1
> v6: Rename WDOG_RUNNING to WDOG_HW_RUNNING
>      Rebased to v4.4-rc2
> v5: Rebased to v4.4-rc1
> v4: No changes
> v3: No changes
> v2: No changes
> ---
>   drivers/watchdog/imx2_wdt.c | 74 ++++++++-------------------------------------
>   1 file changed, 13 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index e47966aa2db0..1a48cb28718f 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -25,14 +25,12 @@
>   #include <linux/delay.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
> -#include <linux/jiffies.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/of_address.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
> -#include <linux/timer.h>
>   #include <linux/watchdog.h>
>
>   #define DRIVER_NAME "imx2-wdt"
> @@ -60,7 +58,6 @@
>   struct imx2_wdt_device {
>   	struct clk *clk;
>   	struct regmap *regmap;
> -	struct timer_list timer;	/* Pings the watchdog when closed */
>   	struct watchdog_device wdog;
>   };
>
> @@ -146,16 +143,6 @@ static int imx2_wdt_ping(struct watchdog_device *wdog)
>   	return 0;
>   }
>
> -static void imx2_wdt_timer_ping(unsigned long arg)
> -{
> -	struct watchdog_device *wdog = (struct watchdog_device *)arg;
> -	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> -
> -	/* ping it every wdog->timeout / 2 seconds to prevent reboot */
> -	imx2_wdt_ping(wdog);
> -	mod_timer(&wdev->timer, jiffies + wdog->timeout * HZ / 2);
> -}
> -
>   static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
>   				unsigned int new_timeout)
>   {
> @@ -172,40 +159,19 @@ static int imx2_wdt_start(struct watchdog_device *wdog)
>   {
>   	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>
> -	if (imx2_wdt_is_running(wdev)) {
> -		/* delete the timer that pings the watchdog after close */
> -		del_timer_sync(&wdev->timer);
> +	if (imx2_wdt_is_running(wdev))
>   		imx2_wdt_set_timeout(wdog, wdog->timeout);
> -	} else
> +	else
>   		imx2_wdt_setup(wdog);
>
> -	return imx2_wdt_ping(wdog);
> -}
> -
> -static int imx2_wdt_stop(struct watchdog_device *wdog)
> -{
> -	/*
> -	 * We don't need a clk_disable, it cannot be disabled once started.
> -	 * We use a timer to ping the watchdog while /dev/watchdog is closed
> -	 */
> -	imx2_wdt_timer_ping((unsigned long)wdog);
> -	return 0;
> -}
> -
> -static inline void imx2_wdt_ping_if_active(struct watchdog_device *wdog)
> -{
> -	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +	set_bit(WDOG_HW_RUNNING, &wdog->status);
>
> -	if (imx2_wdt_is_running(wdev)) {
> -		imx2_wdt_set_timeout(wdog, wdog->timeout);
> -		imx2_wdt_timer_ping((unsigned long)wdog);
> -	}
> +	return imx2_wdt_ping(wdog);
>   }
>
>   static const struct watchdog_ops imx2_wdt_ops = {
>   	.owner = THIS_MODULE,
>   	.start = imx2_wdt_start,
> -	.stop = imx2_wdt_stop,
>   	.ping = imx2_wdt_ping,
>   	.set_timeout = imx2_wdt_set_timeout,
>   	.restart = imx2_wdt_restart,
> @@ -253,7 +219,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   	wdog->info		= &imx2_wdt_info;
>   	wdog->ops		= &imx2_wdt_ops;
>   	wdog->min_timeout	= 1;
> -	wdog->max_timeout	= IMX2_WDT_MAX_TIME;
> +	wdog->max_hw_timeout_ms	= IMX2_WDT_MAX_TIME * 1000;
>   	wdog->parent		= &pdev->dev;
>
>   	ret = clk_prepare_enable(wdev->clk);
> @@ -274,9 +240,10 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   	watchdog_set_restart_priority(wdog, 128);
>   	watchdog_init_timeout(wdog, timeout, &pdev->dev);
>
> -	setup_timer(&wdev->timer, imx2_wdt_timer_ping, (unsigned long)wdog);
> -
> -	imx2_wdt_ping_if_active(wdog);
> +	if (imx2_wdt_is_running(wdev)) {
> +		imx2_wdt_set_timeout(wdog, wdog->timeout);
> +		set_bit(WDOG_HW_RUNNING, &wdog->status);
> +	}
>
>   	/*
>   	 * Disable the watchdog power down counter at boot. Otherwise the power
> @@ -309,7 +276,6 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
>   	watchdog_unregister_device(wdog);
>
>   	if (imx2_wdt_is_running(wdev)) {
> -		del_timer_sync(&wdev->timer);
>   		imx2_wdt_ping(wdog);
>   		dev_crit(&pdev->dev, "Device removed: Expect reboot!\n");
>   	}
> @@ -323,10 +289,9 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
>
>   	if (imx2_wdt_is_running(wdev)) {
>   		/*
> -		 * We are running, we need to delete the timer but will
> -		 * give max timeout before reboot will take place
> +		 * We are running, configure max timeout before reboot
> +		 * will take place.
>   		 */
> -		del_timer_sync(&wdev->timer);
>   		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
>   		imx2_wdt_ping(wdog);
>   		dev_crit(&pdev->dev, "Device shutdown: Expect reboot!\n");
> @@ -344,10 +309,6 @@ static int imx2_wdt_suspend(struct device *dev)
>   	if (imx2_wdt_is_running(wdev)) {
>   		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
>   		imx2_wdt_ping(wdog);
> -
> -		/* The watchdog is not active */
> -		if (!watchdog_active(wdog))
> -			del_timer_sync(&wdev->timer);
>   	}
>
>   	clk_disable_unprepare(wdev->clk);
> @@ -373,19 +334,10 @@ static int imx2_wdt_resume(struct device *dev)
>   		 * watchdog again.
>   		 */
>   		imx2_wdt_setup(wdog);
> +	}
> +	if (imx2_wdt_is_running(wdev)) {
>   		imx2_wdt_set_timeout(wdog, wdog->timeout);
>   		imx2_wdt_ping(wdog);
> -	} else if (imx2_wdt_is_running(wdev)) {
> -		/* Resuming from non-deep sleep state. */
> -		imx2_wdt_set_timeout(wdog, wdog->timeout);
> -		imx2_wdt_ping(wdog);
> -		/*
> -		 * But the watchdog is not active, then start
> -		 * the timer again.
> -		 */
> -		if (!watchdog_active(wdog))
> -			mod_timer(&wdev->timer,
> -				  jiffies + wdog->timeout * HZ / 2);
>   	}
>
>   	return 0;
>

