Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5561E7EA.5090702@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DFCD4.3040701@codeaurora.org>
	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
	<5560D7AC.50009@codeaurora.org>
	<5560DCB6.3090008@roeck-us.net>
	<CADyBb7t7+aT=pF0we5umAGXJAJ0njU0zULFAZ-OHVpE0m=ueyg@mail.gmail.com>
	<5561E7EA.5090702@codeaurora.org>
Date: Mon, 25 May 2015 00:04:34 +0800
Message-ID: <CADyBb7tYL7ATRKNAoRYTXo53LKdCiFZ2YDib4g0nZ8=YxTgO+A@mail.gmail.com>
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

I have said this before:

in the first timeout, just panic()  maybe not enough,  in [RFC]
version of my patchset, I offer some option as "preaction" to use, but
for simplifying the first version of driver, I have deleted them.
but at least, panic() is far more useful than a simple reset.  at
least, it can provide the context of the crashed system  to admin.

If you want to warn user space, that will make driver more
complicated, I don't think that is a good choose for a first version.
but we can find a way to improve this later

On 24 May 2015 at 23:02, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> If pretimeout concept assumes that there are two timers, I
>> misunderstand the "pretimeout", then I will delete the pretimeout
>> immediately.
>
>
> In my opinion, calling panic() on a pre-timeout is not useful, because
> that's really just a normal timeout.  If there were a way to "warn" user
> space that a timeout is about to occur, without a panic or reset, then that
> might be useful.  But as far as I can see, all you're doing is redefining
> the word "timeout".
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
