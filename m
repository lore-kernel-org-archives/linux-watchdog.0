Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34878 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbcJTWYp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Oct 2016 18:24:45 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so121933019qkc.2
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Oct 2016 15:24:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1475853451-22121-8-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com> <1475853451-22121-8-git-send-email-pantelis.antoniou@konsulko.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Oct 2016 00:24:42 +0200
Message-ID: <CACRpkdaYVgwBS_QR+S4CafP0jFrn8jw-Ewc_m8LDXUK5sMMwTw@mail.gmail.com>
Subject: Re: [PATCH 07/10] gpio: ptxpmb-cpld: Add support for PTXPMB CPLD's GPIO
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Rosin <peda@axentia.se>,
        Debjit Ghosh <dghosh@juniper.net>,
        Georgi Vlaev <gvlaev@juniper.net>,
        Guenter Roeck <groeck@juniper.net>,
        JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
        Rajat Jain <rajatjain@juniper.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 7, 2016 at 5:17 PM, Pantelis Antoniou
<pantelis.antoniou@konsulko.com> wrote:

> From: Guenter Roeck <groeck@juniper.net>
>
> Support the GPIO block which is located in PTXPMB CPLDs
> on relevant Juniper platforms.
>
> Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
> Signed-off-by: Guenter Roeck <groeck@juniper.net>
> Signed-off-by: Rajat Jain <rajatjain@juniper.net>
> [Ported from Juniper kernel]
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

Nice with preserved credits.

> +config GPIO_PTXPMB_CPLD
> +       tristate "PTXPMB CPLD GPIO"
> +       depends on MFD_JUNIPER_CPLD
> +       default y if MFD_JUNIPER_CPLD

Can't you do something like

default MFD_JUNIPER_CPLD

so it will become a module if the MFD driver is a module
and compiled-in if the MFD driver is compiled in?

Please check if that works.

> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/gpio.h>

Just:
#include <linux/gpio/driver.h>

Should work.

> +#include <linux/errno.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>

Strange that a PCI driver need so much OF stuff.
Really? But OK, do you really use all these includes?

> +#include <linux/io.h>
> +#include <linux/module.h>
> +
> +#include <linux/mfd/ptxpmb_cpld.h>

Is this include deserving a separate whitespace in
front of it?

> +static u8 *ptxpmb_cpld_gpio_get_addr(struct pmb_boot_cpld *cpld,
> +                                    unsigned int nr)
> +{
> +       if (nr < 8)                     /* 0..7: reset                  */
> +               return &cpld->reset;
> +       else if (nr < 16)               /* 8..15: control               */
> +               return &cpld->control;
> +       else if (nr < 24)               /* 16..23: gpio1                */
> +               return &cpld->gpio_1;
> +       else if (nr < 32)               /* 24..31: gpio2                */
> +               return &cpld->gpio_2;
> +       else if (nr < 40)               /* 32..39: gp_reset1            */
> +               return &cpld->gp_reset1;
> +       return &cpld->thermal_status;   /* 40..41: thermal status       */
> +}

Reset, control, gp_reset and *especially* thermal status
does not seem to be GPIO at all. Rather these seem to be
special purpose lines rather than general purpose.

Can you explain why the GPIO driver should even poke at them?

It seems other subdrivers should use these registers...

> +static void ptxpmb_cpld_gpio_set(struct gpio_chip *gpio, unsigned int nr,
> +                                int val)
> +{
> +       u32 reg;
> +       u8 bit = 1 << (nr & 7);

Use this:

#include <linux/bitops.h>

Then inline BIT() instead of making a local variable like this.
See below...

> +       struct ptxpmb_cpld_gpio *chip =
> +         container_of(gpio, struct ptxpmb_cpld_gpio, gpio);

Use:
struct ptxpmb_cpld_gpio *cpldg = gpiochip_get_data(gpio);

Please don't name it "chip" it is confusing with the gpio chip
proper.

> +       u8 *addr = ptxpmb_cpld_gpio_get_addr(chip->base, nr);
> +
> +       mutex_lock(&chip->lock);
> +       reg = ioread8(addr);
> +       if (val)
> +               reg |= bit;
> +       else
> +               reg &= ~bit;

So instead:
if (val)
    reg |= BIT(nr);
else
    reg &= ~BIT(nr);

> +static int ptxpmb_cpld_gpio_get(struct gpio_chip *gpio, unsigned int nr)
> +{
> +       struct ptxpmb_cpld_gpio *chip = container_of(gpio,
> +                                                    struct ptxpmb_cpld_gpio,
> +                                                    gpio);

Same comment as before.

> +       u8 *addr = ptxpmb_cpld_gpio_get_addr(chip->base, nr);
> +       u8 bit = 1 << (nr & 7);
> +
> +       return !!(ioread8(addr) & bit);

Same comment on using BIT()

> +static int ptxpmb_cpld_gpio_direction_output(struct gpio_chip *gpio,
> +                                            unsigned int nr, int val)
> +{
> +       return 0;
> +}
> +
> +static int ptxpmb_cpld_gpio_direction_input(struct gpio_chip *gpio,
> +                                           unsigned int nr)
> +{
> +       return 0;
> +}

Oh yeah? Can you explain how this works electronically?

If these lines are open drain you should also implement
.set_single_ended().

> +static void ptxpmb_cpld_gpio_setup(struct ptxpmb_cpld_gpio *chip)

Again rename from chip.

> +static int ptxpmb_cpld_gpio_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct ptxpmb_cpld_gpio *chip;

Rename from chip.

> +       struct resource *res;
> +       struct device *dev = &pdev->dev;
> +
> +       chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +       if (chip == NULL)
> +               return -ENOMEM;
> +
> +       chip->dev = dev;
> +       platform_set_drvdata(pdev, chip);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENODEV;
> +
> +       chip->base = devm_ioremap_nocache(dev, res->start, resource_size(res));
> +       if (!chip->base)
> +               return -ENOMEM;
> +
> +       mutex_init(&chip->lock);
> +       ptxpmb_cpld_gpio_setup(chip);
> +       ret = gpiochip_add(&chip->gpio);

Use devm_gpiochip_add_data() so you can use gpiochip_get_data() in the
callbacks and get rid of container_of().

> +       if (ret) {
> +               dev_err(dev, "CPLD gpio: Failed to register GPIO\n");
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static int ptxpmb_cpld_gpio_remove(struct platform_device *pdev)
> +{
> +       struct ptxpmb_cpld_gpio *chip = platform_get_drvdata(pdev);
> +
> +       gpiochip_remove(&chip->gpio);
> +
> +       return 0;
> +}

If you use devm_gpiochip_add_data() I don't think this function is
even needed.

Yours,
Linus Walleij
