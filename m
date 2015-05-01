Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60138 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbEAT1D (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 15:27:03 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YoGaU-0018Mt-II
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 19:27:02 +0000
Date: Fri, 1 May 2015 12:26:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
Message-ID: <20150501192656.GA4928@roeck-us.net>
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org>
 <5542F33D.2020206@roeck-us.net>
 <5543A6E9.1090203@codeaurora.org>
 <20150501174953.GB7712@roeck-us.net>
 <5543C921.9050800@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5543C921.9050800@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 01, 2015 at 01:42:41PM -0500, Timur Tabi wrote:
> On 05/01/2015 12:49 PM, Guenter Roeck wrote:
> 
> >>>That is an interesting one. Makes me wonder if you ever tried to unload
> >>>this driver.
> >>>Did you ?
> >>
> >>The driver can only be compiled in-kernel.
> >>
> >And that makes it valid to have both a global and a local variable named
> >arm_sbsa_wdt_pdev ? Please explain the rationale.
> 
> Because the driver has to create the ACPI platform device, it needs to call
> functions that are not exported:
> 
> ERROR: "acpi_parse_entries" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
> ERROR: "arch_timer_get_rate" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
> ERROR: "arch_timer_read_counter" [drivers/watchdog/arm_sbsa_wdt.ko]
> undefined!
> 
I can understand why that mandates that the driver has to be built into the
kernel, at least if you and/or the arm64 maintainers don't want to export
those functions. However, I still don't understand why you would need
arm_sbsa_wdt_pdev declared twice.

What am I missing here ?

> >>If the table is uninitialized, then all the values are probably zero.  I was
> >>trying to come up with something.  These are the only tests I could come up
> >>with I know work.
> >>
> >How would it be uninitialized ? A quick glance to other code seems to suggest
> >that this isn't needed elsewhere. Why is it needed here ?
> 
> I don't have a good answer to that, except that when I wrote this code, I
> wanted to add some error checking for the ACPI tables, and this is what I
> came up with.
> 
> If you're telling me that the code is wrong and it will generate false
> positives, then I can fix it.  But if you're telling me that you don't
> understand why I'm doing some error checking on the ACPI tables that I'm
> parsing, well, I don't understand what could be wrong with that.
> 
I understand the checking. I don't understand why you think you need an error
message instead of just returning ENODEV if the tables are not there.

> >>It's the best I could come up with.  Sure it seems weird, but it works, and
> >>since it's copied from BAD_MADT_ENTRY, I figured it was acceptable.
> >>
> >That doesn't explain if length is supposed to be 16 or 8 bit, if the length
> >is supposed to be stored as big or little endian value, and what would happen
> >if it was stored as big endian value on some system and is 16 bit wide.
> 
> All lengths and endianness of the fields in the ACPI structures are already
> defined in the ACPI spec, so that stuff is fixed and already known.  I'm not
> sure what you're getting at.  I'm just doing some basic error checking, no
> different than any of the code that calls BAD_MADT_ENTRY does.
> 
> In fact, I suspect that the only reason that BAD_GTDT_ENTRY does not yet
> exist is because there isn't much support for ACPI timers in the kernel yet.
> 
> >If the length is in fact 16 bit, you could just check its value directly,
> >instead of doing all the typecasting. And if it is 16 bit and has a fixed
> >endianness (not host byte order), you should convert it to host byte order
> >before validating it. Alternatively, something appears to be wrong with
> >acpi_gtdt_header and/or with acpi_gtdt_watchdog.
> 
> I don't understand what you mean when you say something is wrong with
> acpi_gtdt_header and/or with acpi_gtdt_watchdog.  These structures look
> perfectly fine to me, and they work.  My driver successfully loads and
> parses the ACPI tables on a real ARM64 server system.
> 
The length field is either 8 bit long or 16 bit. Your code assumes both.

> >>I think the GTDT is required.  Most likely, the kernel will fail to boot
> >>long before we get to this point if the GTDT is missing or corrupt.
> >
> >ACPI, the center of the universe ;-). Is ACPI support on arm64 now mandatory ?
> >I thought it also supports devicetree ?
> 
> Yes, ACPI for ARM64 *servers* is mandatory.  ARM64 servers are not supposed
> to use device tree.
> 
Question here is if enabling ACPI support disables devcietree, and if enabling
devicetree disables ACPI. If both can be enabled, and if an image can be built
which supports both, this would result in stray and unexpected error messages
if the image is loaded on a system supporting devicetree.

If both ACPI and OF can be enabled, and if you want the error messages,
I would expect to see an additional dependency on !OF.

> And since this is a driver for SBSA systems (SBSA = Server Base System
> Architecture), this driver will only ever be used on an ARM64 server system
> with ACPI and no device tree at all.
> 
Question though is if the driver can (and will) be built into an image which
can run on other systems. There is no SBSA dependency, after all, only an
ACPI dependency. If there is no "silent" means for the driver to fail
instantiation, and if the driver is always loaded if present in an image,
I would expect that it must only be built into an image if that image is
built specifically to _only_ run on SBSA systems.


> >Assuming that there can be an image which boots both with ACPI and devicetree
> >based configurations, I can understand that this driver would only load on ACPI
> >based arm64 systems, but that doesn't mean it should dump an error message
> >if the system does not use ACPI (or if its ACPI tables do not include an entry
> >for the watchdog, for that matter).
> 
> I can have the driver silently exit if the GTDT table is missing. However,
> if it does exist, then all the other error messages are valid.
> 
So ACPI based watchdog support and ACPI_SIG_GTDT / ACPI_GTDT_TYPE_WATCHDOG
is mandatory for arm64 servers which support ACPI ?

Thanks,
Guenter
