Return-path: <paolo.bonzini@gmail.com>
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH v2] iTCO_wdt: all versions count down twice
References: <20170405114115.17475-1-pbonzini@redhat.com>
 <3a2a4b95-ef9c-25d8-db48-ebf2b55e89b8@roeck-us.net>
Cc: Guenter Roeck <linux@roeck-us.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 andriy.shevchenko@linux.intel.com
To: linux-watchdog@vger.kernel.org, wim@iguana.be
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d95f872d-31b4-e5c8-41f6-0c8f1f94ad68@redhat.com>
Date: Tue, 18 Apr 2017 15:17:00 +0200
MIME-Version: 1.0
In-Reply-To: <3a2a4b95-ef9c-25d8-db48-ebf2b55e89b8@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 06/04/2017 13:46, Guenter Roeck wrote:
> On 04/05/2017 04:41 AM, Paolo Bonzini wrote:
>> The ICH9 is listed as having TCO v2, and indeed the behavior in the
>> datasheet corresponds to v2 (for example the NO_REBOOT flag is
>> accessible via the 16KiB-aligned Root Complex Base Address).
>>
>> However, the TCO counts twice just like in v1; the documentation
>> of the SECOND_TO_STS bit says: "ICH9 sets this bit to 1 to indicate
>> that the TIMEOUT bit had been (or is currently) set and a second
>> timeout occurred before the TCO_RLD register was written. If this
>> bit is set and the NO_REBOOT config bit is 0, then the ICH9 will
>> reboot the system after the second timeout.  The same can be found
>> in the BayTrail (Atom E3800) datasheet, and even HOWTOs around
>> the Internet say that it will reboot after _twice_ the specified
>> heartbeat.
>>
>> I did not find the Apollo Lake datasheet, but because v4/v5 has
>> a SECOND_TO_STS bit just like the previous version I'm enabling
>> this for Apollo Lake as well.
>>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: linux-watchdog@vger.kernel.org
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Wim, has this been included in a tree for 4.12?  The trees at
linux-watchdog.git still seem empty.

Thanks,

Paolo

>> ---
>>  Documentation/watchdog/watchdog-parameters.txt |  2 +-
>>  drivers/watchdog/iTCO_wdt.c                    | 22 ++++++++++------------
>>  2 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/watchdog/watchdog-parameters.txt
>> b/Documentation/watchdog/watchdog-parameters.txt
>> index 4f7d86dd0a5d..914518aeb972 100644
>> --- a/Documentation/watchdog/watchdog-parameters.txt
>> +++ b/Documentation/watchdog/watchdog-parameters.txt
>> @@ -117,7 +117,7 @@ nowayout: Watchdog cannot be stopped once started
>>  -------------------------------------------------
>>  iTCO_wdt:
>>  heartbeat: Watchdog heartbeat in seconds.
>> -    (2<heartbeat<39 (TCO v1) or 613 (TCO v2), default=30)
>> +    (5<=heartbeat<=74 (TCO v1) or 1226 (TCO v2), default=30)
>>  nowayout: Watchdog cannot be stopped once started
>>      (default=kernel config parameter)
>>  -------------------------------------------------
>> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
>> index 3d0abc0d59b4..d1d0446011c4 100644
>> --- a/drivers/watchdog/iTCO_wdt.c
>> +++ b/drivers/watchdog/iTCO_wdt.c
>> @@ -280,16 +280,15 @@ static int iTCO_wdt_ping(struct watchdog_device
>> *wd_dev)
>>
>>      iTCO_vendor_pre_keepalive(p->smi_res, wd_dev->timeout);
>>
>> +    /* Reset the timeout status bit so that the timer
>> +     * needs to count down twice again before rebooting */
>> +    outw(0x0008, TCO1_STS(p));    /* write 1 to clear bit */
>> +
>>      /* Reload the timer by writing to the TCO Timer Counter register */
>> -    if (p->iTCO_version >= 2) {
>> +    if (p->iTCO_version >= 2)
>>          outw(0x01, TCO_RLD(p));
>> -    } else if (p->iTCO_version == 1) {
>> -        /* Reset the timeout status bit so that the timer
>> -         * needs to count down twice again before rebooting */
>> -        outw(0x0008, TCO1_STS(p));    /* write 1 to clear bit */
>> -
>> +    else if (p->iTCO_version == 1)
>>          outb(0x01, TCO_RLD(p));
>> -    }
>>
>>      spin_unlock(&p->io_lock);
>>      return 0;
>> @@ -302,11 +301,8 @@ static int iTCO_wdt_set_timeout(struct
>> watchdog_device *wd_dev, unsigned int t)
>>      unsigned char val8;
>>      unsigned int tmrval;
>>
>> -    tmrval = seconds_to_ticks(p, t);
>> -
>> -    /* For TCO v1 the timer counts down twice before rebooting */
>> -    if (p->iTCO_version == 1)
>> -        tmrval /= 2;
>> +    /* The timer counts down twice before rebooting */
>> +    tmrval = seconds_to_ticks(p, t) / 2;
>>
>>      /* from the specs: */
>>      /* "Values of 0h-3h are ignored and should not be attempted" */
>> @@ -359,6 +355,8 @@ static unsigned int iTCO_wdt_get_timeleft(struct
>> watchdog_device *wd_dev)
>>          spin_lock(&p->io_lock);
>>          val16 = inw(TCO_RLD(p));
>>          val16 &= 0x3ff;
>> +        if (!(inw(TCO1_STS(p)) & 0x0008))
>> +            val16 += (inw(TCOv2_TMR(p)) & 0x3ff);
>>          spin_unlock(&p->io_lock);
>>
>>          time_left = ticks_to_seconds(p, val16);
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe
> linux-watchdog" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
