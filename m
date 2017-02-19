Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53324 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdBSQ74 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 19 Feb 2017 11:59:56 -0500
Subject: Re: [PATCH v2 2/3] watchdog: sama5d4: Fix setting timeout when
 watchdog is disabled
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
 <20170216193053.5546-2-alexandre.belloni@free-electrons.com>
 <968ef53e-c3c4-5322-020a-8382ce367931@roeck-us.net>
 <20170217151625.hv2vn5imx2kyeftt@piout.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c9f336fd-8761-7999-4ac0-cf68eb6c8ba1@roeck-us.net>
Date: Sun, 19 Feb 2017 08:57:35 -0800
MIME-Version: 1.0
In-Reply-To: <20170217151625.hv2vn5imx2kyeftt@piout.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/17/2017 07:16 AM, Alexandre Belloni wrote:
> On 17/02/2017 at 06:40:33 -0800, Guenter Roeck wrote:
>> On 02/16/2017 11:30 AM, Alexandre Belloni wrote:
>>> The datasheet states: "When setting the WDDIS bit, and while it is set, the
>>> fields WDV and WDD must not be modified."
>>>
>>> Ensure WDDIS is not set when changing the timeout and set it afterwards if
>>> the watchdog was disabled.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> ---
>>> Changes in v2:
>>>  - new patch
>>>  drivers/watchdog/sama5d4_wdt.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
>>> index 2c6f5a70ae67..2a60251806d2 100644
>>> --- a/drivers/watchdog/sama5d4_wdt.c
>>> +++ b/drivers/watchdog/sama5d4_wdt.c
>>> @@ -90,11 +90,18 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
>>>  	u32 reg;
>>>
>>>  	reg = wdt_read(wdt, AT91_WDT_MR);
>>> +
>>> +	if (reg & AT91_WDT_WDDIS)
>>> +		wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
>>> +
>>>  	reg &= ~AT91_WDT_WDV;
>>>  	reg &= ~AT91_WDT_WDD;
>>>  	reg |= AT91_WDT_SET_WDV(value);
>>>  	reg |= AT91_WDT_SET_WDD(value);
>>> -	wdt_write(wdt, AT91_WDT_MR, reg);
>>> +	wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
>>> +
>>> +	if (reg & AT91_WDT_WDDIS)
>>> +		wdt_write(wdt, AT91_WDT_MR, reg);
>>>
>> That means if the watchdog is running, the timeout would not be updated.
>> It should be updated no matter if it is running or not.
>>
>
> No, it is enabling the watchdog, then changing WDV and WDD and finally
> disabling the watchdog if necessary. So, WDV and WDD are always changed.
>
You are correct. Sorry for the noise.

Seems odd that the watchdog must be _running_ to change the timeout.
Usually, if there is a restriction, it is the opposite. I hope this
doesn't cause race conditions, where the watchdog fires immediately
after being enabled due to a low timeout.

Guenter

