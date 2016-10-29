Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36099 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933397AbcJ2JFb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 29 Oct 2016 05:05:31 -0400
Received: by mail-qt0-f174.google.com with SMTP id w33so7977360qtc.3
        for <linux-watchdog@vger.kernel.org>; Sat, 29 Oct 2016 02:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fe8ac70204de48edd8a3da8a783b10810f3d4ca1.1477564996.git-series.zahari.doychev@linux.com>
References: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
 <fe8ac70204de48edd8a3da8a783b10810f3d4ca1.1477564996.git-series.zahari.doychev@linux.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 29 Oct 2016 11:05:29 +0200
Message-ID: <CACRpkdZ+v0HGUCQsTAdeK0+ymi+wQsz8M51kRxCGN7Nwjwny1w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] gpio-dmec: gpio support for dmec
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 27, 2016 at 12:47 PM, Zahari Doychev
<zahari.doychev@linux.com> wrote:

> This is support for the gpio functionality found on the Data Modul embedded
> controllers
>
> Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
> ---
>  drivers/staging/dmec/Kconfig     |  10 +-
>  drivers/staging/dmec/Makefile    |   1 +-
>  drivers/staging/dmec/dmec.h      |   5 +-
>  drivers/staging/dmec/gpio-dmec.c | 390 ++++++++++++++++++++++++++++++++-

I guess Greg has already asked, but why is this in staging?
The driver doesn't seem very complex or anything, it would not
be overly troublesome to get it into the proper kernel subsystems.

> +config GPIO_DMEC
> +       tristate "Data Modul GPIO"
> +       depends on MFD_DMEC && GPIOLIB

So the depends on GPIOLIB can go away if you just put it into
drivers/gpio with the rest.

> +struct dmec_gpio_platform_data {
> +       int gpio_base;

NAK, always use -1. No hardcoding the GPIO base other than on
legacy systems.

> +       int chip_num;

I suspect you may not need this either. struct platform_device
already contains a ->id field, just use that when instantiating
your driver if you need an instance number.

So I think you need zero platform data for this.

> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/errno.h>
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/gpio.h>

You should only need <linux/gpio/driver.h>

> +#ifdef CONFIG_PM
> +struct dmec_reg_ctx {
> +       u32 dat;
> +       u32 dir;
> +       u32 imask;
> +       u32 icfg[2];
> +       u32 emask[2];
> +};
> +#endif
> +
> +struct dmec_gpio_priv {
> +       struct regmap *regmap;
> +       struct gpio_chip gpio_chip;
> +       struct irq_chip irq_chip;
> +       unsigned int chip_num;
> +       unsigned int irq;
> +       u8 ver;
> +#ifdef CONFIG_PM
> +       struct dmec_reg_ctx regs;
> +#endif
> +};

The #ifdef for saving the state is a bit kludgy. Can't you just have it there
all the time? Or is this a footprint-sensitive system?

> +static int dmec_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
> +                                                  gpio_chip);

Use the new pattern with

struct dmec_gpio_priv *priv = gpiochip_get_data(gc);

This needs you to use devm_gpiochip_add_data() below.

> +static int dmec_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
> +                                                  gpio_chip);
> +       struct regmap *regmap = priv->regmap;
> +       unsigned int offset, mask, val;
> +
> +       offset = DMEC_GPIO_IRQTYPE_OFFSET(priv) + (d->hwirq >> 2);
> +       mask = ((d->hwirq & 3) << 1);
> +
> +       regmap_read(regmap, offset, &val);
> +
> +       val &= ~(3 << mask);
> +       switch (type & IRQ_TYPE_SENSE_MASK) {
> +       case IRQ_TYPE_LEVEL_LOW:
> +               break;
> +       case IRQ_TYPE_EDGE_RISING:
> +               val |= (1 << mask);
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               val |= (2 << mask);
> +               break;
> +       case IRQ_TYPE_EDGE_BOTH:
> +               val |= (3 << mask);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       regmap_write(regmap, offset, val);
> +
> +       return 0;
> +}

This chip uses handle_simple_irq() which is fine if the chip really has no
edge detector ACK register.

What some chips have is a special register to clearing (ACK:ing) the edge
IRQ which makes it possible for a new IRQ to be handled as soon as
that has happened, and those need to use handle_edge_irq() for edge IRQs
and handle_level_irq() for level IRQs, with the side effect that the edge
IRQ path will additionally call the .irq_ack() callback on the irqchip
when handle_edge_irq() is used. In this case we set handle_bad_irq()
as default handler and set up the right handler i .set_type().

Look at drivers/gpio/gpio-pl061.c for an example.

If you DON'T have a special edge ACK register, keep it like this.

> +static irqreturn_t dmec_gpio_irq_handler(int irq, void *dev_id)
> +{
> +       struct dmec_gpio_priv *p = dev_id;
> +       struct irq_domain *d = p->gpio_chip.irqdomain;
> +       unsigned int irqs_handled = 0;
> +       unsigned int val = 0, stat = 0;
> +
> +       regmap_read(p->regmap, DMEC_GPIO_IRQSTA_OFFSET(p), &val);
> +       stat = val;
> +       while (stat) {
> +               int line = __ffs(stat);
> +               int child_irq = irq_find_mapping(d, line);
> +
> +               handle_nested_irq(child_irq);
> +               stat &= ~(BIT(line));
> +               irqs_handled++;
> +       }

I think you should re-read the status register in the loop. An IRQ may
appear while you are reading.

> +static int dmec_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct dmec_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +       struct dmec_gpio_priv *priv;
> +       struct gpio_chip *gpio_chip;
> +       struct irq_chip *irq_chip;
> +       int ret = 0;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->regmap = dmec_get_regmap(pdev->dev.parent);

Do you really need a special accessor function to get the regmap like this?
If you just use syscon you get these kind of helpers for free. I don't know
if you can use syscon though, just a suggestion.

> +       priv->chip_num = pdata->chip_num;

As mentioned, why not just use pdev->id

> +       gpio_chip = &priv->gpio_chip;
> +       gpio_chip->label = "gpio-dmec";

You set the label

> +       gpio_chip->owner = THIS_MODULE;
> +       gpio_chip->parent = dev;
> +       gpio_chip->label = dev_name(dev);

You set the label again?

> +       gpio_chip->can_sleep = true;
> +
> +       gpio_chip->base = pdata->gpio_base;

NAK. Use -1

> +#ifdef CONFIG_PM
> +static int dmec_gpio_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +       struct dmec_gpio_priv *p = platform_get_drvdata(pdev);
> +       struct regmap *regmap = p->regmap;
> +       struct dmec_reg_ctx *ctx = &p->regs;
> +
> +       regmap_read(regmap, DMEC_GPIO_BASE(p), &ctx->dat);
> +       regmap_read(regmap, DMEC_GPIO_DIR_OFFSET(p), &ctx->dir);
> +       regmap_read(regmap, DMEC_GPIO_IRQCFG_OFFSET(p), &ctx->imask);
> +       regmap_read(regmap, DMEC_GPIO_IRQTYPE_OFFSET(p), &ctx->emask[0]);
> +       regmap_read(regmap, DMEC_GPIO_IRQTYPE_OFFSET(p) + 1, &ctx->emask[1]);
> +       regmap_read(regmap, DMEC_GPIO_IRQCFG_OFFSET(p), &ctx->icfg[0]);
> +       regmap_read(regmap, DMEC_GPIO_IRQCFG_OFFSET(p) + 1, &ctx->icfg[1]);
> +
> +       devm_free_irq(&pdev->dev, p->irq, p);

That seems a bit violent.

> +static int dmec_gpio_resume(struct platform_device *pdev)
> +{
> +       struct dmec_gpio_priv *p = platform_get_drvdata(pdev);
> +       struct regmap *regmap = p->regmap;
> +       struct dmec_reg_ctx *ctx = &p->regs;
> +       int ret;
> +
> +       regmap_write(regmap, DMEC_GPIO_BASE(p), ctx->dat);
> +       regmap_write(regmap, DMEC_GPIO_DIR_OFFSET(p), ctx->dir);
> +       regmap_write(regmap, DMEC_GPIO_IRQCFG_OFFSET(p), ctx->icfg[0]);
> +       regmap_write(regmap, DMEC_GPIO_IRQCFG_OFFSET(p) + 1, ctx->icfg[1]);
> +       regmap_write(regmap, DMEC_GPIO_IRQTYPE_OFFSET(p), ctx->emask[0]);
> +       regmap_write(regmap, DMEC_GPIO_IRQTYPE_OFFSET(p) + 1, ctx->emask[1]);
> +       regmap_write(regmap, DMEC_GPIO_IRQCFG_OFFSET(p), ctx->imask);
> +       regmap_write(regmap, DMEC_GPIO_EVTSTA_OFFSET(p), 0xff);
> +
> +       ret = devm_request_threaded_irq(&pdev->dev, p->irq,
> +                                       NULL, dmec_gpio_irq_handler,
> +                                       IRQF_ONESHOT | IRQF_SHARED,
> +                                       dev_name(&pdev->dev), p);
> +       if (ret)
> +               dev_err(&pdev->dev, "unable to get irq: %d\n", ret);

Re-requesting the IRQ for every suspend/resume cycle?

That's not right.

Look into the wakeup API. You need to tell the core whether this IRQ
should be masked during suspend or not, the default is to mask it I think.

This is too big hammer to solve that.

> +static struct platform_driver dmec_gpio_driver = {
> +       .driver = {
> +               .name = "dmec-gpio",
> +               .owner = THIS_MODULE,
> +       },
> +       .probe = dmec_gpio_probe,
> +       .remove = dmec_gpio_remove,
> +       .suspend = dmec_gpio_suspend,
> +       .resume = dmec_gpio_resume,
> +};

Don't use the legacy suspend/resume callbacks.

Use the DEV_PM_OPS directly in .pm in .driver above. It should
work the same.

(You probably need to fix this on the other patches too.)

Yours,
Linus Walleij
