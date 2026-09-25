Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0854825CA;
	Fri, 25 Sep 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333682; cv=none; b=CEurI7HvISnhrgOCuZOrT/GD7wXwVinyJ34Agc5NAw4a05Pahi98HNo2zyGo+OmwbvFMmDcKfF/q5Hadmcr/5Hh56LdYrHEAnJr/dCNTJ9NbKvuNW1ED+XpRezZqRjy4fM4VwySEf6ntYyoXHnOze1dW82dqFDHd6rxzIhwd7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333682; c=relaxed/simple;
	bh=eW3NlcY9rz1RWvEA+xMyp3+IKIZ5dfni2x0WYBdu1Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfpCAlJvuNmnYx6PihRE131irXsH1wWOssdqnJsOqk8CnEeB7HWEopvP9nhwfECCyHYYmstdmudVNIX4mBD4l2u13Uoqb+bOqb0yAqvxJl89IrwzSY+YICPSSKEyg54lT1mjFypnQQC1GzO1+4eltTigQ0l5T0TJMYUehuxcV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kq/BOpGt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kq/BOpGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790333677; x=1821869677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eW3NlcY9rz1RWvEA+xMyp3+IKIZ5dfni2x0WYBdu1Zc=;
  b=kq/BOpGtTggJ0wS6A5+jX7oMGUCjIIxBplVfeO57KYjr6/EpV2dL1NIh
   hCrEPG4TksU6SE3E3HU3iV191HCU6ULQ8MM7gBPJYFjYtUB43Nf1eAQG5
   XJCQBYxnrb3aDazpviTBAjelTWoJ55b0IG5OWjdMirVLtTRHAXpXR05vn
   rrybsdT96YzK1iMpp4CdeVKt41GNl8e8qSTrUknSDByfO+I+xxX0hHPcJ
   g3crElh9zg5DseT3SrA94TsHyIO7WvQzeVSiN2+fag7+o9fYKzTpYMWhu
   R7KFfeIJBg+QxWqeTpubhqIZvoOzcelvr0j8dKL5FTpiLsfht4F8yh6Zw
   g==;
X-CSE-ConnectionGUID: EeyVNUD4RH6io8LEbxbexg==
X-CSE-MsgGUID: XOx7n85qT+uOsdOtrM36iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90076208"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90076208"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 03:54:34 -0700
X-CSE-ConnectionGUID: t7/XvLctRKC6Kwl9xjQKSQ==
X-CSE-MsgGUID: 4Z7fXr+dSeaftPoz/pks3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="272883219"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 03:54:29 -0700
Date: Fri, 25 Sep 2026 13:54:26 +0300
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
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <arZS4vwxps01dGb7@ashevche-desk.local>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local>
 <arZNL9BnTGK0Klwc@red-moon>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arZNL9BnTGK0Klwc@red-moon>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 12:30:07PM +0200, Lorenzo Pieralisi wrote:
> On Fri, Sep 25, 2026 at 12:49:54PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:

...

> > > +static int acpi_static_fwnode_read_u32_prop_index(const struct fwnode_handle *fwnode,
> > > +						  const char *propname,
> > > +						  unsigned int index, u32 *value)
> > > +{
> > > +	u32 *values;
> > > +	int ret, count;
> > > +
> > > +	count = fwnode_property_count_u32(fwnode, propname);
> > > +	if (count < 0)
> > > +		return count;
> > > +
> > > +	if (index >= count)
> > > +		return -ENOENT;
> > > +
> > > +	values = kcalloc(count, sizeof(*values), GFP_KERNEL);
> > > +	if (!values)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = fwnode_property_read_u32_array(fwnode, propname, values, count);
> > > +	if (!ret)
> > > +		*value = values[index];
> > 
> > Use standard pattern, id est
> > 
> > 	if (ret)
> > 		...
> > 
> > > +	kfree(values);
> > 
> > You want to use __free()
> > 
> > > +	return ret;
> > > +}
> > 
> > I believe the whole approach is suboptimal, if you wish get indexed value (but why?)
> 
> Why what (that's what the irq_get() interface requires ?) I agree it is
> suboptimal - the whole point of the series is an RFC on using properties
> to store GSI number/flags, then how to read them we will optimize it
> when/if we agree that's the approach to be taken.

Why to have indexed APIs. The callers usually do not want a single item from an
array, they want all of them or a big pile (exception is the array of strings,
but we have matching functions for that).

As per approach, this patch is against device property and I don't think we are
going to agree on the approach taken in *this* patch.

> > it needs to be retrieved as that in the guts of ACPI. Allocating memory for the whole
> > array to retrieve a single element is simply wrong.

...

> > > +#define ACPI_IRQ_PROP_GSI		"linux,acpi-gsi"
> > > +#define ACPI_IRQ_PROP_GSI_TRIGGER	"linux,acpi-gsi-trigger"
> > > +#define ACPI_IRQ_PROP_GSI_POLARITY	"linux,acpi-gsi-polarity"
> > 
> > Oh... This sounds like a big ugly hack.
> 
> That does not help much I am afraid.
> 
> What's a ugly hack ? Property names ? Using properties for this purpose ?

Yes, properties started with "linux," for some core functionality.
Yes, using properties for this also doesn't sound right. I think the problem
here is in the table specifications or somewhere that deep. That's why we
ended up in this series.

> Again, it is an RFC for this specific reason and I mentioned that in the
> cover letter, thank you for your inputs.

And here we have a discussion started :-)

P.S. Looks like I was too quick to jump into this thread. I will wait for
others to share their view on all this.

-- 
With Best Regards,
Andy Shevchenko


