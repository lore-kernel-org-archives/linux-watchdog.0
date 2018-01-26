Return-Path: <geert.uytterhoeven@gmail.com>
Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1516903391-30467-25-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com> <1516903391-30467-25-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2018 11:22:44 +0100
Message-ID: <CAMuHMdUd7Ex-04GTe3dUEdAD00LX5FZcLSi4uOUQaVBjdMu86g@mail.gmail.com>
Subject: Re: [RFC 24/37] watchdog: renesas_wdt_gen2: Add Gen2 specific driver
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-clk <linux-clk@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hi Fabrizio,

CC Wolfram

On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> R-Car Gen2 (and RZ/G1) platforms need some tweaking for SMP and watchdog
> to coexist nicely.
> This new driver is based on top of Wolfram Sang's driver
> (drivers/watchdog/renesas_wdt.c), and it contains the quirks necessary
> for R-Car Gen2 and RZ/G1 to work properly and in harmony with the rest of
> the system. In particular, the driver:

Thanks for your patch!

IMHO, having a unified driver would be better from a maintenance point of
view.

> * expects the device clock to be ON all the time,

That can be handled in the driver, instead of through a critical clock.

> * "pauses" the watchdog operation during suspend, and

Isn't that needed in the original driver, too?

> * "reassures" the SMP bringup function about the availability of the
>   watchdog registers.

Through shmobile_set_wdt_clock_status(), which I don't like very much...
Can this be handled differently?

> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
>  drivers/watchdog/Kconfig            |  15 +-
>  drivers/watchdog/Makefile           |   1 +
>  drivers/watchdog/renesas_wdt_gen2.c | 270 ++++++++++++++++++++++++++++++++++++
>  drivers/watchdog/renesas_wdt_gen2.h |  22 +++
>  4 files changed, 306 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/watchdog/renesas_wdt_gen2.c
>  create mode 100644 drivers/watchdog/renesas_wdt_gen2.h
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ca200d1..e580c72 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -725,12 +725,23 @@ config ATLAS7_WATCHDOG
>           module will be called atlas7_wdt.
>
>  config RENESAS_WDT
> -       tristate "Renesas WDT Watchdog"
> +       tristate "Renesas R-Car Gen3 WDT Watchdog"
>         depends on ARCH_RENESAS || COMPILE_TEST
>         select WATCHDOG_CORE
>         help
>           This driver adds watchdog support for the integrated watchdogs in the
> -         Renesas R-Car and other SH-Mobile SoCs (usually named RWDT or SWDT).
> +         Renesas R-Car Gen3 devices.
> +
> +config RENESAS_WDT_GEN2
> +       tristate "Renesas R-Car Gen2 and RZ/G1 WDT Watchdog"
> +       depends on ARCH_RENESAS || COMPILE_TEST

Note that compile-testing will fail if ARCH_RENESAS=n, due to the reference
to shmobile_set_wdt_clock_status().

> +       select WATCHDOG_CORE
> +       help
> +         This driver adds watchdog support for the integrated watchdogs in the
> +         Renesas R-Car Gen2 and RZ/G1 devices.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called renesas_wdt_gen2.
>
>  config RENESAS_RZAWDT
>         tristate "Renesas RZ/A WDT Watchdog"
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 715a210..57ab810 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
>  obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>  obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
>  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
> +obj-$(CONFIG_RENESAS_WDT_GEN2) += renesas_wdt_gen2.o
>  obj-$(CONFIG_RENESAS_RZAWDT) += rza_wdt.o
>  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>  obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
> diff --git a/drivers/watchdog/renesas_wdt_gen2.c b/drivers/watchdog/renesas_wdt_gen2.c
> new file mode 100644
> index 0000000..c841636
> --- /dev/null
> +++ b/drivers/watchdog/renesas_wdt_gen2.c
> @@ -0,0 +1,270 @@
> +/*
> + * Watchdog driver for Renesas WDT watchdog
> + *
> + * Copyright (C) 2015-17 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
> + * Copyright (C) 2018    Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/watchdog.h>
> +#include "renesas_wdt_gen2.h"
> +
> +#define RWTCNT                 0
> +#define RWTCSRA                        4
> +#define RWTCSRA_WOVF           BIT(4)
> +#define RWTCSRA_WRFLG          BIT(5)
> +#define RWTCSRA_TME            BIT(7)
> +#define RWTCSRB                        8
> +
> +#define RWDT_DEFAULT_TIMEOUT   60U
> +
> +/*
> + * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
> + * divider (12 bits). d is only a factor to fully utilize the WDT counter and
> + * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
> + */
> +#define MUL_BY_CLKS_PER_SEC(p, d) \
> +       DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
> +
> +/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
> +#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
> +
> +static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024, 4096 };
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct rwdt_priv {
> +       void __iomem *base;
> +       struct watchdog_device wdev;
> +       unsigned long clk_rate;
> +       bool enabled;
> +       u8 cks;
> +};
> +
> +static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned int reg)
> +{
> +       if (reg == RWTCNT)
> +               val |= 0x5a5a0000;
> +       else
> +               val |= 0xa5a5a500;
> +
> +       writel_relaxed(val, priv->base + reg);
> +}
> +
> +static int rwdt_init_timeout(struct watchdog_device *wdev)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +       rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, wdev->timeout),
> +                  RWTCNT);
> +
> +       return 0;
> +}
> +
> +static int rwdt_start(struct watchdog_device *wdev)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +       rwdt_write(priv, 0, RWTCSRB);
> +       rwdt_write(priv, priv->cks, RWTCSRA);
> +       rwdt_init_timeout(wdev);
> +
> +       while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> +               cpu_relax();
> +
> +       rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
> +
> +       return 0;
> +}
> +
> +static int rwdt_stop(struct watchdog_device *wdev)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +       rwdt_write(priv, priv->cks, RWTCSRA);
> +
> +       return 0;
> +}
> +
> +static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +       u16 val = readw_relaxed(priv->base + RWTCNT);
> +
> +       return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
> +}
> +
> +static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
> +                       void *data)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +       rwdt_write(priv, 0x00, RWTCSRB);
> +       rwdt_write(priv, 0x00, RWTCSRA);
> +       rwdt_write(priv, 0xffff, RWTCNT);
> +
> +       while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> +               cpu_relax();
> +
> +       rwdt_write(priv, 0x80, RWTCSRA);
> +       return 0;
> +}
> +
> +static const struct watchdog_info rwdt_ident = {
> +       .options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +       .identity = "Renesas WDT Watchdog",
> +};
> +
> +static const struct watchdog_ops rwdt_ops = {
> +       .owner = THIS_MODULE,
> +       .start = rwdt_start,
> +       .stop = rwdt_stop,
> +       .ping = rwdt_init_timeout,
> +       .get_timeleft = rwdt_get_timeleft,
> +       .restart = rwdt_restart,
> +};
> +
> +static int rwdt_probe(struct platform_device *pdev)
> +{
> +       struct rwdt_priv *priv;
> +       struct resource *res;
> +       struct clk *clk;
> +       unsigned long clks_per_sec;
> +       int ret, i;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +
> +       priv->clk_rate = clk_get_rate(clk);
> +
> +       if (!priv->clk_rate)
> +               return -ENOENT;
> +
> +       for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
> +               clks_per_sec = priv->clk_rate / clk_divs[i];
> +               if (clks_per_sec && clks_per_sec < 65536) {
> +                       priv->cks = i;
> +                       break;
> +               }
> +       }
> +
> +       if (i < 0) {
> +               dev_err(&pdev->dev, "Can't find suitable clock divider\n");
> +               return -ERANGE;
> +       }
> +
> +       priv->wdev.info = &rwdt_ident,
> +       priv->wdev.ops = &rwdt_ops,
> +       priv->wdev.parent = &pdev->dev;
> +       priv->wdev.min_timeout = 1;
> +       priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
> +       priv->wdev.timeout = min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
> +
> +       platform_set_drvdata(pdev, priv);
> +       watchdog_set_drvdata(&priv->wdev, priv);
> +       watchdog_set_nowayout(&priv->wdev, nowayout);
> +
> +       ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
> +       if (ret)
> +               dev_warn(&pdev->dev,
> +                        "Specified timeout value invalid, using default\n");
> +       shmobile_set_wdt_clock_status(RWDT_CLOCK_ON);
> +
> +       ret = watchdog_register_device(&priv->wdev);
> +       return ret;
> +}
> +
> +static int rwdt_remove(struct platform_device *pdev)
> +{
> +       struct rwdt_priv *priv = platform_get_drvdata(pdev);
> +
> +       watchdog_unregister_device(&priv->wdev);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int rwdt_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev;
> +       struct rwdt_priv *priv;
> +       u8 val;
> +
> +       pdev = to_platform_device(dev);
> +       priv = platform_get_drvdata(pdev);
> +       val = readb_relaxed(priv->base + RWTCSRA);
> +       if (val & RWTCSRA_TME) {
> +               priv->enabled = true;
> +               rwdt_write(priv, val & ~RWTCSRA_TME, RWTCSRA);
> +       } else {
> +               priv->enabled = false;
> +       }
> +       return 0;
> +}
> +
> +static int rwdt_resume(struct device *dev)
> +{
> +       struct platform_device *pdev;
> +       struct rwdt_priv *priv;
> +       u8 val;
> +
> +       pdev = to_platform_device(dev);
> +       priv = platform_get_drvdata(pdev);
> +       if (priv->enabled) {
> +               val = readb_relaxed(priv->base + RWTCSRA);
> +               rwdt_write(priv, val | RWTCSRA_TME, RWTCSRA);
> +       }
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops rwdt_pm = {
> +       .suspend = rwdt_suspend,
> +       .resume = rwdt_resume,
> +};
> +#endif
> +
> +static const struct of_device_id rwdt_ids[] = {
> +       { .compatible = "renesas,rcar-gen2-wdt", },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rwdt_ids);
> +
> +static struct platform_driver rwdt_driver = {
> +       .driver = {
> +               .name = "renesas_wdt_gen2",
> +               .of_match_table = rwdt_ids,
> +#ifdef CONFIG_PM
> +               .pm = &rwdt_pm,
> +#endif
> +       },
> +       .probe = rwdt_probe,
> +       .remove = rwdt_remove,
> +};
> +module_platform_driver(rwdt_driver);
> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen2 Watchdog Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro@bp.renesas.com>");
> diff --git a/drivers/watchdog/renesas_wdt_gen2.h b/drivers/watchdog/renesas_wdt_gen2.h
> new file mode 100644
> index 0000000..41b9e9c
> --- /dev/null
> +++ b/drivers/watchdog/renesas_wdt_gen2.h
> @@ -0,0 +1,22 @@
> +/*
> + * drivers/watchdog/renesas_wdt_gen2.h
> + *
> + * Copyright (C) 2018 Renesas Electronics Corporation
> + *
> + * R-Car Gen2 and RZ/G specific symbols
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef RENESAS_WDT_GEN2_H
> +#define RENESAS_WDT_GEN2_H
> +
> +#define RWDT_CLOCK_ON          0xdeadbeef
> +#define RWDT_CLOCK_OFF         0x00000000
> +
> +extern void shmobile_set_wdt_clock_status(unsigned long value);
> +
> +#endif /* RENESAS_WDT_GEN2_H */
> --
> 2.7.4
