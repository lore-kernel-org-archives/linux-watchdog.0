Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38044 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbbKCChZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Nov 2015 21:37:25 -0500
Subject: Re: [RFC PATCH 11/13] watchdog: qcom-wdt: use core restart handler
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446514586-31455-12-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56381DE2.3040107@roeck-us.net>
Date: Mon, 2 Nov 2015 18:37:22 -0800
MIME-Version: 1.0
In-Reply-To: <1446514586-31455-12-git-send-email-damien.riegel@savoirfairelinux.com>
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
>   drivers/watchdog/qcom-wdt.c | 63 +++++++++++++++++++--------------------------
>   1 file changed, 26 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 773dcfa..aa7105d 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -17,7 +17,6 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> -#include <linux/reboot.h>
>   #include <linux/watchdog.h>
>
>   #define WDT_RST		0x38
> @@ -28,7 +27,6 @@ struct qcom_wdt {
>   	struct watchdog_device	wdd;
>   	struct clk		*clk;
>   	unsigned long		rate;
> -	struct notifier_block	restart_nb;
>   	void __iomem		*base;
>   };
>
> @@ -72,11 +70,37 @@ static int qcom_wdt_set_timeout(struct watchdog_device *wdd,
>   	return qcom_wdt_start(wdd);
>   }
>
> +static int qcom_wdt_restart(struct watchdog_device *wdd)
> +{
> +	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
> +	u32 timeout;
> +
> +	/*
> +	 * Trigger watchdog bite:
> +	 *    Setup BITE_TIME to be 128ms, and enable WDT.
> +	 */
> +	timeout = 128 * wdt->rate / 1000;
> +
> +	writel(0, wdt->base + WDT_EN);
> +	writel(1, wdt->base + WDT_RST);
> +	writel(timeout, wdt->base + WDT_BITE_TIME);
> +	writel(1, wdt->base + WDT_EN);
> +
> +	/*
> +	 * Actually make sure the above sequence hits hardware before sleeping.
> +	 */
> +	wmb();
> +
> +	msleep(150);
> +	return 0;
> +}
> +
>   static const struct watchdog_ops qcom_wdt_ops = {
>   	.start		= qcom_wdt_start,
>   	.stop		= qcom_wdt_stop,
>   	.ping		= qcom_wdt_ping,
>   	.set_timeout	= qcom_wdt_set_timeout,
> +	.restart        = qcom_wdt_restart,
>   	.owner		= THIS_MODULE,
>   };
>
> @@ -87,32 +111,6 @@ static const struct watchdog_info qcom_wdt_info = {
>   	.identity	= KBUILD_MODNAME,
>   };
>
> -static int qcom_wdt_restart(struct notifier_block *nb, unsigned long action,
> -			    void *data)
> -{
> -	struct qcom_wdt *wdt = container_of(nb, struct qcom_wdt, restart_nb);
> -	u32 timeout;
> -
> -	/*
> -	 * Trigger watchdog bite:
> -	 *    Setup BITE_TIME to be 128ms, and enable WDT.
> -	 */
> -	timeout = 128 * wdt->rate / 1000;
> -
> -	writel(0, wdt->base + WDT_EN);
> -	writel(1, wdt->base + WDT_RST);
> -	writel(timeout, wdt->base + WDT_BITE_TIME);
> -	writel(1, wdt->base + WDT_EN);
> -
> -	/*
> -	 * Actually make sure the above sequence hits hardware before sleeping.
> -	 */
> -	wmb();
> -
> -	msleep(150);
> -	return NOTIFY_DONE;
> -}
> -
>   static int qcom_wdt_probe(struct platform_device *pdev)
>   {
>   	struct qcom_wdt *wdt;
> @@ -187,14 +185,6 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>   		goto err_clk_unprepare;
>   	}
>
> -	/*
> -	 * WDT restart notifier has priority 0 (use as a last resort)
> -	 */
> -	wdt->restart_nb.notifier_call = qcom_wdt_restart;
> -	ret = register_restart_handler(&wdt->restart_nb);
> -	if (ret)
> -		dev_err(&pdev->dev, "failed to setup restart handler\n");
> -
>   	platform_set_drvdata(pdev, wdt);
>   	return 0;
>
> @@ -207,7 +197,6 @@ static int qcom_wdt_remove(struct platform_device *pdev)
>   {
>   	struct qcom_wdt *wdt = platform_get_drvdata(pdev);
>
> -	unregister_restart_handler(&wdt->restart_nb);
>   	watchdog_unregister_device(&wdt->wdd);
>   	clk_disable_unprepare(wdt->clk);
>   	return 0;
>

