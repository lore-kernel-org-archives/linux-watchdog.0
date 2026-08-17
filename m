Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13E3B42FE;
	Mon, 17 Aug 2026 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962836; cv=none; b=Gwcvpme0Dzw85fMgJ4d6TlvmC+5qamcUKqPmAHdYu9CFb2DAG9unwX0EXhwfjH2BK5Kw7+bNeSFmTnh+IJ/0TvFxaNBx60uRMGwTJ9MEfie0OLRGadFgwZr7GVOSX0o2GOdtevk57nN9kYIG21UdSGOEfROTFR77rddkMoCvh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962836; c=relaxed/simple;
	bh=VxFnHyf+IwaWeGaerXm4MvCoawlmUUDKLcThoZ4Oq/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U4TmRnggcMGu2sIVAcimqzw56o9is74ASbbAgONjJMFvAAFe8Cn8ubWGXW7vM7M16fmv5urKxKzeRg9jp/Mk0K/R+AF8F1imhFGdAT+3sv99wcrFheb77SSwgcXkoFVYAdRNHtD/wuHxrKcqi3lSjokcwkcKfQSlFhJgxuEUTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMkMjp6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMkMjp6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB64F1F000E9;
	Mon, 17 Aug 2026 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786962835;
	bh=7TlM06sAb4WjxZZCeTjHrnETa6FNG1wvd8/cAqEW3QM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FMkMjp6QiczlWgFdfIURdEgMDIeS4rxYYll6BGG7iNjc/JpbGKw4qGDTeEYDQzqxw
	 8VeO250gK8491im88/v6y3adYQbR7hgj4okBpMr0taNdfLVRYyf6zhlvWiWOBIJeFb
	 PG66SYnITBv4PARFXI9SXGkss4oqAgXcMxw3+R0aFGvjiHzAJR+tR6FmU2iBjrex7I
	 QyfW9qNGASh35u0Vk68I5BLbX9Y0rEjQ9XECQDmRglN4tb0XCx0zfwF1YZaWOJGlgU
	 vjNxEg5aU6KELHxHnL4vuPde50VbRjM+F0Mv5g94nbToQn5Rd204wjffetdp7b70N0
	 ZwJI1g1lclTdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aiden Isik" <aidenisik@member.fsf.org>
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260817-for-next-lucky7-watchdog-v1-2-a14370e20b92@member.fsf.org>
References: <20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org>
 <20260817-for-next-lucky7-watchdog-v1-2-a14370e20b92@member.fsf.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 10:33:54 +0000
Message-Id: <20260817103354.BB64F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `drv_data_exynos5515` variant declares `QUIRK_HAS_PMU_AUTO_DIS=
ABLE` but fails to initialize `.disable_reg`, causing unintentional writes =
to PMU offset 0x0000.
- [High] The `drv_data_exynos5515` variant uses an 'INT_EN' register for ma=
sking watchdog reset, but omits the `.mask_reset_inv =3D true` flag, invert=
ing the WDT reset mask logic.
- [Medium] Incorrect use of an Exynos Auto v920 register macro (`EXYNOSAUTO=
V920_CLUSTER0_NONCPU_INT_EN`) in an Exynos 5515 variant.
--

--- Patch [2]: [PATCH 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compat=
ible data ---
commit dcaab4881777bc5f5ce1a532adad7c17046164a8
Author: Aiden Isik <aidenisik@member.fsf.org>

watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data

This commit adds driver data and a compatible string for the Exynos5515
SoC's watchdog timer.

> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index e31f93db05096..7299dfdb0c099 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c

[ ... ]

> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_exy=
nos5420 =3D {
>  		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
>  };
> =20
> +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D {
> +	.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,

[Severity: Medium]
Is this intentionally using an Exynos Auto v920 register macro for an
Exynos 5515 variant, or could this be a copy-paste error?

[Severity: High]
Since this variant uses an INT_EN register for masking the reset, should
the .mask_reset_inv =3D true flag be set here?

Without the inversion flag, the bitwise masking logic in
s3c2410wdt_mask_wdt_reset() evaluates to (mask ^ false). For INT_EN
registers, this typically writes 1 when intending to mask the reset, and 0
when intending to unmask it, effectively inverting the logic.

> +	.mask_bit =3D 2,
> +	.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> +	.rst_stat_bit =3D 24,
> +	.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
> +		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE | \
> +		  QUIRK_HAS_DBGACK_BIT,
> +};

[Severity: High]
Will this cause unintentional writes to offset 0x0000 of the PMU regmap?

This variant declares QUIRK_HAS_PMU_AUTO_DISABLE but omits .disable_reg.
Since struct fields default to zero, when s3c2410wdt_enable() checks for
this quirk and calls s3c2410wdt_disable_wdt_reset() during driver probe:

s3c2410wdt_disable_wdt_reset()
    regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg, mask_val, v=
al);

regmap_update_bits() will blindly write to offset 0x0000.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-for-next-l=
ucky7-watchdog-v1-0-a14370e20b92@member.fsf.org?part=3D2
