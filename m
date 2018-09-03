Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34273 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeICFNi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Sep 2018 01:13:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so7809036pgv.1
        for <linux-watchdog@vger.kernel.org>; Sun, 02 Sep 2018 17:55:57 -0700 (PDT)
Subject: Re: [PATCH 1/2] watchdog: Add support for Armada 37xx CPU watchdog
To: Marek Behun <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
References: <20180830142243.12153-1-marek.behun@nic.cz>
 <20180830162853.GA27086@roeck-us.net> <20180830204223.391d6066@nic.cz>
 <20180830205004.6fe9858f@nic.cz> <20180830191226.GB6752@roeck-us.net>
 <20180901022930.64ef4062@nic.cz>
 <0a9c1c83-db36-1572-b4a6-8c49acffa1b0@roeck-us.net>
 <20180902221243.0f7a5035@nic.cz>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <50233b7e-0e61-a9a7-59d0-14d1ec58210f@roeck-us.net>
Date: Sun, 2 Sep 2018 17:55:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180902221243.0f7a5035@nic.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/02/2018 01:12 PM, Marek Behun wrote:
> Hi Guenter,
> 
> One cannot restart the counter to start counting down from initial
> value without disabling the counter, but the counter can be made to
> restart counting from the initial value by an event which can be set,
> and for Counter ID 1 the event can be set to "end count of Counter ID
> 0".
> 
> I have therefore reimplemented the driver so that two counters are
> used. Counter ID 1 is used as the watchdog counter, while Counter ID 0
> is used to reset Counter ID 1 to start counting from initial value.
> Pinging is then done by forcing immediate end count event on Counter ID
> 0.
> 
> I discovered that counters 2 and 3 are enabled by default even before
> U-Boot loads on the board, and therefore, in combination with the
> previous, decided not to add th possibility to select watchdog counter
> as a devicetree property.
> 
> What do you think of this?
> 

Ok with me. Please add above explanation to the driver.

Thanks,
Guenter

> Marek
> 
> On Fri, 31 Aug 2018 17:47:38 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 08/31/2018 05:29 PM, Marek Behun wrote:
>>> Hello Guenter,
>>> I just read in the specification that software does not need to
>>> do debouncing, because when low is read, high is latched into 32 bit
>>> flip flop so that it can be read correctly.
>>> So the correct way is to read low first, then high, and that's it.
>>> I shall write a comment describing this into new code.
>>
>> Excellent. Thanks for checking!
>>
>> Guenter
>>
>>> Marek
>>>
>>> On Thu, 30 Aug 2018 12:12:26 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>    
>>>> On Thu, Aug 30, 2018 at 08:50:04PM +0200, Marek Behun wrote:
>>>>>>>> +static u64 get_counter_value(struct armada_37xx_watchdog
>>>>>>>> *dev) +{
>>>>>>>> +	u64 val;
>>>>>>>> +
>>>>>>>> +	val = readl(dev->reg + CNTR_COUNT_HIGH);
>>>>>>>> +	val = (val << 32) | readl(dev->reg +
>>>>>>>> CNTR_COUNT_LOW);
>>>>>>>
>>>>>>> Is this guaranteed to be consistent ? What happens if there is a
>>>>>>> 32-bit wrap between those two operations ?
>>>>>>
>>>>>> hmmm. The address is not divisible by 8, so I can't use
>>>>>> readq :( what do you propose?
>>>>>
>>>>> What do you think of this solution?
>>>>>
>>>>> u64 val;
>>>>> u32 low1, low2;
>>>>>
>>>>> low1 = readl(dev->reg + CNTR_COUNT_LOW);
>>>>> val = readl(dev->reg + CNTR_COUNT_HIGH);
>>>>> low2 = readl(dev->reg + CNTR_COUNT_LOW);
>>>>>
>>>>> /*
>>>>>    * If low jumped in this short time more than 2^31, a wrap
>>>>> probably
>>>>>    * occured. Read high again.
>>>>>    */
>>>>> if (low2 - low1 > 0x80000000)
>>>>> 	val = readl(dev->reg + CNTR_COUNT_HIGH);
>>>>> val = (val << 32) | low2;
>>>>
>>>> Yes, that is one option. The other would be to read high again
>>>> all the time and repeat reading low if high changed on the second
>>>> read of high.
>>>>
>>>> 	high1 = readl(dev->reg + CNTR_COUNT_HIGH);
>>>> 	low = readl(dev->reg + CNTR_COUNT_LOW);
>>>> 	high2 = readl(dev->reg + CNTR_COUNT_HIGH);
>>>> 	if (high2 != high1)
>>>> 		low = readl(dev->reg + CNTR_COUNT_LOW);
>>>> 	val = (high2 << 32) | low;
>>>>
>>>> There is no ambiguity in this case: We _know_ that
>>>> a wrap occurred if high1 and high2 are different.
>>>>
>>>> Guenter
>>>
>>>    
>>
> 
> 
