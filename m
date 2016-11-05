Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34659 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbcKEI3b (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 5 Nov 2016 04:29:31 -0400
Received: by mail-qt0-f169.google.com with SMTP id n6so61653066qtd.1
        for <linux-watchdog@vger.kernel.org>; Sat, 05 Nov 2016 01:29:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161102083751.6335-3-richard.dorsch@gmail.com>
References: <20161102083751.6335-1-richard.dorsch@gmail.com> <20161102083751.6335-3-richard.dorsch@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 5 Nov 2016 09:29:29 +0100
Message-ID: <CACRpkdZfegDfpV-qK8FkvRnCWZQT8R3CkB_t7r+pyNhQ3_hHpA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] Add Advantech iManager GPIO driver
To: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        jo.sunga@advantech.com, weilun.huang@advantech.com,
        andrew.chou@advantech.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 2, 2016 at 9:37 AM, Richard Vidal-Dorsch
<richard.dorsch@gmail.com> wrote:

> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

> +#include <linux/device.h>
> +#include <linux/gpio.h>

#include <linux/gpio/driver.h>
should be enough.

> +#include <linux/init.h>
> +#include <linux/mfd/imanager.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +
> +#define EC_GPIOF_DIR_OUT       BIT(6)
> +#define EC_GPIOF_DIR_IN                BIT(7)
> +
> +struct imanager_gpio_data {
> +       struct imanager_device_data *imgr;
> +       struct gpio_chip chip;
> +};

Maybe some kerneldoc for this. Not necessary though since its sort of
self-explanatory.

> +static int imanager_gpio_direction_in(struct gpio_chip *chip, uint offset)
> +{
> +       struct imanager_gpio_data *data = gpiochip_get_data(chip);
> +       struct imanager_device_data *imgr = data->imgr;
> +       struct imanager_device_attribute *attr = imgr->ec.gpio.attr[offset];
> +
> +       mutex_lock(&imgr->lock);
> +       imanager_write8(&imgr->ec, EC_CMD_GPIO_DIR_WR, attr->did,
> +                       EC_GPIOF_DIR_IN);
> +       mutex_unlock(&imgr->lock);

It kind of looks like it would be smarter if the imanager_write8() was
taking and releasing the lock so you don't have to do it everywhere.

> +static int imanager_gpio_get_direction(struct gpio_chip *chip, uint offset)
> +{
> +       struct imanager_gpio_data *data = gpiochip_get_data(chip);
> +       struct imanager_device_data *imgr = data->imgr;
> +       struct imanager_device_attribute *attr = imgr->ec.gpio.attr[offset];
> +       int ret;
> +
> +       mutex_lock(&imgr->lock);
> +       ret = imanager_read8(&imgr->ec, EC_CMD_GPIO_DIR_RD, attr->did);
> +       mutex_unlock(&imgr->lock);
> +
> +       return ret & EC_GPIOF_DIR_IN ? GPIOF_DIR_IN : GPIOF_DIR_OUT;

Don't use GPIOF* flags, those are for consumers. Just return 0/1.

> +static int imanager_gpio_get(struct gpio_chip *chip, uint offset)
> +{
> +       struct imanager_gpio_data *data = gpiochip_get_data(chip);
> +       struct imanager_device_data *imgr = data->imgr;
> +       struct imanager_device_attribute *attr = imgr->ec.gpio.attr[offset];
> +       int ret;
> +
> +       mutex_lock(&imgr->lock);
> +       ret = imanager_read8(&imgr->ec, EC_CMD_HWP_RD, attr->did);
> +       mutex_unlock(&imgr->lock);
> +
> +       return ret;
> +}

Can the read function return an error code? In that case it should be checked
everywhere.

Also be sure to clamp ret like this:

return !!ret;

Apart from this it looks good.

Yours,
Linus Walleij
