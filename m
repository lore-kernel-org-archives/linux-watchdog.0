Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:33627 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbaKME40 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Nov 2014 23:56:26 -0500
Received: by mail-vc0-f176.google.com with SMTP id la4so1896936vcb.7
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Nov 2014 20:56:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415805483-26268-2-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1415805483-26268-2-git-send-email-Naidu.Tellapati@imgtec.com>
Date: Wed, 12 Nov 2014 20:56:25 -0800
Message-ID: <CAL1qeaHt14p3cjk7hLx_E2qKdqR+qHne-BJmHvVrgBF-4AyU=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
From: Andrew Bresticker <abrestic@chromium.org>
To: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: wim@iguana.be, linux@roeck-us.net,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	linux-watchdog@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jude.Abraham@imgtec.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 12, 2014 at 7:18 AM,  <Naidu.Tellapati@imgtec.com> wrote:
> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>
> This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
>
> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index d0107d4..13fb1b2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig

> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index c569ec8..467973c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile

These two diffs are full of unrelated changes for some reason.

> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
> new file mode 100644
> index 0000000..df9ff1c
> --- /dev/null
> +++ b/drivers/watchdog/imgpdc_wdt.c
> @@ -0,0 +1,388 @@
> +/*
> + * Imagination Technologies PowerDown Controller Watchdog Timer.
> + *
> + * Copyright (c) 2014 Imagination Technologies Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * Based on drivers/watchdog/sunxi_wdt.c Copyright (c) 2013 Carlo Caione
> + *                                                     2012 Henrik Nordstrom
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/log2.h>
> +#include <linux/slab.h>

#includes should be sorted in alphabetical order.

> +/* registers */
> +#define PDC_WD_SW_RESET                        0x000
> +#define PDC_WD_CONFIG                  0x004
> +#define PDC_WD_TICKLE1                 0x008
> +#define PDC_WD_TICKLE2                 0x00c
> +#define PDC_WD_IRQ_STATUS              0x010
> +#define PDC_WD_IRQ_CLEAR               0x014
> +#define PDC_WD_IRQ_EN                  0x018
> +
> +/* field masks */
> +#define PDC_WD_CONFIG_REMIND           0x00001f00
> +#define PDC_WD_CONFIG_REMIND_SHIFT     8
> +#define PDC_WD_CONFIG_DELAY            0x0000001f
> +#define PDC_WD_CONFIG_DELAY_SHIFT      0
> +#define PDC_WD_TICKLE_STATUS           0x00000007
> +#define PDC_WD_TICKLE_STATUS_SHIFT     0
> +#define PDC_WD_IRQ_REMIND              0x00000001
> +
> +/* constants */
> +#define PDC_WD_TICKLE1_MAGIC           0xabcd1234
> +#define PDC_WD_TICKLE2_MAGIC           0x4321dcba
> +#define PDC_WD_TICKLE_STATUS_HRESET    0x0  /* Hard reset */
> +#define PDC_WD_TICKLE_STATUS_TIMEOUT   0x1  /* Timeout */
> +#define PDC_WD_TICKLE_STATUS_TICKLE    0x2  /* Tickled incorrectly */
> +#define PDC_WD_TICKLE_STATUS_SRESET    0x3  /* Soft reset */
> +#define PDC_WD_TICKLE_STATUS_USER      0x4  /* User reset */

Perhaps put the register field masks/shifts #define next to their
corresponding register #define?

Also, I prefer to #define the unshifted mask, but I'm not sure there's
any rule about that.

> +/* timeout in seconds */
> +#define PDC_WD_MIN_TIMEOUT             1
> +#define PDC_WD_MAX_TIMEOUT             131072
> +#define PDC_WD_DEFAULT_TIMEOUT         64
> +#define PDC_WD_DEFAULT_PRETIMEOUT      PDC_WD_MAX_TIMEOUT
> +#define MIN_TIMEOUT_SHIFT              14  /* Clock rate 32768Hz=2^(14+1)*/

The input clock is not fixed at 32kHz.  I believe it can be configured
to run at a different rate.

> +static int timeout = PDC_WD_DEFAULT_TIMEOUT;
> +static int pretimeout = PDC_WD_DEFAULT_PRETIMEOUT;
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +
> +struct pdc_wdt_dev {
> +       struct watchdog_device wdt_dev;
> +       int irq;
> +       struct clk *clk;
> +       void __iomem *base;
> +       unsigned int pretimeout;
> +};
> +
> +static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
> +{
> +       struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +       writel(PDC_WD_TICKLE1_MAGIC, wdt->base + PDC_WD_TICKLE1);
> +       writel(PDC_WD_TICKLE2_MAGIC, wdt->base + PDC_WD_TICKLE2);
> +
> +       return 0;
> +}
> +
> +static int pdc_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +       unsigned int val;
> +       struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +       val = readl(wdt->base + PDC_WD_CONFIG);
> +       val &= ~BIT(31);

This should be a #define, e.g. PDC_WD_CONFIG_ENABLE.

> +       writel(val, wdt->base + PDC_WD_CONFIG);
> +       /* Must tickle to finish the stop */
> +       pdc_wdt_keepalive(wdt_dev);
> +
> +       return 0;
> +}
> +
> +static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +                              unsigned int new_timeout)
> +{
> +       unsigned int val;
> +       struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +       if (new_timeout < PDC_WD_MIN_TIMEOUT ||
> +           new_timeout > PDC_WD_MAX_TIMEOUT)
> +               return -EINVAL;
> +
> +       wdt->wdt_dev.timeout = new_timeout;
> +
> +       /* round up to the next power of 2 */
> +       new_timeout = order_base_2(new_timeout);
> +       val = readl(wdt->base + PDC_WD_CONFIG);
> +
> +       /* number of 32.768KHz clocks, 2^(n+1) (14 is 1 sec) */
> +       val &= ~PDC_WD_CONFIG_DELAY;
> +       val |= (new_timeout + MIN_TIMEOUT_SHIFT) << PDC_WD_CONFIG_DELAY_SHIFT;
> +       writel(val, wdt->base + PDC_WD_CONFIG);

Like I mentioned above, I don't think the input clock is fixed at
32kHz.  You need to program the right value based on the input clock's
rate.

> +
> +       return 0;
> +}
> +
> +static int pdc_wdt_set_pretimeout(struct watchdog_device *wdt_dev,
> +                                 unsigned int new_pretimeout)
> +{
> +       int delay;
> +       unsigned int val;
> +       struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +       /*
> +       * Pretimeout is measured in seconds before main timeout.
> +       * Subtract and round it once, and it will effectively change
> +       * if the main timeout is changed.
> +       */
> +       delay = wdt->wdt_dev.timeout;
> +       if (!new_pretimeout)
> +               new_pretimeout = PDC_WD_MAX_TIMEOUT;
> +       else if (new_pretimeout > 0 && new_pretimeout < delay)
> +               new_pretimeout = delay - new_pretimeout;
> +       else
> +               return -EINVAL;
> +
> +       pretimeout = new_pretimeout;
> +       new_pretimeout = ilog2(new_pretimeout);
> +       val = readl(wdt->base + PDC_WD_CONFIG);
> +
> +       /* number of 32.768KHz clocks, 2^(n+1) (14 is 1 sec) */
> +       val &= ~PDC_WD_CONFIG_REMIND;
> +       val |= (new_pretimeout + MIN_TIMEOUT_SHIFT)
> +                               << PDC_WD_CONFIG_REMIND_SHIFT;
> +       writel(val, wdt->base + PDC_WD_CONFIG);
> +       wdt->pretimeout = pretimeout;
> +
> +       return 0;
> +}
> +
> +/* Start the watchdog timer (delay should already be set */
> +static int pdc_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +       int ret;
> +       unsigned int val;
> +       struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +       ret = pdc_wdt_set_timeout(&wdt->wdt_dev, wdt->wdt_dev.timeout);
> +       if (ret < 0)
> +               return ret;
> +
> +       val = readl(wdt->base + PDC_WD_CONFIG);
> +       val |= BIT(31);
> +       writel(val, wdt->base + PDC_WD_CONFIG);
> +
> +       return 0;
> +}
> +
> +static long pdc_wdt_ioctl(struct watchdog_device  *wdt_dev,
> +                         unsigned int cmd, unsigned long arg)
> +{
> +       int ret = -ENOIOCTLCMD;
> +       unsigned int new_pretimeout;
> +       void __user *argp = (void __user *)arg;
> +       int __user *p = argp;
> +       struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +       switch (cmd) {
> +       case WDIOC_SETPRETIMEOUT:
> +               if (get_user(new_pretimeout, p))
> +                       return -EFAULT;
> +
> +               ret = pdc_wdt_set_pretimeout(wdt_dev, new_pretimeout);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* fallthrough */
> +       case WDIOC_GETPRETIMEOUT:
> +               ret = put_user(wdt->pretimeout, (int __user *)arg);
> +               break;
> +       }
> +
> +       return ret;
> +}

I'm not sure what the point of this pre-timeout stuff is.  It looks
like it's just used to trigger an interrupt, which we then just
silently ACK.  Perhaps it can be removed, along with the interrupt
handling?

> +static irqreturn_t pdc_wdt_isr(int irq, void *dev_id)
> +{
> +       struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(dev_id);
> +       unsigned int stat = readl(pdc_wdt->base + PDC_WD_IRQ_STATUS);
> +       /*
> +        * The behaviour of the remind interrupt should depend on what userland
> +        * asks for, either do nothing, panic the system or inform userland.
> +        * Unfortunately this is not part of the main linux interface, and is
> +        * currently implemented only in the ipmi watchdog driver (in
> +        * drivers/char). This could be added at a later time.
> +        */
> +       writel(stat, pdc_wdt->base + PDC_WD_IRQ_CLEAR);
> +       return IRQ_HANDLED;
> +}
> +
> +static struct watchdog_info pdc_wdt_info = {
> +       .options                = WDIOF_SETTIMEOUT |
> +                                 WDIOF_KEEPALIVEPING |
> +                                 WDIOF_PRETIMEOUT |
> +                                 WDIOF_MAGICCLOSE,
> +       .identity = "PDC Watchdog",
> +};
> +
> +/* Kernel interface */
> +
> +static const struct watchdog_ops pdc_wdt_ops = {
> +       .owner          = THIS_MODULE,
> +       .start          = pdc_wdt_start,
> +       .stop           = pdc_wdt_stop,
> +       .ping           = pdc_wdt_keepalive,
> +       .set_timeout    = pdc_wdt_set_timeout,
> +       .ioctl          = pdc_wdt_ioctl,
> +};
> +
> +static int pdc_wdt_probe(struct platform_device *pdev)
> +{
> +       int ret, val, irq;
> +       struct resource *res;
> +       struct pdc_wdt_dev *pdc_wdt;
> +
> +       pdc_wdt = devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt), GFP_KERNEL);
> +       if (!pdc_wdt)
> +               return -ENOMEM;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "cannot find wdt IRQ resource\n");
> +               return irq;
> +       }
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       pdc_wdt->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(pdc_wdt->base))
> +               return PTR_ERR(pdc_wdt->base);
> +
> +       pdc_wdt->clk = devm_clk_get(&pdev->dev, "wdt");
> +       if (IS_ERR(pdc_wdt->clk)) {
> +               dev_err(&pdev->dev, "failed to get the clock.\n");
> +               return PTR_ERR(pdc_wdt->clk);
> +       }
> +
> +       ret = clk_prepare_enable(pdc_wdt->clk);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "could not prepare or enable wdt clock.\n");
> +               return ret;
> +       }

Like I said in the binding doc, I think there are two clocks you need
to get and enable here.

> +       pdc_wdt->wdt_dev.info = &pdc_wdt_info;
> +       pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
> +       pdc_wdt->wdt_dev.timeout = PDC_WD_DEFAULT_TIMEOUT;
> +       pdc_wdt->wdt_dev.max_timeout = PDC_WD_MAX_TIMEOUT;
> +       pdc_wdt->wdt_dev.min_timeout = PDC_WD_MIN_TIMEOUT;
> +       pdc_wdt->wdt_dev.parent = &pdev->dev;
> +
> +       watchdog_init_timeout(&pdc_wdt->wdt_dev, timeout, &pdev->dev);
> +
> +       /* Enable remind interrupts */
> +       writel(PDC_WD_IRQ_REMIND, pdc_wdt->base + PDC_WD_IRQ_EN);
> +       pdc_wdt_stop(&pdc_wdt->wdt_dev);
> +       /* Set timeouts before userland has a chance to start the timer */
> +       pdc_wdt_set_timeout(&pdc_wdt->wdt_dev, timeout);
> +       pdc_wdt_set_pretimeout(&pdc_wdt->wdt_dev, pretimeout);
> +
> +       /* Find what caused the last reset */
> +       val = readl(pdc_wdt->base + PDC_WD_TICKLE1);
> +       val = (val & PDC_WD_TICKLE_STATUS) >> PDC_WD_TICKLE_STATUS_SHIFT;
> +       switch (val) {
> +       case PDC_WD_TICKLE_STATUS_TICKLE:
> +       case PDC_WD_TICKLE_STATUS_TIMEOUT:
> +               pdc_wdt->wdt_dev.bootstatus |= WDIOF_CARDRESET;
> +               dev_info(&pdev->dev,
> +                       "watchdog module last reset due to timeout\n");
> +               break;
> +       case PDC_WD_TICKLE_STATUS_HRESET:
> +               dev_info(&pdev->dev,
> +                       "watchdog module last reset due to hard reset\n");
> +               break;
> +       case PDC_WD_TICKLE_STATUS_SRESET:
> +               dev_info(&pdev->dev,
> +                       "watchdog module last reset due to soft reset\n");
> +               break;
> +       case PDC_WD_TICKLE_STATUS_USER:
> +               dev_info(&pdev->dev,
> +                       "watchdog module last reset due to user reset\n");
> +               break;
> +       default:
> +               dev_info(&pdev->dev,
> +                       "contains an illegal status code (%08x)\n", val);
> +               break;
> +       }

Set pdc_wdt->wdt_dev.bootstatus based on this value?

> +
> +       watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
> +
> +       platform_set_drvdata(pdev, pdc_wdt);
> +       watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
> +
> +       ret = watchdog_register_device(&pdc_wdt->wdt_dev);
> +       if (ret) {
> +               clk_disable_unprepare(pdc_wdt->clk);
> +               return ret;
> +       }
> +
> +       ret = devm_request_irq(&pdev->dev, irq, pdc_wdt_isr,
> +                              IRQ_TYPE_LEVEL_HIGH, dev_name(&pdev->dev), pdev);
> +       if (ret) {
> +               watchdog_unregister_device(&pdc_wdt->wdt_dev);
> +               clk_disable_unprepare(pdc_wdt->clk);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int pdc_wdt_remove(struct platform_device *pdev)
> +{
> +       struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
> +
> +       watchdog_unregister_device(&pdc_wdt->wdt_dev);
> +       clk_disable_unprepare(pdc_wdt->clk);

Probably should disable the watchdog as well.

> +       watchdog_set_drvdata(&pdc_wdt->wdt_dev, NULL);

Not necessary.

> +
> +       return 0;
> +}
> +
> +static void pdc_wdt_shutdown(struct platform_device *pdev)
> +{
> +       struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
> +
> +       pdc_wdt_stop(&pdc_wdt->wdt_dev);
> +}
> +
> +static const struct of_device_id pdc_wdt_match[] = {
> +       { .compatible = "img,pistachio-pdc-wdt" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, pdc_wdt_match);
> +
> +static struct platform_driver pdc_wdt_driver = {
> +       .driver = {
> +               .name = "imgpdc-wdt",
> +               .of_match_table = pdc_wdt_match,
> +       },
> +       .probe = pdc_wdt_probe,
> +       .remove = pdc_wdt_remove,
> +       .shutdown = pdc_wdt_shutdown,
> +};
> +module_platform_driver(pdc_wdt_driver);
> +
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout,
> +       "PDC watchdog timer delay in seconds ("
> +       __MODULE_STRING(PDC_WD_MIN_TIMEOUT)" <= timeout <= "
> +       __MODULE_STRING(PDC_WD_MAX_TIMEOUT)
> +       "; default = " __MODULE_STRING(PDC_WD_DEFAULT_TIMEOUT) ")");
> +
> +module_param(pretimeout, int, 0);
> +MODULE_PARM_DESC(pretimeout,
> +       "PDC watchdog timer remind in seconds ("
> +       __MODULE_STRING(PDC_WD_MIN_TIMEOUT)" <= pretimeout <= "
> +       __MODULE_STRING(PDC_WD_MAX_TIMEOUT)
> +       "; default = " __MODULE_STRING(PDC_WD_DEFAULT_PRETIMEOUT) ")");
> +
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +       "Watchdog cannot be stopped once started (default = "
> +               __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

Maybe put this module_param stuff up where their corresponding
variables are defined?

> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Jude Abraham <Jude.Abraham@imgtec.com>");
> +MODULE_AUTHOR("Naidu Tellapati <Naidu.Tellapati@imgtec.com>");
> +MODULE_DESCRIPTION("Imagination Technologies PDC Watchdog Timer Driver");
> +MODULE_ALIAS("platform:img_pdc_wdt");

This driver probes via DT, so I don't think the MODULE_ALIAS is necessary.
