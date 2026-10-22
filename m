Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665286;
	b=CqL+NikafF5QSi1MocNnsxo3B8lZbpYhOZgpjozVCtKJzj+ZN3lUn7XY2gdPdVDC8XYp
	 qTX5u5nmBZqJYr2XAenqle2iyRTaADsZq5LEatk6hvyOaExifKt2YC6ywIE0l2V7e25MQ
	 lE5KdbOlMfDiLTc0+vF23Mj6H3TzDUcN5tk4qE324e400gX59DaKpX96ZOnPP3de/T0W3
	 b7Ed7m+5+Ul79gG5p+WU0Bo64YYDC91EEZPYGs+KQTPieK3uORTmbc1pYCAxv1sg01882
	 SlKFb99qTYHtGV8pEYQZ5EcNzHUXV2zAXb/TOr3Tf8K9DrKstoRS3lWY8xiwthC8Mpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665286;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fGLqzeHj9nniEWw/kgUcLX4W43BoRvMfa82J3ope2Mw=;
	b=Pr0KUcDxpTdQa1eWrulff9Uf0+5XTpKv/Vbwh4Z5G5KMXiiQ/ScWtfHXyjck0yC01axX
	 sUV3Jz/6UCDvOXZD7X8SAXFupDHdUy9souzieDEU7sneBKcD9ZURao7dVkTil6gtoGjim
	 xFoEPEQtgVq2dpmiQrbTloLb5QgBlOSzQDkB0CQKDSTcgeKmgcJgiVidi2MAijfk/n12J
	 Q/TCI/rQ0yub9wlhlpdaBvWaMDLk1YGZVqvFdA9ZMm49tedi23FD14OdBQW2sFkYVx9MU
	 b0+gnVK7FLmbJyYqT3UP9TK1ra/XF73YiafXpo9yh9aleb48WHTox5qRNRqKspHvxIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UT+nhYR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB43606A32D
	for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UT+nhYR5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B931F000C9
	for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792665286;
	bh=fGLqzeHj9nniEWw/kgUcLX4W43BoRvMfa82J3ope2Mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UT+nhYR5qOFPRyn2jaBBc9YQZoUAkt8EEuVdUraJfGs7KFoIsciYZPgBvSSUUO1yK
	 Pnr8pc4uMhP8VIcGYXCKvz0BtURK/jAnaZtWwAvPwtq7m+Y3IhrMI3aQsNDHmZPK7s
	 ZdGKKgrzu1oYRpsD+DMzeKIqkvkGjyttfa4ubHYmUQGd8WzN5T8IwD2ZFa49xzt+cP
	 Xwp26gknYljUfHMI1JQGfzpHBzR1ichFO2REncN049KwTUFsiFEhDj4HlnTGRgs9Fs
	 VW15lREqBJHRt9A4qdXylcy0QFeMGx7WUTfsUoxpJ2YQmSGoAOTCygTKJZVl1BPczK
	 R9seOPWz9LFzA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso1559689e87.3
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 03:34:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxUr8H/1B1Mq/w68DKKmCAwi9kt4afzTL0UMX0928QJIaVpMZ4Z2bDq0AQlT2/fCVOvJvvuTlv0DqO2OatKKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYILFugm0c4daj4k4azT79+6ydoUniHSqcbDzYwLwV3tJOmHNel5
	iUstHWsoaHP5PrZnKTGs7dRkMpBarkzK9BYg8r8PTqxCX4DbqWb/6N6YWxsNWDAU0/tSLXuPyUY
	rFAIfrA57Y0Go2U0SZHUnOGIrcjLLtNE=
X-Received: by 2002:a05:6512:1593:b0:5be:50d5:1909 with SMTP id
 2adb3069b0e04-5bfa1bee9bbmr1886774e87.27.1792665284175; Thu, 22 Oct 2026
 03:34:44 -0700 (PDT)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <arqSqcoWAkhy-8do@red-moon> <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
 <asieTvinZ7c2QpQm@red-moon> <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon> <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon> <athimRqtDvQu1ZzA@ashevche-desk.local>
 <atiAmZSPiRNBAO5O@red-moon> <7f077fd3-9c67-409a-b46f-7f28a55c180b@arm.com> <atmwo3Bpi62kB8_n@red-moon>
In-Reply-To: <atmwo3Bpi62kB8_n@red-moon>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 12:32:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g56LP+EQc6MQ1H_5XnQALEn3CV9Q9HGCoiuMvpkK+N+A@mail.gmail.com>
X-Gm-Features: AclHuK_l7z2nlAJujq_gWhjivoVbKF5EgcQYOoHNkTz7qy_TJ117SkG3BFjwQLM
Message-ID: <CAJZ5v0g56LP+EQc6MQ1H_5XnQALEn3CV9Q9HGCoiuMvpkK+N+A@mail.gmail.com>
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev, 
	linux-watchdog@vger.kernel.org, Grant Likely <grant.likely@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 8:43=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Wed, Oct 21, 2026 at 12:18:39PM +0100, Robin Murphy wrote:
> > On 2026-10-21 10:06 am, Lorenzo Pieralisi wrote:
> > > On Wed, Oct 21, 2026 at 09:58:33AM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 20, 2026 at 05:30:00PM +0200, Lorenzo Pieralisi wrote:
> > > > > On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (Inte=
l) wrote:
> > > > > > On Mon, Oct 19, 2026 at 12:34=E2=80=AFPM Lorenzo Pieralisi
> > > > > > <lpieralisi@kernel.org> wrote:
> > > >
> > > > [...]
> > > >
> > > > > > Basically, yes, the idea is to defer the creation of the platfo=
rm
> > > > > > device until the dependency is met.
> > > > > >
> > > > > > > till the dependencies are cleared but then, without a _CRS, w=
here will
> > > > > > > the consumer driver find the platform device resources ?
> > > > > >
> > > > > > Well, good question.
> > > > > >
> > > > > > > There are multiple facets in this issue and possibly some of =
them have
> > > > > > > been already solved but I need to pull them together.
> > > > > > >
> > > > > > > > Note that the dependencies can be added to acpi_dep_list af=
ter
> > > > > > > > creating a struct acpi_device with acpi_add_single_object()=
 and
> > > > > > > > acpi_scan_add_dep() is not really suitable for that, but it=
 should be
> > > > > > > > doable if the dependencies can be found.
> > > > > > > >
> > > > > > > > > I need to have a deeper look into this next week but I wa=
nted to ask first
> > > > > > > > > whether there was something I missed - most likely.
> > > > > > > >
> > > > > > > > Well, it is not really straightforward.
> > > > > > >
> > > > > > > Yes it is getting messy. This RFC, with all its flaws, does n=
ot transparently
> > > > > > > prevents enumeration but rather relies on -EPROBE_DEFER to so=
rt out
> > > > > > > dependencies - though it does so by adding more stuff into AC=
PI static fwnode
> > > > > > > that to be honest I'd rather see gone.
> > > > > >
> > > > > > I think what you need is a notification mechanism that will tri=
gger
> > > > > > when a specific device (enumerated via the ACPI Namespace) beco=
mes
> > > > > > operational.  It doesn't look like any of the existing ones (pl=
atform
> > > > > > device probe deferral or ACPI device dependencies tracking) is =
really
> > > > > > suitable for your use case.
> > > > >
> > > > > Yes. It might just be a notification from ACPI core to say "the d=
river for
> > > > > this ACPI device probed, go create platform devices that depends =
on it".
> > > > >
> > > > > We can check and track the dependency in code that does create th=
ose
> > > > > devices today.
> > > > >
> > > > > I will think about this to see how bad this might look like.
> > > >
> > > > Don't we do something similar in drivers/acpi/x86/lpss.c?
> > >
> > > I suppose I can add a notifier that checks whether the device whose
> > > companion represents the ACPI device a given platform device IRQ depe=
nds
> > > on was bound to its driver and then map the IRQ and add the platform =
device
> > > _then_ - after all that's what acpi_dev_clear_dependencies() does (si=
milar
> > > at least).
> > >
> > > There is still the question - where the GSI number, flags should be
> > > stashed so that the notifier can grab them in a uniform way. We
> > > could simply attach platform data storing those values to a pdev, eit=
her on
> > > a per static table basis or generalize the data so that a single noti=
fier
> > > would be able to deal with it.
> > >
> > > That or I can just piggyback on acpi_dev_clear_dependencies() and add
> > > a separate dep mechanism to acpi_dep_data that instead of being acpi_=
handle
> > > based the consumer is fwnode based (something Rafael mentioned before=
).
> > >
> > > I will have a stab at this and see what's the least bad solution I ca=
n
> > > come up with.
> > >
> > > I suppose we are scrapping the -EPROBE_DEFER solution (ie this set),
> > > what we are talking about above won't need to defer anything other
> > > than the time when platform devices are added.
> >
> > I dunno, that seems pretty drastic for some use-cases - the fact that a=
 GSI
> > is described in a table doesn't necessarily mean it is critical to devi=
ce
> > operation. If we don't even create the device until all possible resour=
ces
> > are available, then its driver never has any chance to decide whether i=
t's
> > happy to ignore the deferral and just use MSIs or polling instead...
>
> I agree with you (but that's what we do for ACPI autodep and AFAICS OF
> devlinks - though there there might be opt-outs).
>
> To make -EPROBE_DEFER work I have to pursue the approach undertaken in th=
is
> set and apply requested changes - I don't see any other way.
>
> Are we willing to accept the approach taken in this patchset (I can remov=
e
> software nodes and make the whole thing ACPI static nodes self-contained)=
 ?
>
> One way or another this ought to be sorted, please all let me know your
> take on this.

Please make it as simple as reasonably possible. :-)
