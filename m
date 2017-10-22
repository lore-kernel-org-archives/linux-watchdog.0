Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:48614 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdJVRJt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:09:49 -0400
Received: by mail-oi0-f65.google.com with SMTP id m198so27051023oig.5
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:09:49 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:09:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [3/3] watchdog: i6300esb: do not hardcode heartbeat limits
Message-ID: <20171022170947.GA6997@roeck-us.net>
References: <20171016182528.3244-3-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016182528.3244-3-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 16, 2017 at 07:25:28PM +0100, Radu Rendec wrote:
> The minimum, maximum and default values for the watchdog heartbeat
> (timeout) were hardcoded in several places (including module parameter
> description and warning message for invalid module parameter value).
> 
> This patch adds macros for the aforementioned values and replaces all
> occurences of hardcoded values by these macros.
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>
> ---
>  drivers/watchdog/i6300esb.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index 855b4f80ad09..68d76512b08f 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -82,12 +82,16 @@ static int cards_found;
>  
>  /* module parameters */
>  /* 30 sec default heartbeat (1 < heartbeat < 2*1023) */
> -#define WATCHDOG_HEARTBEAT 30
> -static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
> +#define ESB_HEARTBEAT_MIN 1
> +#define ESB_HEARTBEAT_MAX 2046
> +#define ESB_HEARTBEAT_DEFAULT 30
> +static int heartbeat = ESB_HEARTBEAT_DEFAULT;  /* in seconds */

Ah, I just noticed. This defeats watchdog_init_timeout().

In patch 1, the timeout in struct watchdog_device to the default,
and set this variable to 0. watchdog_init_timeout() will then overwrite
the default (which is set in struct watchdog_device) with the module
parameter if the module parameter is set to a value != 0.

Thanks,
Guenter

>  module_param(heartbeat, int, 0);
>  MODULE_PARM_DESC(heartbeat,
> -		"Watchdog heartbeat in seconds. (1<heartbeat<2046, default="
> -				__MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
> +	"Watchdog heartbeat in seconds. ("
> +	__MODULE_STRING(ESB_HEARTBEAT_MIN) "<heartbeat<"
> +	__MODULE_STRING(ESB_HEARTBEAT_MAX) ", default="
> +	__MODULE_STRING(ESB_HEARTBEAT_DEFAULT) ")");
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
> @@ -325,17 +329,19 @@ static int esb_probe(struct pci_dev *pdev,
>  
>  	/* Check that the heartbeat value is within it's range;
>  	   if not reset to the default */
> -	if (heartbeat < 0x1 || heartbeat > 2 * 0x03ff) {
> -		heartbeat = WATCHDOG_HEARTBEAT;
> -		pr_info("heartbeat value must be 1<heartbeat<2046, using %d\n",
> +	if (heartbeat < ESB_HEARTBEAT_MIN || heartbeat > ESB_HEARTBEAT_MAX) {
> +		heartbeat = ESB_HEARTBEAT_DEFAULT;
> +		pr_info("heartbeat value must be "
> +			__MODULE_STRING(ESB_HEARTBEAT_MIN) "<heartbeat<"
> +			__MODULE_STRING(ESB_HEARTBEAT_MAX) ", using %d\n",
>  			heartbeat);
>  	}
>  
>  	/* Initialize the watchdog and make sure it does not run */
>  	edev->wdd.info = &esb_info;
>  	edev->wdd.ops = &esb_ops;
> -	edev->wdd.min_timeout = 1;
> -	edev->wdd.max_timeout = 2 * 0x03ff;
> +	edev->wdd.min_timeout = ESB_HEARTBEAT_MIN;
> +	edev->wdd.max_timeout = ESB_HEARTBEAT_MAX;
>  	watchdog_init_timeout(&edev->wdd, heartbeat, NULL);
>  	watchdog_set_nowayout(&edev->wdd, nowayout);
>  	esb_initdevice(edev);
