Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:50807 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbaIFQtR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Sep 2014 12:49:17 -0400
Received: by mail-la0-f46.google.com with SMTP id pv20so15447544lab.19
        for <linux-watchdog@vger.kernel.org>; Sat, 06 Sep 2014 09:49:16 -0700 (PDT)
Message-ID: <540B3B0A.5040307@contactless.ru>
Date: Sat, 06 Sep 2014 20:49:14 +0400
From: Evgeny Boger <boger@contactless.ru>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	Alexander Shiyan <shc_work@mail.ru>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support for always enabled watchdog timers
References: <1408236338-12555-1-git-send-email-boger@contactless.ru> <53F8CC58.2030406@roeck-us.net> <1408814702.730436497@f133.i.mail.ru> <53F8D052.6060705@roeck-us.net>
In-Reply-To: <53F8D052.6060705@roeck-us.net>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/23/2014 09:33 PM, Guenter Roeck wrote:
> On 08/23/2014 10:25 AM, Alexander Shiyan wrote:
>> Sat, 23 Aug 2014 10:16:08 -0700 =D0=BE=D1=82 Guenter Roeck <linux@ro=
eck-us.net>:
>>> On 08/16/2014 05:45 PM, Evgeny Boger wrote:
>>>> From: Evgeny Boger <boger@contactless.ru>
>>>>
>>>> Add option to use with watchdog timers which are always enabled
>>>> in hardware, i.e. there is no way to enable/disable it via GPIO pi=
n.
>>>> The driver will start pinging WDT immediately upon loading
>>>> and will continue to do so even after stopping the watchdog.
>>>>
>>> The headline needs a reference to the affected driver.
>>>
>>> Also, please copy the dt mailing list and maintainers.
>>>
>>>> Signed-off-by: Evgeny Boger <boger@contactless.ru>
>>>> ---
>>>>    .../devicetree/bindings/watchdog/gpio-wdt.txt      | 14 ++++++-
>>>>    drivers/watchdog/gpio_wdt.c                        | 45=20
>>>> +++++++++++++++++-----
>>>>    2 files changed, 48 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git=20
>>>> a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt=20
>>>> b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
>>>> index 37afec1..1f8ca46 100644
>>>> --- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
>>>> +++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
>>>> @@ -12,8 +12,11 @@ Required Properties:
>>>>        the opposite level disables the WDT. Active level is determ=
ined
>>>>        by the GPIO flags.
>>>>    - hw_margin_ms: Maximum time to reset watchdog circuit=20
>>>> (milliseconds).
>>>> +- always-enabled: Use with wathdog timer which is always enabled
>>
>> Similar to NOWAYOUT?
>>
> I think this one is different. NOWAYOUT is a software flag, while
> the flag here is supposed to mean that the hardware watchdog
> is always enabled and running, and can not be disabled. Or at least
> this is my understanding.

exactly

>
> Guenter
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
     =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=B9 =D0=91=D0=BE=D0=B3=D0=B5=
=D1=80
     =D0=9E=D0=9E=D0=9E =D0=91=D0=B5=D1=81=D0=BA=D0=BE=D0=BD=D1=82=D0=B0=
=D0=BA=D1=82=D0=BD=D1=8B=D0=B5 =D1=83=D1=81=D1=82=D1=80=D0=BE=D0=B9=D1=81=
=D1=82=D0=B2=D0=B0
     http://contactless.ru
     +7 (919) 965 88 36

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
