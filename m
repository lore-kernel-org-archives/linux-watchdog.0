Return-path: <prvs=1770178a4=Rasmus.Villemoes@prevas.dk>
Subject: Re: [PATCH v4 2/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
To: Guenter Roeck <linux@roeck-us.net>
References: <1483974153-466-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1483974153-466-3-git-send-email-rasmus.villemoes@prevas.dk>
 <20170110180818.GC13904@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>, <linux-watchdog@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <be196ed2-d9e5-b575-a4bc-819e95d59d1d@prevas.dk>
Date: Wed, 11 Jan 2017 09:11:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170110180818.GC13904@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2017-01-10 19:08, Guenter Roeck wrote:
> On Mon, Jan 09, 2017 at 04:02:32PM +0100, Rasmus Villemoes wrote:
>>
>> +static unsigned open_timeout;
>> +module_param(open_timeout, uint, 0644);
>> +
>> +static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
>> +{
>> +	if (!open_timeout)
>> +		return false;
>> +	return time_is_before_jiffies(data->open_deadline);
>
> Doesn't this return true if the time is _before_ the open deadline ?
> Should it be time_is_after_jiffies() ?

Yes, time_is_before_jiffies(foo) means foo < jiffies, and that is what 
we want when we're querying whether we've passed the deadline.

>> +}
>> +
>> +static void watchdog_set_open_deadline(struct watchdog_core_data *data)
>> +{
>> +	data->open_deadline = jiffies + msecs_to_jiffies(open_timeout);
>
> The open deadline as defined applies to the time after the device was
> instantiated, not to the time since boot. Would it be better to make it
> "time since boot" ?

I don't have a strong opinion on that, but two small things made me do 
it this way: (1) In case a hardware watchdog is somehow hotplugged long 
after boot and userspace is supposed to detect that and start feeding 
it, it wouldn't make sense for the framework not to take care of it for 
a while. (2) The open_timeout also applies to the case where the 
userspace app gracefully closes the watchdog device (e.g. because it's 
been instructed to restart to load a new configuration or whatnot) but 
the hardware cannot be stopped. In that case, the framework also takes 
over, and the same logic as after boot should apply - if the app fails 
to come up again, the framework should not feed the dog indefinitely, 
but OTOH it clearly doesn't make sense to have a boot-time based deadline.

> Also, are you sure about using milli-seconds (instead of seconds) ?
> I can not really imagine a situation where this would be needed
> (especially and even more so in the context of using "time after
> instantiating").

I went back and forth on this. I did milli-seconds because that should 
cover more use cases. Yes, wanting an open timeout of .7 seconds with 
1.0 seconds being unacceptable is unusual, but I know of some customers 
with very strict requirements. Also, even if one cannot make userspace 
start that fast, one can boot with a somewhat generous open_timeout and 
then write 700 to /sys/module/watchdog/parameters/open_timeout for use 
in case (2) above.

Thanks,
Rasmus

-- 
Rasmus Villemoes
Software Developer
Prevas A/S
Hedeager 1
DK-8200 Aarhus N
+45 51210274
rasmus.villemoes@prevas.dk
www.prevas.dk
