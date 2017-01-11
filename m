Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53682 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbdAKLCO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jan 2017 06:02:14 -0500
Subject: Re: [PATCH v4 2/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <1483974153-466-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1483974153-466-3-git-send-email-rasmus.villemoes@prevas.dk>
 <20170110180818.GC13904@roeck-us.net>
 <be196ed2-d9e5-b575-a4bc-819e95d59d1d@prevas.dk>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <36f7e6eb-e9e6-e33a-6a33-2ae42451637c@roeck-us.net>
Date: Wed, 11 Jan 2017 03:02:10 -0800
MIME-Version: 1.0
In-Reply-To: <be196ed2-d9e5-b575-a4bc-819e95d59d1d@prevas.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/11/2017 12:11 AM, Rasmus Villemoes wrote:
> On 2017-01-10 19:08, Guenter Roeck wrote:
>> On Mon, Jan 09, 2017 at 04:02:32PM +0100, Rasmus Villemoes wrote:
>>>
>>> +static unsigned open_timeout;
>>> +module_param(open_timeout, uint, 0644);
>>> +
>>> +static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
>>> +{
>>> +    if (!open_timeout)
>>> +        return false;
>>> +    return time_is_before_jiffies(data->open_deadline);
>>
>> Doesn't this return true if the time is _before_ the open deadline ?
>> Should it be time_is_after_jiffies() ?
>
> Yes, time_is_before_jiffies(foo) means foo < jiffies, and that is what we want when we're querying whether we've passed the deadline.
>
So you want the function to return true if the timeout has _not_ expired ?

>>> +}
>>> +
>>> +static void watchdog_set_open_deadline(struct watchdog_core_data *data)
>>> +{
>>> +    data->open_deadline = jiffies + msecs_to_jiffies(open_timeout);
>>
>> The open deadline as defined applies to the time after the device was
>> instantiated, not to the time since boot. Would it be better to make it
>> "time since boot" ?
>
> I don't have a strong opinion on that, but two small things made me do it this way: (1) In case a hardware watchdog

is somehow hotplugged long after boot and userspace is supposed to detect that and start feeding it, it wouldn't make

sense for the framework not to take care of it for a while. (2) The open_timeout also applies to the case where the

userspace app gracefully closes the watchdog device (e.g. because it's been instructed to restart to load a new configuration

or whatnot) but the hardware cannot be stopped. In that case, the framework also takes over, and the same logic as after boot should apply

- if the app fails to come up again, the framework should not feed the dog indefinitely, but OTOH it clearly doesn't make sense to have a boot-time based deadline.
>

[ Can you try to work with line wraps ? ]

Uuh, no. I didn't realize that you apply that case to the "userspace app gracefully
closes the watchdog device" case as well. This is clearly a separate use case.

Looks like there are now three use cases for 'open timeout'.
- time after boot
- timer after loading the watchdog device
- time after closing watchdog device and before reopening it

I would have thought the first use case is the important one, and the other ones are,
at best, secondary. Given that, we are clearly not there yet. This will require input
from others on the semantics.

Thanks,
Guenter

>> Also, are you sure about using milli-seconds (instead of seconds) ?
>> I can not really imagine a situation where this would be needed
>> (especially and even more so in the context of using "time after
>> instantiating").
>
> I went back and forth on this. I did milli-seconds because that should cover more use cases. Yes, wanting an open timeout of .7 seconds with 1.0 seconds being unacceptable is unusual, but I know of some customers with very strict requirements. Also, even if one cannot make userspace start that fast, one can boot with a somewhat generous open_timeout and then write 700 to /sys/module/watchdog/parameters/open_timeout for use in case (2) above.
>
> Thanks,
> Rasmus
>

