Return-Path: <prasannatsmkumar@gmail.com>
Return-path: <prasannatsmkumar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <71845801-7edf-9e49-8591-2a4caf11c45b@roeck-us.net>
References: <20171228162939.3928-2-paul@crapouillou.net> <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-4-paul@crapouillou.net> <CANc+2y4z-_++zUG8DUR6+zZYjc26AyJjU-yX+Lx37TSRXb4u0g@mail.gmail.com>
 <71845801-7edf-9e49-8591-2a4caf11c45b@roeck-us.net>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Sat, 20 Jan 2018 21:29:43 +0530
Message-ID: <CANc+2y6OhA8tFZq-toek5ed1Kt-Dv8Jy0+E4HFqQGg8WYGygSg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] watchdog: JZ4740: Drop module remove function
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-MIPS <linux-mips@linux-mips.org>,
	open list <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 20 January 2018 at 21:20, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/19/2018 11:41 PM, PrasannaKumar Muralidharan wrote:
>>
>> Hi Paul,
>>
>> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>>>
>>> When the watchdog was configured for nowayout, and after the
>>> userspace watchdog daemon closed the dev node without sending the
>>> magic character, unloading this module stopped the watchdog
>>> hardware, which was clearly a problem.
>>>
>>> Besides, unloading the module is not possible when the userspace
>>> watchdog daemon is running, so it's safe to assume that we don't
>>> need to stop the watchdog hardware in the jz4740_wdt_remove()
>>> function.
>>>
>>> For this reason, the jz4740_wdt_remove() function can then be
>>> dropped alltogether.
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>   drivers/watchdog/jz4740_wdt.c | 8 --------
>>>   1 file changed, 8 deletions(-)
>>>
>>>   v2: New patch in this series
>>>
>>> diff --git a/drivers/watchdog/jz4740_wdt.c
>>> b/drivers/watchdog/jz4740_wdt.c
>>> index fa7f49a3212c..02b9b8e946a2 100644
>>> --- a/drivers/watchdog/jz4740_wdt.c
>>> +++ b/drivers/watchdog/jz4740_wdt.c
>>> @@ -205,16 +205,8 @@ static int jz4740_wdt_probe(struct platform_device
>>> *pdev)
>>>          return 0;
>>>   }
>>>
>>> -static int jz4740_wdt_remove(struct platform_device *pdev)
>>> -{
>>> -       struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>>> -
>>> -       return jz4740_wdt_stop(&drvdata->wdt);
>>> -}
>>> -
>>>   static struct platform_driver jz4740_wdt_driver = {
>>>          .probe = jz4740_wdt_probe,
>>> -       .remove = jz4740_wdt_remove,
>>>          .driver = {
>>>                  .name = "jz4740-wdt",
>>>                  .of_match_table = of_match_ptr(jz4740_wdt_of_matches),
>>> --
>>> 2.11.0
>>>
>>>
>>
>> As ".remove" is removed and wdt is required for restarting the system
>> I am thinking that stop callback is also not required. If so does it
>> makes sense to remove the stop callback? I can submit a patch for the
>> same once this patch series goes in.
>>
> The remove function was removed because it would otherwise be an empty
> function. Since it is optional, it can and should be removed if it does not
> do anything. If the stop function is removed, it is no longer possible
> to stop the watchdog. Why would this make sense, and why would it make sense
> to drop the stop function if there is no remove function ?
>
> Guenter
>

I missed the fact that stopping is watchdog is possible. Sorry for the noise.

Thanks,
PrasannaKumar
