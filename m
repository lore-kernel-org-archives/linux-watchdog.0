Return-path: <ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
In-Reply-To: <5593F10D.5000507@roeck-us.net>
References: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1435343072-8753-2-git-send-email-ariel@vanguardiasur.com.ar>
	<20150626190700.GC23078@roeck-us.net>
	<55903943.10309@vanguardiasur.com.ar>
	<5590CDF6.7000103@roeck-us.net>
	<5593CF3F.9040206@santafe.gov.ar>
	<5593D6CC.10201@vanguardiasur.com.ar>
	<5593F10D.5000507@roeck-us.net>
Date: Wed, 1 Jul 2015 12:22:12 -0300
Message-ID: <CAAEAJfCz23VKA49CJN51KwF8WFsjYuaCiHFcXfyWxonK-Qty6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: NXP LPC18XX Windowed Watchdog Timer Driver
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Ariel D'Alessandro" <ariel@vanguardiasur.com.ar>, linux-watchdog@vger.kernel.org,
	wim@iguana.be, Joachim Eastwood <manabian@gmail.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

First of all, thanks a lot for your feedback.

On 1 July 2015 at 10:54, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/01/2015 05:02 AM, Ariel D'Alessandro wrote:
>>
>> (Sorry, I sent the last mail with an incorrect mail account)
>>
>> El 01/07/15 a las 08:30, adalessandro escibi=C3=B3:
>>>
>>>
>>> El 29/06/15 a las 01:47, Guenter Roeck escibi=C3=B3:
>>>>
>>>> On 06/28/2015 11:13 AM, Ariel D'Alessandro wrote:
>>>>>>>
>>>>>>> +/* Timeout values in seconds */
>>>>>>> +#define LPC_WDT_DEF_TIMEOUT        1
>>>>>>> +
>>>>>>
>>>>>>
>>>>>> One second ? This is highly unusual. 30 or 60 seconds is more common=
,
>>>>>> and one second would be very challenging for user space.
>>>>>>
>>>>>> Any special reason for using such a tight default ?
>>>>>
>>>>>
>>>>> Considering that LPC18xx Watchdog has a fixed divide-by-4 clock
>>>>> pre-scaler and a 24-bit counter and that Watchdog clock runs at a fix=
ed
>>>>> frequency of 12MHz, timeout range goes from 1 to 5 seconds.
>>>>>
>>>>> I think you're right, 1 sec is very challenging, so it's 5 secs then.
>>>>>
>>>> Ultimately you might want to consider a soft timer as backup to the
>>>> system
>>>> timeout. But that can be done later if/when needed.
>>>
>>>
>>> I understand your point, but just to be sure, what do mean by soft time=
r?
>>>
>
> A kernel function which pings the watchdog periodically even if the
> watchdog is open.
>
> Example: Timeout is set to 30 seconds. Since the HW watchdog times out
> earlier than that, it needs to be pinged regularly (eg every 2.5 seconds)=
.
> The kernel does that with a timer unless user space does not ping the
> watchdog within the configured interval of 30 seconds.
>

Do we really need this? It sounds like bloat to me. Considering this watchd=
og
controller is included in cortex-M MCUs, you wouldn't expect the
scheduler to be under so much pressure.

I realize that 1-5 seconds is challenging for userspace, but having a soft =
timer
in the kernel side sounds like making the system heavier instead of lighter=
.

Not sure I'm making sense here, but I would think twice before adding bloat=
.

Maybe Ariel can submit his v2 (with basic watchdog support, which BTW also
provides a reset handler) now and we can pospone this discussion.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
