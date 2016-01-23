Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43339 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbcAWUBn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 23 Jan 2016 15:01:43 -0500
Subject: Re: [PATCH] watchdog: Add watchdog timer support for the WinSystems
 EBC-C384
To: William Breathitt Gray <vilhelm.gray@gmail.com>, wim@iguana.be
References: <20160122011112.GA19993@sophia> <56A1A52E.7000106@roeck-us.net>
 <56A39C63.9080905@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A3DC22.90508@roeck-us.net>
Date: Sat, 23 Jan 2016 12:01:38 -0800
MIME-Version: 1.0
In-Reply-To: <56A39C63.9080905@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/23/2016 07:29 AM, William Breathitt Gray wrote:
> On 01/21/2016 10:42 PM, Guenter Roeck wrote:
>> This implies that setting the timeout would start the watchdog,
>> which is inappropriate (the timeout can be set while the watchdog
>> is stopped).
>>
>> Also, setting the timeout sets both the resolution _and_ the timeout,
>> which is probably unnecessary when starting or pinging the watchdog.
>
> Help me understand the functionality of the watchdog operations briefly
> since I'm relatively new to the interface. Is it proper to say that the
> start callback starts (and in my case also pings) the watchdog based on
> the value of the previously configured timeout member, while the
> set_timeout callback merely sets the timeout member itself to the
> correct value in seconds accordingly to the watchdog timer's resolution?
>
Correct. In your case it may be sufficient to just set the 'timeout' variable
to a valid timeout (ie one supported by the hardware).

>>> +    const unsigned base = 0x564;
>>> +    const unsigned extent = 5;
>>> +    const char *const name = dev_name(dev);
>>
>> What is the value of those const variables ? Why not just use dev_name() and defines ?
>>
>>> +    int err;
>>> +
>>
>> Is there a means to detect if this is the correct system ? DMI, maybe ?
>> Blindly instantiating the driver seems to be a bit risky and should be avoided
>> if possible.
>
> Unfortunately, the watchdog timer hardware lacks probing capabilities;
> the documentation for the motherboard indicates that the watchdog timer
> is exposed over an ISA-style I/O-mapped port address. In other words,
> the watchdog timer is non-hotpluggable.
>
So how about DMI ? This is a PC, after all, so it should be possible
to identify the hardware with DMI. We should have _something_ available
to identify the hardware.

> I agree that carrying around the constant values in the private data
> structure is somewhat unnecessary, so I'll give them global scope over
> the file. I'm hesitant to lose the type-safety of C variables; is there
> a reason to prefer preprocessor defines over const-qualified variables?
>
It is the common and established approach to use defines (you use a define
for WATCHDOG_TIMEOUT as well). The type-safety argument doesn't really apply;
to me it is similar to the argument for Yoda programming. The compiler
will happily complain if you use an integer define as pointer, or a string
as integer.

Defines are used all over the kernel, and work perfectly fine. I don't see
a need to change that. Worse, it makes life more difficult for reviewers.

>>> +    err = watchdog_init_timeout(&wdt->wdd, timeout, dev);
>>> +    if (err)
>>> +        goto err_init_timeout;
>>
>> A more tolerant implementation would set the default timeout.
>
> Should I remove the timeout module parameter entirely, and simply
> initialize the watchdog_device timeout member to the default timeout I
> want (e.g. wdt->wdd.timeout = 60)? Would I still need to call
> watchdog_init_timeout in that case?
>
I didn't want to suggest that. One option would be to set
wdt->wdd.timeout = 60 and ignore the return value from watchdog_init_timeout,
like most watchdog drivers. Another would be something like

	wdt->wdd.timeout = WATCHDOG_TIMEOUT;
	if (watchdog_init_timeout(&wdt->wdd, timeout, dev))
		dev_warn(dev, "Invalid timeout %d, using default\n", timeout);

You can also abort, as you currently do, I just think it is a bit strict.

>> Have you considered using module_platform_driver_probe() ?
>
> For some reason, I was under the impression that I must allocate a
> platform_device before calling platform_driver_probe. I'll try
> module_platform_driver_probe since that would indeed be far simpler if
> the platform_device setup code is unnecessary.
>
Ah yes, my mistake. The idea is that another driver (usually a platform
driver, or architecture initialization code) would instantiate the device.
Sorry for the noise.

>> No MODULE_ALIAS ?
>
> Since the watchdog timer hardware is non-hotpluggable, I'm not sure I
> should add a MODULE_ALIAS for autoloading the module.
>
Not sure I understand what that has to do with hotplug. Almost all
of the 39 watchdog drivers defining MODULE_ALIAS are not hot-pluggable.
Ok, let's see if it comes back to bite us ;-).

Guenter

