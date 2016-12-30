Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34936 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbcL3H6y (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 30 Dec 2016 02:58:54 -0500
Received: by mail-qk0-f174.google.com with SMTP id u25so280922661qki.2
        for <linux-watchdog@vger.kernel.org>; Thu, 29 Dec 2016 23:58:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161214231237.17496-5-sebastien.bourdelin@savoirfairelinux.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com> <20161214231237.17496-5-sebastien.bourdelin@savoirfairelinux.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Dec 2016 08:58:53 +0100
Message-ID: <CACRpkdYHHrYY-fAPnNmV94ejFJ36rhSF0SqSVHkTNq+YCRNNZw@mail.gmail.com>
Subject: Re: [PATCH 4/6] bus: add driver for the Technologic Systems NBUS
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@savoirfairelinux.com>, mark@embeddedarm.com,
        kris@embeddedarm.com, Simon Horman <horms+renesas@verge.net.au>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        damien.riegel@savoirfairelinux.com,
        Lucile Quirion <lucile.quirion@savoirfairelinux.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Dec 15, 2016 at 12:12 AM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:

> This driver implements a GPIOs bit-banged bus, called the NBUS by
> Technologic Systems. It is used to communicate with the peripherals in
> the FPGA on the TS-4600 SoM.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
(...)

> +#include <linux/gpio.h>

Use:
#include <linux/gpio/consumer.h>
instead, and deal with the fallout.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>

Don't use this.

> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +static DEFINE_MUTEX(ts_nbus_lock);
> +static bool ts_nbus_ready;

Why not move this to the struct ts_nbus state container?

It seems to be per-bus not per-system.

> +#define TS_NBUS_READ_MODE  0
> +#define TS_NBUS_WRITE_MODE 1
> +#define TS_NBUS_DIRECTION_IN  0
> +#define TS_NBUS_DIRECTION_OUT 1
> +#define TS_NBUS_WRITE_ADR 0
> +#define TS_NBUS_WRITE_VAL 1
> +
> +struct ts_nbus {
> +       struct pwm_device *pwm;
> +       int num_data;
> +       int *data;
> +       int csn;
> +       int txrx;
> +       int strobe;
> +       int ale;
> +       int rdy;
> +};
> +
> +static struct ts_nbus *ts_nbus;

Nopes. No singletons please.

Use the state container pattern:
Documentation/driver-model/design-patterns.txt

> +/*
> + * request all gpios required by the bus.
> + */
> +static int ts_nbus_init(struct platform_device *pdev)
> +{
> +       int err;
> +       int i;
> +
> +       for (i = 0; i < ts_nbus->num_data; i++) {
> +               err = devm_gpio_request_one(&pdev->dev, ts_nbus->data[i],
> +                                           GPIOF_OUT_INIT_HIGH,
> +                                           "TS NBUS data");
> +               if (err)
> +                       return err;
> +       }

DO not use the legacy GPIO API anywhere.

Reference the device and use gpiod_get() simple, fair and square.

Store struct gpio_desc * pointers in your state container instead.

> +static int ts_nbus_get_of_pdata(struct device *dev, struct device_node *np)
> +{
> +       int num_data;
> +       int *data;
> +       int ret;
> +       int i;
> +
> +       ret = of_gpio_named_count(np, "data-gpios");
> +       if (ret < 0) {
> +               dev_err(dev,
> +                       "failed to count GPIOs in DT property data-gpios\n");
> +               return ret;
> +       }

Do not reinvent the wheel.

Use devm_gpiod_get_array().


> +       ret = of_get_named_gpio(np, "csn-gpios", 0);

And again use devm_gpiod_get(), and gpiod_* accessors.
Applies everywhere.

Yours,
Linus Walleij
