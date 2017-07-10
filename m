Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
Subject: Re: [v4, 1/2] drivers/watchdog: Add optional ASPEED device tree
 properties
To: Guenter Roeck <linux@roeck-us.net>
References: <20170707004901.26780-2-cbostic@linux.vnet.ibm.com>
 <20170708145907.GA19078@roeck-us.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, wim@iguana.be, robh+dt@kernel.org
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Mon, 10 Jul 2017 10:07:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170708145907.GA19078@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <61225254-6b6c-672f-23f8-b7c9f24aa46e@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>



On 7/8/17 9:59 AM, Guenter Roeck wrote:
> On Thu, Jul 06, 2017 at 07:48:59PM -0500, Christopher Bostic wrote:
>> Describe device tree optional properties:
>>
>>    * aspeed,reset-type = "cpu|soc|system|none"
>>       One of three different, mutually exclusive, values
>>
>> 	"cpu" : ARM CPU reset on signal
>> 	"soc" : 'System on chip' reset
>> 	"system" : Full system reset
>>
>>       The value can also be set to "none" which indicates that no
>>       reset of any kind is to be done via this watchdog.  This assumes
>>       another watchdog on the chip is to take care of resets.
>>
>>    * aspeed,interrupt - Interrupt CPU on signal
> After thinking about that, I wonder if this is necessary. It could be
> implied by providing an interrupt to the driver. The driver could then
> set the interrupt configuration bit automatically.
>
> [ And the bit by itself doesn't really make sense if the driver doesn't
>    also register an interrupt handler ]

The 'aspeed,interrupt' property was added for the sake of documenting 
all potential hardware configurations.  There is no plan as of now to 
enable this so I'm inclined to just remove this part from the 
documentation.  When and if this function is ever used the optional 
property can be documented at that time.

Thanks,
Chris

>>    * aspeed,external-signal - Generate external signal (WDT1 and WDT2 only)
>>    * aspeed,alt-boot - Boot from alternate block on signal
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> ---
>> v4 - Add aspeed-reset-type and assign one of four values,
>>       cpu, soc, system, none.
>> v3 - Invert soc and sys reset to 'no' to preserve backwards
>>       compatibility.  SOC and SYS reset will be set by default
>>       without any optional parameters set
>> v2 - Add 'aspeed,' prefix to all optional properties
>>     - Add arm-reset, soc-reset, interrupt, alt-boot properties
>> ---
>>   .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 35 ++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> index c5e74d7..f526b00 100644
>> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> @@ -8,9 +8,44 @@ Required properties:
>>    - reg: physical base address of the controller and length of memory mapped
>>      region
>>   
>> +Optional properties:
>> +
>> + - aspeed,reset-type = "cpu|soc|system|none"
>> +
>> +   Reset behavior - Whenever a timeout occurs the watchdog can be programmed
>> +   to generate one of three different, mutually exclusive, types of resets.
>> +
>> +   Type "none" can be specified to indicate that no resets are to be done.
>> +   This is useful in situations where another watchdog engine on chip is
>> +   to perform the reset.
>> +
>> +   If 'aspeed,reset-type=' is not specfied the default is to enable system
>> +   reset.
>> +
>> +   Reset types:
>> +
>> +        - cpu: Reset CPU on watchdog timeout
>> +
>> +        - soc: Reset 'System on Chip' on watchdog timeout
>> +
>> +        - system: Reset system on watchdog timeout
>> +
>> +        - none: No reset is performed on timeout. Assumes another watchdog
>> +                engine is responsible for this.
>> +
>> + - aspeed,interrupt:	If property is present then interrupt CPU.
>> +			If not specified then don't interrupt CPU.
>> +
>> + - aspeed,external-signal: If property is present then signal is sent to
>> +			external reset counter (only WDT1 and WDT2). If not
>> +			specified no external signal is sent.
>> + - aspeed,alt-boot:    If property is present then boot from alternate block.
>> +
>>   Example:
>>   
>>   	wdt1: watchdog@1e785000 {
>>   		compatible = "aspeed,ast2400-wdt";
>>   		reg = <0x1e785000 0x1c>;
>> +		aspeed,reset-type = "system";
>> +		aspeed,external-signal;
>>   	};
