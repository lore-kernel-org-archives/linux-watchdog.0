Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:43969 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065AbaKMJMr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 13 Nov 2014 04:12:47 -0500
Message-ID: <54647608.1050504@atmel.com>
Date: Thu, 13 Nov 2014 10:12:40 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	<linux-watchdog@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <1414060846-17306-1-git-send-email-timo.kokkonen@offcode.fi> <54631869.9070709@offcode.fi>
In-Reply-To: <54631869.9070709@offcode.fi>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/11/2014 09:20, Timo Kokkonen :
> Hi,
> 
> On 10/23/14 13:40, Timo Kokkonen wrote:
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
>> "atmel,no-early-timer" which will prevent the kernel timer from
>> pinging the watchdog HW on behalf of user space. The default is still
>> to use kernel timer, but more strict behavior can be enabled via the
>> device tree property.
>>
> 
> Any thoughts on this one? Should I resend this with some more people or 
> lists to get someone to comment or review this patch?

I would like to know if this property added to the device-tree is
already defined by another watchdog timer.

Indeed, it seems a pretty generic behavior and I am surprised it doesn't
have an already existing implementation.

...

>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> ---
>>   Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 4 ++++
>>   drivers/watchdog/at91sam9_wdt.c                          | 6 +++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> index f90e294..1b9289e 100644
>> --- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> @@ -28,6 +28,10 @@ Optional properties:
>>   	entering idle state.
>>   - atmel,dbg-halt : Should be present if you want to stop the watchdog when
>>   	entering debug state.
>> +- atmel,no-early-timer : Should be present if you want to let the
>> +	watchdog timer to expire even before user space has opened the
>> +	device. If not set, a kernel timer will keep on pinging the
>> +	watchdog until it is opened.
>>
>>   Example:
>>   	watchdog@fffffd40 {
>> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
>> index 489729b..8cac712 100644
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

... Nitpicking: there seems to be a indentation mismatch here: use tab +
spaces to align to previous line...

>>   		at91_wdt_reset(wdt);
>>   		mod_timer(&wdt->timer, jiffies + wdt->heartbeat);
>>   	} else {
>> @@ -316,6 +317,9 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
>>
>>   	wdt->mr |= max | ((max - min) << 16);
>>
>> +	if (of_property_read_bool(np, "atmel,no-early-timer"))
>> +		wdt->no_early_timer = 1;
>> +
>>   	return 0;
>>   }
>>   #else

Otherwise, it seems clean. Can you please re-send a version with the
Device tree maintainer in CC?

Best regards,
-- 
Nicolas Ferre
