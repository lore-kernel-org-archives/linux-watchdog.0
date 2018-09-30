Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f170.google.com ([209.85.215.170]:44777 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeI3UcH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 30 Sep 2018 16:32:07 -0400
Received: by mail-pg1-f170.google.com with SMTP id g2-v6so7604546pgu.11
        for <linux-watchdog@vger.kernel.org>; Sun, 30 Sep 2018 06:58:58 -0700 (PDT)
Subject: Re: Default behavior of watchdog drivers
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>,
        Giel van Schijndel <me@mortis.eu>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
References: <20180930130916.GA29981@www.linux-watchdog.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <dc240d8c-d31d-45cc-2741-261c4c27ec81@roeck-us.net>
Date: Sun, 30 Sep 2018 06:58:55 -0700
MIME-Version: 1.0
In-Reply-To: <20180930130916.GA29981@www.linux-watchdog.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/30/2018 06:09 AM, Wim Van Sebroeck wrote:
> hi Jean, Guenter,
> 
>> Hi Jean,
>>
>> On 09/27/2018 05:38 AM, Jean Delvare wrote:
>>> Hello,
>>>
>>> It seems that various watchdog drivers behave differently if the
>>> watchdog timer is already enabled when the driver is loaded:
>>>
>>> * iTCO_wdt will disable the timer. I think this is what most drivers
>>>    do, but not all.
>>> * w83627hf_wdt will let the timer run, unless option early_disable=1 is
>>>    passed.
>>>
>>> These are the 2 which bother me the most because they are among the
>>> most popular watchdog drivers on x86 systems. Having a different
>>> behavior depending on which driver is used is quite confusing.
>>>
>>> Can we please settle on a default behavior (either all drivers reset
>>> the timer a load time, or none do it) and have all watchdog drivers
>>> stick to that?
>>>
>>
>> Since
>>
>> ee142889e32f watchdog: Introduce WDOG_HW_RUNNING flag
>> 664a39236e71 watchdog: Introduce hardware maximum heartbeat in watchdog core
>>
>> the default behavior _should_ be that the timer is kept running but the
>> core is informed that it is running. Of course, that doesn't mean that
>> (legacy) drivers actually do that.
>>
>> Please note that some watchdog drivers can not be stopped, so a common
>> mechanism to stop watchdogs during probe is technically impossible.
> 
> Originally the default behaviour was to stop the watchdog if it was running and restart it when /dev/watchdog was opened.
> However some watchdog devices can't be stopped once running and the starting of it or not is done on "BIOS" level. So there we said that if the watchdog is allready running and it can't be stopped that the core should keep the watchdog running as long as the device is not "opened".
> 
> So the correct behaviour is that we should not have the watchdog device active if the device is not being used, but when the device can't be stopped then we need to keep the watchdog running and do the keepalive ping ourselves. It makes no sense to start the watchdog and ping it while itis not in use and can be stopped.
> 
> So looking at Jean's comment I think we need to review how w83627hf_wdt does the logic.
> 

I have seen requests that evrn watchdogs which can be stopped should be
kept running to ensure that the system is always protected. Given that,
I would hesitate to take that functionality away from the w83627hf_wdt
driver.

Guenter

>>> If an option to get the opposite behavior is deemed useful, can we
>>> settle on a standard name for it? Or even implement it at the
>>> watchdog_core level, so that each driver doesn't need to implement it
>>> separately?
>>>
>>> While looking into this, I found a few other strange module parameters:
>>>
>>> * f71808e_wdt has "start_withtimeout", which starts the timer even if
>>>    nobody opens the watchdog device node. Giel, do we really need this?
>>
>> We had requests for a common mechanism to do that, ie some kind of boot
>> timeout. Idea would be to reboot the system if the watchdog device has
>> not been opened after a set period of time. Maybe that is the idea here.
>>
>> Guenter
>>
>>> * octeon-wdt has "disable", which completely disables the watchdog
>>>    function. This "feature" was sneaked in via commit 381cec022e46
>>>    ("watchdog: octeon-wdt: File cleaning.") which was supposed to be a
>>>    cleanup-only patch, without any explanation nor even mention. I can't
>>>    see how such an option can be useful. If you don't need the driver,
>>>    just don't load it. Steven, can you explain?
>>>
>>> Thanks,
>>>
>>
> 
> Kind regards,
> Wim.
> 
> 
