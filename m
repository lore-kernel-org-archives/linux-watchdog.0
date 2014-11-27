Return-path: <boris.brezillon@free-electrons.com>
Date: Thu, 27 Nov 2014 20:06:47 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Timo Kokkonen
 <timo.kokkonen@offcode.fi>, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org, alexandre.belloni@free-electrons.com
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
Message-ID: <20141127200647.4f0575ca@bbrezillon>
In-Reply-To: <54775E12.6020906@roeck-us.net>
References: <5465C00E.4030808@offcode.fi>
	<1416572610-1770-1-git-send-email-timo.kokkonen@offcode.fi>
	<5476CA7F.4000802@offcode.fi>
	<5476ED44.603@atmel.com>
	<54775E12.6020906@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Thu, 27 Nov 2014 09:23:30 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 11/27/2014 01:22 AM, Nicolas Ferre wrote:
> > On 27/11/2014 07:53, Timo Kokkonen wrote:
> >> Hi,
> >>
> >> On 21.11.2014 14:23, Timo Kokkonen wrote:
> >>> By default the driver will start a kernel timer which keeps on kicking
> >>> the watchdog HW until user space has opened the watchdog
> >>> device. Usually this is desirable as the watchdog HW is running by
> >>> default and the user space may not have any watchdog daemon running at
> >>> all.
> >>>
> >>> However, on production systems it may be mandatory that also early
> >>> crashes and lockups will lead to a watchdog reset, even if they happen
> >>> before the user space has opened the watchdog device.
> >>>
> >>> To resolve the issue, add a new device tree property
> >>> "enable-early-reset" which will prevent the kernel timer from pinging
> >>> the watchdog HW on behalf of user space. The default is still to use
> >>> kernel timer, but more strict behavior can be enabled via the device
> >>> tree property.
> >>>
> >>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> >>
> >> I forgot to put the PATCHv2 on the subject line.. But anyway, any
> >> thoughts about it? Is there something that should be done to get it forward?
> >
> > Sorry for not having come back to you quickly.
> >
> > The only thing that tend to prevent me from taking this patch is the
> > fact that this DT property is mostly a software, Linux-specific one...
> > Which is somehow not covered by the DT.
> > This might explain as well why this property is not present on other SoCs.
> >
> > Can we have other people's advices?
> >
> 
> We have been thinking about a more generic (infrastructure based) solution
> for the problem at hand, but that was a bit more complex and would specify
> the actual timeout during boot, not just a boolean like suggested here.

Can't we keep the same timeout (the one specified in the timeout-sec
property) ?

> 
> As for DT not supposed to be used for configuration, that is really a
> tricky problem which is hard to solve. I seem to recall, though, that
> it may be now acceptable under certain conditions. A module parameter
> might be easier.

I'm not a big fan of passing these kind information through module
params, cause it's kind of hard to assign parameters when you have
multiple device instances (it might not be applicable to watchdog
devices though).
Moreover, adding more module parameters will just expand the cmdline
and make it less and less readable.

Anyway, this is not my call to make :-).

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
