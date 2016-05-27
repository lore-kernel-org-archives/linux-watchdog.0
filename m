Return-path: <narmstrong@baylibre.com>
Subject: Re: [RFC PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
References: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
 <1464249112-13658-2-git-send-email-narmstrong@baylibre.com>
 <57470026.3000501@roeck-us.net> <57480470.4000708@baylibre.com>
 <57485045.70707@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <574866C7.1090201@baylibre.com>
Date: Fri, 27 May 2016 17:24:55 +0200
MIME-Version: 1.0
In-Reply-To: <57485045.70707@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/27/2016 03:48 PM, Guenter Roeck wrote:
> On 05/27/2016 01:25 AM, Neil Armstrong wrote:
> [ ... ]
>>>> +    data->wdt_dev.max_hw_heartbeat_ms = GXBB_WDT_TCNT_SETUP_MASK;
>>>> +    data->wdt_dev.min_hw_heartbeat_ms = 1;
>>>
>>> Does the device require a minimum time between heartbeats ?
>>> Just asking, because you violate it yourself below.
>>>
>>> If you want to set the minimum timeout, that would be min_timeout.
>>
>> Ok, these values are not very clear actually.
>>
> Hmmm .. yes, reading the description again, it doesn't really describe well
> what it is doing. Essentially, min_hw_heartbeat_ms is enforced by the watchdog
> core, and should be used if a watchdog hardware can not tolerate short intervals
> between heartbeats. min_timeout is the minimum timeout value configurable from
> user space.
OK, I'll switch to min_timeout = 1.

> 

[ ... ]

>>>
>>> This is unusual. If the watchdog can be already running, it might make sense
>>> to tell the core about it (set WDOG_HW_RUNNING in the status field), so it
>>> can send heartbeats until user space opens the device.
>>
>> Yes, since meson_gxbb_wdt_set_timeout() already ping, this is useless.
>>
> 
> Not only that - if the watchdog _is_ already running at boot time, you should
> really set WDOG_HW_RUNNING to let the watchdog core know. You status function
> would come handy there.
> 
>     if (meson_gxbb_wdt_status(data))    // note the changed parameter
>         set_bit(WDOG_HW_RUNNING, &data->wdt_dev.status);
Yes, it can be handy.

I will push this feature in a next version, I'll stick to a simpler behavior and check
if it would be running before the kernel starts.

Thanks,
Neil

> 
> Thanks,
> Guenter
> 
