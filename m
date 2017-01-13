Return-path: <prvs=17923fc9e=Rasmus.Villemoes@prevas.dk>
Subject: Re: [PATCH v4 2/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
To: Guenter Roeck <linux@roeck-us.net>
References: <1483974153-466-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1483974153-466-3-git-send-email-rasmus.villemoes@prevas.dk>
 <20170110180818.GC13904@roeck-us.net>
 <be196ed2-d9e5-b575-a4bc-819e95d59d1d@prevas.dk>
 <36f7e6eb-e9e6-e33a-6a33-2ae42451637c@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>, <linux-watchdog@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <7d6b0bb9-43ec-d600-607a-0b43dea39f24@prevas.dk>
Date: Fri, 13 Jan 2017 10:11:42 +0100
MIME-Version: 1.0
In-Reply-To: <36f7e6eb-e9e6-e33a-6a33-2ae42451637c@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2017-01-11 12:02, Guenter Roeck wrote:
> On 01/11/2017 12:11 AM, Rasmus Villemoes wrote:
>> On 2017-01-10 19:08, Guenter Roeck wrote:
>>> On Mon, Jan 09, 2017 at 04:02:32PM +0100, Rasmus Villemoes wrote:
>>>>
>>>> +static unsigned open_timeout;
>>>> +module_param(open_timeout, uint, 0644);
>>>> +
>>>> +static bool watchdog_past_open_deadline(struct watchdog_core_data
>>>> *data)
>>>> +{
>>>> +    if (!open_timeout)
>>>> +        return false;
>>>> +    return time_is_before_jiffies(data->open_deadline);
>>>
>>> Doesn't this return true if the time is _before_ the open deadline ?
>>> Should it be time_is_after_jiffies() ?
>>
>> Yes, time_is_before_jiffies(foo) means foo < jiffies, and that is what
>> we want when we're querying whether we've passed the deadline.
>>
> So you want the function to return true if the timeout has _not_ expired ?

No, I want it to return true if the timeout has expired, just as its
name hopefully suggests ("are we now past the deadline for opening").

time_is_before_jiffies(foo) expands to time_after(jiffies, foo), which
in turn expands to (aside from some type checking)

(long)((foo) - (jiffies)) < 0

which is true precisely when jiffies > foo, i.e., when the current time
is later than foo. [Yes, just as every other user of the time_* helpers
this only works if the times being compared are within LONG_MAX jiffies
of each other.]

> 
> [ Can you try to work with line wraps ? ]

Sorry about that, I hope I've now managed to make Thunderbird not mess
it up.

> Uuh, no. I didn't realize that you apply that case to the "userspace app
> gracefully
> closes the watchdog device" case as well. This is clearly a separate use
> case.
> 
> Looks like there are now three use cases for 'open timeout'.
> - time after boot
> - timer after loading the watchdog device
> - time after closing watchdog device and before reopening it
> 
> I would have thought the first use case is the important one, and the
> other ones are,
> at best, secondary. Given that, we are clearly not there yet. This will
> require input
> from others on the semantics.

I agree, it would be nice to have others chime in on whether they'd even
find this useful, and what semantics they'd like.

But for the record, for us, both the "time after boot" and "time after
closing" are important use cases. In practice, approximating boot time
with time of first registration effectively just pushes the deadline a
little further out, which I think is acceptable (boot time anyway means
"when timekeeping began", and even when the deadline is passed, it takes
up to whatever the hardware is configured to before the board actually
resets, so there's already some slack involved). If one really wants to
measure with respect to boot time, I think one can just make
set_open_deadline take an additional "from" parameter, passing
INITIAL_JIFFIES from watchdog_cdev_register and jiffies from
watchdog_release.

(That won't work for the hotplug case, but please ignore that; it was a
bad example, and certainly not a use case we actually have in mind).


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
