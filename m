Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44347 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964806AbeEYIuK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 25 May 2018 04:50:10 -0400
Received: by mail-oi0-f66.google.com with SMTP id e80-v6so3926599oig.11
        for <linux-watchdog@vger.kernel.org>; Fri, 25 May 2018 01:50:10 -0700 (PDT)
Subject: Re: [PATCH v8 3/4] watchdog: da9063: Fix timeout handling during
 probe
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: wim@linux-watchdog.org, support.opensource@diasemi.com,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de
References: <20180524115101.17097-1-m.felsch@pengutronix.de>
 <20180524115101.17097-4-m.felsch@pengutronix.de>
 <20180524180744.GA13327@roeck-us.net>
 <20180525064454.x3yn2eq4xuxvdtza@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <03553172-0d10-013e-5809-55d490dff8e5@roeck-us.net>
Date: Fri, 25 May 2018 01:50:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180525064454.x3yn2eq4xuxvdtza@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/24/2018 11:44 PM, Marco Felsch wrote:
> On 18-05-24 11:07, Guenter Roeck wrote:
>> On Thu, May 24, 2018 at 01:51:00PM +0200, Marco Felsch wrote:
>>> The watchdog can be enabled in previous steps (e.g. the bootloader). Check
>>> if the watchdog is already running, retrieve the set timeout value and
>>> set it again to set the new timeout reference mark.
>>>
>>> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>>   drivers/watchdog/da9063_wdt.c | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
>>> index 6b0092b7d5a6..c5bd5ffe8ded 100644
>>> --- a/drivers/watchdog/da9063_wdt.c
>>> +++ b/drivers/watchdog/da9063_wdt.c
>>> @@ -45,6 +45,18 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
>>>   	return DA9063_TWDSCALE_MAX;
>>>   }
>>>   
>>> +/*
>>> + * Return 0 if watchdog is disabled, else non zero.
>>> + */
>>> +static unsigned int da9063_wdt_is_running(struct da9063 *da9063)
>>> +{
>>> +	unsigned int val;
>>> +
>>> +	regmap_read(da9063->regmap, DA9063_REG_CONTROL_D, &val);
>>> +
>>> +	return val & DA9063_TWDSCALE_MASK;
>>> +}
>>> +
>>>   static int da9063_wdt_disable_timer(struct da9063 *da9063)
>>>   {
>>>   	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>>> @@ -180,6 +192,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
>>>   {
>>>   	struct da9063 *da9063;
>>>   	struct watchdog_device *wdd;
>>> +	unsigned int cur_timeout;
>>>   
>>>   	if (!pdev->dev.parent)
>>>   		return -EINVAL;
>>> @@ -206,6 +219,12 @@ static int da9063_wdt_probe(struct platform_device *pdev)
>>>   
>>>   	watchdog_set_drvdata(wdd, da9063);
>>>   
>>> +	cur_timeout = da9063_wdt_is_running(da9063);
>>> +	if (cur_timeout) {
>>> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
>>> +		_da9063_wdt_set_timeout(da9063, cur_timeout);
>>
>> Sorry, I should have been more specific. That doesn't make sense as written
>> since it just sets the same timeout as before. You would have to replace
>> the second argument with the desired timeout in seconds, and call
>> da9063_wdt_timeout_to_sel() in _da9063_wdt_set_timeout(). That would
>> actually make sense since all callers of _da9063_wdt_set_timeout()
>> do that anyway before the call.
> 
> That's the reason why I used da9063_wdt_set_timeout() in v6 because in
> v6 da9063_wdt_is_running() has returned the mapped timeout in seconds.
> 
> However, I'm with you to move da9063_wdt_timeout_to_sel() to
> _da9063_wdt_set_timeout(). Should that happen in a seperate patch?
> 
Yes, that would be better.

> Yes it sets the same timeout as before but I didn't want change the timeout
> value without the user knowledge. Should I rather use the ping()
> function or is it okay to change the timeout value to a different value
> as set before by the bootloader?
> 

I thought that changing the timeout to the configured or default value was
the idea.

Guenter

> Marco
>>
>> Guenter
>>
>>> +	}
>>> +
>>>   	return devm_watchdog_register_device(&pdev->dev, wdd);
>>>   }
>>>   
>>> -- 
>>> 2.17.0
>>>
>>
> 

