Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44361 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbeF0Sda (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 27 Jun 2018 14:33:30 -0400
Date: Wed, 27 Jun 2018 11:33:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
Message-ID: <20180627183327.GD16753@roeck-us.net>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
> Hi Guenter/Rob,
> 
> Kindly let me know how you want to proceed with this?
> 

If I recall correctly, the patch series does not add a new problem
but merely exposes one. Is my recollection correct ? If so, maybe
we should just add a note somewhere indicating what might be wrong
and otherwise apply the series.

Does this make sense ?

Guenter

> Thanks,
> 
> Ray
> 
> On 6/6/2018 4:39 PM, Ray Jui wrote:
> >
> >
> >On 6/6/2018 9:33 AM, Rob Herring wrote:
> >>On Wed, Jun 6, 2018 at 11:19 AM, Guenter Roeck <linux@roeck-us.net>
> >>wrote:
> >>>On 06/05/2018 12:41 PM, Rob Herring wrote:
> >>>>
> >>>>On Mon, May 28, 2018 at 11:01:32AM -0700, Ray Jui wrote:
> >>>>>
> >>>>>Consolidate two SP805 binding documents "arm,sp805.txt" and
> >>>>>"sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
> >>>>>desired compatible string to be used
> >>>>>
> >>>>>Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >>>>>---
> >>>>>   .../devicetree/bindings/watchdog/arm,sp805.txt     | 27
> >>>>>++++++++++++++-----
> >>>>>   .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31
> >>>>>----------------------
> >>>>>   2 files changed, 20 insertions(+), 38 deletions(-)
> >>>>>   delete mode 100644
> >>>>>Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> >>>>
> >>>>
> >>>>Would be good to get a ACK from FSL/NXP person on this. It looks to me
> >>>>like the driver fetches the wrong clock as it gets the first one and
> >>>>the
> >>>>driver really wants 'wdog_clk'. In any case, their dts files should be
> >>>>updated.
> >>>>
> >>>
> >>>This is really confusing, since he deleted file lists apb_pclk first.
> >>>Does the watchdog driver need apb_pclk or wdog_clk ? That isn't clear
> >>>to me.
> >>>arch/arm64/boot/dts/hisilicon/hi3660.dtsi only provides apb_pclk, or at
> >>>least
> >>>it says so.
> >>
> >>Note that that clock source is 32KHz. That is obviously a mistake
> >>because no one clocks their bus/register interface at 32KHz. Someone
> >>just filled in something that happened to work.
> >>
> >>>The fsl dts files all have apb_pclk first.
> >>
> >>It's all kind of a mess, but fortunately one we should be able to
> >>clean-up.
> >>
> >
> >It is indeed a mess. Note the SP805 driver only derive one clock from DT,
> >and that's not done based on name. As a result, the first clock defined in
> >DT will be fetched and the rate calculation will be carried out based on
> >that clock rate.
> >
> >I assumed the clock entries and their names defined in the binding
> >document are just placeholders, at least for the 2nd clock.
> >
> >Based on how the current driver is, the first clock needs to be the
> >WDOGCLK for things to work properly.
> >
> >According to the SP805 TRM, APB clock is the PCLK, that drives the bus for
> >register access.
> >
> >The relationship between WDOGCLK and PCLK is defined as:
> >
> >- the rising edges of WDOGCLK must be synchronous and
> >balanced with a rising edge of PCLK
> >
> >- the WDOGCLK frequency cannot be greater than the PCLK
> >frequency
> >
> >>The compatible string changes too, but AMBA bus devices don't actually
> >>use the compatible string as they use the ID registers to match. I
> >>suppose some other OS could do things differently. Worth the risk to
> >>clean-up IMO.
> >>
> >>>
> >>>Either case, why are two clocks asked for in the first place ? Are there
> >>>situations where the second clock is actually used/useful ?
> >>
> >>For clocks, the bus needs "apb_pclk" and the driver just gets the
> >>first clock. The driver is obviously going to want the functional
> >>clock that determines the counter rate. That should
> >>
> >>Primecell peripherals are about the only ones that have clear specs
> >>WRT clock inputs. Yet we've still managed to screw them up. There are
> >>2 clocks in the spec, so the DT has (or should have) 2 clocks.
> >>
> >>Rob
> >>
> >
> >Let me know how you guys want to proceed with this?
> >
> >Thanks,
> >
> >Ray
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
