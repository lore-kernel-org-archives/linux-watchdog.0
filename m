Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] drivers/watchdog: ASPEED reference dev tree
 properties for config
To: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
 <20170627211734.60477-3-cbostic@linux.vnet.ibm.com>
 <606a2e11-2d43-5204-0bb6-9c4415ee03df@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 09:29:50 -0500
MIME-Version: 1.0
In-Reply-To: <606a2e11-2d43-5204-0bb6-9c4415ee03df@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <de0dc054-0813-fab1-d7ac-2f1d7ba61fd8@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>



On 6/28/17 6:31 AM, Guenter Roeck wrote:
> On 06/27/2017 02:17 PM, Christopher Bostic wrote:
>> Reference the system device tree when configuring the watchdog
>> engines.  Set external signal mode on timeout if specified.
>> Set system reset on timeout if specified.
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> ---
>> v2 - Change of_get_property() to of_property_read_bool()
>>     - Remove redundant check for NULL struct device_node pointer
>>     - Optional property names now start with prefix 'aspeed,'
>> ---
>>   drivers/watchdog/aspeed_wdt.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c 
>> b/drivers/watchdog/aspeed_wdt.c
>> index 1c65258..71ce5f5 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct 
>> platform_device *pdev)
>>   {
>>       struct aspeed_wdt *wdt;
>>       struct resource *res;
>> +    struct device_node *np;
>>       int ret;
>>         wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> @@ -170,8 +171,16 @@ static int aspeed_wdt_probe(struct 
>> platform_device *pdev)
>>        * the SOC and not the full chip
>>        */
>>       wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
>> -        WDT_CTRL_1MHZ_CLK |
>> -        WDT_CTRL_RESET_SYSTEM;
>> +        WDT_CTRL_1MHZ_CLK;
>> +
>> +    np = pdev->dev.of_node;
>> +    if (of_property_read_bool(np, "aspeed,sys-reset"))
>> +        wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
>> +
>
> For backward compatibility, this should default to WDT_CTRL_RESET_SYSTEM
> if no optional property is provided.
>
I had the logic inverted for this property in a previous patch.  The 
property was 'no-system-reset' so that when not present the default was 
to set WDT_CTRL_RESET_SYSTEM.   As it is in this patch, the only way to 
indicate that no system reset is to be done is to not specify the 
property.  No system reset is desired under circumstances when another 
wdt engine is to be responsible for this.   Given the issue with 
backward compatibility that's not a solution.  Given this, would 
creating a property 'no-system-reset' be acceptable?

Thanks,
Chris

>> +    if (of_property_read_bool(np, "aspeed,external-signal"))
>> +        wdt->ctrl |= WDT_CTRL_WDT_EXT;
>> +
>> +    writel(wdt->ctrl, wdt->base + WDT_CTRL);
>>         if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>>           aspeed_wdt_start(&wdt->wdd);
>>
>
