Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] drivers/watchdog: ASPEED reference dev tree
 properties for config
To: Guenter Roeck <linux@roeck-us.net>
References: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
 <20170627211734.60477-3-cbostic@linux.vnet.ibm.com>
 <606a2e11-2d43-5204-0bb6-9c4415ee03df@roeck-us.net>
 <de0dc054-0813-fab1-d7ac-2f1d7ba61fd8@linux.vnet.ibm.com>
 <20170628145452.GA30968@roeck-us.net>
 <38e57720-9728-9377-2a16-adc8ce430ca0@linux.vnet.ibm.com>
 <20170628150846.GE30968@roeck-us.net>
Cc: "wim@iguana.be; openbmc"@lists.ozlabs.org, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 10:55:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170628150846.GE30968@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <b6c53add-c165-3678-dfed-cb6f1798accc@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>



On 6/28/17 10:08 AM, Guenter Roeck wrote:
> On Wed, Jun 28, 2017 at 09:59:22AM -0500, Christopher Bostic wrote:
>>
>> On 6/28/17 9:54 AM, Guenter Roeck wrote:
>>> On Wed, Jun 28, 2017 at 09:29:50AM -0500, Christopher Bostic wrote:
>>>> On 6/28/17 6:31 AM, Guenter Roeck wrote:
>>>>> On 06/27/2017 02:17 PM, Christopher Bostic wrote:
>>>>>> Reference the system device tree when configuring the watchdog
>>>>>> engines.  Set external signal mode on timeout if specified.
>>>>>> Set system reset on timeout if specified.
>>>>>>
>>>>>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>>>>>> ---
>>>>>> v2 - Change of_get_property() to of_property_read_bool()
>>>>>>     - Remove redundant check for NULL struct device_node pointer
>>>>>>     - Optional property names now start with prefix 'aspeed,'
>>>>>> ---
>>>>>>   drivers/watchdog/aspeed_wdt.c | 13 +++++++++++--
>>>>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/watchdog/aspeed_wdt.c
>>>>>> b/drivers/watchdog/aspeed_wdt.c
>>>>>> index 1c65258..71ce5f5 100644
>>>>>> --- a/drivers/watchdog/aspeed_wdt.c
>>>>>> +++ b/drivers/watchdog/aspeed_wdt.c
>>>>>> @@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct platform_device
>>>>>> *pdev)
>>>>>>   {
>>>>>>       struct aspeed_wdt *wdt;
>>>>>>       struct resource *res;
>>>>>> +    struct device_node *np;
>>>>>>       int ret;
>>>>>>         wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>>>>>> @@ -170,8 +171,16 @@ static int aspeed_wdt_probe(struct platform_device
>>>>>> *pdev)
>>>>>>        * the SOC and not the full chip
>>>>>>        */
>>>>>>       wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
>>>>>> -        WDT_CTRL_1MHZ_CLK |
>>>>>> -        WDT_CTRL_RESET_SYSTEM;
>>>>>> +        WDT_CTRL_1MHZ_CLK;
>>>>>> +
>>>>>> +    np = pdev->dev.of_node;
>>>>>> +    if (of_property_read_bool(np, "aspeed,sys-reset"))
>>>>>> +        wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
>>>>>> +
>>>>> For backward compatibility, this should default to WDT_CTRL_RESET_SYSTEM
>>>>> if no optional property is provided.
>>>>>
>>>> I had the logic inverted for this property in a previous patch.  The
>>>> property was 'no-system-reset' so that when not present the default was to
>>>> set WDT_CTRL_RESET_SYSTEM.   As it is in this patch, the only way to
>>>> indicate that no system reset is to be done is to not specify the property.
>>>> No system reset is desired under circumstances when another wdt engine is to
>>>> be responsible for this.   Given the issue with backward compatibility
>>>> that's not a solution.  Given this, would creating a property
>>>> 'no-system-reset' be acceptable?
>>>>
>>> Sorry, I fail to see the problem. There are half a dozen properties. What is the
>>> problem with having a default if no property is specified ? Your default is "do
>>> nothing", which does not really make any sense to me. If the user wants the
>>> watchdog to do nothing, the simple means to accomplish that would be to not
>>> instantiate it.
>>>
>>> Sure, that means specifying "system-reset" is redundant, but I don't see a
>>> problem with that either. But I do see a problem with loading a watchdog driver
>>> that doesn't do anything.
>>>
>>> If there is really some use case where it makes sense to load a watchdog driver
>>> and have it do nothing, please explain and provide a respective devicetree
>>> property. "aspeed,do-nothing" (or whatever similar) doesn't sound good, but
>>> at least makes it obvious that the driver isn't doing anything besides
>>> creating a false sense of "the system is watchdog protected".
>> If system-reset is not wanted there are other properties that might still be
>> needed, for example
>> ARM reset only.   We'd still want to instantiate it.
>>
> But then you would presumably specify that property, so there would be one.
> The question here is what to do if _no_ property is provided.
I agree that the default should be to perform a system reset  when no 
property is provided.  I will make that change.   Additionally for 
backwards compatibility the SOC reset should be enabled by default when 
no property is provided.   The other parameters are not configured in 
the watchdog control register if no property is provided.

There is still a need to to configure for no system reset.  For example, 
optional parameter 'aspeed,no-sys-reset' that can be specified if system 
reset is to be disabled.  In addition the default 'SOC reset enabled' 
behavior could be disabled with an optional parameter 'aspeed,no-soc-reset'.

Why would there even be a need configure for no system reset?  The 
external mode 'wdt ext: External signal enable after timeout' can be 
sent off chip even if system reset is disabled.  The watchdog is doing 
something in this case and would require wdt instantiation.

Hope this is more clear, sorry for the confusion.

Thanks,
-Chris AST2500 Software Programming Guide
> Sorry, I don't get your point.
>
> Guenter
>
>> Thanks,
>> Chris
>>> Thanks,
>>> Guenter
>>>
>>>
>>>> Thanks,
>>>> Chris
>>>>
>>>>>> +    if (of_property_read_bool(np, "aspeed,external-signal"))
>>>>>> +        wdt->ctrl |= WDT_CTRL_WDT_EXT;
>>>>>> +
>>>>>> +    writel(wdt->ctrl, wdt->base + WDT_CTRL);
>>>>>>         if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>>>>>>           aspeed_wdt_start(&wdt->wdd);
>>>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
