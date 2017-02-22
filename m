Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:37568 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754828AbdBVQ4o (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 Feb 2017 11:56:44 -0500
Subject: Re: [PATCH v2 4/6] bus: add driver for the Technologic Systems NBUS
To: Linus Walleij <linus.walleij@linaro.org>
References: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170203194729.20995-5-sebastien.bourdelin@savoirfairelinux.com>
 <CACRpkdYfGmVBYgAc4KZGN6634WM_EyzNj_SBbALEs4WYipXRQA@mail.gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@savoirfairelinux.com>,
        Rob Herring <robh@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Featherston <mark@embeddedarm.com>, kris@embeddedarm.com,
        Simon Horman <horms+renesas@verge.net.au>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Wim Van Sebroeck <wim@iguana.be>,
        Mark Rutland <mark.rutland@arm.com>,
        damien.riegel@savoirfairelinux.com,
        Lucile Quirion <lucile.quirion@savoirfairelinux.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <82dfdbb8-58fc-45b4-685c-98be11341e45@savoirfairelinux.com>
Date: Wed, 22 Feb 2017 11:56:40 -0500
MIME-Version: 1.0
In-Reply-To: <CACRpkdYfGmVBYgAc4KZGN6634WM_EyzNj_SBbALEs4WYipXRQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

First thanks for your code review!

On 02/04/2017 05:14 AM, Linus Walleij wrote:
> On Fri, Feb 3, 2017 at 8:47 PM, Sebastien Bourdelin
> <sebastien.bourdelin@savoirfairelinux.com> wrote:
> 
>> This driver implements a GPIOs bit-banged bus, called the NBUS by
>> Technologic Systems. It is used to communicate with the peripherals in
>> the FPGA on the TS-4600 SoM.
>>
>> ---
>> Changes v1 -> v2:
>>   - rebase on master
>>   - the driver now populate its child nodes
>>   - remove the 'default y' option from the Kconfig
>>   - rework the driver to not use singleton anymore (suggested by Linus
>>   Walleij)
>>   - replace the use of the legacy GPIO API with gpiod (suggested by
>>   Linus Walleij)
>>   - use the ts vendor prefix for gpios (suggested by Rob Herring)
>>
>> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> 
> This is starting to look nice!
> 
> More comments:
> 
> First, you sprinked "inline" like cinnamon over everything, skip that. The
> compiler will inline selectively as it seems fit if you turn on optimization.
> 
Ok.

>> +static DEFINE_MUTEX(ts_nbus_lock);
> 
> Move this into struct ts_nbus, initialize the mutex in probe()
> and just mutex_lock(&ts_nbus->lock); etc.
> 
Ok.

>> + * the txrx gpio is used by the FPGA to know if the following transactions
>> + * should be handled to read or write a value.
>> + */
>> +static inline void ts_nbus_set_mode(struct ts_nbus *ts_nbus, int mode)
> 
> Why inline? Let the compiler decide about that.
> 
Ok.

>> +{
>> +       if (mode == TS_NBUS_READ_MODE)
> 
> This mode parameter is too complicated. Isn't it just a bool?
> (not superimportant)
> 
>> +               gpiod_set_value_cansleep(ts_nbus->txrx, 0);
>> +       else
>> +               gpiod_set_value_cansleep(ts_nbus->txrx, 1);
>> +}
> 
> You're certainly just using it as a bool.
> 
I will remove this function to simplify the logic.

>> +static inline void ts_nbus_set_direction(struct ts_nbus *ts_nbus, int direction)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < ts_nbus->data->ndescs; i++) {
>> +               if (direction == TS_NBUS_DIRECTION_IN)
>> +                       gpiod_direction_input(ts_nbus->data->desc[i]);
>> +               else
>> +                       gpiod_direction_output(ts_nbus->data->desc[i], 1);
> 
> Add a comment here explaining why you driver the line high by default
> when setting it to output mode. It certainly makes sense but how
> does the electronics work and why?
> 
Ok.

>> +static inline void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
>> +{
>> +       int i;
>> +       int values[ts_nbus->data->ndescs];
>> +
>> +       for (i = 0; i < ts_nbus->data->ndescs; i++)
>> +               values[i] = 0;
>> +
>> +       gpiod_set_array_value_cansleep(ts_nbus->data->ndescs,
>> +                       ts_nbus->data->desc, values);
>> +       gpiod_set_value_cansleep(ts_nbus->csn, 0);
>> +       gpiod_set_value_cansleep(ts_nbus->strobe, 0);
>> +       gpiod_set_value_cansleep(ts_nbus->ale, 0);
> 
> Add a comment about the process taken when this bus is reset. We
> see what is happening, but why?
> 
Ok.

>> +/*
>> + * let the FPGA knows it can process.
>> + */
>> +static inline void ts_nbus_start_transaction(struct ts_nbus *ts_nbus)
> 
> Why inline?
> 
I will remove all the inline.

>> +{
>> +       gpiod_set_value_cansleep(ts_nbus->strobe, 1);
>> +}
> 
> For example this is a well commented function. We see what is happening
> and stobe has an evident name. Nice work!
> 
>> +/*
>> + * return the byte value read from the data gpios.
>> + */
>> +static inline u8 ts_nbus_read_byte(struct ts_nbus *ts_nbus)
> 
> Why inline?
> 
Ditto.

> Then this cannot fail can it?
> 
> I think this accessor should be changed to return an error code.
> 
> static int ts_nbus_read_byte(struct ts_nbus *ts_nbus, u8 *val);
> 
> Then if the return value from the function is != 0 it failed. Simple
> to check, just pass a pointer to the value you are getting in
> val.
> 
> I KNOW I KNOW, not you have to put in error handling everywhere,
> what a DRAG! But we usually follow that pattern because...
> 
>> +{
>> +       struct gpio_descs *gpios = ts_nbus->data;
>> +       int i;
>> +       u8 value = 0;
>> +
>> +       for (i = 0; i < gpios->ndescs; i++)
> 
> Using gpios->ndescs is a bit overparametrized right? Isn't it
> simply 8 bits? Just putting 8 there is fine IMO. All 8 descs
> must be available for the thing to work anyway right?
> 
>> +               if (gpiod_get_value_cansleep(gpios->desc[i]))
> 
> This can fail and you should return an error if < 0...
> 
> You are ignoring that right now. That is why the function should
> be returning an error code that is usually 0.
> 
You are right,
this can fail, i will propagate the "gpiod_get_value_cansleep(...)"
errno value.

>> +                       value |= 1 << i;
> 
> Use:
> #include <linux/bitops.h>
> 
> value |= BIT(i);
>
Ok.

>> +/*
>> + * set the data gpios accordingly to the byte value.
>> + */
>> +static inline void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
>> +{
>> +       struct gpio_descs *gpios = ts_nbus->data;
>> +       int i;
>> +       int values[gpios->ndescs];
>> +
>> +       for (i = 0; i < gpios->ndescs; i++)
>> +               if (byte & (1 << i))
>> +                       values[i] = 1;
>> +               else
>> +                       values[i] = 0;
>> +
>> +       gpiod_set_array_value_cansleep(gpios->ndescs, gpios->desc, values);
> 
> This can also fail and you should check the return code and print an error
> message if it does.
> 
As far as i understood, the "gpiod_set_array_value_cansleep(...)"
function doesn't return
anything, it will return immediately if gpios->desc is null but nothing
else.
Did i miss something?

>> +/*
>> + * reading the bus consists of resetting the bus, then notifying the FPGA to
>> + * send the data in the data gpios and return the read value.
>> + */
>> +static inline u8 ts_nbus_read_bus(struct ts_nbus *ts_nbus)
> 
> All this inline...
Ok :)

> 
>> +/*
>> + * writing to the bus consists of resetting the bus, then define the type of
>> + * command (address/value), write the data and notify the FPGA to retrieve the
>> + * value in the data gpios.
>> + */
>> +static inline void ts_nbus_write_bus(struct ts_nbus *ts_nbus, int cmd, u8 value)
>> +{
>> +       ts_nbus_reset_bus(ts_nbus);
>> +
>> +       if (cmd == TS_NBUS_WRITE_ADR)
>> +               gpiod_set_value_cansleep(ts_nbus->ale, 1);
>> +
>> +       ts_nbus_write_byte(ts_nbus, value);
>> +       ts_nbus_start_transaction(ts_nbus);
> 
> Error codes?
> 
Same question here, these functions only make call to
"gpiod_set_value_cansleep(...)",
which as far as i understood doesn't return any error code.

>> +       /* reading value MSB first */
>> +       do {
>> +               val = 0;
>> +               for (i = 1; i >= 0; i--)
>> +                       val |= (ts_nbus_read_bus(ts_nbus) << (i * 8));
> 
> Hard to deal with errors in this loop!
I will reformat this part.

> 
>> +               gpiod_set_value_cansleep(ts_nbus->csn, 1);
> 
> Here too.
>
Same question, doesn't seem to have an error code.

>> +++ b/include/linux/ts-nbus.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * Copyright (c) 2016 - Savoir-faire Linux
>> + * Author: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#ifndef _TS_NBUS_H
>> +#define _TS_NBUS_H
>> +
>> +struct ts_nbus {
>> +       struct pwm_device *pwm;
>> +       struct gpio_descs *data;
>> +       struct gpio_desc *csn;
>> +       struct gpio_desc *txrx;
>> +       struct gpio_desc *strobe;
>> +       struct gpio_desc *ale;
>> +       struct gpio_desc *rdy;
>> +};
> 
> Is any consumer really looking into this struct? If not, why
> do you expose it?
> 
> Move it to the ts-nbus.c file.
> 
> The only thing you need in this header is:
> 
> struct ts_nbus;
> 
> Just that one line. The rest of the code, like the declarations
> below and all call sites, are just dealing with "pointers to something",
> they don't need to know what it is. You'll be amazed to see how it compiles.
> struct gpio_desc works exactly like that.
> 
Ok.

>> +extern u16 ts_nbus_read(struct ts_nbus *, u8 adr);
>> +extern int ts_nbus_write(struct ts_nbus *, u8 adr, u16 value);
> 
> I suspect the first function should be augmented to return an error code.
> 
Yes it will.

> Yours,
> Linus Walleij
> 

Thanks you Linus,

Best Regards,
Sebastien Bourdelin.

