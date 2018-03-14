Return-Path: <eajames@linux.vnet.ibm.com>
Return-path: <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] watchdog: aspeed: Allow configuring for alternate
 boot
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, wim@linux-watchdog.org,
        Milton Miller <miltonm@us.ibm.com>
References: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1520632700-25800-3-git-send-email-eajames@linux.vnet.ibm.com>
 <20180309220610.GB32606@roeck-us.net>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 14:53:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180309220610.GB32606@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <bab2d3b4-536c-5dcb-4a13-95a29560d416@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>



On 03/09/2018 04:06 PM, Guenter Roeck wrote:
> On Fri, Mar 09, 2018 at 03:58:20PM -0600, Eddie James wrote:
>> From: Milton Miller <miltonm@us.ibm.com>
>>
>> Allow the device tree to specify a watchdog to fallover to
>> the alternate boot source.
>>
>> The aspeeed watchdog can set a latch directing flash chip select 0 to
>> chip select 1, allowing boot from an alternate media if the watchdog
>> is not reset in time.  On the ast2400 bank 1 also goes to flash bank 1,
>> while on the ast2500 the chip selects are swapped.
>>
>> Signed-off-by: Milton Miller <miltonm@us.ibm.com>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> This is already documented in the bindings document, so the property
> should be ok.
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks. On a related note, our system has need of a way to determine if 
it's currently booted from the alternate chip or not. It seems the only 
way to tell is to look at the ast2400/2500 watchdog timeout status 
register. We can add some debugfs to the aspeed driver I guess, but I 
wonder if this is a common enough situation that the watchdog core could 
use some debugfs or sysfs for providing that info?

Thanks,
Eddie

>
>> ---
>>   drivers/watchdog/aspeed_wdt.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>> index d1987d6..f41d246 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -46,6 +46,7 @@ struct aspeed_wdt_config {
>>   #define WDT_RELOAD_VALUE	0x04
>>   #define WDT_RESTART		0x08
>>   #define WDT_CTRL		0x0C
>> +#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
>>   #define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
>>   #define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
>>   #define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
>> @@ -245,6 +246,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>   	}
>>   	if (of_property_read_bool(np, "aspeed,external-signal"))
>>   		wdt->ctrl |= WDT_CTRL_WDT_EXT;
>> +	if (of_property_read_bool(np, "aspeed,alt-boot"))
>> +		wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;
>>   
>>   	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>>   		/*
>> -- 
>> 1.8.3.1
>>
