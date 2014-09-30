Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33693 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaI3NsO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Sep 2014 09:48:14 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XYxmo-0021Md-4r
	for linux-watchdog@vger.kernel.org; Tue, 30 Sep 2014 13:48:14 +0000
Message-ID: <542AB482.5060102@roeck-us.net>
Date: Tue, 30 Sep 2014 06:47:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
References: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl> <5424E535.7060009@roeck-us.net> <542987F9.2080907@elproma.com.pl> <542A3392.8020903@roeck-us.net> <542A8471.8060401@elproma.com.pl>
In-Reply-To: <542A8471.8060401@elproma.com.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/30/2014 03:22 AM, Janusz Użycki wrote:
>
> W dniu 2014-09-30 06:37, Guenter Roeck pisze:
>> On 09/29/2014 09:25 AM, Janusz Użycki wrote:
>>>
>>>> This patch set is trying to solve four problems at once:
>>>>
>>>> 1) Auto-start watchdog when its driver registers
>>>> 2) Keep watchdog running when its driver registers until userspace opens it
>>>> 3) Handle watchdogs which can not be stopped after being started
>>>> 4) Keep watchdog running with kernel timer after it has been closed,
>>>>    even if it can be stopped.
>>>>
>>>> The next time adds 'boot time protection', which is really another term
>>>> for an initial timeout, and case 5).
>>>>
>>>> That is a bit too much for a single patch and, even more so, a single flag.
>>>
>>> OK, but I think [PATCH 3/6] could be applied.
>>> Do you agree? Should I resent it separately?
>>
>> Yes, it looks ok.
>
> Can you apply it?
>
I don't apply watchdog patches; I only provide review feedback.

>>
>>> I omited in the comment
>>> "The patch adds suspend/resume PM support to stmp3xxx_rtc_wdt
>>> watchdog driver" because the subject is almost the same.
>>>
>>>> Let's look at one case after another.
>>>>
>>>> Auto-start watchdog when its driver registers - this makes sense as a
>>>> feature just by itself. A good name for its flag might be something like
>>>> WDT_AUTOSTART. A matching module parameter might also make sense.
>>>>
>>>> autostart:
>>>>     Set to 0 to disable, -1 to enable with unlimited timeout,
>>>>     or <n> for an initial timeout of <n> seconds.
>>>
>>> Current start(1) + keep-on(2,3,4) + boottime(5) combined. It looks OK.
>>>
>> Maybe for you. For me they are different cases.
>
> They are different. I missed some words in the first sentence :)
> However autostart automatically combine them together again :)
> The problem is common timer so the patches are dependent.
> There is no reason to use more timers.
>
I did not say use multiple timers. I said use multiple flags.

Guenter

