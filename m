Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43807 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcGQTt6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 15:49:58 -0400
Subject: Re: [RFC 1/3] watchdog: change watchdog_need_worker logic
To: Wim Van Sebroeck <wim@iguana.be>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468487788-22457-2-git-send-email-rasmus.villemoes@prevas.dk>
 <20160717192407.GA32415@spo001.leaseweb.nl>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578BE162.2090402@roeck-us.net>
Date: Sun, 17 Jul 2016 12:49:54 -0700
MIME-Version: 1.0
In-Reply-To: <20160717192407.GA32415@spo001.leaseweb.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/17/2016 12:24 PM, Wim Van Sebroeck wrote:
> Hi Rasmus,
>
>> If the driver indicates that the watchdog is running, the framework
>> should feed it until userspace opens the device, regardless of whether
>> the driver has set max_hw_heartbeat_ms.
>>
>> This patch only affects the case where wdd->max_hw_heartbeat_ms is
>> zero, wdd->timeout is non-zero, the watchdog is not active and the
>> hardware device is running (*):
>>
>> - If wdd->timeout is zero, watchdog_need_worker() returns false both
>> before and after this patch, and watchdog_next_keepalive() is not
>> called.
>>
>> - If watchdog_active(wdd), the return value from watchdog_need_worker
>> is also the same as before (namely, hm && t > hm). Hence in that case,
>> watchdog_next_keepalive() is only called if hm == max_hw_heartbeat_ms
>> is non-zero, so the change to min_not_zero there is a no-op.
>>
>> - If the watchdog is not active and the device is not running, we
>> return false from watchdog_need_worker just as before.
>>
>> That leaves the watchdog_hw_running(wdd) && !watchdog_active(wdd) &&
>> wdd->timeout case. Again, it's easy to see that if
>> wdd->max_hw_heartbeat_ms is non-zero, we return true from
>> watchdog_need_worker with and without this patch, and the logic in
>> watchdog_next_keepalive is unchanged. Finally, if
>> wdd->max_hw_heartbeat_ms is 0, we used to end up in the
>> cancel_delayed_work branch, whereas with this patch we end up
>> scheduling a ping timeout_ms/2 from now.
>>
>> (*) This should imply that no current kernel drivers are affected,
>> since the only drivers which explicitly set WDOG_HW_RUNNING are
>> imx2_wdt.c and dw_wdt.c, both of which also provide a non-zero value
>> for max_hw_heartbeat_ms. The watchdog core also sets WDOG_HW_RUNNING,
>> but only when the driver doesn't provide ->stop, in which case it
>> must, according to Documentation/watchdog/watchdog-kernel-api.txt, set
>> max_hw_heartbeat_ms.
>
> This isn't completely true. We will have the following in the linux-watchdog tree:
> drivers/watchdog/aspeed_wdt.c:		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> drivers/watchdog/dw_wdt.c:	set_bit(WDOG_HW_RUNNING, &wdd->status);
> drivers/watchdog/dw_wdt.c:		set_bit(WDOG_HW_RUNNING, &wdd->status);
> drivers/watchdog/imx2_wdt.c:	set_bit(WDOG_HW_RUNNING, &wdog->status);
> drivers/watchdog/imx2_wdt.c:		set_bit(WDOG_HW_RUNNING, &wdog->status);
> drivers/watchdog/max77620_wdt.c:		set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
> drivers/watchdog/sbsa_gwdt.c:		set_bit(WDOG_HW_RUNNING, &wdd->status);
> drivers/watchdog/tangox_wdt.c:		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
>
> I checked the ones that aren't mentioned and aspeed_wdt, max77620_wdt and sbsa_gwdt.c
> also have a non-zero value for max_hw_heartbeat_ms. But tangox_wdt.c doesn't set it.
> This one will need to be looked at closer.
>

I had a brief look; the tangox_wdt problem is my fault. I overlooked that with
my commit 'watchdog: tangox: Mark running watchdog correctly'.

We have a number of options: Set max_hw_heartbeat_ms in tangox_wdt.c,
accept this patch, or both. I think we should accept this patch.

Thanks,
Guenter

>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>   drivers/watchdog/watchdog_dev.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>> index 3595cff..14f8a92 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -92,9 +92,13 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>>   	 *   thus is aware that the framework supports generating heartbeat
>>   	 *   requests.
>>   	 * - Userspace requests a longer timeout than the hardware can handle.
>> +	 *
>> +	 * Alternatively, if userspace has not opened the watchdog
>> +	 * device, we take care of feeding the watchdog if it is
>> +	 * running.
>>   	 */
>> -	return hm && ((watchdog_active(wdd) && t > hm) ||
>> -		      (t && !watchdog_active(wdd) && watchdog_hw_running(wdd)));
>> +	return (hm && watchdog_active(wdd) && t > hm) ||
>> +		(t && !watchdog_active(wdd) && watchdog_hw_running(wdd));
>>   }
>>
>>   static long watchdog_next_keepalive(struct watchdog_device *wdd)
>> @@ -107,7 +111,7 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
>>   	unsigned int hw_heartbeat_ms;
>>
>>   	virt_timeout = wd_data->last_keepalive + msecs_to_jiffies(timeout_ms);
>> -	hw_heartbeat_ms = min(timeout_ms, wdd->max_hw_heartbeat_ms);
>> +	hw_heartbeat_ms = min_not_zero(timeout_ms, wdd->max_hw_heartbeat_ms);
>>   	keepalive_interval = msecs_to_jiffies(hw_heartbeat_ms / 2);
>>
>>   	if (!watchdog_active(wdd))
>> --
>> 2.5.0
>>
>
> Kind regards,
> Wim.
>
>

