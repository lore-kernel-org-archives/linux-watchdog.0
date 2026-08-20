Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FD4119E8
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221141; cv=none; b=nh1TTwzL7+ZuZsa52xTb0blADvHNfizWM83c3XOeyXNKGHYJuRVQMFHULYEVee23oejQuqEDwW90PhvAIWqy/EP+nka4Yf/0k5I3HaOJlopU47b+qpqu7TDaUS4cln2OZBapzxO48mNXft5u6yBum7Fl5J6gnnXOw6JX7SNebZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221141; c=relaxed/simple;
	bh=ypQhHbVTHOprgtbVHtmQ/UYSIvXiLh8ey5IzfWVbv0o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cH1T8cDVE6SKxSap8LJn2SNOnzIMQabzy92H5hvE+DhW58fNd2upJ0VQE8e+yP0bnIby5syReqOD0cT7VaYWNg12Z8/hPLSjhjmVdeaCez0rpmpBGi2ZxUHoMDoECo3N2P75tQPZVb3NFiKhtcWJmmtnskXkcj9X0I2CMekYx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=pFqSPGbG; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="pFqSPGbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1787221123; x=1787480323;
	bh=cAD1H0LhOVgoTCfynNngF4iXHGyiB44K2m2f/TNoWS8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pFqSPGbGJFOTOwBKPhSIoettKizJfA7lIAxfJnMTWwE/b/RXYcXr3AZAULTIM+13V
	 tX2+YGCPT1D8usO4bmfMH9jTARPxWrmC2pIUSioDdinnDl6akIc0GafM+pNW5Sijsr
	 q2hTTjVxlBIFxWuo4M9djsGGvP8PpYvkc1/Q4FHSK7MQz7g4/oS7G3IAiCHgSFTGjD
	 td3U5aPKnwH88wAXXEVWVxzZjQt1GjS4l8wQTY6+Och1BfK4CyEhSXmDJYy7hmCUkZ
	 74ftQSzmum4FqdICl7K/1xYDaYPJ8GjQvv7ABOkGxRSfGYxodXuqFw9TMokqw5E9Ko
	 iOlpFo4cRSkww==
Date: Thu, 20 Aug 2026 10:18:38 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: Aiden Isik <aidenisik@protonmail.com>
Cc: sashiko-reviews@lists.linux.dev, Aiden Isik <aidenisik@member.fsf.org>, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
Message-ID: <s4LZj1kKLrHHKsrkc1s32s4sh7oKzXqEG4hA_W99bG1YTsgnCj-shElNsnI04D-eVsK4Y0tx7ViBSkjy8LZjZmZ8N4D5UEg0bcU16gOXHP0=@protonmail.com>
In-Reply-To: <01a0682b-b7ec-45f0-a19d-df40ed6366a2@roeck-us.net>
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org> <20260818-for-next-lucky7-watchdog-v3-2-2912bd122c57@member.fsf.org> <20260818181349.894171F000E9@smtp.kernel.org> <k_6CWq_7vPkV72MkyL0wCdcr9ptTffpGOGc6dBLbXjcHBV4DGRzP-35mxO0tdOBaIEhy4BxByYLCh8T5nidgwaMwGcNYD9KCIpxkeF4RRiE=@protonmail.com> <83b5d8e7-9504-41c9-9f24-8fce60641de4@roeck-us.net> <-HoGjao7Mdcx5P3JHoh9WjecLbbXBISKawVeEa59KRfhq7rul5NozHGaISvi0T-ZTp2otj7_b5qqb9tQI5XR0Wvp4UzG7crAekiRTXhiOd4=@protonmail.com> <d8191041-a4bc-4674-ab9e-7fb56ca2b56f@roeck-us.net> <cTie_daC2kaIY2BT6HkyAeivwspRhq3thkrkGDMVdIpF2vF5Vr38HQxPcvKFK6pvWatAFk-CO7XL2uz3OCfDSwI-EOxQqI8hNylXjG1jrQI=@protonmail.com> <XNt95pVriUNFbMMYsr5mnQo9LUABboJjUMboxV5mWYj9FQJb6XGjsGkGRre7eSK4bvCG4oOuTg4YNiujCpX7ZlonVgQSHFBEzpFvZLFTXtw=@protonmail.com> <01a0682b-b7ec-45f0-a19d-df40ed6366a2@roeck-us.net>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: 75dd1fe3b66900fa69089a83f0163e7b000f8594
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On 8/19/26 16:36, Aiden Isik wrote:
> > Hi again Guenter,
> >
> >> Hi Guenter,
> >>
> >>> On 8/18/26 12:35, Aiden Isik wrote:
> >>>> Hi Guenter,
> >>>>
> >>>>> On 8/18/26 11:33, Aiden Isik wrote:
> >>>>>>> Thank you for your contribution! Sashiko AI review found 1 potent=
ial issue(s) to consider:
> >>>>>>> - [Medium] Missing PMU counter enable configuration for Exynos551=
5 watchdog.
> >>>>>>> --
> >>>>>>>
> >>>>>>> --- Patch [2]: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos55=
15-wdt compatible data ---
> >>>>>>> commit 9ce360e3c933b7447ba5da9ba1b7ae3fee989703
> >>>>>>> Author: Aiden Isik <aidenisik@member.fsf.org>
> >>>>>>>
> >>>>>>> watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
> >>>>>>>
> >>>>>>> This commit adds driver data for the Exynos5515 SoC's watchdog ti=
mer.
> >>>>>>>
> >>>>>>>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s=
3c2410_wdt.c
> >>>>>>>> index e31f93db05096..5592f25fe6c83 100644
> >>>>>>>> --- a/drivers/watchdog/s3c2410_wdt.c
> >>>>>>>> +++ b/drivers/watchdog/s3c2410_wdt.c
> >>>>>>>> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv=
_data_exynos5420 =3D {
> >>>>>>>>     =09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
> >>>>>>>>     };
> >>>>>>>>
> >>>>>>>> +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D=
 {
> >>>>>>>> +=09.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
> >>>>>>>> +=09.mask_bit =3D 2,
> >>>>>>>> +=09.mask_reset_inv =3D true,
> >>>>>>>> +=09.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> >>>>>>>> +=09.rst_stat_bit =3D 24,
> >>>>>>>> +=09.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESE=
T | \
> >>>>>>>> +=09=09  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
> >>>>>>>> +};
> >>>>>>>
> >>>>>>> [Severity: Medium]
> >>>>>>> Does the Exynos5515 PMU require explicit counter enablement like =
other recent
> >>>>>>> Exynos SoCs?
> >>>>>>>
> >>>>>>> Other variants in this driver (like Exynos850, AutoV920, and GS10=
1) that use
> >>>>>>> the NONCPU_INT_EN PMU registers also pair it with a NONCPU_OUT re=
gister and
> >>>>>>> the QUIRK_HAS_PMU_CNT_EN flag to ensure the watchdog counter tick=
s.
> >>>>>>>
> >>>>>>> If the Exynos5515 hardware works similarly, omitting cnt_en_reg, =
cnt_en_bit,
> >>>>>>> and QUIRK_HAS_PMU_CNT_EN here might leave the counter disabled an=
d the
> >>>>>>> watchdog silently non-functional. Could you confirm if this varia=
nt needs the
> >>>>>>> counter enable logic?
> >>>>>>
> >>>>>> Exynos5515 does not require this.
> >>>>>>
> >>>>>> Downstream on GS101, as an example, has this struct member set:
> >>>>>>
> >>>>>>> pmu_count_en_func
> >>>>>>
> >>>>>> This is not set downstream for Exynos5515, so it is not used for
> >>>>>> Exynos5515.
> >>>>>>
> >>>>>
> >>>>> You keep talking about "downstream". What is that ?
> >>>>
> >>>> By "downstream" I am referring specifically to Samsung's Linux kerne=
l
> >>>> fork for Exynos5515.
> >>>>
> >>>> I host a copy here: https://github.com/Aiden-Isik/linux-android-luck=
y7
> >>>>
> >>>> Also in this message I refer to Google's GS101 kernel fork, which ca=
n
> >>>> be found here:
> >>>> https://github.com/LineageOS/android_kernel_google_gs101
> >>>>
> >>>
> >>> Both are completely irrelevant for the upstream kernel. I am most def=
initely
> >>> not going to look into that code. If there is anything relevant - suc=
h as
> >>> the comment you pointed to earlier - you'll need to provide that as i=
ndependent
> >>> comment(s), not just refer to some downstream code as explanation. Th=
e
> >>> explanation needs to be provided in the _upstream_ kernel code.
> >>>
> >>
> >> There's not really any explanation for it other than "that is the way =
it is".
> >> Samsung designed the Exynos5515 watchdog timer to not have that quirk,
> >> I read the downstream code and learnt that fact, so we don't enable
> >> that quirk.
> >>
> >
> > Just in case I am misunderstanding what you are asking for and you want
> > examples of how I know this is correct to be posted on the mailing list=
,
> > here you go.
> >
> > Unfortunately Samsung doesn't publish technical specifications for thei=
r
> > modern SoCs, so the best documentation we have is their own source code=
,
> > which doesn't really explain the *why*, but it does explain the *what*
> > and the *how*.
> >
> > I'll do my best to explain it concisely and how we drive the hardware
> > in the same way upstream:
> >
> > Google (and/or Samsung since GS101 is Exynos-based) define the struct
> > for the watchdog timer like this:
> >
> >> static const struct s3c2410_wdt_variant drv_data_gs101_cl0 =3D {
> >> =09.noncpu_int_en =3D EXYNOS_CLUSTER0_NONCPU_INT_EN,
> >> =09.noncpu_out =3D EXYNOS_CLUSTER0_NONCPU_OUT,
> >> =09.mask_bit =3D 2,
> >> =09.cnt_en_bit =3D 8,
> >> =09.rst_stat_reg =3D EXYNOS_RST_STAT_REG_OFFSET,
> >> =09.rst_stat_bit =3D 0,      /* CLUSTER0 WDTRESET */
> >> =09.pmu_reset_func =3D s3c2410wdt_noncpu_int_en,
> >> =09.pmu_count_en_func =3D s3c2410wdt_noncpu_out,
> >> =09.quirks =3D QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT | QUIRK_HAS_W=
TCLRINT_REG |
> >> =09=09  QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_WTMINCNT_REG,
> >> };
> >
> > Note 'pmu_count_en_func' is set.
> >
> > Later on in the file, we have this code:
> >
> >> if (wdt->drv_data->pmu_count_en_func) {
> >> =09ret =3D wdt->drv_data->pmu_count_en_func(wdt, true);
> >> =09if (ret < 0) {
> >> =09=09dev_info(wdt->dev, "wdt count enable fail\n");
> >> =09=09return ret;
> >> =09}
> >> }
> >
> > Which will call the chosen counter enable function if that field is set=
,
> > which will, well, enable the counter.
> >
> > Now, for the struct corresponding to Exynos5515 in the same driver:
> >
> >> static const struct s3c2410_wdt_variant drv_data_exynos9_v4 =3D {
> >> =09.noncpu_int_en =3D EXYNOS_CLUSTER2_NONCPU_INT_EN,
> >> =09.mask_bit =3D 2,
> >> =09.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> >> =09.rst_stat_bit =3D 23,=09/* CLUSTER2 WDTRESET */
> >> =09.pmu_reset_func =3D s3c2410wdt_noncpu_int_en,
> >> =09.quirks =3D QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT | QUIRK_HAS_W=
TCLRINT_REG |
> >> =09=09  QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_WTMINCNT_REG,
> > };
> >
> > We can see that 'pmu_count_en_func' is not set, meaning that code withi=
n
> > the if statement shown earlier is not called, and the counter is not ma=
nually
> > enabled.
> >
> > Translating this to upstream, if QUIRK_HAS_PMU_CNT_EN is set as a flag,
> > the following code within the if statement will execute:
> >
> >> if (wdt->drv_data->quirks & QUIRK_HAS_PMU_CNT_EN) {
> >> =09ret =3D s3c2410wdt_enable_counter(wdt, en);
> >> =09=09if (ret < 0)
> >> =09=09=09return ret;
> >> =09}
> >
> > Which as we can see does the same thing and enables the counter.
> >
> > So, since 'pmu_count_en_func' is enabled on GS101 in the downstream ven=
dor
> > code, the QUIRK_HAS_PMU_CNT_EN flag is set, as the Sashiko AI points ou=
t.
> > However, since it is *not* set for Exynos5515, that means Exynos5515 do=
es
> > not require manual counter enablement and that flag should not be set,
> > which is why the AI's concern is wrong.
> >
> > I also tested this (with the watchdog actually enabled this time), and =
it
> > behaves as expected.
> >
>=20
> All ok, but you do not explain all this as comment in your patches, you j=
ust
> point to downstream code. At least some of that downstream code, if I rec=
all
> your previous feedback correctly, actually _did_ explain at least some of
> this.

For this specific quirk there are no comments whatsoever. That comment I
sent is one of the only comments in that file.

>=20
> Example: A comment along the line of "According to <place source here>,
> Exynos5515 PMU does not require explicit counter enablement" would do.
> Sashiko does not know the context. I don't either, and neither does
> anyone else.
>=20
> So why exactly are you not willing to add such comments ? Please explain.

Initially I did not add a comment before I sent the modifications to
the mailing list because nothing else seems to have comments justifying
the flags set or not set.

After you requested an explanation in the code, I thought you wanted
a full explanation like what I sent above, which would be very unwieldy.
Which is why I then also sent you that explanation here, because I wasn't
sure what exactly you were asking for.

But if it's just a comment like the example you described, I can do that.
Do you want the source to be "Samsung's downstream code", or a link to
it?

>=20
> Guenter
>=20
>=20

Kind regards,
- Aiden Isik
