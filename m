Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5560C984.10108@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555F4236.7040206@linaro.org>
	<4095167.UOriXdSu53@wuerfel>
	<556097D5.9050103@codeaurora.org>
	<CADyBb7svbV6QdhzCsa9DiBLfyNpAJHkgm73VSKCieJioPwWHsw@mail.gmail.com>
	<5560C984.10108@codeaurora.org>
Date: Sun, 24 May 2015 03:14:25 +0800
Message-ID: <CADyBb7u0ixabfJMqS0yFcYjTaOjz3NS+W4id9v00KyBnP08OpA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Timur

On 24 May 2015 at 02:40, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> I wonder why you are so sure "that SOC won't have an SBSA watchdog in
>> it."  any documentation ?
>> Sorry, I am not a chip design engineer, I can't see why 32-bit ARM
>> won't have an SBSA watchdog in it.
>
>
> Because there's no market for it.  I'm not talking about what's
> theoretically possible.  I'm only talking about what makes sense and what
> will actually happen.  And I'm quite certain that we will never see an
> actual 32-bit ARM SOC with an SBSA watchdog device in it.

Why are you quite certain? any info you can kindly share here?

>
> Therefore, it makes no sense to complicated the code so that we can support
> an SOC that will never exist.

yes, that is a good reason!

>
> So can we PLEASE stop talking about 32-bit ARM support?

why? we are just trying to figure out:
Do we need to add ARM in "depends on" for SBSA watchdog driver?

If some one suggests this, we need to figure out.

>
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, hosted by The Linux Foundation.



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
