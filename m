Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:48903 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab3I2Bt5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 28 Sep 2013 21:49:57 -0400
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Tomasz Figa <t.figa@samsung.com>,
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
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read PMU registers adresses
Date: Sun, 29 Sep 2013 03:49:51 +0200
Message-ID: <13147351.I7ksvhO9sb@flatron>
In-Reply-To: <CAD=FV=Wa0BpmE7mQoAk-RC_g9QCCz2T_7=Pd46CDSN8Z9KQ8jg@mail.gmail.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com> <2201944.6vg4a9ttux@flatron> <CAD=FV=Wa0BpmE7mQoAk-RC_g9QCCz2T_7=Pd46CDSN8Z9KQ8jg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 27 of September 2013 11:48:53 Doug Anderson wrote:
> Tomasz,
> 
> On Fri, Sep 27, 2013 at 11:14 AM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> >> So isn't the register in the PMU there to save power in the case that
> >> the watchdog timer isn't being used?  How is the PMU "driver" to know
> >> whether the watchdog is being used?  Better IMHO that the watchdog
> >> driver knows to enable and disable itself as needed, right?
> > 
> > How much power can you save on one low frequency counter? Anyway,
> > those
> > bits look more like reset signal masks to me, unrelated to any power
> > saving and even if, this driver switches them on at probe regardless
> > of
> > whether the watchdog is actually used or not.
> 
> I don't know for sure how much power it saves if any.  The description
> I have of those fields is also definitely a little on the confusing
> side.  The fact that they are in the PMU leads me to believe that they
> save power, but perhaps that's not the case here.
> 
> It still does seem nice to keep watchdog related code in the watchdog
> driver, though...  

For me, this thing looks more related to PMU than watchdog, since the code 
writes to PMU registers and does this only on system power state 
transitions, i.e. once per boot, suspend, resume and shutdown.

> I guess I could also imagine ordering problems if
> we tweaked this bit in the PMU driver, though I don't have actual
> evidence of this.  Maybe cases where enabling at the wrong time could
> cause spurious watchdog resets depending on how the BIOS left the
> state of things.

Even if you put this code in watchdog driver you don't have any warranties 
that the firmware leaves both the watchdog and PMU bits sets correctly. 
I'm not sure what would be the point of firmware existence if you can't 
trust it to set up at least the basic working environment for you and I 
consider watchdog to be part of such.

> It would be unfortunate if we found we needed to
> reach into the watchdog register bank from the PMU driver to "pet" the
> watchdog before enabling it.

If you find any such need in future, then with the solution I proposed 
there will be no problem in changing things to be done as you and Leela 
propose. The other way around would not be that simple, because the 
introduced binding would still have to be supported and the code touching 
PMU would have to be kept in watchdog code...

However, if you really insist on handling this in watchdog driver, please 
consider using something smarter to access the PMU. I believe that device 
node of watchdog should not represent parts of PMU, which should be 
represented as a separate node instead.

Could you use the syscon driver instead to handle PMU register accesses in 
a centralized way, put the PMU register offset and respective bit masks 
inside the watchdog driver (preferrably in a struct bound to respective OF 
match entry) and access the registers using the regmap API?

Best regards,
Tomasz

