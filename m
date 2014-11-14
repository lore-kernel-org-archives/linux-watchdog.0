Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:44721 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754623AbaKNIky (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Nov 2014 03:40:54 -0500
Message-ID: <5465C00E.4030808@offcode.fi>
Date: Fri, 14 Nov 2014 10:40:46 +0200
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <1414060846-17306-1-git-send-email-timo.kokkonen@offcode.fi> <54631869.9070709@offcode.fi> <54647608.1050504@atmel.com>
In-Reply-To: <54647608.1050504@atmel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 11/13/14 11:12, Nicolas Ferre wrote:
> On 12/11/2014 09:20, Timo Kokkonen :
>> Hi,
>>
>>
>> Any thoughts on this one? Should I resend this with some more people or
>> lists to get someone to comment or review this patch?
>
> I would like to know if this property added to the device-tree is
> already defined by another watchdog timer.

As far as I know, no. And I didn't even think about it. But after taking 
a quick look at Documentation/devicetree/bindings/watchdog directory, it 
seems there are only a few bindings that are commong among the watchdog 
drivers..

> Indeed, it seems a pretty generic behavior and I am surprised it doesn't
> have an already existing implementation.

Yeah, I think it would be a good idea to use a generic property name for 
it. I don't think it makes sense to make any changes to the watchdog 
core driver for this, it is quite hardware specific thing after all. But 
the policy is generic and could be supported with other drivers too. 
There are other products out there that have this kind of requirement 
already and I guess they all just hack the driver to keep the watchdog 
running to make sure the device gets reset if user space did not open 
the device for some reason.

If we are about to go with a generic property name, I think it needs to 
be something more descriptive with respect to the desired policy. So, 
how about a property name "enable-early-reset". If set to 1, the 
watchdog HW is left running and reset will happen unless user space does 
something about it. If left undefined or has value 0, act just like now?

How about that?

-Timo

>
> ...
>
>>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>>> ---
>>>    Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 4 ++++
>>>    drivers/watchdog/at91sam9_wdt.c                          | 6 +++++-
>>>    2 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>>> index f90e294..1b9289e 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>>> @@ -28,6 +28,10 @@ Optional properties:
>>>    	entering idle state.
>>>    - atmel,dbg-halt : Should be present if you want to stop the watchdog when
>>>    	entering debug state.
>>> +- atmel,no-early-timer : Should be present if you want to let the
>>> +	watchdog timer to expire even before user space has opened the
>>> +	device. If not set, a kernel timer will keep on pinging the
>>> +	watchdog until it is opened.
>>>
>>>    Example:
>>>    	watchdog@fffffd40 {
>>> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
>>> index 489729b..8cac712 100644
>>> --- a/drivers/watchdog/at91sam9_wdt.c
>>> +++ b/drivers/watchdog/at91sam9_wdt.c
>>> @@ -89,6 +89,7 @@ struct at91wdt {
>>>    	u32 mr_mask;
>>>    	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
>>>    	bool nowayout;
>>> +	bool no_early_timer;
>>>    	unsigned int irq;
>>>    };
>>>
>>> @@ -122,7 +123,7 @@ static void at91_ping(unsigned long data)
>>>    {
>>>    	struct at91wdt *wdt = (struct at91wdt *)data;
>>>    	if (time_before(jiffies, wdt->next_heartbeat) ||
>>> -	    !watchdog_active(&wdt->wdd)) {
>>> +		(!watchdog_active(&wdt->wdd) && !wdt->no_early_timer)) {
>
> ... Nitpicking: there seems to be a indentation mismatch here: use tab +
> spaces to align to previous line...
>
>>>    		at91_wdt_reset(wdt);
>>>    		mod_timer(&wdt->timer, jiffies + wdt->heartbeat);
>>>    	} else {
>>> @@ -316,6 +317,9 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
>>>
>>>    	wdt->mr |= max | ((max - min) << 16);
>>>
>>> +	if (of_property_read_bool(np, "atmel,no-early-timer"))
>>> +		wdt->no_early_timer = 1;
>>> +
>>>    	return 0;
>>>    }
>>>    #else
>
> Otherwise, it seems clean. Can you please re-send a version with the
> Device tree maintainer in CC?
>
> Best regards,
>

