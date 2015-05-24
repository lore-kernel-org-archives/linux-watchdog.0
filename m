Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5560DCB6.3090008@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DFCD4.3040701@codeaurora.org>
	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
	<5560D7AC.50009@codeaurora.org>
	<5560DCB6.3090008@roeck-us.net>
Date: Sun, 24 May 2015 18:15:06 +0800
Message-ID: <CADyBb7t7+aT=pF0we5umAGXJAJ0njU0zULFAZ-OHVpE0m=ueyg@mail.gmail.com>
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

On 24 May 2015 at 04:01, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/23/2015 12:40 PM, Timur Tabi wrote:
> [ ... ]
>>
>>
>> I use emergency_restart(), because the watchdog-api.txt documentation says
>> this:
>>
>> "If userspace fails (RAM error, kernel bug, whatever), the
>> notifications cease to occur, and the hardware watchdog will reset the
>> system (causing a reboot) after the timeout occurs."
>>
>> Maybe I'm reading this too literally, but to me this means that when the
>> timeout expires, the system has to reset immediately.
>>
>> However, maybe panic() is better, since it can do the same thing and more.
>>
>
> I have a specific requirement at work to have watchdog expiration
> (not this watchdog, this is different HW) result in a panic, specifically
> to enable crashdump support and thus post-mortem analysis.
>
> I had not thought about this use case myself, and I had always wondered
> why watchdog driver implementers would choose to call panic() after an
> interrupt or NMI. But we live and learn, so now I finally understand.
>
> In the pretimeout/timeout world, the pretimeout would (typically)
> result in a panic, and the timeout would result in a reset. So one
> would set the timer register to 10s for 10s pretimeout and 20s timeout.
>
> However, the pretimeout concept assumes that there are two timers
> which can be set independently. As you had pointed out earlier,
> and as the specification seems to confirm, that is not the case here.

Sorry, in Documentation/watchdog/watchdog-api.txt, I can not get the
info about " the pretimeout concept assumes that there are two timers
which can be set independently."
Could you kindly point out where is the assumption.

I thinks in kernel documentation,  that meams "one watchdog has two
timeout stages", maybe I miss something. Could you help me out?

> As such, I don't really understand why and how the pretimeout / timeout
> concept would add any value here and not just make things more
> complicated than necessary. Maybe I am just missing something.

If pretimeout concept assumes that there are two timers, I
misunderstand the "pretimeout", then I will delete the pretimeout
immediately.

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
