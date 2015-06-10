Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34499 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbbFJRyX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jun 2015 13:54:23 -0400
Received: by oigz2 with SMTP id z2so37572791oig.1
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2015 10:54:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADyBb7tSkdRc0GHbX_vAdDAeFGVS=CFCdC_jMCm5LYmg9m1Qow@mail.gmail.com>
References: <=fu.wei@linaro.org>
	<1433217907-928-1-git-send-email-fu.wei@linaro.org>
	<1433217907-928-6-git-send-email-fu.wei@linaro.org>
	<556DCC95.806@codeaurora.org>
	<CADyBb7sXiMNtrH+Eu1Qj00TPNLMMr5cCTPObzFmKnHLsbWH79Q@mail.gmail.com>
	<556DE2D5.3090906@roeck-us.net>
	<CADyBb7uT=gFJkK8s-QF1n4Z+Zov9Lurp1nvBO-C-qszTqbMYXQ@mail.gmail.com>
	<5575DE48.8010308@roeck-us.net>
	<CADyBb7sYPnvDVEJYVQm65B1JV=yvq10+ezs2x3f8F=TJCZ+OJA@mail.gmail.com>
	<55766D74.2060401@roeck-us.net>
	<CADyBb7vR-jP6ZjzMSnprrSXbNayk8umx+cXV3TsGypfhZcCwTw@mail.gmail.com>
	<55769E0E.8060801@roeck-us.net>
	<CADyBb7skpSZ=3_ByW-RHM99=nbs7Z5xXFXtsKzkxOXAGjxF=3Q@mail.gmail.com>
	<557712CF.8010802@roeck-us.net>
	<5577147B.2030900@codeaurora.org>
	<5577180E.4070804@roeck-us.net>
	<CADyBb7sVd5nLwb3eHRPiNt-WTynfaJonOyuE_bD694dayyvevA@mail.gmail.com>
	<CADyBb7tSkdRc0GHbX_vAdDAeFGVS=CFCdC_jMCm5LYmg9m1Qow@mail.gmail.com>
Date: Thu, 11 Jun 2015 01:54:22 +0800
Message-ID: <CADyBb7tMLjcco76GVu9O+GiDOrH4t2UirgxzAGb_jr253FV6RA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

On 10 June 2015 at 23:38, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Guenter,
>
>
> On 10 June 2015 at 11:41, Fu Wei <fu.wei@linaro.org> wrote:
>> Hi Guenter,
>>
>> On 10 June 2015 at 00:45, Guenter Roeck <linux@roeck-us.net> wrote:
>>> On 06/09/2015 09:29 AM, Timur Tabi wrote:
>>>>
>>>> On 06/09/2015 11:22 AM, Guenter Roeck wrote:
>>>>>
>>>>>
>>>>>
>>>>> but I see your point. Essentially, the specification is broken
>>>>> for all practical purposes, since, as you point out, enabling
>>>>> the watchdog overwrites and explicitly sets WCV. Effectively
>>>>> this means that just using WCV to program the timeout period
>>>>> is not really possible.
>>>>>
>>>>> I am not really sure how to address this. We can either only use WOR,
>>>>> and forget about pretimeout, or we can enforce a minimum pretimeout.
>>>>> In the latter case, we'll have to write WCV after writing WOR.
>>>>
>>>>
>>>> In talking with our hardware engineers, using WCV to program the timeout
>>>> period is not a valid operation.  This is why I keep arguing against the
>>>> pre-timeout feature, and I don't agree that servers should always use
>>>> pre-timeout.
>>>>
>>>
>>> Not sure if "not valid" is correct - after all, it is mentioned in the
>>> specification. However, it is at the very least fragile.
>>
>> I think we should focus on SBSA spec, but not a specific chip design,
>> because this is SBSA watchdog, not a driver for an IP core from a
>> specific chip vendor.
>> this operation is mentioned in the spec,
>> and I have tested my driver on Foundation model(from ARM) and a real hardware.
>>
>>>
>>> I tend to agree that we should just forget about pretimeout and
>>> use your original approach, where the timeout value is used
>>> to program WOR. Everything else is really just asking for trouble.
>>
>> I don't mind if we give up pretimeout, The reason I use pretimeout is:
>> this concept matches the function of two stage timeouts.
>>
>> but, If we give up pretimeout, could you give me a suggestion:
>>
>> How to config the two stage timeouts
>> (1)from enabling watchdog to WS0
>> (2)the time from WS1 to WS0
>>
>> If we only have one timeout parameter,  How to config the two stage timeouts?
>> Any suggestion ?
>
> I have another thought for this, please allow me to sent anther
> patchset in a day. see if you like it.

I have sent a non-pretimeout version patchset, please let me know if
you like the non-pretimeout version more.

Great thanks for your time. :-)

>
>>
>> If we make the first stage timeout is timeout/2,  this violates the
>> definition of timeout.
>> I don't think users expect interrupt, panic or reboot at timeout/2.
>>
>> And WS1  definitely isn't a backup of WS0.
>>
>>>
>>> Guenter
>>>
>>
>>
>>
>> --
>> Best regards,
>>
>> Fu Wei
>> Software Engineer
>> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
>> Ph: +86 21 61221326(direct)
>> Ph: +86 186 2020 4684 (mobile)
>> Room 1512, Regus One Corporate Avenue,Level 15,
>> One Corporate Avenue,222 Hubin Road,Huangpu District,
>> Shanghai,China 200021
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
> Ph: +86 21 61221326(direct)
> Ph: +86 186 2020 4684 (mobile)
> Room 1512, Regus One Corporate Avenue,Level 15,
> One Corporate Avenue,222 Hubin Road,Huangpu District,
> Shanghai,China 200021



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
