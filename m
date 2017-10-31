Return-Path: <andrew.smirnov@gmail.com>
Return-path: <andrew.smirnov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171028161422.GA6263@roeck-us.net>
References: <20171025190421.18415-5-andrew.smirnov@gmail.com> <20171028161422.GA6263@roeck-us.net>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 31 Oct 2017 08:41:28 -0700
Message-ID: <CAHQ1cqG=ceHLE-2DwrtL90BUDHbbH9bCma06-LO2SSuqZkX99A@mail.gmail.com>
Subject: Re: [v9,4/5] watchdog: Add RAVE SP watchdog driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org,
	Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>,
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Oct 28, 2017 at 9:14 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Oct 25, 2017 at 12:04:20PM -0700, Andrey Smirnov wrote:
>> This driver provides access to RAVE SP watchdog functionality.
>>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-watchdog@vger.kernel.org
>> Cc: cphealy@gmail.com
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>
>> Guenter:
>>
>> In our previous discussion you noted that relying on the state of
>> WDOG_HW_RUNNING was not correct (that should be fixed now), please let
>> me know if using watchdog_hw_running() the way I do in
>> rave_sp_wdt_set_timeout() is incorrect as well.
>>
>
> You could as well have used watchdog_active(), but it is ok.
>

That's easy to change. I'll do that in v10.


>> Thanks,
>> Andrey Smirnov
>>
>>  drivers/watchdog/Kconfig       |   7 +
>>  drivers/watchdog/Makefile      |   1 +
>>  drivers/watchdog/rave-sp-wdt.c | 343 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 351 insertions(+)
>>  create mode 100644 drivers/watchdog/rave-sp-wdt.c
>>
> [ ... ]
>
>> +
>> +static int rave_sp_wdt_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     const struct of_device_id *id;
>> +     struct watchdog_device *wdd;
>> +     struct rave_sp_wdt *sp_wd;
>> +     struct nvmem_cell *cell;
>> +     __le16 timeout = 0;
>> +     int ret;
>> +
>> +     id = of_match_device(rave_sp_wdt_variants, dev->parent);
>> +     if (WARN_ON(!id))
>> +             return -ENODEV;
>> +
>
> I could understand an error message here, but why a traceback ?
>

I can't think of a good reason for it. I'll change this to a regular
error message in v10.

Thanks,
Andrey Smirnov
