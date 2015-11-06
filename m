Return-path: <carlo@endlessm.com>
MIME-Version: 1.0
In-Reply-To: <20151106221519.GB19791@roeck-us.net>
References: <1446846906-31520-1-git-send-email-carlo@caione.org>
	<1446846906-31520-2-git-send-email-carlo@caione.org>
	<20151106221519.GB19791@roeck-us.net>
Date: Fri, 6 Nov 2015 23:47:38 +0100
Message-ID: <CAL9uMOH4i4ajkF2x7agHe2WZcHTJ=vs9cO+TGx8WGLOFVLZnig@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: meson: Enable meson SoC specific data
From: Carlo Caione <carlo@endlessm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Carlo Caione <carlo@caione.org>, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org,
	Daniel Drake <drake@endlessm.com>, Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>, romain.perier@gmail.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Nov 6, 2015 at 11:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:

>> +struct meson_wdt_data {
>> +     unsigned int shift_enable;
>> +     unsigned int terminal_count_mask;
>> +     unsigned int count_unit;
>> +};
>> +
>> +static struct meson_wdt_data meson6_wdt_data = {
>> +     .shift_enable           = 22,
>
> I have to admit that I completely fail to understand why it would be
> better to move the bit calculation from a constant to runtime.
>
> Can you explain ?

No real reasons and you are right. I'll change it back.

> I am also not really a friend of removing definitions, even if they are
> only used once. But I understand that this is a matter of opinion.
>
>> +     .terminal_count_mask    = 0x3fffff,
>> +     .count_unit             = 100000, /* 10 us */
>> +};
>> +
>>  struct meson_wdt_dev {
>>       struct watchdog_device wdt_dev;
>>       void __iomem *wdt_base;
>>       struct notifier_block restart_handler;
>> +     struct meson_wdt_data *data;
>>  };
>>
>>  static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
>>                               void *cmd)
>>  {
>> -     u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN;
>> +     u32 tc_reboot = MESON_WDT_DC_RESET;
>>       struct meson_wdt_dev *meson_wdt = container_of(this,
>>                                                      struct meson_wdt_dev,
>>                                                      restart_handler);
>> +     tc_reboot |= BIT(meson_wdt->data->shift_enable);
>>
>
> I am quite sure that this results in a checkpatch warning.
> Did you run your patch through checkpatch ?

Yeah, no error/warnings on that line.

>>       while (1) {
>>               writel(tc_reboot, meson_wdt->wdt_base + MESON_WDT_TC);
>> @@ -80,8 +92,8 @@ static void meson_wdt_change_timeout(struct watchdog_device *wdt_dev,
>>       u32 reg;
>>
>>       reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
>> -     reg &= ~MESON_WDT_TC_TM_MASK;
>> -     reg |= MESON_SEC_TO_TC(timeout);
>> +     reg &= ~(meson_wdt->data->terminal_count_mask);
>
> Unnecessary ( )

Ok

>>       meson_wdt = devm_kzalloc(&pdev->dev, sizeof(*meson_wdt), GFP_KERNEL);
>> @@ -153,11 +172,19 @@ static int meson_wdt_probe(struct platform_device *pdev)
>>       if (IS_ERR(meson_wdt->wdt_base))
>>               return PTR_ERR(meson_wdt->wdt_base);
>>
>> +     of_id = of_match_device(meson_wdt_dt_ids, &pdev->dev);
>> +     if (!of_id) {
>> +             dev_err(&pdev->dev, "Unable to setup WDT data\n");
>
> "set up" or maybe better initialize.

Ok

>> +             return -ENODEV;
>> +     }
>> +     meson_wdt->data = (struct meson_wdt_data *) of_id->data;
>
> Is this typecase necessary ?

Just for clarity. Not needed.

I'll fix everything in v2. Thanks.

-- 
Carlo Caione
