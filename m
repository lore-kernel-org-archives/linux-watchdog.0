Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A436AB56
	for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081730; cv=none; b=M9TlEqMc7IiTVTdUKU9yfuVVlD1rKp0BI2q6V+hqYJkEProdxE0fZKFfm1AAMkAVFNP8aAJrY/4EcOs2+yKF2CfWjc3SudCmwHnbHa4FAzAIjuyHDLpUfYDiYJ1m19wrukeqGoL9ayTAiCM+nxd/TdEUFzsTuWf0lXe399vuFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081730; c=relaxed/simple;
	bh=3FdzEhyUHu1B8cMyiTOdkek3BgxmcRgL5ADjOWeh7EM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1v71mHRdLyQ9hdrzTYhDIzTb0LaM+VYAsU48yw2r9aY7nkEkLJzVoG4XZxdgr14iiTUPKaBzW+4U5PqCYY4lOHA6EVZFPN99az668DmmwSpJlqS6UaaIIuqFNxZMrrsKrG7lnynInc0S+uT6KxPe7357OYVGPoIASwphBwlMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=vmabt1fJ; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vmabt1fJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1787081720; x=1787340920;
	bh=N0KBiJt1oJTjlPJhhE7GbPh7qNKSVDqvAL0pUofYVEw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vmabt1fJzsW4OQ7wV0BN+p/KeKgDyQg4O7HX/9boc3/cfDzOdTki1jtQVU+5dM8pV
	 kcbnpsC3DiLbcwumnLlpOQIreVKQgnlgFFZGMhcQUwCXBYSCGKt2XFOzsIGxOsgw8i
	 CLfqI7jK1f8o7hs+uygC6kJVjBnCgCnvutdXWuh480UTsX1u9LFJXfcVCEaZEk1r9v
	 RDQ1dxSUQBON2Znzz6Eq9AfUZ0v8o9nYvGcOgepeCVjdTBia1+A6myXJnd7PglizCT
	 XWggNeQCYpVKD6CNmL3Q63guoIkQOGtEU8SDp+f1TqeSY0o3V/aAy5xzNRHvy2u0FH
	 ItuenKBPGps3A==
Date: Tue, 18 Aug 2026 19:35:17 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: Aiden Isik <aidenisik@protonmail.com>
Cc: sashiko-reviews@lists.linux.dev, Aiden Isik <aidenisik@member.fsf.org>, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
Message-ID: <-HoGjao7Mdcx5P3JHoh9WjecLbbXBISKawVeEa59KRfhq7rul5NozHGaISvi0T-ZTp2otj7_b5qqb9tQI5XR0Wvp4UzG7crAekiRTXhiOd4=@protonmail.com>
In-Reply-To: <83b5d8e7-9504-41c9-9f24-8fce60641de4@roeck-us.net>
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org> <20260818-for-next-lucky7-watchdog-v3-2-2912bd122c57@member.fsf.org> <20260818181349.894171F000E9@smtp.kernel.org> <k_6CWq_7vPkV72MkyL0wCdcr9ptTffpGOGc6dBLbXjcHBV4DGRzP-35mxO0tdOBaIEhy4BxByYLCh8T5nidgwaMwGcNYD9KCIpxkeF4RRiE=@protonmail.com> <83b5d8e7-9504-41c9-9f24-8fce60641de4@roeck-us.net>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: d32b3bed6d0dffed448fbbee8297932da2e67159
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

> On 8/18/26 11:33, Aiden Isik wrote:
> >> Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:
> >> - [Medium] Missing PMU counter enable configuration for Exynos5515 wat=
chdog.
> >> --
> >>
> >> --- Patch [2]: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wd=
t compatible data ---
> >> commit 9ce360e3c933b7447ba5da9ba1b7ae3fee989703
> >> Author: Aiden Isik <aidenisik@member.fsf.org>
> >>
> >> watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
> >>
> >> This commit adds driver data for the Exynos5515 SoC's watchdog timer.
> >>
> >>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c241=
0_wdt.c
> >>> index e31f93db05096..5592f25fe6c83 100644
> >>> --- a/drivers/watchdog/s3c2410_wdt.c
> >>> +++ b/drivers/watchdog/s3c2410_wdt.c
> >>> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data=
_exynos5420 =3D {
> >>>   =09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
> >>>   };
> >>>
> >>> +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D {
> >>> +=09.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
> >>> +=09.mask_bit =3D 2,
> >>> +=09.mask_reset_inv =3D true,
> >>> +=09.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> >>> +=09.rst_stat_bit =3D 24,
> >>> +=09.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
> >>> +=09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
> >>> +};
> >>
> >> [Severity: Medium]
> >> Does the Exynos5515 PMU require explicit counter enablement like other=
 recent
> >> Exynos SoCs?
> >>
> >> Other variants in this driver (like Exynos850, AutoV920, and GS101) th=
at use
> >> the NONCPU_INT_EN PMU registers also pair it with a NONCPU_OUT registe=
r and
> >> the QUIRK_HAS_PMU_CNT_EN flag to ensure the watchdog counter ticks.
> >>
> >> If the Exynos5515 hardware works similarly, omitting cnt_en_reg, cnt_e=
n_bit,
> >> and QUIRK_HAS_PMU_CNT_EN here might leave the counter disabled and the
> >> watchdog silently non-functional. Could you confirm if this variant ne=
eds the
> >> counter enable logic?
> >
> > Exynos5515 does not require this.
> >
> > Downstream on GS101, as an example, has this struct member set:
> >
> >> pmu_count_en_func
> >
> > This is not set downstream for Exynos5515, so it is not used for
> > Exynos5515.
> >
>=20
> You keep talking about "downstream". What is that ?

By "downstream" I am referring specifically to Samsung's Linux kernel
fork for Exynos5515.

I host a copy here: https://github.com/Aiden-Isik/linux-android-lucky7

Also in this message I refer to Google's GS101 kernel fork, which can
be found here:
https://github.com/LineageOS/android_kernel_google_gs101

>=20
> Guenter
>=20
>=20

Kind regards,
- Aiden Isik
