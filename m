Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52429 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbFHS0c (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 8 Jun 2015 14:26:32 -0400
Message-ID: <5575DE48.8010308@roeck-us.net>
Date: Mon, 08 Jun 2015 11:26:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>
CC: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1433217907-928-1-git-send-email-fu.wei@linaro.org>	<1433217907-928-6-git-send-email-fu.wei@linaro.org>	<556DCC95.806@codeaurora.org>	<CADyBb7sXiMNtrH+Eu1Qj00TPNLMMr5cCTPObzFmKnHLsbWH79Q@mail.gmail.com>	<556DE2D5.3090906@roeck-us.net> <CADyBb7uT=gFJkK8s-QF1n4Z+Zov9Lurp1nvBO-C-qszTqbMYXQ@mail.gmail.com>
In-Reply-To: <CADyBb7uT=gFJkK8s-QF1n4Z+Zov9Lurp1nvBO-C-qszTqbMYXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/08/2015 09:05 AM, Fu Wei wrote:
> Hi Gurnter
>
> On 3 June 2015 at 01:07, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 06/02/2015 09:55 AM, Fu Wei wrote:
>>>
>>> Hi Timur,
>>>
>>> Thanks , feedback inline
>>>
>>> On 2 June 2015 at 23:32, Timur Tabi <timur@codeaurora.org> wrote:
>>>>
>>>> On 06/01/2015 11:05 PM, fu.wei@linaro.org wrote:
>>>>
>>>>> +/*
>>>>> + * help functions for accessing 32bit registers of SBSA Generic
>>>>> Watchdog
>>>>> + */
>>>>> +static void sbsa_gwdt_cf_write(unsigned int reg, u32 val,
>>>>> +                              struct watchdog_device *wdd)
>>>>> +{
>>>>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>>>> +
>>>>> +       writel_relaxed(val, gwdt->control_base + reg);
>>>>> +}
>>>>> +
>>>>> +static void sbsa_gwdt_rf_write(unsigned int reg, u32 val,
>>>>> +                              struct watchdog_device *wdd)
>>>>> +{
>>>>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>>>> +
>>>>> +       writel_relaxed(val, gwdt->refresh_base + reg);
>>>>> +}
>>>>> +
>>>>> +static u32 sbsa_gwdt_cf_read(unsigned int reg, struct watchdog_device
>>>>> *wdd)
>>>>> +{
>>>>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>>>> +
>>>>> +       return readl_relaxed(gwdt->control_base + reg);
>>>>> +}
>>>>
>>>>
>>>>
>>>> I still think you should get rid of these functions and just call
>>>> readl_relaxed() and writel_relaxed() every time, but I won't complain
>>>> again
>>>> if you keep them.
>>>
>>>
>>> yes, that make sense, and will reduce the size of code, and I think
>>> the code's readability will be OK too.
>>> will try in my next patch,
>>>
>>>>
>>>>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>>>>> +{
>>>>> +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>>>>> +       struct watchdog_device *wdd = &gwdt->wdd;
>>>>> +
>>>>> +       if (wdd->pretimeout)
>>>>> +               /* The pretimeout is valid, go panic */
>>>>> +               panic("SBSA Watchdog pre-timeout");
>>>>> +       else
>>>>> +               /* We don't use pretimeout, trigger WS1 now*/
>>>>> +               sbsa_gwdt_set_wcv(wdd, 0);
>>>>
>>>>
>>>>
>>>> I don't like this.
>>>
>>>
>>> If so, what is your idea ,if pretimeout == 0?
>>>
>>> the reason of using WCV as (timout - pretimeout): it can provide the
>>> longer timeout period,
>>> (1)If we use WOR, it can only provide 10s @ 400MHz(max).
>>> as Guenter said earlier, the default timer out for most watchdog will
>>> be 30s, so I think 10s limit will be a little short
>>> (2)we can always program WCV just like ping.
>>> (3)if a timeout arrives, WOR will be use, so use it as pretimeout, but
>>> we still can make this pretimeout longer by programming WCV(I don't
>>> think it's necessary)
>>>
>>>
>>>> The triggering of the hardware reset should never depend
>>>> on an interrupt being handled properly.
>>>
>>>
>>> if this fail, system reset in 1S, because WOR == (1s)
>>>
>> So ?
>
> Even the interrupt routine isn't triggered,  (WOR + system counter) --> WCV,
> then, sy system reset in 1S.
>
> the hardware reset doesn't depend on an interrupt.
>
>
>>
>>>> You should always program WCV
>>>> correctly in advance.  This is especially true since pre-timeout will
>>>> probably rarely be used.
>>>
>>>
>>> always programming WCV is doable.  But I absolutely can not agree "
>>> pre-timeout will probably rarely be used"
>>> If so, SBSA watchdog is just a normal watchdog,  This use case just
>>> makes this HW useless.
>>> If so, go to use SP805.
>>> you still don't see the importance of this warning and pretimeout to a
>>> real server.
>>>
>>
>> If pretimeout isn't used, why not just set WCV = timeout, WOR = 0 ?
>
> Because if WOR = 0 , according to SBSA,  once you want to enable watchdog,
> (0 + system counter) --> WCV , then , WS0 and WS1 will be triggered immediately.
> we have not a chance(a time slot) to update WCV.
>

I would have thought that this is exactly what we want if pretimeout is not used.
What am I missing here ?

Guenter

