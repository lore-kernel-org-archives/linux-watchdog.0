Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49703 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbcFZCaK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Jun 2016 22:30:10 -0400
Subject: Re: [PATCH v2 1/2] watchdog: add pretimeout support to the core
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robin Gong <b38343@freescale.com>
References: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1466902865-14354-2-git-send-email-vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <576F3E2E.7060606@roeck-us.net>
Date: Sat, 25 Jun 2016 19:30:06 -0700
MIME-Version: 1.0
In-Reply-To: <1466902865-14354-2-git-send-email-vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/25/2016 06:01 PM, Vladimir Zapolskiy wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Since the watchdog framework centrializes the IOCTL interfaces of device
> drivers now, SETPRETIMEOUT and GETPRETIMEOUT need to be added in the
> common code.
>
> Signed-off-by: Robin Gong <b38343@freescale.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> [vzapolskiy: added conditional pretimeout sysfs attribute visibility]
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---

[ ... ]

> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -307,10 +307,14 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>   	if (watchdog_timeout_invalid(wdd, timeout))
>   		return -EINVAL;
>
> -	if (wdd->ops->set_timeout)
> +	if (wdd->ops->set_timeout) {
>   		err = wdd->ops->set_timeout(wdd, timeout);
> -	else
> +	} else {
>   		wdd->timeout = timeout;
> +		/* Disable pretimeout if it doesn't fit the new timeout */
> +		if (wdd->pretimeout > wdd->timeout)

Nitpick: If we consider pretimeout == timeout to be invalid, we should reject it here
as well. So this should be >=.

Otherwise lgtm, so feel free to add

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

to the next version. I'd suggest to wait a bit to give Wolfram time to provide input,
though.

Thanks,
Guenter

