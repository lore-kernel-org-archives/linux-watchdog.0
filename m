Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42231 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbbICKm1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Sep 2015 06:42:27 -0400
Message-ID: <55E8240E.9020005@roeck-us.net>
Date: Thu, 03 Sep 2015 03:42:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Pratyush Anand <panand@redhat.com>
CC: dyoung@redhat.com, dzickus@redhat.com,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH V3 1/2] watchdog: Use static struct class watchdog_class
 in stead of pointer
References: <cover.1441249584.git.panand@redhat.com> <6110a851dbc9fe6afe5f6d14b498a18de7158a8a.1441249584.git.panand@redhat.com>
In-Reply-To: <6110a851dbc9fe6afe5f6d14b498a18de7158a8a.1441249584.git.panand@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/02/2015 08:21 PM, Pratyush Anand wrote:
> We need few sysfs attributes to know different status of a watchdog device.
> To do that, we need to associate .dev_groups with watchdog_class. So
> convert it from pointer to static.
> Putting this static struct in watchdog_dev.c, so that static device
> attributes defined in that file can be attached to it.
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_core.c | 15 ++-------------
>   drivers/watchdog/watchdog_core.h |  2 +-
>   drivers/watchdog/watchdog_dev.c  | 26 ++++++++++++++++++++++----
>   3 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 1a8059455413..47d38c5c3f9a 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -274,19 +274,9 @@ static int __init watchdog_deferred_registration(void)
>
>   static int __init watchdog_init(void)
>   {
> -	int err;
> -
> -	watchdog_class = class_create(THIS_MODULE, "watchdog");
> -	if (IS_ERR(watchdog_class)) {
> -		pr_err("couldn't create class\n");
> +	watchdog_class = watchdog_dev_init();
> +	if (IS_ERR(watchdog_class))
>   		return PTR_ERR(watchdog_class);
> -	}
> -
> -	err = watchdog_dev_init();
> -	if (err < 0) {
> -		class_destroy(watchdog_class);
> -		return err;
> -	}
>
>   	watchdog_deferred_registration();
>   	return 0;
> @@ -295,7 +285,6 @@ static int __init watchdog_init(void)
>   static void __exit watchdog_exit(void)
>   {
>   	watchdog_dev_exit();
> -	class_destroy(watchdog_class);
>   	ida_destroy(&watchdog_ida);
>   }
>
> diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
> index 6c951418fca7..1c8d6b0e68c7 100644
> --- a/drivers/watchdog/watchdog_core.h
> +++ b/drivers/watchdog/watchdog_core.h
> @@ -33,5 +33,5 @@
>    */
>   extern int watchdog_dev_register(struct watchdog_device *);
>   extern int watchdog_dev_unregister(struct watchdog_device *);
> -extern int __init watchdog_dev_init(void);
> +extern struct class * __init watchdog_dev_init(void);
>   extern void __exit watchdog_dev_exit(void);
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 6aaefbad303e..986282d44b90 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -578,18 +578,35 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
>   	return 0;
>   }
>
> +static struct class watchdog_class = {
> +	.name =		"watchdog",
> +	.owner =	THIS_MODULE,
> +};
> +
>   /*
>    *	watchdog_dev_init: init dev part of watchdog core
>    *
>    *	Allocate a range of chardev nodes to use for watchdog devices
>    */
>
> -int __init watchdog_dev_init(void)
> +struct class * __init watchdog_dev_init(void)
>   {
> -	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
> -	if (err < 0)
> +	int err;
> +
> +	err = class_register(&watchdog_class);
> +	if (err < 0) {
> +		pr_err("couldn't register class\n");
> +		return ERR_PTR(err);
> +	}
> +
> +	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
> +	if (err < 0) {
>   		pr_err("watchdog: unable to allocate char dev region\n");
> -	return err;
> +		class_unregister(&watchdog_class);
> +		return ERR_PTR(err);
> +	}
> +
> +	return &watchdog_class;
>   }
>
>   /*
> @@ -601,4 +618,5 @@ int __init watchdog_dev_init(void)
>   void __exit watchdog_dev_exit(void)
>   {
>   	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
> +	class_unregister(&watchdog_class);
>   }
>

