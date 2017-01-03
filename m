Return-path: <prvs=1693c1c27=Rasmus.Villemoes@prevas.dk>
Subject: Re: [PATCH v3 2/2] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
References: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481722654-6266-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481722654-6266-3-git-send-email-rasmus.villemoes@prevas.dk>
 <02c2de88-fa70-39ee-b9e3-89e0dee5523c@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sylvain
 Lemieux <slemieux.tyco@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <c74b9968-65c5-61ea-c233-7dc66b39d903@prevas.dk>
Date: Tue, 3 Jan 2017 16:52:14 +0100
MIME-Version: 1.0
In-Reply-To: <02c2de88-fa70-39ee-b9e3-89e0dee5523c@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2017-01-02 16:22, Guenter Roeck wrote:
> On 12/14/2016 05:37 AM, Rasmus Villemoes wrote:
>> +config WATCHDOG_OPEN_TIMEOUT
>> +    int "Default timeout value for opening watchdog device (seconds)"
>> +    default 0
>> +    help
>> +      If a watchdog driver indicates to the framework that the
>> +      hardware watchdog is running, the framework takes care of
>> +      pinging the watchdog until userspace opens
>> +      /dev/watchdogN. This value (overridden by the device's
>> +      "open-timeout" property if present) sets an upper bound for
>> +      how long the kernel does this - thus, if userspace hasn't
>> +      opened the device within the timeout, the board reboots. A
>> +      value of 0 means there is no timeout.
>> +
>> +
>
> Dual empty line. Also, as mentioned before, I am not a friend of such
> configuration variables. It forces distribution vendors to make the
> decision
> for everyone.

Well, unless the distribution can guarantee that something opens the 
watchdog device in a timely manner, the only sensible decision is to 
keep the default infinite timeout, so I don't see how this is in any way 
a burden for general distributions.

> Please consider defining a command line parameter such as
> watchdog_open_timeout.

I'd be happy to, and that was exactly what I did in the original 
proposal, where it could also be tweaked after boot via sysfs. But I'd 
still like the default value of that command line parameter to be 
settable via Kconfig. That's a lot easier to maintain than having to do 
parts of the kernel configuration in u-boot or whatever bootloader one uses.

>> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
>> index 35a4d81..a89a293 100644
>> --- a/include/linux/watchdog.h
>> +++ b/include/linux/watchdog.h
>> @@ -76,6 +76,11 @@ struct watchdog_ops {
>>   * @max_hw_heartbeat_ms:
>>   *        Hardware limit for maximum timeout, in milli-seconds.
>>   *        Replaces max_timeout if specified.
>> + * @open_timeout:
>> + *              The maximum time for which the kernel will ping the
>> + *              device after registration.
>> + * @open_deadline:
>> + *              Set to jiffies + @open_timeout at registration.
>>   * @reboot_nb:    The notifier block to stop watchdog on reboot.
>>   * @restart_nb:    The notifier block to register a restart function.
>>   * @driver_data:Pointer to the drivers private data.
>> @@ -107,6 +112,8 @@ struct watchdog_device {
>>      unsigned int max_timeout;
>>      unsigned int min_hw_heartbeat_ms;
>>      unsigned int max_hw_heartbeat_ms;
>> +    unsigned int open_timeout;
>> +    unsigned long open_deadline;
>
> None of those need to be visible in drivers. I don't see why the
> variables should be
> defined here and not in struct watchdog_core_data.

I completely agree, these values have nothing to do with individual 
drivers, but as I tried to convince you, they also, IMO, have nothing to 
do with individual devices.

So, since

 > New devicetree properties need to be documented and approved by
 > devicetree maintainers.

I'd like to start with implementing this _just_ as a command line 
parameter (if I can't convince you to accept the Kconfig part we can 
always maintain that trivial addition internally).  If anyone down the 
road feels strongly about the possibility of setting the deadline via a 
device property, it can be added later if they do that work.

How about that?

-- 
Rasmus Villemoes
Software Developer
Prevas A/S
Hedeager 1
DK-8200 Aarhus N
+45 51210274
rasmus.villemoes@prevas.dk
www.prevas.dk
