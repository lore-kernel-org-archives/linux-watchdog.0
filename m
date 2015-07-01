Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35541 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbbGAMCZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Jul 2015 08:02:25 -0400
Received: by qget71 with SMTP id t71so17192772qge.2
        for <linux-watchdog@vger.kernel.org>; Wed, 01 Jul 2015 05:02:24 -0700 (PDT)
Message-ID: <5593D6CC.10201@vanguardiasur.com.ar>
Date: Wed, 01 Jul 2015 09:02:20 -0300
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be,
	ezequiel@vanguardiasur.com.ar
Subject: Re: [PATCH 1/2] watchdog: NXP LPC18XX Windowed Watchdog Timer Driver
References: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar> <1435343072-8753-2-git-send-email-ariel@vanguardiasur.com.ar> <20150626190700.GC23078@roeck-us.net> <55903943.10309@vanguardiasur.com.ar> <5590CDF6.7000103@roeck-us.net> <5593CF3F.9040206@santafe.gov.ar>
In-Reply-To: <5593CF3F.9040206@santafe.gov.ar>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

(Sorry, I sent the last mail with an incorrect mail account)

El 01/07/15 a las 08:30, adalessandro escibió:
> 
> El 29/06/15 a las 01:47, Guenter Roeck escibió:
>> On 06/28/2015 11:13 AM, Ariel D'Alessandro wrote:
>>>>> +/* Timeout values in seconds */
>>>>> +#define LPC_WDT_DEF_TIMEOUT        1
>>>>> +
>>>>
>>>> One second ? This is highly unusual. 30 or 60 seconds is more common,
>>>> and one second would be very challenging for user space.
>>>>
>>>> Any special reason for using such a tight default ?
>>>
>>> Considering that LPC18xx Watchdog has a fixed divide-by-4 clock
>>> pre-scaler and a 24-bit counter and that Watchdog clock runs at a fixed
>>> frequency of 12MHz, timeout range goes from 1 to 5 seconds.
>>>
>>> I think you're right, 1 sec is very challenging, so it's 5 secs then.
>>>
>> Ultimately you might want to consider a soft timer as backup to the system
>> timeout. But that can be done later if/when needed.
> 
> I understand your point, but just to be sure, what do mean by soft timer?
> 
>>
>>>>> +
>>>>> +static int lpc_wdt_remove(struct platform_device *pdev)
>>>>> +{
>>>>> +    struct lpc_wdt_dev *lpc_wdt = platform_get_drvdata(pdev);
>>>>> +
>>>>> +    lpc_wdt_stop(&lpc_wdt->wdt_dev);
>>>>
>>>> This will keep the timer enabled. It would be interesting to see what
>>>> happens if you build the driver as module and unload it. I think
>>>> it will crash. Can you try ?
>>>
>>> Yes, you're right. After module gets unloaded, timer keeps enabled with
>>> a callback that was deallocated from memory.
>>>
>>> Since Watchdog cannot be disabled in hardware, it's not going to be
>>> possible to remove the driver without resetting the system. Unless we
>>> could keep a timer set and running outside the module, it won't be
>>> removable.
>>>
>>> What do you think?
>>>
>>
>> My take is that the driver should be loadable as module, which implies
>> that it must be removable. Whoever actually does remove the driver
>> is really asking for trouble and doesn't deserve better.
>>
>> On the other side, there are a few other watchdogs with similar properties.
>> Maybe we can just take guidance from there. Can you have a look ?
>> I can look myself, but it may take a few days.
> 
> Ok. I'm sending patchset v2 with all these modifications.
> 
>>
>> Thanks,
>> Guenter
>>
> --
