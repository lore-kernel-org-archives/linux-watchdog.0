Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F647CC62;
	Tue, 29 Sep 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671424; cv=none; b=LAOYvPdaHZQzoT0FAIpd+FPU1vy/npKATeyBzlzf7ArSKjcuOGyzT8xS5yXak2P4+m5tpc6w7zy+1bQDfpZkIz26E0mvNdYdK+4F4uVhsEbpDOM/7JhUC2s0XQWMFqYbY8V6AmiMG/4nj9mlBXvMvKZOQZ247OBdXsiCgTwbnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671424; c=relaxed/simple;
	bh=DI9VBTYLYVYdL6svrMpP+kaYJQt8U+UxM5lBR6ovqDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hde/z6tZGODxh2+4WK//eFT2Yx8FTJ2TGTNPMheks4PPtfZqWGPSEGoAQTOVKTpEEhBEKvJhy48BXn9QKW79RncCPdVsvmWRqkrfIB4RMTeHS6wppBUcRND66965Uh0EPL+TxDUp2HYdH+1oM8nA68Ubowm8DjbHi5y6mHZqOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzlXAIlq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzlXAIlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585C51F00893;
	Tue, 29 Sep 2026 08:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671423;
	bh=/kaL8yN3QljuQSjvdkWYP0iZEH5AUWpebqZtTfgcbUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bzlXAIlq46fGXbmD+F4bJWYZ3lFZKM4eDA4r2hRZSE4rs0lKPVBsJkbq/tcnkG5A/
	 iW74M5k3IsLMB1L/Wq+5oy2mKaFXjgeHnl/fcJ/EaQx00BmmQlP2KQi4PenT/npHrp
	 aS2AycOTRRjvtq2ovyxu5B00KWem0qNvE54FGOodZBWrEppQLaLUs330Q1qpkfHgfv
	 r6U7bAdE7z8r8iMlIbXqxCbz1ZfIEh3pgvRRjYSQkshkl/ZgaJagDRb1FekZPVYotH
	 x994/INRNVw6Imhqj9sfkEFiiuwbaNV5WNExL+WAL4QN2CKD2P4cqelf+vFqM0p4Q/
	 SaQbUHKrIaepw==
Date: Tue, 29 Sep 2026 10:43:36 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 10/11] iommu/arm-smmu-v3: Add IRQ mapping
 -EPROBE_DEFER handling
Message-ID: <art6OOFPXggDIet9@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-10-2c62125d0085@kernel.org>
 <arrtFFtK7KgQfr0z@hu-ashoraj-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arrtFFtK7KgQfr0z@hu-ashoraj-lv.qualcomm.com>

On Mon, Sep 28, 2026 at 03:41:24PM -0700, Ashok Raj wrote:
> On Fri, Sep 25, 2026 at 09:48:09AM +0200, Lorenzo Pieralisi wrote:
> > With the advent of GICv5, IRQs mapping can fail if the interrupt
> > controller the wired SMMU interrupts are routed to has not probed
> > yet when the SMMU driver probes.
> > 
> > Handle -EPROBE_DEFER gracefully for IRQ mappings failures.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 5732f3ba0122..1832389916a4 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -5562,18 +5562,26 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >  	/* Interrupt lines */
> >  
> >  	irq = platform_get_irq_byname_optional(pdev, "combined");
> > +	if (irq == -EPROBE_DEFER)
> > +		return dev_err_probe(dev, irq, "failed to get combined IRQ\n");
> >  	if (irq > 0)
> >  		smmu->combined_irq = irq;
> >  	else {
> >  		irq = platform_get_irq_byname_optional(pdev, "eventq");
> > +		if (irq == -EPROBE_DEFER)
> > +			return dev_err_probe(dev, irq, "failed to get eventq IRQ\n");
> >  		if (irq > 0)
> >  			smmu->evtq.q.irq = irq;
> >  
> >  		irq = platform_get_irq_byname_optional(pdev, "priq");
> > +		if (irq == -EPROBE_DEFER)
> > +			return dev_err_probe(dev, irq, "failed to get priq IRQ\n");
> >  		if (irq > 0)
> >  			smmu->priq.q.irq = irq;
> >  
> >  		irq = platform_get_irq_byname_optional(pdev, "gerror");
> > +		if (irq == -EPROBE_DEFER)
> > +			return dev_err_probe(dev, irq, "failed to get gerror IRQ\n");
> >  		if (irq > 0)
> >  			smmu->gerr_irq = irq;
> >  	}
> 
> minor: 
> 
> Maybe consolidate the multiple if (irq == -EPROBE_DEFER) parts and
> consolidate the return to one place?

Yes that can be done, not even sure the different log strings are worth having
in the first place.

Again, the whole series aim is an RFC to understand what's best to implement
the deferral mechanism, I patched the consumer drivers just for completeness.

Thanks,
Lorenzo
