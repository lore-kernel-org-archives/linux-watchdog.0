Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51257 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbbF2Erz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Jun 2015 00:47:55 -0400
Message-ID: <5590CDF6.7000103@roeck-us.net>
Date: Sun, 28 Jun 2015 21:47:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be,
	ezequiel@vanguardiasur.com.ar
Subject: Re: [PATCH 1/2] watchdog: NXP LPC18XX Windowed Watchdog Timer Driver
References: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar> <1435343072-8753-2-git-send-email-ariel@vanguardiasur.com.ar> <20150626190700.GC23078@roeck-us.net> <55903943.10309@vanguardiasur.com.ar>
In-Reply-To: <55903943.10309@vanguardiasur.com.ar>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/28/2015 11:13 AM, Ariel D'Alessandro wrote:
> Hi Guenter,
> Thanks for your quick reply.
>
My pleasure ....

>>> +/*
>>> + * NXP LPC18xx Windowed Watchdog Timer (WWDT)
>>> + *
>>
>> What does "Windowed" stand for ? That term doesn't really mean anything
>> to me. How does it differ from a non-windowed watchdog driver ?
>
> "NXP LPC18xx Windowed Watchdog Timer" is the full specific name of the
> Watchdog, as it's written in the LPC18xx User Manual (UM10430).
>
> "Windowed" means that, besides the maximum, a minimum time-out period
> can be set, requiring reload operation (feed) to occur between these two
> limits.
>
> Linux watchdog framework doesn't take this property into account, so
> "Windowed" term may not have much significance here. Do you think it
> should be removed?
>
I would suggest to drop the term - without explanation it is just confusing.

>>> +/* Timeout values in seconds */
>>> +#define LPC_WDT_DEF_TIMEOUT		1
>>> +
>>
>> One second ? This is highly unusual. 30 or 60 seconds is more common,
>> and one second would be very challenging for user space.
>>
>> Any special reason for using such a tight default ?
>
> Considering that LPC18xx Watchdog has a fixed divide-by-4 clock
> pre-scaler and a 24-bit counter and that Watchdog clock runs at a fixed
> frequency of 12MHz, timeout range goes from 1 to 5 seconds.
>
> I think you're right, 1 sec is very challenging, so it's 5 secs then.
>
Ultimately you might want to consider a soft timer as backup to the system
timeout. But that can be done later if/when needed.

>>> +
>>> +static int lpc_wdt_remove(struct platform_device *pdev)
>>> +{
>>> +	struct lpc_wdt_dev *lpc_wdt = platform_get_drvdata(pdev);
>>> +
>>> +	lpc_wdt_stop(&lpc_wdt->wdt_dev);
>>
>> This will keep the timer enabled. It would be interesting to see what
>> happens if you build the driver as module and unload it. I think
>> it will crash. Can you try ?
>
> Yes, you're right. After module gets unloaded, timer keeps enabled with
> a callback that was deallocated from memory.
>
> Since Watchdog cannot be disabled in hardware, it's not going to be
> possible to remove the driver without resetting the system. Unless we
> could keep a timer set and running outside the module, it won't be
> removable.
>
> What do you think?
>

My take is that the driver should be loadable as module, which implies
that it must be removable. Whoever actually does remove the driver
is really asking for trouble and doesn't deserve better.

On the other side, there are a few other watchdogs with similar properties.
Maybe we can just take guidance from there. Can you have a look ?
I can look myself, but it may take a few days.

Thanks,
Guenter

