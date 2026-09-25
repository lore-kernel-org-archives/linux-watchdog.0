Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7028B7C8;
	Fri, 25 Sep 2026 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329939; cv=none; b=Mqr1onNMUYxNGZyOa36yLeKzfmVpAtM4/ckphJ3LEXcrNQOqy1LvpJtp69cSrDeHQU/s1xdC2o7x6+W0USVAOKnxpX4GasPAGG+xeyGJhi3OIcaweIr2SmrriG2z6YefZfggBU8m5WbsTbXeGdaRck2/ASIVxDFGrcWu9dluSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329939; c=relaxed/simple;
	bh=c3Wlh2Q2VXVEe5gte86lqh134KXeDG/AwBNnURu4sHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ1xEhOv1vZAdEu3008JUghn4ablX3x7qGrtkDXswPuiknDa2fiQuUrA67TxxW5VfWQC9RDUZTx+lB7doH1JyUFenIKDgLotBRmxfKEYpfXoipiazhgMEe9HRDVYrLMl4pa0p9G97V1TVLeJ6xLQSxlBC9/fjVC4a61vW9tbIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBs5nMR/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBs5nMR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790329937; x=1821865937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c3Wlh2Q2VXVEe5gte86lqh134KXeDG/AwBNnURu4sHo=;
  b=ZBs5nMR/tfcoPxB6aRPaynUtlYf2AwR8htOQh/a1coJnvIEXCjBpiN9n
   qeyJtULYqy8SbmsRWcUZ6sUgJqVf7SLlCLruWdbyfyNSS/i/6pd28nVEJ
   ennfIh+tD7N8ErbhadW3C0OptxTeWi0dmtNn3vLN/pTm3JKgbG3ChtkZw
   M+6/qWQ87JN6x9R7AR+/ARpm7kSYjEmfAHeBZQPdmLCUeUDI7d3cMXOv4
   SXuz+Fr+OBP/EVJZkLk3/qcIGH5ZChzycX1akxnqNWlV0a8nv/OVBmEiG
   /JKUtT/GcFpeTHCK5iBP9LNqbGAPFZa2IpOoRsPbQQDX6C46XeQCsd7gC
   g==;
X-CSE-ConnectionGUID: jAOc37oESeK5w7MikcX84Q==
X-CSE-MsgGUID: NLRipG9eT1eKhubl1jJlVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101640042"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="101640042"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:52:17 -0700
X-CSE-ConnectionGUID: B730t5QVQ4CoaRahwCerbQ==
X-CSE-MsgGUID: SuxLZS75QH6YE12CTCZKrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="273783342"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:52:12 -0700
Date: Fri, 25 Sep 2026 12:52:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 04/11] clocksource/drivers/arm_arch_timer_mmio:
 Dispose IRQ mappings on probe failure
Message-ID: <arZESXn4xUJoVRss@ashevche-desk.local>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-4-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-4-2c62125d0085@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 09:48:03AM +0200, Lorenzo Pieralisi wrote:
> On probe failure the driver does not dispose the IRQ mappings that
> were carried out before the probe function hit an error condition.
> 
> Add code to dispose the IRQ mappings on driver probe failure.

> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---

Same here about Cc list...

...

> +static void arch_timer_mmio_unmap_irq(int *irq)
> +{
> +	if (irq && *irq) {

Would be better to read and maintain with the negative check.

> +		irq_dispose_mapping(*irq);
> +		*irq = 0;
> +	}
> +}

...

> +static void arch_timer_mmio_unmap_irqs(struct arch_timer_mem *gt_block)
> +{
> +	int i;

Why signed?

> +	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {

	for (unsigned int i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {

> +		struct arch_timer_mem_frame *frame = &gt_block->frame[i];
> +
> +		if (!frame->valid)
> +			continue;
> +
> +		arch_timer_mmio_unmap_frame_irqs(frame);
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


