Return-path: <adalessandro@santafe.gov.ar>
Message-ID: <5593CF3F.9040206@santafe.gov.ar>
Date: Wed, 01 Jul 2015 08:30:07 -0300
From: adalessandro <adalessandro@santafe.gov.ar>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be,
 ezequiel@vanguardiasur.com.ar
Subject: Re: [PATCH 1/2] watchdog: NXP LPC18XX Windowed Watchdog Timer Driver
References: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar> <1435343072-8753-2-git-send-email-ariel@vanguardiasur.com.ar> <20150626190700.GC23078@roeck-us.net> <55903943.10309@vanguardiasur.com.ar> <5590CDF6.7000103@roeck-us.net>
In-Reply-To: <5590CDF6.7000103@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>


El 29/06/15 a las 01:47, Guenter Roeck escibi=F3:
> On 06/28/2015 11:13 AM, Ariel D'Alessandro wrote:
>>>> +/* Timeout values in seconds */
>>>> +#define LPC_WDT_DEF_TIMEOUT        1
>>>> +
>>>
>>> One second ? This is highly unusual. 30 or 60 seconds is more common,
>>> and one second would be very challenging for user space.
>>>
>>> Any special reason for using such a tight default ?
>>
>> Considering that LPC18xx Watchdog has a fixed divide-by-4 clock
>> pre-scaler and a 24-bit counter and that Watchdog clock runs at a fixe=
d
>> frequency of 12MHz, timeout range goes from 1 to 5 seconds.
>>
>> I think you're right, 1 sec is very challenging, so it's 5 secs then.
>>
> Ultimately you might want to consider a soft timer as backup to the sys=
tem
> timeout. But that can be done later if/when needed.

I understand your point, but just to be sure, what do mean by soft timer?

>=20
>>>> +
>>>> +static int lpc_wdt_remove(struct platform_device *pdev)
>>>> +{
>>>> +    struct lpc_wdt_dev *lpc_wdt =3D platform_get_drvdata(pdev);
>>>> +
>>>> +    lpc_wdt_stop(&lpc_wdt->wdt_dev);
>>>
>>> This will keep the timer enabled. It would be interesting to see what
>>> happens if you build the driver as module and unload it. I think
>>> it will crash. Can you try ?
>>
>> Yes, you're right. After module gets unloaded, timer keeps enabled wit=
h
>> a callback that was deallocated from memory.
>>
>> Since Watchdog cannot be disabled in hardware, it's not going to be
>> possible to remove the driver without resetting the system. Unless we
>> could keep a timer set and running outside the module, it won't be
>> removable.
>>
>> What do you think?
>>
>=20
> My take is that the driver should be loadable as module, which implies
> that it must be removable. Whoever actually does remove the driver
> is really asking for trouble and doesn't deserve better.
>=20
> On the other side, there are a few other watchdogs with similar propert=
ies.
> Maybe we can just take guidance from there. Can you have a look ?
> I can look myself, but it may take a few days.

Ok. I'm sending patchset v2 with all these modifications.

>=20
> Thanks,
> Guenter
>=20
