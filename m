Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39777 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbeGPOkI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jul 2018 10:40:08 -0400
Subject: Re: watchdog: davinci_wdt: add possibility to configure watchdog
 period
To: Michele Dionisio <michele.dionisio@gmail.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michele Dionisio <michele.dionisio@powersoft.com>
References: <20180716121909.4869-1-michele.dionisio@gmail.com>
 <20180716121909.4869-2-michele.dionisio@gmail.com>
 <6803158b-27b2-63ae-1720-72d9da78df1f@roeck-us.net>
 <CAFwEtmq1f6fSe0cyXeQrGjh-5O9p+DmYDp=LmKt=tNYYzNK9SQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0252e19a-acd8-90c5-85cf-4363f752d616@roeck-us.net>
Date: Mon, 16 Jul 2018 07:12:27 -0700
MIME-Version: 1.0
In-Reply-To: <CAFwEtmq1f6fSe0cyXeQrGjh-5O9p+DmYDp=LmKt=tNYYzNK9SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/16/2018 07:04 AM, Michele Dionisio wrote:
> I have done what are already done in:
> omap_wdt.c with parameter timer_margin
> softdog.c with parameter softMargin
> ...
> 
> the same feature is missing in davinci_wdt and I think is quite usefull.
> 
> if you NACK because I don't use watchdog_init_timeout I can rewrite
> the code but I do that to reduce the number of changes done in one
> commit

Did you read my comment ? Did you try to use the existing "heartbeat"
module parameter ?

If that doesn't work for some reason, lets fix it. Introducing another
module parameter with a different name because the first one doesn't work
simply does not make sense.

Guenter

> Il giorno lun 16 lug 2018 alle ore 15:31 Guenter Roeck
> <linux@roeck-us.net> ha scritto:
>>
>> On 07/16/2018 05:19 AM, michele.dionisio@gmail.com wrote:
>>> From: Michele Dionisio <michele.dionisio@powersoft.com>
>>>
>>> It is not possible to implement setting of watchdog period because it is
>>> not possible to stop watchdog so it is nice to have possibility to
>>> configure watchdog period at module loading.
>>>
>>> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
>>>
>>> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
>>> index 6c6594261cb7..5f95afa20fee 100644
>>> --- a/drivers/watchdog/davinci_wdt.c
>>> +++ b/drivers/watchdog/davinci_wdt.c
>>> @@ -54,6 +54,10 @@
>>>    #define WDKEY_SEQ0          (0xa5c6 << 16)
>>>    #define WDKEY_SEQ1          (0xda7e << 16)
>>>
>>> +static unsigned int init_timeout;
>>> +module_param(init_timeout, uint, 0);
>>> +MODULE_PARM_DESC(init_timeout, "initial watchdog timeout (in seconds)");
>>> +
>>>    static int heartbeat;
>>>
>>>    /*
>>> @@ -223,8 +227,10 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>>>        wdd->ops                = &davinci_wdt_ops;
>>>        wdd->min_timeout        = 1;
>>>        wdd->max_timeout        = MAX_HEARTBEAT;
>>> -     wdd->timeout            = DEFAULT_HEARTBEAT;
>>> -     wdd->parent             = &pdev->dev;
>>> +     if ((init_timeout >= 1) && (init_timeout <= MAX_HEARTBEAT))
>>> +             wdd->timeout = init_timeout;
>>> +     else
>>> +             wdd->timeout = DEFAULT_HEARTBEAT;
>>>
>>>        watchdog_init_timeout(wdd, heartbeat, dev);
>>>
>>
>> NACK. This is done with the 'heartbeat' module parameter already.
>>
>> Guenter
>>
>>
> 

