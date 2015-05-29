Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <556889D9.5070707@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>
	<1432548193-19569-6-git-send-email-fu.wei@linaro.org>
	<5564A44A.5000606@codeaurora.org>
	<CADyBb7uQCPoerjyiGT3uUxXJk6XVTEkEuOdEB+-w6G-=RrdTmA@mail.gmail.com>
	<55686960.5010503@codeaurora.org>
	<CADyBb7tdoajU4crdjrjCf68_Lz=8KbxAX4+Gd_H15aNaimHXww@mail.gmail.com>
	<556889D9.5070707@codeaurora.org>
Date: Sat, 30 May 2015 01:53:06 +0800
Message-ID: <CADyBb7t4moXr_a9unRXDHZCcmbvjWui2ifJ6=eiv8Ce=FOWoYA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Timur

On 29 May 2015 at 23:46, Timur Tabi <timur@codeaurora.org> wrote:
> On 05/29/2015 09:32 AM, Fu Wei wrote:
>>
>> It is a SPI, every CPU can get it,
>> But maybe I miss something, but please let me know if other CPU can
>> not get the interrupt.
>
>
> There's only one watchdog device, so there's only one interrupt.  I don't
> know which CPU will get the interrupt, but the watchdog is not a per-CPU
> device.
>

OK, first of all, I know, there maybe only watchdog in the system, but
the Interrupter is SPI,
that means maybe some other device can also trigger the same
Interrupter or maybe(in SMP) other CPU will handle it.

If this interrupter is triggered, that means system has goes wrong,
who knows what is wrong ,
I have to make sure that  system get into that routine ,because of the
WS0, if not I won't do panic.

And in a interrupter routine , checking the Interrupter status
register is right way to do.


> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.



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
