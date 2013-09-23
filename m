Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33169 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab3IWRDP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Sep 2013 13:03:15 -0400
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <t.figa@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
Date: Mon, 23 Sep 2013 19:03:10 +0200
Message-id: <1918747.quF8QJoP6D@amdc1032>
In-reply-to: <CAL1wa8eWKNL3kdfjqxqaLsAtc8nqgiPW34SBk4gozAR1jnRaSg@mail.gmail.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
 <CAD=FV=XQSLULsYanJCCFehxrs9LESZ=KO8XgyzZaacL4GNeXPA@mail.gmail.com>
 <CAL1wa8eWKNL3kdfjqxqaLsAtc8nqgiPW34SBk4gozAR1jnRaSg@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Hi,

On Wednesday, September 18, 2013 12:20:31 PM Leela Krishna Amudala wrote:
> Tomasz,
> 
> On Wed, Sep 18, 2013 at 10:04 AM, Doug Anderson <dianders@chromium.org> wrote:
> > Tomasz,
> >
> > On Tue, Sep 17, 2013 at 6:30 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> >>> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> >>> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> >>> @@ -7,8 +7,20 @@ occurred.
> >>>  Required properties:
> >>>  - compatible : should be "samsung,s3c2410-wdt"
> >>
> >> Since the WDT block of Exynos 5420 needs some extra configuration in PMU
> >> registers, it is no longer compatible with samsung.s3c2410-wdt. Please
> >> introduce separate compatible ("samsung,exynos5420-wdt") and make the
> >> driver handle the additional configuration only if running on a device with
> >> this compatible value.
> >>
> >> I'd suggest introducing quirk system to the driver and adding a
> >> NEEDS_PMU_CONFIG quirk selected by DT match entry with "samsung,exynos5420-
> >> wdt" compatible.
> >>
> >>>  - reg : base physical address of the controller and length of memory
> >>> mapped -      region.
> >>> +     region and the optional (addresses and length of memory mapped regions
> >>> +     of) PMU registers for masking/unmasking WDT.
> >>>  - interrupts : interrupt number to the cpu.
> >>>
> >>>  Optional properties:
> >>>  - timeout-sec : contains the watchdog timeout in seconds.
> >>> +- reset-mask-bit: bit number in the PMU registers to program mask/unmask
> >>> WDT. +
> >>
> >> I believe this is mandatory on Exynos 5420 and unused on previous SoCs. It
> >> should be handled depending on compatible value.
> >
> > I think at least 5250 needs something similar.  I believe we got away
> > with it in the past since other (non-WDT) code was tweaking with this
> > bit, but that was a little bit gross.  Leela Krishna can correct me if
> > I'm wrong.
> >
> 
> Yes, 5250 also needs this reset-mask-bit, but not required by SoCs
> other than Exynos5xxx.
> Hence I kept it as optional parameter.
> 
> I took care of this code such that it won't break on older SoCs.
> 
> If you notice the code in probe function, I used the check condition
> 
> if (!IS_ERR(wdt->pmu_disable_reg) && !IS_ERR(wdt->pmu_mask_reset_reg)) {
> }
> 
> i.e., if any of the PMU register address is not mentioned in the DT
> node it simply skips reading reset-mask-bit
> and continues execution (which may happen in older SoC DT node).
> 
> ..also, in s3c2410wdt_mask_and_disable_reset() function, below
> condition check is happening
> 
> if (IS_ERR(wdt->pmu_disable_reg) || IS_ERR(wdt->pmu_mask_reset_reg)
>                                 || (wdt->pmu_mask_bit < 0))
>         return;
> 
> i.e., if any of the registers is not specified in DT node simply
> return without programming
> PMU registers(which is true in case of older SoCs).
> 
> If you think this doesn't sounds good way of handling older SoCs.
> I'll add new compatible string for Exynos5xxx and do like what you said. :)

Yes, please re-do the code per Tomasz's suggestions.

This would also allow you to check return values of devm_ioremap_resource()
calls in the probe method and require them to succeed in order to register
watchdog device (which is unfortunately not what happens currently).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

