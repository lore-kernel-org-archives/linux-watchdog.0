Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38333 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaI3EiH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Sep 2014 00:38:07 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XYpCQ-000QqT-Be
	for linux-watchdog@vger.kernel.org; Tue, 30 Sep 2014 04:38:06 +0000
Message-ID: <542A3392.8020903@roeck-us.net>
Date: Mon, 29 Sep 2014 21:37:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
References: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl> <5424E535.7060009@roeck-us.net> <542987F9.2080907@elproma.com.pl>
In-Reply-To: <542987F9.2080907@elproma.com.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/29/2014 09:25 AM, Janusz Użycki wrote:
>
> W dniu 2014-09-26 06:01, Guenter Roeck pisze:
>> On 09/22/2014 01:55 PM, Janusz Uzycki wrote:
>>> Some applications require to start watchdog before userspace software.
>>> This patch enables such feature. Only the flag is necessary
>>> to enable it.
>>> Moreover kernel's ping is re-enabled when userspace software closed
>>> watchdog using the magic character. The features improves kernel's
>>> reliability if hardware watchdog is available.
>>>
>>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
>>
>
> Hi Guenter,
>
>>
>> This patch set is trying to solve four problems at once:
>>
>> 1) Auto-start watchdog when its driver registers
>> 2) Keep watchdog running when its driver registers until userspace opens it
>> 3) Handle watchdogs which can not be stopped after being started
>> 4) Keep watchdog running with kernel timer after it has been closed,
>>    even if it can be stopped.
>>
>> The next time adds 'boot time protection', which is really another term
>> for an initial timeout, and case 5).
>>
>> That is a bit too much for a single patch and, even more so, a single flag.
>
> OK, but I think [PATCH 3/6] could be applied.
> Do you agree? Should I resent it separately?

Yes, it looks ok.

> I omited in the comment
> "The patch adds suspend/resume PM support to stmp3xxx_rtc_wdt
> watchdog driver" because the subject is almost the same.
>
>> Let's look at one case after another.
>>
>> Auto-start watchdog when its driver registers - this makes sense as a
>> feature just by itself. A good name for its flag might be something like
>> WDT_AUTOSTART. A matching module parameter might also make sense.
>>
>> autostart:
>>     Set to 0 to disable, -1 to enable with unlimited timeout,
>>     or <n> for an initial timeout of <n> seconds.
>
> Current start(1) + keep-on(2,3,4) + boottime(5) combined. It looks OK.
>
Maybe for you. For me they are different cases.

>>
>> This could be accompanied by a variable in watchdog_device:
>>     int init_timeout;    /* initial timeout in seconds */
>
> As the module parameter, instead of "boottime" in watchdog_core?
>
>>
>> An API function such as watchdog_set_autostart() with the initial timeout
>> as parameter would also be helpful. This function could then be used to
>> implement 2).
>>
>>     if (autostart || (keep_running && this_watchdog_is_running())
>>         watchdog_set_autostart(&wdd, autostart ? : keep_running);
>>
> I don't understand the difference exactly and why to check the watchdog
> is running? This means watchdog is active or something new?
>
>> keep_running could then be a another module parameter with the same meaning
>> as autostart.
> But autostart and keep_running aren't in conflict.
> So I don't understand also "autostart ? : keep_running".
>

The functionality is distinctively different.

autostart: start watchdog on module load
keep_running: If the watchdog is already running, keep it running. Otherwise do nothing.

Both have different use cases which should not be combined.

>>
>> Together this would also solve problem 5) while at the same time keeping
>> the use cases separate.
>
> It is solved by current code.
>
>>
>> For 3) we really need another flag. Actually, it might be sufficient to have
>> watchdog drivers with this condition simply not provide a 'stop' function.
> or use "NOT SUPPORTED" error code in stop,
> Stop could be called on register and new flag is set.
>

Seems to add complexity for no real benefit. Please explain why you think
it is a good idea to have multiple drivers implement the same function
just to return an error and do nothing else,

>> If we use a flag, something like WDOG_HW_NO_WAY_OUT with matching
>> WATCHDOG_HW_NOWAYOUT might make sense. Its functionality is slightly
>
> What is difference between WDOG_HW_NO_WAY_OUT
> and WATCHDOG_HW_NOWAYOUT?
>
Similar to other flags

#define WDOG_HW_NO_WAY_OUT	5
#define WATCHDOG_HW_NOWAYOUT	(1 << WDOG_HW_NO_WAY_OUT)

>> different to the other conditions: It would not auto-start a watchdog,
>> but keep it running with the internal timer when the watchdog file is closed.
>>
>> As for 4), I don't really know if it makes sense to have this functionality.
>
> Yes, it is rootfs specific need. Script based code runs watchdog before
> critical function and after exit the watchdog using magic char.
> Critical section has timeout equal watchdog timeout value.
> The feature allow to avoid userland application for watchdog
> and does not cost much in the kernel.
>
Sorry, I can not follow your logic here. A basic userland implementation
doesn't cost much either, is much safer, and even init systems such as
systemd implement it nowadays.

Guenter

