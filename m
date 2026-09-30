Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF591457E7F;
	Wed, 30 Sep 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754994; cv=none; b=cgxBpbU18vgfuo37OsCivsB1eMWlh4NXZxgDhRSdZs6RxC9+VvpXsi24/DPT+DlNlXzZ6Yb1fHCTUacMKdiTUsU3LPmfYZiGlJh89lkn7Y4HnDF9mgYQIrAcsJ8LPeqCK3/F53xSaI8DOIAUTtVBr3FQu1Osf/IQouW7OIeY2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754994; c=relaxed/simple;
	bh=qfBD7mkuKmouucL0LHWaXkROgW7LHPkYYRDsvYtBZNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjyfHMxZ6nGfHynllcm7Fu7MaZFEMuA4j2yjJz4ifvSa554OHtoBExWofTcBAsfGG/8rHDGE1LHiDHDyBo76PSx6OE378Ca8ZWKKI6htSFmyco8QfoLNJiGw6216QlkxM7x2ws2+Rth4Moq1zQDKNnPcpmQ3WpnzPTcJ9ii6fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i89SYrP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i89SYrP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4728B1F000FF;
	Wed, 30 Sep 2026 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790754992;
	bh=xL6M0dr5FX7bEZLB4pEnUkdcIL4YjSX8nLQPwIT5Zzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i89SYrP8uoUOW63arVdATXVuZH9y+kHuAUwU2N0UGVY94DWwNd2K7x/EKMapEQVv2
	 IS3kZU8IQdtUbPMdMBwhZM6iXY4jKf0Fjfr+CLnKACgkbMqTegribBZxPXuGqW37SI
	 V7Dy6PcWs6l1EKldjWnXwAcyB2uHLXgdmhUpIZDmeZ6RDMNVivQTbewanLOKGj0/Nw
	 YZTyMxUhi5R0AW5hS+q9NUt6pU5Y9GQYUthgafm93QVh4LLtAMf0aoQJcmj+Qh7TKt
	 A4xvaRF2ROzvt2xapbNlc1Xwjz+inDZ42dlbHzdFa5OS8rzLPfLvFJZ4lflr1SMC2F
	 LPpBIT4uCLTBQ==
Date: Wed, 30 Sep 2026 09:56:24 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <arzAqMOmSVl_PzH5@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arr3IhF0bwN4uzUP@hu-ashoraj-lv.qualcomm.com>
 <art5m5QPXAOAvkvW@red-moon>
 <arxZ7BAya5ntRi6t@hu-ashoraj-lv.qualcomm.com>
 <ary9AGmVWDuez7Ax@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ary9AGmVWDuez7Ax@ashevche-desk.local>

On Wed, Sep 30, 2026 at 10:40:48AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 29, 2026 at 05:38:04PM -0700, Ashok Raj wrote:
> > On Tue, Sep 29, 2026 at 10:40:59AM +0200, Lorenzo Pieralisi wrote:
> > > On Mon, Sep 28, 2026 at 04:24:18PM -0700, Ashok Raj wrote:
> > > > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:
> 
> ...
> 
> > > > > +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI_POLARITY,
> > > > > +						index, &polarity);
> > 
> > For each of the above calls for read_u32_prop_index() the allocation,
> > copy a value and does free it. 
> > 
> > Instead you could read the whole array, and just get each value and
> > discard it once? 
> 
> This was my question as well. But I formulated it differently.

Same answer (and actually two properties are enough), yes that should
be done, if using software nodes is the way to go, which does not
look like, that's the whole reason behind this series, understanding
where to stash GSI numbers, flags and names. It is a working proof
of concept to get this debated and resolved, hopefully next week at LPC.

Thanks,
Lorenzo
