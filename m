Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:63835 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaCBFLU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 2 Mar 2014 00:11:20 -0500
Message-ID: <5312BD76.2080102@roeck-us.net>
Date: Sat, 01 Mar 2014 21:11:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: core: module param to activate watchdog
References: <1393604183-8755-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1393604183-8755-1-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/28/2014 08:16 AM, Markus Pargmann wrote:
> Many watchdog driver reset the watchdog device on initialization. This
> is a problem if the watchdog is activated by the bootloader and should
> be active the whole time until the userspace can write to it.
>

Shouldn't those watchdog drivers be fixed to keep the watchdog running
if it was already active ? Otherwise there is still the time between
driver initialization, which disables the watchdog, and it being re-enabled
by watchdog registration.

Also, does this affect or impact drivers which _do_ keep the watchdog
enabled ?

> This patch adds a module parameter (watchdog.activate_first) that
> activates the first registered watchdog. Using this parameter it is
> possible to have an active watchdog during the whole boot process.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>   drivers/watchdog/watchdog_core.c |  4 ++++
>   drivers/watchdog/watchdog_core.h |  4 ++++
>   drivers/watchdog/watchdog_dev.c  | 21 ++++++++++++++++++++-
>   3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index cec9b55..6db16eb 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -43,6 +43,10 @@
>   static DEFINE_IDA(watchdog_ida);
>   static struct class *watchdog_class;
>
> +unsigned int activate_first = 0;

Bad variable name for a global variable.

> +module_param(activate_first, uint, 0);
> +MODULE_PARM_DESC(activate_first, "Activation timeout for first watchdog registered. 0 means no activation.");
> +

Does that _have_ to be in this file ? Would be much easier
if it was in watchdog_dev.c, where it is used.

>   static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>   {
>   	/*
> diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
> index 6c95141..4526170 100644
> --- a/drivers/watchdog/watchdog_core.h
> +++ b/drivers/watchdog/watchdog_core.h
> @@ -28,6 +28,10 @@
>
>   #define MAX_DOGS	32	/* Maximum number of watchdog devices */
>
> +/* Activate first registered watchdog and set this as the timeout value
> + * (only != 0) */

Coding style.

> +extern unsigned int activate_first;
> +
>   /*
>    *	Functions/procedures to be called by the core
>    */
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 6aaefba..fe60fdc 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -553,8 +553,27 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
>   			misc_deregister(&watchdog_miscdev);
>   			old_wdd = NULL;
>   		}
> +

Is that extra empty line really necessary ?

> +		return err;
>   	}
> -	return err;
> +
> +	if (activate_first && watchdog->id == 0) {
> +		err = watchdog_set_timeout(watchdog, activate_first);
> +		if (err && err != -EOPNOTSUPP) {
> +			pr_err("watchdog%d failed to set timeout for first activation\n",
> +					watchdog->id);
> +			return err;
> +		}
> +
> +		err = watchdog_start(watchdog);
> +		if (err) {
> +			pr_err("watchdog%d failed to start first watchdog\n",
> +					watchdog->id);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
>   }
>
>   /*
>

