Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45274 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427Ab3BMJ2q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 04:28:46 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so1027454obc.5
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 01:28:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130212230303.GA7867@spo001.leaseweb.com>
References: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
 <1357639455-21935-2-git-send-email-fabio.porcedda@gmail.com> <20130212230303.GA7867@spo001.leaseweb.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Wed, 13 Feb 2013 10:28:24 +0100
Message-ID: <CAHkwnC_XdgHSo8Vkz5Ae=DQ48BBhLPVx_hXTzLTcw+xZJaEi5A@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] watchdog: core: dt: add support for the
 timeout-sec dt property
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 13, 2013 at 12:03 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Fabio,
>
> I must admit that the different iterations of this patch only made it better.
> I like the idea that you are proposing here (put the default timeout in the
> watchdog_device struct and use a helper function to set the timeout parameter
> value or the timeout-sec dt value). To be able to use other mechanism in the
> future also, I think it make more sense to pass the device instead of the
> device_node.

If i understand correctly you want to use "struct platform_device"
instead of "struct device_node",
in the function watchdog_init_timeout?

>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> ---
>>  Documentation/watchdog/watchdog-kernel-api.txt | 10 +++++++
>>  drivers/watchdog/watchdog_core.c               | 37 ++++++++++++++++++++++++++
>>  include/linux/watchdog.h                       |  3 +++
>>  3 files changed, 50 insertions(+)
>>
> ...
>>
>> +static bool watchdog_is_valid_timeout(struct watchdog_device *wdd,
>> +                                   unsigned int t)
>> +
>> +{
>> +     if (wdd->min_timeout < wdd->max_timeout)
>> +             return (wdd->min_timeout <= t) && (t <= wdd->max_timeout);
>> +     else
>> +             return (t > 0);
>> +}
>
> We use a similar check allready in watchdog_dev.c in the set_timeout wrapper.
> And we should move this to the watchdog.h include file so that drivers can also
> use the logic if necessary.

Do you prefer that i move or just export that function in watchdog.h?
I think it's better to just export it because the function is
not small enough as inline function, but both solutions are fine to me.

>
>> +/**
>> + * watchdog_init_timeout() - initialize the timeout field
>> + * @parm: timeout module parameter, it takes precedence over the
>> + *        timeout-sec property.
>> + * @node: Retrieve the timeout-sec property only if the parm_timeout
>> + *        is out of bounds.
>> + */
>> +void watchdog_init_timeout(struct watchdog_device *wdd, unsigned int parm,
>> +                        struct device_node *node)
>
> make this int so that drivers can give appropriate warnings if necessary.

In which cases i must return a non zero result?
For a value out of range in parm or node?
Wich value -EINVAL?


> I also detailed your documentation a bit more and incorporated above changes
> in an adjusted patch. Can you have a look at it and if OK for you I will put
> it in linux-watchdog-next as your v10 :-).

That's good for sure :)

> Kind regards,
> Wim.
> ---
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index 086638f..a0438f3 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -1,6 +1,6 @@
>  The Linux WatchDog Timer Driver Core kernel API.
>  ===============================================
> -Last reviewed: 22-May-2012
> +Last reviewed: 12-Feb-2013
>
>  Wim Van Sebroeck <wim@iguana.be>
>
> @@ -212,3 +212,15 @@ driver specific data to and a pointer to the data itself.
>  The watchdog_get_drvdata function allows you to retrieve driver specific data.
>  The argument of this function is the watchdog device where you want to retrieve
>  data from. The function returns the pointer to the driver specific data.
> +
> +To initialize the timeout field, the following function can be used:
> +
> +extern int watchdog_init_timeout(struct watchdog_device *wdd,
> +                                  unsigned int timeout_parm, struct device *dev);
> +
> +The watchdog_init_timeout function allows you to initialize the timeout field
> +using the module timeout parameter or by retrieving the timeout-sec property from
> +the device tree (if the module timeout parameter is invalid). Best practice is
> +to set the default timeout value as timeout value in the watchdog_device and
> +then use this function to set the user "preferred" timeout value.
> +This routine returns zero on success and a negative errno code for failure.
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 3796434..a74a3ef 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -36,12 +36,62 @@
>  #include <linux/init.h>                /* For __init/__exit/... */
>  #include <linux/idr.h>         /* For ida_* macros */
>  #include <linux/err.h>         /* For IS_ERR macros */
> +#include <linux/of.h>          /* For of_get_timeout_sec */
>
>  #include "watchdog_core.h"     /* For watchdog_dev_register/... */
>
>  static DEFINE_IDA(watchdog_ida);
>  static struct class *watchdog_class;
>
> +void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
> +{
> +       /*
> +        * Check that we have valid min and max timeout values, if
> +        * not reset them both to 0 (=not used or unknown)
> +        */
> +       if (wdd->min_timeout > wdd->max_timeout) {
> +               pr_info("Invalid min and max timeout values, resetting to 0!\n");
> +               wdd->min_timeout = 0;
> +               wdd->max_timeout = 0;
> +       }
> +}
> +
> +/**
> + * watchdog_init_timeout() - initialize the timeout field
> + * @timeout_parm: timeout module parameter
> + * @dev: Device that stores the timeout-sec property
> + *
> + * Initialize the timeout field of the watchdog_device struct with either the
> + * timeout module parameter (if it is valid value) or the timeout-sec property
> + * (only if it is a valid value and the timeout_parm is out of bounds).
> + * If none of them are valid then we keep the old value (which should normally
> + * be the default timeout value.
> + *
> + * A zero is returned on success and -EINVAL for failure.
> + */
> +int watchdog_init_timeout(struct watchdog_device *wdd,
> +                               unsigned int timeout_parm, struct device *dev)
> +{
> +       unsigned int t = 0;
> +
> +       watchdog_check_min_max_timeout(wdd);
> +
> +       /* try to get the tiemout module parameter first */
> +       if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
> +               wdd->timeout = timeout_parm;
> +               return 0;
> +       }
> +
> +       /* try to get the timeout_sec property */
> +       if (dev == NULL || dev->of_node == NULL)
> +               return -EINVAL;
> +       of_property_read_u32(dev->of_node, "timeout-sec", &t);
> +       if (!watchdog_timeout_invalid(wdd, t))
> +               wdd->timeout = t;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(watchdog_init_timeout);
> +
>  /**
>   * watchdog_register_device() - register a watchdog device
>   * @wdd: watchdog device
> @@ -63,15 +113,7 @@ int watchdog_register_device(struct watchdog_device *wdd)
>         if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
>                 return -EINVAL;
>
> -       /*
> -        * Check that we have valid min and max timeout values, if
> -        * not reset them both to 0 (=not used or unknown)
> -        */
> -       if (wdd->min_timeout > wdd->max_timeout) {
> -               pr_info("Invalid min and max timeout values, resetting to 0!\n");
> -               wdd->min_timeout = 0;
> -               wdd->max_timeout = 0;
> -       }
> +       watchdog_check_min_max_timeout(wdd);
>
>         /*
>          * Note: now that all watchdog_device data has been verified, we
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index ef8edec..08b48bb 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -200,8 +200,7 @@ static int watchdog_set_timeout(struct watchdog_device *wddev,
>             !(wddev->info->options & WDIOF_SETTIMEOUT))
>                 return -EOPNOTSUPP;
>
> -       if ((wddev->max_timeout != 0) &&
> -           (timeout < wddev->min_timeout || timeout > wddev->max_timeout))
> +       if (watchdog_timeout_invalid(wddev, timeout))
>                 return -EINVAL;
>
>         mutex_lock(&wddev->lock);
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 3a9df2f..2a3038e 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -118,6 +118,13 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
>                 set_bit(WDOG_NO_WAY_OUT, &wdd->status);
>  }
>
> +/* Use the following function to check if a timeout value is invalid */
> +static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
> +{
> +       return ((wdd->max_timeout != 0) &&
> +               (t < wdd->min_timeout || t > wdd->max_timeout));
> +}
> +
>  /* Use the following functions to manipulate watchdog driver specific data */
>  static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
>  {
> @@ -130,6 +137,8 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
>  }
>
>  /* drivers/watchdog/watchdog_core.c */
> +extern int watchdog_init_timeout(struct watchdog_device *wdd,
> +                                 unsigned int timeout_parm, struct device *dev);
>  extern int watchdog_register_device(struct watchdog_device *);
>  extern void watchdog_unregister_device(struct watchdog_device *);
>



--
Fabio Porcedda
