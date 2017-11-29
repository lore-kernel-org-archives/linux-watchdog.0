Return-Path: <prvs=499054018=Rasmus.Villemoes@prevas.dk>
Return-path: <prvs=499054018=Rasmus.Villemoes@prevas.dk>
Subject: Re: [PATCH 1/2] watchdog: introduce watchdog.open_timeout commandline
 parameter
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>, Esben
 Haabendal <esben@haabendal.dk>, <mnhu@prevas.dk>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <1511865350-20665-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1511865350-20665-2-git-send-email-rasmus.villemoes@prevas.dk>
 <20171128221445.GG10144@roeck-us.net>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <d7c722eb-5c74-700d-44f6-a7a6961c957e@prevas.dk>
Date: Wed, 29 Nov 2017 11:56:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171128221445.GG10144@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2017-11-28 23:14, Guenter Roeck wrote:
> On Tue, Nov 28, 2017 at 11:35:49AM +0100, Rasmus Villemoes wrote:
>>
>> The unit is milliseconds rather than seconds because that covers more
>> use cases. For example, one can effectively disable the kernel handling
>> by setting the open_timeout to 1 ms. There are also customers with very
>> strict requirements that may want to set the open_timeout to something
>> like 4500 ms, which combined with a hardware watchdog that must be
>> pinged every 250 ms ensures userspace is up no more than 5 seconds after
>> the bootloader hands control to the kernel (250 ms until the driver gets
>> registered and kernel handling starts, 4500 ms of kernel handling, and
>> then up to 250 ms from the last ping until userspace takes over).
> 
> This is quite vague, especially since it doesn't count the time from
> boot to starting the watchdog driver,

My example is bad, and I now realize one cannot really get such precise
guarantees. But the example _did_ actually account for the time from
boot to device registration - it allowed 250 ms for the kernel to get
that far.

which can vary even across boots.
> Why not make it specific, for example by adjusting the open timeout with
> ktime_get_boot_ns() ?

If by "boot" we mean the moment the bootloader hands control to the
kernel, ktime_get_boot_ns() doesn't give that either - at best, it gives
an approximation of the time since timekeeping_init(), but it's not very
accurate that early (I simply injected printks of ktime_get_boot_ns at
various places in init/main.c and timestamped the output lines). If it
overshoots, we'd be subtracting more of the allowance than we should,
and I don't think we have any way of knowing when that happens or to
correct for it. So I'd rather keep the code simple and let it count from
the time the watchdog framework knows about the device, which is also
around the time when the kernel's timekeeping is reasonably accurate.

> I would actually make it even more specific and calculate the open
> timeout such that the system would reboot after open_timeout, not
> after <open_timeout + hardware_timeout>. Any reason for not doing that ?
> The upside would be more accuracy, and I don't really see a downside.

I don't think it would be that much more accurate - we schedule the
pings at a frequency of half the max_hw_heartbeat_ms==$x, with the
current code we'd get rebooted somewhere between [open_deadline + $x/2,
open_deadline + $x], and subtracting $x from the open_timeout that would
become [open_deadline - $x/2, open_deadline]. I'd rather not have the
reboot happen before the open_deadline. Sure, we could subtract $x/2
instead. Then there's the case where ->max_hw_heartbeat_ms is not set,
so we have to use ->timeout for $x, and then there's the case of $x (or
$x/2) being greater than $open_timeout. I'd really like to keep the code
simple. If it helps, I'd be happy to document the exact semantics of the
open_timeout with a nice ascii art timeline.

Rasmus
