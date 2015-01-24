Return-path: <zajec5@gmail.com>
MIME-Version: 1.0
In-Reply-To: <54C3C90B.1060503@roeck-us.net>
References: <1422107244-32097-1-git-send-email-zajec5@gmail.com>
	<54C3C90B.1060503@roeck-us.net>
Date: Sat, 24 Jan 2015 17:45:39 +0100
Message-ID: <CACna6rwZN0XcdhCcUMef-=awk_FUG+z7LWt5t2xsLT5L6ddT4A@mail.gmail.com>
Subject: Re: [PATCH] watchdog: bcm47xx_wdt.c: add restart handler support
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

On 24 January 2015 at 17:32, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/24/2015 05:47 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
>>
>> Just like in case of other watchdog drivers, use the new kernel core
>> API to provide restart support.
>>
>> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
>> ---
>>   drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/bcm47xx_wdt.c
>> b/drivers/watchdog/bcm47xx_wdt.c
>> index 9816485..dac3c5d 100644
>> --- a/drivers/watchdog/bcm47xx_wdt.c
>> +++ b/drivers/watchdog/bcm47xx_wdt.c
>> @@ -169,6 +169,17 @@ static int bcm47xx_wdt_notify_sys(struct
>> notifier_block *this,
>>         return NOTIFY_DONE;
>>   }
>>
>> +static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned lo=
ng
>> mode,
>> +                              void *cmd)
>> +{
>> +       struct bcm47xx_wdt *wdt;
>> +
>> +       wdt =3D container_of(this, struct bcm47xx_wdt, restart_handler);
>> +       wdt->timer_set(wdt, 1);
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>>   static struct watchdog_ops bcm47xx_wdt_soft_ops =3D {
>>         .owner          =3D THIS_MODULE,
>>         .start          =3D bcm47xx_wdt_soft_start,
>> @@ -204,20 +215,27 @@ static int bcm47xx_wdt_probe(struct platform_devic=
e
>> *pdev)
>>         watchdog_set_nowayout(&wdt->wdd, nowayout);
>>
>>         wdt->notifier.notifier_call =3D &bcm47xx_wdt_notify_sys;
>> -
>>         ret =3D register_reboot_notifier(&wdt->notifier);
>>         if (ret)
>>                 goto err_timer;
>>
>> -       ret =3D watchdog_register_device(&wdt->wdd);
>> +       wdt->restart_handler.notifier_call =3D &bcm47xx_wdt_restart;
>> +       wdt->restart_handler.priority =3D 128;
>
>
> This should be low priority since it doesn't immediately restart the syst=
em
> but uses a watchdog timeout.

I think this is also the only way to reboot Broadcom device. Is there
some howto on values I should use? Should I change it to sth like 64?
Or what number?

--=20
Rafa=C5=82
