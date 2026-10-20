Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510237;
	b=LB9E4//lgsWctPLWOW3Wlm9MU0Rakzz8nIvwmM2hXVfCDFFQ/z/KC8eO5ANxuTdn5rav
	 fK4HveblR5nU07UyaDzTTG6wfNYJyOVP+zjfGQhVUSUxtLDXQnOGy7z3c4zTNg6pw0C8+
	 ugTB/6N6Av3/mQK5Y6DcLQSNBy7JCpc6dSsnqvMuNvuTvLTt+W14iAsIONoWvw1EEiJUV
	 A17uOBDquYbcq3B6cTyjoOGjVpRcteaisweM2ODv6uTpk+1q/UV+XVTtu7vCPX1YtfDEW
	 4epWjgqdj0DrsrspcveUHFzNnLGUeG+kyk+auRjrfuIpfEOP0fYqXJZy92uYr2EQyLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510237;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=VMqDibeEONqAJsijitjSdM1kHE4HWDS9vh+bBPboeGQ=;
	b=W4izgiXOszXhfT4SKHo/HprQv5rrjZ0cLuw02ODw8tBgn8CBqbgnC6hdjz+DvBMNgO/Y
	 QpZZ+CAQNHgxPOO3X3FxBFu0gvz2bzzsVKqYlBvh2c1mLW+3KxLRbbsUUIlDGlvoyWpTb
	 b+EIopMdtVstA4BeBia/oZEliCY4lJ7/GMyTqqKyZddj7ZWAGIDCxT6t6kthnwEJcWBZE
	 xMIyi1d+9y53b9z46PCl4VEvZ1KT2K0WqMVbhN8dIoDUicrUY29dJ9Q0TnhMbi8Ge+EJC
	 +4LrXtbbTlqzNEs1Lw3mfuhYivtNiX+/vKSW5RBdu2oiYVT4F7R6rTvX7a20Q9Anzew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87432606A324;
	Tue, 20 Oct 2026 15:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4933D1F000C8;
	Tue, 20 Oct 2026 15:30:32 +0000 (UTC)
Date: Tue, 20 Oct 2026 17:30:00 +0200
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
Message-ID: <ateI-JcExDyfXKrs@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local>
 <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local>
 <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
 <asieTvinZ7c2QpQm@red-moon>
 <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon>
 <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>

On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Mon, Oct 19, 2026 at 12:34 PM Lorenzo Pieralisi
> <lpieralisi@kernel.org> wrote:

[...]

> Basically, yes, the idea is to defer the creation of the platform
> device until the dependency is met.
> 
> > till the dependencies are cleared but then, without a _CRS, where will
> > the consumer driver find the platform device resources ?
> 
> Well, good question.
> 
> > There are multiple facets in this issue and possibly some of them have
> > been already solved but I need to pull them together.
> >
> > > Note that the dependencies can be added to acpi_dep_list after
> > > creating a struct acpi_device with acpi_add_single_object() and
> > > acpi_scan_add_dep() is not really suitable for that, but it should be
> > > doable if the dependencies can be found.
> > >
> > > > I need to have a deeper look into this next week but I wanted to ask first
> > > > whether there was something I missed - most likely.
> > >
> > > Well, it is not really straightforward.
> >
> > Yes it is getting messy. This RFC, with all its flaws, does not transparently
> > prevents enumeration but rather relies on -EPROBE_DEFER to sort out
> > dependencies - though it does so by adding more stuff into ACPI static fwnode
> > that to be honest I'd rather see gone.
> 
> I think what you need is a notification mechanism that will trigger
> when a specific device (enumerated via the ACPI Namespace) becomes
> operational.  It doesn't look like any of the existing ones (platform
> device probe deferral or ACPI device dependencies tracking) is really
> suitable for your use case.

Yes. It might just be a notification from ACPI core to say "the driver for
this ACPI device probed, go create platform devices that depends on it".

We can check and track the dependency in code that does create those
devices today.

I will think about this to see how bad this might look like.

> > > I'm still not sure why you can't represent all devices in the ACPI
> > > namespace in addition to describing some of them in static tables.  I
> > > guess that would work for everybody, wouldn't it?
> >
> > That's a fair point - though then code will have to work with firmware
> > that does NOT explicitly require those devices in the namespace (ie: firmware
> > as it is specified _now_); it can turn out to be a mess even less
> > manageable than this discussion ;-)
> 
> If it has to work under these conditions anyway, then adding stuff to
> the namespace is rather pointless.

Yes that's the problem, reworking the code to make it work with namespace
devices is doable the issue is existing firmware and that we can't change it
(and we can't create it in the kernel either).

Thanks,
Lorenzo
