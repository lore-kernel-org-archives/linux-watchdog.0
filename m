Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5568E3E8.7070008@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>
	<1432548193-19569-6-git-send-email-fu.wei@linaro.org>
	<5564A44A.5000606@codeaurora.org>
	<CADyBb7uQCPoerjyiGT3uUxXJk6XVTEkEuOdEB+-w6G-=RrdTmA@mail.gmail.com>
	<55686960.5010503@codeaurora.org>
	<CADyBb7tdoajU4crdjrjCf68_Lz=8KbxAX4+Gd_H15aNaimHXww@mail.gmail.com>
	<556889D9.5070707@codeaurora.org>
	<5568E3E8.7070008@roeck-us.net>
Date: Mon, 1 Jun 2015 15:50:09 +0800
Message-ID: <CADyBb7tQ4NaX5KnfNjoL3YsjHqctW2W4J_-qbrfhvonJ9KP0MQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] Watchdog: introduce ARM SBSA watchdog driver
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
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter , Timur

On 30 May 2015 at 06:10, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/29/2015 08:46 AM, Timur Tabi wrote:
>>
>> On 05/29/2015 09:32 AM, Fu Wei wrote:
>>>
>>> It is a SPI, every CPU can get it,
>>> But maybe I miss something, but please let me know if other CPU can
>>> not get the interrupt.
>>
>>
>> There's only one watchdog device, so there's only one interrupt.  I don't
>> know which CPU will get the interrupt, but the watchdog is not a per-CPU
>> device.
>>
> Plus, that one interrupt is not shared, and the driver returns
> IRQ_HANDLED even if the bit is not set. So _something_ is definitely
> wrong. Either the interrupt is shared, then it needs to be requested
> as shared and the handler should only return IRQ_HANDLED if it actually
> handles the interrupt. Or it is not shared and the handler should always
> handle it.

I have thought about this again, For now, I did not find any reason to
keep that "if (status & SBSA_GWDT_WCS_WS0)"

So you are right, I should delete it.

and for IRQF_TIMER,  I will delete it.

Thanks for your correction.

>
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
