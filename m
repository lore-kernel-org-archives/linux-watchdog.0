Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62039 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab1ADN1s (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Jan 2011 08:27:48 -0500
Received: by wwa36 with SMTP id 36so15156086wwa.1
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Jan 2011 05:27:46 -0800 (PST)
Date: Tue, 4 Jan 2011 13:27:42 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: Macpaul Lin <macpaul@andestech.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog/ftwdt010: Release Faraday ftwdt010 watchdog
Message-ID: <20110104132742.GA15553@pulham.picochip.com>
References: <1294126494-8119-1-git-send-email-macpaul@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1294126494-8119-1-git-send-email-macpaul@andestech.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

A few minor comments inline. It's also worth running your patch through 
scripts/checkpatch.pl as there are some useful warnings in there.

Jamie

On Tue, Jan 04, 2011 at 03:34:54PM +0800, Macpaul Lin wrote:
> Support Faraday ftwdt010 watchdog driver.
> 
> Signed-off-by: Macpaul Lin <macpaul@andestech.com>
> ---
>  drivers/watchdog/Kconfig        |    6 ++
>  drivers/watchdog/Makefile       |    1 +
>  drivers/watchdog/ftwdt010_wdt.c |  178 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 185 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/ftwdt010_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3711b88..86deb80 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -55,6 +55,12 @@ config SOFT_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called softdog.
>  
> +config FTWDT010_WATCHDOG
> +	tristate "FTWDT010_WATCHDOG"
> +	help
> +	  Support for Faraday ftwdt010 watchdog. When the watchdog triigers the

s/triigers/triggers

> +	  system will be reset.
> +
>  config WM831X_WATCHDOG
>  	tristate "WM831x watchdog"
>  	depends on MFD_WM831X
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 699199b..a3b9bee 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -142,6 +142,7 @@ obj-$(CONFIG_WATCHDOG_CP1XXX)		+= cpwd.o
>  # XTENSA Architecture
>  
>  # Architecture Independant
> +obj-$(CONFIG_FTWDT010_WATCHDOG) += ftwdt010_wdt.o
>  obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
>  obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
>  obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
> diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
> new file mode 100644
> index 0000000..41447d1
> --- /dev/null
> +++ b/drivers/watchdog/ftwdt010_wdt.c
> @@ -0,0 +1,178 @@
> +/*
> + *  Watchdog driver for the FTWDT010 Watch Dog Driver
> + *
> + *      (c) Copyright 2004 Faraday Technology Corp. (www.faraday-tech.com)
> + *      Based on sa1100_wdt.c by Oleg Drokin <green@crimea.edu>
> + *      Based on SoftDog driver by Alan Cox <alan@redhat.com>
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License
> + *  as published by the Free Software Foundation; either version
> + *  2 of the License, or (at your option) any later version.
> + *
> + *      27/11/2004 Initial release
> + */
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/watchdog.h>
> +#include <linux/smp_lock.h>
> +#include <linux/delay.h>

I don't think your driver needs smp_lock.h and delay.h.

> +#include <asm/uaccess.h>
> +
> +#define DEBUG( str, ...)			\
> +	do{					\
> +		if( debug)			\
> +		printk( str, ##__VA_ARGS__);	\
> +	} while(0)

Best to use dev_dbg() rather than creating new macros for this.

> +#define wdcounter	(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x00))
> +#define wdload		(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x04))
> +#define wdrestart	(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x08))
> +#define wdcr		(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x0C))
> +#define wdstatus	(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x10))
> +#define wdclear		(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x14))
> +#define wdintrcter	(*( volatile unsigned long *)( WDT_FTWDT010_VA_BASE + 0x18))

You shouldn't really be using direct accessors and volatile like this. 
The usual way would be to have something like a platform_device and then 
a platform_driver and ioremap() the memory. You can then use ioreadN() 
and iowriteN() to access the registers and you can cope with platforms 
where the WDT is in different locations.

> +#define TIMER_MARGIN	60	/* (secs) Default is 1 minute */
> +#define RESTART_MAGIC	0x5AB9
> +#define PCLK		(AHB_CLK_IN / 2)

Do you need to use the clk API (linux/clk.h) to make sure that the pclk 
is enabled? You could also use clk_get_rate() to make sure that this 
driver works on different speed devices.

> +static int debug = 0;
> +static int timeout = TIMER_MARGIN;  /* in seconds */
> +
> +module_param(debug, int, 0);
> +module_param(timeout, int, 0);

It's nice if you use MODULE_PARM_DESC() here to provide some 
documentation for the timeout. If you use dev_dbg() then you can 
probably lose the debug parameter.

> +
> +static int ftwdt010_dog_open(struct inode *inode, struct file *file){
> +
> +#if 0
> +	/* Allow only one person to hold it open */
> +	if( test_and_set_bit( 1, &ftwdt010_wdt_users))
> +		return -EBUSY;
> +
> +	ftwdt010_wdt_users = 1;
> +#endif

Why the #if 0?

> +	DEBUG("Activating WDT..\n");
> +
> +	wdcr = 0;
> +	wdload = PCLK * timeout;
> +	wdrestart = RESTART_MAGIC;	/* Magic number */
> +	wdcr = 0x03;			/* Enable WDT */
> +
> +	return 0;

return nonseekable_open()?

> +}
> +
> +static int ftwdt010_dog_release(struct inode *inode, struct file *file){
> +
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	/*
> +	 *  Shut off the timer.
> +	 *  Lock it in if it's a module and we defined ...NOWAYOUT
> +	 */
> +	wdcr = 0;
> +	DEBUG( "Deactivating WDT..\n");
> +#endif
> +	return 0;
> +}
> +
> +static ssize_t ftwdt010_dog_write(struct file *file, const char *data, size_t len, loff_t *ppos){
> +
> +	if(len){
> +

Extraneous blank line.

> +		wdrestart = RESTART_MAGIC;
> +		return 1;

Most other drivers return the length of the buffer rather than 1 here.

> +	}
> +
> +	return 0;
> +}
> +
> +static int ftwdt010_dog_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg){

We should be using unlocked_ioctl now so this should return a long.

> +
> +	static struct watchdog_info ident = {
> +		.identity = "FTWDT010 watchdog",
> +	};
> +
> +	int time = 0;
> +	void __user *argp = (void __user *)arg;
> +	int __user *p = argp;
> +
> +	switch( cmd){
> +
> +		case WDIOC_GETSUPPORT:
> +			return copy_to_user(argp, &ident, sizeof( ident));
> +
> +		case WDIOC_GETSTATUS:
> +			return put_user(0, p);
> +
> +		case WDIOC_GETBOOTSTATUS:
> +			return put_user(wdstatus ? WDIOF_CARDRESET : 0, p);
> +
> +		case WDIOC_SETTIMEOUT:
> +
> +			if( get_user( time, p))
> +				return 0;
> +
> +			if( time <= 0 || time > 255)
> +
> +				return -EINVAL;
> +
> +			timeout = time;
> +			wdload = PCLK * timeout;
> +			wdrestart = RESTART_MAGIC;
> +
> +			return put_user(timeout, p);
> +
> +		case WDIOC_GETTIMEOUT:
> +			return put_user(timeout, p);
> +
> +		case WDIOC_KEEPALIVE:
> +			wdrestart = RESTART_MAGIC;
> +			return 0;
> +
> +		default:
> +			return -ENOIOCTLCMD;
> +
> +	}
> +}
> +
> +static struct file_operations ftwdt010_dog_fops = {
> +
> +	.owner		= THIS_MODULE,
> +	.llseek		= no_llseek,
> +	.write		= ftwdt010_dog_write,
> +	.ioctl		= ftwdt010_dog_ioctl,

.unlocked_ioctl rather than .ioctl.

> +	.open		= ftwdt010_dog_open,
> +	.release	= ftwdt010_dog_release,
> +};

This could be const.

> +
> +static struct miscdevice ftwdt010_dog_miscdev = {
> +
> +	WATCHDOG_MINOR,
> +	"FTWDT010 watchdog",
> +	&ftwdt010_dog_fops
> +};

Better to use explicit initializers here (.minor = WATCHDOG_MINOR...) 
etc.

> +
> +static int __init ftwdt010_dog_init( void){
> +
> +	int ret;
> +
> +	ret = misc_register(&ftwdt010_dog_miscdev);
> +
> +	if( ret)
> +		return ret;
> +
> +	DEBUG("FTWDT010 watchdog timer: timer timeout %d sec\n", timeout);
> +
> +	return 0;
> +}
> +
> +static void __exit ftwdt010_dog_exit( void){
> +
> +	misc_deregister(&ftwdt010_dog_miscdev);
> +}
> +
> +module_init(ftwdt010_dog_init);
> +module_exit(ftwdt010_dog_exit);
> +MODULE_AUTHOR("Faraday Corp.");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
