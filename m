Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:55692 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdJLOM1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Oct 2017 10:12:27 -0400
Subject: Re: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
To: =?UTF-8?B?5YiY56iz?= <18502523564@163.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <1507641172-6099-1-git-send-email-18502523564@163.com>
 <8b80788f-5906-38a5-4b40-0a78f0ab55d9@roeck-us.net>
 <20171010135134.2zepquujhfwbhxoq@piout.net>
 <20171010150514.GB1879@roeck-us.net>
 <33912070.da58.15f10d0b307.Coremail.18502523564@163.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0c909661-c97d-dfcd-01f8-4afa727c96ae@roeck-us.net>
Date: Thu, 12 Oct 2017 07:12:24 -0700
MIME-Version: 1.0
In-Reply-To: <33912070.da58.15f10d0b307.Coremail.18502523564@163.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/12/2017 06:40 AM, ÁõÎÈ wrote:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2017-10-10 23:05:14, "Guenter Roeck" <linux@roeck-us.net> wrote:
>> On Tue, Oct 10, 2017 at 03:51:34PM +0200, Alexandre Belloni wrote:
>>> On 10/10/2017 at 06:41:15 -0700, Guenter Roeck wrote:
>>>> On 10/10/2017 06:12 AM, winton.liu wrote:
>>>>> When enable CONFIG_RTC_DRV_DS1374_WDT use as watchdog,
>>>>> in suspend mode, watchdog is still working but no daemon
>>>>> patting the watchdog. The system will reboot if timeout.
>>>>>
>>>>> Add support suspend/resume for watchdog.
>>>>> suspend: disable the watchdog
>>>>> resume: disable existing watchdog, reload watchdog timer, enable watchdog
>>>>>
>>>>> Signed-off-by: winton.liu <18502523564@163.com>
>>>>> ---
>>>>>    drivers/rtc/rtc-ds1374.c | 31 +++++++++++++++++++++++++++++++
>>>>>    1 file changed, 31 insertions(+)
>>>>>
>>>>> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
>>>>> index 38a2e9e..642e31d 100644
>>>>> --- a/drivers/rtc/rtc-ds1374.c
>>>>> +++ b/drivers/rtc/rtc-ds1374.c
>>>>> @@ -437,6 +437,29 @@ static void ds1374_wdt_ping(void)
>>>>>    		pr_info("WD TICK FAIL!!!!!!!!!! %i\n", ret);
>>>>>    }
>>>>> +static void ds1374_wdt_resume(void)
>>>>> +{
>>>>> +	int ret = -ENOIOCTLCMD;
>>>>
>>>> Useless initialization (yes, I can see that this is widely done in the driver,
>>>> but that doesn't make it better).
>>>>
>          Yes, I think this is useless. The original ds1374_wdt_disable has the same issue.

That doesn't make it better and is not an argument.

>>>>> +	int cr;
>>>>> +
>>>>> +	cr = i2c_smbus_read_byte_data(save_client, DS1374_REG_CR);
>>>>> +
>>>>> +	/* Disable any existing watchdog/alarm before setting the new one */
>>>>> +	cr &= ~DS1374_REG_CR_WACE;
>>>>> +
>>>>> +	i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
>>>>> +
>>>>> +	/* Reload watchdog timer */
>>>>> +	ds1374_wdt_ping();
>>>>> +
>>>>> +	/* Enable watchdog timer */
>>>>> +	cr |= DS1374_REG_CR_WACE | DS1374_REG_CR_WDALM;
>>>>> +	cr &= ~DS1374_REG_CR_AIE;
>>>>> +
>>>>> +	ret = i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
>>>>> +
>>>> Extra empty line. Also, returns void, so what is the point of assigning
>>>> the result to ret ?
>>>>
>>>>> +}
>>>>
>>>> Unless I am missing something, this unconditionally starts the watchdog
>>>> at resume time. So if it was not running before, it will be started anyway,
>>>> and the system will reboot since there will be no ping.
>>>>
>      This driver starts watchdog by default. In probe watchdog starts:
>     #ifdef CONFIG_RTC_DRV_DS1374_WDT
>      save_client = client;
>      ret = misc_register(&ds1374_miscdev);
>      if (ret)
>          return ret;
>      ret = register_reboot_notifier(&ds1374_wdt_notifier);
>      if (ret) {
>          misc_deregister(&ds1374_miscdev);
>          return ret;
>      }
>      ds1374_wdt_settimeout(131072);   //Here starts watchdog

Meaning the system will reboot unless the watchdog device is opened ?
Weird, and conceptually wrong.

What if the watchdog device is stopped explicitly by the watchdog demon ?

> #endif
>     And userspace watchdogd will ping.
>>>
>>> Also, I'm still not convinced this is the right thing to do. I have seen
>>> many systems were it was desirable to let the watchdog run while the
>>> system is suspended. It ensures it will either wake up or reboot. If you
>>> don't want that, why not disabling the watchdog from userspace before
>>> going to suspend?
>>>
>>
>> Usually watchdog drivers supporting suspend/resume do handle it this way.
>> Maybe that depends on the HW. Expecting user space to do it makes it
>> even more racy than it already is, since there is no watchdog protection
>> after it has been disabled, so I am not sure if that is really better.
>> Does anyone happen to know if/how systemd and watchdogd are handling
>> this situation ?
>>
>>>> I assume it is guaranteed that the chip doesn't forget the previously
>>>> configured timeout on resume.
>>>>
>>>> Overall the driver would really benefit from a conversion to the watchdog
>>>> subsystem.
>>>>
>>>
>>> That is the point of https://www.spinics.net/lists/linux-watchdog/msg12095.html
>>
>> Ah, yes, and I even provided feedback. Hope I didn't miss an updated
>> version of that patch. Either case, seems to me we should wait for that
>> patch to make it in before accepting any further changes to the driver.
>>
>     Is this multi function patch has any update ? If not, could my patch be acceptable before moving to watchdog subsystem.(I could update a new patch for your suggestion)?
>     Because current kernel using ds1374 for watchdog. If the device need suspend, there will be a reboot issue.
> 
Only if CONFIG_RTC_DRV_DS1374_WDT is enabled, and then it appears the driver
has other problems such as unconditionally enabling the watchdog.
Given that, I am not in favor of temporary changes.

Guenter
