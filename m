Return-path: <j.uzycki@elproma.com.pl>
Message-ID: <541BFB63.3060006@elproma.com.pl>
Date: Fri, 19 Sep 2014 11:46:11 +0200
From: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog's pm support preffered implementation
References: <S1751381AbaIDOwq/20140904145246Z+988@vger.kernel.org> <54088996.4040500@elproma.com.pl> <540C9383.9050307@roeck-us.net> <540D02E1.90403@elproma.com.pl> <540D1F8F.2080802@roeck-us.net> <54196BE2.2010800@elproma.com.pl> <541ABD07.5090407@elproma.com.pl> <541B5156.803@elproma.com.pl> <541B5684.7000809@elproma.com.pl> <541B9EF7.4030702@roeck-us.net>
In-Reply-To: <541B9EF7.4030702@roeck-us.net>
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>


W dniu 2014-09-19 05:11, Guenter Roeck pisze:
> On 09/18/2014 03:02 PM, Janusz U¿ycki wrote:
>> Small fix below in the second implementation.
>>
>> best regards
>> Janusz
>>
>> W dniu 2014-09-18 23:40, Janusz U¿ycki pisze:
>>> Hi again,
>>>
>>> This is the second implementation. Which do you prefer?
>>>
> This one

ok

>
>>> Subject: [PATCH] stmp3xxx_rtc_wdt: Add suspend/resume PM support
>>>
>>>
>>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
>>> ---
>>>  drivers/watchdog/stmp3xxx_rtc_wdt.c | 39 +++++++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c 
>>> b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> index 3546f03..1946277 100644
>>> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> @@ -95,9 +95,48 @@ static int stmp3xxx_wdt_remove(struct 
>>> platform_device *pdev)
>>>         return 0;
>>>  }
>>>
>>> +#ifdef CONFIG_PM_SLEEP
>>> +/* There is no conflict with rtc/rtc-stmp3xxx.c parent
>>> + * because modified registers in PM functions are different */
>
> Coding style, and what does this comment mean ? To me it is just 
> confusing.

I will move to comment of commit

>
>>> +static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
>>> +{
>>> +       struct watchdog_device *wdd = dev_get_drvdata(dev);
>>
>> drvdata is NULL, too fast,
>> +       struct watchdog_device *wdd = &stmp3xxx_wdd;
>>
>>> +
>>> +       /* Is keep-on/ping timer suspended before?
>>> +        * or additional driver-specific flag must be added
>>> +        *  to block watchdog ping in the timer?
>>> +        * or disable WATCHDOG_KEEP_ON before wdt_stop
>>> +        *  and restore it in resume? */
>
> You'll have to answer those questions.

I guess you don't know if timers are stopped before susnder of other 
drivers?

>
>>> +       if (watchdog_active(wdd)) {
>>> +               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
>
> Does this message add any value ?
>
>>> +               return wdt_stop(wdd);
>>> +       }
>>> +       /* should we use pm_runtime like omap_wdt.c does? */
>
> Isn't that what you do here ?

I meant pm_runtime_put/get_sync() etc.
Maybe it is connected to my question above about timers.

>
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
>
> Does the __maybe_unused really apply ?

What do you preffer: __maybe_unused or ifdef CONFIG_PM_SLEEP?
I guess the first one because SIMPLE_DEV_PM_OPS/SET_SYSTEM_SLEEP_PM_OPS
just uses CONFIG_PM_SLEEP.

>
>>> +{
>>> +       struct watchdog_device *wdd = dev_get_drvdata(dev);
>> +       struct watchdog_device *wdd = &stmp3xxx_wdd;
>
> One of those lines needs to go.
Sure, I wanted to fix it on the list in fast way.
I'll use static stmp3xxx_wdd.

>
> Do you have indentation problems ? Do you use space for indentations, 
> maybe ?

No, it's probably Thunderbird copy-paste despite text email format.
When I finish fixes I will send patches using git:
1. watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
2. watchdog: boottime protection feature (requires 'keep on')
3. stmp3xxx_rtc_wdt: WATCHDOG_KEEP_ON enabled
4. stmp3xxx_rtc_wdt: Add suspend/resume PM support

>
>>
>>> +
>>> +       if (watchdog_active(wdd)) {
>>> +               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
>
> Does this message add any value ?

It was only for debug. Removed.

>
>>> +               return wdt_start(wdd);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +#endif /* CONFIG_PM_SLEEP */
>>> +
>>> +static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
>>> +               stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
>
> Please align second line with (
ok

>
>>> +
>>>  static struct platform_driver stmp3xxx_wdt_driver = {
>>>         .driver = {
>>>                 .name = "stmp3xxx_rtc_wdt",
>>> +               .owner = THIS_MODULE,
>
> Is this needed ? I have seen the .owner assignment being removed
> in other drivers recently.

I just noticed that some drivers have the assignment and others not.

https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/include/linux/platform_device.h?id=9447057eaff871dd7c63c808de761b8732407169
http://lxr.free-electrons.com/source/include/linux/platform_device.h?v=3.14
"use a macro to avoid include chaining to get THIS_MODULE"

You are right. The direction is to remove this. Removed.

"owner" history from must have to remove (for others):
http://stackoverflow.com/questions/19467150/significance-of-this-module-in-linux-driver
http://lists.linaro.org/pipermail/linaro-kernel/2013-July/005457.html
https://lkml.org/lkml/2014/9/8/1

best regards
Janusz
