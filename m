Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20150603182503.GD6460@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1433217907-928-1-git-send-email-fu.wei@linaro.org>
	<1433217907-928-6-git-send-email-fu.wei@linaro.org>
	<556F4489.6030206@codeaurora.org>
	<20150603182503.GD6460@roeck-us.net>
Date: Tue, 9 Jun 2015 00:10:42 +0800
Message-ID: <CADyBb7t04N1_AhtVdahijm4zFWc52XJ5NmM9Rn7OEpmiAPEzRQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
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
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,


On 4 June 2015 at 02:25, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jun 03, 2015 at 01:16:41PM -0500, Timur Tabi wrote:
>> On 06/01/2015 11:05 PM, fu.wei@linaro.org wrote:
>> >+    if (wdd->pretimeout)
>> >+            /* The pretimeout is valid, go panic */
>> >+            panic("SBSA Watchdog pre-timeout");
>>
>> The problem with this is that WS1 will still occur.  So a few seconds after
>> the panic() call, the hardware will reset.  There won't be any time to debug
>> or log anything.
>>
>
> In general the idea here would be to use a crashdump kernel, which,
> when loaded, would reset the watchdog before it fires. This kernel
> would then write a core dump to a specified location.
>
> If arm64 doesn't support a crashdump kernel, it might still be possible
> to log the backtrace somewhere (eg in nvram using pstore if that is
> supported via acpi or efi).

yes, you are right , thanks for explaining this.

>
> Is there reason to believe that this all won't work on arm64 ?

I don't think there is a reason.

>
> Thanks,
> Guenter



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
