Return-path: <prvs=0029b658e=Rasmus.Villemoes@prevas.dk>
Subject: Re: [PATCH 3/3] watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when
 appropriate
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
	Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric
 Anholt <eric@anholt.net>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468570524-18222-3-git-send-email-rasmus.villemoes@prevas.dk>
 <5788E935.6080608@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <578FEF33.9020801@prevas.dk>
Date: Wed, 20 Jul 2016 23:37:55 +0200
MIME-Version: 1.0
In-Reply-To: <5788E935.6080608@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2016-07-15 15:46, Guenter Roeck wrote:
> On 07/15/2016 01:15 AM, Rasmus Villemoes wrote:
>>
>> +static bool bcm2835_wdt_is_running(struct bcm2835_wdt *wdt)
>> +{
>> +    uint32_t cur;
>> +
>> +    cur = readl(wdt->base + PM_RSTC);
>> +
>> +    return !!(cur & PM_RSTC_WRCFG_FULL_RESET);
>> +}
>> +
>>   static int bcm2835_wdt_start(struct watchdog_device *wdog)
>>   {
>>       struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
>> @@ -70,6 +79,7 @@ static int bcm2835_wdt_start(struct watchdog_device
>> *wdog)
>>             PM_RSTC_WRCFG_FULL_RESET, wdt->base + PM_RSTC);
>>
>>       spin_unlock_irqrestore(&wdt->lock, flags);
>> +    set_bit(WDOG_HW_RUNNING, &wdog->status);
>>
> You don't need to set this bit here unless the watchdog can not be stopped.
>
>>       return 0;
>>   }
>> @@ -79,6 +89,7 @@ static int bcm2835_wdt_stop(struct watchdog_device
>> *wdog)
>>       struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
>>
>>       writel_relaxed(PM_PASSWORD | PM_RSTC_RESET, wdt->base + PM_RSTC);
>> +    clear_bit(WDOG_HW_RUNNING, &wdog->status);
>
> ... and since you clear the bit, it can be stopped. Both setting and
> resetting the bit
> is therefore not necessary.

Well, if the bit isn't cleared here, but it was set during probe(), the 
framework will (re)start this watchdog (and keep it fed) since there's 
no separate ping method. I suppose that's reasonable semantics if the 
watchdog was running at boot (and I like how that ends up interacting 
with my open_deadline proposal), but probably a little too subtle. This 
would also change if the ->start method was broken up into separate ping 
and start methods, which it seems that it could be.

If we do clear the bit here, I think it's neater to set it in start as 
well, even if that doesn't really have any effect.

Rasmus
