Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <55620808.4030605@codeaurora.org>
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
Date: Mon, 25 May 2015 01:23:31 +0800
Message-ID: <CADyBb7tYq9LMbUvMPD=7wv8tUhd4wEHsQZSVLc=DxOZu-5qcpQ@mail.gmail.com>
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

Hi Timur,

On 25 May 2015 at 01:19, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> I don't know why you want to do this tricky way.  you can always
>> register the interrupt handler,
>> if pre-timeout is 0, system will just trigger WS1 right after WS0
>
>
> But that only works if the pre-timeout and timeout can be programmed to
> separate values.  And as Guenter says, the SBSA may not guarantee that.

In my driver patch, the first stage, I am using WCV, for the second
stage I am using WOR,
that have been tested on real hardware.

would you please read the pseudocode in Page 23 of SBSA 2.3

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
