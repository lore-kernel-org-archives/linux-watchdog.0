Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33220 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032407AbeEZXLt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 26 May 2018 19:11:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id a20-v6so4173287pfo.0
        for <linux-watchdog@vger.kernel.org>; Sat, 26 May 2018 16:11:49 -0700 (PDT)
Subject: Re: [PATCH v8 3/4] watchdog: da9063: Fix timeout handling during
 probe
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: wim@linux-watchdog.org, support.opensource@diasemi.com,
        kernel@pengutronix.de, linux-watchdog@vger.kernel.org
References: <20180524115101.17097-1-m.felsch@pengutronix.de>
 <20180524115101.17097-4-m.felsch@pengutronix.de>
 <20180524180744.GA13327@roeck-us.net>
 <20180525064454.x3yn2eq4xuxvdtza@pengutronix.de>
 <03553172-0d10-013e-5809-55d490dff8e5@roeck-us.net>
 <20180525130934.zimcqmdtpkijlz4r@pengutronix.de>
 <62e8397e-bb92-d0b9-04e5-ebb1838d1af9@roeck-us.net>
 <20180525214157.GA12107@pengutronix.de> <20180525224230.GA4632@roeck-us.net>
 <20180526173934.GA12799@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a47d1a46-8675-5db3-b142-05ce16c78848@roeck-us.net>
Date: Sat, 26 May 2018 16:11:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180526173934.GA12799@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2018 10:39 AM, Marco Felsch wrote:

>>>>> We can't move it to the _da9063_wdt_set_timeout() because the
>>>>> da9063_wdt_set_timeout() uses the mapped timeouts later:
>>>>>
>>>>> static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
>>>>>                                     unsigned int timeout)
>>>>> {
>>>>> 	[ ... ]
>>>>>           else
>>>>> 		wdd->timeout = wdt_timeout[selector];
>>>>>
>>>>> 	return ret;
>>>>>
>>>>> }
>>>>>
>>>> 	...
>>>> 	if (ret)
>>>> 		return ret;
>>>>
>>>>          wdd->timeout = wdt_timeout[da9063_wdt_timeout_to_sel(timeout)];
>>>> 	return 0;
>>>>
>>>> Guenter
>>>
>>> Sorry, I tought da9063_wdt_timeout_to_sel() should get called only within
>>> _da9063_wdt_set_timeout().
>>>
>> Well, you _could_ have _da9063_wdt_set_timeout() return either a negative
>> error code or the actually selected timeout. Just an idea.
> 
> Yes, I've tought about this approach too. Anyway, is it okay to split
> the series into a "fixes" series and a "improvment" series? I think we

Yes

> losing sight of the initial problem "Change the timeout value more than
> once." A next improvment could be to squash the da9062/1 and da9063 into
> one if this is possible.
> 
Sure. Next step, though.

Thanks,
Guenter
