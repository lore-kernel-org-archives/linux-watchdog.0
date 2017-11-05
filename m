Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:53929 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKEPft (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 5 Nov 2017 10:35:49 -0500
Received: by mail-pf0-f194.google.com with SMTP id t188so5854102pfd.10
        for <linux-watchdog@vger.kernel.org>; Sun, 05 Nov 2017 07:35:49 -0800 (PST)
Date: Sun, 5 Nov 2017 07:35:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [1/2] watchdog: xen_wdt: use the watchdog subsystem
Message-ID: <20171105153546.GA27613@roeck-us.net>
References: <20171103153153.9992-2-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103153153.9992-2-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 03, 2017 at 03:31:52PM +0000, Radu Rendec wrote:
> Change the xen_wdt driver to use the watchdog subsystem instead of
> registering and manipulating the char device directly through the misc
> API. This is mainly getting rid of the "write" and "ioctl" methods and
> part of the watchdog control logic (which are all implemented by the
> watchdog subsystem).
> 
> Even though the watchdog subsystem supports registering and handling
> multiple watchdog devices at the same time, the xen_wdt driver has an
> inherent limitation of only one device due to the way the Xen hypervisor
> exposes watchdog functionality. However, the driver can now coexist with
> other watchdog devices (supported by different drivers).
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>

Can you rebase the patch on top of Arnd's patch ("watchdog: xen: use time64_t
for timeouts") ?

> ---
>  drivers/watchdog/xen_wdt.c | 204 +++++++++------------------------------------
>  1 file changed, 38 insertions(+), 166 deletions(-)
> 
> diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
> index cf0e650c2015..8bea946dfdc7 100644
> --- a/drivers/watchdog/xen_wdt.c
> +++ b/drivers/watchdog/xen_wdt.c
> @@ -33,13 +33,11 @@
>  #include <xen/interface/sched.h>
>  
#include <linux/miscdevice.h>
#include <linux/spinlock.h>
#include <linux/uaccess.h>

should now be unnecessary.

>  static struct platform_device *platform_device;
> -static DEFINE_SPINLOCK(wdt_lock);
>  static struct sched_watchdog wdt;
>  static __kernel_time_t wdt_expires;
> -static bool is_active, expect_release;
>  
>  #define WATCHDOG_TIMEOUT 60 /* in seconds */
> -static unsigned int timeout = WATCHDOG_TIMEOUT;
> +static unsigned int timeout;
>  module_param(timeout, uint, S_IRUGO);
>  MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
>  	"(default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
> @@ -49,20 +47,18 @@ module_param(nowayout, bool, S_IRUGO);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>  	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> -static inline __kernel_time_t set_timeout(void)
> +static inline __kernel_time_t set_timeout(struct watchdog_device *wdd)
>  {
> -	wdt.timeout = timeout;
> -	return ktime_to_timespec(ktime_get()).tv_sec + timeout;
> +	wdt.timeout = wdd->timeout;
> +	return ktime_to_timespec(ktime_get()).tv_sec + wdd->timeout;
>  }
>  
> -static int xen_wdt_start(void)
> +static int xen_wdt_start(struct watchdog_device *wdd)
>  {
>  	__kernel_time_t expires;
>  	int err;
>  
> -	spin_lock(&wdt_lock);
> -
> -	expires = set_timeout();
> +	expires = set_timeout(wdd);
>  	if (!wdt.id)
>  		err = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wdt);
>  	else
> @@ -74,36 +70,28 @@ static int xen_wdt_start(void)
>  	} else
>  		BUG_ON(!err);
>  
> -	spin_unlock(&wdt_lock);
> -
>  	return err;
>  }
>  
> -static int xen_wdt_stop(void)
> +static int xen_wdt_stop(struct watchdog_device *wdd)
>  {
>  	int err = 0;
>  
> -	spin_lock(&wdt_lock);
> -
>  	wdt.timeout = 0;
>  	if (wdt.id)
>  		err = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wdt);
>  	if (!err)
>  		wdt.id = 0;
>  
> -	spin_unlock(&wdt_lock);
> -
>  	return err;
>  }
>  
> -static int xen_wdt_kick(void)
> +static int xen_wdt_kick(struct watchdog_device *wdd)
>  {
>  	__kernel_time_t expires;
>  	int err;
>  
> -	spin_lock(&wdt_lock);
> -
> -	expires = set_timeout();
> +	expires = set_timeout(wdd);
>  	if (wdt.id)
>  		err = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wdt);
>  	else
> @@ -111,137 +99,31 @@ static int xen_wdt_kick(void)
>  	if (!err)
>  		wdt_expires = expires;
>  
> -	spin_unlock(&wdt_lock);
> -
> -	return err;
> -}
> -
> -static int xen_wdt_open(struct inode *inode, struct file *file)
> -{
> -	int err;
> -
> -	/* /dev/watchdog can only be opened once */
> -	if (xchg(&is_active, true))
> -		return -EBUSY;
> -
> -	err = xen_wdt_start();
> -	if (err == -EBUSY)
> -		err = xen_wdt_kick();
> -	return err ?: nonseekable_open(inode, file);
> -}
> -
> -static int xen_wdt_release(struct inode *inode, struct file *file)
> -{
> -	int err = 0;
> -
> -	if (expect_release)
> -		err = xen_wdt_stop();
> -	else {
> -		pr_crit("unexpected close, not stopping watchdog!\n");
> -		xen_wdt_kick();
> -	}
> -	is_active = err;
> -	expect_release = false;
>  	return err;
>  }
>  
> -static ssize_t xen_wdt_write(struct file *file, const char __user *data,
> -			     size_t len, loff_t *ppos)
> +static unsigned int xen_wdt_get_timeleft(struct watchdog_device *wdd)
>  {
> -	/* See if we got the magic character 'V' and reload the timer */
> -	if (len) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			/* in case it was set long ago */
> -			expect_release = false;
> -
> -			/* scan to see whether or not we got the magic
> -			   character */
> -			for (i = 0; i != len; i++) {
> -				char c;
> -				if (get_user(c, data + i))
> -					return -EFAULT;
> -				if (c == 'V')
> -					expect_release = true;
> -			}
> -		}
> -
> -		/* someone wrote to us, we should reload the timer */
> -		xen_wdt_kick();
> -	}
> -	return len;
> +	return wdt_expires - ktime_to_timespec(ktime_get()).tv_sec;
>  }
>  
> -static long xen_wdt_ioctl(struct file *file, unsigned int cmd,
> -			  unsigned long arg)
> -{
> -	int new_options, retval = -EINVAL;
> -	int new_timeout;
> -	int __user *argp = (void __user *)arg;
> -	static const struct watchdog_info ident = {
> -		.options =		WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> -		.firmware_version =	0,
> -		.identity =		DRV_NAME,
> -	};
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
> -
> -	case WDIOC_GETSTATUS:
> -	case WDIOC_GETBOOTSTATUS:
> -		return put_user(0, argp);
> -
> -	case WDIOC_SETOPTIONS:
> -		if (get_user(new_options, argp))
> -			return -EFAULT;
> -
> -		if (new_options & WDIOS_DISABLECARD)
> -			retval = xen_wdt_stop();
> -		if (new_options & WDIOS_ENABLECARD) {
> -			retval = xen_wdt_start();
> -			if (retval == -EBUSY)
> -				retval = xen_wdt_kick();
> -		}
> -		return retval;
> -
> -	case WDIOC_KEEPALIVE:
> -		xen_wdt_kick();
> -		return 0;
> -
> -	case WDIOC_SETTIMEOUT:
> -		if (get_user(new_timeout, argp))
> -			return -EFAULT;
> -		if (!new_timeout)
> -			return -EINVAL;
> -		timeout = new_timeout;
> -		xen_wdt_kick();
> -		/* fall through */
> -	case WDIOC_GETTIMEOUT:
> -		return put_user(timeout, argp);
> -
> -	case WDIOC_GETTIMELEFT:
> -		retval = wdt_expires - ktime_to_timespec(ktime_get()).tv_sec;
> -		return put_user(retval, argp);
> -	}
> -
> -	return -ENOTTY;
> -}
> +static struct watchdog_info xen_wdt_info = {
> +	.identity = DRV_NAME,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +};
>  
> -static const struct file_operations xen_wdt_fops = {
> -	.owner =		THIS_MODULE,
> -	.llseek =		no_llseek,
> -	.write =		xen_wdt_write,
> -	.unlocked_ioctl =	xen_wdt_ioctl,
> -	.open =			xen_wdt_open,
> -	.release =		xen_wdt_release,
> +static const struct watchdog_ops xen_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = xen_wdt_start,
> +	.stop = xen_wdt_stop,
> +	.ping = xen_wdt_kick,
> +	.get_timeleft = xen_wdt_get_timeleft,
>  };
>  
> -static struct miscdevice xen_wdt_miscdev = {
> -	.minor =	WATCHDOG_MINOR,
> -	.name =		"watchdog",
> -	.fops =		&xen_wdt_fops,
> +static struct watchdog_device xen_wdt_dev = {
> +	.info = &xen_wdt_info,
> +	.ops = &xen_wdt_ops,
> +	.timeout = WATCHDOG_TIMEOUT,
>  };
>  
>  static int xen_wdt_probe(struct platform_device *dev)
> @@ -251,20 +133,21 @@ static int xen_wdt_probe(struct platform_device *dev)
>  
>  	switch (ret) {
>  	case -EINVAL:
> -		if (!timeout) {
> -			timeout = WATCHDOG_TIMEOUT;
> -			pr_info("timeout value invalid, using %d\n", timeout);
> -		}
> -
> -		ret = misc_register(&xen_wdt_miscdev);
> +		if (watchdog_init_timeout(&xen_wdt_dev, timeout, NULL))
> +			pr_info("timeout value invalid, using %d\n",
> +				xen_wdt_dev.timeout);
> +		watchdog_set_nowayout(&xen_wdt_dev, nowayout);
> +		watchdog_stop_on_reboot(&xen_wdt_dev);
> +		watchdog_stop_on_unregister(&xen_wdt_dev);
> +
> +		ret = watchdog_register_device(&xen_wdt_dev);

Please consider using devm_watchdog_register_device() and drop the remove
function entirely.

>  		if (ret) {
> -			pr_err("cannot register miscdev on minor=%d (%d)\n",
> -			       WATCHDOG_MINOR, ret);
> +			pr_err("cannot register watchdog device (%d)\n", ret);
>  			break;
>  		}
>  
>  		pr_info("initialized (timeout=%ds, nowayout=%d)\n",
> -			timeout, nowayout);
> +			xen_wdt_dev.timeout, nowayout);

Maybe convert messages to dev_err() and dev_info().

>  		break;
>  
>  	case -ENOSYS:
> @@ -282,24 +165,14 @@ static int xen_wdt_probe(struct platform_device *dev)
>  

The probe function is quite odd. It may return 0 (no error) but not
initialize the watchdog. It might be better to reorganize the code
along the line of

	int ret = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wd);

	if (ret != -EINVAL) {
		/* pick your preferred error message */
		dev_err(&pdev->dev, "Hypervisor error (%d)\n", ret);
		return -ENODEV;
	}

	...

>  static int xen_wdt_remove(struct platform_device *dev)
>  {
> -	/* Stop the timer before we leave */
> -	if (!nowayout)
> -		xen_wdt_stop();
> -
> -	misc_deregister(&xen_wdt_miscdev);
> -
> +	watchdog_unregister_device(&xen_wdt_dev);
>  	return 0;
>  }
>  
> -static void xen_wdt_shutdown(struct platform_device *dev)
> -{
> -	xen_wdt_stop();
> -}
> -
>  static int xen_wdt_suspend(struct platform_device *dev, pm_message_t state)
>  {
>  	typeof(wdt.id) id = wdt.id;
> -	int rc = xen_wdt_stop();
> +	int rc = xen_wdt_stop(&xen_wdt_dev);
>  
>  	wdt.id = id;
>  	return rc;
> @@ -310,13 +183,12 @@ static int xen_wdt_resume(struct platform_device *dev)
>  	if (!wdt.id)
>  		return 0;
>  	wdt.id = 0;
> -	return xen_wdt_start();
> +	return xen_wdt_start(&xen_wdt_dev);
>  }
>  
>  static struct platform_driver xen_wdt_driver = {
>  	.probe          = xen_wdt_probe,
>  	.remove         = xen_wdt_remove,
> -	.shutdown       = xen_wdt_shutdown,
>  	.suspend        = xen_wdt_suspend,
>  	.resume         = xen_wdt_resume,
>  	.driver         = {

For module initialization: Any chance to use module_platform_driver_probe() ?

