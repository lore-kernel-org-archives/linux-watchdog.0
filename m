Return-path: <ldewangan@nvidia.com>
Message-ID: <57581D40.1040304@nvidia.com>
Date: Wed, 8 Jun 2016 18:57:28 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: <wim@iguana.be>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH] watchdog: max77620: Add support for watchdog timer
References: <1465213964-25639-1-git-send-email-ldewangan@nvidia.com> <20160607175600.GA3712@roeck-us.net> <5757DE51.6000201@nvidia.com> <57581A7F.4000200@roeck-us.net>
In-Reply-To: <57581A7F.4000200@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>


On Wednesday 08 June 2016 06:45 PM, Guenter Roeck wrote:
> On 06/08/2016 01:58 AM, Laxman Dewangan wrote:
>> Hi Guenter,
>>
>> Thanks for quick review. I will take care of most of comment.
>> I have one query fr following comment.
>>
>> Thanks,
>> Laxman
>>
>> On Tuesday 07 June 2016 11:26 PM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Mon, Jun 06, 2016 at 05:22:44PM +0530, Laxman Dewangan wrote:
>>> +    /* Stop watchodog */
>>> +    ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
>>> +                 MAX77620_WDTEN, 0);
>>> +    if (ret < 0) {
>>> +        dev_err(wdt->dev, "Failed to reset WDTEN: %d\n", ret);
>>> +        return ret;
>>> +    }
>>> Alternatively, you could set WDOG_HW_RUNNING to tell the watchdog core
>>> that the watchdog is already running. The watchdog core would then ping
>>> the watchdog until the watchdog device is opened.
>>>
>>> That would also require to tell the watchdog core about the current 
>>> (or default)
>>> timeout, which doesn't seem to be set anywhere. That means it won't 
>>> be set at all
>>> unless user space updates it explicitly. This is quite unusual. Is 
>>> it on purpose
>>> or an oversight ? If it is on purpose, please explain.
>>
>> OK, we have use cases where we have enabled the WDT in BL also. and 
>> keep runnign till kernel up.
>> Instead of stopping WDT, I can say that WDOG_HW_RUNING and current 
>> timeout can be read from the register.
>>
>> Now, the WDT need to be ping periodically. Is there any flag which 
>> enabled the worker thread from core which will keep pinging till user 
>> space alive and activate the WDT?
>>
> The watchdog core will start the worker if WDOG_HW_RUNNING is set.
>
>

Thanks, found that I also need to set max_hw_heartbeat_ms  for periodic 
ping if user space is not active.
I tested this path and it works perfectly. This is also great that all 
work thread is moved to core. It simplify the drivers very much.

I sent the v2 patch with fixing all this.

Thanks,
Laxman
