Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58688 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbcE0NtJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 May 2016 09:49:09 -0400
Subject: Re: [RFC PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
To: Neil Armstrong <narmstrong@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
 <1464249112-13658-2-git-send-email-narmstrong@baylibre.com>
 <57470026.3000501@roeck-us.net> <57480470.4000708@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57485045.70707@roeck-us.net>
Date: Fri, 27 May 2016 06:48:53 -0700
MIME-Version: 1.0
In-Reply-To: <57480470.4000708@baylibre.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/27/2016 01:25 AM, Neil Armstrong wrote:
[ ... ]
>>> +    data->wdt_dev.max_hw_heartbeat_ms = GXBB_WDT_TCNT_SETUP_MASK;
>>> +    data->wdt_dev.min_hw_heartbeat_ms = 1;
>>
>> Does the device require a minimum time between heartbeats ?
>> Just asking, because you violate it yourself below.
>>
>> If you want to set the minimum timeout, that would be min_timeout.
>
> Ok, these values are not very clear actually.
>
Hmmm .. yes, reading the description again, it doesn't really describe well
what it is doing. Essentially, min_hw_heartbeat_ms is enforced by the watchdog
core, and should be used if a watchdog hardware can not tolerate short intervals
between heartbeats. min_timeout is the minimum timeout value configurable from
user space.

>>> +    data->wdt_dev.timeout = DEFAULT_TIMEOUT;
>>> +    watchdog_set_drvdata(&data->wdt_dev, data);
>>> +
>>> +    watchdog_init_timeout(&data->wdt_dev, DEFAULT_TIMEOUT, &pdev->dev);
>>> +
>>
>> DEFAULT_TIMEOUT is unnecessary here. Since the default timeout is already set,
>> it makes the call useless.
>>
>>> +    ret = watchdog_register_device(&data->wdt_dev);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    /* Setup with 1ms timebase */
>>> +    writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
>>> +        GXBB_WDT_CTRL_EE_RESET |
>>> +        GXBB_WDT_CTRL_CLK_EN |
>>> +        GXBB_WDT_CTRL_CLKDIV_EN,
>>> +        data->reg_base + GXBB_WDT_CTRL_REG);
>>> +    meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
>>
>> set_timeout already calls the ping function. Also, the functions should be called
>> prior to watchdog registration to avoid race conditions.
>>
>>> +    meson_gxbb_wdt_ping(&data->wdt_dev);
>>
>> This is unusual. If the watchdog can be already running, it might make sense
>> to tell the core about it (set WDOG_HW_RUNNING in the status field), so it
>> can send heartbeats until user space opens the device.
>
> Yes, since meson_gxbb_wdt_set_timeout() already ping, this is useless.
>

Not only that - if the watchdog _is_ already running at boot time, you should
really set WDOG_HW_RUNNING to let the watchdog core know. You status function
would come handy there.

	if (meson_gxbb_wdt_status(data))	// note the changed parameter
		set_bit(WDOG_HW_RUNNING, &data->wdt_dev.status);

Thanks,
Guenter

