Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36508 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdBSQx4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 19 Feb 2017 11:53:56 -0500
Subject: Re: [PATCH v2 1/3] watchdog: sama5d4: Cleanup init
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
 <14ea461a-5a95-ca85-1eb3-1c34e382bc48@roeck-us.net>
 <20170217153505.gv4kftvk3z6emmii@piout.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c488ef1f-0ce1-23d7-8105-89efd0f5a769@roeck-us.net>
Date: Sun, 19 Feb 2017 08:53:52 -0800
MIME-Version: 1.0
In-Reply-To: <20170217153505.gv4kftvk3z6emmii@piout.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/17/2017 07:35 AM, Alexandre Belloni wrote:
> On 17/02/2017 at 06:48:36 -0800, Guenter Roeck wrote:
>> On 02/16/2017 11:30 AM, Alexandre Belloni wrote:
>>> .config is used to cache a part of WDT_MR at probe time and is not used
>>> afterwards. Also functions are used while they always return 0. Simplify
>>> the flow by having everything in .probe().
>>>
>>
>> Does that really improve anything ? It makes the code harder to read
>> and, ultimately, the dropped value in sama5d4_wdt is added back in a
>> later patch as 'mr'.
>>
>
> I don't find the current code to be particularly easy to read but maybe
> it is a matter of taste.
>
I always thought it is commonly accepted that splitting code into smaller
functions tends to improve readability. I for my part still think it does,
and splitting out reading configuration data and initializing the chip
are good candidates.

[ Not that the functions are necessarily named well here, but that is
a different issue ]

> I would still remove the test on pdev->dev.of_node because it will never
> be false anyway.
>
Agreed.

Guenter

>
>> Guenter
>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> ---
>>> Changes in v2:
>>>  - completely get rid of .config instead of caching it
>>>  - merge init functions in probe()
>>>
>>>  drivers/watchdog/sama5d4_wdt.c | 92 ++++++++++++++++--------------------------
>>>  1 file changed, 34 insertions(+), 58 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
>>> index a49634cdc1cc..2c6f5a70ae67 100644
>>> --- a/drivers/watchdog/sama5d4_wdt.c
>>> +++ b/drivers/watchdog/sama5d4_wdt.c
>>> @@ -28,7 +28,6 @@
>>>  struct sama5d4_wdt {
>>>  	struct watchdog_device	wdd;
>>>  	void __iomem		*reg_base;
>>> -	u32	config;
>>>  };
>>>
>>>  static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
>>> @@ -128,57 +127,15 @@ static irqreturn_t sama5d4_wdt_irq_handler(int irq, void *dev_id)
>>>  	return IRQ_HANDLED;
>>>  }
>>>
>>> -static int of_sama5d4_wdt_init(struct device_node *np, struct sama5d4_wdt *wdt)
>>> -{
>>> -	const char *tmp;
>>> -
>>> -	wdt->config = AT91_WDT_WDDIS;
>>> -
>>> -	if (!of_property_read_string(np, "atmel,watchdog-type", &tmp) &&
>>> -	    !strcmp(tmp, "software"))
>>> -		wdt->config |= AT91_WDT_WDFIEN;
>>> -	else
>>> -		wdt->config |= AT91_WDT_WDRSTEN;
>>> -
>>> -	if (of_property_read_bool(np, "atmel,idle-halt"))
>>> -		wdt->config |= AT91_WDT_WDIDLEHLT;
>>> -
>>> -	if (of_property_read_bool(np, "atmel,dbg-halt"))
>>> -		wdt->config |= AT91_WDT_WDDBGHLT;
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
>>> -{
>>> -	struct watchdog_device *wdd = &wdt->wdd;
>>> -	u32 value = WDT_SEC2TICKS(wdd->timeout);
>>> -	u32 reg;
>>> -
>>> -	/*
>>> -	 * Because the fields WDV and WDD must not be modified when the WDDIS
>>> -	 * bit is set, so clear the WDDIS bit before writing the WDT_MR.
>>> -	 */
>>> -	reg = wdt_read(wdt, AT91_WDT_MR);
>>> -	reg &= ~AT91_WDT_WDDIS;
>>> -	wdt_write(wdt, AT91_WDT_MR, reg);
>>> -
>>> -	reg = wdt->config;
>>> -	reg |= AT91_WDT_SET_WDD(value);
>>> -	reg |= AT91_WDT_SET_WDV(value);
>>> -
>>> -	wdt_write(wdt, AT91_WDT_MR, reg);
>>> -
>>> -	return 0;
>>> -}
>>> -
>>>  static int sama5d4_wdt_probe(struct platform_device *pdev)
>>>  {
>>>  	struct watchdog_device *wdd;
>>>  	struct sama5d4_wdt *wdt;
>>>  	struct resource *res;
>>>  	void __iomem *regs;
>>> -	u32 irq = 0;
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +	const char *tmp;
>>> +	u32 mr, reg, irq = 0;
>>>  	int ret;
>>>
>>>  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>>> @@ -201,17 +158,26 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>>>
>>>  	wdt->reg_base = regs;
>>>
>>> -	if (pdev->dev.of_node) {
>>> -		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>>> -		if (!irq)
>>> -			dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
>>> +	irq = irq_of_parse_and_map(np, 0);
>>> +	if (!irq)
>>> +		dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
>>>
>>> -		ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
>>> -		if (ret)
>>> -			return ret;
>>> -	}
>>>
>>> -	if ((wdt->config & AT91_WDT_WDFIEN) && irq) {
>>> +	mr = AT91_WDT_WDDIS;
>>> +
>>> +	if (!of_property_read_string(np, "atmel,watchdog-type", &tmp) &&
>>> +	    !strcmp(tmp, "software"))
>>> +		mr |= AT91_WDT_WDFIEN;
>>> +	else
>>> +		mr |= AT91_WDT_WDRSTEN;
>>> +
>>> +	if (of_property_read_bool(np, "atmel,idle-halt"))
>>> +		mr |= AT91_WDT_WDIDLEHLT;
>>> +
>>> +	if (of_property_read_bool(np, "atmel,dbg-halt"))
>>> +		mr |= AT91_WDT_WDDBGHLT;
>>> +
>>> +	if ((mr & AT91_WDT_WDFIEN) && irq) {
>>>  		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
>>>  				       IRQF_SHARED | IRQF_IRQPOLL |
>>>  				       IRQF_NO_SUSPEND, pdev->name, pdev);
>>> @@ -228,9 +194,19 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>>>  		return ret;
>>>  	}
>>>
>>> -	ret = sama5d4_wdt_init(wdt);
>>> -	if (ret)
>>> -		return ret;
>>> +	/*
>>> +	 * WDV and WDD must not be modified when the WDDIS bit is set, so clear
>>> +	 * the WDDIS bit before writing the WDT_MR.
>>> +	 */
>>> +	reg = wdt_read(wdt, AT91_WDT_MR);
>>> +	reg &= ~AT91_WDT_WDDIS;
>>> +	wdt_write(wdt, AT91_WDT_MR, reg);
>>> +
>>> +	reg = mr;
>>> +	reg |= AT91_WDT_SET_WDD(WDT_SEC2TICKS(wdd->timeout));
>>> +	reg |= AT91_WDT_SET_WDV(WDT_SEC2TICKS(wdd->timeout));
>>> +
>>> +	wdt_write(wdt, AT91_WDT_MR, reg);
>>>
>>>  	watchdog_set_nowayout(wdd, nowayout);
>>>
>>>
>>
>

