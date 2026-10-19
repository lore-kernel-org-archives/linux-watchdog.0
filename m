Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019D4229B0;
	Mon, 19 Oct 2026 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406058; cv=none; b=tePMAIR0rEtCmmoHMq5GwCM5zK5ynWm2KgPDIG3KjKUdeDQ4R175bEOEdeQuk8goz7LhxHEOGJ0qKRGstTM4qVrtfm+FdD5z4VhbHQWRFd+niLFwcHrboecXKc4DTN28Xg68mPaBDbO2ljPS2JkVnpIli/8dLjwd9HF/+1LKi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406058; c=relaxed/simple;
	bh=NTDR2Xll57DoFnyRnQaeAjDI184KgSuEj3+KOod0qrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de82XURTRzAgBiHACWTgn2j87wShApP1z7JVEzTWRdBNajPH9TO+EqBoO86wOUCFIVHebFAcPY1BNVNHRAAZx+hEU0EjF+LVtUfr/EHe3LvUMf5O6DicmvfRJz2SC4EI6nuTGba3GNNb/wPGQTgeY3az7uumCgTuQKDj5g4u9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ycAEPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ycAEPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C633C1F000C4;
	Mon, 19 Oct 2026 10:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792406056;
	bh=2isKPp1wM9+mMjBHFJ5/MaR69jAHuUC6g5n2m/A1BPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2ycAEPWKmgq5RpZUV4BFbSKELoNnsF2UxIzYArcV03ep6lSR1UMVTM/0F6S+rW1L
	 42RDUTTdoVQCNBHZ0SqWqQdu9xfnrS7vGwXm0u+IFNXpvfrS4fRQQt08Cr3RFHyWvs
	 Jmra1muXvNfB2RagDnnIifeN9LH8Bo5uILmIdQP7FQs6Qkimkp5DwuUd6zPeoIFz+R
	 LGQUGSLapSzsdxikugc0sULnVNIT/k5d0xxBGu7ij/BV+7nJ47jVhCQUQafe+uboGB
	 w320dTkd4Rfawg/I55MtSRkUUV2QK7k0Ke9XqccSICZzG/1TlWIAPfvk6e0OP+R+VH
	 ycdNXnLxXAVdg==
Date: Mon, 19 Oct 2026 12:34:09 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <atXyIadz1TEKSodg@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local>
 <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local>
 <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
 <asieTvinZ7c2QpQm@red-moon>
 <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>

On Thu, Oct 15, 2026 at 10:46:26PM +0200, Rafael J. Wysocki (Intel) wrote:
> Sorry for the delay.

Thanks for chiming in.

> On Fri, Oct 9, 2026 at 9:57 AM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> >
> > On Tue, Oct 06, 2026 at 05:19:23PM +0100, Robin Murphy wrote:
> > > On 28/09/2026 5:15 pm, Lorenzo Pieralisi wrote:
> > > > On Fri, Sep 25, 2026 at 01:54:26PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Sep 25, 2026 at 12:30:07PM +0200, Lorenzo Pieralisi wrote:
> > > > > > On Fri, Sep 25, 2026 at 12:49:54PM +0300, Andy Shevchenko wrote:
> > > > > > > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > > +static int acpi_static_fwnode_read_u32_prop_index(const struct fwnode_handle *fwnode,
> > > > > > > > +                                             const char *propname,
> > > > > > > > +                                             unsigned int index, u32 *value)
> > > > > > > > +{
> > > > > > > > +   u32 *values;
> > > > > > > > +   int ret, count;
> > > > > > > > +
> > > > > > > > +   count = fwnode_property_count_u32(fwnode, propname);
> > > > > > > > +   if (count < 0)
> > > > > > > > +           return count;
> > > > > > > > +
> > > > > > > > +   if (index >= count)
> > > > > > > > +           return -ENOENT;
> > > > > > > > +
> > > > > > > > +   values = kcalloc(count, sizeof(*values), GFP_KERNEL);
> > > > > > > > +   if (!values)
> > > > > > > > +           return -ENOMEM;
> > > > > > > > +
> > > > > > > > +   ret = fwnode_property_read_u32_array(fwnode, propname, values, count);
> > > > > > > > +   if (!ret)
> > > > > > > > +           *value = values[index];
> > > > > > >
> > > > > > > Use standard pattern, id est
> > > > > > >
> > > > > > >       if (ret)
> > > > > > >               ...
> > > > > > >
> > > > > > > > +   kfree(values);
> > > > > > >
> > > > > > > You want to use __free()
> > > > > > >
> > > > > > > > +   return ret;
> > > > > > > > +}
> > > > > > >
> > > > > > > I believe the whole approach is suboptimal, if you wish get indexed value (but why?)
> > > > > >
> > > > > > Why what (that's what the irq_get() interface requires ?) I agree it is
> > > > > > suboptimal - the whole point of the series is an RFC on using properties
> > > > > > to store GSI number/flags, then how to read them we will optimize it
> > > I>>> when/if we agree that's the approach to be taken.
> > > > >
> > > > > Why to have indexed APIs. The callers usually do not want a single item from an
> > > > > array, they want all of them or a big pile (exception is the array of strings,
> > > > > but we have matching functions for that).
> > > > >
> > > > > As per approach, this patch is against device property and I don't think we are
> > > > > going to agree on the approach taken in *this* patch.
> > > >
> > > > Coming back to this, what is needed here is a way to stash the GSI number,
> > > > flags and name in stardard storage (like OF nodes IRQ properties, ACPI objects
> > > > _CRS, etc).
> > > >
> > > > To give you some background, I thought about adding an array of:
> > > >
> > > > GSI [number, flags, name]
> > > >
> > > > to the ACPI static fwnode itself. Then basically the irq_get() API has got
> > > > all the information it needs from the primary fwnode; while doing that I
> > > > thought that this might have been a bit like reinventing software nodes
> > > > (granted, software node properties are ways more general that what I suggest
> > > > above and I don't expect any other property to be ever added to static fwnodes)
> > > > that's why I put together the series as it is, precisely to understand what's
> > > > best.
> > > >
> > > > When you say "against device property", what do you mean precisely ?
> > > >
> > > > I suppose you mean that this approach goes against software node properties
> > > > usage guidelines ?
> > > >
> > > > Anyway, again, it is just to provide some context, we are talking about
> > > > a bunch of platform devices, it is nice to have a generic solution but
> > > > it has to be simple enough too given its scope, I understand very well
> > > > your concern with this approach as-is - it is there to find a way
> > > > forward together and show what the problem is.
> > >
> > > I guess software node properties look inviting in theory since they're a
> > > ready-made mechanism for effectively attaching arbitrary data to a fwnode,
> > > however looking at patches 6-7 and the amount of boilerplate involved in the
> > > reality, I'm inclined to think that a dedicated structure for static nodes
> > > is probably the best and most efficient compromise here. The redundancy
> > > argument rather falls apart once we end up creating copies of those
> > > contentiously-made-up property name strings for every node, especially given
> > > that any one of those alone is probably already more than the amount of
> > > actual data we need per node...
> > >
> > > Perhaps the "purest" option might be to just store a function pointer in the
> > > fwnode wrapper for each static table type to provide its own internal
> > > irq_get() callback, so not stashing intermediate GSI data at all, but I
> > > suspect that might end up being more work overall.
> >
> > Hi Rafael, Robin,
> >
> > I have not started prototyping it yet but I have got a question as a
> > follow-up to our chat at LPC about crafting an ACPI device for the static
> > table entries and sort out the probe dependencies using autodep.
> >
> > After spur of the moment reaction during the session, I now remember I
> > thought about crafting an ACPI device for the static table entries and
> > started digging then bumped into acpi_add_single_object() as you
> > suggested.
> >
> > The point though is: what about the acpi_handle and the AML required to
> > sort out the dependencies using the _CRS ? We have got the info to fill
> > the _CRS coming from static table entries (MMIO, GSI) but I am not sure how I
> > can form a full-fledged ACPI namespace object in the kernel, without
> > that in place I am not sure how the autodep mechanism can possibly
> > work.
> 
> The missing ACPI handle is not a hard part IMV, it is a matter of
> modifying struct acpi_dep_data to be able to hold struct acpi_device
> pointers instead of ACPI handles in case the devices in question have
> no ACPI handles and adjusting the code using it.
> 
> Finding the dependencies is harder.  I guess it may involve walking
> the namespace and looking up a device object with a specific device ID
> or similar.

All we need to find dependencies is a GSI number, the question though
is what are we really solving by creating a dependency (and where
that GSI number will be stored eventually so that the platform driver
at probe - when dependencies are cleared, can retrieve it).

I think that what we want is preventing a platform device to be created
(ie we don't create platform devices at static table init time anymore
but we let ACPI core do it at acpi_bus_attach(adev)/enumeration time ?)
till the dependencies are cleared but then, without a _CRS, where will
the consumer driver find the platform device resources ?

There are multiple facets in this issue and possibly some of them have
been already solved but I need to pull them together.

> Note that the dependencies can be added to acpi_dep_list after
> creating a struct acpi_device with acpi_add_single_object() and
> acpi_scan_add_dep() is not really suitable for that, but it should be
> doable if the dependencies can be found.
> 
> > I need to have a deeper look into this next week but I wanted to ask first
> > whether there was something I missed - most likely.
> 
> Well, it is not really straightforward.

Yes it is getting messy. This RFC, with all its flaws, does not transparently
prevents enumeration but rather relies on -EPROBE_DEFER to sort out
dependencies - though it does so by adding more stuff into ACPI static fwnode
that to be honest I'd rather see gone.

> I'm still not sure why you can't represent all devices in the ACPI
> namespace in addition to describing some of them in static tables.  I
> guess that would work for everybody, wouldn't it?

That's a fair point - though then code will have to work with firmware
that does NOT explicitly require those devices in the namespace (ie: firmware
as it is specified _now_); it can turn out to be a mess even less
manageable than this discussion ;-)

Any thoughts appreciated.

Thanks,
Lorenzo
