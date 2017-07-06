Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] drivers/watchdog: Add optional ASPEED device tree
 properties
To: Guenter Roeck <linux@roeck-us.net>
References: <20170629002811.87199-1-cbostic@linux.vnet.ibm.com>
 <20170629002811.87199-2-cbostic@linux.vnet.ibm.com>
 <b51fedbb-837f-49ea-d050-4c3be82724c5@roeck-us.net>
 <21f28ed9-b73a-5c21-5557-bec1fef0d874@linux.vnet.ibm.com>
 <20170629150417.GA10226@roeck-us.net>
 <20170706143512.bmjv2gnoqp5ew4py@rob-hp-laptop>
 <e36ab090-865c-f4d4-6173-1485f77c5d31@linux.vnet.ibm.com>
 <20170706204850.GA20079@roeck-us.net>
Cc: mark.rutland@arm.com, Rob Herring <robh@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, wim@iguana.be
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Thu, 6 Jul 2017 18:32:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170706204850.GA20079@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <e90bdd25-4213-70f6-b72f-b3f75d46a4df@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>



On 7/6/17 3:48 PM, Guenter Roeck wrote:
> On Thu, Jul 06, 2017 at 02:27:18PM -0500, Christopher Bostic wrote:
>>
>> On 7/6/17 9:35 AM, Rob Herring wrote:
>>> On Thu, Jun 29, 2017 at 08:04:17AM -0700, Guenter Roeck wrote:
>>>> On Thu, Jun 29, 2017 at 08:39:59AM -0500, Christopher Bostic wrote:
>>>>> On 6/28/17 10:33 PM, Guenter Roeck wrote:
>>>>>> On 06/28/2017 05:28 PM, Christopher Bostic wrote:
>>>>>>> Describe device tree optional properties:
>>>>>>>
>>>>>>>    * aspeed,arm-reet - ARM CPU reset on signal
>>>>>>>    * aspeed,no-soc-reset - SOC reset on signal
>>>>>>>    * aspeed,no-sys-reset - System reset on signal
>>>>>>>    * aspeed,interrupt - Interrupt CPU on signal
>>>>>>>    * aspeed,external-signal - Generate external signal (WDT1 and WDT2
>>>>>>> only)
>>>>>>>    * aspeed,alt-boot - Boot from alternate block on signal
>>>>>>>
>>>>>>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>>>>>>> ---
>>>>>>> v3 - Invert soc and sys reset to 'no' to preserve backwards
>>>>>>>       compatibility.  SOC and SYS reset will be set by default
>>>>>>>       without any optional parameters set
>>>>>>> v2 - Add 'aspeed,' prefix to all optional properties
>>>>>>>     - Add arm-reset, soc-reset, interrupt, alt-boot properties
>>>>>>> ---
>>>>>>>   .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 24
>>>>>>> ++++++++++++++++++++++
>>>>>>>   1 file changed, 24 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>>>>>>> b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>>>>>>> index c5e74d7..6f18005 100644
>>>>>>> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>>>>>>> @@ -8,9 +8,33 @@ Required properties:
>>>>>>>    - reg: physical base address of the controller and length of memory
>>>>>>> mapped
>>>>>>>      region
>>>>>>>   +Optional properties:
>>>>>>> +   Signal behavior - Whenever a timeout occurs the watchdog can be
>>>>>>> programmed
>>>>>>> +   to generate/not generate 6 types of signals:
>>>>>>> +
>>>>>>> + - aspeed,arm-reset:    If property is present then reset ARM CPU only.
>>>>>>> +            If not specified no ARM CPU reset is done.
>>>>>>> +
>>>>>>> + - aspeed,no-soc-reset: If property is present then do not reset SOC.
>>>>>>> +            If not specified then SOC reset is done.
>>>>>>> +
>>>>>>> + - aspeed,no-sys-reset: If property is present then do not reset
>>>>>>> system.
>>>>>>> +            Typcally used in tandem with 'aspeed-external-signal'
>>>>>> Is this correct ? As I understand the datasheet, it could also used in
>>>>>> tandem with
>>>>>> aspeed,interrupt.
>>>>> True, that should be documented.  Will add that.
>>>>>>> +            If not specified then system reset is done.
>>>>>>> +
>>>>>> I'll leave it up to Rob to decide, but for my part I don't understand
>>>>>> no-soc-reset.
>>>>> As the aspeed watchdog driver exists prior to this change an SOC reset is
>>>>> done by
>>>>> default.   In order to preserve backwards compatibility a missing optional
>>>>> property
>>>>> should result in default behavior.  I however need to be able to specify
>>>>> that SOC
>>>>> reset be disabled in some way.  This goes back to our discussion about why
>>>>> we'd
>>>>> ever want to disable SYSTEM reset in the first place.  Same reasoning
>>>>> applies for
>>>>> SOC reset.
>>>>>
>>>>>> I would instead use four properties.
>>>>>>
>>>>>>     aspeed,arm-reset
>>>>>>     aspeed,soc-reset
>>>>> Per my response above I think it should remain as aspeed,no-soc-reset due to
>>>>> backwards compatibility requirements.
>>>> The same can be accomplished with "aspeed,no-reset", which would avoid the, in
>>>> my opinion, awkward "no-{sys,soc}-reset" poperties.
>>>>
>>>>>>     aspeed,sys-reset (which is the default)
>>>>> Again as per our discussion yesterday I need some way to specify how system
>>>>> reset is to  be done.  For backwards compatibility, a lack of parameter here
>>>>> would
>>>>> result in a system reset being configured.  Only way to indicate to the
>>>>> driver
>>>>> that no system reset is to be done is to indicate 'no' system reset in the
>>>>> optional
>>>>> parameter.
>>>> Or "aspeed,no-reset".
>>>>
>>>>>>     aspeed,no-reset
>>>>> This parameter seems ambiguous as we could be doing a 'no system reset'
>>>>> or a 'no SOC reset' in theory.
>>>> {arm,soc,sys}-reset are mutually exclusive per datasheet, and there is a
>>>> separate configuration bit which enables the reset in the first place.
>>>> I don't see how that is ambiguous.
>>>>
>>>> Anyway, I don't think we are making any progress here. Let's wait for
>>>> guidance from Rob.
>>> I tend to agree with Guenter.
>>>
>>> Maybe using the form 'aspeed,reset-type = "cpu|soc|system"' would be
>>> more aligned to the type of reset being mutually exclusive.
>> OK I'll update to this method.
>>
> Maybe add 'aspeed,reset-type = "none"' ? The default (no property) would
> then be "system".

That's what I was thinking -will do that.

Thanks,
Chris
>
> Thanks,
> Guenter
>
