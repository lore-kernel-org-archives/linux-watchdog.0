Return-path: <timur@codeaurora.org>
Message-ID: <5543C921.9050800@codeaurora.org>
Date: Fri, 01 May 2015 13:42:41 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>,
 Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>,
 linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org> <20150501174953.GB7712@roeck-us.net>
In-Reply-To: <20150501174953.GB7712@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/01/2015 12:49 PM, Guenter Roeck wrote:

>>> That is an interesting one. Makes me wonder if you ever tried to unload
>>> this driver.
>>> Did you ?
>>
>> The driver can only be compiled in-kernel.
>>
> And that makes it valid to have both a global and a local variable named
> arm_sbsa_wdt_pdev ? Please explain the rationale.

Because the driver has to create the ACPI platform device, it needs to 
call functions that are not exported:

ERROR: "acpi_parse_entries" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
ERROR: "arch_timer_get_rate" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
ERROR: "arch_timer_read_counter" [drivers/watchdog/arm_sbsa_wdt.ko] 
undefined!

>> If the table is uninitialized, then all the values are probably zero.  I was
>> trying to come up with something.  These are the only tests I could come up
>> with I know work.
>>
> How would it be uninitialized ? A quick glance to other code seems to suggest
> that this isn't needed elsewhere. Why is it needed here ?

I don't have a good answer to that, except that when I wrote this code, 
I wanted to add some error checking for the ACPI tables, and this is 
what I came up with.

If you're telling me that the code is wrong and it will generate false 
positives, then I can fix it.  But if you're telling me that you don't 
understand why I'm doing some error checking on the ACPI tables that I'm 
parsing, well, I don't understand what could be wrong with that.

>> It's the best I could come up with.  Sure it seems weird, but it works, and
>> since it's copied from BAD_MADT_ENTRY, I figured it was acceptable.
>>
> That doesn't explain if length is supposed to be 16 or 8 bit, if the length
> is supposed to be stored as big or little endian value, and what would happen
> if it was stored as big endian value on some system and is 16 bit wide.

All lengths and endianness of the fields in the ACPI structures are 
already defined in the ACPI spec, so that stuff is fixed and already 
known.  I'm not sure what you're getting at.  I'm just doing some basic 
error checking, no different than any of the code that calls 
BAD_MADT_ENTRY does.

In fact, I suspect that the only reason that BAD_GTDT_ENTRY does not yet 
exist is because there isn't much support for ACPI timers in the kernel 
yet.

> If the length is in fact 16 bit, you could just check its value directly,
> instead of doing all the typecasting. And if it is 16 bit and has a fixed
> endianness (not host byte order), you should convert it to host byte order
> before validating it. Alternatively, something appears to be wrong with
> acpi_gtdt_header and/or with acpi_gtdt_watchdog.

I don't understand what you mean when you say something is wrong with 
acpi_gtdt_header and/or with acpi_gtdt_watchdog.  These structures look 
perfectly fine to me, and they work.  My driver successfully loads and 
parses the ACPI tables on a real ARM64 server system.

>> I think the GTDT is required.  Most likely, the kernel will fail to boot
>> long before we get to this point if the GTDT is missing or corrupt.
>
> ACPI, the center of the universe ;-). Is ACPI support on arm64 now mandatory ?
> I thought it also supports devicetree ?

Yes, ACPI for ARM64 *servers* is mandatory.  ARM64 servers are not 
supposed to use device tree.

And since this is a driver for SBSA systems (SBSA = Server Base System 
Architecture), this driver will only ever be used on an ARM64 server 
system with ACPI and no device tree at all.

> Assuming that there can be an image which boots both with ACPI and devicetree
> based configurations, I can understand that this driver would only load on ACPI
> based arm64 systems, but that doesn't mean it should dump an error message
> if the system does not use ACPI (or if its ACPI tables do not include an entry
> for the watchdog, for that matter).

I can have the driver silently exit if the GTDT table is missing. 
However, if it does exist, then all the other error messages are valid.

>> I can't use acpi_bus_register_driver() because there are no ACPI IDs to
>> probe on.  Watchdog information is stored as a subtable of the GTDT table,
>> and there's nothing in the ACPI layer that automatically creates platforms
>> from subtables.  I have to create the platform from scratch, which is why
>> the code looks so messy.
>>
> Weird. I'll really want to know from some ACPI experts if this is really
> how ACPI drivers are supposed to be instantiated. Can you give me some
> other examples where this is done ?

A lot of this code is taken from the GIC driver, which is the closest 
match.  There really isn't much similar, because there's little code 
that supports the ACPI tables as-is.  A lot of the ACPI data is in the 
form of device nodes, which are device-tree like and are probed very 
differently.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
