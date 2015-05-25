Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <55620EA1.3070605@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DFCD4.3040701@codeaurora.org>
	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
	<5560D7AC.50009@codeaurora.org>
	<5560DCB6.3090008@roeck-us.net>
	<CADyBb7t7+aT=pF0we5umAGXJAJ0njU0zULFAZ-OHVpE0m=ueyg@mail.gmail.com>
	<5561E7EA.5090702@codeaurora.org>
	<CADyBb7tYL7ATRKNAoRYTXo53LKdCiFZ2YDib4g0nZ8=YxTgO+A@mail.gmail.com>
	<5561F8A8.4080607@codeaurora.org>
	<5561FC70.5080802@roeck-us.net>
	<5561FFF0.5090108@codeaurora.org>
	<CADyBb7snhcR43KT_xrFipBH3PBNBfj39-hE-mSjJ3vMb7Ehp+A@mail.gmail.com>
	<55620808.4030605@codeaurora.org>
	<55620B2F.5000708@roeck-us.net>
	<55620EA1.3070605@codeaurora.org>
Date: Mon, 25 May 2015 10:03:05 +0800
Message-ID: <CADyBb7tSJBzrwu8RC4rhNe95PkrS=iQMV6KcG8=A3ao+11XsWg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
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


On 25 May 2015 at 01:47, Timur Tabi <timur@codeaurora.org> wrote:
> Guenter Roeck wrote:
>>
>>
>> The pseudo-code in the specification suggests that if WCV is configured,
>>      WS0 = WCV
>>      WS1 = WCV + WOR
>>
>> Assuming that the implementation follows the pseudo-code in the
>> specification,
>> we would have separately programmable values. Since the pretimeout (per
>> ABI)
>> is the difference in seconds to the timeout, and not an absolute value,
>> we would have to program the registers as follows.
>>
>>      WCV = timeout - pretimeout;
>>      WOR = pretimeout;
>>
>> Does this make sense ?

And actually all the patchset  I sent to upstream are all follow this
design, and have been test on Foundation model and Seattle B0

>
>
> Yes, thank you.  I will test this on my hardware.
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
