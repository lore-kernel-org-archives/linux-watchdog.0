Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512144;
	b=SvR8NIdRsfHGm9X1NNyN5mdENGJndKJBQXIFFCrDOI8eByPI+UUAW8rFtomlIUIPeWhS
	 yCXpJVBqIz3+ed+OKXS0Ci3ypELZV3lNsNGDRLoRV3apRsphymXauenyL5m11PwAaryYK
	 gAZfHmmOsNa0dZsnnc3XtdxQR8++yWxOZzaJdfGu6880VKu1QYadPVLDIU44ZBmRmbi6k
	 eosxxl/pKWQiW4f1sLKLViULnFQcBT4/rCMlyucjp0irpf3FX8uCBoM89s4SMObgOXweM
	 7AwjyPpQSnWqLPauXy5VWsy6CiOHKy+wGgY/nHPk0Ql9p4sk3AXUelw76vSsaBDjHXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512144;
	h=Received:Received:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=T6Xn0GgbQ2LS6M/ihkwGknyXfBAZO+tMr2iX2I+xIjg=;
	b=bVBZRx2VVPvqf5GxwdVQVTsXuA3eKHfw907YjUfA+WxIc1jS6IjODhb1hRnXrwtgTeZ5
	 PsUzWvnz0IKTf2OPrBd0CLXtCY20RV2P2r9xoYBLZoB68FNn+CibtDopoqYReSwL4i86I
	 rwafdZCTndVPAYdHzaUs0g8vh6lcj05cI6M2BW5dnmtuPAFfaT+Lvgrw+gz6TR8oCKKRr
	 oWzxC+tU9cWorpVabA4AGNUwzWDyzciIQH9FefKhvOdiEIPszTEDbJ7r0c0KlSYLemsBy
	 KXp9NrdXJ3DK5+ZCKXxuwKSUZxYEG1U11l8sq5D85fC1tW6c8zrgWb3SE8nFQcat8zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E303606A31C
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 16:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F3B1F000C5
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 16:02:24 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so3712074e87.2
        for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 09:02:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxv/0Qjnp7kjHEUb0EfdN3ldawF9e/QwvcmywRSvVd8WrvAIUST7AHlof1BVIrTwmQjVhQGttHLAMufZe84nw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJaHXeIUtjGZEnWyl4KkyxuUIHt6w9aI3axxHeRORQJJ5mWudX0
	Gd2PPGsr7g9dNg+ID8j62jLX7alekDgiNiIZAVpogDoqA4a+/MiiSYEhgbrCl7yvxgebw+FMpuZ
	2zfNou42gKMW99g11e3eJqjlRmRBqslY=
X-Received: by 2002:a05:6512:3d8c:b0:5bc:d9d6:6a98 with SMTP id
 2adb3069b0e04-5be50a471cbmr3402594e87.10.1792512142493; Tue, 20 Oct 2026
 09:02:22 -0700 (PDT)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local> <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local> <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com> <asieTvinZ7c2QpQm@red-moon>
 <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon> <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon>
In-Reply-To: <ateI-JcExDyfXKrs@red-moon>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 20 Oct 2026 18:00:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+S3z3YqpJYCwcZXpPNEawedSof1z4+ydWn=tZbL8L6g@mail.gmail.com>
X-Gm-Features: AclHuK8HDf2yPjcd4rawrCfnLbX27pb5S5MNqmvyCllH3hG9fIPbIUdmHBI-lNo
Message-ID: <CAJZ5v0h+S3z3YqpJYCwcZXpPNEawedSof1z4+ydWn=tZbL8L6g@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 5:30=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Mon, Oct 19, 2026 at 12:34=E2=80=AFPM Lorenzo Pieralisi
> > <lpieralisi@kernel.org> wrote:
>
> [...]
>
> > Basically, yes, the idea is to defer the creation of the platform
> > device until the dependency is met.
> >
> > > till the dependencies are cleared but then, without a _CRS, where wil=
l
> > > the consumer driver find the platform device resources ?
> >
> > Well, good question.
> >
> > > There are multiple facets in this issue and possibly some of them hav=
e
> > > been already solved but I need to pull them together.
> > >
> > > > Note that the dependencies can be added to acpi_dep_list after
> > > > creating a struct acpi_device with acpi_add_single_object() and
> > > > acpi_scan_add_dep() is not really suitable for that, but it should =
be
> > > > doable if the dependencies can be found.
> > > >
> > > > > I need to have a deeper look into this next week but I wanted to =
ask first
> > > > > whether there was something I missed - most likely.
> > > >
> > > > Well, it is not really straightforward.
> > >
> > > Yes it is getting messy. This RFC, with all its flaws, does not trans=
parently
> > > prevents enumeration but rather relies on -EPROBE_DEFER to sort out
> > > dependencies - though it does so by adding more stuff into ACPI stati=
c fwnode
> > > that to be honest I'd rather see gone.
> >
> > I think what you need is a notification mechanism that will trigger
> > when a specific device (enumerated via the ACPI Namespace) becomes
> > operational.  It doesn't look like any of the existing ones (platform
> > device probe deferral or ACPI device dependencies tracking) is really
> > suitable for your use case.
>
> Yes. It might just be a notification from ACPI core to say "the driver fo=
r
> this ACPI device probed, go create platform devices that depends on it".

The ACPI core doesn't know about driver probing, so this notification
would need to come from the driver of that specific device.

In the regular _DEP dependencies case, the drivers that provide
dependencies generally need to call acpi_dev_clear_dependencies()
which triggers a dependency list walk.

I guess driver_bound() could do something like that in principle (it
does a similar thing already for deferred probing), but I'm not sure
how generic it needs to be for this particular use case.
