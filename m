Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6823C13FB;
	Sun, 27 Sep 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518875; cv=none; b=Tvcu3Iq9Xytv5ZqOeYQCunZux43wKNzeJ1d2mkI9WeIq/FBoAMjDg+bs8I0kgeexYyJQ1Yu7FpmAswCRs3iTpG7r49uDUkSIEPIqzdbfLhLqvrX5nZspwTAvkiXat/jMPH9ydrg2Z7tBlwMxJCa56W4v77FDM4OiF5q/bSufxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518875; c=relaxed/simple;
	bh=0APwN6Q1z5h15ijhzOHkXXzaI/L5DvpEXcrPwPWB5B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qGwSJey5zxY3fNr2ka5h65SO30pomNkgbp1DN46d/m8JNZNJCIFVDKD6JafArP7I3b1e2S6TtgntCaaHCfRf9D/UwGYUwTSSNqEySXuR1f5D5qlSeWmi5+EP921t/u9W1U7vJtEgSj3NOHY6mwheGMiAUNShnQGbuOkdSJ+ifkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUsQxC88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUsQxC88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6621F000FF;
	Sun, 27 Sep 2026 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790518873;
	bh=jP5wJQNytj2OPtfn50WtVj9qCV/nXtoTXewCQQDwFok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lUsQxC88m5bYQEL8TiB87Zf2e+Sre+oF1Ih0S/0akC802CgvNyRcWA3L5SRF1FL44
	 HQ2SPf5A7Mfq9KGutHH7piYBuVn2bKK9LW8ol5ai5C/TTZkyF6gDKx1u2VJEnw3XgS
	 e7mY8PxoLtWtQc66yBzCqQwmTfqeY8+/nDxL7ors9D3X6vTUoUczapNXokDA2LSfc/
	 /Bs7PRtS9RFQ77FzT2DoPsPn8jeaipqA2Hzp720qp0QZCaDbCJy/BUQvPKQlcJP6n6
	 t/9M5QXeVUI9dlo/f1U+GOCYjIMLJRDt/UFj3GkZO3fHOAm42+URSrR2cMdAzIcgKq
	 B0Glq4ej5uISg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] watchdog: s3c2410_wdt: Add support for Exynos8855
 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alim Akhtar" <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260927143100.3576195-2-alim.akhtar@samsung.com>
References: <20260927143100.3576195-1-alim.akhtar@samsung.com>
 <CGME20260927141258epcas5p12769f53e7911b72fd26dcbec15950b9b@epcas5p1.samsung.com>
 <20260927143100.3576195-2-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 14:21:13 +0000
Message-Id: <20260927142113.9C6621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] watchdog: confusing reuse of CLUSTER0 macro for CLUSTER1
- [Low] watchdog: space-based alignment for EXYNOS8855_RST_STAT_REG_OFFSET
--

commit fec6f94918dfbe88ae7146d760500426231edbc3
Author: Alim Akhtar <alim.akhtar@samsung.com>

watchdog: s3c2410_wdt: Add support for Exynos8855 SoC

Watchdog IP on this SoC is similar to Exynos850/ExynosAutov{9/920}.
This does not have CNT_EN_WDT bit in PMU and offset of RST_STAT is
different then the previously support SoC.
Reuse the offset as much as from already supported SoC

> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 7053963fb0ac6..8ce4ca3e2aa81 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -58,6 +58,7 @@
>  #define S3C2410_WATCHDOG_DEFAULT_TIME	(15)
> =20
>  #define EXYNOS5_RST_STAT_REG_OFFSET		0x0404
> +#define EXYNOS8855_RST_STAT_REG_OFFSET          0x10
                                          ^^^^^^^^^^
[Severity: Low]
Does this new macro intentionally use space-based alignment here?

The surrounding macros seem to use tabs for alignment. Using spaces deviates
from the standard tab-based formatting.

>  #define EXYNOS5_WDT_DISABLE_REG_OFFSET		0x0408
>  #define EXYNOS5_WDT_MASK_RESET_REG_OFFSET	0x040c

[ ... ]

> @@ -281,6 +282,26 @@ static const struct s3c2410_wdt_variant drv_data_exy=
nos850_cl1 =3D {
>  		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN,
>  };
> =20
> +static const struct s3c2410_wdt_variant drv_data_exynos8855_cl0 =3D {
> +	.mask_reset_reg =3D EXYNOS850_CLUSTER0_NONCPU_INT_EN,
> +	.mask_bit =3D 2,
> +	.mask_reset_inv =3D true,
> +	.rst_stat_reg =3D EXYNOS8855_RST_STAT_REG_OFFSET,
> +	.rst_stat_bit =3D EXYNOS850_CLUSTER0_WDTRESET_BIT,
> +	.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
> +		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
> +};
> +
> +static const struct s3c2410_wdt_variant drv_data_exynos8855_cl1 =3D {
> +	.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER1_NONCPU_INT_EN,
> +	.mask_bit =3D 2,
> +	.mask_reset_inv =3D true,
> +	.rst_stat_reg =3D EXYNOS8855_RST_STAT_REG_OFFSET,
> +	.rst_stat_bit =3D EXYNOSAUTOV9_CLUSTER0_WDTRESET_BIT,
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Is it intentional to use a CLUSTER0 macro from an unrelated SoC to define t=
he
reset status bit for a cluster 1 configuration?

Even if the underlying hardware bit value is correct and allows reuse, appl=
ying
a CLUSTER0 macro here is misleading and looks like a potential copy-paste t=
ypo.
Could this result in a functional logic error if the status bit for cluster=
 1
is actually supposed to be different?

> +	.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
> +		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927143100.3576=
195-1-alim.akhtar@samsung.com?part=3D2
