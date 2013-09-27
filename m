Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50865 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab3I0LZh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 07:25:37 -0400
From: Tomasz Figa <t.figa@samsung.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	swarren@wwwdotorg.org, ian.campbell@citrix.com,
	mark.rutland@arm.com, galak@codeaurora.org, pawel.moll@arm.com,
	rob.herring@calxeda.com
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
Date: Fri, 27 Sep 2013 13:25:21 +0200
Message-id: <2333262.vSzLePxk45@amdc1227>
In-reply-to: <CAL1wa8cDAui8AJXvmYPpPEWtUum-ZNpW2hQWjwKLpzXBFLv=eA@mail.gmail.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
 <9721965.AJ5fjDQ1RM@amdc1227>
 <CAL1wa8cDAui8AJXvmYPpPEWtUum-ZNpW2hQWjwKLpzXBFLv=eA@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 27 of September 2013 16:48:34 Leela Krishna Amudala wrote:
> Tomasz,
> 
> On Fri, Sep 27, 2013 at 3:42 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > On Monday 23 of September 2013 19:11:11 Tomasz Figa wrote:
> >> On Monday 23 of September 2013 19:03:10 Bartlomiej Zolnierkiewicz wrote:
> >> >
> >> > Hi,
> >> >
> >> > On Wednesday, September 18, 2013 12:20:31 PM Leela Krishna Amudala wrote:
> >> > > Tomasz,
> >> > >
> >> > > On Wed, Sep 18, 2013 at 10:04 AM, Doug Anderson <dianders@chromium.org> wrote:
> >> > > > Tomasz,
> >> > > >
> >> > > > On Tue, Sep 17, 2013 at 6:30 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> >> > > >> I believe this is mandatory on Exynos 5420 and unused on previous SoCs. It
> >> > > >> should be handled depending on compatible value.
> >> > > >
> >> > > > I think at least 5250 needs something similar.  I believe we got away
> >> > > > with it in the past since other (non-WDT) code was tweaking with this
> >> > > > bit, but that was a little bit gross.  Leela Krishna can correct me if
> >> > > > I'm wrong.
> >> > > >
> >> > >
> >> > > Yes, 5250 also needs this reset-mask-bit, but not required by SoCs
> >> > > other than Exynos5xxx.
> >> > > Hence I kept it as optional parameter.
> >> > >
> >> > > I took care of this code such that it won't break on older SoCs.
> >> > >
> >> > > If you notice the code in probe function, I used the check condition
> >> > >
> >> > > if (!IS_ERR(wdt->pmu_disable_reg) && !IS_ERR(wdt->pmu_mask_reset_reg)) {
> >> > > }
> >> > >
> >> > > i.e., if any of the PMU register address is not mentioned in the DT
> >> > > node it simply skips reading reset-mask-bit
> >> > > and continues execution (which may happen in older SoC DT node).
> >> > >
> >> > > ..also, in s3c2410wdt_mask_and_disable_reset() function, below
> >> > > condition check is happening
> >> > >
> >> > > if (IS_ERR(wdt->pmu_disable_reg) || IS_ERR(wdt->pmu_mask_reset_reg)
> >> > >                                 || (wdt->pmu_mask_bit < 0))
> >> > >         return;
> >> > >
> >> > > i.e., if any of the registers is not specified in DT node simply
> >> > > return without programming
> >> > > PMU registers(which is true in case of older SoCs).
> >> > >
> >> > > If you think this doesn't sounds good way of handling older SoCs.
> >> > > I'll add new compatible string for Exynos5xxx and do like what you said. :)
> >> >
> >> > Yes, please re-do the code per Tomasz's suggestions.
> >> >
> >> > This would also allow you to check return values of devm_ioremap_resource()
> >> > calls in the probe method and require them to succeed in order to register
> >> > watchdog device (which is unfortunately not what happens currently).
> >>
> >> Now as I think of it, the driver doesn't seem to reconfigure those PMU
> >> registers in any watchdog API callback, only in probe, remove, suspend
> >> and resume.
> >>
> >> Since we already have PMU "driver" in mach-exynos, which already has
> >> suspend/resume syscore ops, what about placing such configuration there
> >> instead?
> >
> > Any opinions on this?
> >
> 
> In PMU we have control registers for other IPs (like USB, MIPI etc.,)
> also and I'm not sure where those registers are getting configured.
> If we want to configure WDT register in PMU driver then we have to
> consider configuring control regs for other IPs also and the DT node
> has to have all these control bit numbers. So instead of that I feel
> configuring it in WDT driver looks fine.

I believe this depends on possible use cases, not the IP block itself.
If this is just a low level initial (and SoC specific) initialization
that doesn't require any co-operation with high level kernel/userspace
APIs, then I think there is no need to entangle the driver for watchdog
IP with SoC specific details outside the IP itself.

[Adding more people on Cc for further discussion.]

Best regards,
Tomasz

