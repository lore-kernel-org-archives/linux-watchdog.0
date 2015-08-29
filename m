Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48594 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbH2Jxe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 29 Aug 2015 05:53:34 -0400
Message-ID: <55E1811A.9000709@roeck-us.net>
Date: Sat, 29 Aug 2015 02:53:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Justin Chen <justinpopo6@gmail.com>, linux-kernel@vger.kernel.org
CC: wim@iguana.be, linux-watchdog@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] watchdog_dev: Use device tree alias for naming watchdogs
References: <1440799086-14683-1-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1440799086-14683-1-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/28/2015 02:58 PM, Justin Chen wrote:
> Currently there is no way to easily differentiate multiple
> watchdog devices. The watchdogs are named by the order they
> are probed.
> 1st probed watchdog: /dev/watchdog0
> 2nd probed watchdog: /dev/watchdog1
> ...
>
> This change uses the alias of the watchdog device node for
> the name of the watchdog.
> aliases {
> 	watchdog0 = "/...../...."
> 	watchdog3 = "/..../....."
> 	watchdog2 = "/..../....."
> 	...
> }
>
> This will translate to...
> /dev/watchdog0
> /dev/watchdog3
> /dev/watchdog2
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Interesting idea. Checking through other subsystems, many others do the same,
so it makes sense to use that mechanism.

However, the id assignment should be in the calling code, in __watchdog_register_device,
to avoid that another id, possibly conflicting, is assigned through the ida mechanism.

This is a bit more complicated than it looks like to ensure correct id assignment.
Have a look into the i2c code to see how it is handled. Essentially we must pass
the requested number to ida_simple_get().

Thanks,
Guenter

> ---
>   drivers/watchdog/watchdog_dev.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 6aaefba..52b1f0b 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -41,6 +41,7 @@
>   #include <linux/miscdevice.h>	/* For handling misc devices */
>   #include <linux/init.h>		/* For __init/__exit/... */
>   #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
> +#include <linux/of.h>
>
>   #include "watchdog_core.h"
>
> @@ -522,7 +523,13 @@ static struct miscdevice watchdog_miscdev = {
>
>   int watchdog_dev_register(struct watchdog_device *watchdog)
>   {
> -	int err, devno;
> +	int err, devno, ret;
> +
> +	if (watchdog->parent) {
> +		ret = of_alias_get_id(watchdog->parent->of_node, "watchdog");
> +		if (ret >= 0)
> +			watchdog->id = ret;
> +	}
>
>   	if (watchdog->id == 0) {
>   		old_wdd = watchdog;
>

