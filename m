Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7A30E828
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787265565; cv=none; b=JyW1JediC5OYWDSLcui7DbGywpoeGWuln8XflxLDdFG4TkxecF+N1ZbpIfmKYV8o5jTfPfEewK41Q6XPGGd4ZLc92fLjRhFWO5KAcnqAFI85r0GdeAisODypUlBpYFcQw7XaHcREWur1lWp4HAWVIsy3PY6qs1EjpAE3Qu/HFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787265565; c=relaxed/simple;
	bh=24WTNEuE9Gk290lrM8hnVIFZwrU99eOPWcXM8TCMvWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EAzpBcjt37S9HwIkD7ituJycwwSRk8zwfaMyJDvqpU9Mge70sKRhvlhB6QfFpAohUEkmEfkhoQFbJG36dGl30iiv8QNtkhY02xst8H1t8MpFxcqvJt1vuE8gpCsrfYfKvZB/5VwpTopTSNIgvyLo9TPmZrkDInn7g7CZkhDdzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJgV1cZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJgV1cZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715BF1F000E9;
	Thu, 20 Aug 2026 22:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787265563;
	bh=GFDW/kfm8e4aNGbk3jDMRk3TSc3+f4xLoPvkNtIPG14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJgV1cZjKDd1SKlTvLu4B7td/WXav9w0RIMUnOI7WprN9lnfYqx7AeEqcQTBK9uHO
	 KCGxQKTqqs53D95b15yxOa7Yb/x2HHpz7/2DhiltxifGKNZz3HUi1AN2cGQex0CLsY
	 epx8KUasZsVfz0pYLTBUlErv2PK2Q3Xn0N/jR3HMmcXuqP3lqLBpE+FyLzFb4mWFve
	 XrKsLPwcx1FcEbOlycI2HK9Zf49OKJYWDCM+CjTcphjghHB7igh4PcIEc6KVhqk5Ux
	 lptTbwiZjzaqoWK5jbIRl+0A92UVcWsPdk6+KDFo2tZjARw6C/baKw6Zlpzgb+aDhj
	 dBquUj1w3x9EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: sp5100_tco: add reversible legacy MMIO
 relocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Berliner" <caberliner@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260820222541.16494-1-caberliner@gmail.com>
References: <20260820222541.16494-1-caberliner@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 22:39:23 +0000
Message-Id: <20260820223923.715BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] Lockless traversal of the global `iomem_resource` tree can lead to=
 a Time-of-Check to Time-of-Use (TOCTOU) Use-After-Free (UAF) and system cr=
ash.
- [High] Algorithmic Denial of Service (O(N) boot lockup) due to a step-by-=
8-bytes brute-force resource search loop.
- [High] The watchdog relocation logic can allocate memory inside leaf devi=
ces such as the IOAPIC, causing hardware conflicts and immediate system han=
gs.
- [High] Intermediate MMIO base addresses are left actively decoding during=
 byte-by-byte register writes, risking hardware hangs.
- [High] The patch fails to restore the hardware PM registers on system shu=
tdown/reboot, risking the same BIOS boot failure it aims to prevent.
- [Medium] The relocated watchdog MMIO resource is allocated without the `I=
ORESOURCE_BUSY` flag.

Pre-existing issues:
- [High] Incorrect release of a muxed memory region leaves concurrent waite=
rs sleeping forever.
- [High] The probe function leaks the muxed IO port region lock on an error=
 path.
--

--- Patch [1]: [PATCH] watchdog: sp5100_tco: add reversible legacy MMIO rel=
ocation ---
commit acc706a989fc9058e6e8b5ba34a48d8247e973fd
Author: Christoph Berliner <caberliner@gmail.com>
Subject: watchdog: sp5100_tco: add reversible legacy MMIO relocation

This patch adds a reversible relocation path for legacy SP5100 watchdog
registers when they conflict with reserved resources. It attempts to locate=
 an
unreserved child resource inside the conflicting parent, reprogram the
watchdog base address, and uses devres to restore the original state upon
failure or removal.

> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 2bd3dc25cb030..aafa73bd3be12 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
[ ... ]
> +/*
> + * Find the top-level firmware resource containing the conflicting
> + * watchdog address.  The watchdog can then be allocated as a sibling
> + * of resources such as the IOAPIC rather than as a child of them.
> + */
> +static struct resource *
> +sp5100_tco_find_parent_resource(resource_size_t addr)
> +{
> +	struct resource *res;
> +
> +	for (res =3D iomem_resource.child; res; res =3D res->sibling) {

[Severity: High]
Is it safe to traverse the iomem_resource.child tree without holding
read_lock(&resource_lock)?

Lockless traversal can race with concurrent resource modifications, potenti=
ally
returning an unpinned pointer that could lead to a use-after-free when pass=
ed
to request_resource() later.

[Severity: High]
Could this top-level traversal return a leaf device (such as the IOAPIC)
instead of a container?

If it returns a leaf device, request_resource() won't detect any child
conflicts and will succeed, allocating watchdog memory that perfectly overl=
aps
the IOAPIC. This might cause immediate hardware hangs due to interrupt
starvation.

> +		if (addr >=3D res->start && addr <=3D res->end)
> +			return res;
> +	}
> +
> +	return NULL;
> +}
[ ... ]
> +static int sp5100_tco_reprogram_base(struct sp5100_tco *tco,
> +				     u32 conflict_addr,
> +				     const char *dev_name)
> +{
[ ... ]
> +	reloc =3D devm_kzalloc(dev, sizeof(*reloc), GFP_KERNEL);
> +	if (!reloc)
> +		return -ENOMEM;
> +
> +	res =3D &reloc->res;
> +	res->name =3D dev_name;
> +	res->flags =3D IORESOURCE_MEM;

[Severity: Medium]
Does this resource initialization omit the IORESOURCE_BUSY flag?

Without it, the kernel treats this as a non-leaf container rather than an
exclusively owned region. If another driver calls request_mem_region() for =
an
overlapping address space, it might incorrectly succeed by carving out a ch=
ild
resource.

> +	candidate =3D ALIGN(parent->start, SP5100_WDT_MEM_MAP_SIZE);
> +
> +	for (;;) {
> +		if (candidate > max_addr ||
> +		    max_addr - candidate + 1 < SP5100_WDT_MEM_MAP_SIZE) {
> +			dev_err(dev,
> +				"No free watchdog MMIO slot found inside %pR\n",
> +				parent);
> +			return -EBUSY;
> +		}
> +
> +		res->start =3D candidate;
> +		res->end =3D candidate + SP5100_WDT_MEM_MAP_SIZE - 1;
> +
> +		ret =3D request_resource(parent, res);
> +		if (!ret)
> +			break;
> +
> +		if (ret !=3D -EBUSY)
> +			return ret;
> +
> +		candidate +=3D SP5100_WDT_MEM_MAP_SIZE;
> +	}

[Severity: High]
Does this loop excessively delay boot on large, occupied parent resources?

Blindly incrementing the candidate address by 8 bytes
(SP5100_WDT_MEM_MAP_SIZE) on each request_resource() failure, instead of us=
ing
the conflicting resource's end address to skip occupied regions, could resu=
lt
in millions of loop iterations and acquisitions of the global resource_lock.

> +	reloc->saved_control =3D
> +		sp5100_tco_read_pm_reg8(SP5100_PM_WATCHDOG_CONTROL);
> +
> +	for (i =3D 0; i < 4; i++)
> +		reloc->saved_base[i] =3D
> +			sp5100_tco_read_pm_reg8(SP5100_PM_WATCHDOG_BASE + i);
> +
> +	ret =3D devm_add_action_or_reset(dev,
> +				       sp5100_tco_release_relocation,
> +				       reloc);

[Severity: High]
Is devm_add_action_or_reset() sufficient for restoring the hardware PM
registers on system shutdown or reboot?

Devres callbacks fire on device unbind or probe failure, but not during
shutdown. Could this leave the MMIO base actively relocated on a warm reboo=
t,
potentially causing the exact BIOS boot failures this patch intends to prev=
ent?

> +	if (ret)
> +		return ret;
> +
> +	mmio_addr =3D (u32)res->start;
> +
> +	/*
> +	 * Disable the watchdog before changing its decode address.
> +	 */
> +	sp5100_tco_update_pm_reg8(SP5100_PM_WATCHDOG_CONTROL,
> +				  0xff,
> +				  SP5100_PM_WATCHDOG_DISABLE);
> +
> +	/*
> +	 * Preserve the reserved low three bits of BASE0 while
> +	 * reprogramming the aligned watchdog address.
> +	 */
> +	base0_reserved =3D reloc->saved_base[0] & 0x07;
> +
> +	for (i =3D 0; i < 4; i++) {
> +		u8 val =3D (mmio_addr >> (8 * i)) & 0xff;
> +
> +		if (!i)
> +			val |=3D base0_reserved;
> +
> +		sp5100_tco_write_pm_reg8(SP5100_PM_WATCHDOG_BASE + i, val);
> +	}

[Severity: High]
Are intermediate MMIO base addresses actively decoding during these
byte-by-byte register writes?

For the SP5100/SB7x0 layout, setting SP5100_PM_WATCHDOG_DISABLE disables the
timer, but decoding is controlled by SP5100_PCI_WATCHDOG_DECODE_EN which
appears to remain active. As the base address shifts during the loop, could
DMA or CPU accesses intercept these intermediate addresses and cause hardwa=
re
hangs?

[ ... ]
> @@ -404,7 +632,7 @@ static int sp5100_tco_setupdevice_mmio(struct device =
*dev,
>  		alt_mmio_addr =3D EFCH_PM_ACPI_MMIO_ADDR +
>  			EFCH_PM_ACPI_MMIO_WDT_OFFSET;
> =20
> -	ret =3D sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name=
);
> +	ret =3D sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name=
, true);

[Severity: High]
This is a pre-existing issue, but further down in sp5100_tco_setupdevice_mm=
io()
on the teardown/error path, release_resource(res) is called instead of
release_mem_region(res).

Since the memory was requested with request_mem_region_muxed(), using
release_resource() skips the wake_up(&muxed_resource_wait) call. Could this
leave concurrent waiters sleeping forever?

[ ... ]
> @@ -490,7 +720,24 @@ static int sp5100_tco_setupdevice(struct device *dev,
>  		return -ENODEV;
>  	}

[Severity: High]
This is a pre-existing issue, but the above return -ENODEV occurs when the
switch statement hits the default branch for an unsupported tco_reg_layout.

This exits the probe function without releasing the muxed IO port region
acquired earlier via request_muxed_region(SP5100_IO_PM_INDEX_REG). Does this
lock leak indefinitely starve other drivers requiring the muxed region?

> -	ret =3D sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name=
);
> +	report_error =3D tco->tco_reg_layout !=3D sp5100;
> +	ret =3D sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name=
, report_error);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820222541.1649=
4-1-caberliner@gmail.com?part=3D1
