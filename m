Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:56843 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdJYU45 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 25 Oct 2017 16:56:57 -0400
Received: by mail-pg0-f67.google.com with SMTP id m18so904955pgd.13
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Oct 2017 13:56:56 -0700 (PDT)
Date: Wed, 25 Oct 2017 13:56:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 3/4] watchdog: i6300esb: do not hardcode heartbeat
 limits
Message-ID: <20171025205655.GC30439@roeck-us.net>
References: <20171022170947.GA6997@roeck-us.net>
 <20171025153914.3467-3-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171025153914.3467-3-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 25, 2017 at 04:39:13PM +0100, Radu Rendec wrote:
> The minimum, maximum and default values for the watchdog heartbeat
> (timeout) were hardcoded in several places (including module parameter
> description and warning message for invalid module parameter value).
> 
> This patch adds macros for the aforementioned values and replaces all
> occurences of hardcoded values by these macros.
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>
> ---
>  drivers/watchdog/i6300esb.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index 0b4489661a82..3f7f66513dfa 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -81,12 +81,16 @@ static int cards_found;
>  
>  /* module parameters */
>  /* 30 sec default heartbeat (1 < heartbeat < 2*1023) */
> -#define WATCHDOG_HEARTBEAT 30
> +#define ESB_HEARTBEAT_MIN 1
> +#define ESB_HEARTBEAT_MAX 2046
> +#define ESB_HEARTBEAT_DEFAULT 30

Please use tabs above.

#define ESB_HEARTBEAT_MIN	1
#define ESB_HEARTBEAT_MAX	2046
#define ESB_HEARTBEAT_DEFAULT	30

> +#define ESB_HEARTBEAT_RANGE __MODULE_STRING(ESB_HEARTBEAT_MIN) \
> +	"<heartbeat<" __MODULE_STRING(ESB_HEARTBEAT_MAX)
>  static int heartbeat; /* in seconds */
>  module_param(heartbeat, int, 0);
>  MODULE_PARM_DESC(heartbeat,
> -		"Watchdog heartbeat in seconds. (1<heartbeat<2046, default="
> -				__MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
> +	"Watchdog heartbeat in seconds. (" ESB_HEARTBEAT_RANGE
> +	", default=" __MODULE_STRING(ESB_HEARTBEAT_DEFAULT) ")");
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
> @@ -326,13 +330,13 @@ static int esb_probe(struct pci_dev *pdev,
>  	/* Initialize the watchdog and make sure it does not run */
>  	edev->wdd.info = &esb_info;
>  	edev->wdd.ops = &esb_ops;
> -	edev->wdd.min_timeout = 1;
> -	edev->wdd.max_timeout = 2 * 0x03ff;
> -	edev->wdd.timeout = WATCHDOG_HEARTBEAT;
> +	edev->wdd.min_timeout = ESB_HEARTBEAT_MIN;
> +	edev->wdd.max_timeout = ESB_HEARTBEAT_MAX;
> +	edev->wdd.timeout = ESB_HEARTBEAT_DEFAULT;
>  	if (watchdog_init_timeout(&edev->wdd, heartbeat, NULL))
>  		dev_info(&pdev->dev,
> -			"heartbeat value must be 1<heartbeat<2046, using %u\n",
> -			edev->wdd.timeout);
> +			"heartbeat value must be " ESB_HEARTBEAT_RANGE
> +			", using %u\n", edev->wdd.timeout);
>  	watchdog_set_nowayout(&edev->wdd, nowayout);
>  	watchdog_stop_on_reboot(&edev->wdd);
>  	watchdog_stop_on_unregister(&edev->wdd);
> -- 
> 2.13.6
> 
