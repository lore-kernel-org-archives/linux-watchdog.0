Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:44271 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab3JVK5i (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Oct 2013 06:57:38 -0400
Message-ID: <52665A1E.5020700@gmail.com>
Date: Tue, 22 Oct 2013 05:57:34 -0500
From: Dinh Nguyen <dinh.linux@gmail.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
	Guenter Roeck <linux@roeck-us.net>
CC: "dinguyen@altera.com" <dinguyen@altera.com>,
	Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [RESEND PATCHv2] watchdog: dw: Enable OF support for DW watchdog
 timer.
References: <1380739472-26172-1-git-send-email-dinguyen@altera.com> <20131021110532.GA8144@kartoffel> <5265C9B0.2060003@roeck-us.net> <20131022103936.GA5511@kartoffel>
In-Reply-To: <20131022103936.GA5511@kartoffel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

On 10/22/13 5:39 AM, Mark Rutland wrote:
> On Tue, Oct 22, 2013 at 01:41:20AM +0100, Guenter Roeck wrote:
>> On 10/21/2013 04:05 AM, Mark Rutland wrote:
>>> On Wed, Oct 02, 2013 at 07:44:32PM +0100, dinguyen@altera.com wrote:
>>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>>
>>>> Add device tree support to the DW watchdog timer.
>>>>
>>>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>>>> Acked-by: Jamie Iles <jamie@jamieiles.com>
>>>> Reviewed-by: Pavel Machek <pavel@denx.de>
>>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>> Cc: Jamie Iles <jamie@jamieiles.com>
>>>> Cc: Viresh Kumar <viresh.linux@gmail.com>
>>>> Cc: Wim Van Sebroeck <wim@iguana.be>
>>>> Cc: Pavel Machek <pavel@denx.de>
>>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>>>> Cc: Ian Campbell <ian.campbell@citrix.com>
>>>> Cc: devicetree@vger.kernel.org
>>>> Cc: linux-watchdog@vger.kernel.org
>>>> ---
>>>> v2:
>>>> - Use of_match_ptr() for of_match_table
>>>> ---
>>>>    .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 ++++++++++++++++
>>>>    drivers/watchdog/dw_wdt.c                          |    8 ++++++++
>>>>    2 files changed, 24 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
>>>> new file mode 100644
>>>> index 0000000..29e150b
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
>>>> @@ -0,0 +1,16 @@
>>>> +Synopsys Designware Watchdog Timer
>>>> +
>>>> +Required Properties:
>>>> +
>>>> +- Compatiblity	: "snps,dw-wdt"
>>> This should presumably be:
>>>
>>> - compatbile: should contain "snps,dw-wdt"
>>>
>> Hi Mark,
>>
>> s/compatbile/compatible/ :-)
> Indeed :)
Changed for v3.
>
>> "must be" or "should contain" ? I see both in various bindings.
>> Is there a preference ?
> I would prefer "should contain" -- it doesn't preclude future compatible
> variants.
Oops..v3 has "should be"...will change to "should contain" in v4.
>
>>>> +- reg		: Base address of the watchdog timer register.
>>> And the size...
>>>
>>>> +
>>>> +Example:
>>>> +
>>>> +	watchdog0: wd@ffd02000 {
>>>> +		compatible = "snps,dw-wdt";
>>>> +		reg = <0xffd02000 0x1000>;
>>>> +		interrupts = <0 171 4>;
>>> This wasn't mentioned.
>>>
>>> Is it necessary?
>>>
>>   From looking into the code ...
>>
>> The driver doesn't use interrupts, so I guess the answer is no. Cut-and-paste error, maybe ?
> Does the device have any interrupts, even if they're unused?
Yes, the device does have an interrupt. Should I add it as an optional 
property?
>
>>> Is it the only interrupt?
>>>
>>>> +		clocks = <&per_base_clk>;
>>> Similarly, is this the only clock?
>>>
>> The driver uses one clock, and it is mandatory.
> Is this the only clock into the unit?
>
> Does it have a name?
Yes, this is is the only clock into the unit. No, it does not have name.

Thanks,
Dinh
>
> Thanks,
> Mark.

