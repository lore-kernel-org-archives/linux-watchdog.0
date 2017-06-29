Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] drivers/watchdog: Add optional ASPEED device tree
 properties
To: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20170629002811.87199-1-cbostic@linux.vnet.ibm.com>
 <20170629002811.87199-2-cbostic@linux.vnet.ibm.com>
 <b51fedbb-837f-49ea-d050-4c3be82724c5@roeck-us.net>
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 08:39:59 -0500
MIME-Version: 1.0
In-Reply-To: <b51fedbb-837f-49ea-d050-4c3be82724c5@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <21f28ed9-b73a-5c21-5557-bec1fef0d874@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>



On 6/28/17 10:33 PM, Guenter Roeck wrote:
> On 06/28/2017 05:28 PM, Christopher Bostic wrote:
>> Describe device tree optional properties:
>>
>>    * aspeed,arm-reet - ARM CPU reset on signal
>>    * aspeed,no-soc-reset - SOC reset on signal
>>    * aspeed,no-sys-reset - System reset on signal
>>    * aspeed,interrupt - Interrupt CPU on signal
>>    * aspeed,external-signal - Generate external signal (WDT1 and WDT2 
>> only)
>>    * aspeed,alt-boot - Boot from alternate block on signal
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> ---
>> v3 - Invert soc and sys reset to 'no' to preserve backwards
>>       compatibility.  SOC and SYS reset will be set by default
>>       without any optional parameters set
>> v2 - Add 'aspeed,' prefix to all optional properties
>>     - Add arm-reset, soc-reset, interrupt, alt-boot properties
>> ---
>>   .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 24 
>> ++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt 
>> b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> index c5e74d7..6f18005 100644
>> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> @@ -8,9 +8,33 @@ Required properties:
>>    - reg: physical base address of the controller and length of 
>> memory mapped
>>      region
>>   +Optional properties:
>> +   Signal behavior - Whenever a timeout occurs the watchdog can be 
>> programmed
>> +   to generate/not generate 6 types of signals:
>> +
>> + - aspeed,arm-reset:    If property is present then reset ARM CPU only.
>> +            If not specified no ARM CPU reset is done.
>> +
>> + - aspeed,no-soc-reset: If property is present then do not reset SOC.
>> +            If not specified then SOC reset is done.
>> +
>> + - aspeed,no-sys-reset: If property is present then do not reset 
>> system.
>> +            Typcally used in tandem with 'aspeed-external-signal'
>
> Is this correct ? As I understand the datasheet, it could also used in 
> tandem with
> aspeed,interrupt.
True, that should be documented.  Will add that.
>
>> +            If not specified then system reset is done.
>> +
>
> I'll leave it up to Rob to decide, but for my part I don't understand 
> no-soc-reset.
As the aspeed watchdog driver exists prior to this change an SOC reset 
is done by
default.   In order to preserve backwards compatibility a missing 
optional property
should result in default behavior.  I however need to be able to specify 
that SOC
reset be disabled in some way.  This goes back to our discussion about 
why we'd
ever want to disable SYSTEM reset in the first place.  Same reasoning 
applies for
SOC reset.

> I would instead use four properties.
>
>     aspeed,arm-reset
>     aspeed,soc-reset
Per my response above I think it should remain as aspeed,no-soc-reset due to
backwards compatibility requirements.
>     aspeed,sys-reset (which is the default)
Again as per our discussion yesterday I need some way to specify how system
reset is to  be done.  For backwards compatibility, a lack of parameter 
here would
result in a system reset being configured.  Only way to indicate to the 
driver
that no system reset is to be done is to indicate 'no' system reset in 
the optional
parameter.
>     aspeed,no-reset
This parameter seems ambiguous as we could be doing a 'no system reset'
or a 'no SOC reset' in theory.
>
> There should also be a note explaining that the above are mutually 
> exclusive.
>
OK, will add that.

>> + - aspeed,interrupt:    If property is present then interrupt CPU.
>> +            If not specified then don't interrupt CPU.
>> +
>> + - aspeed,external-signal: If property is present then signal is 
>> sent to
>> +            external reset counter (only WDT1 and WDT2). If not
>> +            specified no external signal is sent.
>
> For consistency, either add an empty line here or remove the empty 
> lines above

Will fix.

Thanks,
Chris
>
>> + - aspeed,alt-boot:    If property is present then boot from 
>> alternate block.
>> +
>>   Example:
>>         wdt1: watchdog@1e785000 {
>>           compatible = "aspeed,ast2400-wdt";
>>           reg = <0x1e785000 0x1c>;
>> +        aspeed,no-sys-reset;
>> +        aspeed,external-signal;
>>       };
>>
>
