Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <8e133764-0caa-92bc-4a30-1e0b154b4b4e@roeck-us.net>
References: <20170926200712.10069-1-linus.walleij@linaro.org>
 <20170926200712.10069-2-linus.walleij@linaro.org> <8e133764-0caa-92bc-4a30-1e0b154b4b4e@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 9 Oct 2017 01:25:59 +0200
Message-ID: <CACRpkdYn5FKh-rcSdu6E+BRuS7PWo3X82UH3=PYMC5F+8HuoRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: gpio: Convert to use GPIO descriptors
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Oct 8, 2017 at 6:22 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 09/26/2017 01:07 PM, Linus Walleij wrote:

>> @@ -35,11 +35,11 @@ struct gpio_wdt_priv {
>>     static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
>>   {
>> -       gpio_set_value_cansleep(priv->gpio, !priv->active_low);
>> +       gpiod_set_value_cansleep(priv->gpiod, 0);
>
> This ...

Bah that's wrong. As anyone can see.

>>         case HW_ALGO_LEVEL:
>>                 /* Pulse */
>> -               gpio_set_value_cansleep(priv->gpio, !priv->active_low);
>> +               gpiod_set_value_cansleep(priv->gpiod, 1);
>
>
> ... and this seem to contradict each other.

Sorry, fixing.

Thanks a lot for spotting this!

Yours,
Linus Walleij
