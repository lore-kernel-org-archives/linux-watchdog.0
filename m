Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48927 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335Ab2DMI5s (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Apr 2012 04:57:48 -0400
Message-ID: <4F87EB0A.4070807@redhat.com>
Date: Fri, 13 Apr 2012 10:59:54 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 3/4] watchdog: create all the proper device files
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120321152517.20045.82208.stgit@bob.linux.org.uk>
In-Reply-To: <20120321152517.20045.82208.stgit@bob.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

One small remark below (inline), with that fixed this patch is:
Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

On 03/21/2012 04:25 PM, Alan Cox wrote:
> From: Alan Cox<alan@linux.intel.com>
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/watchdog/watchdog_dev.c |   29 ++++++++++++++++++++++++-----
>   include/linux/watchdog.h        |    5 ++++-
>   2 files changed, 28 insertions(+), 6 deletions(-)
>
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 40c557b..abefa56 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -42,6 +42,8 @@
>   #include<linux/init.h>		/* For __init/__exit/... */
>   #include<linux/uaccess.h>	/* For copy_to_user/put_user/... */
>
> +static struct class *watchdog_class;	/* So we have someone to create
> +					   our devices */
>   static dev_t dog_devt;		/* Watchdog device range */
>   static unsigned long dog_mask;	/* Watchodgs that are in use */
>   /* the watchdog device behind /dev/watchdog */
> @@ -429,13 +431,21 @@ static int watchdog_add_device(struct watchdog_device *watchdog)
>   	watchdog->devt = MKDEV(MAJOR(dog_devt), watchdog->id);
>   	watchdog->cdev.owner = watchdog->ops->owner;
>   	cdev_init(&watchdog->cdev,&watchdog_multi_fops);
> -
>   	/* Add the device */
>   	err  = cdev_add(&watchdog->cdev, watchdog->devt, 1);
> -	if (err)
> +	if (err) {
>   		pr_err("watchdog%d unable to add device %d:%d\n",
>   			watchdog->id,  MAJOR(dog_devt), watchdog->id);
> -	return err;
> +		return err;
> +	}
> +	watchdog->dev = device_create(watchdog_class, watchdog->busdev,
> +					MKDEV(MAJOR(dog_devt), watchdog->id),
> +					NULL, "watchdog%d", watchdog->id);

It is probably cleaner to pass watchdog->devt as 3th parameter here, rather then
MKDEV(MAJOR(dog_devt), watchdog->id).

> +	if (IS_ERR(watchdog->dev)) {
> +		cdev_del(&watchdog->cdev);
> +		return PTR_ERR(watchdog->dev);
> +	}
> +	return 0;
>   }
>
>   /**
> @@ -447,6 +457,7 @@ static int watchdog_add_device(struct watchdog_device *watchdog)
>   static void watchdog_del_device(struct watchdog_device *watchdog)
>   {
>   	cdev_del(&watchdog->cdev);
> +	device_destroy(watchdog_class, MKDEV(MAJOR(dog_devt), watchdog->id));
>   }	
>
>   /**
> @@ -517,9 +528,16 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
>   int __init watchdog_init(void)
>   {
>   	int err = alloc_chrdev_region(&dog_devt, 0, DOG_MAX, "watchdog");
> -	if (err<  0)
> +	if (err<  0) {
>   		pr_err("watchdog: unable to allocate char dev region\n");
> -	return err;
> +		return err;
> +	}
> +	watchdog_class = class_create(THIS_MODULE, "watchdog");
> +	if (IS_ERR(watchdog_class)) {
> +		unregister_chrdev_region(dog_devt, DOG_MAX);
> +		return PTR_ERR(watchdog_class);
> +	}
> +	return 0;
>   }
>
>   /**
> @@ -530,6 +548,7 @@ int __init watchdog_init(void)
>   void __exit watchdog_exit(void)
>   {
>   	unregister_chrdev_region(dog_devt, DOG_MAX);
> +	class_destroy(watchdog_class);
>   }
>
>   module_init(watchdog_init);
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index fdd5dbb..b7a3359 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -108,7 +108,10 @@ struct watchdog_ops {
>    */
>   struct watchdog_device {
>   	struct cdev cdev;		/* Character device */
> -	dev_t devt;			/* Our device */
> +	struct device *dev;		/* Device for our node */
> +	struct device *busdev;		/* Parent bus device (set by caller
> +							if used) */
> +	dev_t devt;			/* Our device devt */
>   	int id;				/* Watchdog id */
>
>   	const struct watchdog_info *info;
>
