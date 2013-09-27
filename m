Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:40858 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab3I0LS6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 07:18:58 -0400
MIME-Version: 1.0
In-Reply-To: <9721965.AJ5fjDQ1RM@amdc1227>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
 <1918747.quF8QJoP6D@amdc1032> <3933206.EMuKSi641Y@amdc1227> <9721965.AJ5fjDQ1RM@amdc1227>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Fri, 27 Sep 2013 16:48:34 +0530
Message-ID: <CAL1wa8cDAui8AJXvmYPpPEWtUum-ZNpW2hQWjwKLpzXBFLv=eA@mail.gmail.com>
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
To: Tomasz Figa <t.figa@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Leela Krishna Amudala <l.krishna@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tomasz,

On Fri, Sep 27, 2013 at 3:42 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> On Monday 23 of September 2013 19:11:11 Tomasz Figa wrote:
>> On Monday 23 of September 2013 19:03:10 Bartlomiej Zolnierkiewicz wrote:
>> >
>> > Hi,
>> >
>> > On Wednesday, September 18, 2013 12:20:31 PM Leela Krishna Amudala wrote:
>> > > Tomasz,
>> > >
>> > > On Wed, Sep 18, 2013 at 10:04 AM, Doug Anderson <dianders@chromium.org> wrote:
>> > > > Tomasz,
>> > > >
>> > > > On Tue, Sep 17, 2013 at 6:30 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>> > > >> I believe this is mandatory on Exynos 5420 and unused on previous SoCs. It
>> > > >> should be handled depending on compatible value.
>> > > >
>> > > > I think at least 5250 needs something similar.  I believe we got away
>> > > > with it in the past since other (non-WDT) code was tweaking with this
>> > > > bit, but that was a little bit gross.  Leela Krishna can correct me if
>> > > > I'm wrong.
>> > > >
>> > >
>> > > Yes, 5250 also needs this reset-mask-bit, but not required by SoCs
>> > > other than Exynos5xxx.
>> > > Hence I kept it as optional parameter.
>> > >
>> > > I took care of this code such that it won't break on older SoCs.
>> > >
>> > > If you notice the code in probe function, I used the check condition
>> > >
>> > > if (!IS_ERR(wdt->pmu_disable_reg) && !IS_ERR(wdt->pmu_mask_reset_reg)) {
>> > > }
>> > >
>> > > i.e., if any of the PMU register address is not mentioned in the DT
>> > > node it simply skips reading reset-mask-bit
>> > > and continues execution (which may happen in older SoC DT node).
>> > >
>> > > ..also, in s3c2410wdt_mask_and_disable_reset() function, below
>> > > condition check is happening
>> > >
>> > > if (IS_ERR(wdt->pmu_disable_reg) || IS_ERR(wdt->pmu_mask_reset_reg)
>> > >                                 || (wdt->pmu_mask_bit < 0))
>> > >         return;
>> > >
>> > > i.e., if any of the registers is not specified in DT node simply
>> > > return without programming
>> > > PMU registers(which is true in case of older SoCs).
>> > >
>> > > If you think this doesn't sounds good way of handling older SoCs.
>> > > I'll add new compatible string for Exynos5xxx and do like what you said. :)
>> >
>> > Yes, please re-do the code per Tomasz's suggestions.
>> >
>> > This would also allow you to check return values of devm_ioremap_resource()
>> > calls in the probe method and require them to succeed in order to register
>> > watchdog device (which is unfortunately not what happens currently).
>>
>> Now as I think of it, the driver doesn't seem to reconfigure those PMU
>> registers in any watchdog API callback, only in probe, remove, suspend
>> and resume.
>>
>> Since we already have PMU "driver" in mach-exynos, which already has
>> suspend/resume syscore ops, what about placing such configuration there
>> instead?
>
> Any opinions on this?
>

In PMU we have control registers for other IPs (like USB, MIPI etc.,)
also and I'm not sure where those registers are getting configured.
If we want to configure WDT register in PMU driver then we have to
consider configuring control regs for other IPs also and the DT node
has to have all these control bit numbers. So instead of that I feel
configuring it in WDT driver looks fine.

Best Wishes,
Leela Krishna.

> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
