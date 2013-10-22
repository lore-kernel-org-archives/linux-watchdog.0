Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58402 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab3JVAl2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Oct 2013 20:41:28 -0400
Message-ID: <5265C9B0.2060003@roeck-us.net>
Date: Mon, 21 Oct 2013 17:41:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
	"dinguyen@altera.com" <dinguyen@altera.com>
CC: "dinh.linux@gmail.com" <dinh.linux@gmail.com>,
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
References: <1380739472-26172-1-git-send-email-dinguyen@altera.com> <20131021110532.GA8144@kartoffel>
In-Reply-To: <20131021110532.GA8144@kartoffel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/21/2013 04:05 AM, Mark Rutland wrote:
> On Wed, Oct 02, 2013 at 07:44:32PM +0100, dinguyen@altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Add device tree support to the DW watchdog timer.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> Acked-by: Jamie Iles <jamie@jamieiles.com>
>> Reviewed-by: Pavel Machek <pavel@denx.de>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Jamie Iles <jamie@jamieiles.com>
>> Cc: Viresh Kumar <viresh.linux@gmail.com>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: Pavel Machek <pavel@denx.de>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: Ian Campbell <ian.campbell@citrix.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-watchdog@vger.kernel.org
>> ---
>> v2:
>> - Use of_match_ptr() for of_match_table
>> ---
>>   .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 ++++++++++++++++
>>   drivers/watchdog/dw_wdt.c                          |    8 ++++++++
>>   2 files changed, 24 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
>> new file mode 100644
>> index 0000000..29e150b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
>> @@ -0,0 +1,16 @@
>> +Synopsys Designware Watchdog Timer
>> +
>> +Required Properties:
>> +
>> +- Compatiblity	: "snps,dw-wdt"
>
> This should presumably be:
>
> - compatbile: should contain "snps,dw-wdt"
>

Hi Mark,

s/compatbile/compatible/ :-)

"must be" or "should contain" ? I see both in various bindings.
Is there a preference ?

>> +- reg		: Base address of the watchdog timer register.
>
> And the size...
>
>> +
>> +Example:
>> +
>> +	watchdog0: wd@ffd02000 {
>> +		compatible = "snps,dw-wdt";
>> +		reg = <0xffd02000 0x1000>;
>> +		interrupts = <0 171 4>;
>
> This wasn't mentioned.
>
> Is it necessary?
>

 From looking into the code ...

The driver doesn't use interrupts, so I guess the answer is no. Cut-and-paste error, maybe ?

> Is it the only interrupt?
>
>> +		clocks = <&per_base_clk>;
>
> Similarly, is this the only clock?
>
The driver uses one clock, and it is mandatory.

Guenter

> Is it necessary?
>
>> +		status = "okay";
>
> This is unnecessary.
>
> Thanks,
> Mark.
>
>

