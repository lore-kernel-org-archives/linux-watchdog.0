Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44478 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbbFTBo4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Jun 2015 21:44:56 -0400
Message-ID: <5584C594.70300@roeck-us.net>
Date: Fri, 19 Jun 2015 18:44:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: poeschel@lemonage.de, wim@iguana.be, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: omap_wdt: start_enabled module parameter
References: <1434719880-12393-1-git-send-email-poeschel@lemonage.de>
In-Reply-To: <1434719880-12393-1-git-send-email-poeschel@lemonage.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/19/2015 06:18 AM, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
>
> Add a start_enabled module parameter to the omap_wdt that starts the
> watchdog on module insertion. The default value is 0 which does not
> start the watchdog - which also does not change the behaviour if the

behavior

> parameter is not given.
>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>   Documentation/watchdog/watchdog-parameters.txt |  1 +
>   drivers/watchdog/omap_wdt.c                    | 10 ++++++++++
>   2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 692791c..fb023bb 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -208,6 +208,7 @@ nowayout: Watchdog cannot be stopped once started
>   -------------------------------------------------
>   omap_wdt:
>   timer_margin: initial watchdog timeout (in seconds)
> +start_enabled: Watchdog is started on module insertion (default=0)

Please name the parameter early_enable. We have one driver with early_disable,
so this makes it at least to some degree generic.

>   -------------------------------------------------
>   orion_wdt:
>   heartbeat: Initial watchdog heartbeat in seconds
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index a29a61d..7dc8de7 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -53,6 +53,13 @@ static unsigned timer_margin;
>   module_param(timer_margin, uint, 0);
>   MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
>
> +#define START_DEFAULT	0
> +static bool start_enabled = START_DEFAULT;

Please drop the define. Static variables do not need to be initialized to 0.
Cirumventing that with a define to defeat the resulting warning isn't really
the idea.

> +module_param(start_enabled, bool, 0);
> +MODULE_PARM_DESC(start_enabled,
> +	"Watchdog is started on module insertion (default="
> +	__MODULE_STRING(START_DEFAULT) ")");

and just make this default=0.

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
