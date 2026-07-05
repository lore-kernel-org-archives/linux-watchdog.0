Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70063644A4;
	Sun,  5 Jul 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260650; cv=none; b=d9Os1T+ToZom42C0dX/s+PFec2NFIg7MOjCeqzsbU10Oa4a4mLt4TAI7NNdGh82Ah5sC0NHlExFzW92c01DNFvCRE5t0sEckn/igxD5bgrgJPBi7mP1wwZeCdlt/1yF/zbvAca2lCsi/j0STlr8K1euyJHOcsOsXmJHdD2dsOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260650; c=relaxed/simple;
	bh=UoaZUZdvK5tVW9JIXitsjOje+bJUuGATyLKpSjDPluc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eLWRK3qxE0wpBxNRnvQAuj8eRC8B+6Pd87OVRz0tGcLJDD4LipXLu3daBOrSx5mRdEluiIEzvS1LeQkvwqtpC5/qpxoR4bz7MpLzON6Zs5y8T/HSpV5AM02gxOH1E0uwyZRr93CKuWZ+QZ059v2zcRzxpyoWJCzdl2+las0mBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajDZJMtm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajDZJMtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C5D1F000E9;
	Sun,  5 Jul 2026 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260648;
	bh=JbIeFz2Sa5U1XOA57Vf8ZTTx6ud5jxzDCyWE/uByH5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ajDZJMtmpQryWPf0lu3sW24pwc4+blvFHV/ykbNO25hoBSLOtSBnamXlYfWZCtZBA
	 tUfqdsdBHBGUAsZDo0lv/qVTqI6YEny+mHIWRTDi3YUWNfRchc4cVm9qI07/miTwJO
	 subfUGh8c+SREtg/yywpLVgwTpOTiOM+KxkcqWwqyABcdURdtpL9BU9dWlElrperx7
	 1Fcq46FqV/FHwHzDWTV+IrwZtYGwZRHFmbdIqxRRNiNEKUW3SJ00S3gf6pgu4mMFJm
	 Rj2JlxCSbPhaamazXvek/KzQtoYR3vzLpaOJyJKM4dMA+LynZJb3za5y6HYoh1Y55Q
	 DgSkNonC7pScQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] watchdog: npcm: add bootstatus support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomer Maimon" <tmaimon77@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260705140100.1543486-4-tmaimon77@gmail.com>
References: <20260705140100.1543486-1-tmaimon77@gmail.com>
 <20260705140100.1543486-4-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 14:10:48 +0000
Message-Id: <20260705141048.75C5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Non-atomic read-modify-write on shared syscon registers corrupts c=
oncurrent updates or incorrectly clears W1C bits.
- [High] The driver hijacks standardized watchdog bootstatus flags to repor=
t unrelated SoC reset reasons.
- [Low] The driver hardcodes physical MMIO base addresses to identify drive=
r instances.

Pre-existing issues:
- [High] The driver leaks a clock enable reference on every timeout change =
and fails to clean up on probe errors.
--

commit 3d82c9ef067a4770a83258e13cbb0ed566d4998b
Author: Tomer Maimon <tmaimon77@gmail.com>

watchdog: npcm: add bootstatus support

The NPCM750 uses RESSR and the NPCM845 uses INTCR2 to latch reset indicatio=
ns.
Read those bits during probe and map them into watchdog bootstatus flags. F=
or
NPCM845, cache the sampled INTCR2 state in SCRPAD10 after the reset status
bits are cleared.

> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index e62ea054bc618..82ff3956dcf21 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c

[ ... ]

> +static const struct npcm_wdt_rst_map npcm750_rst_map[] =3D {
> +	{ 0xf000801c, NPCM_WD0RST },
> +	{ 0xf000901c, NPCM_WD1RST },
> +	{ 0xf000a01c, NPCM_WD2RST },
> +};

[Severity: Low]
Does this code hardcode physical MMIO base addresses to identify driver
instances?

Matching the resource start address against hardcoded values in
npcm_get_reset_status() can be brittle if the memory map changes in future
SoC revisions or alternative device tree mappings. Is there a way to use
device tree aliases or instance IDs to identify the hardware block instead?

> +
> +static const struct npcm_wdt_status_map npcm750_status_map[] =3D {
> +	{ NPCM_PORST, WDIOF_OVERHEAT },
> +	{ NPCM_CORST, WDIOF_FANFAULT },
> +	{ NPCM_SWR1RST, WDIOF_EXTERN1 },
> +	{ NPCM_SWR2RST, WDIOF_EXTERN2 },
> +	{ NPCM_SWR3RST, WDIOF_POWERUNDER },
> +	{ NPCM_SWR4RST, WDIOF_POWEROVER },
> +};

[Severity: High]
Does this mapping hijack standardized watchdog bootstatus flags to report
unrelated SoC reset reasons?

Translating NPCM SoC-specific reset reasons into standard UAPI flags might
cause issues in userspace. For example, WDIOF_OVERHEAT and WDIOF_FANFAULT
are strictly defined in the UAPI to indicate thermal overheating and fan
failures.

Could system monitoring tools misinterpret a normal cold boot (NPCM_CORST)
as a severe hardware failure and trigger unintended alerts or shutdowns?

[ ... ]

> +static void npcm_get_reset_status(struct npcm_wdt *wdt, struct device *d=
ev,
> +				  const struct npcm_wdt_data *data,
> +				  resource_size_t start)
> +{

[ ... ]

> +	if (of_device_is_compatible(dev->of_node, "nuvoton,npcm845-wdt")) {
> +		ret =3D regmap_read(gcr_regmap, NPCM_INTCR2_OFFSET, &rstval);
> +		if (ret) {
> +			dev_warn(dev, "Failed to read INTCR2 reset status: %d\n",
> +				 ret);
> +			return;
> +		}
> +
> +		if (rstval & NPCM_RST) {
> +			ret =3D regmap_write(gcr_regmap, NPCM_INTCR2_OFFSET,
> +					   rstval & ~NPCM_RST);

[Severity: High]
Can this non-atomic read-modify-write sequence on the shared syscon
register corrupt concurrent updates?

If INTCR2 (and RESSR below) are standard read-write registers, this
sequence could silently overwrite modifications made by other drivers
sharing the syscon.

Alternatively, if these are Write-1-to-Clear (W1C) registers, writing
rstval & ~NPCM_RST will write 1s to all other active status bits,
inadvertently clearing them, while writing 0 to the watchdog bits,
failing to clear the intended reset flags.

Would it be safer to use regmap_update_bits() for atomic updates, or if
W1C, write only the target bits without a read-modify-write?

[ ... ]

> @@ -220,6 +430,8 @@ static int npcm_wdt_probe(struct platform_device *pde=
v)
>  	/* Ensure timeout is able to be represented by the hardware */
>  	npcm_wdt_set_timeout(&wdt->wdd, wdt->wdd.timeout);
> =20
> +	npcm_get_reset_status(wdt, dev, data, start);
> +
>  	if (npcm_is_running(&wdt->wdd)) {
>  		/* Restart with the default or device-tree specified timeout */
>  		npcm_wdt_start(&wdt->wdd);
>  		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>  	}
> =20
>  	ret =3D devm_request_irq(dev, irq, npcm_wdt_interrupt, 0, "watchdog",
>  			       wdt);
>  	if (ret)
>  		return ret;

[Severity: High]
This is a pre-existing issue, but does this code leak a clock enable
reference?

In npcm_wdt_probe(), if the hardware is running, npcm_wdt_start() is called:

npcm_wdt_start()
    clk_prepare_enable(wdt->clk);

If subsequent probe steps fail (e.g., devm_request_irq() returns an error),
probe returns without unwinding the clock enable.

Additionally, npcm_wdt_set_timeout() calls npcm_wdt_start() when the watchd=
og
is active. Since there is no matching disable on timeout change, every
WDIOC_SETTIMEOUT ioctl increments the clock's refcount. This prevents
the clock from ever being disabled when the watchdog is stopped, leading
to a resource leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705140100.1543=
486-1-tmaimon77@gmail.com?part=3D3
