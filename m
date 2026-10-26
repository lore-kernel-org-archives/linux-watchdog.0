Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015748;
	b=ww3vDS34mDAfLgS3+PQCy8ON1BiThV2AivxufGwfC22mo1QZYXlnL5LjwHEb5bsjdbGI
	 3FFyuN4ZUM6lXJ7RSzxwFf375q/iCm6QrPpEn/tvTkStEqmprLD8jWlzLPvT08EfoZeN4
	 s/P7RfoG/WXsRdf+Ed0TSZqeFRzBYACjNXBP1K8viZKxWsevNawVkSEw+V15pBGVswW6E
	 UMx9Solsyj7dYYkK2S6gWsC6YxK3TlSqpP+3wsC710KWOLXbgb2qL7qiTxB6eTgDT2rdA
	 zOwQ+OrdK6V3Gzp8uZ1RK7njRJhjQ9cDQelh4GLd4NXf0+rVX83ljvoxsPeh+kVyCuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015748;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=VuwNovxBeheUNEyf0xe0FOSw7zw//LLQy0q3ztYt6Fs=;
	b=zmQbtsxQyrQJOsP3XsGNp//3A2W/HXadAoBfTGi0UinkqlcFwRzacux3Wr1vIwR9MjBy
	 oHCNhiHcsHexRUXJqRvONog+4g0QOc5sSWmwyjaK4nTKQy1TajnsLTg4NNF8hdH8YLYG1
	 TB8LC4dOpFH93+/5yjhFPSOqOpe8cjqVi7/fIj7zwPqy7toLxfnWTlYvVfGvwhjc+HTg8
	 sEPOGsRv0jDLUpWJ/wApEOIT6EpgY/EVzapWLlTrJBQvmyJhfns74TT/8mpqgucPApwqQ
	 D0mSfzEhiD6oslswjCvbqY8Gaaw5YSa6lepjrmaCTUvU3Rh5mPRHgC2JN9mpWAz56Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5XPZm7e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11E606A31A;
	Mon, 26 Oct 2026 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5XPZm7e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AAF1F01825;
	Mon, 26 Oct 2026 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015747;
	bh=VuwNovxBeheUNEyf0xe0FOSw7zw//LLQy0q3ztYt6Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E5XPZm7eHlS0DKixSiYZJgVnH5UJkdCH55tiz9U+upA85dAD1bUVFuCt9CNnBQ/r/
	 ImVLj8peT4KPCPqzSyWR6WfZeCmy9JIC6D77eqyuKsO5zscEO0u11QGXXpgvT5bypE
	 2b0ox3cbOibQCtTNnMixUiek7oaMhIlVW1Rj+dxe5veE9RxFulRhw3jRJu3apk6ESK
	 bRY8WFjQWei8cNM16ZQO0k648SFyIN7+S9DZFVd7eShILfn1heqaX91frGBdlQEdJl
	 +vSacG5b5bvnPnhO9t2XcEMue/Kn6rIb8RiyBLpxlkxWpu9dlnJNvDuF3BwdD3E4ug
	 F2E1hwyb/1Kfg==
Date: Mon, 26 Oct 2026 12:55:39 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
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
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org,
	Grant Likely <grant.likely@arm.com>
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <at8_u-BCVD8Bpudp@red-moon>
References: <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon>
 <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon>
 <athimRqtDvQu1ZzA@ashevche-desk.local>
 <atiAmZSPiRNBAO5O@red-moon>
 <7f077fd3-9c67-409a-b46f-7f28a55c180b@arm.com>
 <atmwo3Bpi62kB8_n@red-moon>
 <CAJZ5v0g56LP+EQc6MQ1H_5XnQALEn3CV9Q9HGCoiuMvpkK+N+A@mail.gmail.com>
 <CAB19ukGr39DrSXdR9Gy=YxVSXfPgYB0oqqjggQNBfedMjVtAwA@mail.gmail.com>
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
In-Reply-To: <CAB19ukGr39DrSXdR9Gy=YxVSXfPgYB0oqqjggQNBfedMjVtAwA@mail.gmail.com>

On Mon, Oct 26, 2026 at 10:20:37AM +0530, Sunil V L wrote:
> On Thu, Oct 22, 2026 at 4:18 PM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 22, 2026 at 8:43 AM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > >
> > > On Wed, Oct 21, 2026 at 12:18:39PM +0100, Robin Murphy wrote:
> > > > On 2026-10-21 10:06 am, Lorenzo Pieralisi wrote:
> > > > > On Wed, Oct 21, 2026 at 09:58:33AM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Oct 20, 2026 at 05:30:00PM +0200, Lorenzo Pieralisi wrote:
> > > > > > > On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > > > > > > On Mon, Oct 19, 2026 at 12:34 PM Lorenzo Pieralisi
> > > > > > > > <lpieralisi@kernel.org> wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > Basically, yes, the idea is to defer the creation of the platform
> > > > > > > > device until the dependency is met.
> > > > > > > >
> > > > > > > > > till the dependencies are cleared but then, without a _CRS, where will
> > > > > > > > > the consumer driver find the platform device resources ?
> > > > > > > >
> > > > > > > > Well, good question.
> > > > > > > >
> > > > > > > > > There are multiple facets in this issue and possibly some of them have
> > > > > > > > > been already solved but I need to pull them together.
> > > > > > > > >
> > > > > > > > > > Note that the dependencies can be added to acpi_dep_list after
> > > > > > > > > > creating a struct acpi_device with acpi_add_single_object() and
> > > > > > > > > > acpi_scan_add_dep() is not really suitable for that, but it should be
> > > > > > > > > > doable if the dependencies can be found.
> > > > > > > > > >
> > > > > > > > > > > I need to have a deeper look into this next week but I wanted to ask first
> > > > > > > > > > > whether there was something I missed - most likely.
> > > > > > > > > >
> > > > > > > > > > Well, it is not really straightforward.
> > > > > > > > >
> > > > > > > > > Yes it is getting messy. This RFC, with all its flaws, does not transparently
> > > > > > > > > prevents enumeration but rather relies on -EPROBE_DEFER to sort out
> > > > > > > > > dependencies - though it does so by adding more stuff into ACPI static fwnode
> > > > > > > > > that to be honest I'd rather see gone.
> > > > > > > >
> > > > > > > > I think what you need is a notification mechanism that will trigger
> > > > > > > > when a specific device (enumerated via the ACPI Namespace) becomes
> > > > > > > > operational.  It doesn't look like any of the existing ones (platform
> > > > > > > > device probe deferral or ACPI device dependencies tracking) is really
> > > > > > > > suitable for your use case.
> > > > > > >
> > > > > > > Yes. It might just be a notification from ACPI core to say "the driver for
> > > > > > > this ACPI device probed, go create platform devices that depends on it".
> > > > > > >
> > > > > > > We can check and track the dependency in code that does create those
> > > > > > > devices today.
> > > > > > >
> > > > > > > I will think about this to see how bad this might look like.
> > > > > >
> > > > > > Don't we do something similar in drivers/acpi/x86/lpss.c?
> > > > >
> > > > > I suppose I can add a notifier that checks whether the device whose
> > > > > companion represents the ACPI device a given platform device IRQ depends
> > > > > on was bound to its driver and then map the IRQ and add the platform device
> > > > > _then_ - after all that's what acpi_dev_clear_dependencies() does (similar
> > > > > at least).
> > > > >
> > > > > There is still the question - where the GSI number, flags should be
> > > > > stashed so that the notifier can grab them in a uniform way. We
> > > > > could simply attach platform data storing those values to a pdev, either on
> > > > > a per static table basis or generalize the data so that a single notifier
> > > > > would be able to deal with it.
> > > > >
> > > > > That or I can just piggyback on acpi_dev_clear_dependencies() and add
> > > > > a separate dep mechanism to acpi_dep_data that instead of being acpi_handle
> > > > > based the consumer is fwnode based (something Rafael mentioned before).
> > > > >
> > > > > I will have a stab at this and see what's the least bad solution I can
> > > > > come up with.
> > > > >
> > > > > I suppose we are scrapping the -EPROBE_DEFER solution (ie this set),
> > > > > what we are talking about above won't need to defer anything other
> > > > > than the time when platform devices are added.
> > > >
> > > > I dunno, that seems pretty drastic for some use-cases - the fact that a GSI
> > > > is described in a table doesn't necessarily mean it is critical to device
> > > > operation. If we don't even create the device until all possible resources
> > > > are available, then its driver never has any chance to decide whether it's
> > > > happy to ignore the deferral and just use MSIs or polling instead...
> > >
> > > I agree with you (but that's what we do for ACPI autodep and AFAICS OF
> > > devlinks - though there there might be opt-outs).
> > >
> > > To make -EPROBE_DEFER work I have to pursue the approach undertaken in this
> > > set and apply requested changes - I don't see any other way.
> > >
> > > Are we willing to accept the approach taken in this patchset (I can remove
> > > software nodes and make the whole thing ACPI static nodes self-contained) ?
> > >
> > > One way or another this ought to be sorted, please all let me know your
> > > take on this.
> >
> > Please make it as simple as reasonably possible. :-)
> >
> For this use case, where platform devices are created from static ACPI
> tables, I think adding fw_devlink support to ACPI is a much simpler
> approach. I proposed this in [1] as a generic solution, but we later
> realized that it doesn't work well for cases where dependencies need
> to be established very early (_DEP/autodep worked better for such use
> cases). That limitation should not apply to this particular use case,
> though. So I wonder if a combination of autodep and fw_devlink will be
> a better solution?
> 
> [1] - https://lists.infradead.org/pipermail/linux-riscv/2023-December/046146.html

Not sure and actually the point here is about opting in for using
-EPROBE_DEFER in consumer drivers (so that they have a choice on probe
deferral rather than being deferred behind their back).

I implemented devlink supports for these platform devices but I don't
think it is best way forward - given this discussion.

Thanks,
Lorenzo
