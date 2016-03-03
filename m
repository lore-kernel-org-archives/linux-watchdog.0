Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54133 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbcCCEuu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2016 23:50:50 -0500
Subject: Re: [RFC PATCH] watchdog: s3c2410_wdt: Add max and min timeout values
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-kernel@vger.kernel.org
References: <1456850717-3670-1-git-send-email-javier@osg.samsung.com>
 <56D62979.5040009@samsung.com> <56D7233B.50907@osg.samsung.com>
 <56D7838D.4060602@samsung.com> <56D79E1D.3030302@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D7C2A5.1050304@roeck-us.net>
Date: Wed, 2 Mar 2016 20:50:45 -0800
MIME-Version: 1.0
In-Reply-To: <56D79E1D.3030302@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/02/2016 06:14 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
>
> On 03/02/2016 09:21 PM, Krzysztof Kozlowski wrote:
>> On 03.03.2016 02:30, Javier Martinez Canillas wrote:
>
> [snip]
>
>>>>>
>>>>> +    wdt->wdt_device.min_timeout = 1;
>>>>> +    wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt->clock);
>>>>
>>>> Can the frequency of clock change? E.g. with devfreq? No problem if it
>>>> goes lower but if it gets higher than initial, then the problem will
>>>> appear again.
>>>>
>
> I think both cases are problematic since low scaling will meant that the
> watchdog will support a bigger timeout than what was set as maximum (this
> will be a regression) and going up will mean that the maximum timeout is
> bigger than what the watchdog supports (the same issue without this patch).
>
>>>
>>> That's a very good question. As Guenter said we will be in deep troubles
>>> if that ever happens since the driver doesn't take that into account.
>>>
>>> The .set_timeout handler just sets the counter according to the current
>>> frequency and that's never updated, unless a new timeout is set of course.
>>>
>>> So in other words, I just made the same assumptions that the driver is
>>> currently doing.
>>
>> Not entirely. Change of clock frequency will affect currently set
>> timeout. But the next timeout will be using new frequency.
>>
>> However you are setting the maximum timeout once. It will never change.
>
> Of course. I meant that the driver makes the assumption that the clock
> frequency never changes, no that the symptoms will be the same in both
> cases (maximum timeout vs current timeout).
>
>>
>>> At least the Exynos SoCs manual don't mention frequency
>>> scaling for the watchdog timer source clock and AFAICT none of the CLK_WDT
>>> parents scale their frequencies but I don't know if that's true for all
>>> the machines using this driver (i.e: out-of-tree boards).
>>
>> I looked at Exynos4 family because the devfreq was tested there. The WDT
>> clock goes from ACLK100 (or ACLK66 on different socs).
>>
>> 1. Existing devfreq for Exynos4 does not change ACLK100 frequency.
>> 2. New patches from Chanwoo (Cc) add scaling of ACLK100 also to 50 MHz:
>> http://lkml.iu.edu/hypermail/linux/kernel/1512.1/04828.html
>>
>
> Thanks for the pointer, I missed that patch from Chanwoo.
>
>> The problem will be more severe if the watchdog got configured on 50 MHz
>> and then devfreq bumps the clock to 100 MHz...
>>
>
> So, what do you propose? We could for example set a maximum timeout on probe
> as $SUBJECT do and also update the maximum timeout again on the .set_timeout
> callback in case the clock rate changed. I think that is kind of hacky but I
> can't think of another way to guard about the frequency being changed.
>

People will likely get random watchdog timeouts if the frequency increases.
Typical example for shot-yourself-into-the-foot.

A watchdog driver using a non-static clock must register a clock change notifier
to handle the clock rate change and update its settings accordingly.

I would also argue that the maximum timeout should be set to the minimum
possible value (probably associated with the highest possible frequency).
All other cases might end up causing trouble if a clock frequency
chance results in an enforced timeout change, since there is currently
no mechanism to inform user space about such a change.

Example: maximum possible timeout changes from 1 minute to 30 seconds.
The timeout was set to 1 minute, and has to be reduced to 30 seconds.
Very likely result is that the watchdog will reset the system because
user space still believes that the timeout is 60 seconds and doesn't
ping the watchdog often enough to prevent it.

Guenter

