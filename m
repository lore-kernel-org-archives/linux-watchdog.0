Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933598AbcKKPcr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 11 Nov 2016 10:32:47 -0500
Date: Fri, 11 Nov 2016 15:32:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
        harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
        graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
        wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, Suravee.Suthikulpanit@amd.com,
        leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, tn@semihalf.com,
        christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
Message-ID: <20161111153205.GI11945@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
 <20161020163719.GC27598@leverpostej>
 <5825CBB5.8090104@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5825CBB5.8090104@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 11, 2016 at 09:46:29PM +0800, Hanjun Guo wrote:
> On 10/21/2016 12:37 AM, Mark Rutland wrote:
> >On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei@linaro.org wrote:
> >>+static int __init map_gt_gsi(u32 interrupt, u32 flags)
> >>+{
> >>+	int trigger, polarity;
> >>+
> >>+	if (!interrupt)
> >>+		return 0;
> >
> >Urgh.
> >
> >Only the secure interrupt (which we do not need) is optional in this
> >manner, and (hilariously), zero appears to also be a valid GSIV, per
> >figure 5-24 in the ACPI 6.1 spec.
> >
> >So, I think that:
> >
> >(a) we should not bother parsing the secure interrupt
> >(b) we should drop the check above
> >(c) we should report the spec issue to the ASWG
> 
> Sorry, I willing to do that, but I need to figure out the issue here.
> What kind of issue in detail? do you mean that zero should not be valid
> for arch timer interrupts?

As above, zero is a valid GSIV, and is valid for the non-secure timer
interrupts. The check is wrong for non-secure interrupts.

We can ignore the secure timer interrupt since it's irrelevant to us,
and remove the check.

Regardless, the spec is inconsistent w.r.t. the secure interrupt being
zero if not present, since zero is a valid GSIV. That should be reported
to the ASWG.

Thanks,
Mark.
