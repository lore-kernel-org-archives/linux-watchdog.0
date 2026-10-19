Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433288;
	b=RIfi4N/RbfL0VD9lceZXEojFNwIIutIWmQ1z2aMyCLbEv03Otj27PJzITebbXrq04gkM
	 X/apdkKPXVV0d9cBf1euvfOraIi9pyF9c81KZUPWa8pkf2nVhldyTUzPRn7cjR7+nNBhn
	 hE8abPW9gTgvhPSAGBUH5N7BTv5yNsJJMd9uwgQ+59xUM/GV/ANTkc2vVHImnv324yzOH
	 ZSvYqoKpDS21W7RZWY/xd4P6+oKrzD1Rgi6ZcByQZ/sgD8RmhG21WF4R+ow6O1Hs0/8Xd
	 NhsO7Lo9neGgX3kczmtHLfFQ4bFShaAmRqUrE5vlVJpvGjRypyfl13+OxjKcl51Txjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433288;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0yJvOwPfZ5d2rGhnowwpIR6yBLsjsRPjCVACsCnz6cw=;
	b=EioTEZuUtvEeePC1hwdkxly466/YsntV41mE/nH+GDIeG9aHkpwJ74pt14Tn5WGzHPyI
	 GViOuu5pRuZxQ3jCMkb5c7CGHphDTp0kH73p5KL2j7b704sjwWOPTDDWO/59sIlsgJf2J
	 bhX2EjkNYj6o6Spi1HCp1hc0Pzpxk9fMnY15MVMJmkdJBr+8TBRFPxJI++M3Ge4k3nR+E
	 axX7GxlYUCDoCb1T1WvLSlZNoYxbIaci7MBBdBOpA+shrgomJFH9iR96UuIQr+1PB4rtn
	 IIok4+KFz26rei9oA1BXluR01g4d3tolvur5kzY4qhVwlIuYwzBxXLwLUbq/vn9Tn+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ6naX2y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D96606A31A
	for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ6naX2y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0100B1F000CB
	for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433288;
	bh=0yJvOwPfZ5d2rGhnowwpIR6yBLsjsRPjCVACsCnz6cw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WJ6naX2y+idzEv0gJ1YxEYmR0YsFHjn6+3S92nABDj5DGDRxppocrDCtaIWTYy0qg
	 pMa4EoFEdEUUAOKehkLV3kbSJmv4cPu7+d3YyOwLIoWdabVbd9sH558dnFIoUDE+5s
	 MpmKU4s/fbovoDeLZBtziu0BXxZl+kHUwsjTzZb+Gov/uE5ZUO77dhH8lwoGhXA9Om
	 ikrjc7FkO+josYTrzWYtHn+br8HOyppsNJVuY+KNcYbRz9muO+HP4gJ4HzDk5kZpdW
	 zX95wyLip81coHgseUKy5h/hahn1/JuXUXWHuNbR6gNp2iy+4AaZaxd3camC3BGf9B
	 I0DbFYTnFhMMg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso1933453e87.3
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 11:08:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwXQrUP1Rdh+rHTxPy9S6Q0QbCVS/0/KYq7BAuGMEvLhSEG3EZvT1yw0CXDunM08YcdzF2nAThdVSL5C+yoUQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI5nnNCFc/fitrb0MTxk3zHCELmoCSCASvJWLPlr9COzE6K4M3I
	/IsxAsDhpU10GGNiPy1uKe333UEdLEUurHhd41hVDI9arevYn4k76KpOUN5fd8sl10sVh9FmWFM
	gMYG6l+XtVwX98mLonPnQ7r7BB+hb+TY=
X-Received: by 2002:a05:6512:b95:b0:5be:52d8:f70a with SMTP id
 2adb3069b0e04-5be52d8f89emr2829793e87.34.1792433286328; Mon, 19 Oct 2026
 11:08:06 -0700 (PDT)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local> <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local> <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com> <asieTvinZ7c2QpQm@red-moon>
 <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com> <atXyIadz1TEKSodg@red-moon>
In-Reply-To: <atXyIadz1TEKSodg@red-moon>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 19 Oct 2026 20:05:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
X-Gm-Features: AclHuK9KYDE64m8huu2HeNgeVrCBa6dkbPQ8_E7l8BP-IVa43wPKwt6awgXhlNs
Message-ID: <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
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

On Mon, Oct 19, 2026 at 12:34=E2=80=AFPM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Thu, Oct 15, 2026 at 10:46:26PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > Sorry for the delay.
>
> Thanks for chiming in.
>
> > On Fri, Oct 9, 2026 at 9:57=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@ke=
rnel.org> wrote:
> > >
> > > On Tue, Oct 06, 2026 at 05:19:23PM +0100, Robin Murphy wrote:
> > > > On 28/09/2026 5:15 pm, Lorenzo Pieralisi wrote:
> > > > > On Fri, Sep 25, 2026 at 01:54:26PM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, Sep 25, 2026 at 12:30:07PM +0200, Lorenzo Pieralisi wro=
te:
> > > > > > > On Fri, Sep 25, 2026 at 12:49:54PM +0300, Andy Shevchenko wro=
te:
> > > > > > > > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi=
 wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > > +static int acpi_static_fwnode_read_u32_prop_index(const =
struct fwnode_handle *fwnode,
> > > > > > > > > +                                             const char =
*propname,
> > > > > > > > > +                                             unsigned in=
t index, u32 *value)
> > > > > > > > > +{
> > > > > > > > > +   u32 *values;
> > > > > > > > > +   int ret, count;
> > > > > > > > > +
> > > > > > > > > +   count =3D fwnode_property_count_u32(fwnode, propname)=
;
> > > > > > > > > +   if (count < 0)
> > > > > > > > > +           return count;
> > > > > > > > > +
> > > > > > > > > +   if (index >=3D count)
> > > > > > > > > +           return -ENOENT;
> > > > > > > > > +
> > > > > > > > > +   values =3D kcalloc(count, sizeof(*values), GFP_KERNEL=
);
> > > > > > > > > +   if (!values)
> > > > > > > > > +           return -ENOMEM;
> > > > > > > > > +
> > > > > > > > > +   ret =3D fwnode_property_read_u32_array(fwnode, propna=
me, values, count);
> > > > > > > > > +   if (!ret)
> > > > > > > > > +           *value =3D values[index];
> > > > > > > >
> > > > > > > > Use standard pattern, id est
> > > > > > > >
> > > > > > > >       if (ret)
> > > > > > > >               ...
> > > > > > > >
> > > > > > > > > +   kfree(values);
> > > > > > > >
> > > > > > > > You want to use __free()
> > > > > > > >
> > > > > > > > > +   return ret;
> > > > > > > > > +}
> > > > > > > >
> > > > > > > > I believe the whole approach is suboptimal, if you wish get=
 indexed value (but why?)
> > > > > > >
> > > > > > > Why what (that's what the irq_get() interface requires ?) I a=
gree it is
> > > > > > > suboptimal - the whole point of the series is an RFC on using=
 properties
> > > > > > > to store GSI number/flags, then how to read them we will opti=
mize it
> > > > I>>> when/if we agree that's the approach to be taken.
> > > > > >
> > > > > > Why to have indexed APIs. The callers usually do not want a sin=
gle item from an
> > > > > > array, they want all of them or a big pile (exception is the ar=
ray of strings,
> > > > > > but we have matching functions for that).
> > > > > >
> > > > > > As per approach, this patch is against device property and I do=
n't think we are
> > > > > > going to agree on the approach taken in *this* patch.
> > > > >
> > > > > Coming back to this, what is needed here is a way to stash the GS=
I number,
> > > > > flags and name in stardard storage (like OF nodes IRQ properties,=
 ACPI objects
> > > > > _CRS, etc).
> > > > >
> > > > > To give you some background, I thought about adding an array of:
> > > > >
> > > > > GSI [number, flags, name]
> > > > >
> > > > > to the ACPI static fwnode itself. Then basically the irq_get() AP=
I has got
> > > > > all the information it needs from the primary fwnode; while doing=
 that I
> > > > > thought that this might have been a bit like reinventing software=
 nodes
> > > > > (granted, software node properties are ways more general that wha=
t I suggest
> > > > > above and I don't expect any other property to be ever added to s=
tatic fwnodes)
> > > > > that's why I put together the series as it is, precisely to under=
stand what's
> > > > > best.
> > > > >
> > > > > When you say "against device property", what do you mean precisel=
y ?
> > > > >
> > > > > I suppose you mean that this approach goes against software node =
properties
> > > > > usage guidelines ?
> > > > >
> > > > > Anyway, again, it is just to provide some context, we are talking=
 about
> > > > > a bunch of platform devices, it is nice to have a generic solutio=
n but
> > > > > it has to be simple enough too given its scope, I understand very=
 well
> > > > > your concern with this approach as-is - it is there to find a way
> > > > > forward together and show what the problem is.
> > > >
> > > > I guess software node properties look inviting in theory since they=
're a
> > > > ready-made mechanism for effectively attaching arbitrary data to a =
fwnode,
> > > > however looking at patches 6-7 and the amount of boilerplate involv=
ed in the
> > > > reality, I'm inclined to think that a dedicated structure for stati=
c nodes
> > > > is probably the best and most efficient compromise here. The redund=
ancy
> > > > argument rather falls apart once we end up creating copies of those
> > > > contentiously-made-up property name strings for every node, especia=
lly given
> > > > that any one of those alone is probably already more than the amoun=
t of
> > > > actual data we need per node...
> > > >
> > > > Perhaps the "purest" option might be to just store a function point=
er in the
> > > > fwnode wrapper for each static table type to provide its own intern=
al
> > > > irq_get() callback, so not stashing intermediate GSI data at all, b=
ut I
> > > > suspect that might end up being more work overall.
> > >
> > > Hi Rafael, Robin,
> > >
> > > I have not started prototyping it yet but I have got a question as a
> > > follow-up to our chat at LPC about crafting an ACPI device for the st=
atic
> > > table entries and sort out the probe dependencies using autodep.
> > >
> > > After spur of the moment reaction during the session, I now remember =
I
> > > thought about crafting an ACPI device for the static table entries an=
d
> > > started digging then bumped into acpi_add_single_object() as you
> > > suggested.
> > >
> > > The point though is: what about the acpi_handle and the AML required =
to
> > > sort out the dependencies using the _CRS ? We have got the info to fi=
ll
> > > the _CRS coming from static table entries (MMIO, GSI) but I am not su=
re how I
> > > can form a full-fledged ACPI namespace object in the kernel, without
> > > that in place I am not sure how the autodep mechanism can possibly
> > > work.
> >
> > The missing ACPI handle is not a hard part IMV, it is a matter of
> > modifying struct acpi_dep_data to be able to hold struct acpi_device
> > pointers instead of ACPI handles in case the devices in question have
> > no ACPI handles and adjusting the code using it.
> >
> > Finding the dependencies is harder.  I guess it may involve walking
> > the namespace and looking up a device object with a specific device ID
> > or similar.
>
> All we need to find dependencies is a GSI number, the question though
> is what are we really solving by creating a dependency (and where
> that GSI number will be stored eventually so that the platform driver
> at probe - when dependencies are cleared, can retrieve it).
>
> I think that what we want is preventing a platform device to be created
> (ie we don't create platform devices at static table init time anymore
> but we let ACPI core do it at acpi_bus_attach(adev)/enumeration time ?)

Basically, yes, the idea is to defer the creation of the platform
device until the dependency is met.

> till the dependencies are cleared but then, without a _CRS, where will
> the consumer driver find the platform device resources ?

Well, good question.

> There are multiple facets in this issue and possibly some of them have
> been already solved but I need to pull them together.
>
> > Note that the dependencies can be added to acpi_dep_list after
> > creating a struct acpi_device with acpi_add_single_object() and
> > acpi_scan_add_dep() is not really suitable for that, but it should be
> > doable if the dependencies can be found.
> >
> > > I need to have a deeper look into this next week but I wanted to ask =
first
> > > whether there was something I missed - most likely.
> >
> > Well, it is not really straightforward.
>
> Yes it is getting messy. This RFC, with all its flaws, does not transpare=
ntly
> prevents enumeration but rather relies on -EPROBE_DEFER to sort out
> dependencies - though it does so by adding more stuff into ACPI static fw=
node
> that to be honest I'd rather see gone.

I think what you need is a notification mechanism that will trigger
when a specific device (enumerated via the ACPI Namespace) becomes
operational.  It doesn't look like any of the existing ones (platform
device probe deferral or ACPI device dependencies tracking) is really
suitable for your use case.

> > I'm still not sure why you can't represent all devices in the ACPI
> > namespace in addition to describing some of them in static tables.  I
> > guess that would work for everybody, wouldn't it?
>
> That's a fair point - though then code will have to work with firmware
> that does NOT explicitly require those devices in the namespace (ie: firm=
ware
> as it is specified _now_); it can turn out to be a mess even less
> manageable than this discussion ;-)

If it has to work under these conditions anyway, then adding stuff to
the namespace is rather pointless.
