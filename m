Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41322 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbKWH0e (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 02:26:34 -0500
Subject: Re: [PATCH v2] watchdog: add Alphascale asm9260-wdt driver
To: Oleksij Rempel <linux@rempel-privat.de>,
	Rob Herring <robh@kernel.org>
References: <20151027023132.GA1270@roeck-us.net>
 <1446714416-22587-1-git-send-email-linux@rempel-privat.de>
 <1446714416-22587-2-git-send-email-linux@rempel-privat.de>
 <20151105204301.GA15806@rob-hp-laptop> <5652BC30.7060803@rempel-privat.de>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	devicetree@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5652BFA5.9010101@roeck-us.net>
Date: Sun, 22 Nov 2015 23:26:29 -0800
MIME-Version: 1.0
In-Reply-To: <5652BC30.7060803@rempel-privat.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/22/2015 11:11 PM, Oleksij Rempel wrote:
> Hi,
>
> thank you for review!
>
> Am 05.11.2015 um 21:43 schrieb Rob Herring:
>> On Thu, Nov 05, 2015 at 10:06:56AM +0100, Oleksij Rempel wrote:
>>> Add WD support for Alphascale asm9260 SoC. This driver
>>> provide support for different function modes:
>>> - HW mode to trigger SoC reset on timeout
>>> - SW mode do soft reset if needed
>>> - DEBUG mode
>>>
>>> Optional support for stopping watchdog. If reset binding are not provided
>>> this driver will work in nowayout mode.
>>>
>>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>>> ---
>>>   .../bindings/watchdog/alphascale-asm9260.txt       |  39 ++
>>
>> It is preferred that bindings are a separate patch.
>>
>>>   drivers/watchdog/Kconfig                           |   9 +
>>>   drivers/watchdog/Makefile                          |   1 +
>>>   drivers/watchdog/asm9260_wdt.c                     | 415 +++++++++++++++++++++
>>>   4 files changed, 464 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
>>>   create mode 100644 drivers/watchdog/asm9260_wdt.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
>>> new file mode 100644
>>> index 0000000..6e54d1f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
>>> @@ -0,0 +1,39 @@
>>> +Alphascale asm9260 Watchdog timer
>>> +
>>> +Required properties:
>>> +
>>> +- compatible : should be "alphascale,asm9260-wdt".
>>> +- reg : Specifies base physical address and size of the registers.
>>> +- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
>>> +- clock-names : should be set to
>>> +	"mod" - source for tick counter.
>>> +	"ahb" - ahb gate.
>>> +
>>> +Optional properties:
>>> +- resets : phandle pointing to the system reset controller with correct
>>> +	reset line index for watchdog controller reset. This propertie is
>>
>> s/propertie/property/
>>
>>> +	required if you need to disable "nowayout" and it neened only with
>>> +	CONFIG_WATCHDOG_NOWAYOUT=n.
>>
>> The DT cannot depend on certain kernel configs.
>>
>>> +	Without reseting this WD controller, it is not possible to stop
>>
>> s/reseting/resetting/
>>
>>> +	counter.
>>> +- reset-names : should be set to "wdt_rst" if "resets" is used.
>>> +- timeout-sec : shall contain the default watchdog timeout in seconds,
>>> +	if unset, the default timeout is 30 seconds.
>>> +- alphascale,mode : tree modes are supported
>>
>> s/tree/three/
>>
>>> +	"hw" - hw reset (defaul).
>>
>> s/defaul/default/
>>
>>> +	"sw" - sw reset.
>>> +	"debug" - no action is taken.
>>
>> Seems like this should be a generic wdog property.
>>
>
> what do you mean?
> Using "mode" instead of "alphascale,mode" and implement it in WD framework?
>

You should still read the property in the driver, even it if is made generic.
The watchdog framework can't really use the information, most drivers don't
support selecting the mode. We can consider moving it into the framework
if/when it benefits other drivers.

On a side note, I would suggest "software" and "hardware" instead of sw / hw,
but that is just a personal preference.

Thanks,
Guenter

