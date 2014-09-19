Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56167 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbaISDL5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Sep 2014 23:11:57 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XUobz-004Id8-UW
	for linux-watchdog@vger.kernel.org; Fri, 19 Sep 2014 03:11:56 +0000
Message-ID: <541B9EF7.4030702@roeck-us.net>
Date: Thu, 18 Sep 2014 20:11:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog's pm support preffered implementation
References: <S1751381AbaIDOwq/20140904145246Z+988@vger.kernel.org> <54088996.4040500@elproma.com.pl> <540C9383.9050307@roeck-us.net> <540D02E1.90403@elproma.com.pl> <540D1F8F.2080802@roeck-us.net> <54196BE2.2010800@elproma.com.pl> <541ABD07.5090407@elproma.com.pl> <541B5156.803@elproma.com.pl> <541B5684.7000809@elproma.com.pl>
In-Reply-To: <541B5684.7000809@elproma.com.pl>
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/18/2014 03:02 PM, Janusz U¿ycki wrote:
> Small fix below in the second implementation.
>
> best regards
> Janusz
>
> W dniu 2014-09-18 23:40, Janusz U¿ycki pisze:
>> Hi again,
>>
>> This is the second implementation. Which do you prefer?
>>
This one

>> Subject: [PATCH] stmp3xxx_rtc_wdt: Add suspend/resume PM support
>>
>>
>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
>> ---
>>  drivers/watchdog/stmp3xxx_rtc_wdt.c | 39 +++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>> index 3546f03..1946277 100644
>> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
>> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>> @@ -95,9 +95,48 @@ static int stmp3xxx_wdt_remove(struct platform_device *pdev)
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +/* There is no conflict with rtc/rtc-stmp3xxx.c parent
>> + * because modified registers in PM functions are different */

Coding style, and what does this comment mean ? To me it is just confusing.

>> +static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
>> +{
>> +       struct watchdog_device *wdd = dev_get_drvdata(dev);
>
> drvdata is NULL, too fast,
> +       struct watchdog_device *wdd = &stmp3xxx_wdd;
>
>> +
>> +       /* Is keep-on/ping timer suspended before?
>> +        * or additional driver-specific flag must be added
>> +        *  to block watchdog ping in the timer?
>> +        * or disable WATCHDOG_KEEP_ON before wdt_stop
>> +        *  and restore it in resume? */

You'll have to answer those questions.

>> +       if (watchdog_active(wdd)) {
>> +               dev_info(wdd->dev, "%s: wdt was active\n", __func__);

Does this message add any value ?

>> +               return wdt_stop(wdd);
>> +       }
>> +       /* should we use pm_runtime like omap_wdt.c does? */

Isn't that what you do here ?

>> +
>> +       return 0;
>> +}
>> +
>> +static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)

Does the __maybe_unused really apply ?

>> +{
>> +       struct watchdog_device *wdd = dev_get_drvdata(dev);
> +       struct watchdog_device *wdd = &stmp3xxx_wdd;

One of those lines needs to go.

Do you have indentation problems ? Do you use space for indentations, maybe ?

>
>> +
>> +       if (watchdog_active(wdd)) {
>> +               dev_info(wdd->dev, "%s: wdt was active\n", __func__);

Does this message add any value ?

>> +               return wdt_start(wdd);
>> +       }
>> +
>> +       return 0;
>> +}
>> +#endif /* CONFIG_PM_SLEEP */
>> +
>> +static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
>> +               stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);

Please align second line with (

>> +
>>  static struct platform_driver stmp3xxx_wdt_driver = {
>>         .driver = {
>>                 .name = "stmp3xxx_rtc_wdt",
>> +               .owner = THIS_MODULE,

Is this needed ? I have seen the .owner assignment being removed
in other drivers recently.

>> +               .pm = &stmp3xxx_wdt_pm_ops,
>>         },
>>         .probe = stmp3xxx_wdt_probe,
>>         .remove = stmp3xxx_wdt_remove,
>> --
>> 1.7.11.3
>>
>>
>> W dniu 2014-09-18 13:07, Janusz U¿ycki pisze:
>>>
>>> I work under suspend/resume PM support for stmp3xxx driver.
>>>
>>> Most of them use suspend() with struct platform_device and CONFIG_PM.
>>> Only sp805, sirfsoc, s3c2410, dw drivers use suspend() with struct device
>>> and SIMPLE_DEV_PM_OPS.
>>> Which implementation is preffered today?
>>>
>>> best regards
>>> Janusz
>>>
>>> P.S. Patch on the moment:
>>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
>>> ---
>>>  drivers/watchdog/stmp3xxx_rtc_wdt.c | 41 +++++++++++++++++++++++
>>>  1 file changed, 41 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> index 3546f03..12060ab 100644
>>> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> @@ -74,6 +74,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
>>>  {
>>>         int ret;
>>>
>>> +       platform_set_drvdata(pdev, &stmp3xxx_wdd);
>>>         watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
>>>
>>>         stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, STMP3XXX_MAX_TIMEOUT);
>>> @@ -95,12 +96,52 @@ static int stmp3xxx_wdt_remove(struct platform_device *pdev)
>>>         return 0;
>>>  }
>>>
>>> +#ifdef CONFIG_PM
>>> +/* There is no conflict with rtc/rtc-stmp3xxx.c parent
>>> + * because modified registers in PM functions are different */
>>> +static int stmp3xxx_wdt_suspend(struct platform_device *pdev,
>>> +                                       pm_message_t state)
>>> +{
>>> +       struct watchdog_device *wdd = platform_get_drvdata(pdev);
>>> +
>>> +       /* Is keep-on/ping timer suspended before?
>>> +        * or additional driver-specific flag must be added
>>> +        *  to block watchdog ping in the timer?
>>> +        * or disable WATCHDOG_KEEP_ON before wdt_stop
>>> +        *  and restore it in resume? */
>>> +       if (watchdog_active(wdd)) {
>>> +               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
>>> +               return wdt_stop(wdd);
>>> +       }
>>> +       /* should we use pm_runtime like omap_wdt.c does? */
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int stmp3xxx_wdt_resume(struct platform_device *pdev)
>>> +{
>>> +       struct watchdog_device *wdd = platform_get_drvdata(pdev);
>>> +
>>> +       if (watchdog_active(wdd)) {
>>> +               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
>>> +               return wdt_start(wdd);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +#else
>>> +#define stmp3xxx_wdt_suspend   NULL
>>> +#define stmp3xxx_wdt_resume    NULL
>>> +#endif
>>> +
>>>  static struct platform_driver stmp3xxx_wdt_driver = {
>>>         .driver = {
>>>                 .name = "stmp3xxx_rtc_wdt",
>>>         },
>>>         .probe = stmp3xxx_wdt_probe,
>>>         .remove = stmp3xxx_wdt_remove,
>>> +       .suspend = stmp3xxx_wdt_suspend,
>>> +       .resume = stmp3xxx_wdt_resume,
>>>  };
>>>  module_platform_driver(stmp3xxx_wdt_driver);
>>>
>>
>
>

