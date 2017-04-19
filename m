Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765545AbdDSPJv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Apr 2017 11:09:51 -0400
Date: Wed, 19 Apr 2017 16:09:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rruigrok@codeaurora.org, wim@iguana.be,
        wei@redhat.com, al.stone@linaro.org, tn@semihalf.com,
        timur@codeaurora.org, daniel.lezcano@linaro.org,
        linux-acpi@vger.kernel.org, linux@roeck-us.net,
        harba@codeaurora.org, julien.grall@arm.com,
        linux-watchdog@vger.kernel.org, arnd@arndb.de,
        marc.zyngier@arm.com, jcm@redhat.com, cov@codeaurora.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        graeme.gregory@linaro.org, linux-kernel@vger.kernel.org,
        leo.duran@amd.com, Suravee.Suthikulpanit@amd.com,
        sudeep.holla@arm.com, christoffer.dall@linaro.org
Subject: Re: [PATCH v24 08/11] acpi: Introduce acpi_unregister_irq function
Message-ID: <20170419150916.GI27829@leverpostej>
References: <20170414184014.8524-1-fu.wei@linaro.org>
 <20170414184014.8524-9-fu.wei@linaro.org>
 <20170418155841.GK17866@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418155841.GK17866@leverpostej>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 18, 2017 at 04:58:41PM +0100, Mark Rutland wrote:
> On Sat, Apr 15, 2017 at 02:40:11AM +0800, fu.wei@linaro.org wrote:
> > From: Fu Wei <fu.wei@linaro.org>
> > 
> > This patch introduces acpi_unregister_irq function to free a
> > linux IRQ number<->GSI mapping by a given linux IRQ number.
> > 
> > Even we have successfully registered the GSI, when some error occurs, we
> > may need to unmap it for freeing the IRQ resource. But in some cases, we
> > only have IRQ, but not GSI.
> > 
> > This patch is the preparation for memory-mapped timer support in GTDT
> > driver.
> > 
> > Signed-off-by: Fu Wei <fu.wei@linaro.org>
> > ---
> >  drivers/acpi/irq.c   | 10 ++++++++++
> >  include/linux/acpi.h |  7 +++++++
> >  2 files changed, 17 insertions(+)
> 
> This will need comments/acks from the ACPI folk.

I've now reworked the cleanup to not require this API, and will drop
this patch.

Thanks,
Mark.
