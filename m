Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <557D8862.8020805@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1433958452-23721-1-git-send-email-fu.wei@linaro.org>
	<1433958452-23721-4-git-send-email-fu.wei@linaro.org>
	<557B470B.9030908@codeaurora.org>
	<CADyBb7seDgmQYxjsxCo_thPr_w847oy7d0AEiL8w9T_ZCF9+BQ@mail.gmail.com>
	<557D8862.8020805@roeck-us.net>
Date: Mon, 15 Jun 2015 19:00:24 +0800
Message-ID: <CADyBb7veJWc84hK1=fwhvDec0dv-QPMh0rEHyk49AHSRe3Uawg@mail.gmail.com>
Subject: Re: [PATCH non-pretimeout 3/7] ARM64: add SBSA Generic Watchdog
 device node in amd-seattle-soc.dtsi
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 14 June 2015 at 21:57, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/14/2015 03:05 AM, Fu Wei wrote:
>>
>> On 13 June 2015 at 04:54, Timur Tabi <timur@codeaurora.org> wrote:
>>>
>>> On 06/10/2015 12:47 PM, fu.wei@linaro.org wrote:
>>>>
>>>>
>>>> +                       reg = <0x0 0xe0bb0000 0 0x10000>,
>>>> +                               <0x0 0xe0bc0000 0 0x10000>;
>>>
>>>
>>>
>>> I think the sizes are wrong.  They should be 0x1000 instead of 0x10000.
>>
>>
>> This has been proved by test, it works well on Seattle
>> Foundation model has same value. So I don't think it is wrong
>>
>> otherwise someone has the data sheet of Seattle B0, and it shows that is
>> wrong.
>>
>
> If only 0x1000 is used, why would you have to reserve 0x10000 ?
> You never access any higher addresses, so no matter what the datasheet
> says, 0x1000 should be sufficient. What matters is what the driver uses.

the reason for using 0x10000 before is :
(1)in <ARM v8-A Foundation Platform User Guide(Version: 9.1)> page 20
0x00_2A44_0000 0x00_2A44_FFFF - EL2 Generic Watchdog Control 64KB S/NS
0x00_2A45_0000 0x00_2A45_FFFF - EL2 Generic Watchdog Refresh 64KB S/NS
(2)It is also confirmed by Suravee, in Seattle,  the size is 64KB also.
(3) these configuration has passed the test in Foundation model and Seattle B0.

Not sure the reason, maybe because of the 64KB page size.

But, yes, in SBSA, the device only has 4KB register area, and the
driver only need to use 4KB.

So you are right,  "What matters is what the driver uses." , so will use 0x1000.
I think there is not problem, because ACPI uses this size.


>
> Guenter
>
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
