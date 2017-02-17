Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53511 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbdBQKGH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Feb 2017 05:06:07 -0500
Subject: Re: [PATCH v2 1/3] power: reset: Add Renesas reset driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-2-chris.brandt@renesas.com>
 <20170216182644.GA17814@roeck-us.net>
 <PS1PR06MB1162A4C12D144C321379E3028A5A0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <20170216222014.GA29672@roeck-us.net>
 <PS1PR06MB11622077DE4673C1879C05278A5D0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <55cf087f-aa70-3660-1186-af9b9b20376d@roeck-us.net>
 <CAMuHMdUChhntL0Mw2CY7au87WHj11nBi+0Q2mWSi+RcYpHXgAQ@mail.gmail.com>
Cc: Chris Brandt <Chris.Brandt@renesas.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <fb92af5b-6ed8-ef52-d1d1-4615b5026738@roeck-us.net>
Date: Fri, 17 Feb 2017 02:06:03 -0800
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUChhntL0Mw2CY7au87WHj11nBi+0Q2mWSi+RcYpHXgAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 12:09 AM, Geert Uytterhoeven wrote:
> Hi G=C3=BCnter,
>
> On Fri, Feb 17, 2017 at 5:45 AM, Guenter Roeck <linux@roeck-us.net> wro=
te:
>> On 02/16/2017 06:00 PM, Chris Brandt wrote:
>>> On Thursday, February 16, 2017, Guenter Roeck wrote:
>>> If this WDT had a timeout longer than 125ms, I would make a real watc=
hdog
>>> driver
>>> out of it. But at the moment, it just serves as the only way to reset=
 the
>>> chip.
>>> Historically, this was the only way to reset a SH4 device...and we ju=
st
>>> lived
>>> with that fact. When Renesas moved from SH4 to ARM, a lot of the desi=
gn
>>> teams
>>> just kept the same philosophy (and copied the HW blocks they knew alr=
eady
>>> worked)
>>
>> FWIW, the watchdog subsystem should support that easily, even with 125=
 ms
>> hardware
>> timeout. We added that capability for that very purpose. That would on=
ly
>> fail if
>> the system is stuck with interrupts disabled for more than 125 ms, whi=
ch
>> seems
>> unlikely. I think the gpio watchdog on some systems has a similar low
>> hardware
>> timeout.
>
> I also thought 125ms was a bit short, but I'm happy to be proven wrong!
> Let's make a real watchdog driver instead ;-)
>
>>>>>>> v2: * changed DT bindings from 'wdt-reset' to 'rza-wdt' * changed
>>>>>>> hard coded register values to defines * added msleep to while(1)
>>>>>>> loop
>>>>>>
>>>>>> Sure you can sleep here ?
>>>>>
>>>>> As per Geert's review:
>>>>>
>>>>> On Wednesday, February 15, 2017, Geert Uytterhoeven wrote:
>>>>>>>
>>>>>>> + +       /* Wait for WDT overflow */ +       while (1)
>>>>
>>>> +               ;
>>>>>>
>>>>>> This burns CPU, and thus power, albeit for a very short time.
>>>>>> Perhaps add an msleep() to the loop body?
>>>>>
>>>>> Note that you only have 7.7us before the restart occurs, so probabl=
y
>>>>> not much sleeping will be going on.
>>>>>
>>>> Let me rephrase my question. Is it guaranteed that you _can_ sleep i=
n
>>>> this
>>>> function, or in other words that it is guaranteed that interrupts ar=
e
>>>> enabled ?
>>>
>>> Hmm, I'm not sure if will actually 'sleep' or not. Regardless, interr=
upts
>>> or not,
>>> in 7.7us, the internal reset circuit is going to get triggered and th=
e
>>> whole system
>>> is going to reboot not matter what is going on.
>>>
>>
>> That isn't the point, really. You might get a WARN blob if msleep() is
>> called
>> with interrupts disabled, but of course you won't really see that beca=
use it
>> can
>> not be displayed in 7.7 us.
>
> If it's not 100% guaranteed that we cannot sleep, we should not use msl=
eep(),
> and stick to busy waiting.
> On ARM, we could also use wfi().
>
>>> I know Geert's suggestion was in reference to saving power...but in
>>> reality it's
>>> probably negligible when we are talking about 7.7us. The reboot is go=
ing
>>> to
>>> automatically shut off all the peripherals clocks as well.
>>
>> Maybe udelay(10); would have been more acceptable (and appropriate).
>
> Inside the while (1) loop? That's the same as a plain "while (1) ;" ;-)
> Or just udelay(10) and return, with the latter never happening if every=
thing
> goes well? Then the next restart handler will be tried, if available.
>

That is what I meant. Or use udelay(20) to be on the safe side.

Guenter

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
>
> In personal conversations with technical people, I call myself a hacker=
. But
> when I'm talking to journalists I just say "programmer" or something li=
ke that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
