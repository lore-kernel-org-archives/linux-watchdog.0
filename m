Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573601;
	b=YBhq+x/Z3XfPZwd9BbqaeAvMh9xlr5fi1tV2XLNhy0oU2OMaWWIu5xIhh6BxE697Vibk
	 rmEAN63By0K9uKaF7H0o8asP4atTfVwPOm5Kqztmshunbe/3VbwAQjQGg7aTaWyvmTwXU
	 knFN4L3mPmwbEifGYsqs6rbbCf9TeR5irqTvk2Wbt8J/1gkymNX3srxrVSIpPeQsFXB+1
	 vpn46j0w8c8RAZTBAvu00FXK/upnjsMHlSInfSa7h9Mz+E+jrY045R+L+AWpt08mx1/jU
	 roVPA9JQ9v8W7V8k3h/8yoehMJ6hZwHtxFpa5S7RI8rum5grUz9ozsJJmHSRWHxbbPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573601;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=vSS1WWn/ggetKOBLUbWaNnFFsMjByCm0f95BaaBVfMk=;
	b=rqtgRWh9hj7V4V3a6njR5ImWLlv45iBkQ05RJxA+LZ/N43uItbULYPTE1SwjDWgyyrzr
	 okzVJpb98TXZ01ar4OQlBoIHIcCC0haZocaUGwq25kWWpwGsJ73+BDfi9567Sw97V3TNt
	 lf8zlh16rYmgxZVmscv0IQtKbxqHCrtRjGab1nxt4FdZTVU5vsRBOtZ74NizD6NiKqy7S
	 +sFR2hpnVDBgs8D6Zd0XBRk+M30YkT6J6mcBvlFxPHfhA7lXQjzd0i2QcLhAwcJKcf7nX
	 VJa4y0V0MFTPvsyGkdVakHU2tHHlNSKTCO0JFEVt0UCF5O4jXhFWAIuMItQirF9gG8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSEshD96;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA3606A319;
	Wed, 21 Oct 2026 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSEshD96
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D3D1F000C9;
	Wed, 21 Oct 2026 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792573600;
	bh=vSS1WWn/ggetKOBLUbWaNnFFsMjByCm0f95BaaBVfMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lSEshD96KlFwImuJmXbsSDz9RmF0KKXIJsHAGH+hysJab6kr07dWIyuLKc296ew57
	 exkHOAROwJYlBTZmHlyYSpSU5zCOeBEkyLFSr/4fEAYLWjf1UU+ICQVij7n/FuiRxp
	 3rAhTZccZFhIuwT45vXWRDE+M43MDdkseb1l9brVVIQf0tE17wR7KC7PV1324QKOW9
	 R8Xyn/7+c2fXU/4sLvGaCo3++d1704GiODuR9neuTZPbh4jSOVZXsWdtbpoIMpd51l
	 OYUsH9tHVeNuWg7EZFY01nlyljTDYStuTyRUK+eSrdGJoFAx5EJT3CapxbkRqFn0lv
	 F9o1DAxACZqyg==
Date: Wed, 21 Oct 2026 11:06:33 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <atiAmZSPiRNBAO5O@red-moon>
References: <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local>
 <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
 <asieTvinZ7c2QpQm@red-moon>
 <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon>
 <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon>
 <athimRqtDvQu1ZzA@ashevche-desk.local>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <athimRqtDvQu1ZzA@ashevche-desk.local>

On Wed, Oct 21, 2026 at 09:58:33AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 20, 2026 at 05:30:00PM +0200, Lorenzo Pieralisi wrote:
> > On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > On Mon, Oct 19, 2026 at 12:34 PM Lorenzo Pieralisi
> > > <lpieralisi@kernel.org> wrote:
> 
> [...]
> 
> > > Basically, yes, the idea is to defer the creation of the platform
> > > device until the dependency is met.
> > > 
> > > > till the dependencies are cleared but then, without a _CRS, where will
> > > > the consumer driver find the platform device resources ?
> > > 
> > > Well, good question.
> > > 
> > > > There are multiple facets in this issue and possibly some of them have
> > > > been already solved but I need to pull them together.
> > > >
> > > > > Note that the dependencies can be added to acpi_dep_list after
> > > > > creating a struct acpi_device with acpi_add_single_object() and
> > > > > acpi_scan_add_dep() is not really suitable for that, but it should be
> > > > > doable if the dependencies can be found.
> > > > >
> > > > > > I need to have a deeper look into this next week but I wanted to ask first
> > > > > > whether there was something I missed - most likely.
> > > > >
> > > > > Well, it is not really straightforward.
> > > >
> > > > Yes it is getting messy. This RFC, with all its flaws, does not transparently
> > > > prevents enumeration but rather relies on -EPROBE_DEFER to sort out
> > > > dependencies - though it does so by adding more stuff into ACPI static fwnode
> > > > that to be honest I'd rather see gone.
> > > 
> > > I think what you need is a notification mechanism that will trigger
> > > when a specific device (enumerated via the ACPI Namespace) becomes
> > > operational.  It doesn't look like any of the existing ones (platform
> > > device probe deferral or ACPI device dependencies tracking) is really
> > > suitable for your use case.
> > 
> > Yes. It might just be a notification from ACPI core to say "the driver for
> > this ACPI device probed, go create platform devices that depends on it".
> > 
> > We can check and track the dependency in code that does create those
> > devices today.
> > 
> > I will think about this to see how bad this might look like.
> 
> Don't we do something similar in drivers/acpi/x86/lpss.c?

I suppose I can add a notifier that checks whether the device whose
companion represents the ACPI device a given platform device IRQ depends
on was bound to its driver and then map the IRQ and add the platform device
_then_ - after all that's what acpi_dev_clear_dependencies() does (similar
at least).

There is still the question - where the GSI number, flags should be
stashed so that the notifier can grab them in a uniform way. We
could simply attach platform data storing those values to a pdev, either on
a per static table basis or generalize the data so that a single notifier
would be able to deal with it.

That or I can just piggyback on acpi_dev_clear_dependencies() and add
a separate dep mechanism to acpi_dep_data that instead of being acpi_handle
based the consumer is fwnode based (something Rafael mentioned before).

I will have a stab at this and see what's the least bad solution I can
come up with.

I suppose we are scrapping the -EPROBE_DEFER solution (ie this set),
what we are talking about above won't need to defer anything other
than the time when platform devices are added.

Thanks,
Lorenzo
