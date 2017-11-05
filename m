Return-Path: <andrew.smirnov@gmail.com>
Return-path: <andrew.smirnov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171105154725.GA11226@localhost>
References: <20171031163656.24552-1-andrew.smirnov@gmail.com>
 <20171031163656.24552-5-andrew.smirnov@gmail.com> <20171105154725.GA11226@localhost>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sun, 5 Nov 2017 13:59:13 -0800
Message-ID: <CAHQ1cqGH_Y8i+T9BHqdttQUPwuG08jRaBcYvHoGhm98KYBgtqQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] watchdog: Add RAVE SP watchdog driver
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org,
	Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Nov 5, 2017 at 7:47 AM, Johan Hovold <johan@kernel.org> wrote:
> On Tue, Oct 31, 2017 at 09:36:55AM -0700, Andrey Smirnov wrote:
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
>> Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
>> +static const struct of_device_id rave_sp_wdt_of_match[] = {
>> +     { .compatible = "zii,rave-sp-watchdog" },
>> +     {}
>> +};
>
>> +static const struct of_device_id rave_sp_wdt_variants[] = {
>> +     { .compatible = COMPATIBLE_RAVE_SP_NIU,  .data = &rave_sp_wdt_legacy },
>> +     { .compatible = COMPATIBLE_RAVE_SP_MEZZ, .data = &rave_sp_wdt_legacy },
>> +     { .compatible = COMPATIBLE_RAVE_SP_ESB,  .data = &rave_sp_wdt_legacy },
>> +     { .compatible = COMPATIBLE_RAVE_SP_RDU1, .data = &rave_sp_wdt_rdu    },
>> +     { .compatible = COMPATIBLE_RAVE_SP_RDU2, .data = &rave_sp_wdt_rdu    },
>> +     { /* sentinel */ }
>> +};
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
>
> So as I already mentioned in a comment on an earlier version of the MFD
> driver, I find this matching on the parent of_node to be an odd
> pattern, which also does not seem to have any precedent in mainline.
>
> It seems you really should be using two compatible strings for the
> watchdog (for the legacy and rdu variants) rather than keep an entry for
> every parent compatible-string in every child/cell driver (which all
> need to be kept in sync).
>

That's doable, for sure, but the downside is that it opens the door
for nonsensical configurations as, for example, "zii,rave-sp-niu" as a
parent SP device and "zii,rave-watchdog-rdu" as child watchdog and it
forces majority of child device drivers to split their compatibility
strings into 2 or more "flavors". My preference was to avoid that and
instead deal with having to having to keep things in sync.

> But let's see what Rob and Lee says about this.
>
>> +     if (!id) {
>> +             dev_err(dev, "Unknown parent device variant. Bailing out\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     sp_wd = devm_kzalloc(dev, sizeof(*sp_wd), GFP_KERNEL);
>> +     if (!sp_wd)
>> +             return -ENOMEM;
>> +
>> +     sp_wd->variant = id->data;
>> +     sp_wd->sp      = dev_get_drvdata(dev->parent);
>> +
>> +     wdd              = &sp_wd->wdd;
>> +     wdd->parent      = dev;
>> +     wdd->info        = &rave_sp_wdt_info;
>> +     wdd->ops         = &rave_sp_wdt_ops;
>> +     wdd->min_timeout = sp_wd->variant->min_timeout;
>> +     wdd->max_timeout = sp_wd->variant->max_timeout;
>> +     wdd->status      = WATCHDOG_NOWAYOUT_INIT_STATUS;
>> +     wdd->timeout     = 60;
>> +
>> +     cell = nvmem_cell_get(dev, "wdt-timeout");
>> +     if (!IS_ERR(cell)) {
>> +             size_t len;
>> +             void *value = nvmem_cell_read(cell, &len);
>> +
>> +             if (!IS_ERR(value)) {
>> +                     memcpy(&timeout, value, min(len, sizeof(timeout)));
>> +                     kfree(value);
>> +             }
>> +             nvmem_cell_put(cell);
>> +     }
>> +     watchdog_init_timeout(wdd, le16_to_cpu(timeout), dev);
>> +     watchdog_set_restart_priority(wdd, 255);
>> +
>> +     sp_wd->reboot_notifier.notifier_call = rave_sp_wdt_reboot_notifier;
>> +     ret = devm_register_reboot_notifier(dev, &sp_wd->reboot_notifier);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to register reboot notifier\n");
>> +             return ret;
>> +     }
>> +
>> +     /*
>> +      * We don't know if watchdog is running now. To be sure, let's
>> +      * start it and depend on watchdog core to ping it
>> +      */
>> +     wdd->max_hw_heartbeat_ms = wdd->max_timeout * 1000;
>> +     ret = rave_sp_wdt_start(wdd);
>> +     if (ret) {
>> +             dev_err(dev, "Watchdog didn't start\n");
>> +             return ret;
>> +     }
>> +
>> +     return devm_watchdog_register_device(dev, wdd);
>
> What about stopping the watchdog on errors here?
>
> And does watchdog core take care of calling stop() on unregister (i.e.
> at unbind)?
>

I think Guenter already addressed those, so I'll update the code with
his suggestions in v11.

Thanks,
Andrey Smirnov
