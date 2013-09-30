Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:35935 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab3I3RUl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Sep 2013 13:20:41 -0400
From: Tomasz Figa <t.figa@samsung.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
	Leela Krishna Amudala <l.krishna@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>, mark.rutland@arm.com,
	galak <galak@codeaurora.org>, pawel.moll@arm.com,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
Date: Mon, 30 Sep 2013 19:20:24 +0200
Message-id: <2977055.g9Xlcgnplt@amdc1227>
In-reply-to: <CAD=FV=U35jtZBMjx3te9+2brd0KDQHJr0c6u8y1ucQtDQfMTDQ@mail.gmail.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
 <13147351.I7ksvhO9sb@flatron>
 <CAD=FV=U35jtZBMjx3te9+2brd0KDQHJr0c6u8y1ucQtDQfMTDQ@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Doug,

On Monday 30 of September 2013 09:54:33 Doug Anderson wrote:
> Tomasz,
> 
> On Sat, Sep 28, 2013 at 6:49 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> >> On Fri, Sep 27, 2013 at 11:14 AM, Tomasz Figa <tomasz.figa@gmail.com>
> > wrote:
> >> >> So isn't the register in the PMU there to save power in the case that
> >> >> the watchdog timer isn't being used?  How is the PMU "driver" to know
> >> >> whether the watchdog is being used?  Better IMHO that the watchdog
> >> >> driver knows to enable and disable itself as needed, right?
> >> >
> >> > How much power can you save on one low frequency counter? Anyway,
> >> > those
> >> > bits look more like reset signal masks to me, unrelated to any power
> >> > saving and even if, this driver switches them on at probe regardless
> >> > of
> >> > whether the watchdog is actually used or not.
> >>
> >> I don't know for sure how much power it saves if any.  The description
> >> I have of those fields is also definitely a little on the confusing
> >> side.  The fact that they are in the PMU leads me to believe that they
> >> save power, but perhaps that's not the case here.
> >>
> >> It still does seem nice to keep watchdog related code in the watchdog
> >> driver, though...
> >
> > For me, this thing looks more related to PMU than watchdog, since the code
> > writes to PMU registers and does this only on system power state
> > transitions, i.e. once per boot, suspend, resume and shutdown.
> 
> I wonder if there is any reason that it shouldn't be put in the
> s3c2410wdt_start() and s3c2410wdt_stop() functions?

Well, this could actually make some sense, assuming that there would be
any use case for it and any advantages of doing so. According to user's
manual those masks are only masking the reset signal, but there are no
use scenarios described.

> >> I guess I could also imagine ordering problems if
> >> we tweaked this bit in the PMU driver, though I don't have actual
> >> evidence of this.  Maybe cases where enabling at the wrong time could
> >> cause spurious watchdog resets depending on how the BIOS left the
> >> state of things.
> >
> > Even if you put this code in watchdog driver you don't have any warranties
> > that the firmware leaves both the watchdog and PMU bits sets correctly.
> > I'm not sure what would be the point of firmware existence if you can't
> > trust it to set up at least the basic working environment for you and I
> > consider watchdog to be part of such.
> 
> I trust it to leave the system in some state that is safe.  ...but I
> don't trust the firmware of all exynos-based products to have the same
> idea of what "safe" is.  I could imagine some of them disabling the
> watchdog before booting linux by tweaking the settings in the PMU (and
> leaving the reset of the watchdog configured and running) and some of
> them disabling the watchdog by leaving the PMU settings alone and
> turning off the enable bit.  I could also imagine some of them
> actually leaving the watchdog fully configured and running to try to
> catch the case where the kernel crashes at bootup.  I don't know of
> any official rules here, which means that the kernel needs to be
> flexible enough.

Nothing stops the kernel from simply disabling the watchdog by watchdog
(not PMU registers), but still, what about kernels compiled without the
watchdog driver?

> >> It would be unfortunate if we found we needed to
> >> reach into the watchdog register bank from the PMU driver to "pet" the
> >> watchdog before enabling it.
> >
> > If you find any such need in future, then with the solution I proposed
> > there will be no problem in changing things to be done as you and Leela
> > propose. The other way around would not be that simple, because the
> > introduced binding would still have to be supported and the code touching
> > PMU would have to be kept in watchdog code...
> >
> > However, if you really insist on handling this in watchdog driver,
> 
> I certainly don't insist.  I have not contributed nearly enough to the
> community to insist on anything.  At this point I'm merely stating my
> opinion.  Feel free to take it into consideration or ignore it.  I
> will not be offended if you choose to ignore my opinion here.  It is
> really up to Leela Krishna and the maintainer of the subsystem if I
> understand correctly.

Well, everyone has their right to insist on something. Since you're
writing to this mailing list, you're part of the community and you're free
to suggest the superiority of your preferred solution :).

> > please
> > consider using something smarter to access the PMU. I believe that device
> > node of watchdog should not represent parts of PMU, which should be
> > represented as a separate node instead.
> 
> We've already had this discussion before.  Assuming I'm understanding
> him correctly, Olof weighed in and suggested that he preferred to do
> the simpler thing in this case (AKA: what Leela Krishna is doing):
> 
> http://www.spinics.net/lists/devicetree/msg00812.html

Well, the patches themselves in their last version looks fine to me,
however this solution has several issues:
 - a full page of virtual address space is being mapped for just 4 bytes,
   for every such register,
 - the MASK_WDT_RESET_REQUEST register (0x1004040c) contains multiple
   fields, not just SYS_WDT_RESET, so to be future proof, access to it
   must be somehow synchronized,
 - register area of multiple IPs are being specified in device tree node
   of one IP,
 - every driver that accesses PMU will have to contain such extra reg
   parsing and mapping, instead of just requesting a named regmap.

In addition, on the contrary to keeping this in PMU:
 - the driver must be taught some SoC specific details, even if the IPs
   are identical, without any real need to do so.

I don't insist on keeping this in PMU driver, but at least having a common
regmap for all PMU registers that could be accessed by all drivers that
need to do something in PMU registers would be much more elegant and
future-proof.

Best regards,
Tomasz

