Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC962F8E8B
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964943; cv=none; b=kuZ4RABR1ozq4h9d1EVJbutWzCotpBH03lKc3ozx8UU/ptUdta8cRBeEBXuJT1t9UpHg7uf7nkqz7ktwye2MLV4Mcbo9G9rLh+ThKmYa/cDxv+OtVWb75UiE6Mk/B8V0jncGxiooS7lqk5jXpTlKinR5CU2sAyit0gu7KU8p8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964943; c=relaxed/simple;
	bh=zPCnKvUY679S6FYWHPC8KfDz/9Shx5+soSEn5mxDyxE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnHeWvkJw7hBaAF1jb56h1w9KVwtTbScXtyw/dq+tYGAXXuqBzbofCwCnoR3hVfNFzOEqNxpiwxoozsChACwZRZFH4YfNiX5TUvrLYTl7HJQagCQVh8l3RqTnpTSlKee4gZHBwbsKTYAwq1j2vrweKI/ViVr+yIxyMuRkNDqJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=e4hJc5ua; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="e4hJc5ua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1786964933; x=1787224133;
	bh=yGze0ymZYgExAxN/K4WSJodaDn1EV8mUaPA6esUxvqs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e4hJc5uaHCNZyoKMDroam7FzgEMXepWWYotk+LGIa7Y4JuiEBxGJsqeSpBuaMZ22D
	 /CJWbEuItZIzyCzEMPVzfwm3w7+b5c5+yrP6uhM4rxRaDtgJdI8uiY1B9CSMtsBWGR
	 Xw2qPWYhc7dGUaX7D9ZDlo16LKlhzt8bqGQYITQIPxt3nRqcoC6Qan6M0Vqz+lR9/t
	 tO/qMjdCFVHpR0jqGXE0ZDWE0yqlYtPvRLA/ZfNZ/pj48i55Xu1kGDJqdjuslKcQ6/
	 dIREMQuqDqTModVWxOOWyiu7zdWN5pe1qXUqSxdd08CogaSSMuHgMD2cgS0qOY90zr
	 Gt1Nw/8LzIO6w==
Date: Mon, 17 Aug 2026 11:08:48 +0000
To: sashiko-reviews@lists.linux.dev
From: Aiden Isik <aidenisik@protonmail.com>
Cc: Aiden Isik <aidenisik@member.fsf.org>, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
Message-ID: <Pv3LDXcGtYeb0JiJVOS82nc-ncrhiXght8Q87Z9yrqKw0zLqkMiF05AdaUtvS7BLt6P4CK6XOiaj4IA7uq0bFqkHKtS96mkPeCxMvgtvRNc=@protonmail.com>
In-Reply-To: <20260817103354.BB64F1F000E9@smtp.kernel.org>
References: <20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org> <20260817-for-next-lucky7-watchdog-v1-2-a14370e20b92@member.fsf.org> <20260817103354.BB64F1F000E9@smtp.kernel.org>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: b6cfe360eccfd6718e12a25ae94a2c4a8726c356
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] The `drv_data_exynos5515` variant declares `QUIRK_HAS_PMU_AUTO_D=
ISABLE` but fails to initialize `.disable_reg`, causing unintentional write=
s to PMU offset 0x0000.
> - [High] The `drv_data_exynos5515` variant uses an 'INT_EN' register for =
masking watchdog reset, but omits the `.mask_reset_inv =3D true` flag, inve=
rting the WDT reset mask logic.
> - [Medium] Incorrect use of an Exynos Auto v920 register macro (`EXYNOSAU=
TOV920_CLUSTER0_NONCPU_INT_EN`) in an Exynos 5515 variant.
> --
>=20
> --- Patch [2]: [PATCH 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt comp=
atible data ---
> commit dcaab4881777bc5f5ce1a532adad7c17046164a8
> Author: Aiden Isik <aidenisik@member.fsf.org>
>=20
> watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
>=20
> This commit adds driver data and a compatible string for the Exynos5515
> SoC's watchdog timer.
>=20
> > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_=
wdt.c
> > index e31f93db05096..7299dfdb0c099 100644
> > --- a/drivers/watchdog/s3c2410_wdt.c
> > +++ b/drivers/watchdog/s3c2410_wdt.c
>=20
> [ ... ]
>=20
> > @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_e=
xynos5420 =3D {
> >  =09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
> >  };
> >
> > +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D {
> > +=09.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
>=20
> [Severity: Medium]
> Is this intentionally using an Exynos Auto v920 register macro for an
> Exynos 5515 variant, or could this be a copy-paste error?
>=20

This is intentional.

> [Severity: High]
> Since this variant uses an INT_EN register for masking the reset, should
> the .mask_reset_inv =3D true flag be set here?
>=20
> Without the inversion flag, the bitwise masking logic in
> s3c2410wdt_mask_wdt_reset() evaluates to (mask ^ false). For INT_EN
> registers, this typically writes 1 when intending to mask the reset, and =
0
> when intending to unmask it, effectively inverting the logic.
>=20
> > +=09.mask_bit =3D 2,
> > +=09.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> > +=09.rst_stat_bit =3D 24,
> > +=09.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
> > +=09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE | \
> > +=09=09  QUIRK_HAS_DBGACK_BIT,
> > +};
>=20

Possibly, will wait for maintainer input.

> [Severity: High]
> Will this cause unintentional writes to offset 0x0000 of the PMU regmap?
>=20
> This variant declares QUIRK_HAS_PMU_AUTO_DISABLE but omits .disable_reg.
> Since struct fields default to zero, when s3c2410wdt_enable() checks for
> this quirk and calls s3c2410wdt_disable_wdt_reset() during driver probe:
>=20
> s3c2410wdt_disable_wdt_reset()
>     regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg, mask_val,=
 val);
>=20
> regmap_update_bits() will blindly write to offset 0x0000.
>=20
> [ ... ]
>=20
> --

Again, will wait for maintainer input.

> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-for-next=
-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org?part=3D2
> 
