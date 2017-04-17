Return-path: <karim.eshapa@gmail.com>
From: Karim Eshapa <karim.eshapa@gmail.com>
To: joel@jms.id.au
Cc: wim@iguana.be,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karim Eshapa <karim.eshapa@gmail.com>
Subject: Re:drivers:watchdog:aspeed_wdt: using msleep instead of mdelay
Date: Mon, 17 Apr 2017 19:05:30 +0200
Message-Id: <1492448730-5948-1-git-send-email-karim.eshapa@gmail.com>
In-Reply-To: <7ca24742-8a82-da21-7b4c-ca807f995844@roeck-us.net>
References: <7ca24742-8a82-da21-7b4c-ca807f995844@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 16 Apr 2017 12:53:28 -0700,Guenter Roeck wrote:
> On 04/16/2017 09:33 AM, Karim Eshapa wrote:
>>
>> that's useful for the scheduler, power management unless
>> the driver needs to delay in atomic context
>> look at documentation/timers/timers-howto
>
> Possibly, but how can you guarantee that the restart function is called with
> interrupts enabled ? Also, why would it be necessary or even useful for the 
> scheduler to do anything while the system is in the process of restarting ?

>From signaling or interruption point of view msleep() is uninterruptible. 
your process will sleep and won't be waked up until finish the time.

>From the cpu load and power point of view, mdelay() makes your code
stucked doing nothing until the delay finishes so, it's still headache
to the schedular from time slot perspective.
Although it's restating but it's still a long process that takes time. 

In addittion to mdelay() isn't preferable in case of large delays +10 as it uses udelay()
 
But the question now what about ptotecting your HW while being accessed
through manipulating the registers. and what about memory reordering may be generated
by the compiler or the machine itself! while accessing a sequence of registers.

>> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
>> ---
>> drivers/watchdog/aspeed_wdt.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)

>>  diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>> index 1c65258..17f06d1 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>>  +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -115,7 +115,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd>> , aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
>> -       mdelay(1000);
>> +       msleep(1000);
>>
>>         return 0;
>>   }

Thanks,
Karim
