Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:54745 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdJVRCM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:02:12 -0400
Received: by mail-pg0-f65.google.com with SMTP id l24so10034970pgu.11
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:02:12 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:02:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [1/3] watchdog: i6300esb: use the watchdog subsystem
Message-ID: <20171022170210.GA24573@roeck-us.net>
References: <20171016182528.3244-1-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171016182528.3244-1-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 16, 2017 at 07:25:26PM +0100, Radu Rendec wrote:
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
> ---
>  drivers/watchdog/i6300esb.c | 191 +++++++++-----------------------------------
>  1 file changed, 39 insertions(+), 152 deletions(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index d7befd58b391..1df41a09553c 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -21,6 +21,8 @@
>   *	Version 0.02
>   *  20050210 David Härdeman <david@2gen.com>
>   *	Ported driver to kernel 2.6
> + *  20171016 Radu Rendec <rrendec@arista.com>
> + *	Change driver to use the watchdog subsystem
>   */
>  
>  /*
> @@ -77,10 +79,7 @@
>  /* internal variables */
>  static void __iomem *BASEADDR;
>  static DEFINE_SPINLOCK(esb_lock); /* Guards the hardware */
> -static unsigned long timer_alive;
>  static struct pci_dev *esb_pci;
> -static unsigned short triggered; /* The status of the watchdog upon boot */
> -static char esb_expect_close;
>  
>  /* We can only use 1 card due to the /dev/watchdog restriction */
>  static int cards_found;
> @@ -116,21 +115,22 @@ static inline void esb_unlock_registers(void)
>  	writew(ESB_UNLOCK2, ESB_RELOAD_REG);
>  }
>  
> -static int esb_timer_start(void)
> +static int esb_timer_start(struct watchdog_device *wdd)
>  {
> +	int _wdd_nowayout = test_bit(WDOG_NO_WAY_OUT, &wdd->status);
>  	u8 val;
>  
>  	spin_lock(&esb_lock);
>  	esb_unlock_registers();
>  	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
>  	/* Enable or Enable + Lock? */
> -	val = ESB_WDT_ENABLE | (nowayout ? ESB_WDT_LOCK : 0x00);
> +	val = ESB_WDT_ENABLE | (_wdd_nowayout ? ESB_WDT_LOCK : 0x00);
>  	pci_write_config_byte(esb_pci, ESB_LOCK_REG, val);
>  	spin_unlock(&esb_lock);
>  	return 0;
>  }
>  
> -static int esb_timer_stop(void)
> +static int esb_timer_stop(struct watchdog_device *wdd)
>  {
>  	u8 val;
>  
> @@ -147,22 +147,21 @@ static int esb_timer_stop(void)
>  	return val & ESB_WDT_ENABLE;
>  }
>  
> -static void esb_timer_keepalive(void)
> +static int esb_timer_keepalive(struct watchdog_device *wdd)
>  {
>  	spin_lock(&esb_lock);
>  	esb_unlock_registers();
>  	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
>  	/* FIXME: Do we need to flush anything here? */
>  	spin_unlock(&esb_lock);
> +	return 0;
>  }
>  
> -static int esb_timer_set_heartbeat(int time)
> +static int esb_timer_set_heartbeat(struct watchdog_device *wdd,
> +		unsigned int time)
>  {
>  	u32 val;
>  
> -	if (time < 0x1 || time > (2 * 0x03ff))
> -		return -EINVAL;
> -
>  	spin_lock(&esb_lock);
>  
>  	/* We shift by 9, so if we are passed a value of 1 sec,
> @@ -186,148 +185,33 @@ static int esb_timer_set_heartbeat(int time)
>  	/* FIXME: Do we need to flush everything out? */
>  
>  	/* Done */
> -	heartbeat = time;
>  	spin_unlock(&esb_lock);

Needs to set wdt->timeout.

>  	return 0;
>  }
>  
>  /*
> - *	/dev/watchdog handling
> + * Watchdog Subsystem Interfaces
>   */
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
>  	.owner = THIS_MODULE,
> -	.llseek = no_llseek,
> -	.write = esb_write,
> -	.unlocked_ioctl = esb_ioctl,
> -	.open = esb_open,
> -	.release = esb_release,
> +	.start = esb_timer_start,
> +	.stop = esb_timer_stop,
> +	.set_timeout = esb_timer_set_heartbeat,
> +	.ping = esb_timer_keepalive,
>  };
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
>  };
>  
>  /*
> @@ -405,14 +289,14 @@ static void esb_initdevice(void)
>  	esb_unlock_registers();
>  	val2 = readw(ESB_RELOAD_REG);
>  	if (val2 & ESB_WDT_TIMEOUT)
> -		triggered = WDIOF_CARDRESET;
> +		esb_dev.bootstatus = WDIOF_CARDRESET;
>  
>  	/* Reset WDT_TIMEOUT flag and timers */
>  	esb_unlock_registers();
>  	writew((ESB_WDT_TIMEOUT | ESB_WDT_RELOAD), ESB_RELOAD_REG);
>  
>  	/* And set the correct timeout value */
> -	esb_timer_set_heartbeat(heartbeat);
> +	esb_timer_set_heartbeat(&esb_dev, esb_dev.timeout);
>  }
>  
>  static int esb_probe(struct pci_dev *pdev,
> @@ -443,17 +327,18 @@ static int esb_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Initialize the watchdog and make sure it does not run */
> +	watchdog_init_timeout(&esb_dev, heartbeat, NULL);
> +	watchdog_set_nowayout(&esb_dev, nowayout);
>  	esb_initdevice();
>  
>  	/* Register the watchdog so that userspace has access to it */
> -	ret = misc_register(&esb_miscdev);
> +	ret = watchdog_register_device(&esb_dev);
>  	if (ret != 0) {
> -		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -		       WATCHDOG_MINOR, ret);
> +		pr_err("cannot register watchdog device (err=%d)\n", ret);

dev_err()

>  		goto err_unmap;
>  	}
>  	pr_info("initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",

dev_info()

> -		BASEADDR, heartbeat, nowayout);
> +		BASEADDR, esb_dev.timeout, nowayout);
>  	return 0;
>  
>  err_unmap:
> @@ -466,12 +351,14 @@ static int esb_probe(struct pci_dev *pdev,
>  
>  static void esb_remove(struct pci_dev *pdev)
>  {
> +	int _wdd_nowayout = test_bit(WDOG_NO_WAY_OUT, &esb_dev.status);
> +
>  	/* Stop the timer before we leave */
> -	if (!nowayout)
> -		esb_timer_stop();
> +	if (!_wdd_nowayout)
> +		esb_timer_stop(&esb_dev);

Can you call watchdog_stop_on_unregister() in probe instead ?

>  
>  	/* Deregister */
> -	misc_deregister(&esb_miscdev);
> +	watchdog_unregister_device(&esb_dev);
>  	iounmap(BASEADDR);
>  	pci_release_region(esb_pci, 0);
>  	pci_disable_device(esb_pci);
> @@ -480,7 +367,7 @@ static void esb_remove(struct pci_dev *pdev)
>  
>  static void esb_shutdown(struct pci_dev *pdev)
>  {
> -	esb_timer_stop();
> +	esb_timer_stop(&esb_dev);

Call watchdog_stop_on_reboot() in probe ?

>  }
>  
>  static struct pci_driver esb_driver = {
