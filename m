Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5560E6AE.1000109@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DFCD4.3040701@codeaurora.org>
	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
	<5560D7AC.50009@codeaurora.org>
	<5560DCB6.3090008@roeck-us.net>
	<5560E294.6040903@codeaurora.org>
	<5560E6AE.1000109@roeck-us.net>
Date: Sun, 24 May 2015 18:50:50 +0800
Message-ID: <CADyBb7tq4CoP+KtZfDZLzSwM-baL1S7hP-GCoCsW73V+Df2i+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 24 May 2015 at 04:44, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/23/2015 01:27 PM, Timur Tabi wrote:
>>
>> Guenter Roeck wrote:
>>>
>>>
>>> However, the pretimeout concept assumes that there are two timers
>>> which can be set independently. As you had pointed out earlier,
>>> and as the specification seems to confirm, that is not the case here.
>>> As such, I don't really understand why and how the pretimeout / timeout
>>> concept would add any value here and not just make things more
>>> complicated than necessary. Maybe I am just missing something.
>>
>>
>> It might be possible to load a new value into the WOR register after the
>> WS0 interrupt occurs.  That is, in the interrupt handler, we can do
>> something like this:
>>
>>      if (status & SBSA_GWDT_WCS_WS0)
>>          // write new WOR value,
>>          // then ping watchdog so that it's loaded
>>
>> I'm not convinced that it's worth it, however.  It would require
>> interrupts to still be working when WS0 times out, which somewhat defeats
>> the purpose of a watchdog.
>>
>
> If I understand the specification correctly, reloading the register
> would result in another WS0, not in WS1. That isn't really what we
> would want to happen.

Yes, you are 100% correct.
In SBSA:
---------------
An explicit watchdog refresh occurs when one of a number of different
events occur:
(1) The Watchdog Refresh Register is written.
(2) The Watchdog Offset Register is written.
(3) The Watchdog Control and Status register is written.
In the case of an explicit refresh the Watchdog Signals are cleared.
---------------
So,  for the second timeout,  we can only use WOR.(but maybe we can
write WCV in the WS0 routine to make the second timeout longer, if we
really need a long time for panic)
If we write WOR , that will clean WCS, then the system go back to
first timeout stage.

But for the first timeout, we can use WOR (that means the two timeout
stages will be the same,  in another world, WS0==WS1*2 )
or we can write WCV directly.

And writing WCV will not trigger an explicit watchdog refresh, that is
what I am doing to set up  pretimeout.

>
> Reloading the register would normally be done in the crashdump kernel,
> if it is loaded, to give it time to actually take the crashdump.
> But that is post-restart, not pre-restart.
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
