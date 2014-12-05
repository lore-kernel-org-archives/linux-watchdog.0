Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39516 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbaLEVkt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Dec 2014 16:40:49 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xx0br-002KaR-7T
	for linux-watchdog@vger.kernel.org; Fri, 05 Dec 2014 21:40:19 +0000
Date: Fri, 5 Dec 2014 13:39:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
Message-ID: <20141205213946.GA2802@roeck-us.net>
References: <5465C00E.4030808@offcode.fi>
 <1416572610-1770-1-git-send-email-timo.kokkonen@offcode.fi>
 <20141127200036.2c65df62@bbrezillon>
 <5481ABA1.9030408@offcode.fi>
 <20141205151221.0ee1e814@bbrezillon>
 <5481FC7F.3000105@offcode.fi>
 <20141205190247.GA25455@roeck-us.net>
 <54821670.9030602@offcode.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54821670.9030602@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 05, 2014 at 10:32:48PM +0200, Timo Kokkonen wrote:
> On 05.12.2014 21:02, Guenter Roeck wrote:
> >On Fri, Dec 05, 2014 at 08:42:07PM +0200, Timo Kokkonen wrote:
> >>On 05.12.2014 16:12, Boris Brezillon wrote:
> >>>Hi Timo,
> >>>
> >>>On Fri, 05 Dec 2014 14:57:05 +0200
> >>>Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
> >>>
> >>>>On 27.11.2014 21:00, Boris Brezillon wrote:
> >>>>>Hi Timo,
> >>>>>
> >>>>>Sorry for the late reply.
> >>>>>
> >>>>>On Fri, 21 Nov 2014 14:23:30 +0200
> >>>>>Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
> >>>>>
> >>>>>>By default the driver will start a kernel timer which keeps on kicking
> >>>>>>the watchdog HW until user space has opened the watchdog
> >>>>>>device. Usually this is desirable as the watchdog HW is running by
> >>>>>>default and the user space may not have any watchdog daemon running at
> >>>>>>all.
> >>>>>>
> >>>>>>However, on production systems it may be mandatory that also early
> >>>>>>crashes and lockups will lead to a watchdog reset, even if they happen
> >>>>>>before the user space has opened the watchdog device.
> >>>>>>
> >>>>>>To resolve the issue, add a new device tree property
> >>>>>>"enable-early-reset" which will prevent the kernel timer from pinging
> >>>>>>the watchdog HW on behalf of user space. The default is still to use
> >>>>>>kernel timer, but more strict behavior can be enabled via the device
> >>>>>>tree property.
> >>>>>>
> >>>>>>Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> >>>>>>---
> >>>>>>   Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 4 ++++
> >>>>>>   drivers/watchdog/at91sam9_wdt.c                          | 6 +++++-
> >>>>>>   2 files changed, 9 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>>diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >>>>>>index f90e294..a0b7b75 100644
> >>>>>>--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >>>>>>+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >>>>>>@@ -28,6 +28,10 @@ Optional properties:
> >>>>>>   	entering idle state.
> >>>>>>   - atmel,dbg-halt : Should be present if you want to stop the watchdog when
> >>>>>>   	entering debug state.
> >>>>>>+- enable-early-reset : Should be present if you want to let the
> >>>>>>+	watchdog timer to expire even before user space has opened the
> >>>>>>+	device. If not set, a kernel timer will keep on pinging the
> >>>>>>+	watchdog until it is opened.
> >>>>>
> >>>>>If you want to make this property generic, maybe you should document it
> >>>>>in a generic binding doc
> >>>>>(Documentation/devicetree/bindings/watchdog/watchdog.txt ?).
> >>>>>Once you're at it, maybe you could document the generic timeout-sec
> >>>>>property in this file.
> >>>>>Moreover, you might want to parse this property in watchdog_core.c and
> >>>>>store the information in the watchdog_device struct.
> >>>>
> >>>>I gave a little thought about this today and we could maybe have it like
> >>>>watchdog_init_timeout() is today. But I can't really think of any
> >>>>generic handling for this property, anything else except storing the
> >>>>parsed value to a variable in watchdog_device struct. Everything else is
> >>>>HW specific, except how we read the variable.. If we had some logic or
> >>>>checking for this variable (other than to check it is not negative)
> >>>>maybe then it would make sense.
> >>>
> >>>Okay, I'm fine with keeping this DT property parsing out of the core.
> >>
> >>Ok, good.
> >>
> >>>>
> >>>>So I could write a patch to document generic watchdog properties in
> >>>>Documentation/devicetree/bindings/watchdog/watchdog.txt (anything else
> >>>>generic that would go there except timeout-sec and enable-early-reset?)
> >>>
> >>>I'm not sure you and Guenter agreed on the 'early-keepalive-sec'
> >>>property (and this one won't be used in atmel driver since you can't
> >>>change the timeout once set), so I'd say the timeout-sec and
> >>>enable-early-reset are the only common properties for now.
> >>
> >>Actually it can be done in Atmel driver as well. It already has a
> >>timer that keeps on pinging the watchdog until user space opens it.
> >>We just modify the code so that it keeps on pinging the watchdog
> >>until early-keepalive-sec has expired. No need to change the HW
> >>timeouts at all. And I rather have it implemented that way anyway,
> >>the 16 second timeout is a little tight if there happens to be a lot
> >>of stuff already in the early user space.
> >>
> >>Yeah, I didn't get anything back from Guenter about my
> >>early-keepalive-sec property proposal. Frankly, I already forgot
> >>about it my self already. I guess I'll get back to you with v3 set
> >>once I get time for it. Probably easiest to continue from there.
> >>
> >Sorry for that, folks. I have been a bit overwhelmed in the last cycle.
> >
> >early-timeout-sec seems to be the best property name to me right now.
> >It is aligned with the existing timeout-sec. early-keepalive-sec seems
> >kind of different just for the purpose of being different.
> 
> early-timeout-sec sounds good to me. I'll go with that.
> 
> >Not sure about how to name enable-early-reset. I'd prefer to have something
> >generic, even if only implemented in a single driver for now, but I don't
> >really know right now what that might/should look like. Maybe just
> >"enable-early" to indicate that the watchdog should be enabled during init ?
> 
> Do we need the enable-early or such property at all? Just leave
> early-timeout-sec to zero and then let it behave just like
> enable-early would do?
> 

Problem is that the possible conditions are all over the place
for "early" watchdog handling.

- Disable watchdog
- Enable watchdog (or keep it enabled), and keep it alive
  until user space kicks in (ie possibly forever)
- Enable watchdog or keep it enabled, and keep it alive
  for a specified period of time.
- Keep watchdog enabled if it is already enabled, otherwise
  keep it disabled.

There are probably more conditions which I don't recall right now.
Which of those conditions would you address with "early-timeout = <0>;" ?
"enable watchdog early and keep it alive until user space kicks in",
or "keep watchdog enabled if already running, and set specified early
timeout" ? One could argue either way which one of the two meanings
it should be.

Thanks,
Guenter
