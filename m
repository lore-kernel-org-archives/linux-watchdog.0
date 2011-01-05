Date: Wed, 5 Jan 2011 23:49:10 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110105234910.GD2112@gallagher>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
 <1294257379-417-6-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1294257379-417-6-git-send-email-blogic@openwrt.org>
Return-Path: <jamie@jamieiles.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi John,

A few nitpicks inline, but otherwise looks good to me.

Jamie

On Wed, Jan 05, 2011 at 08:56:14PM +0100, John Crispin wrote:
> This patch adds the driver for the watchdog found inside the Lantiq SoC family.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org
> ---
>  drivers/watchdog/Kconfig      |    6 +
>  drivers/watchdog/Makefile     |    1 +
>  drivers/watchdog/lantiq_wdt.c |  208 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 215 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/lantiq_wdt.c
[...]
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> new file mode 100644
> index 0000000..543bcf1
> --- /dev/null
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -0,0 +1,208 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + *  Based on EP93xx wdt driver
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/miscdevice.h>

Duplicated include of linux/miscdevice.h

> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/uaccess.h>
> +#include <linux/clk.h>
> +
> +#include <lantiq.h>
> +
> +#define LTQ_WDT_PW1			0x00BE0000
> +#define LTQ_WDT_PW2			0x00DC0000
> +
> +#define LTQ_BIU_WDT_CR		0x3F0
> +#define LTQ_BIU_WDT_SR		0x3F8

It's not obvious to me what these defines actually mean. A couple of 
short comments to describe what they are?
> +
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +static int wdt_ok_to_close;
> +#endif
> +
> +static int wdt_timeout = 30;
> +static __iomem void *wdt_membase;

I think this would normally be "static void __iomem" rather than "static 
__iomem void". Also these could do with the ltq_ prefix for namespacing.

> +static unsigned long io_region_clk;

Better to name this io_region_clk_rate?

> +
> +static int
> +ltq_wdt_enable(unsigned int timeout)
> +{
> +	ltq_w32(LTQ_WDT_PW1, wdt_membase + LTQ_BIU_WDT_CR);
> +	ltq_w32(LTQ_WDT_PW2 |
> +		(0x3 << 26) | /* PWL */
> +		(0x3 << 24) | /* CLKDIV */
> +		(0x1 << 31) | /* enable */
> +		((timeout * (io_region_clk / 0x40000)) + 0x1000), /* reload */
> +			wdt_membase + LTQ_BIU_WDT_CR);

Perhaps a comment describing the how this value is calculated? What does 
PWL mean and what are the significance of 0x40000 and 0x1000? Also, do 
you need to check that the timeout won't overflow the bits for the 
reload value?

> +	return 0;
> +}
> +
> +static void
> +ltq_wdt_disable(void)
> +{
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	wdt_ok_to_close = 0;
> +#endif
> +	ltq_w32(LTQ_WDT_PW1, wdt_membase + LTQ_BIU_WDT_CR);
> +	ltq_w32(LTQ_WDT_PW2, wdt_membase + LTQ_BIU_WDT_CR);
> +}
> +
> +static ssize_t
> +ltq_wdt_write(struct file *file, const char __user *data,
> +		size_t len, loff_t *ppos)
> +{
> +	size_t i;
> +	if (!len)
> +		return 0;
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	for (i = 0; i != len; i++) {
> +		char c;
> +		if (get_user(c, data + i))
> +			return -EFAULT;
> +		if (c == 'V')
> +			wdt_ok_to_close = 1;
> +	}
> +#endif
> +	ltq_wdt_enable(wdt_timeout);
> +	return len;
> +}
> +
> +static struct watchdog_info ident = {
> +	.options = WDIOF_MAGICCLOSE,

I think you can also add WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING.

> +	.identity = "ltq_wdt",
> +};
> +
> +static long
> +ltq_wdt_ioctl(struct file *file,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	int ret = -ENOTTY;
> +	switch (cmd) {
> +	case WDIOC_GETSUPPORT:
> +		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
> +				sizeof(ident)) ? -EFAULT : 0;
> +		break;
> +
> +	case WDIOC_GETTIMEOUT:
> +		ret = put_user(wdt_timeout, (int __user *)arg);
> +		break;
> +
> +	case WDIOC_SETTIMEOUT:
> +		ret = get_user(wdt_timeout, (int __user *)arg);

Should you reset the WDT with the new timeout here rather than waiting 
for the next keepalive?

> +		break;
> +
> +	case WDIOC_KEEPALIVE:
> +		ltq_wdt_enable(wdt_timeout);
> +		ret = 0;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int
> +ltq_wdt_open(struct inode *inode, struct file *file)
> +{
> +	ltq_wdt_enable(wdt_timeout);
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int
> +ltq_wdt_release(struct inode *inode, struct file *file)
> +{
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	if (wdt_ok_to_close)
> +		ltq_wdt_disable();
> +	else
> +#endif
> +		printk(KERN_ERR "ltq_wdt: watchdog closed without warning,"
> +			" rebooting system\n");
> +	return 0;
> +}
> +
> +static const struct file_operations ltq_wdt_fops = {
> +	.owner			= THIS_MODULE,
> +	.write			= ltq_wdt_write,
> +	.unlocked_ioctl	= ltq_wdt_ioctl,

Align the .unlocked_ioctl assignment with the others?

> +	.open			= ltq_wdt_open,
> +	.release		= ltq_wdt_release,

Add ".llseek = no_llseek"?

> +};
> +
> +static struct miscdevice ltq_wdt_miscdev = {
> +	.minor		= WATCHDOG_MINOR,
> +	.name		= "watchdog",
> +	.fops		= &ltq_wdt_fops,
> +};
> +
> +static int
> +ltq_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct clk *clk;
> +	int ret = 0;
> +	if (!res)
> +		return -ENOENT;
> +	res = request_mem_region(res->start, resource_size(res),
> +		dev_name(&pdev->dev));
> +	if (!res)
> +		return -EBUSY;
> +	wdt_membase = ioremap_nocache(res->start, resource_size(res));
> +	if (!wdt_membase) {
> +		ret = -ENOMEM;
> +		goto err_release_mem_region;
> +	}

You can use devm_request_mem_region() and devm_ioremap_nocache() to 
simplify the error handling and removal.

> +	clk = clk_get(&pdev->dev, "io");

Do you need a clk_enable() here too? Or a comment explaining it's always 
enabled (if it is)?

> +	io_region_clk = clk_get_rate(clk);;
> +	ret = misc_register(&ltq_wdt_miscdev);
> +	if (!ret)
> +		return 0;
> +
> +	iounmap(wdt_membase);
> +err_release_mem_region:
> +	release_mem_region(res->start, resource_size(res));
> +	return ret;
> +}
> +
> +static int
> +ltq_wdt_remove(struct platform_device *dev)
> +{
> +	ltq_wdt_disable();
> +	misc_deregister(&ltq_wdt_miscdev);

I think you need a clk_put() here too to balance the clk_get() in the 
probe method so you'll need to keep a reference to the clk.

> +	return 0;
> +}
> +
> +static struct platform_driver ltq_wdt_driver = {
> +	.probe = ltq_wdt_probe,
> +	.remove = ltq_wdt_remove,
> +	.driver = {
> +		.name = "ltq_wdt",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init
> +init_ltq_wdt(void)
> +{
> +	return platform_driver_register(&ltq_wdt_driver);
> +}
> +
> +static void __exit
> +exit_ltq_wdt(void)
> +{
> +	platform_driver_unregister(&ltq_wdt_driver);
> +}
> +
> +module_init(init_ltq_wdt);
> +module_exit(exit_ltq_wdt);
> +
> +MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
> +MODULE_DESCRIPTION("Lantiq Watchdog");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
