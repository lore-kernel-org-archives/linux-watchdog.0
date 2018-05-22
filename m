Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40099 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVNsZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 22 May 2018 09:48:25 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so10945202plo.7
        for <linux-watchdog@vger.kernel.org>; Tue, 22 May 2018 06:48:24 -0700 (PDT)
Subject: Re: [PATCH v5] watchdog: da9063: Fix setting/changing timeout
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: wim@linux-watchdog.org, support.opensource@diasemi.com,
        kernel@pengutronix.de, linux-watchdog@vger.kernel.org
References: <20180518163850.5237-1-m.felsch@pengutronix.de>
 <20180518171135.GA9065@roeck-us.net>
 <20180522081820.5vf2fe7gh5lb6foc@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <de1d1962-05ae-aaf0-3e7e-238d0dc7cdc7@roeck-us.net>
Date: Tue, 22 May 2018 06:48:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180522081820.5vf2fe7gh5lb6foc@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/22/2018 01:18 AM, Marco Felsch wrote:
> Hi Guenter,
> 
> On 18-05-18 10:11, Guenter Roeck wrote:
>> On Fri, May 18, 2018 at 06:38:50PM +0200, Marco Felsch wrote:
>>> If the timeout value is set more than once the DA9063 watchdog triggers
>>> a reset signal which reset the system.
>>>
>>> The DA9063 watchdog timeout register field TWDSCALE combines two functions:
>>> setting the timeout value scale and enabling the watchdog. If the
>>> watchdog is enabled we have to disable the watchdog, wait some time due
>>> to a HW issue and set the new timeout value. Setting the new timeout
>>> value reenables the watchdog.
>>>
>>> We have to buffer the timeout value because the DA9063 can't set a
>>> timeout without enabling the watchdog (as described above). The buffered
>>> value will then set by the next wdt_start() call.
>>>
>>> The patch is based on Philipp Zabel's previous patch.
>>>
>>> Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>>   drivers/watchdog/da9063_wdt.c | 54 ++++++++++++++++++++++++++++++-----
>>>   1 file changed, 47 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
>>> index b17ac1bb1f28..1e2ecb76dcb1 100644
>>> --- a/drivers/watchdog/da9063_wdt.c
>>> +++ b/drivers/watchdog/da9063_wdt.c
>>> @@ -45,10 +45,51 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
>>>   	return DA9063_TWDSCALE_MAX;
>>>   }
>>>   
>>> -static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
>>> +/*
>>> + * Writing a '1' to the self-clearing WATCHDOG bit resets the watchdog counter
>>> + * value.
>>> + */
>>> +static int _da9063_wdt_reset_timer(struct da9063 *da9063)
>>> +{
>>> +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
>>> +			    DA9063_WATCHDOG);
>>> +}
>>> +
>>> +static int da9063_wdt_stop(struct watchdog_device *wdd);
>>> +static int
>>> +_da9063_wdt_set_timeout(struct watchdog_device *wdd, unsigned int regval)
>>>   {
>>> -	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>>> -				  DA9063_TWDSCALE_MASK, regval);
>>> +	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
>>> +	int ret = 0;
>>> +
>>> +	/*
>>> +	 * The watchdog triggers a reboot if a timeout value is already
>>> +	 * programmed because the timeout value combines two functions
>>> +	 * in one: indicating the counter limit and starting the watchdog.
>>> +	 * The watchdog must be disabled to be able to change the timeout
>>> +	 * value if the watchdog is already running. Then we can set the
>>> +	 * new timeout value which enables the watchdog again.
>>> +	 *
>>> +	 * We have to cache the timeout value since we can't update the value
>>> +	 * without enabling the watchdog. This case may happen if the watchdog
>>> +	 * is disabled and we only want to update the timeout value.
>>> +	 */
>>> +
>>> +	if (watchdog_hw_running(wdd)) {
>>> +		/* Don't try to update the value if disabling fails */
>>> +		ret = da9063_wdt_stop(wdd);
>>> +		if (ret)
>>> +			goto out;
>>> +
>>> +		usleep_range(150, 300);
>>> +
>>> +		ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>>> +					 DA9063_TWDSCALE_MASK, regval);
>>> +	}
>>> +
>>> +	wdd->timeout = regval;
>>
>> Sorry, this is public (ie reported back to userspace) and has to be in
>> seconds, and is already set in da9063_wdt_set_timeout(). If you want to
>> cache the to-be-written register value, you will indeed have to do that
>> locally.
>>
>> Guenter
> 
> Yes I saw it to late. However, should I buffer the value a second time?
> In my v6 I made the following changes to avoid enabling the wdt during
> updating the timeout if the watchdog is off.
> 

I did not say you _should_ cache it twice; if anything, you would cache
the register value.

> da9063_wdt_set_timeout() {
>    [...]
>    ret = 0;
> 
>    selector = da9063_wdt_timeout_to_sel(timeout);
> 
>    if (watchdog_hw_running(wdd))
> 	  ret = da9063_wdt_update_timeout();
>    
>    if (ret)
> 	  dev_err();
>    else
> 	  wdd->timeout = wdt_timeout[selector];

I would use this approach, though I would drop the dev_err() since 1) I am
not a friend of noisy kernel drivers and 2) the error is reported to user space.

In general, problems like this tend to be persistent, and this is one of the
kernel drivers which will fill the log with noise if/when that happens.

Guenter

> }
> 
> Note: I renamed the _da9063_wdt_set_timeout() to
> da9063_wdt_update_timeout() in a separate patch. Anyway, this way we
> store/buffer the timeout value if the watchdog is off and can be set
> later by da9063_wdt_start(). If the watchdog is enabled we update the
> timeout immediately.
> 
> Is that okay?
> 
> Regards,
> Marco
> 
>>> +out:
>>> +	return ret;
>>>   }
>>>   
>>>   static int da9063_wdt_start(struct watchdog_device *wdd)
>>> @@ -58,7 +99,7 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
>>>   	int ret;
>>>   
>>>   	selector = da9063_wdt_timeout_to_sel(wdd->timeout);
>>> -	ret = _da9063_wdt_set_timeout(da9063, selector);
>>> +	ret = _da9063_wdt_set_timeout(wdd, selector);
>>>   	if (ret)
>>>   		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
>>>   			ret);
>>> @@ -85,8 +126,7 @@ static int da9063_wdt_ping(struct watchdog_device *wdd)
>>>   	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
>>>   	int ret;
>>>   
>>> -	ret = regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
>>> -			   DA9063_WATCHDOG);
>>> +	ret = _da9063_wdt_reset_timer(da9063);
>>>   	if (ret)
>>>   		dev_alert(da9063->dev, "Failed to ping the watchdog (err = %d)\n",
>>>   			  ret);
>>> @@ -102,7 +142,7 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
>>>   	int ret;
>>>   
>>>   	selector = da9063_wdt_timeout_to_sel(timeout);
>>> -	ret = _da9063_wdt_set_timeout(da9063, selector);
>>> +	ret = _da9063_wdt_set_timeout(wdd, selector);
>>>   	if (ret)
>>>   		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
>>>   			ret);
>>> -- 
>>> 2.17.0
>>>
>>
>>
> 

