Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8446A5F2;
	Tue, 18 Aug 2026 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076831; cv=none; b=rSV6FaKNUERDt9HnDDUVznDLfXhtDEpCcfMhZOniXqKc9x1kgsrfpArEgSexS82gTnG+DgpRvdwseCA7UgyE2WnVlALP1Z9fyJpOkTeWk/258iS1zZ0NbkGvOzz1QEpKlK6j8rvHV6gKJO1DYVFqb/kslDy49O7JZdMoiAwRArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076831; c=relaxed/simple;
	bh=M5kwdOzunImGD6gBP4tq4Kh1qqLnAmdjewGVQW66cP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TiAa1VpSBTUS2OhMvUJkHAVdftMdJAgPYCVutYua2+uRo6F4xNRRGqxmgoNmD3RQV64ZW69vIAMqB4pvbbar2yS7YzdBspEHbcONXfR/jozijK9k6cs0apHThwBX911Yp+UgDd+ckWkLKCrDeHC+fEGDG4iHX9Cdyu6k1Z283HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNt3qUGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNt3qUGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894171F000E9;
	Tue, 18 Aug 2026 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787076829;
	bh=NqlsgxRR4DGcwzzSAScmqBxpNylSgGCApwj4t8CQ6UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNt3qUGKWLKOLcckvK2NQfNxTSqETfaIWQL7CPobvwkwQirnkmyH9mlO/yTIjSdYK
	 iUxwfEa3jBMcc9psPz7HCftHydLX1rkXrjnMVx9NFNuPYMyPYEd12Q8gBD22S/51Zm
	 bg/Ah75dMFUrm47L998ia+ZKkh/NC5yULhqBMHVVf1k5cpd4pI+5HXdjyZyFNoX0of
	 Cx7Ub9V/+WcQuaZOqbFQVjIjpZYfYiNPB1uciQ2xuyE4Muge1uSFfnJKlE2fEkjbL1
	 AGVNF3Kcc/ooewZyikPAr7DLoyBXdgPDWU2gBU05NxjdZdf2XX09fqI67f6auuu0zw
	 ByLNO+OyBpopQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aiden Isik" <aidenisik@member.fsf.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260818-for-next-lucky7-watchdog-v3-2-2912bd122c57@member.fsf.org>
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org>
 <20260818-for-next-lucky7-watchdog-v3-2-2912bd122c57@member.fsf.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 18:13:49 +0000
Message-Id: <20260818181349.894171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing PMU counter enable configuration for Exynos5515 watchdog.
--

--- Patch [2]: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt com=
patible data ---
commit 9ce360e3c933b7447ba5da9ba1b7ae3fee989703
Author: Aiden Isik <aidenisik@member.fsf.org>

watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
   =20
This commit adds driver data for the Exynos5515 SoC's watchdog timer.

> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index e31f93db05096..5592f25fe6c83 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_exy=
nos5420 =3D {
>  		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
>  };
> =20
> +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D {
> +	.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
> +	.mask_bit =3D 2,
> +	.mask_reset_inv =3D true,
> +	.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> +	.rst_stat_bit =3D 24,
> +	.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
> +		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
> +};

[Severity: Medium]
Does the Exynos5515 PMU require explicit counter enablement like other rece=
nt
Exynos SoCs?

Other variants in this driver (like Exynos850, AutoV920, and GS101) that use
the NONCPU_INT_EN PMU registers also pair it with a NONCPU_OUT register and
the QUIRK_HAS_PMU_CNT_EN flag to ensure the watchdog counter ticks.

If the Exynos5515 hardware works similarly, omitting cnt_en_reg, cnt_en_bit,
and QUIRK_HAS_PMU_CNT_EN here might leave the counter disabled and the
watchdog silently non-functional. Could you confirm if this variant needs t=
he
counter enable logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-for-next-l=
ucky7-watchdog-v3-0-2912bd122c57@member.fsf.org?part=3D2
