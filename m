Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41772 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeF0Sza (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 27 Jun 2018 14:55:30 -0400
Date: Wed, 27 Jun 2018 11:55:29 -0700
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
Message-ID: <20180627185529.GB19743@roeck-us.net>
References: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
 <20180627183327.GD16753@roeck-us.net>
 <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
 <20180627184234.GA19538@roeck-us.net>
 <8483f675-0c7d-4b0f-25fd-a5eff4bc7937@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8483f675-0c7d-4b0f-25fd-a5eff4bc7937@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 27, 2018 at 11:47:21AM -0700, Ray Jui wrote:
> 
> 
> On 6/27/2018 11:42 AM, Guenter Roeck wrote:
> >On Wed, Jun 27, 2018 at 11:38:48AM -0700, Ray Jui wrote:
> >>
> >>
> >>On 6/27/2018 11:33 AM, Guenter Roeck wrote:
> >>>On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
> >>>>Hi Guenter/Rob,
> >>>>
> >>>>Kindly let me know how you want to proceed with this?
> >>>>
> >>>
> >>>If I recall correctly, the patch series does not add a new problem
> >>>but merely exposes one. Is my recollection correct ? If so, maybe
> >>>we should just add a note somewhere indicating what might be wrong
> >>>and otherwise apply the series.
> >>>
> >>>Does this make sense ?
> >>
> >>Yes this makes a lot of sense to me. This patch series exposes potential
> >>problems in some SoCs that they might not be feeding the correct clock into
> >>WDT, at least based on clock names from their DT entries.
> >>
> >>This patch series does not change/affect how SP805 works on those systems.
> >>
> >>Where should the note be added?
> >>
> >
> >I would suggest to add a note into the driver where the clock is used,
> >with the details discussed here.
> 
> I assume you meant adding the notes to the SP805 driver where the clock is
> used.
> 
> If so, I think that makes sense. That notes deserves its own patch because
> it really has nothing to do with any of the change in this patch series.
> 
> Do you want me to 1) embed that patch into this patch series and send out
> v5; or 2) leave the patch series as it is and send out a separate patch to
> add the notes to the driver?
> 
2) is fine. I don't have the series here right now; if I recall correctly
all patches in the series are all marked as Reviewed-by: and/or Acked-by:.
If so, I'll apply them to my tree tonight, or at least the ones that will
go in through the watchdog tree.

Guenter
