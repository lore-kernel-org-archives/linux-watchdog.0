Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:13519 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3I0KM2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 06:12:28 -0400
From: Tomasz Figa <t.figa@samsung.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
Date: Fri, 27 Sep 2013 12:12:13 +0200
Message-id: <9721965.AJ5fjDQ1RM@amdc1227>
In-reply-to: <3933206.EMuKSi641Y@amdc1227>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
 <1918747.quF8QJoP6D@amdc1032> <3933206.EMuKSi641Y@amdc1227>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 23 of September 2013 19:11:11 Tomasz Figa wrote:
> On Monday 23 of September 2013 19:03:10 Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Wednesday, September 18, 2013 12:20:31 PM Leela Krishna Amudala wrote:
> > > Tomasz,
> > > 
> > > On Wed, Sep 18, 2013 at 10:04 AM, Doug Anderson <dianders@chromium.org> wrote:
> > > > Tomasz,
> > > >
> > > > On Tue, Sep 17, 2013 at 6:30 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > > >> I believe this is mandatory on Exynos 5420 and unused on previous SoCs. It
> > > >> should be handled depending on compatible value.
> > > >
> > > > I think at least 5250 needs something similar.  I believe we got away
> > > > with it in the past since other (non-WDT) code was tweaking with this
> > > > bit, but that was a little bit gross.  Leela Krishna can correct me if
> > > > I'm wrong.
> > > >
> > > 
> > > Yes, 5250 also needs this reset-mask-bit, but not required by SoCs
> > > other than Exynos5xxx.
> > > Hence I kept it as optional parameter.
> > > 
> > > I took care of this code such that it won't break on older SoCs.
> > > 
> > > If you notice the code in probe function, I used the check condition
> > > 
> > > if (!IS_ERR(wdt->pmu_disable_reg) && !IS_ERR(wdt->pmu_mask_reset_reg)) {
> > > }
> > > 
> > > i.e., if any of the PMU register address is not mentioned in the DT
> > > node it simply skips reading reset-mask-bit
> > > and continues execution (which may happen in older SoC DT node).
> > > 
> > > ..also, in s3c2410wdt_mask_and_disable_reset() function, below
> > > condition check is happening
> > > 
> > > if (IS_ERR(wdt->pmu_disable_reg) || IS_ERR(wdt->pmu_mask_reset_reg)
> > >                                 || (wdt->pmu_mask_bit < 0))
> > >         return;
> > > 
> > > i.e., if any of the registers is not specified in DT node simply
> > > return without programming
> > > PMU registers(which is true in case of older SoCs).
> > > 
> > > If you think this doesn't sounds good way of handling older SoCs.
> > > I'll add new compatible string for Exynos5xxx and do like what you said. :)
> > 
> > Yes, please re-do the code per Tomasz's suggestions.
> > 
> > This would also allow you to check return values of devm_ioremap_resource()
> > calls in the probe method and require them to succeed in order to register
> > watchdog device (which is unfortunately not what happens currently).
> 
> Now as I think of it, the driver doesn't seem to reconfigure those PMU
> registers in any watchdog API callback, only in probe, remove, suspend
> and resume.
> 
> Since we already have PMU "driver" in mach-exynos, which already has
> suspend/resume syscore ops, what about placing such configuration there
> instead?

Any opinions on this?

Best regards,
Tomasz

