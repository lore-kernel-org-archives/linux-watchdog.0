Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:20287 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaK0JWQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Nov 2014 04:22:16 -0500
Message-ID: <5476ED44.603@atmel.com>
Date: Thu, 27 Nov 2014 10:22:12 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>,
	<alexandre.belloni@free-electrons.com>,
	<boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <5465C00E.4030808@offcode.fi> <1416572610-1770-1-git-send-email-timo.kokkonen@offcode.fi> <5476CA7F.4000802@offcode.fi>
In-Reply-To: <5476CA7F.4000802@offcode.fi>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 27/11/2014 07:53, Timo Kokkonen wrote:
> Hi,
> 
> On 21.11.2014 14:23, Timo Kokkonen wrote:
>> By default the driver will start a kernel timer which keeps on kicking
>> the watchdog HW until user space has opened the watchdog
>> device. Usually this is desirable as the watchdog HW is running by
>> default and the user space may not have any watchdog daemon running at
>> all.
>>
>> However, on production systems it may be mandatory that also early
>> crashes and lockups will lead to a watchdog reset, even if they happen
>> before the user space has opened the watchdog device.
>>
>> To resolve the issue, add a new device tree property
>> "enable-early-reset" which will prevent the kernel timer from pinging
>> the watchdog HW on behalf of user space. The default is still to use
>> kernel timer, but more strict behavior can be enabled via the device
>> tree property.
>>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> 
> I forgot to put the PATCHv2 on the subject line.. But anyway, any 
> thoughts about it? Is there something that should be done to get it forward?

Sorry for not having come back to you quickly.

The only thing that tend to prevent me from taking this patch is the
fact that this DT property is mostly a software, Linux-specific one...
Which is somehow not covered by the DT.
This might explain as well why this property is not present on other SoCs.

Can we have other people's advices?

Bye,

>> ---
>>   Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 4 ++++
>>   drivers/watchdog/at91sam9_wdt.c                          | 6 +++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> index f90e294..a0b7b75 100644
>> --- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> @@ -28,6 +28,10 @@ Optional properties:
>>   	entering idle state.
>>   - atmel,dbg-halt : Should be present if you want to stop the watchdog when
>>   	entering debug state.
>> +- enable-early-reset : Should be present if you want to let the
>> +	watchdog timer to expire even before user space has opened the
>> +	device. If not set, a kernel timer will keep on pinging the
>> +	watchdog until it is opened.
>>
>>   Example:
>>   	watchdog@fffffd40 {
>> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
>> index 489729b..78b1977 100644
>> --- a/drivers/watchdog/at91sam9_wdt.c
>> +++ b/drivers/watchdog/at91sam9_wdt.c
>> @@ -89,6 +89,7 @@ struct at91wdt {
>>   	u32 mr_mask;
>>   	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
>>   	bool nowayout;
>> +	bool no_early_timer;
>>   	unsigned int irq;
>>   };
>>
>> @@ -122,7 +123,7 @@ static void at91_ping(unsigned long data)
>>   {
>>   	struct at91wdt *wdt = (struct at91wdt *)data;
>>   	if (time_before(jiffies, wdt->next_heartbeat) ||
>> -	    !watchdog_active(&wdt->wdd)) {
>> +		(!watchdog_active(&wdt->wdd) && !wdt->no_early_timer)) {
>>   		at91_wdt_reset(wdt);
>>   		mod_timer(&wdt->timer, jiffies + wdt->heartbeat);
>>   	} else {
>> @@ -316,6 +317,9 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
>>
>>   	wdt->mr |= max | ((max - min) << 16);
>>
>> +	if (of_property_read_bool(np, "enable-early-reset"))
>> +		wdt->no_early_timer = 1;
>> +
>>   	return 0;
>>   }
>>   #else
>>
> 
> 


-- 
Nicolas Ferre
