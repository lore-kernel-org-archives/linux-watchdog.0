Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55516 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934387AbeF0Smg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 27 Jun 2018 14:42:36 -0400
Date: Wed, 27 Jun 2018 11:42:34 -0700
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
Message-ID: <20180627184234.GA19538@roeck-us.net>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
 <20180627183327.GD16753@roeck-us.net>
 <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 27, 2018 at 11:38:48AM -0700, Ray Jui wrote:
> 
> 
> On 6/27/2018 11:33 AM, Guenter Roeck wrote:
> >On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
> >>Hi Guenter/Rob,
> >>
> >>Kindly let me know how you want to proceed with this?
> >>
> >
> >If I recall correctly, the patch series does not add a new problem
> >but merely exposes one. Is my recollection correct ? If so, maybe
> >we should just add a note somewhere indicating what might be wrong
> >and otherwise apply the series.
> >
> >Does this make sense ?
> 
> Yes this makes a lot of sense to me. This patch series exposes potential
> problems in some SoCs that they might not be feeding the correct clock into
> WDT, at least based on clock names from their DT entries.
> 
> This patch series does not change/affect how SP805 works on those systems.
> 
> Where should the note be added?
> 

I would suggest to add a note into the driver where the clock is used,
with the details discussed here.

Does this make sense ?

Thanks,
Guenter
