Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37286 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbbKCCcP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Nov 2015 21:32:15 -0500
Subject: Re: [RFC PATCH 09/13] watchdog: moxart_wdt: use core restart handler
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446514586-31455-10-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56381CAD.3050602@roeck-us.net>
Date: Mon, 2 Nov 2015 18:32:13 -0800
MIME-Version: 1.0
In-Reply-To: <1446514586-31455-10-git-send-email-damien.riegel@savoirfairelinux.com>
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
>   drivers/watchdog/moxart_wdt.c | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
> index 60b0605..c64e4f0 100644
> --- a/drivers/watchdog/moxart_wdt.c
> +++ b/drivers/watchdog/moxart_wdt.c
> @@ -17,7 +17,6 @@
>   #include <linux/kernel.h>
>   #include <linux/notifier.h>
>   #include <linux/platform_device.h>
> -#include <linux/reboot.h>
>   #include <linux/watchdog.h>
>   #include <linux/moduleparam.h>
>
> @@ -29,22 +28,19 @@ struct moxart_wdt_dev {
>   	struct watchdog_device dev;
>   	void __iomem *base;
>   	unsigned int clock_frequency;
> -	struct notifier_block restart_handler;
>   };
>
>   static int heartbeat;
>
> -static int moxart_restart_handle(struct notifier_block *this,
> -				 unsigned long mode, void *cmd)
> +static int moxart_wdt_restart(struct watchdog_device *wdt_dev)
>   {
> -	struct moxart_wdt_dev *moxart_wdt = container_of(this,
> -							 struct moxart_wdt_dev,
> -							 restart_handler);
> +	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
> +
>   	writel(1, moxart_wdt->base + REG_COUNT);
>   	writel(0x5ab9, moxart_wdt->base + REG_MODE);
>   	writel(0x03, moxart_wdt->base + REG_ENABLE);
>
> -	return NOTIFY_DONE;
> +	return 0;
>   }
>
>   static int moxart_wdt_stop(struct watchdog_device *wdt_dev)
> @@ -87,6 +83,7 @@ static const struct watchdog_ops moxart_wdt_ops = {
>   	.start          = moxart_wdt_start,
>   	.stop           = moxart_wdt_stop,
>   	.set_timeout    = moxart_wdt_set_timeout,
> +	.restart        = moxart_wdt_restart,
>   };
>
>   static int moxart_wdt_probe(struct platform_device *pdev)
> @@ -134,6 +131,7 @@ static int moxart_wdt_probe(struct platform_device *pdev)
>
>   	watchdog_init_timeout(&moxart_wdt->dev, heartbeat, dev);
>   	watchdog_set_nowayout(&moxart_wdt->dev, nowayout);
> +	watchdog_set_restart_priority(&moxart_wdt->dev, 128);
>
>   	watchdog_set_drvdata(&moxart_wdt->dev, moxart_wdt);
>
> @@ -141,13 +139,6 @@ static int moxart_wdt_probe(struct platform_device *pdev)
>   	if (err)
>   		return err;
>
> -	moxart_wdt->restart_handler.notifier_call = moxart_restart_handle;
> -	moxart_wdt->restart_handler.priority = 128;
> -	err = register_restart_handler(&moxart_wdt->restart_handler);
> -	if (err)
> -		dev_err(dev, "cannot register restart notifier (err=%d)\n",
> -			err);
> -
>   	dev_dbg(dev, "Watchdog enabled (heartbeat=%d sec, nowayout=%d)\n",
>   		moxart_wdt->dev.timeout, nowayout);
>
> @@ -158,7 +149,6 @@ static int moxart_wdt_remove(struct platform_device *pdev)
>   {
>   	struct moxart_wdt_dev *moxart_wdt = platform_get_drvdata(pdev);
>
> -	unregister_restart_handler(&moxart_wdt->restart_handler);
>   	moxart_wdt_stop(&moxart_wdt->dev);
>
>   	return 0;
>

