Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:37958 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751332AbbBTIAL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 03:00:11 -0500
Message-ID: <54E6E981.7020201@offcode.fi>
Date: Fri, 20 Feb 2015 10:00:01 +0200
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: boris.brezillon@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Nicolas FERRE <nicolas.ferre@atmel.com>,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <54B53160.6060309@roeck-us.net> <cover.1424262664.git.timo.kokkonen@offcode.fi> <cover.1424262664.git.timo.kokkonen@offcode.fi> <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi> <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
In-Reply-To: <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 20.02.2015 09:48, Jean-Christophe PLAGNIOL-VILLARD wrote:
>
>> On Feb 18, 2015, at 8:57 PM, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
>>
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
>> "early-timeout-sec" which will let the kernel timer to ping the
>> watchdog HW only as long as the specified timeout permits. The default
>> is still to use kernel timer, but more strict behavior can be enabled
>> via the device tree property.
>>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> ---
>> Documentation/devicetree/bindings/watchdog/watchdog.txt | 7 +++++++
>> drivers/watchdog/at91sam9_wdt.c                         | 9 ++++++++-
>
> This should not be handled by the driver but the kernel in a generic way
>

Any idea how to do that? The generic watchdog code doesn't really know 
anything about how the actual HW works. Eg. it can't know whether the 
watchdog is already running or not, does it need to be started or should 
we just change the expiration timeout or what. The best the core can do 
about this is to parse the timeout value off the device tree and give 
that to the driver. And even that requires that the driver asks the core 
to do that, because the driver needs to know how to configure the HW 
properly before exiting probe.

This is why I thought it is quite pointless trying to do anything about 
it in the watchdog core. We could add more generic of parser in the core 
and change the core API and all drivers, but I don't really see what we 
would accomplish with that. Each driver that wants to support this needs 
to change, because all drivers currently try to stop watchdog on their 
probe function. This is not right if we are about to catch a crash that 
might happen in the kernel right after the watchdog HW has been stopped.

Of course, I might be missing something, please elaborate if you had 
some plan in your mind.

Thanks,
-Timo


>> 2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.txt b/Documentation/devicetree/bindings/watchdog/watchdog.txt
>> index 7e3686c..32647cf 100644
>> --- a/Documentation/devicetree/bindings/watchdog/watchdog.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.txt
>> @@ -4,9 +4,16 @@ using these definitions.
>>
>> Optional properties:
>> - timeout-sec: Contains the watchdog timeout in seconds.
>> +- early-timeout-sec: If present, specifies a timeout value in seconds
>> +  that the driver keeps on ticking the watchdog HW on behalf of user
>> +  space. Once this timeout expires watchdog is left to expire in
>> +  timeout-sec seconds. If this propery is set to zero, watchdog is
>> +  started (or left running) so that a reset occurs in timeout-sec
>> +  since the watchdog was started.
>>
>> Example:
>>
>> watchdog {
>> 	 timeout-sec = <60>;
>> +	 early-timeout-sec = <120>;
>> };
>> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
>> index 6df9405..1b40bfa 100644
>> --- a/drivers/watchdog/at91sam9_wdt.c
>> +++ b/drivers/watchdog/at91sam9_wdt.c
>> @@ -89,6 +89,8 @@ struct at91wdt {
>> 	u32 mr_mask;
>> 	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
>> 	bool nowayout;
>> +	/* Timeout in jiffies for stopping the early timer */
>> +	unsigned long early_timer;
>> 	unsigned int irq;
>> };
>>
>> @@ -122,7 +124,8 @@ static void at91_ping(unsigned long data)
>> {
>> 	struct at91wdt *wdt = (struct at91wdt *)data;
>> 	if (time_before(jiffies, wdt->next_heartbeat) ||
>> -	    !watchdog_active(&wdt->wdd)) {
>> +		(time_before(jiffies, wdt->early_timer) &&
>> +			!watchdog_active(&wdt->wdd))) {
>> 		at91_wdt_reset(wdt);
>> 		mod_timer(&wdt->timer, jiffies + wdt->heartbeat);
>> 	} else {
>> @@ -316,6 +319,10 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
>>
>> 	wdt->mr |= max | ((max - min) << 16);
>>
>> +	if (!of_property_read_u32_index(np, "early-timeout-sec", 0,
>> +					(u32 *)&wdt->early_timer))
>> +		wdt->early_timer = wdt->early_timer * HZ + jiffies;
>> +
>> 	return 0;
>> }
>> #else
>> --
>> 2.1.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

