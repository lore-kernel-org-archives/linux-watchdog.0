Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:52759 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdJ0BDY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Oct 2017 21:03:24 -0400
Received: by mail-pg0-f65.google.com with SMTP id a192so4013291pge.9
        for <linux-watchdog@vger.kernel.org>; Thu, 26 Oct 2017 18:03:24 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] watchdog: i6300esb: use the watchdog subsystem
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
References: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
 <20171026161016.3198-1-rrendec@arista.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a649bb9a-a818-1bd4-51bd-7fb9a53dea71@roeck-us.net>
Date: Thu, 26 Oct 2017 18:03:22 -0700
MIME-Version: 1.0
In-Reply-To: <20171026161016.3198-1-rrendec@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/26/2017 09:10 AM, Radu Rendec wrote:
> Change the i6300esb driver to use the watchdog subsystem instead of the
> legacy watchdog API. This is mainly just getting rid of the "write" and
> "ioctl" methods and part of the watchdog control logic (which are all
> implemented by the watchdog subsystem).
> 
> Even though the watchdog subsystem supports registering and handling
> multiple watchdog devices at the same time, the i6300esb driver still
> has a limitation of only one i6300esb device due to some global variable
> usage that comes from the original design. However, the driver can now
> coexist with other watchdog devices (supported by different drivers).
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/i6300esb.c | 232 +++++++++-----------------------------------
>   1 file changed, 47 insertions(+), 185 deletions(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index d7befd58b391..4f4287d83c21 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -21,6 +21,8 @@
>    *	Version 0.02
>    *  20050210 David Härdeman <david@2gen.com>
>    *	Ported driver to kernel 2.6
> + *  20171016 Radu Rendec <rrendec@arista.com>
> + *	Change driver to use the watchdog subsystem
>    */
>   
>   /*
> @@ -44,7 +46,6 @@
>   /* Module and version information */
>   #define ESB_VERSION "0.05"
>   #define ESB_MODULE_NAME "i6300ESB timer"
> -#define ESB_DRIVER_NAME ESB_MODULE_NAME ", v" ESB_VERSION
>   
>   /* PCI configuration registers */
>   #define ESB_CONFIG_REG  0x60            /* Config register                   */
> @@ -76,11 +77,7 @@
>   
>   /* internal variables */
>   static void __iomem *BASEADDR;
> -static DEFINE_SPINLOCK(esb_lock); /* Guards the hardware */
> -static unsigned long timer_alive;
>   static struct pci_dev *esb_pci;
> -static unsigned short triggered; /* The status of the watchdog upon boot */
> -static char esb_expect_close;
>   
>   /* We can only use 1 card due to the /dev/watchdog restriction */
>   static int cards_found;
> @@ -88,7 +85,7 @@ static int cards_found;
>   /* module parameters */
>   /* 30 sec default heartbeat (1 < heartbeat < 2*1023) */
>   #define WATCHDOG_HEARTBEAT 30
> -static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
> +static int heartbeat; /* in seconds */
>   module_param(heartbeat, int, 0);
>   MODULE_PARM_DESC(heartbeat,
>   		"Watchdog heartbeat in seconds. (1<heartbeat<2046, default="
> @@ -116,55 +113,47 @@ static inline void esb_unlock_registers(void)
>   	writew(ESB_UNLOCK2, ESB_RELOAD_REG);
>   }
>   
> -static int esb_timer_start(void)
> +static int esb_timer_start(struct watchdog_device *wdd)
>   {
> +	int _wdd_nowayout = test_bit(WDOG_NO_WAY_OUT, &wdd->status);
>   	u8 val;
>   
> -	spin_lock(&esb_lock);
>   	esb_unlock_registers();
>   	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
>   	/* Enable or Enable + Lock? */
> -	val = ESB_WDT_ENABLE | (nowayout ? ESB_WDT_LOCK : 0x00);
> +	val = ESB_WDT_ENABLE | (_wdd_nowayout ? ESB_WDT_LOCK : 0x00);
>   	pci_write_config_byte(esb_pci, ESB_LOCK_REG, val);
> -	spin_unlock(&esb_lock);
>   	return 0;
>   }
>   
> -static int esb_timer_stop(void)
> +static int esb_timer_stop(struct watchdog_device *wdd)
>   {
>   	u8 val;
>   
> -	spin_lock(&esb_lock);
>   	/* First, reset timers as suggested by the docs */
>   	esb_unlock_registers();
>   	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
>   	/* Then disable the WDT */
>   	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x0);
>   	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val);
> -	spin_unlock(&esb_lock);
>   
>   	/* Returns 0 if the timer was disabled, non-zero otherwise */
>   	return val & ESB_WDT_ENABLE;
>   }
>   
> -static void esb_timer_keepalive(void)
> +static int esb_timer_keepalive(struct watchdog_device *wdd)
>   {
> -	spin_lock(&esb_lock);
>   	esb_unlock_registers();
>   	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
>   	/* FIXME: Do we need to flush anything here? */
> -	spin_unlock(&esb_lock);
> +	return 0;
>   }
>   
> -static int esb_timer_set_heartbeat(int time)
> +static int esb_timer_set_heartbeat(struct watchdog_device *wdd,
> +		unsigned int time)
>   {
>   	u32 val;
>   
> -	if (time < 0x1 || time > (2 * 0x03ff))
> -		return -EINVAL;
> -
> -	spin_lock(&esb_lock);
> -
>   	/* We shift by 9, so if we are passed a value of 1 sec,
>   	 * val will be 1 << 9 = 512, then write that to two
>   	 * timers => 2 * 512 = 1024 (which is decremented at 1KHz)
> @@ -186,148 +175,33 @@ static int esb_timer_set_heartbeat(int time)
>   	/* FIXME: Do we need to flush everything out? */
>   
>   	/* Done */
> -	heartbeat = time;
> -	spin_unlock(&esb_lock);
> +	wdd->timeout = time;
>   	return 0;
>   }
>   
>   /*
> - *	/dev/watchdog handling
> + * Watchdog Subsystem Interfaces
>    */
>   
> -static int esb_open(struct inode *inode, struct file *file)
> -{
> -	/* /dev/watchdog can only be opened once */
> -	if (test_and_set_bit(0, &timer_alive))
> -		return -EBUSY;
> -
> -	/* Reload and activate timer */
> -	esb_timer_start();
> -
> -	return nonseekable_open(inode, file);
> -}
> -
> -static int esb_release(struct inode *inode, struct file *file)
> -{
> -	/* Shut off the timer. */
> -	if (esb_expect_close == 42)
> -		esb_timer_stop();
> -	else {
> -		pr_crit("Unexpected close, not stopping watchdog!\n");
> -		esb_timer_keepalive();
> -	}
> -	clear_bit(0, &timer_alive);
> -	esb_expect_close = 0;
> -	return 0;
> -}
> -
> -static ssize_t esb_write(struct file *file, const char __user *data,
> -			  size_t len, loff_t *ppos)
> -{
> -	/* See if we got the magic character 'V' and reload the timer */
> -	if (len) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			/* note: just in case someone wrote the magic character
> -			 * five months ago... */
> -			esb_expect_close = 0;
> -
> -			/* scan to see whether or not we got the
> -			 * magic character */
> -			for (i = 0; i != len; i++) {
> -				char c;
> -				if (get_user(c, data + i))
> -					return -EFAULT;
> -				if (c == 'V')
> -					esb_expect_close = 42;
> -			}
> -		}
> -
> -		/* someone wrote to us, we should reload the timer */
> -		esb_timer_keepalive();
> -	}
> -	return len;
> -}
> -
> -static long esb_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	int new_options, retval = -EINVAL;
> -	int new_heartbeat;
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = argp;
> -	static const struct watchdog_info ident = {
> -		.options =		WDIOF_SETTIMEOUT |
> -					WDIOF_KEEPALIVEPING |
> -					WDIOF_MAGICCLOSE,
> -		.firmware_version =	0,
> -		.identity =		ESB_MODULE_NAME,
> -	};
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		return copy_to_user(argp, &ident,
> -					sizeof(ident)) ? -EFAULT : 0;
> -
> -	case WDIOC_GETSTATUS:
> -		return put_user(0, p);
> -
> -	case WDIOC_GETBOOTSTATUS:
> -		return put_user(triggered, p);
> -
> -	case WDIOC_SETOPTIONS:
> -	{
> -		if (get_user(new_options, p))
> -			return -EFAULT;
> -
> -		if (new_options & WDIOS_DISABLECARD) {
> -			esb_timer_stop();
> -			retval = 0;
> -		}
> -
> -		if (new_options & WDIOS_ENABLECARD) {
> -			esb_timer_start();
> -			retval = 0;
> -		}
> -		return retval;
> -	}
> -	case WDIOC_KEEPALIVE:
> -		esb_timer_keepalive();
> -		return 0;
> -
> -	case WDIOC_SETTIMEOUT:
> -	{
> -		if (get_user(new_heartbeat, p))
> -			return -EFAULT;
> -		if (esb_timer_set_heartbeat(new_heartbeat))
> -			return -EINVAL;
> -		esb_timer_keepalive();
> -		/* Fall */
> -	}
> -	case WDIOC_GETTIMEOUT:
> -		return put_user(heartbeat, p);
> -	default:
> -		return -ENOTTY;
> -	}
> -}
> -
> -/*
> - *      Kernel Interfaces
> - */
> +static struct watchdog_info esb_info = {
> +	.identity = ESB_MODULE_NAME,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +};
>   
> -static const struct file_operations esb_fops = {
> +static const struct watchdog_ops esb_ops = {
>   	.owner = THIS_MODULE,
> -	.llseek = no_llseek,
> -	.write = esb_write,
> -	.unlocked_ioctl = esb_ioctl,
> -	.open = esb_open,
> -	.release = esb_release,
> +	.start = esb_timer_start,
> +	.stop = esb_timer_stop,
> +	.set_timeout = esb_timer_set_heartbeat,
> +	.ping = esb_timer_keepalive,
>   };
>   
> -static struct miscdevice esb_miscdev = {
> -	.minor = WATCHDOG_MINOR,
> -	.name = "watchdog",
> -	.fops = &esb_fops,
> +static struct watchdog_device esb_dev = {
> +	.info = &esb_info,
> +	.ops = &esb_ops,
> +	.min_timeout = 1,
> +	.max_timeout = 2 * 0x03ff,
> +	.timeout = WATCHDOG_HEARTBEAT,
>   };
>   
>   /*
> @@ -346,19 +220,19 @@ MODULE_DEVICE_TABLE(pci, esb_pci_tbl);
>   static unsigned char esb_getdevice(struct pci_dev *pdev)
>   {
>   	if (pci_enable_device(pdev)) {
> -		pr_err("failed to enable device\n");
> +		dev_err(&pdev->dev, "failed to enable device\n");
>   		goto err_devput;
>   	}
>   
>   	if (pci_request_region(pdev, 0, ESB_MODULE_NAME)) {
> -		pr_err("failed to request region\n");
> +		dev_err(&pdev->dev, "failed to request region\n");
>   		goto err_disable;
>   	}
>   
>   	BASEADDR = pci_ioremap_bar(pdev, 0);
>   	if (BASEADDR == NULL) {
>   		/* Something's wrong here, BASEADDR has to be set */
> -		pr_err("failed to get BASEADDR\n");
> +		dev_err(&pdev->dev, "failed to get BASEADDR\n");
>   		goto err_release;
>   	}
>   
> @@ -396,7 +270,7 @@ static void esb_initdevice(void)
>   	/* Check that the WDT isn't already locked */
>   	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val1);
>   	if (val1 & ESB_WDT_LOCK)
> -		pr_warn("nowayout already set\n");
> +		dev_warn(&esb_pci->dev, "nowayout already set\n");
>   
>   	/* Set the timer to watchdog mode and disable it for now */
>   	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x00);
> @@ -405,14 +279,14 @@ static void esb_initdevice(void)
>   	esb_unlock_registers();
>   	val2 = readw(ESB_RELOAD_REG);
>   	if (val2 & ESB_WDT_TIMEOUT)
> -		triggered = WDIOF_CARDRESET;
> +		esb_dev.bootstatus = WDIOF_CARDRESET;
>   
>   	/* Reset WDT_TIMEOUT flag and timers */
>   	esb_unlock_registers();
>   	writew((ESB_WDT_TIMEOUT | ESB_WDT_RELOAD), ESB_RELOAD_REG);
>   
>   	/* And set the correct timeout value */
> -	esb_timer_set_heartbeat(heartbeat);
> +	esb_timer_set_heartbeat(&esb_dev, esb_dev.timeout);
>   }
>   
>   static int esb_probe(struct pci_dev *pdev,
> @@ -434,26 +308,25 @@ static int esb_probe(struct pci_dev *pdev,
>   	if (!esb_getdevice(pdev) || esb_pci == NULL)
>   		return -ENODEV;
>   
> -	/* Check that the heartbeat value is within it's range;
> -	   if not reset to the default */
> -	if (heartbeat < 0x1 || heartbeat > 2 * 0x03ff) {
> -		heartbeat = WATCHDOG_HEARTBEAT;
> -		pr_info("heartbeat value must be 1<heartbeat<2046, using %d\n",
> -			heartbeat);
> -	}
> -
>   	/* Initialize the watchdog and make sure it does not run */
> +	if (watchdog_init_timeout(&esb_dev, heartbeat, NULL))
> +		pr_info("heartbeat value must be 1<heartbeat<2046, using %u\n",
> +			esb_dev.timeout);
> +	watchdog_set_nowayout(&esb_dev, nowayout);
> +	watchdog_stop_on_reboot(&esb_dev);
> +	watchdog_stop_on_unregister(&esb_dev);
>   	esb_initdevice();
>   
>   	/* Register the watchdog so that userspace has access to it */
> -	ret = misc_register(&esb_miscdev);
> +	ret = watchdog_register_device(&esb_dev);
>   	if (ret != 0) {
> -		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -		       WATCHDOG_MINOR, ret);
> +		dev_err(&pdev->dev,
> +			"cannot register watchdog device (err=%d)\n", ret);
>   		goto err_unmap;
>   	}
> -	pr_info("initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
> -		BASEADDR, heartbeat, nowayout);
> +	dev_info(&pdev->dev,
> +		"initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
> +		BASEADDR, esb_dev.timeout, nowayout);
>   	return 0;
>   
>   err_unmap:
> @@ -466,29 +339,18 @@ static int esb_probe(struct pci_dev *pdev,
>   
>   static void esb_remove(struct pci_dev *pdev)
>   {
> -	/* Stop the timer before we leave */
> -	if (!nowayout)
> -		esb_timer_stop();
> -
> -	/* Deregister */
> -	misc_deregister(&esb_miscdev);
> +	watchdog_unregister_device(&esb_dev);
>   	iounmap(BASEADDR);
>   	pci_release_region(esb_pci, 0);
>   	pci_disable_device(esb_pci);
>   	esb_pci = NULL;
>   }
>   
> -static void esb_shutdown(struct pci_dev *pdev)
> -{
> -	esb_timer_stop();
> -}
> -
>   static struct pci_driver esb_driver = {
>   	.name		= ESB_MODULE_NAME,
>   	.id_table	= esb_pci_tbl,
>   	.probe          = esb_probe,
>   	.remove         = esb_remove,
> -	.shutdown       = esb_shutdown,
>   };
>   
>   module_pci_driver(esb_driver);
> 

