Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990CB59C99C
	for <linux-watchdog@vger.kernel.org>; Thu, 15 Oct 2026 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097323; cv=none; b=prWvQpdF2UDCbQD960XXcYUD7aWQhlI2KpHvx/WDvG5QdxpOhQrXEeqqygikrHnyvx11YMlhT4gHke2iySidK/DnJFyEJ2Ys7jFX8k77Y+CItYHCJmvNFUTSBtFrMUeLz8L/YXtzThEZt8rj26Q4sltUp+tJPaUG0hm6Ya1GyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097323; c=relaxed/simple;
	bh=xaEjKs9uYoaK1rWbKH1mNgyaJjN0O2ZtD6LiYw3mop8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBf7pJXteSEspkCA2YrilMcGBbvfOyPUU11FTmdTEkdmHqlFlvUaUQakRmeZ5gSSg3ohKaAO3sM4ziYXgbDFocnbKNmfCjNalOe4+BY0CI9GSZLzDTMPc9XznUTgtG99dri8lJ63jyLwe1CzyqmQWj52MlP1YTIRPgvm8zVDI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Hj8kNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Hj8kNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCC71F000C9
	for <linux-watchdog@vger.kernel.org>; Thu, 15 Oct 2026 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792097318;
	bh=a7yiMjjkdLQO3PNrhwbNdhn6qAcJaSjM3V5hz1K+dJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N4Hj8kNExJ+JrnujyZgbMsvOCoHJkVG+LP1Cs5qQYG2SzdxPEJ5FCtLWEbQsyHgXI
	 9clxLwV3a4NKbgPdCIZEwhx8L++HUAZUm31eT3Hy3+pUqllHtdGjuzActhIuBR0xzY
	 Lk/A+aTOZa30skPjWB4GlhBhVkf+5z9NtYCr0HOoNbLnNWO6I/iTBnQk0uNEWpJhV6
	 K//dzvwd9eyVITmdoBN5Dd9KY/Ba1KpyCudTZvkSBzOPkhNqD4aEioNzd8wsmvI/dI
	 V71pqFEUFimqYwFxiyHEoN54iyC5H+0+071j00kVQfIXVqBM7KvRBstXI7Go9NP2hL
	 oo3fry8DJiLLw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be47159f2bso473434e87.2
        for <linux-watchdog@vger.kernel.org>; Thu, 15 Oct 2026 13:48:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxR1AsPf8IhuyuqobabnsaJ6UwnkCQBblFSdAv7NH/a8CJHj1+7OHXvNCBZUdXzAmSeSgKHwnUeVX0e+PalQA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKxBVudJdybh0wTAlprcapdFT4yH/RWZOEsdoa3E1bgLvwBj6ye
	NAWYDYZ5sTmGTHQXXHBuMtKo024x1+/IUHSo/DF4P78yN+AETRVhXl8eP4Y+vJhVOjwBQueR3yZ
	3NBx5SBGRQfY3kOP4NhPmtX9SYUBJlgk=
X-Received: by 2002:a05:6512:2c99:b0:5be:456e:7bf5 with SMTP id
 2adb3069b0e04-5be456e7d65mr691240e87.2.1792097317209; Thu, 15 Oct 2026
 13:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local> <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local> <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com> <asieTvinZ7c2QpQm@red-moon>
In-Reply-To: <asieTvinZ7c2QpQm@red-moon>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 22:46:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
X-Gm-Features: AclHuK-DuoXI-ze6OR_y67J91aOnhT8WYRNmJVSaRmfvir6JKBEzZ6K-TrcO_zw
Message-ID: <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delay.

On Fri, Oct 9, 2026 at 9:57=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kernel=
.org> wrote:
>
> On Tue, Oct 06, 2026 at 05:19:23PM +0100, Robin Murphy wrote:
> > On 28/09/2026 5:15 pm, Lorenzo Pieralisi wrote:
> > > On Fri, Sep 25, 2026 at 01:54:26PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Sep 25, 2026 at 12:30:07PM +0200, Lorenzo Pieralisi wrote:
> > > > > On Fri, Sep 25, 2026 at 12:49:54PM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wro=
te:
> > > >
> > > > ...
> > > >
> > > > > > > +static int acpi_static_fwnode_read_u32_prop_index(const stru=
ct fwnode_handle *fwnode,
> > > > > > > +                                             const char *pro=
pname,
> > > > > > > +                                             unsigned int in=
dex, u32 *value)
> > > > > > > +{
> > > > > > > +   u32 *values;
> > > > > > > +   int ret, count;
> > > > > > > +
> > > > > > > +   count =3D fwnode_property_count_u32(fwnode, propname);
> > > > > > > +   if (count < 0)
> > > > > > > +           return count;
> > > > > > > +
> > > > > > > +   if (index >=3D count)
> > > > > > > +           return -ENOENT;
> > > > > > > +
> > > > > > > +   values =3D kcalloc(count, sizeof(*values), GFP_KERNEL);
> > > > > > > +   if (!values)
> > > > > > > +           return -ENOMEM;
> > > > > > > +
> > > > > > > +   ret =3D fwnode_property_read_u32_array(fwnode, propname, =
values, count);
> > > > > > > +   if (!ret)
> > > > > > > +           *value =3D values[index];
> > > > > >
> > > > > > Use standard pattern, id est
> > > > > >
> > > > > >       if (ret)
> > > > > >               ...
> > > > > >
> > > > > > > +   kfree(values);
> > > > > >
> > > > > > You want to use __free()
> > > > > >
> > > > > > > +   return ret;
> > > > > > > +}
> > > > > >
> > > > > > I believe the whole approach is suboptimal, if you wish get ind=
exed value (but why?)
> > > > >
> > > > > Why what (that's what the irq_get() interface requires ?) I agree=
 it is
> > > > > suboptimal - the whole point of the series is an RFC on using pro=
perties
> > > > > to store GSI number/flags, then how to read them we will optimize=
 it
> > I>>> when/if we agree that's the approach to be taken.
> > > >
> > > > Why to have indexed APIs. The callers usually do not want a single =
item from an
> > > > array, they want all of them or a big pile (exception is the array =
of strings,
> > > > but we have matching functions for that).
> > > >
> > > > As per approach, this patch is against device property and I don't =
think we are
> > > > going to agree on the approach taken in *this* patch.
> > >
> > > Coming back to this, what is needed here is a way to stash the GSI nu=
mber,
> > > flags and name in stardard storage (like OF nodes IRQ properties, ACP=
I objects
> > > _CRS, etc).
> > >
> > > To give you some background, I thought about adding an array of:
> > >
> > > GSI [number, flags, name]
> > >
> > > to the ACPI static fwnode itself. Then basically the irq_get() API ha=
s got
> > > all the information it needs from the primary fwnode; while doing tha=
t I
> > > thought that this might have been a bit like reinventing software nod=
es
> > > (granted, software node properties are ways more general that what I =
suggest
> > > above and I don't expect any other property to be ever added to stati=
c fwnodes)
> > > that's why I put together the series as it is, precisely to understan=
d what's
> > > best.
> > >
> > > When you say "against device property", what do you mean precisely ?
> > >
> > > I suppose you mean that this approach goes against software node prop=
erties
> > > usage guidelines ?
> > >
> > > Anyway, again, it is just to provide some context, we are talking abo=
ut
> > > a bunch of platform devices, it is nice to have a generic solution bu=
t
> > > it has to be simple enough too given its scope, I understand very wel=
l
> > > your concern with this approach as-is - it is there to find a way
> > > forward together and show what the problem is.
> >
> > I guess software node properties look inviting in theory since they're =
a
> > ready-made mechanism for effectively attaching arbitrary data to a fwno=
de,
> > however looking at patches 6-7 and the amount of boilerplate involved i=
n the
> > reality, I'm inclined to think that a dedicated structure for static no=
des
> > is probably the best and most efficient compromise here. The redundancy
> > argument rather falls apart once we end up creating copies of those
> > contentiously-made-up property name strings for every node, especially =
given
> > that any one of those alone is probably already more than the amount of
> > actual data we need per node...
> >
> > Perhaps the "purest" option might be to just store a function pointer i=
n the
> > fwnode wrapper for each static table type to provide its own internal
> > irq_get() callback, so not stashing intermediate GSI data at all, but I
> > suspect that might end up being more work overall.
>
> Hi Rafael, Robin,
>
> I have not started prototyping it yet but I have got a question as a
> follow-up to our chat at LPC about crafting an ACPI device for the static
> table entries and sort out the probe dependencies using autodep.
>
> After spur of the moment reaction during the session, I now remember I
> thought about crafting an ACPI device for the static table entries and
> started digging then bumped into acpi_add_single_object() as you
> suggested.
>
> The point though is: what about the acpi_handle and the AML required to
> sort out the dependencies using the _CRS ? We have got the info to fill
> the _CRS coming from static table entries (MMIO, GSI) but I am not sure h=
ow I
> can form a full-fledged ACPI namespace object in the kernel, without
> that in place I am not sure how the autodep mechanism can possibly
> work.

The missing ACPI handle is not a hard part IMV, it is a matter of
modifying struct acpi_dep_data to be able to hold struct acpi_device
pointers instead of ACPI handles in case the devices in question have
no ACPI handles and adjusting the code using it.

Finding the dependencies is harder.  I guess it may involve walking
the namespace and looking up a device object with a specific device ID
or similar.

Note that the dependencies can be added to acpi_dep_list after
creating a struct acpi_device with acpi_add_single_object() and
acpi_scan_add_dep() is not really suitable for that, but it should be
doable if the dependencies can be found.

> I need to have a deeper look into this next week but I wanted to ask firs=
t
> whether there was something I missed - most likely.

Well, it is not really straightforward.

I'm still not sure why you can't represent all devices in the ACPI
namespace in addition to describing some of them in static tables.  I
guess that would work for everybody, wouldn't it?
