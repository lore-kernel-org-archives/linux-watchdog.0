Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5561DAF3.8020805@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555F4236.7040206@linaro.org>
	<4095167.UOriXdSu53@wuerfel>
	<556097D5.9050103@codeaurora.org>
	<CADyBb7svbV6QdhzCsa9DiBLfyNpAJHkgm73VSKCieJioPwWHsw@mail.gmail.com>
	<5560C85B.8040100@roeck-us.net>
	<5560C8D3.40708@codeaurora.org>
	<5560DA3F.3070707@roeck-us.net>
	<CADyBb7sW8GTJmRR2ysUAYtZ=mkSCFZBzXuor=puLck0Q983NMw@mail.gmail.com>
	<5561DAF3.8020805@roeck-us.net>
Date: Sun, 24 May 2015 23:37:00 +0800
Message-ID: <CADyBb7sROUmDE6N=7w=CQyUo-AiG_dBcTr=xB4R7+=pPFWh85A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Great thanks for your time,
you provide your feedback in your weekend, I am so appreciate that.

my feedback inline below

On 24 May 2015 at 22:06, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/24/2015 02:58 AM, Fu Wei wrote:
>>
>> Hi Guenter,
>>
>> Great thanks for your suggestion and review,
>> I have some questions below , would you please help me out?
>>
>> On 24 May 2015 at 03:51, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 05/23/2015 11:37 AM, Timur Tabi wrote:
>>>>
>>>>
>>>> Guenter Roeck wrote:
>>>>>
>>>>>
>>>>> I think it is quite unfortunate that the specification is not public.
>>>>> We have heard many statements about what is in the spec or not.
>>>>
>>>>
>>>>
>>>> All you need to do is go to
>>>>
>>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0029b/index.html,
>>>> get a free ARM account, and download the spec.
>>>>
>>> That helps - thanks a lot!
>>>
>>> Folks, please correct me if my understanding of the specification
>>> is wrong.
>>>
>>> 1) Pretimeout
>>>
>>> The document suggests that
>>>          WS1 = WS0 * 2
>>
>>
>> Are you saying: the first timeout == the second timeout
>>
>> |-------------WS0
>>                    |-------------WS1
>>
>> Sorry, could you let me know where is that suggestion??
>> I have checked the SBSA again, but I can not find it.
>> Maybe I really miss this part.
>>
>
> The document states:
>
> "If both watchdog signals are deasserted and a timeout refresh occurs then
> WS0 is asserted.
>  If WS0 is asserted and a timeout refresh occurs then WS1 is asserted."

yes, this just describe how the WS0/WS1 are deasserted or asserted.
but it doesn't suggest WS1 = WS0 * 2.
Of course,  If we only config  WOR in the driver, we get WS1 = WS0 * 2.

If we delete pretimeout concept from this driver
Then what is the timeout, |-------------WS0  or
|-------------WS0-------------WS1 ?

If we only config WOR ,  the timeout for two stage will be the same
I think  the first stage should be called timeout, the user get a
panic in timeout(the first stage)
Then we can tell user, in this driver, if first timeout is triggered
but fail, we can wait for the same time for reboot.

but the second timeout is still like a pretimeout, why not just use it ?

IMO,  the key point of SBSA watchdog is two signal, and the first one
is interrupt, the second one maybe a hardware reset OR a interrupt
if we drop "pretimeout", the watchdog just acts like a common watchdog
(just like SP805)

Now we assume that the second signal is a reset, but according to
SBSA, that maybe a  interrupt. If that happens on a Soc(that will
happen), how to deal with that?
what is the timeout between WS0 and WS1?

If the two signals are all connect to interrupts, I think we still
need a pretimeout. why not use pretimeout right now. that will be more
easy to maintain the driver.

>
> There is no mention that programming both WOR and WCV would or even
> could result in different timeouts for the two watchdog signals.

yes, they don't mention it.
using WCV to config the first stage and  WOR for the second stage  is
my idea to solve the two stage timeouts.
Because by this way, we can make the first stage longer(has not that
10s(@400MHz) limit), and we can provide the full feature of SBSA
watchdog.
as I have mentioned above, If the two signals are all connect to
interrupts, we don't need to tell user : the two stage timeout must be
the same and 10s(@400MHz) limit,

>
>>> is in fact correct. In essence, there is just one counter,
>>> not two. This means that a separate pretimeout does not really
>>> make sense, since in practice the timeout would always be
>>> twice the pretimeout,
>>
>>
>> Yes, you are right, if we only use "WOR", then the first timeout ==
>> the second timeout
>>
>>> and changing just one without affecting
>>> the other is not really possible.
>>
>>
>> although there is only one counter, and it is 32 bits wide.
>> In SBSA,  we can see this:
>> -------
>> Note: the watchdog offset register is 32 bits wide. This gives a
>> maximum watch period of around 10s at a system counter frequency of
>> 400MHz.
>> If a larger watch period is required then the compare value can be
>> programmed directly into the compare value register.
>> -------
>> So for the first timeout, we can set the compare value register(WCV).
>> Then the two timeouts are different. and the first timeout has not
>> 10s(@400MHz) limit.
>> just the the second timeout must use "WOR".
>>
>
> That is not how I read the specification. It only talks about
> "timeout refresh". There is no indication that using both registers
> would have the impact you describe.
>
> Since there is no mention of different WS0 and WS1 timeout periods
> in the specification, I am concerned that even _if_ a specific
> implementation supports such different timeouts, it would be
> implementation specific.

yes, you are right, they don't mention,  but they can be different,
that is the way I use.
I just put limit on user , say: the two timeout must be the same. I
hope my driver can provide the full feature of hardware.
but they make driver a little more complicated than the one which
simply config WOR.
I have to say , another one make SBSA watchdog become a watchdog.

>
> Maybe you and/or Timur can test this on the real systems you
> have access to. It should be quite straightforward to test -
> have the interrupt handler only print a message, program some
> values into the watchdog, and see when WS0 and WS1 occur.

yes,  the first version of my driver has printed the timeleft out,  I
can have different timeouts and pretimeout

>
> Thanks,
> Guenter
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
