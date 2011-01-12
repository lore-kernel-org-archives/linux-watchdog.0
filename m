Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f194.google.com ([74.125.82.194]:52372 "EHLO
	mail-wy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776Ab1ALIYZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Jan 2011 03:24:25 -0500
Received: by wyf23 with SMTP id 23so103508wyf.1
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Jan 2011 00:24:24 -0800 (PST)
Date: Wed, 12 Jan 2011 08:24:16 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: viresh kumar <viresh.linux@gmail.com>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110112082416.GE3181@pulham.picochip.com>
References: <1294675181-18273-1-git-send-email-jamie@jamieiles.com>
 <AANLkTikbxyCSX5eKiwtZyW+gYToTD7Jcucst6su2fEjN@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTikbxyCSX5eKiwtZyW+gYToTD7Jcucst6su2fEjN@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Viresh,

On Wed, Jan 12, 2011 at 10:46:28AM +0530, viresh kumar wrote:
> Jamie,
> 
> Sorry for sending comments on V5 !!

No problem!  All feedback appreciated!

> I don't know why, but checkpatch used to give few errors which it is
> not giving now.
> Like:
> - Mixing spaces and tabs
> - Line over 80 columns.
> 
> There are few places in this patch where i have seen these issues, but
> checkpatch doesn't
> report them at all.

Hmm, the only lines over 80 chars are printk lines and I can't see any 
with mixed spaces and tabs...


> On Mon, Jan 10, 2011 at 9:29 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 8a3aa2f..62c607a 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -331,6 +331,15 @@ config IMX2_WDT
> >          To compile this driver as a module, choose M here: the
> >          module will be called imx2_wdt.
> >
> > +config DW_WATCHDOG
> > +       tristate "Synopsys DesignWare watchdog"
> > +       depends on ARM
> 
> Correct me if i am wrong, but can't this peripheral be used for any
> other architecture.
> We are adding it as a platform device and not amba device.
> Might be synopsys give some other interface here, other than AMBA.

Well this is an APB peripheral so I think that it is fair to have the 
dependency on ARM for now.  If someone wants to use it on another 
architecture then we can easily widen this if we need to.

> > +       help
> > +         Say Y here if to include support for the Synopsys DesignWare
> > +         watchdog timer found in many ARM chips.
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called dw_wdt.
> > +
> >  # AVR32 Architecture
> >
> 
> (...)
> 
> > diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> > new file mode 100644
> > index 0000000..45fa1fb
> > --- /dev/null
> > +++ b/drivers/watchdog/dw_wdt.c
> > @@ -0,0 +1,405 @@
> > +/*
> > + * Copyright 2010-2011 Picochip Ltd., Jamie Iles
> > + * http://www.picochip.com
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + *
> > + * This file implements a driver for the Synopsys DesignWare watchdog device
> > + * in the many ARM subsystems. The watchdog has 16 different timeout periods
> > + * and these are a function of the input clock frequency.
> > + *
> > + * The DesignWare watchdog cannot be stopped once it has been started so we
> > + * use a software timer to implement a ping that will keep the watchdog alive.
> > + * If we receive an expected close for the watchdog then we keep the timer
> > + * running, otherwise the timer is stopped and the watchdog will expire.
> > + */
> > +#define pr_fmt(fmt) "dw_wdt: " fmt
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/fs.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/pm.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/timer.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/watchdog.h>
> > +
> 
> can remove this blank line.

Ok, will do.

> > +#include <linux/platform_data/dw_wdt.h>
> > +
> > +#define WDOG_CONTROL_REG_OFFSET             0x00
> > +#define WDOG_CONTROL_REG_WDT_EN_MASK       0x01
> > +#define WDOG_TIMEOUT_RANGE_REG_OFFSET       0x04
> > +#define WDOG_CURRENT_COUNT_REG_OFFSET       0x08
> > +#define WDOG_COUNTER_RESTART_REG_OFFSET     0x0c
> > +#define WDOG_COUNTER_RESTART_KICK_VALUE            0x76
> 
> I don't know why, but i have seen a lot of comment that people give to
> align macro's.
> Use tabs instead of spaces between macro name and its value. Also keep
> them aligned.
> I am not sure if its absolutely necessary.

Ahh, yes, there are the spaces.  I'll fix this up, they should be 
aligned.

> (...)
> 
> > +static int dw_wdt_set_top(unsigned top_s)
> > +{
> > +       int i, top_val = -1;
> 
> We can assign top_val = DW_WDT_MAX_TOP, here and
> 
> > +
> > +       /*
> > +        * Iterate over the timeout values until we find the closest match. We
> > +        * always look for >=.
> > +        */
> > +       for (i = 0; i <= DW_WDT_MAX_TOP; ++i)
> > +               if (dw_wdt_top_in_seconds(i) >= top_s) {
> > +                       top_val = i;
> > +                       break;
> > +               }
> > +
> > +       /*
> > +        * If we didn't find a suitable value, it must have been too large. Go
> > +        * with the biggest that we can.
> > +        */
> > +       if (top_val < 0)
> > +               top_val = DW_WDT_MAX_TOP;
> 
> remove this check.

That's cleaner.  Thanks.

> > +       /* Set the new value in the watchdog. */
> > +       writel(top_val, dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> > +
> > +       dw_wdt_set_next_heartbeat();
> > +
> > +       return dw_wdt_top_in_seconds(top_val);
> > +}
> > +
> 
> (...)
> 
> > +static int __devinit dw_wdt_drv_probe(struct platform_device *pdev)
> > +{
> > +       int ret;
> > +       struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       struct dw_wdt_platform_data *pdata = pdev->dev.platform_data;
> > +
> > +       if (!mem)
> > +               return -EINVAL;
> > +
> > +       if (!devm_request_mem_region(&pdev->dev, mem->start, resource_size(mem),
> > +                                    "dw_wdt"))
> > +               return -ENOMEM;
> > +
> > +       dw_wdt.regs = devm_ioremap(&pdev->dev, mem->start,
> > +                                            resource_size(mem));
> 
> this can come in single line.

Ok.

> > +       if (!dw_wdt.regs)
> > +               return -ENOMEM;
> > +
> > +       dw_wdt.clk = clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(dw_wdt.clk))
> > +               return -ENODEV;
> 
> shouldn't we use the error value returned from clk_get here instead of defining
> a new value -ENODEV?

Yes, that's probably better.

> > +
> > +       ret = clk_enable(dw_wdt.clk);
> 
> should we call this routine if clk is NULL? Probably we will get error here.
> But as we discussed earlier, we should support machines who don't support clk
> framework. So, shouldn't we check clk for NULL here and call this
> routine only if we have a valid clk pointer, otherwise continue 
> instead of returning error.

I think this is right, it's perfectly valid for a platform to return 
NULL as a clk and you can pass that to clk_enable().

> > +       if (ret)
> > +               goto out_put_clk;
> > +
> > +       /*
> > +        * The timeout period of the watchdog is derived from the input clock
> > +        * frequency.  For platforms that don't have a clk for the watchdog,
> > +        * they can specify the WDT clock rate through the clk_rate field of
> > +        * the struct dw_wdt_platform_data platform data.
> > +        */
> > +       if (pdata && pdata->clk_rate > 0)
> > +               dw_wdt.clk_rate = pdata->clk_rate;
> > +       else
> > +               dw_wdt.clk_rate = clk_get_rate(dw_wdt.clk);
> > +
> 
> I know it doesn't make sense for a platform to have support for clk framework
> and pass rate through plat data. But this code will always take 
> pdata->rate, if it is passed.
> Wouldn't it be better if we reverse the sequence.
> 
> if (clk)
>  rate = clk_get_rate(...);
> else {
>  pdata = pdev->dev.platform_data;
>  if (pdata)
>   rate = pdata->rate;
> }
> 
> and then following code

That's what I did first (without the test that clk is not NULL) but 
switched it the other way round so that the platform can override the 
frequency by setting platform_data->clk_rate to nonzero.  That just 
seems a little more flexible and easy for testing but I'm happy to 
switch the order if you feel that's important.

> > +       if (!dw_wdt.clk_rate) {
> > +               dev_err(&pdev->dev, "no clk rate defined for watchdog, cannot enable\n");
> > +               ret = -EINVAL;
> > +               goto out_disable_clk;
> > +       }
> > +
> > +       spin_lock_init(&dw_wdt.lock);
> > +
> > +       ret = misc_register(&dw_wdt_miscdev);
> > +       if (ret)
> > +               goto out_put_clk;
> 
> shouldn't it be out_disable_clk??

Yes, thanks.

> > +
> > +       dw_wdt_set_next_heartbeat();
> > +       setup_timer(&dw_wdt.timer, dw_wdt_ping, 0);
> > +       mod_timer(&dw_wdt.timer, jiffies + WDT_TIMEOUT);
> > +
> > +       return 0;
> > +
> > +out_disable_clk:
> > +       clk_disable(dw_wdt.clk);
> > +out_put_clk:
> > +       clk_put(dw_wdt.clk);
> > +
> > +       return ret;
> > +}
> > +
> > +static int __devexit dw_wdt_drv_remove(struct platform_device *pdev)
> > +{
> > +       misc_deregister(&dw_wdt_miscdev);
> > +
> > +       clk_disable(dw_wdt.clk);
> > +       clk_put(dw_wdt.clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver dw_wdt_driver = {
> > +       .probe          = dw_wdt_drv_probe,
> > +       .remove         = __devexit_p(dw_wdt_drv_remove),
> > +       .driver         = {
> > +               .name   = "dw_wdt",
> > +               .owner  = THIS_MODULE,
> > +#ifdef CONFIG_PM
> > +               .pm     = &dw_wdt_pm_ops,
> > +#endif /* CONFIG_PM */
> > +       },
> > +};
> > +
> > +static int __init dw_wdt_watchdog_init(void)
> > +{
> > +       return platform_driver_register(&dw_wdt_driver);
> > +}
> > +module_init(dw_wdt_watchdog_init);
> > +
> > +static void __exit dw_wdt_watchdog_exit(void)
> > +{
> > +       platform_driver_unregister(&dw_wdt_driver);
> > +}
> > +module_exit(dw_wdt_watchdog_exit);
> > +
> > +MODULE_AUTHOR("Jamie Iles");
> > +MODULE_DESCRIPTION("Synopsys DesignWare Watchdog Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
> > diff --git a/include/linux/platform_data/dw_wdt.h b/include/linux/platform_data/dw_wdt.h
> > new file mode 100644
> > index 0000000..0af10ef
> > --- /dev/null
> > +++ b/include/linux/platform_data/dw_wdt.h
> 
> It looks you have created a separate generic folder platform_data.
> But generally we put these files directly into existing folders.
> I am not quite sure if that's fine or we should avoid this.

Yes, this was suggested by Greg K-H to stop include/linux getting filled 
with platform data (https://lkml.org/lkml/2011/1/7/323).

Thanks again!

Jamie
