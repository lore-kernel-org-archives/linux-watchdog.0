Message-ID: <4D6E286D.9050100@mvista.com>
Date: Wed, 02 Mar 2011 14:22:21 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: John Crispin <blogic@openwrt.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1298996006-15960-6-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hello.

On 01-03-2011 19:13, John Crispin wrote:

> This patch adds the driver for the watchdog found inside the Lantiq SoC family.

> Changes in V2
> * add comments to explain register access
> * cleanup resource allocation
> * cleanup clock handling
> * whitespace fixes

    The patch revision history is normally put under --- tearline.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Signed-off-by: Ralph Hempel<ralph.hempel@lantiq.com>
> Cc: Wim Van Sebroeck<wim@iguana.be>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org
[...]

> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> new file mode 100644
> index 0000000..8515c1f
> --- /dev/null
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -0,0 +1,233 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2010 John Crispin<blogic@openwrt.org>
> + *  Based on EP93xx wdt driver
> + */
> +
> +#include<linux/module.h>
> +#include<linux/fs.h>
> +#include<linux/miscdevice.h>
> +#include<linux/watchdog.h>
> +#include<linux/platform_device.h>
> +#include<linux/uaccess.h>
> +#include<linux/clk.h>
> +#include<linux/io.h>
> +
> +#include<lantiq.h>
> +
> +/* Section 3.4 of the datasheet
> +   The password sequence protects the WDT control register from unintended
> +   write actions, which might cause malfunction of the WDT.
> +
> +   essentially the following two magic passwords need to be written to allow
> +   io access to the wdt core */

    The preferred style for the multi-line comments is this:

/*
  * bla
  * bla
  */

> +#define LTQ_WDT_CR		0x03F0	/* watchdog control register */
> +#define LTQ_WDT_SR		0x03F8	/* watchdog status register */
> +
> +#define LTQ_WDT_SR_EN		(0x1 << 31) /* enable bit */
> +#define LTQ_WDT_SR_PWD		(0x3 << 26) /* turn on power */
> +#define LTQ_WDT_SR_CLKDIV	(0x3 << 24) /* turn on clock and set */
> +					    /* divider to 0x40000 */
> +#define LTQ_WDT_DIVIDER		0x40000
> +#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */

    Should align like the above...

> +
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +static int ltq_wdt_ok_to_close;
> +#endif
> +
> +static int ltq_wdt_timeout = 30;
> +static __iomem void *ltq_wdt_membase;

    It's normally "void __iomem *".

> +static unsigned long ltq_io_region_clk_rate;
> +
> +static int
> +ltq_wdt_enable(unsigned int timeout)
> +{
> +	timeout = ((timeout * (ltq_io_region_clk_rate / LTQ_WDT_DIVIDER))
> +		+ 0x1000);
> +	if (timeout > LTQ_MAX_TIMEOUT)
> +		timeout = LTQ_MAX_TIMEOUT;
> +
> +	/* write the first paswword magic */

    s/paswword/password/.

> +	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	/* write the second magic plus the configuration and new timeout */
> +	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
> +		LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
> +	return 0;

    This function should be *void* -- you alway return 0 and never check the 
result.

> +}
> +
> +static void
> +ltq_wdt_disable(void)
> +{
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	ltq_wdt_ok_to_close = 0;
> +#endif
> +	/* write the first paswword magic */
> +	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	/* write the second paswword magic with no config
> +	   this turns the watchdog off */

    Multi-line comment style...

> +	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
> +}
> +
> +static ssize_t
> +ltq_wdt_write(struct file *file, const char __user *data,
> +		size_t len, loff_t *ppos)
> +{
> +	size_t i;

    Empty line between the variables and code won't hurt...

> +	if (!len)
> +		return 0;
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	for (i = 0; i != len; i++) {
> +		char c;

    Here too...

> +		if (get_user(c, data + i))
> +			return -EFAULT;
> +		if (c == 'V')
> +			ltq_wdt_ok_to_close = 1;
> +	}
> +#endif
[...]
> +static long
> +ltq_wdt_ioctl(struct file *file,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	int ret = -ENOTTY;

    Empty line between the variables and code won't hurt...

> +	switch (cmd) {
> +	case WDIOC_GETSUPPORT:
> +		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
> +				sizeof(ident)) ? -EFAULT : 0;

    Doesn't copy_to_user() return 0 or -EFAULT?

> +static int
> +ltq_wdt_release(struct inode *inode, struct file *file)
> +{
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	if (ltq_wdt_ok_to_close)
> +		ltq_wdt_disable();
> +	else
> +#endif
> +		printk(KERN_ERR "ltq_wdt: watchdog closed without warning\n");

    Use pr_err() instead.

> +static int
> +ltq_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct clk *clk;
> +	int ret = 0;

    Empty line between the variables and code won't hurt...

> +	/* we do not need to enable the clock as it is always running */
> +	clk = clk_get(&pdev->dev, "io");

    clk_get() may fail...

> +	ret = misc_register(&ltq_wdt_miscdev);
> +	if (ret)
> +		return 0;

    Er, didn't you mean:

	if (!ret)
		return 0;

> +	return ret;

    'ret' is always 0 here with your code.

> +}
> +
> +static int
> +ltq_wdt_remove(struct platform_device *dev)

    __exit?

> +static int __init
> +init_ltq_wdt(void)
> +{
> +	return platform_driver_register(&ltq_wdt_driver);

    Why not platfrom_driver_probe()? It's hardly a hotplug device...

WBR, Sergei
