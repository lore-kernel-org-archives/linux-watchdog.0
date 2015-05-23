Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <556097D5.9050103@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555F4236.7040206@linaro.org>
	<4095167.UOriXdSu53@wuerfel>
	<556097D5.9050103@codeaurora.org>
Date: Sun, 24 May 2015 01:26:06 +0800
Message-ID: <CADyBb7svbV6QdhzCsa9DiBLfyNpAJHkgm73VSKCieJioPwWHsw@mail.gmail.com>
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

Hi Timur,



On 23 May 2015 at 23:08, Timur Tabi <timur@codeaurora.org> wrote:
> Arnd Bergmann wrote:
>>
>> I think it's a reasonable assumption that someone will sooner or later
>> put that hardware into an ARM32 machine,
>
>
> I'm going to have to disagree.  If they haven't done it by now, I can't
> imagine any ARM SOC vendor creating a 32-bit ARM SOC with an SBSA watchdog
> in it.  I can imagine a vendor trying to repurpose an existing 32-bit ARM
> SOC for the server market, but that SOC won't have an SBSA watchdog in it.

I will agree with you on this, ONLY IF a people can represent ARM and
all chip vendors say publicly:
" We never ever use SBSA watchdog IP core on ARM32!" or " SBSA
watchdog IP core is imcompatible with ARM32"

Although the SBSA is all about ARMv8, but in "5 APPENDIX A: GENERIC
WATCHDOG", it doesn't say "this is only for ARMv8".
and its clock source "system counter" and arm_arch_timer have been in
ARM32 Soc for years,
and all the regs in SBSA watchdog is 32bit. I can't see why we can not
do that, unless I miss something.

I wonder why you are so sure "that SOC won't have an SBSA watchdog in
it."  any documentation ?
Sorry, I am not a chip design engineer, I can't see why 32-bit ARM
won't have an SBSA watchdog in it.

>
>> or run a 32-bit kernel on
>>
>> a chip that has it.
>
>
> That might happen, but I would be very surprised, and I would need to be
> convinced that it's useful.
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
