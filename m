Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF71FE44A
	for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2026 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085993; cv=none; b=CpjWLqOrobErs85uruiI0cHIdWgm6G3GSVsP6agG/p5q41vS0Im+yB/ZtAjlZUpaZIyPlYv5ELJQc1BwuoifwzBkMLo8lr0jEBXe5Sl/LnvyAjwumKKddlNcvYIxhQYvvM1iemW+n73IY1YtsWNnJJCwXA0AW7b7kpoprxYvjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085993; c=relaxed/simple;
	bh=K3vlFJD4cT1F0eM8FfQttXwV0OfJJaJt1BMhDK27JQQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqIBnCzIzTMQpW4D3CIGtMvop1beWEJ5yOBOBPS7VMgoTMLELy31fXFuYqCQBHLbRhqI0jXeiwr2ow84B+FA7M9KUqIBGKgKZq6p2aKGrbly6egc8ebMq3zGiX3QF4/PIYCTcU6S8kiyoGIQO3yKpx02WQrNdK47xhuo9Haemzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=BSPHPvMG; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BSPHPvMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1787085983; x=1787345183;
	bh=cRkYxNJn/yxzKk7pSNeZpMeDLO4mT6EyjoLqmG1frtU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BSPHPvMGJZi8yT6XML5B+noc94wgz17dAGDaMRsz4Xx8WkIjEBX4wcdRW5eEtUJot
	 R3So/GzynHE+827ld9WkCYE/q6fowB5kGuzVsAXf15EyZeHCYsDfmnseEEt+NSMGw2
	 xJIOAS6RCqapGbm9kE8FqM0d8kMwhHtWK0jMleDNrrUv6DI2bOxFb2KMABbdMVs5Wi
	 qfO/cFsJ/FKukIFwimCkrQcV38dUWovG5Gi+q4uZ5yEnSXkvMOR4jTIjL6wpTExVJe
	 tA1sU0jDIERMaDRtG4/32PpIqVgXtfma33BtSjfbAi3h6IXQMwuIoMJC0hMpHSjhrp
	 g4nOjyh6FrGHg==
Date: Tue, 18 Aug 2026 20:46:19 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: Aiden Isik <aidenisik@protonmail.com>
Cc: sashiko-reviews@lists.linux.dev, Aiden Isik <aidenisik@member.fsf.org>, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
Message-ID: <cTie_daC2kaIY2BT6HkyAeivwspRhq3thkrkGDMVdIpF2vF5Vr38HQxPcvKFK6pvWatAFk-CO7XL2uz3OCfDSwI-EOxQqI8hNylXjG1jrQI=@protonmail.com>
In-Reply-To: <d8191041-a4bc-4674-ab9e-7fb56ca2b56f@roeck-us.net>
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org> <20260818-for-next-lucky7-watchdog-v3-2-2912bd122c57@member.fsf.org> <20260818181349.894171F000E9@smtp.kernel.org> <k_6CWq_7vPkV72MkyL0wCdcr9ptTffpGOGc6dBLbXjcHBV4DGRzP-35mxO0tdOBaIEhy4BxByYLCh8T5nidgwaMwGcNYD9KCIpxkeF4RRiE=@protonmail.com> <83b5d8e7-9504-41c9-9f24-8fce60641de4@roeck-us.net> <-HoGjao7Mdcx5P3JHoh9WjecLbbXBISKawVeEa59KRfhq7rul5NozHGaISvi0T-ZTp2otj7_b5qqb9tQI5XR0Wvp4UzG7crAekiRTXhiOd4=@protonmail.com> <d8191041-a4bc-4674-ab9e-7fb56ca2b56f@roeck-us.net>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: ef885cefebbd3cf3ff2575b1f5a98544d88d6c7e
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

> On 8/18/26 12:35, Aiden Isik wrote:
> > Hi Guenter,
> >
> >> On 8/18/26 11:33, Aiden Isik wrote:
> >>>> Thank you for your contribution! Sashiko AI review found 1 potential=
 issue(s) to consider:
> >>>> - [Medium] Missing PMU counter enable configuration for Exynos5515 w=
atchdog.
> >>>> --
> >>>>
> >>>> --- Patch [2]: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-=
wdt compatible data ---
> >>>> commit 9ce360e3c933b7447ba5da9ba1b7ae3fee989703
> >>>> Author: Aiden Isik <aidenisik@member.fsf.org>
> >>>>
> >>>> watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
> >>>>
> >>>> This commit adds driver data for the Exynos5515 SoC's watchdog timer=
.
> >>>>
> >>>>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2=
410_wdt.c
> >>>>> index e31f93db05096..5592f25fe6c83 100644
> >>>>> --- a/drivers/watchdog/s3c2410_wdt.c
> >>>>> +++ b/drivers/watchdog/s3c2410_wdt.c
> >>>>> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_da=
ta_exynos5420 =3D {
> >>>>>    =09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
> >>>>>    };
> >>>>>
> >>>>> +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D {
> >>>>> +=09.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
> >>>>> +=09.mask_bit =3D 2,
> >>>>> +=09.mask_reset_inv =3D true,
> >>>>> +=09.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> >>>>> +=09.rst_stat_bit =3D 24,
> >>>>> +=09.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |=
 \
> >>>>> +=09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
> >>>>> +};
> >>>>
> >>>> [Severity: Medium]
> >>>> Does the Exynos5515 PMU require explicit counter enablement like oth=
er recent
> >>>> Exynos SoCs?
> >>>>
> >>>> Other variants in this driver (like Exynos850, AutoV920, and GS101) =
that use
> >>>> the NONCPU_INT_EN PMU registers also pair it with a NONCPU_OUT regis=
ter and
> >>>> the QUIRK_HAS_PMU_CNT_EN flag to ensure the watchdog counter ticks.
> >>>>
> >>>> If the Exynos5515 hardware works similarly, omitting cnt_en_reg, cnt=
_en_bit,
> >>>> and QUIRK_HAS_PMU_CNT_EN here might leave the counter disabled and t=
he
> >>>> watchdog silently non-functional. Could you confirm if this variant =
needs the
> >>>> counter enable logic?
> >>>
> >>> Exynos5515 does not require this.
> >>>
> >>> Downstream on GS101, as an example, has this struct member set:
> >>>
> >>>> pmu_count_en_func
> >>>
> >>> This is not set downstream for Exynos5515, so it is not used for
> >>> Exynos5515.
> >>>
> >>
> >> You keep talking about "downstream". What is that ?
> >
> > By "downstream" I am referring specifically to Samsung's Linux kernel
> > fork for Exynos5515.
> >
> > I host a copy here: https://github.com/Aiden-Isik/linux-android-lucky7
> >
> > Also in this message I refer to Google's GS101 kernel fork, which can
> > be found here:
> > https://github.com/LineageOS/android_kernel_google_gs101
> >
>=20
> Both are completely irrelevant for the upstream kernel. I am most definit=
ely
> not going to look into that code. If there is anything relevant - such as
> the comment you pointed to earlier - you'll need to provide that as indep=
endent
> comment(s), not just refer to some downstream code as explanation. The
> explanation needs to be provided in the _upstream_ kernel code.
>=20

There's not really any explanation for it other than "that is the way it is=
".
Samsung designed the Exynos5515 watchdog timer to not have that quirk,
I read the downstream code and learnt that fact, so we don't enable
that quirk.

> Guenter
>=20
> >>
> >> Guenter
> >>
> >>
> >
> > Kind regards,
> > - Aiden Isik
>=20
>=20

Kind regards,
- Aiden Isik
