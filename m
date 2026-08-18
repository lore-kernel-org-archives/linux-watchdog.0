Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C73624A6;
	Tue, 18 Aug 2026 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078048; cv=none; b=sF+cahbMqkYnToM8Db6nnn84UqKyGjSi5Vgwm/VJjfj5SLlzeHMQf3ytxCOIxduCzSsGRvomW18uY/GbA8bVQs6a8s7f7xppvm8rUT+G6KQYVYsSubIvbVeQj6QJKWo6Aaishyz1yg0OVSuYSbte/BqkUE1fgHgUNB5e909QWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078048; c=relaxed/simple;
	bh=o7mhtP5p5wzfewTf7WCFfovB2mgteOKm57sN8crWO0s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlhuOkOXSOIjp+wGgElqsw2UkriD28CJ5b2UKFSYdV7XGFghiT7ny4R0A0DRVXhQ3fh4Dp1rfP5P56+8BxmwvF10Kxr9lWmt4oimixoq3EbB7lFN8TxM2gZj9w5n3bsmHwdXkmBw1f8/duIsu6cHMsHD80HBMxATUndem7q9ies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=kwM9S0jY; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kwM9S0jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1787078039; x=1787337239;
	bh=w0uzwuGiVMHmCer/41xcj00rnepOJYjo7yKl1UxKBkw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kwM9S0jYAg20xdHw+m6IPdEGIV/JedIb2xz3klPT8cR+evbDA5MKXiRNz/epjehNx
	 YR3xz/BZIIHnNiQFFhjQu5YkLUyZ2VB8TNL2mWxWua2uQPCHw3esEzXnrpD1BZdBOU
	 56JsBXiLbpr6UZ09YFJH+BIjHgrRY6hcizHNcnVooWSLfSDKOBxSbAn40YllxfCZjD
	 YUwY37dMEQeEgEmA4OLISFixpaIS1TokGrzeJNvc/SdL5ZpoJ726GLrGx9OTgkHgYm
	 4D8MWiYPBtJJSeXVNp+I6vp+igTLukxalBbVbXQwosCgwZNVnxKn7FJCYwGoskDOE4
	 z96pX4wlqfgkw==
Date: Tue, 18 Aug 2026 18:33:53 +0000
To: sashiko-reviews@lists.linux.dev
From: Aiden Isik <aidenisik@protonmail.com>
Cc: Aiden Isik <aidenisik@member.fsf.org>, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
Message-ID: <k_6CWq_7vPkV72MkyL0wCdcr9ptTffpGOGc6dBLbXjcHBV4DGRzP-35mxO0tdOBaIEhy4BxByYLCh8T5nidgwaMwGcNYD9KCIpxkeF4RRiE=@protonmail.com>
In-Reply-To: <20260818181349.894171F000E9@smtp.kernel.org>
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org> <20260818-for-next-lucky7-watchdog-v3-2-2912bd122c57@member.fsf.org> <20260818181349.894171F000E9@smtp.kernel.org>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: dcd15b15cf88ef7e20ba209dfab872d1d57669b1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Missing PMU counter enable configuration for Exynos5515 watchd=
og.
> --
>=20
> --- Patch [2]: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt c=
ompatible data ---
> commit 9ce360e3c933b7447ba5da9ba1b7ae3fee989703
> Author: Aiden Isik <aidenisik@member.fsf.org>
>=20
> watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
>=20
> This commit adds driver data for the Exynos5515 SoC's watchdog timer.
>=20
> > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_=
wdt.c
> > index e31f93db05096..5592f25fe6c83 100644
> > --- a/drivers/watchdog/s3c2410_wdt.c
> > +++ b/drivers/watchdog/s3c2410_wdt.c
> > @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_e=
xynos5420 =3D {
> >  =09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
> >  };
> >
> > +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D {
> > +=09.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
> > +=09.mask_bit =3D 2,
> > +=09.mask_reset_inv =3D true,
> > +=09.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> > +=09.rst_stat_bit =3D 24,
> > +=09.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
> > +=09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
> > +};
>=20
> [Severity: Medium]
> Does the Exynos5515 PMU require explicit counter enablement like other re=
cent
> Exynos SoCs?
>=20
> Other variants in this driver (like Exynos850, AutoV920, and GS101) that =
use
> the NONCPU_INT_EN PMU registers also pair it with a NONCPU_OUT register a=
nd
> the QUIRK_HAS_PMU_CNT_EN flag to ensure the watchdog counter ticks.
>=20
> If the Exynos5515 hardware works similarly, omitting cnt_en_reg, cnt_en_b=
it,
> and QUIRK_HAS_PMU_CNT_EN here might leave the counter disabled and the
> watchdog silently non-functional. Could you confirm if this variant needs=
 the
> counter enable logic?

Exynos5515 does not require this.

Downstream on GS101, as an example, has this struct member set:

> pmu_count_en_func

This is not set downstream for Exynos5515, so it is not used for
Exynos5515.

>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-for-next=
-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org?part=3D2
> 
