Return-path: <timo.kokkonen@offcode.fi>
Message-ID: <54EAD6E5.8090104@offcode.fi>
Date: Mon, 23 Feb 2015 09:29:41 +0200
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
 Boris Brezillon <boris.brezillon@free-electrons.com>
CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
 Nicolas FERRE <nicolas.ferre@atmel.com>,
 alexandre.belloni@free-electrons.com, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <54B53160.6060309@roeck-us.net> <cover.1424262664.git.timo.kokkonen@offcode.fi> <cover.1424262664.git.timo.kokkonen@offcode.fi> <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi> <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com> <20150220085151.3b599de8@bbrezillon> <E7DD67EB-CA34-48EA-838D-3EBBF74CAEBD@jcrosoft.com> <20150220181640.57b21432@bbrezillon> <20150220180646.GA26698@roeck-us.net>
In-Reply-To: <20150220180646.GA26698@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

On 20.02.2015 20:06, Guenter Roeck wrote:
> On Fri, Feb 20, 2015 at 06:16:40PM +0100, Boris Brezillon wrote:
>> Hi Jean-Christophe,
>>
>> On Sat, 21 Feb 2015 00:33:17 +0800
>> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
>>
>>
>> Timo's need is quite generic, but nobody seemed to bother with that
>> before.
>
> The problem has been discussed before. There are even some patches,
> but they were too specific and limited in scope for my liking.
>
> As I said in my other reply, to move forward we would need
> someone who has the time and energy to get an agreement with the
> DT folks about an acceptable means to express the properties needed
> for a specific hardware, and to actually implement the necessary code.
>
>> Moreover, using an at91 specific implementation does not prevent
>> migrating to a more generic implementation when it's available.
>> Actually, it's rather difficult to design a generic infrastructure until
>> you have dealt with several devices requiring the same feature, and
>> that's obviously not the case here.
>>
> Absolutely agree. If we can not even get a property like the one suggested
> here accepted, it is completely pointless to even think about a more
> generic solution that would work for all watchdog drivers.
>

I'm not really sure that I understand what we are really arguing here, 
but seems that this is not getting any forward unless we get in touch 
with the DT people who get to decide whether this kind of property 
belongs to device tree or not. Who are these people anyway? Which list 
should I write an email to get in touch with them? Why are we not CC'ing 
them already?

Anyway, the way I tried to express it in the v4 patch set, we have a 
generic device tree property that does not try to imply any sort of 
implementation or HW details. The description in watchdog.txt tries to 
state the purpose of the property clearly so that other driver writers 
could make other drivers to support it correctly. And then there is at91 
specific implementation because that's the only watchdog hardware 
currently on my desk that I can easily test it with.

I can't think of how I could make this more generic, not without making 
more changes to the way drivers initialize itself with the watchdog 
core. And that would require changing a lot of drivers, at least if we 
intend to make it work so that the watchdog core takes care of this 
instead of the driver. It's a nice idea but I think it's overly complex 
given the amount of functionality there needs to be in different drivers 
and the diversity between drivers.

To me there is nothing wrong with having this done also via a kernel 
configuration option. We could simply have 
CONFIG_WATCHDOG_EARLY_TIMEOUT_SEC option that works exactly the same way 
as the proposed device tree property. To make it clear only some drivers 
support this option, we could let each driver select an enabler config 
option CONFIG_WATCHDOG_HAS_DEFERRABLE_EARLY_RESET or such that is used 
to hide the config option unless we are building a watchdog that 
supports the given option. Or something like that. But that would be 
less flexible, as if we want to run the same kernel binary on different 
arm boards we can't make these values per board any more. The use case I 
am dealing with doesn't care about this, but I was thinking someone else 
might care. Which is why I thought it should be run time configurable 
via device tree instead of a compile time option.

But now that I have mentioned arm boards, I noticed we are talking about 
generic behaviour and there are also watchdogs running on architectures 
where device trees are not supported. That said, it might be better to 
make it compile time configurable now and add other configuration 
options later.

Any thoughts about that?

Thanks,
-Timo
