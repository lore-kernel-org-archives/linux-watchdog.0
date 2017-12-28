Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37130 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdL1VDi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 16:03:38 -0500
Subject: Re: [PATCH 2/7] watchdog: jz4740: Use devm_* functions
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20171228162939.3928-1-paul@crapouillou.net>
 <20171228162939.3928-3-paul@crapouillou.net>
 <9778afd4-5841-0d48-cde3-c02872623a5f@roeck-us.net>
 <1514491167.6093.0@smtp.crapouillou.net>
 <994187b3-113c-88ef-8ebd-cd57d0c833a0@roeck-us.net>
 <1514492538.6093.1@smtp.crapouillou.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <de7b629e-35b6-a55c-d7ca-57c145fa30ae@roeck-us.net>
Date: Thu, 28 Dec 2017 13:03:35 -0800
MIME-Version: 1.0
In-Reply-To: <1514492538.6093.1@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/28/2017 12:22 PM, Paul Cercueil wrote:
> 
> 
> Le jeu. 28 déc. 2017 à 21:19, Guenter Roeck <linux@roeck-us.net> a écrit :
>> On 12/28/2017 11:59 AM, Paul Cercueil wrote:
>>> Hi Guenter,
>>>
>>> Le jeu. 28 déc. 2017 à 18:48, Guenter Roeck <linux@roeck-us.net> a écrit :
>>>> On 12/28/2017 08:29 AM, Paul Cercueil wrote:
>>>>> - Use devm_clk_get instead of clk_get
>>>>> - Use devm_watchdog_register_device instead of watchdog_register_device
>>>>>
>>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>> ---
>>>>>   drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
>>>>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
>>>>> index 6955deb100ef..92d6ca8ceb49 100644
>>>>> --- a/drivers/watchdog/jz4740_wdt.c
>>>>> +++ b/drivers/watchdog/jz4740_wdt.c
>>>>> @@ -178,40 +178,29 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>>>>>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>       drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>>>>> -    if (IS_ERR(drvdata->base)) {
>>>>> -        ret = PTR_ERR(drvdata->base);
>>>>> -        goto err_out;
>>>>> -    }
>>>>> +    if (IS_ERR(drvdata->base))
>>>>> +        return PTR_ERR(drvdata->base);
>>>>>   -    drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
>>>>> +    drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
>>>>>       if (IS_ERR(drvdata->rtc_clk)) {
>>>>>           dev_err(&pdev->dev, "cannot find RTC clock\n");
>>>>> -        ret = PTR_ERR(drvdata->rtc_clk);
>>>>> -        goto err_out;
>>>>> +        return PTR_ERR(drvdata->rtc_clk);
>>>>>       }
>>>>>   -    ret = watchdog_register_device(&drvdata->wdt);
>>>>> +    ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>>>>>       if (ret < 0)
>>>>> -        goto err_disable_clk;
>>>>> +        return ret;
>>>>>         platform_set_drvdata(pdev, drvdata);
>>>>> -    return 0;
>>>>>   -err_disable_clk:
>>>>> -    clk_put(drvdata->rtc_clk);
>>>>> -err_out:
>>>>> -    return ret;
>>>>> +    return 0;
>>>>>   }
>>>>>     static int jz4740_wdt_remove(struct platform_device *pdev)
>>>>>   {
>>>>>       struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>>>>>   -    jz4740_wdt_stop(&drvdata->wdt);
>>>>> -    watchdog_unregister_device(&drvdata->wdt);
>>>>> -    clk_put(drvdata->rtc_clk);
>>>>> -
>>>>> -    return 0;
>>>>> +    return jz4740_wdt_stop(&drvdata->wdt);
>>>>
>>>> If the watchdog is running, the module can not be unloaded. Even if that wasn't
>>>> the case, this defeats both WDIOF_MAGICCLOSE and watchdog_set_nowayout().
>>>> Are you sure this is what you want ? If so, please call
>>>> watchdog_stop_on_unregister() before registration; this clarifies that this
>>>> is what you want, and you can drop the remove function.
>>>>
>>>> Thanks,
>>>> Guenter
>>>
>>> This patch does not change the behaviour. We always used that driver built-in; what
>>> should the behaviour be when unloading the module? Keep the watchdog hardware running
>>> if configured for 'nowayout'?
>>>
>>
>> One can still unload the driver. If you are fine with bypassing/dfeating nowayout
>> and WDIOF_MAGICCLOSE, may I ask why those are enabled in the first place ?
>>
> 
> Who knows? That code is very old :)

Probably copied from some other driver w/o thinking much about it.

> I'm fine with removing the remove() function completely, if you think it makes more sense.
> 

Yes, I do, but I won't insist on it either.

Thanks,
Guenter
