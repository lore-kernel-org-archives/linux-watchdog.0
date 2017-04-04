Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38198 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932082AbdDDQjQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 12:39:16 -0400
Subject: Re: [PATCH] watchdog: core: Make use of
 devm_register_reboot_notifier()
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-watchdog@vger.kernel.org
References: <20170404141048.16828-1-andrew.smirnov@gmail.com>
Cc: cphealy@gmail.com, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>,
        Andrew Morton <akpm@linux-foundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <34972d36-74bc-7c9a-4ae1-67d484dab41a@roeck-us.net>
Date: Tue, 4 Apr 2017 09:39:06 -0700
MIME-Version: 1.0
In-Reply-To: <20170404141048.16828-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/04/2017 07:10 AM, Andrey Smirnov wrote:
> Save a bit of cleanup code by leveraging newly added
> devm_register_reboot_notifier().
>
> Cc: cphealy@gmail.com
> Cc: linux-kernel@vger.kernel.org
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> All:
>
> This patch is a follow up to this thread
> https://lkml.org/lkml/2017/3/20/671. I am not sure what's the best way
> to manager cross-tree dependency here, so, if there's something to be
> done, please let me know.
>
> Thanks,
> Andrey Smirnov
>
>  drivers/watchdog/watchdog_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 74265b2..9d868f1 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -247,7 +247,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>  	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
>  		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
>
> -		ret = register_reboot_notifier(&wdd->reboot_nb);
> +		ret = devm_register_reboot_notifier(wdd->parent,
> +						    &wdd->reboot_nb);

I like the idea, but unfortunately wdd->parent can be NULL. Also, this would result
in the notifier being removed _after_ the watchdog device has been removed, which
would be bad as well.

Guenter

>  		if (ret) {
>  			pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
>  			       wdd->id, ret);
> @@ -302,9 +303,6 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
>  	if (wdd->ops->restart)
>  		unregister_restart_handler(&wdd->restart_nb);
>
> -	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
> -		unregister_reboot_notifier(&wdd->reboot_nb);
> -
>  	watchdog_dev_unregister(wdd);
>  	ida_simple_remove(&watchdog_ida, wdd->id);
>  }
>

