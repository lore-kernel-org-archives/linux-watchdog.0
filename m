Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <55687D9A.8080409@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>
	<1432548193-19569-6-git-send-email-fu.wei@linaro.org>
	<55637A6D.3080403@roeck-us.net>
	<CADyBb7t_OC0FwoCeOr-umZhjTMxXZ65g7U8Ca+SUgmiWwjvm2w@mail.gmail.com>
	<55687D9A.8080409@roeck-us.net>
Date: Fri, 29 May 2015 23:05:34 +0800
Message-ID: <CADyBb7vcYoCMGMZ102yfHQtNQtAPdhKBSYw20naxMmjhqsf5-g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,



On 29 May 2015 at 22:54, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/29/2015 02:11 AM, Fu Wei wrote:
> [ ... ]
>
>>>> +
>>>> +       status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
>>>> +       if (status & SBSA_GWDT_WCS_WS1) {
>>>> +               dev_warn(dev, "System reset by WDT(WCS: %x, WCV:
>>>> %llx)\n",
>>>> +                        status, sbsa_gwdt_get_wcv(wdd));
>>>
>>>
>>>
>>> Does this message (specifically the WCS / WCV values) have any
>>> useful meaning for the user ?
>>
>>
>> I think so, according to SBSA spec:
>> If WS0 is asserted and a timeout refresh occurs then the following must
>> occur:
>>      If the system is compliant to SBSA level 2 or higher the compare
>> value must retain its current value. This means that the compare value
>> records the time that WS1 is asserted.
>>
>> So, I think WCV can log the time when system reset by WDT, that may
>> help user figure out the problem. but WCS can be delete I think.
>>
>
> How would that help ? It is just a number with no reference to anything.

This number is the time, when system reset by watchdog
WCV : the number of clock, from system boot  to system reset.
Is that worthy to be logged? any suggestion ? :-)

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
