Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38668 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbcGUAbS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 20 Jul 2016 20:31:18 -0400
Date: Wed, 20 Jul 2016 17:31:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE
Message-ID: <20160721003110.GC23213@roeck-us.net>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468487788-22457-4-git-send-email-rasmus.villemoes@prevas.dk>
 <5787A4E9.30905@roeck-us.net>
 <578891AB.3070501@prevas.dk>
 <5788F34E.8060905@roeck-us.net>
 <578FF674.2000704@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578FF674.2000704@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jul 21, 2016 at 12:08:52AM +0200, Rasmus Villemoes wrote:
> On 2016-07-15 16:29, Guenter Roeck wrote:
> >On 07/15/2016 12:32 AM, Rasmus Villemoes wrote:
> >
> >>>The initial timeout should be specified as module option or as
> >>>devicetree parameter, and there should be no additional configuration
> >>>option.
> >>
> >>I was under the impression that device tree was exclusively for
> >>describing hardware, and this certainly is not that. I also wanted to
> >>avoid having to modify each driver, which would seem to be necessary
> >>if it was module parameter/DT - the only thing required of a driver
> >>now is that it correctly reports WDOG_HW_RUNNING.
> >
> >What is "hardware" ? It is supposed to describe the system, isn't it ?
> >Part of that system is its clock rate,
> >and the means how the OS is loaded, and both have impact on the initial
> >timeout (and the regular timeout).
> >
> >You might as well argue that clock rates should not be in devicetree
> >either. Clock rates are, after all,
> >just reflecting the _use_ of the hardware, not the hardware itself.
> 
> But they are used to configure hardware. The init timeout is not a property
> of any particular device - it configures how the kernel behaves, and as such
> I find it quite natural to have it in the kernel's .config (and overridable
> on command line and via sysfs).
> 

I hear you. "configure hardware" is a slippery term, though. After all,
one would typically configure the initial timeout in hardware, just as
any "normal" timeout. In many cases, this will actually already be the
case (and should be), since the watchdog should be enabled by the
ROMMON or BIOS before control is passed to the kernel. As such, the
initial timeout should already be set when the driver is loaded.

Also, I would want to be able to use the same kernel, and the same
root file system, on different machines without having to bother about
system variants, even more so if I was responsible for potentially dozens
of different variants with subtle differences in hardware. One ends
up having to maintain configuration files which happen to closely look like
devicetree files, plus an entire infrastructure to detect and configure
hardware variants. Such configuration files may be part of the root file
system, or have to be maintained separately. Either creates additional
overhead.

Unfortunately, those configuration files can only be read after the kernel
passed control to user space, which typically happens after the driver
to be controlled was already loaded. Using sysfs is therefore pretty much
useless - one might as well start the watchdog daemon as early as possible
after passing control to user space.

This leaves module parameters, which have to be passed on the kernel command
line to be useful. This is not really desirable either in most situations,
since now the system variant specific configuration has to be implemented
somewhere in the ROMMON, BIOS, or bootloader configuration file. Another level
of complexity added, since the per-variant boot parameters have to be managed
somewhere. Plus, as mentioned above, if the initial timeout has to be passed
as parameter to the kernel, the passing entity might as well program it
into the hardware directly, and start the watchdog, thereby fixing the gap
between hand-off to kernel and loading the watchdog driver.

So what is left ? Situations where the hardware does not tell software what
its configured timeout is, and situations where the maximum hardware timeout
is smaller than the required initial timeout. Both would, in my opinion, warrant
the use of a devicetree property, but I understand that others may have a
different opinion.

Overall, my conclusion is that if a devicetree property is not acceptable
for some reason, we should drop the notion of supporting an initial or
"open" timeout entirely, and leave it up to the BIOS/ROMMON as well as the
respective watchdog driver to set an acceptable default or initial timeout.
This initial timeout can (and will) be overwritten with the desired runtime
timeout by the watchdog daemon after it opened the watchdog device.

> >Devicetree could be handled in the core, with a function to set the
> >initial timeout,
> >or possibly even with the watchdog registration itself.
> 
> But where in the device tree would you put this value? I'd really prefer not
> having to modify the node representing each individual watchdog device I
> might use.
> 
The existing "timeout-sec" property is in the watchdog node as well.

Thanks,
Guenter
