Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46337 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaK0Tbp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Nov 2014 14:31:45 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xu4n0-001Eoy-T3
	for linux-watchdog@vger.kernel.org; Thu, 27 Nov 2014 19:31:43 +0000
Message-ID: <54777C18.3010609@roeck-us.net>
Date: Thu, 27 Nov 2014 11:31:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Boris Brezillon <boris.brezillon@free-electrons.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <5465C00E.4030808@offcode.fi>	<1416572610-1770-1-git-send-email-timo.kokkonen@offcode.fi>	<5476CA7F.4000802@offcode.fi>	<5476ED44.603@atmel.com>	<54775E12.6020906@roeck-us.net> <20141127200647.4f0575ca@bbrezillon>
In-Reply-To: <20141127200647.4f0575ca@bbrezillon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/27/2014 11:06 AM, Boris Brezillon wrote:
> Hi Guenter,
>
> On Thu, 27 Nov 2014 09:23:30 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On 11/27/2014 01:22 AM, Nicolas Ferre wrote:
>>> On 27/11/2014 07:53, Timo Kokkonen wrote:
>>>> Hi,
>>>>
>>>> On 21.11.2014 14:23, Timo Kokkonen wrote:
>>>>> By default the driver will start a kernel timer which keeps on kicking
>>>>> the watchdog HW until user space has opened the watchdog
>>>>> device. Usually this is desirable as the watchdog HW is running by
>>>>> default and the user space may not have any watchdog daemon running at
>>>>> all.
>>>>>
>>>>> However, on production systems it may be mandatory that also early
>>>>> crashes and lockups will lead to a watchdog reset, even if they happen
>>>>> before the user space has opened the watchdog device.
>>>>>
>>>>> To resolve the issue, add a new device tree property
>>>>> "enable-early-reset" which will prevent the kernel timer from pinging
>>>>> the watchdog HW on behalf of user space. The default is still to use
>>>>> kernel timer, but more strict behavior can be enabled via the device
>>>>> tree property.
>>>>>
>>>>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>>>>
>>>> I forgot to put the PATCHv2 on the subject line.. But anyway, any
>>>> thoughts about it? Is there something that should be done to get it forward?
>>>
>>> Sorry for not having come back to you quickly.
>>>
>>> The only thing that tend to prevent me from taking this patch is the
>>> fact that this DT property is mostly a software, Linux-specific one...
>>> Which is somehow not covered by the DT.
>>> This might explain as well why this property is not present on other SoCs.
>>>
>>> Can we have other people's advices?
>>>
>>
>> We have been thinking about a more generic (infrastructure based) solution
>> for the problem at hand, but that was a bit more complex and would specify
>> the actual timeout during boot, not just a boolean like suggested here.
>
> Can't we keep the same timeout (the one specified in the timeout-sec
> property) ?
>
That doesn't take into account systems where - for whatever reason -
the initial timeout needs to be longer. I do not think it is a good idea
to unnecessarily limit functionality. We may make the additional timeout
optional - in that case timeout-sec could be used as default.

>>
>> As for DT not supposed to be used for configuration, that is really a
>> tricky problem which is hard to solve. I seem to recall, though, that
>> it may be now acceptable under certain conditions. A module parameter
>> might be easier.
>
> I'm not a big fan of passing these kind information through module
> params, cause it's kind of hard to assign parameters when you have
> multiple device instances (it might not be applicable to watchdog
> devices though).
> Moreover, adding more module parameters will just expand the cmdline
> and make it less and less readable.
>
Agreed but ...

> Anyway, this is not my call to make :-).

it isn't us who restrict the DT scope (though of course timeout-sec
_is_ configuration, but that was before things got more restrictive).

Guenter

