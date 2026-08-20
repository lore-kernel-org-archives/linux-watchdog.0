Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B038F92D
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268418; cv=none; b=p+Pi3w4T2dTc5YwaZXSeKzvSljRiKdMQxhdFiVindtB6dLaIzitV3tU0umKBvXD9yOeUBVqqTZlt6CMy7kK6sqggpbOu78MX21LqWrKVTrPzqgjLAEyqEFKSK69+2e/4VDykaiUr4abFsumybDYizrqISd35YA3HwnC7vA8XCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268418; c=relaxed/simple;
	bh=RZgDopxERqCNItrvrb5mEGSIQYvuIxzhms0JpR3JRFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ys6IWN8k4tNSKZzhRE+lEya/eLABuFZAsyzAj53Pcj2DcPLro2kFX+S4tK8pOK8BdmRysD3qzI0jHHEEZVBvGXJdyXRx8hsYvy/rVZgGgfnyNi7mRq5qn9sL/VyVdBECdbAsZxWbSlEuqFYncXs6rTeTXPjL+Q8nnVHj5QtdsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJYnAMV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJYnAMV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3255D1F000E9;
	Thu, 20 Aug 2026 23:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787268416;
	bh=jm/MvmDZ7hIzfaAS244P/+G/Gt3TkjQJApHd2CV5q4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJYnAMV/6kOB3uQAS+pNNxsExDNjRYylW6vYwNMiS+/rE5HfUhvK8BjnZtDUQS/KG
	 EGa/cbeNg5pJ331+fJNGH8bCvNbSVfMW1KPPqFgzDdt2xvS5inXk9Uu2FG7xkDA//N
	 3jpkgnh5aoymsIQbvDd/pbDCcGgZ2qZe+mmoF4w2TLdCdnrXQwXU09MJZCXQzVLTFD
	 QtPLkmobhZISHY9WCKIsEWFnPbIqjzKsaAGLiogljIumZaeeTSSAZVltKpa7e0I9NF
	 niZeeIGexH8Qy/S3C7bU+yML/0em6b+ji3WemD/4gFS/kTlRll0ExJl3DqoDT4PkDC
	 I/GpFyQFfhVUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: sp5100_tco: add reversible legacy MMIO
 relocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Berliner" <caberliner@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260820231409.8427-1-caberliner@gmail.com>
References: <20260820222541.16494-1-caberliner@gmail.com>
 <20260820231409.8427-1-caberliner@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 23:26:55 +0000
Message-Id: <20260820232656.3255D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware register restoration relies on a devres action which is n=
ot executed during system reboot or shutdown, causing SB700 machines to han=
g on warm reboot.
- [High] Unaligned PCI configuration dword accesses cause watchdog decode d=
isable to silently fail, leaving intermediate addresses decoded and reading=
 uninitialized stack memory.
--

--- Patch [1]: [PATCH v2] watchdog: sp5100_tco: add reversible legacy MMIO =
relocation ---
commit 3a0c050c3a37ed10584cd869f59392a7482a02f9
Author: Christoph Berliner <caberliner@gmail.com>

watchdog: sp5100_tco: add reversible legacy MMIO relocation

This commit adds a reversible relocation path for the legacy SP5100
register layout when the firmware-provided watchdog address cannot be
reserved. It searches for a free MMIO window, saves the original state,
and restores the firmware state on probe failure or device removal.

> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 2bd3dc25cb030..99b2f5787b6cd 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
[ ... ]
> @@ -228,6 +228,215 @@ static void tco_timer_enable(struct sp5100_tco *tco)
>  	}
>  }
> =20
> +static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
> +				   u32 mmio_addr,
> +				   u32 alt_mmio_addr,
> +				   const char *dev_name,
> +				   bool report_error);
> +
> +#define SP5100_WDT_RELOCATION_RANGE	0x1000
> +
> +/*
> + * Legacy SP5100/SB7x0 fallback.
> + *
> + * Some firmware uses 0xfec000f0 for the watchdog MMIO window.
> + * This may overlap the IOAPIC resource. Historical Linux versions
> + * relocated the watchdog and reprogrammed PM registers 0x6c..0x6f.
> + */
> +static void sp5100_tco_write_pm_reg8(u8 index, u8 val)
> +{
> +	outb(index, SP5100_IO_PM_INDEX_REG);
> +	outb(val, SP5100_IO_PM_DATA_REG);
> +}
> +
> +struct sp5100_tco_relocation {
> +	u32 saved_pci_misc;
> +	u8 saved_control;
> +	u8 saved_base[4];
> +	bool programmed;
> +	bool restored;
> +};
> +
> +static void sp5100_tco_restore_relocation(struct sp5100_tco_relocation *=
reloc)
> +{
> +	u32 val;
> +	int i;
> +
> +	if (!reloc || !reloc->programmed || reloc->restored)
> +		return;
> +
> +	if (!request_muxed_region(SP5100_IO_PM_INDEX_REG,
> +				  SP5100_PM_IOPORTS_SIZE,
> +				  "sp5100_tco restore"))
> +		return;
> +
> +	/*
> +	 * MMIO decode is controlled independently of the PM watchdog-disable
> +	 * bit. Disable decode before changing the byte-wise base registers so
> +	 * that no intermediate address can become active.
> +	 */
> +	pci_read_config_dword(sp5100_tco_pci,
> +			      SP5100_PCI_WATCHDOG_MISC_REG, &val);
> +	pci_write_config_dword(sp5100_tco_pci,
> +			       SP5100_PCI_WATCHDOG_MISC_REG,
> +			       val & ~SP5100_PCI_WATCHDOG_DECODE_EN);

[Severity: High]
Since SP5100_PCI_WATCHDOG_MISC_REG is 0x41, which is not 4-byte aligned, wi=
ll
pci_read_config_dword() silently return PCIBIOS_BAD_REGISTER_NUMBER?

If so, does this leave the stack variable 'val' uninitialized and cause the
subsequent pci_write_config_dword() to write garbage back to the PCI
configuration space?

[ ... ]
> +static int sp5100_tco_reprogram_base(struct sp5100_tco *tco,
> +				     u32 conflict_addr,
> +				     const char *dev_name)
> +{
> +	struct device *dev =3D tco->wdd.parent;
> +	struct sp5100_tco_relocation *reloc;
> +	struct resource *res =3D NULL;
[ ... ]
> +	/*
> +	 * Save all firmware-programmed watchdog and decode state before
> +	 * changing anything.
> +	 */
> +	reloc->saved_control =3D
> +		sp5100_tco_read_pm_reg8(SP5100_PM_WATCHDOG_CONTROL);
> +
> +	for (i =3D 0; i < 4; i++)
> +		reloc->saved_base[i] =3D
> +			sp5100_tco_read_pm_reg8(SP5100_PM_WATCHDOG_BASE + i);
> +
> +	pci_read_config_dword(sp5100_tco_pci,
> +			      SP5100_PCI_WATCHDOG_MISC_REG,
> +			      &reloc->saved_pci_misc);
> +
> +	ret =3D devm_add_action_or_reset(dev,
> +				       sp5100_tco_release_relocation,
> +				       reloc);

[Severity: High]
Since devres callbacks like sp5100_tco_release_relocation() are only execut=
ed
during driver unbind, and not during system shutdown or reboot, will the
watchdog MMIO remain relocated in hardware during a reboot?

Because the platform driver lacks a .shutdown callback, could this cause SB=
700
machines to hang on warm reboot?

> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Disable MMIO decode before byte-wise modification of BASE0..3.
> +	 */
> +	pci_write_config_dword(sp5100_tco_pci,
> +			       SP5100_PCI_WATCHDOG_MISC_REG,
> +			       reloc->saved_pci_misc &
> +			       ~SP5100_PCI_WATCHDOG_DECODE_EN);

[Severity: High]
As mentioned earlier, does this unaligned pci_write_config_dword() silently
fail?

Could this leave intermediate addresses decoded while the byte-wise base
registers are rewritten, breaking the intended hardware isolation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820231409.8427=
-1-caberliner@gmail.com?part=3D1
