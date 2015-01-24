Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54931 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbbAXTCT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Jan 2015 14:02:19 -0500
Received: by mail-lb0-f177.google.com with SMTP id p9so2416483lbv.8
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Jan 2015 11:02:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54C3DFC9.7000708@roeck-us.net>
References: <1422107244-32097-1-git-send-email-zajec5@gmail.com>
	<54C3C90B.1060503@roeck-us.net>
	<CACna6rwZN0XcdhCcUMef-=awk_FUG+z7LWt5t2xsLT5L6ddT4A@mail.gmail.com>
	<54C3CE2C.1000107@roeck-us.net>
	<CACna6rwESHnzbfLrUG2U5M-HmsYytjptzrfxuLYEGfrGdiwu+w@mail.gmail.com>
	<54C3DFC9.7000708@roeck-us.net>
Date: Sat, 24 Jan 2015 20:02:17 +0100
Message-ID: <CACna6rz2QZrYf4LNvGsi2LL-BDLDwiB4pBk_tZCvoFbHYwLe=A@mail.gmail.com>
Subject: Re: [PATCH] watchdog: bcm47xx_wdt.c: add restart handler support
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24 January 2015 at 19:09, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/24/2015 09:31 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
>>
>> On 24 January 2015 at 17:54, Guenter Roeck <linux@roeck-us.net> wrot=
e:
>>>
>>> On 01/24/2015 08:45 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
>>>>
>>>>
>>>> On 24 January 2015 at 17:32, Guenter Roeck <linux@roeck-us.net> wr=
ote:
>>>>>
>>>>>
>>>>> On 01/24/2015 05:47 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Just like in case of other watchdog drivers, use the new kernel =
core
>>>>>> API to provide restart support.
>>>>>>
>>>>>> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
>>>>>> ---
>>>>>>     drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
>>>>>>     1 file changed, 20 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/watchdog/bcm47xx_wdt.c
>>>>>> b/drivers/watchdog/bcm47xx_wdt.c
>>>>>> index 9816485..dac3c5d 100644
>>>>>> --- a/drivers/watchdog/bcm47xx_wdt.c
>>>>>> +++ b/drivers/watchdog/bcm47xx_wdt.c
>>>>>> @@ -169,6 +169,17 @@ static int bcm47xx_wdt_notify_sys(struct
>>>>>> notifier_block *this,
>>>>>>           return NOTIFY_DONE;
>>>>>>     }
>>>>>>
>>>>>> +static int bcm47xx_wdt_restart(struct notifier_block *this, uns=
igned
>>>>>> long
>>>>>> mode,
>>>>>> +                              void *cmd)
>>>>>> +{
>>>>>> +       struct bcm47xx_wdt *wdt;
>>>>>> +
>>>>>> +       wdt =3D container_of(this, struct bcm47xx_wdt, restart_h=
andler);
>>>>>> +       wdt->timer_set(wdt, 1);
>>>>>> +
>>>>>> +       return NOTIFY_DONE;
>>>>>> +}
>>>>>> +
>>>>>>     static struct watchdog_ops bcm47xx_wdt_soft_ops =3D {
>>>>>>           .owner          =3D THIS_MODULE,
>>>>>>           .start          =3D bcm47xx_wdt_soft_start,
>>>>>> @@ -204,20 +215,27 @@ static int bcm47xx_wdt_probe(struct
>>>>>> platform_device
>>>>>> *pdev)
>>>>>>           watchdog_set_nowayout(&wdt->wdd, nowayout);
>>>>>>
>>>>>>           wdt->notifier.notifier_call =3D &bcm47xx_wdt_notify_sy=
s;
>>>>>> -
>>>>>>           ret =3D register_reboot_notifier(&wdt->notifier);
>>>>>>           if (ret)
>>>>>>                   goto err_timer;
>>>>>>
>>>>>> -       ret =3D watchdog_register_device(&wdt->wdd);
>>>>>> +       wdt->restart_handler.notifier_call =3D &bcm47xx_wdt_rest=
art;
>>>>>> +       wdt->restart_handler.priority =3D 128;
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> This should be low priority since it doesn't immediately restart =
the
>>>>> system
>>>>> but uses a watchdog timeout.
>>>>
>>>>
>>>>
>>>> I think this is also the only way to reboot Broadcom device. Is th=
ere
>>>> some howto on values I should use? Should I change it to sth like =
64?
>>>> Or what number?
>>>>
>>>
>>> 64 is fine.
>>>
>>> You never know if someone using that chip implements, for example, =
reset
>>> with a gpio pin.
>>
>>
>> Sure, that's why I wanted to left 129-255 values for other situation=
s.
>> As watchdog reset is used in 99% of cases, I wanted to use the middl=
e
>> priority for it.
>>
> ... and then forcing everyone else to use a higher priority than 128,
> resulting in a priority war. Guess those who predicted that this woul=
d
> happen were right after all :-(.

At least you're there to stop non-aware developers ;)

But honestly maybe it'd be worth to document this priority a bit
better. Documentation from kernel/reboot.c:
> 128: Default restart handler; use if no other restart handler is expe=
cted to be available, and/or if restart functionality is sufficient to =
restart the entire system
made me believe I'm doing well. Apparently I didn't understand it well =
enough :|


>> Actually it seems that currently every watchdog driver with restart
>> handler uses priority 128. This includes: alim7101_wdt.c dw_wdt.c
>> imx2_wdt.c meson_wdt.c moxart_wdt.c s3c2410_wdt.c sunxi_wdt.c
>>
>> Are you sure this value 128 is wrong in case of bcm47xx_wdt? What
>> makes it alright for all other drivers?
>>
> The other drivers do not use a watchdog timeout to accomplish an indi=
rect
> restart, but use a register from the set of registers used by the wat=
chdog
> driver to implement the restart. Or at least that is how it should be=
=2E

Uh, that "register from the set of registers used by the watchdog
driver to implement the restart" make it really complex to follow for
someone non-involved into restart/priorities/watchdog.

I can't really see the difference, I'll just trust your comment.

P.S.
I just checked few watchdog drivers and:
1) meson_wdt.c uses
while (1) {
        (..., no break)
        mdelay(5);
}
2) sunxi_wdt.c uses
while (1) {
        mdelay(5);
        (..., no break)
}

Since they loop forever in restart handler it seems they also force
all other handlers to use priority higher than 128.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
