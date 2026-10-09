Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9D3CB2C7;
	Fri,  9 Oct 2026 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532642; cv=none; b=Msn2katlG7XzE6ERLYE7Gho3QEbzM+8w6iDe1YrToS1w7xtalI3njf8LLFYPrfCPAllz5Nrp4Khf6eV59q5E48QyrlR7TUthUIG60PwNFgDr89aI4iel1TLY/Lx7jnzE9OadwxMPPXLElm31/0YfqF9QAdnKcz9vG6kjeISwSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532642; c=relaxed/simple;
	bh=OVgnTlwhqjp5woUBmZR8Z1/tP1JnGEu9IxPV5ssVSmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umrX/8tSUyt4nBVNXeZttGDHToxDMT5sw5kZVyRPZ2YYp5pr28ck69Cqp9wE8GVY4W2oEx9AOXpRIe9ELs/C0NjjqTMPb58LPSg82EetbstN2XqG9gIGzYPV3pS1M4T/KSEIm+Tg06NoJOAgRmWQFwfguR0xLuUeKdCtFAVSwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXBkcs1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXBkcs1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888031F000FF;
	Fri,  9 Oct 2026 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532632;
	bh=7JwBUaKiDw3DL4V1VblyqY4NlQUKc0x+WHZ55mtpZGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iXBkcs1ozdItQ91Qzqsd9bSnGiaVHmmQXgWX31nAahFHARHVMlRC01fE/XmvxTcaB
	 AxmiA9IBMQT1BEgvXWlPPqAKWJ1DK7wtvu/u33eqUlFHZ5HJ518T+j+TlvK48tFoO+
	 vcoithhATsDmOJrOHoFlumiaZLTwOKF1O3v+Lusa8xnFhppIegGSvCTuXkY1zQ1Z+N
	 sEAtMFWBHxxprOVTOQq9vwB98xCsb0zzQaYeZTpImM/zWsPiBhtxLWuBeTdah0I/Tv
	 OcXDTvxQXr65PFPpvxoqiA5WZgehZIlTzQeKPoKAWYRsJm6Zpg939xRbs8gJnnBjV6
	 IaytI+HxCZvKg==
Date: Fri, 9 Oct 2026 09:57:02 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <asieTvinZ7c2QpQm@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local>
 <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local>
 <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>

On Tue, Oct 06, 2026 at 05:19:23PM +0100, Robin Murphy wrote:
> On 28/09/2026 5:15 pm, Lorenzo Pieralisi wrote:
> > On Fri, Sep 25, 2026 at 01:54:26PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 25, 2026 at 12:30:07PM +0200, Lorenzo Pieralisi wrote:
> > > > On Fri, Sep 25, 2026 at 12:49:54PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:
> > > 
> > > ...
> > > 
> > > > > > +static int acpi_static_fwnode_read_u32_prop_index(const struct fwnode_handle *fwnode,
> > > > > > +						  const char *propname,
> > > > > > +						  unsigned int index, u32 *value)
> > > > > > +{
> > > > > > +	u32 *values;
> > > > > > +	int ret, count;
> > > > > > +
> > > > > > +	count = fwnode_property_count_u32(fwnode, propname);
> > > > > > +	if (count < 0)
> > > > > > +		return count;
> > > > > > +
> > > > > > +	if (index >= count)
> > > > > > +		return -ENOENT;
> > > > > > +
> > > > > > +	values = kcalloc(count, sizeof(*values), GFP_KERNEL);
> > > > > > +	if (!values)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	ret = fwnode_property_read_u32_array(fwnode, propname, values, count);
> > > > > > +	if (!ret)
> > > > > > +		*value = values[index];
> > > > > 
> > > > > Use standard pattern, id est
> > > > > 
> > > > > 	if (ret)
> > > > > 		...
> > > > > 
> > > > > > +	kfree(values);
> > > > > 
> > > > > You want to use __free()
> > > > > 
> > > > > > +	return ret;
> > > > > > +}
> > > > > 
> > > > > I believe the whole approach is suboptimal, if you wish get indexed value (but why?)
> > > > 
> > > > Why what (that's what the irq_get() interface requires ?) I agree it is
> > > > suboptimal - the whole point of the series is an RFC on using properties
> > > > to store GSI number/flags, then how to read them we will optimize it
> I>>> when/if we agree that's the approach to be taken.
> > > 
> > > Why to have indexed APIs. The callers usually do not want a single item from an
> > > array, they want all of them or a big pile (exception is the array of strings,
> > > but we have matching functions for that).
> > > 
> > > As per approach, this patch is against device property and I don't think we are
> > > going to agree on the approach taken in *this* patch.
> > 
> > Coming back to this, what is needed here is a way to stash the GSI number,
> > flags and name in stardard storage (like OF nodes IRQ properties, ACPI objects
> > _CRS, etc).
> > 
> > To give you some background, I thought about adding an array of:
> > 
> > GSI [number, flags, name]
> > 
> > to the ACPI static fwnode itself. Then basically the irq_get() API has got
> > all the information it needs from the primary fwnode; while doing that I
> > thought that this might have been a bit like reinventing software nodes
> > (granted, software node properties are ways more general that what I suggest
> > above and I don't expect any other property to be ever added to static fwnodes)
> > that's why I put together the series as it is, precisely to understand what's
> > best.
> > 
> > When you say "against device property", what do you mean precisely ?
> > 
> > I suppose you mean that this approach goes against software node properties
> > usage guidelines ?
> > 
> > Anyway, again, it is just to provide some context, we are talking about
> > a bunch of platform devices, it is nice to have a generic solution but
> > it has to be simple enough too given its scope, I understand very well
> > your concern with this approach as-is - it is there to find a way
> > forward together and show what the problem is.
> 
> I guess software node properties look inviting in theory since they're a
> ready-made mechanism for effectively attaching arbitrary data to a fwnode,
> however looking at patches 6-7 and the amount of boilerplate involved in the
> reality, I'm inclined to think that a dedicated structure for static nodes
> is probably the best and most efficient compromise here. The redundancy
> argument rather falls apart once we end up creating copies of those
> contentiously-made-up property name strings for every node, especially given
> that any one of those alone is probably already more than the amount of
> actual data we need per node...
> 
> Perhaps the "purest" option might be to just store a function pointer in the
> fwnode wrapper for each static table type to provide its own internal
> irq_get() callback, so not stashing intermediate GSI data at all, but I
> suspect that might end up being more work overall.

Hi Rafael, Robin,

I have not started prototyping it yet but I have got a question as a
follow-up to our chat at LPC about crafting an ACPI device for the static
table entries and sort out the probe dependencies using autodep.

After spur of the moment reaction during the session, I now remember I
thought about crafting an ACPI device for the static table entries and
started digging then bumped into acpi_add_single_object() as you
suggested.

The point though is: what about the acpi_handle and the AML required to
sort out the dependencies using the _CRS ? We have got the info to fill
the _CRS coming from static table entries (MMIO, GSI) but I am not sure how I
can form a full-fledged ACPI namespace object in the kernel, without
that in place I am not sure how the autodep mechanism can possibly
work.

I need to have a deeper look into this next week but I wanted to ask first
whether there was something I missed - most likely.

Thanks !
Lorenzo

> 
> Cheers,
> Robin.
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > > > it needs to be retrieved as that in the guts of ACPI. Allocating memory for the whole
> > > > > array to retrieve a single element is simply wrong.
> > > 
> > > ...
> > > 
> > > > > > +#define ACPI_IRQ_PROP_GSI		"linux,acpi-gsi"
> > > > > > +#define ACPI_IRQ_PROP_GSI_TRIGGER	"linux,acpi-gsi-trigger"
> > > > > > +#define ACPI_IRQ_PROP_GSI_POLARITY	"linux,acpi-gsi-polarity"
> > > > > 
> > > > > Oh... This sounds like a big ugly hack.
> > > > 
> > > > That does not help much I am afraid.
> > > > 
> > > > What's a ugly hack ? Property names ? Using properties for this purpose ?
> > > 
> > > Yes, properties started with "linux," for some core functionality.
> > > Yes, using properties for this also doesn't sound right. I think the problem
> > > here is in the table specifications or somewhere that deep. That's why we
> > > ended up in this series.
> > > 
> > > > Again, it is an RFC for this specific reason and I mentioned that in the
> > > > cover letter, thank you for your inputs.
> > > 
> > > And here we have a discussion started :-)
> > > 
> > > P.S. Looks like I was too quick to jump into this thread. I will wait for
> > > others to share their view on all this.
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
> > > 
> 
