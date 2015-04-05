Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56918 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbDENEF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 5 Apr 2015 09:04:05 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YekDc-004NjB-3T
	for linux-watchdog@vger.kernel.org; Sun, 05 Apr 2015 13:04:04 +0000
Message-ID: <552132B1.1080402@roeck-us.net>
Date: Sun, 05 Apr 2015 06:03:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Andrew Bresticker <abrestic@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH V3 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
References: <1428080722-29683-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1428080722-29683-1-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/03/2015 10:05 AM, Andrew Bresticker wrote:
> Since the heartbeat is statically initialized to its default value,
> watchdog_init_timeout() will never look in the device-tree for a
> timeout-sec value.  Instead of statically initializing heartbeat,
> fall back to the default timeout value if watchdog_init_timeout()
> fails.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes from v2:
>   - Set timeout before calling watchdog_init_timeout
>   - Don't print an error on watchdog_init_timeout failure
> New for v2.
> ---
>   drivers/watchdog/imgpdc_wdt.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
> index 0deaa4f..d6826a6 100644
> --- a/drivers/watchdog/imgpdc_wdt.c
> +++ b/drivers/watchdog/imgpdc_wdt.c
> @@ -42,7 +42,7 @@
>   #define PDC_WDT_MIN_TIMEOUT		1
>   #define PDC_WDT_DEF_TIMEOUT		64
>
> -static int heartbeat = PDC_WDT_DEF_TIMEOUT;
> +static int heartbeat;
>   module_param(heartbeat, int, 0);
>   MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
>   	"(default=" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
> @@ -190,15 +190,11 @@ static int pdc_wdt_probe(struct platform_device *pdev)
>   	pdc_wdt->wdt_dev.info = &pdc_wdt_info;
>   	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
>   	pdc_wdt->wdt_dev.max_timeout = 1 << PDC_WDT_CONFIG_DELAY_MASK;
> +	pdc_wdt->wdt_dev.timeout = PDC_WDT_DEF_TIMEOUT;
>   	pdc_wdt->wdt_dev.parent = &pdev->dev;
>   	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
>
> -	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
> -	if (ret < 0) {
> -		pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
> -		dev_warn(&pdev->dev,
> -			 "Initial timeout out of range! setting max timeout\n");
> -	}
> +	watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
>
>   	pdc_wdt_stop(&pdc_wdt->wdt_dev);
>
>

