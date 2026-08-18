Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E747ACF6;
	Tue, 18 Aug 2026 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075785; cv=none; b=ZJJHNQZZ6LXOwOdJ7tfW2Z7qZgXWRAxTw/Lw80FfnEmWcs6FIGD+MiDJfQ6zkSqH678E4q4q0sVGKvTkt/df70ZML6Y0PywRzqpF+DUeppCuDC4Bj2FB9jkI8Hol66L5XQC9hVzbjxtyLGrLtJvk63aQVZzktQFhIGrUxuuvGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075785; c=relaxed/simple;
	bh=8NnAKA1Wu+Zox2PtrAdbrfk5WpUjAgKTJ0y+XbdDMv4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxEDYyXjHFM9CnKVta6CmXoUGw31u7y0W45pn7wHpF0tWO1EorIYU+MgmqhgHFTSWG/Ourt+1CN4ZvBr8znwNTaQ3SRZ9FP0hwYKoVXsihUO7RT0liClgVEZffFyawVF24IKarmjsUccvX7rIUsmZbczld65K1Pizz7gDn9SvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=otdaVsg3; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="otdaVsg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1787075781; x=1787334981;
	bh=WfeZJ4/Uu5+5SQa1TKs3/R1EC+79WK7M4LswJI4I/wI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=otdaVsg3mS9rKvIVzSnAE+At2fGKk7qwVe/MCSwkfD0ENnOYFf2lGbCuu5DjQz7+f
	 7FBpyuCNs9IQcRrGfj+6XS7LGCzYi8JmBKiQQGYhWlo3YN3S6J/kEVsK7IwjLOZnLL
	 SaGqBzCrp3bFRu9+hTlECP0c3maNYY8uvGzlVGzz2bxir3Si0KU0PnvuK/tFg1Xbb0
	 Ojf+2gBuNaQxNm2bfMwi0YgEzBvUoL/toS6c/YJ4vSA6SNavTwReuBPsDoOfxkqUDp
	 eMN7ctzVpHif7e2foT9LChi/8Ocj3hSwr5Ker/wj+6pXwL2rFHRsIXgUaESJrHpaj3
	 eCC2Xvqb1pPIA==
Date: Tue, 18 Aug 2026 17:56:16 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: Aiden Isik <aidenisik@protonmail.com>
Cc: sashiko-reviews@lists.linux.dev, Aiden Isik <aidenisik@member.fsf.org>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
Message-ID: <M_lNzXuQ5wi3MVyFU1JstH_dxQWKDdPGje5yyVFO9lvJsz1H4USWNtew1040JtG4p17UrpWTWoohByvy_x7Nc5dvBh0LuONKNmPZPNMImdg=@protonmail.com>
In-Reply-To: <8919c7f3-2dcb-4666-91e0-a91edc378c28@roeck-us.net>
References: <20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org> <20260818-for-next-lucky7-watchdog-v2-2-6743f479a47f@member.fsf.org> <20260818155332.9E0DD1F000E9@smtp.kernel.org> <8919c7f3-2dcb-4666-91e0-a91edc378c28@roeck-us.net>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: 932c582b24195cb701693a284c24bd0b34c4c621
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

> Aiden,
>=20
> On 8/18/26 08:53, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [High] The `drv_data_exynos5515` variant includes `QUIRK_HAS_PMU_AUTO=
_DISABLE` but fails to define `.disable_reg`, resulting in PMU register cor=
ruption at offset 0x0.
> > - [High] The `drv_data_exynos5515` variant uses an INT_EN register for =
masking but fails to set `.mask_reset_inv =3D true`, inverting the watchdog=
 masking logic.
> > --
> >
> Please either address or explain why those are non-issues.
>=20

For the 'disable_reg' issue Sashiko flagged, downstream says this:

> /* PMU registers are changed.
>  * MASK_RESET register was replaced by CLUSTERx_NONCPU_INT_TYPE register.
>  * DISABLE register was removed and its value was always fixed by 0.
>  */

Which is why I omitted disable_reg. It no longer exists.

Looking closer just now, A few months ago when I was implementing this
I mistook pmu_reset_func for auto_disable_func. There is no
auto_disable_func set in the struct corresponding to exynos5515 and so
the QUIRK_HAS_PMU_AUTO_DISABLE flag should be removed. I'm not sure how
I did not catch that. Will fix in v3.

As for the mask inversion issue, similar story. Will also fix in v3.

I've been using this driver for the past few months and it has been
working, I assumed it poked the watchdog every so often but I suppose
with these problems it disables it completely by default. I will keep
that in mind when testing future contributions to this driver.

> Guenter
>=20
> > --- Patch [2]: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt=
 compatible data ---
> > commit fd223d0c16451bec63089d85a77c3b012b8f28ed
> > Author: Aiden Isik <aidenisik@member.fsf.org>
> >
> > watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
> >
> > Add driver data for the Exynos5515 SoC's watchdog timer.
> >
> >> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410=
_wdt.c
> >> index e31f93db05096..7299dfdb0c099 100644
> >> --- a/drivers/watchdog/s3c2410_wdt.c
> >> +++ b/drivers/watchdog/s3c2410_wdt.c
> >> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_=
exynos5420 =3D {
> >>   =09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
> >>   };
> >>
> >> +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D {
> >> +=09.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
> >
> > [Severity: High]
> > This variant uses an INT_EN register for masking but omits .mask_reset_=
inv.
> > Could this cause the watchdog masking logic to be inverted?
> >
> > Looking at s3c2410wdt_mask_wdt_reset(), the logic evaluates to false wh=
en
> > unmasking if .mask_reset_inv is not set to true:
> >
> > s3c2410wdt_mask_wdt_reset() {
> > =09...
> > =09const bool val_inv =3D wdt->drv_data->mask_reset_inv;
> > =09const u32 val =3D (mask ^ val_inv) ? mask_val : 0;
> > =09...
> > =09ret =3D regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_re=
g,
> > =09=09=09=09 mask_val, val);
> >
> > Does this mean it will write a 0 when unmasking, disabling the reset ou=
tput
> > instead of enabling it?
> >
> >> +=09.mask_bit =3D 2,
> >> +=09.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> >> +=09.rst_stat_bit =3D 24,
> >> +=09.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
> >> +=09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE | \
> >
> > [Severity: High]
> > Since QUIRK_HAS_PMU_AUTO_DISABLE is set but .disable_reg is omitted, wi=
ll
> > .disable_reg default to 0x0?
> >
> > During initialization and suspend, s3c2410wdt_disable_wdt_reset() appli=
es
> > updates to wdt->drv_data->disable_reg:
> >
> > s3c2410wdt_disable_wdt_reset() {
> > =09...
> > =09ret =3D regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg,
> > =09=09=09=09 mask_val, val);
> >
> > Could this unintentionally corrupt bit 2 at PMU offset 0x0?
> >
> >> +=09=09  QUIRK_HAS_DBGACK_BIT,
> >> +};
> >> +
> >
> > [ ... ]
> >
>=20
>=20

Kind regards,
- Aiden Isik
